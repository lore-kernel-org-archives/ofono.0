Content-Type: multipart/mixed; boundary="===============1287706192619679302=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 03/10] ublox: query USBCONF for applicable devices
Date: Wed, 13 Mar 2019 16:34:23 -0500
Message-ID: <1d076805-ca86-f4ff-55ed-16a1cce27390@gmail.com>
In-Reply-To: <0ffaa16f-7be2-9c77-7542-f87c3223443e@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1287706192619679302==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,


>> +static const char * const uusbconf_prefix[] =3D { "+UUSBCONF:", NULL };
>> +static const char * const none_prefix[] =3D { NULL };
> =

> Of course, I got conned by checkpatch into making this change... it's =

> certainly correct but making the pointer const doesn't play well with =

> the rest of ofono so it's not sane to actually change this now.

Yes, at some point we should use this pattern and change these =

wholesale.  Maybe someone strong in coccinelle-fu can do this for us?

Regards,
-Denis

--===============1287706192619679302==--

