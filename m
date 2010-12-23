Content-Type: multipart/mixed; boundary="===============0056594042030000803=="
MIME-Version: 1.0
From: Antti Paila <antti.paila@nokia.com>
Subject: RE: [RFC PATCH 2/5 v2] cell-info: Header file for cell-info atom
Date: Thu, 23 Dec 2010 09:14:02 +0200
Message-ID: <1293088442.22770.53.camel@apaila-ThinkPad-T410>
In-Reply-To: <1A42CE6F5F474C41B63392A5F80372B231C6CC0F@shsmsx501.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0056594042030000803==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jun,

On Thu, 2010-12-23 at 14:31 +0800, ext Wei, Jun wrote:
> Hi Antti,
> =

> On Wed, 2010-12-22 at 11:35 +0200, ext Antti Paila wrote:
> > ---
> >  include/cell-info.h |  133 =

> > +++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 files changed, 133 insertions(+), 0 deletions(-)  create mode =

> > 100644 include/cell-info.h
> > =

> > diff --git a/include/cell-info.h b/include/cell-info.h new file mode =

> > 100644 index 0000000..3941e69
> > --- /dev/null
> > +++ b/include/cell-info.h
> > @@ -0,0 +1,133 @@
> > +/*
> >  ...
> >  ...
> >  ...
> > +struct ofono_cell_info_driver {
> > +	const char *name;
> > +	int (*probe)(struct ofono_cell_info *ci,
> > +			unsigned int vendor,
> > +			void *data);
> > +	void (*remove)(struct ofono_cell_info *ci);
> > +	void (*query)(struct ofono_cell_info *ci,
> > +			ofono_cell_info_query_cb_t,
> > +			void *data);
> > +};
> > +
> =

> To be aligning with the other header files, do we need to add one 'cb' af=
ter 'ofono_cell_info_query_cb_t' here?

This seems to be a matter with no clear convention. In "sms.h" and
"netreg.h" some callbacks have 'cb' and some not. I agree that if within
a function's parameter list some parameters have name declared, so
should all have.

Thanks for the comment.

Best Regards,
  Antti  =



--===============0056594042030000803==--

