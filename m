Content-Type: multipart/mixed; boundary="===============7153262999871373225=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 0/4] Add support for CPHS customer service profile
Date: Wed, 26 Jan 2011 11:28:46 +0100
Message-ID: <1296037726.1520.110.camel@aeonflux>
In-Reply-To: <AANLkTinYA0a=N3mcyT3dkzF8Uu2c2J-NiZh6nk6Js70U@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7153262999871373225==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

> > one open question here is still if we also have to disallow scanning
> > when this is set?
> >
> > So we might wanna update the Scan() and Register() method with the
> > proper error codes and put a note in there for mode =3D "auto-only".
> =

> Good point, it's also missing from the Scan() implementation. I meant
> to add it for but forgot. I'll send a v2 shortly.
> =

> The other open item was whether to create a new error code for this or
> reuse the existing access denied error (my preference).

good question. I can see the benefit of having a proper error code, but
I have no preference here right now.

Regards

Marcel



--===============7153262999871373225==--

