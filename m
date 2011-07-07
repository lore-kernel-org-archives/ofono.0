Content-Type: multipart/mixed; boundary="===============9024503390288712548=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: [PATCH] Create a SpeedUp plugin, using standard AT Modem,
 and add corresponding udev rules
Date: Thu, 07 Jul 2011 10:04:58 +0200
Message-ID: <1310025902.21109.50.camel@aeonflux>
In-Reply-To: <568DE01DA537804BA73470071BAC288938DF3488@irsmsx503.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9024503390288712548==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bertrand,

> >I tried with the code, but my speedup dongle still failed to work.
> >
> >Until I issue command manually: modprobe usbserial vendor=3D0x1c9e produ=
ct=3D0x9800, then the driver is >attached and ttyUSB0, 1, 2 devices are cre=
ated, and ofono starts to probe the device.
> >After ofono starts to initialize the Speedup modem, the registration pro=
cess failed. I attach the >log here with AT debug info.
> >
> >Question: why the usbserial driver cannot probe and installed with the s=
peedup dongle automatically?  =

> =

> Yes I know, and I am working on it.
> =

> I don't know why we have to do the modprobe manually. If someone has some=
 info, I would be very happy to get them.

I am not even sure that the usbserial driver is 100% the right one for
this hardware. That is something that SpeedUp should confirm. However if
the VID/PID combination is not listed in any USB_DEVICE() entry of any
driver, then of course the kernel can not pick the device. Actually I
don't see usbserial has any USB_DEVICE entries. They are all in
specialized drivers.

Anyhow, the linux-usb mailing list should be the first contact point for
this.

Regards

Marcel



--===============9024503390288712548==--

