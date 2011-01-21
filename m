Content-Type: multipart/mixed; boundary="===============8987456823723126181=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: Re: [PATCH] doc: Add modem Type property
Date: Fri, 21 Jan 2011 18:25:05 -0200
Message-ID: <20110121202505.GG2400@joana>
In-Reply-To: <4D39E972.5060305@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8987456823723126181==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

* Denis Kenzior <denkenz@gmail.com> [2011-01-21 14:15:46 -0600]:

> Hi Dara,
> =

> On 01/20/2011 04:48 PM, Dara Spieker-Doyle wrote:
> > Add support for providing the type of the attached modem device
> > including GSM (3GPP), CDMA (3GPP2) and Bluetooth HFP.
> > ---
> >  doc/modem-api.txt |   13 +++++++++++++
> >  1 files changed, 13 insertions(+), 0 deletions(-)
> > =

> > diff --git a/doc/modem-api.txt b/doc/modem-api.txt
> > index 45043b0..fe806c8 100644
> > --- a/doc/modem-api.txt
> > +++ b/doc/modem-api.txt
> > @@ -82,6 +82,19 @@ Properties	boolean Powered [readwrite]
> >  =

> >  			This is usually obtained by using the +CGSN AT command.
> >  =

> > +		string Type [readonly, optional, experimental]
> > +
> > +			String representing the type of the modem device.
> > +
> > +			The possible values are:
> > +				"gsm" 	Modem supports one or more of the 3GPP
> > +					family of technologies including GSM,
> > +					EDGE, UMTS, HSPA, LTE.
> > +				"cdma"  Modem supports one or more of the 3GPP2
> > +					family of technologies including CDMA 1x,
> > +					EVDO.
> > +				"hfp"	Bluetooth hands-free profile (HFP) modem
> > +
> =

> So one pointed question:
> =

> How are we planning to support dual-mode devices with this property?  I
> believe during the CDMA workshop we decided that the clients should
> simply look at the set of interfaces, not a semi-static property...

We can have a value that is "gsm & cdma". This fits for now, but won't scal=
e. =

And this list won't increase in the near future I think.

-- =

Gustavo F. Padovan
http://profusion.mobi

--===============8987456823723126181==--

