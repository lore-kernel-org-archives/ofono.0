Content-Type: multipart/mixed; boundary="===============3053295022073607695=="
MIME-Version: 1.0
From: Bastian, Waldo <waldo.bastian@intel.com>
Subject: RE: RFC: Neighbouring Cell Info, take 2
Date: Thu, 11 Feb 2010 11:25:49 -0800
Message-ID: <97D5E1BB8FC13D4EA3B34BAE8E6898C9BD651580@orsmsx508.amr.corp.intel.com>
In-Reply-To: <1265874729.2210.9.camel@phoenix.elisa-laajakaista.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3053295022073607695==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> > struct ofono_cell_info_driver {
> > 	const char *name;
> > 	int (*probe)(struct ofono_cell_info *ci, unsigned int vendor,
> > 			void *data);
> > 	void (*remove)(struct ofono_cell_info *ci);
> > 	void (*query)(struct ofono_cell_info *ci,
> > 			ofono_cell_info_query_cb_t cb,
> > 			void *data);
> > };
> >
> > void ofono_cell_info_query(struct ofono_cell_info *ci,
> ofono_cell_info_query_cb_t cb, void *data);
> =

> What's this for?

It's basically ofono_cell_info_driver->query(...) for use by a plugin after=
 it has acquired the atom, something like:
cell_info_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_CELL_INFO=
);
cell_info =3D __ofono_atom_get_data(cell_info_atom);
ofono_cell_info_query(cell_info, plugin_query_cb, plugin_data);

Cheers,
Waldo

--===============3053295022073607695==--

