Content-Type: multipart/mixed; boundary="===============5891392397793015587=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [PATCH 0/4] Add support for CPHS customer service profile
Date: Wed, 26 Jan 2011 12:17:01 +0200
Message-ID: <AANLkTinYA0a=N3mcyT3dkzF8Uu2c2J-NiZh6nk6Js70U@mail.gmail.com>
In-Reply-To: <1296035456.1520.96.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5891392397793015587==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

2011/1/26 Marcel Holtmann <marcel@holtmann.org>:
> one open question here is still if we also have to disallow scanning
> when this is set?
>
> So we might wanna update the Scan() and Register() method with the
> proper error codes and put a note in there for mode =3D "auto-only".

Good point, it's also missing from the Scan() implementation. I meant
to add it for but forgot. I'll send a v2 shortly.

The other open item was whether to create a new error code for this or
reuse the existing access denied error (my preference).

Cheers,
Aki

--===============5891392397793015587==--

