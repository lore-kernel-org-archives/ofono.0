Content-Type: multipart/mixed; boundary="===============8325925549872795134=="
MIME-Version: 1.0
From: Wang, Pengzhuo <Pengzhuo.Wang@windriver.com>
Subject: RE: Removal of modemconf plugin
Date: Tue, 17 Aug 2010 12:29:28 +0200
Message-ID: <52CF90264091A14888078A031D780F430644533A@ism-mail03.corp.ad.wrs.com>
In-Reply-To: <1282038865.23399.65.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8325925549872795134==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

Best Regards
 =

pengzhuo wang(bobwang)
Professional Service | WindRiver P.R.China Room3-H,New JinQiao Plaza,
No.585 Xizhang Rd(M),Shanghai,200003,P.R.C Tel:86-21-63585586/87/89/90
ext.208 Fax:86-21-63585591

 =


> -----Original Message-----
> From: ofono-bounces(a)ofono.org =

> [mailto:ofono-bounces(a)ofono.org] On Behalf Of Marcel Holtmann
> Sent: Tuesday, August 17, 2010 5:54 PM
> To: ofono(a)ofono.org
> Subject: RE: Removal of modemconf plugin
> =

> Hi Caiwen,
> =

> a gentle reminder that this mailing list doesn't allow top =

> posting, please follow the netiquette for open source mailing lists.
> =

> > What about dual mode modems that with two different serial ports? =

> > e.g. a modem support both GSM and CDMA, there is a serial port For =

> > GSM, and there is a serial another for CDMA.
> > =

> > =

> > Why not keep both udev and modemconf plug-in. It remains =

> for the user =

> > To decide which way to use. I think maybe we can change the compile =

> > Scrips, let user to select which plug-in to use.
> =

> I don't even see a problem with this at all. Every serial =

> port is present in udev, so you can write proper udev rules =

> for it. A modem with a serial port for GSM and another one =

> CDMA will be just presented as two modems inside oFono. So no =

> problem at all.
> =

Udev really can work, but in many embedded devices,udev service is being
forbidden because
of boot-up speed issue. In addtion, on these devices, device nodes are
often explictly defined.
 =

> So modemconf plugin will be removed since it is not needed at =

> all. The only component that needs it is the phonesim plugin. =

> And that will get its own configuration file.
> =

> Regards
> =

> Marcel
> =

> =

> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono
>=20

--===============8325925549872795134==--

