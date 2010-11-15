Content-Type: multipart/mixed; boundary="===============7135416025492630130=="
MIME-Version: 1.0
From: Bastian, Waldo <waldo.bastian@intel.com>
Subject: RE: [PATCH] TODO: Add vCard export to SM/ME stores
Date: Mon, 15 Nov 2010 11:01:48 -0800
Message-ID: <97D5E1BB8FC13D4EA3B34BAE8E6898C90157C37EC1@orsmsx508.amr.corp.intel.com>
In-Reply-To: <1289550575.3266.103.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7135416025492630130==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Marcel wrote:
> > diff --git a/TODO b/TODO
> > index bf2305b..9dcb43f 100644
> > --- a/TODO
> > +++ b/TODO
> > @@ -496,3 +496,14 @@ Miscellaneous
> >  =

> >    Priority: Low
> >    Complexity: C4
> > +
> > +- Enable exporting contact information from vCard data to SM and ME st=
ores.
> > +  Need to implement a robust vCard parser that can extract at least the
> > +  fields supported by the existing phonebook module.  Functionality sh=
ould
> > +  be analoguous to existing import functionality.
> =

> and you will not be able to write a robust vCard parser that we can
> safely run as root or with any kind of ofonod privileges. It is just way
> too risky from a security point of view.
> =

> To support this feature then first we need to convert the current
> feature into returning a dict. And then have this feature using a dict
> as input.

Does this mean that support for writing to the phonebook is expected to
be added to the phonebook modem API as part of ofono core functionality?

Cheers,
Waldo


--===============7135416025492630130==--

