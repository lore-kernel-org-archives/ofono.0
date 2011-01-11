Content-Type: multipart/mixed; boundary="===============5142249474324954807=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: Re: [PATCH 05/10] Update documentation for GPRS technology
Date: Tue, 11 Jan 2011 10:57:47 +0200
Message-ID: <201101111057.47545.remi.denis-courmont@nokia.com>
In-Reply-To: <1294705860.3873.4.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5142249474324954807==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tuesday 11 January 2011 02:31:00 ext Marcel Holtmann, you wrote:
> Hi Remi,
> =

> >  doc/connman-api.txt |    8 ++++++++
> >  1 files changed, 8 insertions(+), 0 deletions(-)
> > =

> > diff --git a/doc/connman-api.txt b/doc/connman-api.txt
> > index 22e02e5..b13efd1 100644
> > --- a/doc/connman-api.txt
> > +++ b/doc/connman-api.txt
> > @@ -77,6 +77,14 @@ Properties	boolean Attached [readonly]
> > =

> >  			be available, e.g. receiving SMS over packet radio
> >  			or network initiated PDP activation.
> > =

> > +		string Technology [readonly, optional]
> > +
> > +			Contains the data technology as reported by the
> > +			GPRS service registration (if known).
> > +
> > +			Possible values are the same as for the Technology
> > +			property the NetworkRegistration object.
> > +
> =

> we used to have this value and then we removed it since it ended up
> being not useful. So why do you wanna bring it back?

The network registration only ever tells 2G/3G/4G. We need something to tel=
l =

about EDGE or HS*PA. We cannot rely (only) on the CPSB bearer as it is only =

defined when there is an active context. Technology is set whenever we are =

registered to the GPRS service.

-- =

R=C3=A9mi Denis-Courmont
Nokia Devices R&D, Maemo Software, Helsinki

--===============5142249474324954807==--

