Content-Type: multipart/mixed; boundary="===============2969017914680822847=="
MIME-Version: 1.0
From: Bastian, Waldo <waldo.bastian@intel.com>
Subject: RE: RFC: Neighbouring Cell Info, take 2
Date: Fri, 12 Feb 2010 08:03:19 -0800
Message-ID: <97D5E1BB8FC13D4EA3B34BAE8E6898C9BD6519C3@orsmsx508.amr.corp.intel.com>
In-Reply-To: <1265963192.2241.4.camel@phoenix.elisa-laajakaista.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2969017914680822847==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> to, 2010-02-11 kello 20:25 +0100, ext Bastian, Waldo kirjoitti:
> > > > void ofono_cell_info_query(struct ofono_cell_info *ci,
> > > ofono_cell_info_query_cb_t cb, void *data);
> > >
> > > What's this for?
> >
> > It's basically ofono_cell_info_driver->query(...) for use by a plugin
> after it has acquired the atom, something like:
> > cell_info_atom =3D __ofono_modem_find_atom(modem,
> OFONO_ATOM_TYPE_CELL_INFO);
> > cell_info =3D __ofono_atom_get_data(cell_info_atom);
> > ofono_cell_info_query(cell_info, plugin_query_cb, plugin_data);
> =

> Right, but if the atom already exposes a D-Bus API, what is the purpose
> of this plugin interface?

It's either a D-Bus API or a plugin interface and Denis indicated a prefere=
nce for a plugin interface over a D-Bus API. I think his main concern was o=
ver the maturity of the API, so maybe he can be pursuaded otherwise now tha=
t this is based off the OMA SUPL standard.

Cheers,
Waldo

--===============2969017914680822847==--

