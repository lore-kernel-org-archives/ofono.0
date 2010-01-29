Content-Type: multipart/mixed; boundary="===============6447622361177370335=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: RFC: API for Neighbouring Cell Info
Date: Fri, 29 Jan 2010 10:51:52 -0600
Message-ID: <201001291051.52879.denkenz@gmail.com>
In-Reply-To: <1264782563.19283.825.camel@phoenix.elisa-laajakaista.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6447622361177370335==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

> > Honestly I don't like either approach, the Agent pattern would be a
> > much better fit here.  This would allow us to specify
> > the polling/update interval and stop neighbor cell updates when no one
> > is interested in them.
> =

> In my experience, the positioning guys don't need periodic updates at
> all. The data needs to be fetched on demand. Like whenever the user
> starts up a location-aware application.

Fair enough, but we also have to consider the case of multiple applications =

being interested in this information.  We can't assume that it will be poll=
ed =

on demand by just one...

> =

> > > > Once there is agreement on the API we can discuss whether it makes
> > > > sense to add some skeleton support in the oFono core or leave it to
> > > > each individual modem plugin to implement the DBUS service in its
> > > > entire.
> > >
> > > I think it's reasonable to assume that most modems support this. There
> > > is a standard to follow, and at least isimodem will have a driver for
> > > it. So I would make it a proper atom from the beginning.
> >
> > I'd like to see the low level driver API proposal first.  The Nokia
> > isimodem interface is actually quite sane, AT command modems are usually
> > not so...  If we make this into a proper atom we have to make this work
> > for all hardware from the beginning.
> =

> Right, we perhaps need a datapoint from an AT modem to know for sure,
> but the fact that OMA SUPL standardizes this, and the ISI interface is
> close to that standard already, makes me think the AT modems can't be
> that far off.

I have a few modems that support this capability, so we can definitely chec=
k.

> =

> I could take a stab at a driver API for this as soon as I clear up some
> space on my todo list.

Yes, that would be great.

Regards,
-Denis

--===============6447622361177370335==--

