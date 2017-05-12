Content-Type: multipart/mixed; boundary="===============2937486255812382196=="
MIME-Version: 1.0
From: Pau Espin Pedrol <pespin@sysmocom.de>
Subject: Re: [PATCH] gobi/qmi: Fix invalid memory access
Date: Fri, 12 May 2017 15:16:34 +0200
Message-ID: <c0c1d641-d90e-386f-0f22-d23206376e63@sysmocom.de>
In-Reply-To: <61d4226a-d9f1-8c38-f599-dceb73b17131@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2937486255812382196==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On 11/05/17 21:45, Denis Kenzior wrote:
> =

> Please try the attached patch.
> =

> Regards,
> -Denis

I tested it and it looks good, I was unable to trigger the valgrind =

issue anymore. This issue was causing ofono to crash from time to time btw.

Thanks for providing correct fix for the issue.

Regards,
Pau

-- =

- Pau Espin Pedrol <pespin@sysmocom.de>         http://www.sysmocom.de/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
* sysmocom - systems for mobile communications GmbH
* Alt-Moabit 93
* 10559 Berlin, Germany
* Sitz / Registered office: Berlin, HRB 134158 B
* Geschaeftsfuehrer / Managing Director: Harald Welte

--===============2937486255812382196==--

