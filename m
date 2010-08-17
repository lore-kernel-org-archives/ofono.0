Content-Type: multipart/mixed; boundary="===============4524568551726233961=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: Removal of modemconf plugin
Date: Tue, 17 Aug 2010 12:21:58 +0200
Message-ID: <1282040518.23399.69.camel@localhost.localdomain>
In-Reply-To: <CE761E84DADF2947A4AF22FB8D97A47328F28F73@shsmsx501.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4524568551726233961==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yang,

> >> What about dual mode modems that with two different serial ports?
> >> e.g. a modem support both GSM and CDMA, there is a serial port
> >> For GSM, and there is a serial another for CDMA.
> >>
> >>
> >> Why not keep both udev and modemconf plug-in. It remains for the user
> >> To decide which way to use. I think maybe we can change the compile
> >> Scrips, let user to select which plug-in to use.
> >
> >I don't even see a problem with this at all. Every serial port is
> >present in udev, so you can write proper udev rules for it. A modem with
> >a serial port for GSM and another one CDMA will be just presented as two
> >modems inside oFono. So no problem at all.
> >
> >So modemconf plugin will be removed since it is not needed at all. The
> >only component that needs it is the phonesim plugin. And that will get
> >its own configuration file.
> =

> Can we just add some code in phonesim to make it look like a pseudo seria=
l device which can be managed by udev? That is, if we start the phonesim, i=
t will simulate some tty ports under /dev and udevd will inform the oFono t=
here is a new device (We need some rule for phonesim). And the device disap=
pears if phonesim meets an end.
> Maybe this is possible if we can send message to udevd the same way as ke=
rnel via netlink.

in theory yes, but phonesim is the one piece that also works via TCP. So
just having a /etc/ofono/phonesim.conf is a lot simpler.

Regards

Marcel



--===============4524568551726233961==--

