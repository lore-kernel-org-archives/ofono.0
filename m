Content-Type: multipart/mixed; boundary="===============0317227904701209349=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 6/6] drivers: support for auth NONE
Date: Thu, 04 Oct 2018 22:37:19 -0500
Message-ID: <b91ce547-a36b-91fa-6dfe-1326cca020ca@gmail.com>
In-Reply-To: <CAKSBH7FuMX2xdZ0oNgKDzOz8WZQEp7g-9DBy8Utb-oFzWPVbBA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0317227904701209349==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

> this is in a function that assigns the variable for sure:
> =

> static uint32_t auth_method_to_auth_protocol(enum ofono_gprs_auth_method =
method)
> {
> switch (method) {
> case OFONO_GPRS_AUTH_METHOD_CHAP:
> return 2; /* MBIMAuthProtocolChap */
> case OFONO_GPRS_AUTH_METHOD_PAP:
> return 1; /* MBIMAuthProtocolPap */
> }
> =

> return 0;  // < see here?
> }
> =

> that's why the compiler doesnt complain.
> =


Sure, but you also know the core will never send you a value that is not =

PAP/CHAP.  So you know that in reality we never get to the 'return 0' =

part, even though the compiler might think that we could.

And if we ever add a new enumeration and forget to update this code, the =

compiler will complain.  This is what we want.  If we add a default: =

here, compiler will not warn us, that leads to bugs.

>> uint32_t auth;
>>
>> if (auth_method_to_foo(method, &auth) < 0)
>>          goto error;
>>
> =

> this doesnt work, because it could leave the variable auth unassigned,
> according to the compiler.

Not according to any compiler I tried.  I literally tested this before =

sending the above email on both GCC 7.3 and GCC 8.2.  So what compiler =

are you using?

> =

> Please note that the current code for qmimodem has a default already,
> and it is the only way the compiler doesn't complain:

And that is wrong and should be fixed.

Regards,
-Denis

--===============0317227904701209349==--

