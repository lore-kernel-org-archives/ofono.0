Content-Type: multipart/mixed; boundary="===============8488870821731504212=="
MIME-Version: 1.0
From: Lukasz Nowak <lnowak.tyco@gmail.com>
Subject: Re: Telit LE910V1 - LTE only modem
Date: Thu, 16 Mar 2017 12:57:44 +0000
Message-ID: <66b613b4-f5f0-43dc-f512-9dfb6c542944@gmail.com>
In-Reply-To: <20170316093204.25275-1-gluedig@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8488870821731504212==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Piotr,

Thanks for the QMI patch. I will try it out, and if I manage to get it to w=
ork with the SVG modem, maybe it can be submitted to the main ofono code ba=
se.
I think vid/pid can be added to the list of devices in udevng.c to force th=
e qmimodem driver to load.

btw I am being told that at least the SVG variant (Verizon) hardware is not=
 EOLed by Telit currently.

Lukasz


On 16/03/17 09:32, Piotr Haber wrote:
> Hi Lukasz,
> =

> I have never useg LE910-SVG but I have used LE910-EUG which is also V1 LE=
910 modem.
> It uses QMI interface and is End-of-life product according to Telit.
> Below is a patch I used to add support for it, maybe it will help you.
> =

> Modem is not recognized automatically, you need to point ofono  to use co=
rrect driver
> by setting ENV{OFONO_DRIVER}=3D"le910" in udev.
> =

> =

>=20

--===============8488870821731504212==--

