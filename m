Content-Type: multipart/mixed; boundary="===============6414996162520308086=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: tun interface name conflicts with ppp driver
Date: Thu, 06 Dec 2012 16:59:47 +0100
Message-ID: <1354809587.1815.27.camel@aeonflux>
In-Reply-To: <CABvLYuBcciGaMBvJK0ss1PiufW2=bMFsonEnmyT+Q2HeshzBtw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6414996162520308086==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Cedric,

> > actually we are using ppp%d syntax to assign the network interfaces. So
> > the kernel does the numbering. This is a bug in pppd and not ours.
> >
> > Looking at the pppd code, it seems to hardcodes ppp0. So please complain
> > to them for assuming that a certain device name is owned by them.
> >
> =

> pppd requests the ppp driver to create a network interface with the ioctl
>  PPPIOCNEWUNIT. If the parameter passed to the ioctl is -1, the ppp driver
> will allocate the unit itself. Because it's the first network interface
> created by the ppp driver, and the ppp driver doesn't know about the tun
> interface, it's choosing 0. Check ppp_create_interface() in ppp_generic.c
> in the kernel to see how this is done.
> =

> So it seems the ppp driver reserves the ppp%d interface names.

that is not how the kernel works. It is global and tun interface will
not interfere with ppp interface. In case ppp driver and pppd would do
it right, then there would be no conflict.

Regards

Marcel



--===============6414996162520308086==--

