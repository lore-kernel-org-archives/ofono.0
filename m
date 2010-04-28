Content-Type: multipart/mixed; boundary="===============5995752039957795705=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: [PATCH] usbpnmodem: configure usbpn interfaces automatically
Date: Wed, 28 Apr 2010 16:03:59 +0300
Message-ID: <p2j80fd4e751004280603gea6dc8fdy642032645ec5a88c@mail.gmail.com>
In-Reply-To: <201004231300.22037.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5995752039957795705==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

2010/4/23 Denis Kenzior <denkenz@gmail.com>:
>> + =C2=A0 =C2=A0 *(uint32_t *)(void *)RTA_DATA(rta) =3D ifa_index;

> I'm running away scared from this one...

This is the GCC -Wcast-align problem. It does not grok the alignment
logic in RTA_DATA() macro from Linux kernel.

-- =

Pekka.Pessi mail at nokia.com

--===============5995752039957795705==--

