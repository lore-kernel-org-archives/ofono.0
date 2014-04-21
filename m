Content-Type: multipart/mixed; boundary="===============3403247600490755241=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Huawei E171 modem removed after execute online-modem script.
Date: Sun, 20 Apr 2014 23:30:31 -0500
Message-ID: <53549EE7.8070203@gmail.com>
In-Reply-To: <CAGNC_aNqCRxhP-J_a5HB=_5K+Zv6xn0-dE-9f1yHKUHjqfRLiA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3403247600490755241==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Renat,

On 04/20/2014 03:55 PM, r.r.zaripov wrote:
> ofonod[9917]: drivers/atmodem/cbs.c:at_cbs_set_topics()
> ofonod[9917]: PCUI: > AT+CSCB=3D0\r
> ofonod[9917]: PCUI: < \r\n+CMS ERROR: 302\r\n
> ofonod[9917]: PCUI: >
> AT+CSCB=3D0,"0-1,3,5,7,11,13,43,130,333,500,555,666,900,4096,4097,4098,40=
99,4100,4101,4102,4103,4104,4105,4352-4356"\r
> ofonod[9917]: plugins/udevng.c:remove_device()
> /sys/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.2/2-1.2:1.0/ttyUSB0/tty=
/ttyUSB0
> ofonod[9917]: plugins/udevng.c:destroy_modem()
> /sys/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.2

Sounds like your modem doesn't like commands related to Cell Broadcast
and goes away (likely crashes) when it receives something it finds
objectionable.

Try removing the CBS atom from this model or quirking the behavior.

Regards,
-Denis

--===============3403247600490755241==--

