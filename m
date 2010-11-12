Content-Type: multipart/mixed; boundary="===============8901011387643032222=="
MIME-Version: 1.0
From: Kiviluoto, Jaakko J <jaakko.j.kiviluoto@intel.com>
Subject: RE: [PATCH] TODO: Add vCard export to SM/ME stores
Date: Fri, 12 Nov 2010 10:05:02 +0000
Message-ID: <6E42A1B4DD2F7B4D80A1F26BB498BF9F8C9A039CBD@irsmsx501.ger.corp.intel.com>
In-Reply-To: <1289550575.3266.103.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8901011387643032222==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> > diff --git a/TODO b/TODO
> > index bf2305b..9dcb43f 100644
> > --- a/TODO
> > +++ b/TODO
> > @@ -496,3 +496,14 @@ Miscellaneous
> >
> >    Priority: Low
> >    Complexity: C4
> > +
> > +- Enable exporting contact information from vCard data to SM and ME
> stores.
> > +  Need to implement a robust vCard parser that can extract at least
> the
> > +  fields supported by the existing phonebook module.  Functionality
> should
> > +  be analoguous to existing import functionality.
> =

> and you will not be able to write a robust vCard parser that we can
> safely run as root or with any kind of ofonod privileges. It is just
> way
> too risky from a security point of view.

Got it. (I do have a parser implementation 95% ready just in case you're wi=
lling to try this another time.)

> To support this feature then first we need to convert the current
> feature into returning a dict. And then have this feature using a dict
> as input.

Is there already a specification/draft of the format of this dict? If not, =
I would be tempted to use the 27.007 +CPBR/W field names as keys (e.g. inde=
x, number, type, text, adnumber, secondtext, sip_uri, etc.)

I'm assuming you would then want to have "aa{ss} Import(void)" to import an=
d array of contact info dicts from all stores, and respectively "void Expor=
t(s, aa{ss})" to export one or more contact info dicts to a specified store?

Jaakko

---------------------------------------------------------------------
Intel Finland Oy
Registered Address: PL 281, 00181 Helsinki =

Business Identity Code: 0357606 - 4 =

Domiciled in Helsinki =


This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


--===============8901011387643032222==--

