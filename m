Content-Type: multipart/mixed; boundary="===============5589546348566069425=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: [RFC PATCH 2/5 v2] cell-info: Header file for cell-info atom
Date: Thu, 23 Dec 2010 07:02:14 -0800
Message-ID: <1293116534.9439.18.camel@aeonflux>
In-Reply-To: <1293088442.22770.53.camel@apaila-ThinkPad-T410>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5589546348566069425==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antti,

> > > ---
> > >  include/cell-info.h |  133 =

> > > +++++++++++++++++++++++++++++++++++++++++++++++++++
> > >  1 files changed, 133 insertions(+), 0 deletions(-)  create mode =

> > > 100644 include/cell-info.h
> > > =

> > > diff --git a/include/cell-info.h b/include/cell-info.h new file mode =

> > > 100644 index 0000000..3941e69
> > > --- /dev/null
> > > +++ b/include/cell-info.h
> > > @@ -0,0 +1,133 @@
> > > +/*
> > >  ...
> > >  ...
> > >  ...
> > > +struct ofono_cell_info_driver {
> > > +	const char *name;
> > > +	int (*probe)(struct ofono_cell_info *ci,
> > > +			unsigned int vendor,
> > > +			void *data);
> > > +	void (*remove)(struct ofono_cell_info *ci);
> > > +	void (*query)(struct ofono_cell_info *ci,
> > > +			ofono_cell_info_query_cb_t,
> > > +			void *data);
> > > +};
> > > +
> > =

> > To be aligning with the other header files, do we need to add one 'cb' =
after 'ofono_cell_info_query_cb_t' here?
> =

> This seems to be a matter with no clear convention. In "sms.h" and
> "netreg.h" some callbacks have 'cb' and some not. I agree that if within
> a function's parameter list some parameters have name declared, so
> should all have.

we are trying to be consistent, but some of these slipped through in the
initial development phase of oFono.

Once we find them, we document them in doc/coding-style.txt and then
slowly start fixing these up. This is an ongoing process and pretty hard
if your codebase reaches over 100k lines of code.

Regards

Marcel



--===============5589546348566069425==--

