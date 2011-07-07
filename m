Content-Type: multipart/mixed; boundary="===============1803396085249116248=="
MIME-Version: 1.0
From: Aygon, Bertrand <bertrand.aygon@intel.com>
Subject: RE: [PATCH] Create a SpeedUp plugin, using standard AT Modem,
 and add corresponding udev rules
Date: Thu, 07 Jul 2011 08:29:02 +0100
Message-ID: <568DE01DA537804BA73470071BAC288938DF3488@irsmsx503.ger.corp.intel.com>
In-Reply-To: <CE59C043D0EC3349B2BF41C0EC72229B12D1E4CC19@shsmsx501.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1803396085249116248==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

>I tried with the code, but my speedup dongle still failed to work.
>
>Until I issue command manually: modprobe usbserial vendor=3D0x1c9e product=
=3D0x9800, then the driver is >attached and ttyUSB0, 1, 2 devices are creat=
ed, and ofono starts to probe the device.
>After ofono starts to initialize the Speedup modem, the registration proce=
ss failed. I attach the >log here with AT debug info.
>
>Question: why the usbserial driver cannot probe and installed with the spe=
edup dongle automatically?  =


Yes I know, and I am working on it.

I don't know why we have to do the modprobe manually. If someone has some i=
nfo, I would be very happy to get them.

Regards,

Bertrand
---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


--===============1803396085249116248==--

