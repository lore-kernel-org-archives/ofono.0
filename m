Content-Type: multipart/mixed; boundary="===============3930472081192621648=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH_v2 1/4] gatppp: Add new contructor to use external fd
Date: Fri, 29 Apr 2011 03:52:49 -0500
Message-ID: <4DBA7C61.6020203@gmail.com>
In-Reply-To: <4DBAB95A.9050104@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3930472081192621648==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

On 04/29/2011 08:12 AM, Guillaume Zajac wrote:
> Hi Denis,
> =

> On 28/04/2011 21:41, Denis Kenzior wrote:
>> Hi Guillaume,
>>
>>>>>>> +        /* create a channel for reading and writing to this
>>>>>>> interface */
>>>>>>> +        channel =3D g_io_channel_unix_new(fd);
>>>>>>> +    }
>>>>>> There's a small problem of symmetry here.  If IPCP is established
>>>>>> correctly, then the fd will eventually be closed by ppp_net. =

>>>>>> However,
>>>>>> if we never properly establish IPCP, then fd will not be closed. =

>>>>>> What
>>>>>> is actually expected by ConnMan?
>>>>>>
>>>>> In the case we don't properly establish the IPCP, ppp_disconnect CB of
>>>>> emulator will be called.
>>>>> Then, we will call the release_private_network DBus method. This
>>>>> method
>>>>> will close the fd if it is opened.
>>>>>
>>>> Again, we're writing a library.  We cannot assume some behavior
>>>> external
>>>> to the library is going to save us.  So I really suggest we make
>>>> closing
>>>> of the fd symmetric.
>>> So I will close the fd into g_at_ppp_unref() if it is>=3D0.
>>> I have also to close it if we fail to create the PPP server.
>>>
>> Right.  Your approach doesn't sound completely correct, but I will let
>> you figure this out.  Just make sure to close the fd in all
>> circumstances.
> =

> In looking the previous implementation in ppp_net_new(),
> there is just:
> =

> fd =3D open("/dev/net/tun", ...);
> ...
> net->channel =3D g_io_channel_unix_new(fd);
> =

> However, the fd is never closed when we do ppp_net_free()
> We just unref the net->channel
> =

> So should we do in ppp_net_free() a:
> fd =3D g_io_channel_unix_get_fd(net->channel);
> close(fd);
> g_io_channel_unref(net->channel);
> =

> Or maybe I miss something?
> =


You are, namely the call to:

        if (!g_at_util_setup_io(channel, 0))
                goto error;

which sets the close on unref flag on the GIOChannel.

Regards,
-Denis

--===============3930472081192621648==--

