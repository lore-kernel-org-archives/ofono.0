Content-Type: multipart/mixed; boundary="===============3040390732289839328=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] voicecall: fix transfer
Date: Mon, 07 Feb 2011 15:30:32 -0600
Message-ID: <4D506478.1030907@gmail.com>
In-Reply-To: <AANLkTi=KSZWwgfqcVXGkirWVzAxt=cKA50affLix+-ZF@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3040390732289839328==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andre,

> Are we reading the same code?
> =

> for this case we have:
> numactive !=3D 1  =3D=3D> true
> numheld !=3D 1  =3D=3D> false
> =

> (numactive !=3D 1) && (numheld !=3D 1)  =3D=3D>  false
> =


Then shouldn't the patch simply be modified to if (numactive !=3D 1 ||
numheld !=3D 1)?

Regards,
-Denis

--===============3040390732289839328==--

