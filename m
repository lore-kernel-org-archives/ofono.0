Content-Type: multipart/mixed; boundary="===============8101310069478757406=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v2 3/3] isimodem: header updates for ISI2.5
Date: Wed, 02 Feb 2011 11:47:30 +0100
Message-ID: <1296643650.1520.322.camel@aeonflux>
In-Reply-To: <1296588776.2619.30.camel@tucson>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8101310069478757406==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

> > > +enum isi_version {
> > > +	ISI_20 =3D 0,
> > > +	ISI_25 =3D 1
> > > +};
> > =

> > so what is the final decision here now. ISI doing auto-detection and
> > this gets not exposed to the modem drivers or we do.
> =

> Like I replied earlier, I don't see the need for this. Also, it will not
> work well with the isiusb plugin, which has the potential to work with
> any ISI modem. I'm not willing to break that potential until we just
> absolutely have to.
> =

> So, my stance holds: we quirk based on resource ID and based on the
> server's ISI version.

good to know. I was just double-checking in case you guys agreed on
something different on a private channel.

> I'm starting to think me just saying this out loud is not concrete
> enough, so I guess one way forward here could be for me to go ahead and
> adapt e.g. the netreg driver to work with N900 and later ISI modems. The
> netreg driver would make a good example, as it is one of those where the
> resource ID changes post N900, and the messages do vary based on it.

I think having an example on how you want this handled would be a good
idea. I don't have time to get myself familiar enough with ISI that I
can do any proper review here. So this is in your hands.

Regards

Marcel



--===============8101310069478757406==--

