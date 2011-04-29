Content-Type: multipart/mixed; boundary="===============5723765607414635751=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: Re: [PATCH_v2 1/4] gatppp: Add new contructor to use external fd
Date: Fri, 29 Apr 2011 15:39:04 +0200
Message-ID: <4DBABF78.30106@linux.intel.com>
In-Reply-To: <4DBAB95A.9050104@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5723765607414635751==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi again Denis,

On 29/04/2011 15:12, Guillaume Zajac wrote:
> Hi Denis,
>
> On 28/04/2011 21:41, Denis Kenzior wrote:
>> Hi Guillaume,
>>
>>>>>>> +        /* create a channel for reading and writing to this
>>>>>>> interface */
>>>>>>> +        channel =3D g_io_channel_unix_new(fd);
>>>>>>> +    }
>>>>>> There's a small problem of symmetry here.  If IPCP is established
>>>>>> correctly, then the fd will eventually be closed by ppp_net.  =

>>>>>> However,
>>>>>> if we never properly establish IPCP, then fd will not be closed.  =

>>>>>> What
>>>>>> is actually expected by ConnMan?
>>>>>>
>>>>> In the case we don't properly establish the IPCP, ppp_disconnect =

>>>>> CB of
>>>>> emulator will be called.
>>>>> Then, we will call the release_private_network DBus method. This =

>>>>> method
>>>>> will close the fd if it is opened.
>>>>>
>>>> Again, we're writing a library.  We cannot assume some behavior =

>>>> external
>>>> to the library is going to save us.  So I really suggest we make =

>>>> closing
>>>> of the fd symmetric.
>>> So I will close the fd into g_at_ppp_unref() if it is>=3D0.
>>> I have also to close it if we fail to create the PPP server.
>>>
>> Right.  Your approach doesn't sound completely correct, but I will let
>> you figure this out.  Just make sure to close the fd in all =

>> circumstances.
>
> In looking the previous implementation in ppp_net_new(),
> there is just:
>
> fd =3D open("/dev/net/tun", ...);
> ...
> net->channel =3D g_io_channel_unix_new(fd);
>
> However, the fd is never closed when we do ppp_net_free()
> We just unref the net->channel
>
> So should we do in ppp_net_free() a:
> fd =3D g_io_channel_unix_get_fd(net->channel);
> close(fd);
> g_io_channel_unref(net->channel);
>
> Or maybe I miss something?

In fact I missed something :) , the g_io_channel_unref() is closing fd

>
> In the new implementation, in the case we don't establish the IPCP, we =

> still have the fd of ConnMan opened.
> ppp->net =3D=3D NULL so in the g_at_ppp_unref() we can do:
>
> if (ppp->net)
>         ppp_net_free(ppp->net); /* We close the fd  like above */

We close it during unref.

> else {
>         if( fd >=3D 0)
>                 close(ppp->fd); /* We don't have established IPCP, we =

> need to close the fd from ConnMan */
>         }
>

We might need also to do:

ppp->fd =3D -1;

into ppp_ipcp_down_notify() just after ppp_net_free()


Kind regards,
Guillaume

--===============5723765607414635751==--

