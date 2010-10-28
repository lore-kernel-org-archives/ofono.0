Content-Type: multipart/mixed; boundary="===============8223324329320458129=="
MIME-Version: 1.0
From: Rajesh.Nagaiah@elektrobit.com
Subject: RE: [PATCH 1/4] doc: Add ModemAccessTechnology property
Date: Thu, 28 Oct 2010 14:32:56 -0700
Message-ID: <C681C76E0D5F1E4BB01DE79E0A80EEC702BC7128@usrdes03.ebgroup.elektrobit.com>
In-Reply-To: <1288261617.3322.7.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8223324329320458129==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel, =

 =

> Hi Rajesh,
> =

> >  doc/modem-api.txt |    9 +++++++++
> >  1 files changed, 9 insertions(+), 0 deletions(-)
> > =

> > diff --git a/doc/modem-api.txt b/doc/modem-api.txt index =

> > c48375e..f5a3026 100644
> > --- a/doc/modem-api.txt
> > +++ b/doc/modem-api.txt
> > @@ -43,6 +43,15 @@ Properties	boolean Powered [readwrite]
> >  			modem. The Emergency is true if an =

> emergency call or
> >  			related operation is currently active.
> >  =

> > +		string ModemAccessTechnology [readonly]
> > +
> > +			Contains current access techonology of =

> the modem.
> > +			Possible values are:
> > +			"gsm" - the current modem access =

> technology is GSM
> > +			"cdma" - the current modem access =

> technology is CDMA
> > +
> > +			By default oFono uses "gsm" setting.
> > +
> =

> so you are in the org.ofono.Modem interface and its =

> properties and you wanna prefix the property with "Modem". =

> That is rather pointless duplication of information. So just =

> strip that.

I prefix it with Modem just not to mix with the Network Access
Technology. From the property name prespective I agree with you, its an
redundant info as we are in org.ofono.Modem interface

> The obvious question we have to discuss, if we really wanna =

> do it this way. What are the pros and what are the cons?

I quite didnt get this query, pros and cons about this property usage or
?

BR,
Rajesh

--===============8223324329320458129==--

