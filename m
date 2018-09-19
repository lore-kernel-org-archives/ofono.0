Content-Type: multipart/mixed; boundary="===============5407835504204841064=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/3] sim800: add udev detection
Date: Wed, 19 Sep 2018 15:03:57 -0500
Message-ID: <72714607-51ea-ca77-42fc-77ed237030e0@gmail.com>
In-Reply-To: <20180919200135.GD3536@turing>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5407835504204841064==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

>>
>> So I'm confused now.  If sim800 is a serial device, why do you have all =
this
>> here?  Shouldn't this be handled by setup_serial_modem ?
>>
> =

> Because the modem was seen through a serial/USB converter, my kernel sees=
 it as a USB device. So I used this function.
> Should this be coded in a more generic way ?
> =


Yes, you should use the setup_serial_modem bits and the UDEV rule =

outlined in patch 3 should take care of the detection.

Regards,
-Denis

--===============5407835504204841064==--

