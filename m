Content-Type: multipart/mixed; boundary="===============6328803704645104722=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: Re: [PATCH 02/10] Distinguish HSDPA,
 HSUPA or both as access technologies
Date: Tue, 11 Jan 2011 10:54:33 +0200
Message-ID: <201101111054.34118.remi.denis-courmont@nokia.com>
In-Reply-To: <1294706366.3873.8.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6328803704645104722==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tuesday 11 January 2011 02:39:26 ext Marcel Holtmann, you wrote:
> Hi Remi,
> =

> >  src/common.c |    4 ++--
> >  1 files changed, 2 insertions(+), 2 deletions(-)
> > =

> > diff --git a/src/common.c b/src/common.c
> > index 4d93488..d4e567b 100644
> > --- a/src/common.c
> > +++ b/src/common.c
> > @@ -702,9 +702,9 @@ const char *registration_tech_to_string(int tech)
> > =

> >  	case ACCESS_TECHNOLOGY_GSM_EGPRS:
> >  		return "edge";
> >  	=

> >  	case ACCESS_TECHNOLOGY_UTRAN_HSDPA:
> > -		return "hspa";
> > +		return "hsdpa";
> > =

> >  	case ACCESS_TECHNOLOGY_UTRAN_HSUPA:
> > -		return "hspa";
> > +		return "hsupa";
> > =

> >  	case ACCESS_TECHNOLOGY_UTRAN_HSDPA_HSUPA:
> >  		return "hspa";
> >  	=

> >  	case ACCESS_TECHNOLOGY_EUTRAN:
> what happens here on the CS interface. Will we ever see anything else
> than UMTS indication on CS and the extra ones are purely for PS or how
> is this expected?

Yeah, that's how I interpret CREG and CGREG. But ultimately, it depends how =

the modem vendors interpret it, not how I interpret it...

> The second question is why do we bother with the difference between
> uplink and downlink speed. The user just cares about HSxPA in general
> and that is why these three have been combined.

I have seen requirements to distinguish them. If you don't care and only wa=
nt =

to show 3.5G for all of them, it's still easy to match hs.?pa

-- =

R=C3=A9mi Denis-Courmont
Nokia Devices R&D, Maemo Software, Helsinki

--===============6328803704645104722==--

