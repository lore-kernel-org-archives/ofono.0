Content-Type: multipart/mixed; boundary="===============3165031861141194730=="
MIME-Version: 1.0
From: Vijay.Nayani@elektrobit.com
Subject: RE: [RFC PATCH 10/20] doc: add PreferredMode property to modem
Date: Tue, 12 Apr 2011 14:51:08 +0300
Message-ID: <AA48DD8077D5D945A49BD1782C1140F1EBB21B@fioues08.ebgroup.elektrobit.com>
In-Reply-To: <4DA35631.5090906@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3165031861141194730==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Dennis,

> "data centric".
> > +				"PS mode 1"	UE registers only to EPS
> > +						services, and =

> UE's usage setting
> > +						is "voice centric".
> > +
> =

> I don't like that this is being exposed on the modem =

> interface.  This really belongs on a separate atom.  Not all =

> modems are going to be LTE enabled yet...
> =

Preferred mode is modem property on which mode modem is going to
operate.
Currently we have restricted this to read only for below reasons.
1.No proper business case on why would user needs to play around this.
Unless operator give privilege to user to configure the modem behavior.
2.Setting the preferred mode from user side would bring in new API for
driver essentially. =


Regards,
Vijay

> -----Original Message-----
> From: Denis Kenzior [mailto:denkenz(a)gmail.com] =

> Sent: 11 April 2011 22:28
> To: ofono(a)ofono.org
> Cc: Nayani Vijay
> Subject: Re: [RFC PATCH 10/20] doc: add PreferredMode =

> property to modem
> =

> Hi Vijay,
> =

> On 04/11/2011 05:20 AM, Vijay Nayani wrote:
> > ---
> >  doc/modem-api.txt |   18 ++++++++++++++++++
> >  1 files changed, 18 insertions(+), 0 deletions(-)
> > =

> > diff --git a/doc/modem-api.txt b/doc/modem-api.txt index =

> > fa400a2..c79bffa 100644
> > --- a/doc/modem-api.txt
> > +++ b/doc/modem-api.txt
> > @@ -54,6 +54,24 @@ Properties	boolean Powered [readwrite]
> >  			modem. The Emergency is true if an =

> emergency call or
> >  			related operation is currently active.
> >  =

> > +		string PreferredMode [readonly, optional]
> > +
> > +			Preferred UE mode setting. A UE =

> attached for EPS services
> > +			shall operate in one of the following =

> operation modes:
> > +
> > +				"PS mode 2"	UE registers only to EPS
> > +						services, and =

> UE's usage setting
> > +						is "data centric".
> > +				"CS/PS mode 1"	UE registers to =

> both EPS and
> > +						non-EPS =

> services, and UE's usage
> > +						setting is =

> "voice centric".
> > +				"CS/PS mode 2"	UE registers to =

> both EPS and
> > +						non-EPS =

> services, and UE's usage
> > +						setting is =

> "data centric".
> > +				"PS mode 1"	UE registers only to EPS
> > +						services, and =

> UE's usage setting
> > +						is "voice centric".
> > +
> =

> I don't like that this is being exposed on the modem =

> interface.  This really belongs on a separate atom.  Not all =

> modems are going to be LTE enabled yet...
> =

> Have you looked at the IMS/LTE API proposal from Sjur a while back?
> =

> >  		string Name [readonly, optional]
> >  =

> >  			Friendly name of the modem device.
> =

> Regards,
> -Denis
>=20

--===============3165031861141194730==--

