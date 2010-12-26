Content-Type: multipart/mixed; boundary="===============8075401421596788035=="
MIME-Version: 1.0
From: Antti Paila <antti.paila@nokia.com>
Subject: RE: [RFC PATCH 2/5 v2] cell-info: Header file for cell-info atom
Date: Sun, 26 Dec 2010 15:57:43 +0200
Message-ID: <1293371863.2368.36.camel@apaila-ThinkPad-T410>
In-Reply-To: <97D5E1BB8FC13D4EA3B34BAE8E6898C9015A323449@orsmsx508.amr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8075401421596788035==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Waldo,

On Fri, 2010-12-24 at 10:54 -0800, ext Bastian, Waldo wrote:
> > +struct gsm {
> > +	int lac;
> > +	int ci;
> > +	int ta;
> > +	int no_cells;
> > +	struct geran_neigh_cell{
> > +		int arfcn;
> > +		int bsic;
> > +		int rxlev;
> > +
> > +	} nmr[OFONO_MAX_NMR_COUNT];
> > +};
> =

> What about the frequency of the serving cell? I was under the impression =
that
> there was a need for that one as well.
> =

> Even though the serving cell may be included already in the nmr, do you s=
ee a need =

> to explicitly provide the arfcn, bsic and rxlev of the serving cell as we=
ll?

Serving cell frequency is, or should be, included in the nmr list in the
arfcn variable. I believe the arfcn, bsic and rxlev are needed for all
cells since this information is used for location determination.

> What about LAC and CI for the neighbouring cells?

As far as I know, the neighbor cell info in the above-mentioned form is
used for location specific purposes. Hence, bsic suffices to identify
base station and rxlev gives the unscaled distance from it.

If there is a reason for including LAC and CI for neighboring cells, we
can add them to the list. In that case we should probably modify the
DBUS method list to include one method for requesting location data and
another method for general identity data.

Best Regards,
  Antti =



--===============8075401421596788035==--

