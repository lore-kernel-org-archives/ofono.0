Content-Type: multipart/mixed; boundary="===============4790814550491345199=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [PATCH 04/18] gisi: fix subscription for wgmodem2.5
Date: Wed, 16 Feb 2011 13:16:22 +0200
Message-ID: <AANLkTi=aS+22cSBibi=i=2K4bcYzLbKtiJ9gtpACL-KS@mail.gmail.com>
In-Reply-To: <ffc8a75a856d2d2af65696f1878fb2b5ad7c5045.1297772944.git.andreas.westin@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4790814550491345199==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andreas,

2011/2/15 Andreas Westin <andreas.westin@stericsson.com>:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (legacy)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0msg[3 + count] =3D mux->resource;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0/* Resource field is 32bit and Little-endian */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0msg[4 + count * 4 + 3] =3D mux->resource;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }

Curly brackets are either in both if and else, or in neither. I
actually prefer not to have them here, since the first line is just a
comment in the else statement. ;)

> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0count++;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> + =C2=A0 =C2=A0 =C2=A0 commgr.spn_dev =3D legacy ? modem->device : PN_DEV=
_MODEM;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0len =3D legacy ? 3 + count : 4 + count * 4;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0msg[2] =3D count;

This is not necessary, as a modem plugin is supposed to call
g_isi_modem_set_device() to set the modem->device to whatever it needs
to right after creating the GIsiModem instance.

In other words, the assumption is that when the GIsiModem instace is
actually used, all necessary internal data, such as flags and the
remote device have already been set.

Cheers,
Aki

--===============4790814550491345199==--

