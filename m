Content-Type: multipart/mixed; boundary="===============0020123984448646878=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Removal of modemconf plugin
Date: Fri, 13 Aug 2010 14:56:10 +0200
Message-ID: <1281704170.23399.5.camel@localhost.localdomain>
In-Reply-To: <87r5i35433.fsf@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0020123984448646878==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kalle,

> > Using special udev rules for special devices (in conjunction with the
> > oFono auto-detection rule) make the process of setting up oFono for the
> > system integrator a lot simpler. No manual configuration file patching
> > anymore. Just installation of an additional udev rule.
> >
> > The open here is the ISI modem detection, but this should be clearly
> > done via a Phonet plugin. And also the N900 specific case inside
> > modemconf is just wrong. This needs to be fixed and just auto-detected
> > via Phonet or maybe just via RTNL directly.
> =

> What about old style serial port modems? How can we configure them if
> you remove modemconf?

with a proper udev rule. All old style modems show up in udev as well.

Regards

Marcel



--===============0020123984448646878==--

