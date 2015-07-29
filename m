Content-Type: multipart/mixed; boundary="===============7718174762224309692=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: query
Date: Wed, 29 Jul 2015 10:23:59 -0500
Message-ID: <55B8F00F.5030703@gmail.com>
In-Reply-To: <222E70FA67D72A4FB8EEDF5AF01724ACCF22F3@BGSMSX102.gar.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7718174762224309692==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Ram,

On 07/28/2015 04:27 AM, Kallumari Nagaraja Rao, RammohanX wrote:
> Hi All,
>
> I am trying to get ofono running on my Intel Edison board.
>
> We have Intel Arduino Board with Ublox Sara-G350 connected via ttyMFD1
> device.
>
> 1.Placed necessary configuration files at the needed places.
>
> a.Ofono.conf
>
> b.Tun.conf
>
> c.Ofono.rules
>
> 2.Updated ofono.rules with the following,
>
> # Ublox SARA-G350
>
> ATTRS{idVendor}=3D=3D"1546", ATTRS{idProduct}=3D=3D"1102", ENV{OFONO_DRIV=
ER}=3D"ublox"
>

I don't know what this is doing, but in general ofono.rules is only used =

for pure-serial devices.  ublox driver is only setup to work via USB. =

Is your modem hardware USB based?

> 3.tun.conf into modules-load.d, but when I do lsmod I do not see module
> tun being loaded !
>
> 4.when I try running ofonod, I get struck at BT stuff as attached.
>
> Please let me know if I am missing something.
>

Regards,
-Denis

--===============7718174762224309692==--

