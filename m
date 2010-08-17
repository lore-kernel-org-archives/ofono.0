Content-Type: multipart/mixed; boundary="===============2783133063333089027=="
MIME-Version: 1.0
From: Zhang, Caiwen <Caiwen.Zhang@windriver.com>
Subject: RE: Removal of modemconf plugin
Date: Tue, 17 Aug 2010 11:25:46 +0200
Message-ID: <D87B22B1FE8C0F479CA9BEAD6C25AAE80550C4FE@ism-mail03.corp.ad.wrs.com>
In-Reply-To: <1281704170.23399.5.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2783133063333089027==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

What about dual mode modems that with two different serial ports? =

e.g. a modem support both GSM and CDMA, there is a serial port
For GSM, and there is a serial another for CDMA.


Why not keep both udev and modemconf plug-in. It remains for the user
To decide which way to use. I think maybe we can change the compile
Scrips, let user to select which plug-in to use.

Best regards,
Caiwen

> -----Original Message-----
> From: Marcel Holtmann [mailto:marcel(a)holtmann.org]
> Sent: Friday, August 13, 2010 8:56 PM
> To: ofono(a)ofono.org
> Subject: Re: Removal of modemconf plugin
> =

> Hi Kalle,
> =

> > > Using special udev rules for special devices (in conjunction with
> the
> > > oFono auto-detection rule) make the process of setting up oFono for
> the
> > > system integrator a lot simpler. No manual configuration file
> patching
> > > anymore. Just installation of an additional udev rule.
> > >
> > > The open here is the ISI modem detection, but this should be
> clearly
> > > done via a Phonet plugin. And also the N900 specific case inside
> > > modemconf is just wrong. This needs to be fixed and just auto-
> detected
> > > via Phonet or maybe just via RTNL directly.
> >
> > What about old style serial port modems? How can we configure them if
> > you remove modemconf?
> =

> with a proper udev rule. All old style modems show up in udev as well.
> =

> Regards
> =

> Marcel
> =

> =



--===============2783133063333089027==--

