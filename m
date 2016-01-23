Content-Type: multipart/mixed; boundary="===============4150181262518356354=="
MIME-Version: 1.0
From: CedrIc Jehasse <cedric.jehasse@gmail.com>
Subject: Re: Huawei 3131 with idVendor=12d1, idProduct=14fe
Date: Sat, 23 Jan 2016 21:32:44 +0100
Message-ID: <47184AF1-26FD-4A4A-9E09-1D756E18B878@gmail.com>
In-Reply-To: <CADnUhn1Ts0rWpLknGnibnzt7iWU4B0e1pgHesVZ==yrLUSNZ1Q@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4150181262518356354==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> Executing ifconfig wwan0 up;dhclient wwan0 can't get lease from wwan0 int=
erface.
> =

I=E2=80=99ve had issues with an E3372 that didn=E2=80=99t accept cdc ncm fr=
ames from the linux cdc_ncm driver. Maybe there=E2=80=99s the same issue on=
 the E3131, causing dhcp to fail. I see it=E2=80=99s been worked around sin=
ce linux kernel v4.2 by adding the flag CDC_NCM_FLAG_NDP_TO_END to the cdc_=
ncm driver.

Cedric=20
--===============4150181262518356354==--

