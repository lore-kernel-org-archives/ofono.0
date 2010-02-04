Content-Type: multipart/mixed; boundary="===============4967538242190081963=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 1/3] Add radio settings atom and driver API
Date: Thu, 04 Feb 2010 08:35:25 -0800
Message-ID: <1265301325.31341.165.camel@localhost.localdomain>
In-Reply-To: <1265298185.2603.7.camel@Nokia-N900-50-5>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4967538242190081963==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

> > > Yeah, perhaps the property should be called "TechnologyPreference" wi=
th values
> > > "any", "2G", "3G", "4G". For now at least.
> >
> > so what about the magic CDMA + UMTS combo chips. We basically have to
> > reload the firmware with these. Would be nice to figure out on how that
> > can be done. Not that we know much about how Qualcomm intends to use
> > that in a phone case scenario, but would be nice to at least think about
> > it a bit.
> =

> I'm not at all sure toggling between CDMA and UMTS is going to work smoot=
hly enough for it to be done at this interface level. It sounds more like d=
isabling one modem and enabling another. And I'm sure there are other areas=
 in the API that are going to need tweaking for CDMA. I would rather cross =
that bridge when we come to it.

fair enough from my point of view, but lets keep that in mind. The
hardware for that is out there.

> > Also I wanted you to ask about the data roaming. Does the Nokia modem
> > has an option to NOT data roam that we can set. The problem with doing
> > it in the host is that a bit of data goes through if you start roaming
> > and have a PDP context active. So it costs the user. At least some
> > reports indicate this. Does your modem forces a detach or does it just
> > happily data roam and just give us a cell update?
> =

> You mean PDP contexts survive a network change? I don't think they do. So=
unds like a bug in the application.
> =

> The Nokia modems have a setting to automatically attach, but that doesn't=
 yet move any data.

That is what T-Mobile promises me when crossing borders into Netherlands
or Austria with my German SIM card. It should have smooth data roaming.
To be honest, I have never really tried it. Either I was on a plane
anymore or too cheap to pay for data roaming ;)

Regards

Marcel



--===============4967538242190081963==--

