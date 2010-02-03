Content-Type: multipart/mixed; boundary="===============5078093871447630592=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/3] Add radio access atom and driver API
Date: Tue, 02 Feb 2010 22:02:31 -0600
Message-ID: <201002022202.31945.denkenz@gmail.com>
In-Reply-To: <97D5E1BB8FC13D4EA3B34BAE8E6898C9BAD63EF8@orsmsx508.amr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5078093871447630592==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Waldo,

> > > This atom provides access to the modem's radio access properties. It
> > > currently includes a single rw property, namely the radio access
> > > selection mode setting.
> >
> > It might be helpful to include the API documentation too.  One thing I
> > don't like is the name RadioAccess.  The connotation is a bit too
> > low-level. Perhaps BandSelection? RadioBandSelection?
> =

> Radio access is a pretty broad high level concept. It's one of those black
>  boxes you draw somewhere near the bottom of a phone architecture diagram,
>  so in that sense it is low-level but that comes with the territory.
>  BandSelection in my mind implies frequency band selection, which is a
>  narrow aspect of radio access. The 2G/3G selection covered with this pat=
ch
>  is about radio access _technology_, which is distinct from the actual
>  frequency bands used by those technologies. I think RadioAccess is a
>  fairly good name for an interface that has the potential to cover various
>  radio related settings.

People on this list keep forgetting two things:
1. We're not designing a kitchen sink API here.  Most of the 'radio related =

settings' will simply never be exposed, nobody really cares what UMTS chann=
el =

he/she is currently on.
2. We're designing the API to be easy to use for everyone, not just GSM gee=
ks.

In your AM/FM Tuner the 'Band' button switches between AM and FM.  You =

immediately know what the button does.  The interface name in oFono should =

ideally give the user an immediate idea of what it is for.  In my view =

"RadioAccess" does not fit this ideal.  Perhaps "BandSelection" is the wron=
g =

name too, lets come up with a better one.

Regards,
-Denis

--===============5078093871447630592==--

