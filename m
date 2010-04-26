Content-Type: multipart/mixed; boundary="===============0514884320069591185=="
MIME-Version: 1.0
From: Gu, Yang <yang.gu@intel.com>
Subject: RE: Option GTM 382
Date: Mon, 26 Apr 2010 10:39:00 +0800
Message-ID: <CE761E84DADF2947A4AF22FB8D97A4731CD27E86@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <201004230954.06488.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0514884320069591185==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

>-----Original Message-----
>From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On Beha=
lf Of
>Denis Kenzior
>Sent: Friday, April 23, 2010 10:54 PM
>To: ofono(a)ofono.org
>Subject: Re: Option GTM 382
>
>Hi Teemu,
>
>> Is Option GTM 382 supported? The module works with Ubuntu's own
>> connection manager, but list-modems script doesn't return anything.
>
>This modem is in the HSO family, so should be supported by oFono.  Can you
>edit plugins/ofono.rules (see the Option Globetrotter rules) to add the
>product ID of this modem and see if it is detected?

The product id for this modem is already in ofono.rules:
ATTRS{idVendor}=3D=3D"0af0", ATTRS{idProduct}=3D=3D"7601", ENV{OFONO_DRIVER=
}=3D"hso"
Below is the output at my side:
./list-modems
[ /hso0 ]
    Interfaces =3D =

    Powered =3D 0

Then you may need to run enable-modem (script in test directory) to enable =
this modem.


>Regards,
>-Denis
>_______________________________________________
>ofono mailing list
>ofono(a)ofono.org
>http://lists.ofono.org/listinfo/ofono


Regards,
-Yang

--===============0514884320069591185==--

