Content-Type: multipart/mixed; boundary="===============8343667076826624051=="
MIME-Version: 1.0
From: Gu, Yang <yang.gu@intel.com>
Subject: RE: Option GTM 382
Date: Mon, 26 Apr 2010 18:10:55 +0800
Message-ID: <CE761E84DADF2947A4AF22FB8D97A4731CD28413@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <m2o35f991da1004260251l980f256az81d81754644a3218@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8343667076826624051==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

>> The product id for this modem is already in ofono.rules:
>> ATTRS{idVendor}=3D=3D"0af0", ATTRS{idProduct}=3D=3D"7601",
>ENV{OFONO_DRIVER}=3D"hso"
>> Below is the output at my side:
>> ./list-modems
>> [ /hso0 ]
>> =C2=A0 =C2=A0Interfaces =3D
>> =C2=A0 =C2=A0Powered =3D 0
>>
>> Then you may need to run enable-modem (script in test directory) to enab=
le this
>modem.
>
>I have the modem also in the ofono.rules file, but enable-modem returns:
>
>Traceback (most recent call last):
>  File "./enable-modem", line 14, in <module>
>    path =3D properties["Modems"][0]
>IndexError: list index out of range
>
>lsusb shows the device in the list:
>Bus 001 Device 004: ID 0af0:7601 Option

Yes, it seems we have the same modem.
>
>Any ideas, what I should check next?

Have you put the ofono.rules into /etc/udev/rules.d?

Regards,
-Yang

--===============8343667076826624051==--

