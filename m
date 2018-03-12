Content-Type: multipart/mixed; boundary="===============1665614526321599482=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: LTE atom support for gemalto modem
Date: Mon, 12 Mar 2018 09:39:18 -0500
Message-ID: <b01a0978-83a7-7d2d-c924-55a0524800d1@gmail.com>
In-Reply-To: <8e8e60f4-7eda-b8de-f88c-efdf1927f99c@smile.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1665614526321599482==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Gabriel,

> I've been having a look at the recent LTE atom. I've noticed there was =

> no vendor-specific parameter when registering it. I think we might have =

> some problem with the atmodem driver as in the =

> AT+CGDCONT=3D<context-id>,... command, the context-id starts from 0 on =

> some modems and from 1 on other ones (I won't denounce gemalto).

Hah, that was obviously a mistake.  Not sure who let that past review =

stage ;)

Anyway, it is fixed now upstream.

Regards,
-Denis

--===============1665614526321599482==--

