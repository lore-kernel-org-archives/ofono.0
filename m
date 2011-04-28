Content-Type: multipart/mixed; boundary="===============8122206189297092266=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH_v2 1/4] gatppp: Add new contructor to use external fd
Date: Thu, 28 Apr 2011 14:41:23 -0500
Message-ID: <4DB9C2E3.9060301@gmail.com>
In-Reply-To: <4DB9851D.5080803@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8122206189297092266==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

>>>>> +        /* create a channel for reading and writing to this
>>>>> interface */
>>>>> +        channel =3D g_io_channel_unix_new(fd);
>>>>> +    }
>>>> There's a small problem of symmetry here.  If IPCP is established
>>>> correctly, then the fd will eventually be closed by ppp_net.  However,
>>>> if we never properly establish IPCP, then fd will not be closed.  What
>>>> is actually expected by ConnMan?
>>>>
>>> In the case we don't properly establish the IPCP, ppp_disconnect CB of
>>> emulator will be called.
>>> Then, we will call the release_private_network DBus method. This method
>>> will close the fd if it is opened.
>>>
>> Again, we're writing a library.  We cannot assume some behavior external
>> to the library is going to save us.  So I really suggest we make closing
>> of the fd symmetric.
> So I will close the fd into g_at_ppp_unref() if it is >=3D0.
> I have also to close it if we fail to create the PPP server.
> =


Right.  Your approach doesn't sound completely correct, but I will let
you figure this out.  Just make sure to close the fd in all circumstances.

Regards,
-Denis

--===============8122206189297092266==--

