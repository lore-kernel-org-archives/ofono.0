Content-Type: multipart/mixed; boundary="===============4364671825401978020=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Beno=C3=AEt?= Monin <benoit.monin@gmx.fr>
Subject: Re: [PATCH] hso: Set modem name based on udev network interface name
Date: Sun, 07 Nov 2010 21:32:33 +0100
Message-ID: <201011072132.33440.benoit.monin@gmx.fr>
In-Reply-To: <1288008955.9729.28.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4364671825401978020==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,
[Sorry for the delay]

Le lundi 25 octobre 2010 14:15:55 Marcel Holtmann, vous avez =C3=A9crit :
> actually do you get the serial number from the USB descriptors?
> =

No, the serial number comes from an AT command, I guess.

> oFono does not have the concept of physical devices actually. We moved
> away from dealing with specific modem hardware for a reason. oFono is
> based around a SIM card.
> =

> However we did allow the object path of the modem to be unique, but for
> that, the udev plugin needs to know it. And in your case the modem needs
> to have proper USB descriptors for that.
> =

I checked with udevadm info, ID_SERIAL_SHORT is not set and ID_SERIAL
is "Option_N.V._Globetrotter_HSUPA_Modem" for both modem. So I simply set
ID_SERIAL_SHORT to what I wanted with an udev rule. =


Thank you for pointing me to udev and please discard my patch.

--
Cordially,
Beno=C3=AEt.



--===============4364671825401978020==--

