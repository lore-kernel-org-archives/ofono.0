Content-Type: multipart/mixed; boundary="===============1466765480458965908=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: Access to SIM card when Modem is not "Powered"
Date: Tue, 30 Mar 2010 21:27:37 +0300
Message-ID: <a32762a21003301127q295e8418id66aef0c89edcb39@mail.gmail.com>
In-Reply-To: <201003301305.49366.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1466765480458965908==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

2010/3/30 Denis Kenzior <denkenz@gmail.com>:
> We need to look closely at whether enabling flight mode (e.g. SIM on, whi=
le
> TX/RX is off) makes sense. =C2=A0It is something we should consider, but =
challenging
> since most of the SIM attributes are exposed through atoms which won't be
> generally available when in Flight mode (e.g. SMSC address on SIM atom, M=
BDN
> on message waiting, etc)

I think this is mostly about SIM PIN. For instance, in the N900, PIN
is entered very early in the boot process, but RF is activated
(Powered=3Dtrue in oFono) only after the desktop is fully usable.
Granted, you could always prompt for the PIN only after the desktop is
fully usable, but the point is, this is now the only option you have
available with oFono.

Cheers,
Aki

--===============1466765480458965908==--

