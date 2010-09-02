Content-Type: multipart/mixed; boundary="===============4084436605275340541=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 4/4] Add documentation for the Alphabet property
Date: Thu, 02 Sep 2010 14:19:18 -0400
Message-ID: <1283451558.6640.6.camel@localhost.localdomain>
In-Reply-To: <4C7FD87E.8040905@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4084436605275340541==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> >  doc/message-api.txt |   15 +++++++++++++++
> >  1 files changed, 15 insertions(+), 0 deletions(-)
> > =

> > diff --git a/doc/message-api.txt b/doc/message-api.txt
> > index 693a111..9e8ea33 100644
> > --- a/doc/message-api.txt
> > +++ b/doc/message-api.txt
> > @@ -64,3 +64,18 @@ Properties	string ServiceCenterAddress
> >  				"ps-preferred" - Use CS if PS is unavailable
> >  =

> >  			By default oFono uses "cs-preferred" setting.
> > +
> > +		string Alphabet
> > +
> > +			Contains the alphabet setting for outgoing SMSs.
> > +			Possible values are:
> > +
> > +				"default" - Default GSM alphabet
> > +				"turkish" - Turkish alphabet
> > +				"spanish" - Spanish alphabet
> > +				"portuguese" - Portuguese alphabet
> > +				"reduced" - Non-standard extension that adds
> > +					translit support to the default alphabet
> > +
> > +			The standard, language-specific alphabets are defined in
> > +			3GPP TS23.038, Annex A.
> =

> I want to hear everyone's thoughts on whether this should be in
> ofono/main.conf or an actual property.  We still never decides this...

so the general rule is that if it is exposed in the UI, then it needs to
be a D-Bus API. If it is manufacturer/integrator specific then this
should be in main.conf (to be created of course). There might be
exception here and there, but that is the general rule.

If we think we wanna expose this inside the UI, then of course we have
to ask ourselves if this is something a user should be really exposed
to. So this needs use cases and justification for it.

Regards

Marcel



--===============4084436605275340541==--

