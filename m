Content-Type: multipart/mixed; boundary="===============4595421666844202716=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: Re: [PATCH 3/4] Bearer documentation
Date: Mon, 10 Jan 2011 14:41:23 +0200
Message-ID: <201101101441.23644.remi.denis-courmont@nokia.com>
In-Reply-To: <4D273DFD.7020408@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4595421666844202716==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Friday 07 January 2011 18:23:25 ext Denis Kenzior, you wrote:
> Hi R=C3=A9mi,
> =

> On 01/07/2011 10:02 AM, R=C3=A9mi Denis-Courmont wrote:
> > ---
> > =

> >  doc/connman-api.txt |   10 ++++++++++
> >  1 files changed, 10 insertions(+), 0 deletions(-)
> > =

> > diff --git a/doc/connman-api.txt b/doc/connman-api.txt
> > index b13efd1..18185d7 100644
> > --- a/doc/connman-api.txt
> > +++ b/doc/connman-api.txt
> > @@ -150,6 +150,16 @@ Properties	boolean Active [readwrite]
> > =

> >  			Holds whether the context is activated.  This value
> >  			can be set to activate / deactivate the context.
> > =

> > +		string Bearer [readonly, optional]
> > +
> > +			Contains the current packet switched bearer of the
> > +			connection context.
> > +
> > +			Possible values are the same as for the Technology
> > +			property the NetworkRegistration object, plus
> > +			"none" if no data activity is ongoing, or "unknown"
> > +			if not known.
> > +
> =

> Please remove this "unknown" bit.  The property is already optional, so
> if it is never reported by the driver we shouldn't report it up, even if
> the context is active.

That would not work. We need some default value otherwise we cannot signal =
the =

change from known to unknown, at least not with the oFono property change =

interface.

-- =

R=C3=A9mi Denis-Courmont
Nokia Devices R&D, Maemo Software, Helsinki

--===============4595421666844202716==--

