Content-Type: multipart/mixed; boundary="===============3539602299344780250=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH_v2 1/4] gatppp: Add new contructor to use external fd
Date: Thu, 28 Apr 2011 09:44:19 -0500
Message-ID: <4DB97D43.4050404@gmail.com>
In-Reply-To: <4DB96659.8060102@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3539602299344780250==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

>>> -    if (ppp_net_set_mtu(ppp->net, ppp->mtu) =3D=3D FALSE)
>>> -        DBG(ppp, "Unable to set MTU");
>>> +    /*
>>> +     * If we have opened the tun interface locally,
>>> +     * we have to set a MTU value.
>>> +     */
>> So I don't agree with this.  The MTU is negotiated during LCP phase, so
>> unless I'm missing something, this value should still be set to the
>> negotiated one.
>>
> =

> Right , I thought that as I was setting a MTU value for ConnMan tun
> interface I didn't need to set the MTU value into oFono.
> Obviously I was wrong :)
> =


I assume the MTU is set to the default 1500 in Connman?

>>> +        net->if_name =3D strdup("Server ppp");
>> This looks wrong.  You do actually want to return a proper network
>> interface here, not make something up.
> =

> In fact, only ConnMan needs to know each name of its interfaces,
> so do we need to fill this field in when ConnMan creates the interface?
> =


Remember that we're writing a library, so things must be consistent.
Besides, isn't this is a matter of running a TUNGETIFF ioctl?

>>> +        /* create a channel for reading and writing to this
>>> interface */
>>> +        channel =3D g_io_channel_unix_new(fd);
>>> +    }
>> There's a small problem of symmetry here.  If IPCP is established
>> correctly, then the fd will eventually be closed by ppp_net.  However,
>> if we never properly establish IPCP, then fd will not be closed.  What
>> is actually expected by ConnMan?
>>
> =

> In the case we don't properly establish the IPCP, ppp_disconnect CB of
> emulator will be called.
> Then, we will call the release_private_network DBus method. This method
> will close the fd if it is opened.
> =


Again, we're writing a library.  We cannot assume some behavior external
to the library is going to save us.  So I really suggest we make closing
of the fd symmetric.

Regards,
-Denis

--===============3539602299344780250==--

