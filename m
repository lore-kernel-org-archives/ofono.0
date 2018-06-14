Content-Type: multipart/mixed; boundary="===============2436360131748090229=="
MIME-Version: 1.0
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Modem not detected by oFono
Date: Thu, 14 Jun 2018 14:19:05 +0200
Message-ID: <20180614121905.GA8798@amd>
In-Reply-To: <CAMp63jVABRSRaEKcf6HikG5438wX8jA-xAbQQfUYaMmXSSeZqQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2436360131748090229==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sat 2018-06-09 15:37:18, Davide Depau wrote:
> Hello,
> I just built oFono on Arch Linux from git [1]. I made sure no other progr=
am
> was using the modem (Huawei ME906s LTE M.2 Module) and started oFono. The
> modem is not recognized and I get no output in logs:
> =

> systemd[1]: Starting Telephony service...
> ofonod[32448]: oFono version 1.23
> systemd[1]: Started Telephony service.
> ofonod[32448]: parse_devices_reply: found 1st battery device:
> /org/freedesktop/UPower/devices/battery_BAT0
> =

> I checked the DBus org.ofono.Manager interface: GetModems() returns an
> empty list.
> It behaves like no modem is present, even though it's detected by the
> kernel:
> =

> [ 1471.866434] usb 1-2: new high-speed USB device number 8 using xhci_hcd
> [ 1472.008230] usb 1-2: New USB device found, idVendor=3D12d1, idProduct=
=3D15c1
> [ 1472.008234] usb 1-2: New USB device strings: Mfr=3D1, Product=3D2,
> SerialNumber=3D3
> [ 1472.008237] usb 1-2: Product: HUAWEI Mobile
> [ 1472.008239] usb 1-2: Manufacturer: Huawei Technologies Co., Ltd.
> [ 1472.008241] usb 1-2: SerialNumber: 0123456789ABCDEF
> [ 1472.012514] cdc_ether 1-2:2.0 wwan0: register 'cdc_ether' at
> usb-0000:00:14.0-2, Mobile Broadband Network Device, [MAC addr removed]
> [ 1472.013268] option 1-2:2.2: GSM modem (1-port) converter detected
> [ 1472.013414] usb 1-2: GSM modem (1-port) converter now attached to ttyU=
SB0
> [ 1472.013641] option 1-2:2.3: GSM modem (1-port) converter detected
> [ 1472.013715] usb 1-2: GSM modem (1-port) converter now attached to ttyU=
SB1
> [ 1472.013904] option 1-2:2.4: GSM modem (1-port) converter detected
> [ 1472.013972] usb 1-2: GSM modem (1-port) converter now attached to ttyU=
SB2
> [ 1472.014160] option 1-2:2.5: GSM modem (1-port) converter detected
> [ 1472.014229] usb 1-2: GSM modem (1-port) converter now attached to ttyU=
SB3
> [ 1472.014415] option 1-2:2.6: GSM modem (1-port) converter detected
> [ 1472.014480] usb 1-2: GSM modem (1-port) converter now attached to ttyU=
SB4
> [ 1472.592941] cdc_ether 1-2:2.0 wwp0s20f0u2c2: renamed from wwan0
> =

> Did I miss or mess up something?

Perhaps modems vid/pid needs to the list somewhere? (Maybe udevng.c ?)
									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--===============2436360131748090229==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEKCmlFWUVBUkVD
QUFZRkFsc2lYVGtBQ2drUU1PZndhcFhiK3ZMeVhRQ2VOVms0eFdHWVZUR3UvU1J5ZHp1UUtKUmEK
TFNBQW5pYmxXYUVhUUhaaVVnTCt0OGtJV1JOQWxHcHYKPWRYdVAKLS0tLS1FTkQgUEdQIFNJR05B
VFVSRS0tLS0tCg==

--===============2436360131748090229==--

