Content-Type: multipart/mixed; boundary="===============0307521297156176502=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: Removal of modemconf plugin
Date: Tue, 17 Aug 2010 11:54:25 +0200
Message-ID: <1282038865.23399.65.camel@localhost.localdomain>
In-Reply-To: <D87B22B1FE8C0F479CA9BEAD6C25AAE80550C4FE@ism-mail03.corp.ad.wrs.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0307521297156176502==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Caiwen,

a gentle reminder that this mailing list doesn't allow top posting,
please follow the netiquette for open source mailing lists.

> What about dual mode modems that with two different serial ports? =

> e.g. a modem support both GSM and CDMA, there is a serial port
> For GSM, and there is a serial another for CDMA.
> =

> =

> Why not keep both udev and modemconf plug-in. It remains for the user
> To decide which way to use. I think maybe we can change the compile
> Scrips, let user to select which plug-in to use.

I don't even see a problem with this at all. Every serial port is
present in udev, so you can write proper udev rules for it. A modem with
a serial port for GSM and another one CDMA will be just presented as two
modems inside oFono. So no problem at all.

So modemconf plugin will be removed since it is not needed at all. The
only component that needs it is the phonesim plugin. And that will get
its own configuration file.

Regards

Marcel



--===============0307521297156176502==--

