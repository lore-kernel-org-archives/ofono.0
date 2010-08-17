Content-Type: multipart/mixed; boundary="===============3475051360529259545=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: Removal of modemconf plugin
Date: Tue, 17 Aug 2010 12:58:12 +0200
Message-ID: <1282042692.23399.73.camel@localhost.localdomain>
In-Reply-To: <52CF90264091A14888078A031D780F430644533A@ism-mail03.corp.ad.wrs.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3475051360529259545==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pengzhuo,

> > a gentle reminder that this mailing list doesn't allow top =

> > posting, please follow the netiquette for open source mailing lists.
> > =

> > > What about dual mode modems that with two different serial ports? =

> > > e.g. a modem support both GSM and CDMA, there is a serial port For =

> > > GSM, and there is a serial another for CDMA.
> > > =

> > > =

> > > Why not keep both udev and modemconf plug-in. It remains =

> > for the user =

> > > To decide which way to use. I think maybe we can change the compile =

> > > Scrips, let user to select which plug-in to use.
> > =

> > I don't even see a problem with this at all. Every serial =

> > port is present in udev, so you can write proper udev rules =

> > for it. A modem with a serial port for GSM and another one =

> > CDMA will be just presented as two modems inside oFono. So no =

> > problem at all.
> > =

> Udev really can work, but in many embedded devices,udev service is being
> forbidden because
> of boot-up speed issue. In addtion, on these devices, device nodes are
> often explictly defined.

this is just an urban myth. udev works as nicely on embedded system as
it works on servers. If you think it is not working fine, then lets have
Kay fix it. Also with the integration of devtmpfs all the last issues
with initial device nodes are solved and udev execution time on a really
static environment is almost non existent. If you have a problem with
your boot time, then it is somewhere else. I highly doubt it is really a
problem of udev.

Regards

Marcel



--===============3475051360529259545==--

