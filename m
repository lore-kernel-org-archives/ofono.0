Content-Type: multipart/mixed; boundary="===============5172452055773324802=="
MIME-Version: 1.0
From: JH <jupiter.hce@gmail.com>
Subject: Re: Unsalble cellular connection
Date: Mon, 19 Aug 2019 11:51:44 +1000
Message-ID: <CAA=hcWQm56r-FA_wR1HaXKjfYmnewnTNNAgcYBNzBvC-Y7GS0w@mail.gmail.com>
In-Reply-To: <CAOf5uw=2U6MkcKP8OzWNyzwvxjAvYLdXuDASFVEjnWvMQ0fjHw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5172452055773324802==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi  Michael,

On 8/18/19, Michael Nazzareno Trimarchi <michael@amarulasolutions.com> wr=
ote:
> Aug 17 11:32:44 solar kernel: usb 1-1: new high-speed USB device
> number 5 using ci_hdrc
> Aug 17 11:32:45 solar kernel: usb 1-1: New USB device found,
> idVendor=3D05c6, idProduct=3D90b2, bcdDevice=3D 0.00
> Aug 17 11:32:45 solar kernel: usb 1-1: New USB device strings: Mfr=3D1,
> Product=3D2, SerialNumber=3D3
> Aug 17 11:32:45 solar kernel: usb 1-1: Product: QHSUSB__BULK
> Aug 17 11:32:45 solar kernel: usb 1-1: Manufacturer: Qualcomm CDMA
> Technologies MSM
> Aug 17 11:32:45 solar kernel: usb 1-1: SerialNumber: 5ff10299
>
> Here seems that reboot in bootloader mode. I have couple of disconnect
> and reconnect and I don't know if connman
> send some power on/off at command and make this strange behavior. The
> fact that start in bootloader mode can be a power
> issue? can you try to connect using a powered HUB?

I did a couple of restarting ofonod and connmand during the debug, one
or two times power recycling manually, not clear if it was me to cause
those reboot or not.

Like Daniel said, it was unlikely that connman would run reboot, it
might just record some messages from kernel.

Just talked to the hardware engineer, he said who is very concerning
we are using kernel 5.1.0, he said we should use kernel 4.9.123, could
the kernel 5.1.0 cause that issue? Jonas what is your comments?

Let me further clarify it, the issue did not occur very often, it
occurred randomly between hours to many days, that is a big worry, LTE
should be 100% stable.

Thank you.

Kind regards,

- jh

--===============5172452055773324802==--

