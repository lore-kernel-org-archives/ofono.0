Content-Type: multipart/mixed; boundary="===============1443109549117177852=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 1/3] Add radio settings atom and driver API
Date: Thu, 04 Feb 2010 07:23:24 -0800
Message-ID: <1265297004.31341.163.camel@localhost.localdomain>
In-Reply-To: <1265296513.2603.2.camel@Nokia-N900-50-5>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1443109549117177852==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

> > > +Properties    string Mode [read-write]
> > > +
> > > +            The current radio access selection mode, also known
> > > +            as network preference.
> > > +
> > > +            The possible values are:
> > > +                "dual"        Radio access selection is done
> > > +                        automatically, using either 2G
> > > +                        or 3G, depending on reception.
> > > +                "2g"            Only GSM used for radio access.
> > > +                "3g"            Only UTRAN used for radio access.
> > > +                "unknown"  Mode currently unknown.
> >
> > how would we be dealing with LTE here. The word "dual" is kinda tricky
> > in that sense. Also what about chips like Qualcomm GOBI that can change
> > their firmware and start operating in CDMA. We do wanna extend oFono to
> > support CDMA at some point.
> =

> Yeah, perhaps the property should be called "TechnologyPreference" with v=
alues "any", "2G", "3G", "4G". For now at least.

so what about the magic CDMA + UMTS combo chips. We basically have to
reload the firmware with these. Would be nice to figure out on how that
can be done. Not that we know much about how Qualcomm intends to use
that in a phone case scenario, but would be nice to at least think about
it a bit.

Also I wanted you to ask about the data roaming. Does the Nokia modem
has an option to NOT data roam that we can set. The problem with doing
it in the host is that a bit of data goes through if you start roaming
and have a PDP context active. So it costs the user. At least some
reports indicate this. Does your modem forces a detach or does it just
happily data roam and just give us a cell update?

The AT command specification obviously didn't care about this at all :(

Regards

Marcel



--===============1443109549117177852==--

