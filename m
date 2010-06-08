Content-Type: multipart/mixed; boundary="===============4802951043670868994=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
Subject: Re: [RFC patches 03/13] documentation: add note about referencing
 standards
Date: Tue, 08 Jun 2010 22:01:21 +0000
Message-ID: <1276034748.2478.42.camel@localhost.localdomain>
In-Reply-To: <1275055983.4706.73.camel@aeonflux.t-mobile.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4802951043670868994==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2010-05-28 at 07:13 -0700, Marcel Holtmann wrote: =

> Hi Inaky,
> =

> > From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
> > =

> > ---
> >  doc/standards.txt |    8 ++++++++
> >  1 files changed, 8 insertions(+), 0 deletions(-)
> >  create mode 100644 doc/standards.txt
> > =

> > diff --git a/doc/standards.txt b/doc/standards.txt
> > new file mode 100644
> > index 0000000..c4b68eb
> > --- /dev/null
> > +++ b/doc/standards.txt
> > @@ -0,0 +1,8 @@
> > +Referencing standards in the source
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +When referencing standard documents use raw numbers xx.xxx for 3GPP
> > +documents or xxx.xxx for ETSI document (eg: 23.040). If needing to
> > +point to an specific section/subsection, explicitly say "Section foo"
> > +
> > +3GPP specs can be found in http://3gpp.org/ftp/Specs.
> =

> would this not better fit into HACKING document. I don't really have a
> strong opinion here. Just asking.

This was Denis' request to have it as separate. I think initially I had
put it on HACKING or README? It fits me in any, as long as it is easy to
find.


--===============4802951043670868994==--

