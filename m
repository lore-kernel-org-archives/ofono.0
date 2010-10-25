Content-Type: multipart/mixed; boundary="===============3913499222122418046=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] hso: Set modem name based on udev network interface name
Date: Mon, 25 Oct 2010 14:15:55 +0200
Message-ID: <1288008955.9729.28.camel@aeonflux>
In-Reply-To: <20101025120910.178860@gmx.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3913499222122418046==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Benoit,

please fix your mail client. You keep breaking threading every single
time you respond. That is pretty annoying.

> > the friendly modem name is for devices that do have a friendly name,
> > like Bluetooth headsets. Why do you wanna misuse the interface name
> > here. I am a bit against this, because it leads to speculation and
> > assumptions in userspace programs.
> > =

> Maybe I should give some details of what I'm trying to achieve. The
> device we're building has 2 identical modems with fixed position on
> USB. We also have the possibility to drive their power supply
> independently and to swap the sim cards.
> =

> I need a way to know which one is modem A and which one is modem B
> and I have no easy way of knowing the modem serial number or the
> sim subscriber id beforehand. With an udev rule, I can easily set
> a fixed name for the network interface of each modem. But under
> ofono, I can't tell which modem is which. That's why I added this
> "not-so-friendly" name.

actually do you get the serial number from the USB descriptors?

> Is there a way of knowing which physical modem ofono is refering to ?
> I recognize that our case may not be the most common and I understand
> that you don't want to abuse the Name property. Maybe exposing the
> NetworkInterface as a modem property would be ok ? or exposing
> a PhysicalName ?

oFono does not have the concept of physical devices actually. We moved
away from dealing with specific modem hardware for a reason. oFono is
based around a SIM card.

However we did allow the object path of the modem to be unique, but for
that, the udev plugin needs to know it. And in your case the modem needs
to have proper USB descriptors for that.

Regards

Marcel



--===============3913499222122418046==--

