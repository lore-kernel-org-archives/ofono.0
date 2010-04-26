Content-Type: multipart/mixed; boundary="===============8600403687651383115=="
MIME-Version: 1.0
From: Teemu Piiroinen <teemu.piiroinen@gmail.com>
Subject: Re: Option GTM 382
Date: Mon, 26 Apr 2010 12:51:55 +0300
Message-ID: <m2o35f991da1004260251l980f256az81d81754644a3218@mail.gmail.com>
In-Reply-To: <CE761E84DADF2947A4AF22FB8D97A4731CD27E86@shsmsx501.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8600403687651383115==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello

On Mon, Apr 26, 2010 at 5:39 AM, Gu, Yang <yang.gu@intel.com> wrote:
> Hi,
>
>>-----Original Message-----
>>From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On Beh=
alf Of
>>Denis Kenzior
>>Sent: Friday, April 23, 2010 10:54 PM
>>To: ofono(a)ofono.org
>>Subject: Re: Option GTM 382
>>
>>Hi Teemu,
>>
>>> Is Option GTM 382 supported? The module works with Ubuntu's own
>>> connection manager, but list-modems script doesn't return anything.
>>
>>This modem is in the HSO family, so should be supported by oFono. =C2=A0C=
an you
>>edit plugins/ofono.rules (see the Option Globetrotter rules) to add the
>>product ID of this modem and see if it is detected?
>
> The product id for this modem is already in ofono.rules:
> ATTRS{idVendor}=3D=3D"0af0", ATTRS{idProduct}=3D=3D"7601", ENV{OFONO_DRIV=
ER}=3D"hso"
> Below is the output at my side:
> ./list-modems
> [ /hso0 ]
> =C2=A0 =C2=A0Interfaces =3D
> =C2=A0 =C2=A0Powered =3D 0
>
> Then you may need to run enable-modem (script in test directory) to enabl=
e this modem.

I have the modem also in the ofono.rules file, but enable-modem returns:

Traceback (most recent call last):
  File "./enable-modem", line 14, in <module>
    path =3D properties["Modems"][0]
IndexError: list index out of range

lsusb shows the device in the list:
Bus 001 Device 004: ID 0af0:7601 Option

Any ideas, what I should check next?

Br,
Teemu

>
>
>>Regards,
>>-Denis
>>_______________________________________________
>>ofono mailing list
>>ofono(a)ofono.org
>>http://lists.ofono.org/listinfo/ofono
>
>
> Regards,
> -Yang
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono
>

--===============8600403687651383115==--

