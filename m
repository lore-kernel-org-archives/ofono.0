Content-Type: multipart/mixed; boundary="===============1702678716720655420=="
MIME-Version: 1.0
From: Kallumari Nagaraja Rao, RammohanX <rammohanx.kallumari.nagaraja.rao@intel.com>
Subject: RE: query
Date: Thu, 30 Jul 2015 12:49:54 +0000
Message-ID: <222E70FA67D72A4FB8EEDF5AF01724ACCF2637@BGSMSX102.gar.corp.intel.com>
In-Reply-To: <55B8F00F.5030703@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1702678716720655420==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

Can't we use the existing ofono UBLOX driver to work with serial interfaces=
 instead of USB interface ?

Regards,
Ram.


-----Original Message-----
From: ofono [mailto:ofono-bounces(a)ofono.org] On Behalf Of Denis Kenzior
Sent: Wednesday, July 29, 2015 8:54 PM
To: ofono(a)ofono.org
Subject: Re: query

Hi Ram,

On 07/28/2015 04:27 AM, Kallumari Nagaraja Rao, RammohanX wrote:
> Hi All,
>
> I am trying to get ofono running on my Intel Edison board.
>
> We have Intel Arduino Board with Ublox Sara-G350 connected via ttyMFD1 =

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

I don't know what this is doing, but in general ofono.rules is only used fo=
r pure-serial devices.  ublox driver is only setup to work via USB. =

Is your modem hardware USB based?

> 3.tun.conf into modules-load.d, but when I do lsmod I do not see =

> module tun being loaded !
>
> 4.when I try running ofonod, I get struck at BT stuff as attached.
>
> Please let me know if I am missing something.
>

Regards,
-Denis
_______________________________________________
ofono mailing list
ofono(a)ofono.org
https://lists.ofono.org/mailman/listinfo/ofono

--===============1702678716720655420==--

