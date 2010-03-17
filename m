Content-Type: multipart/mixed; boundary="===============8639470928862402611=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: Re: [patch 3/6] LCP support
Date: Wed, 17 Mar 2010 11:59:30 -0700
Message-ID: <20100317115930.6643ea73@kcaccard-MOBL3>
In-Reply-To: <1268809765.2700.104.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8639470928862402611==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 17 Mar 2010 00:09:25 -0700
Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi Kristen,
> =

> >  Makefile.am               |    6 -
> >  gatchat/gatppp.c          |   53 +++++++++
> >  gatchat/gatppp_internal.h |    8 +
> >  gatchat/gatppplcp.c       |  244 +++++++++++++++++++++++++++++++++++++=
+++++++++
> =

> this should be gatchat/ppp_lcp.c
> =

> > +void __ppp_set_auth(GAtPPP *ppp, guint8* auth_data)
> > +{
> > +	guint16 proto =3D ntohs(*(guint16 *)auth_data);
> =

> This are again one of these constructs that will break on non-x86
> hardware.
> =

> I think you need to create ppp_get_unaligned and ppp_put_unaligned. If
> all of them are be16 anyway, you could do ppp_get_unaligned_be16 etc.
> =

> Regards
> =

> Marcel

Would it make more sense to pack the structures that are meant to
represent bytes off the wire?  I personally prefer that to making
a different function for be vs. le.  But I am not sure if we can
assume we are using gcc and have __attribute__((packed)) support?

--===============8639470928862402611==--

