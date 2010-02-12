Content-Type: multipart/mixed; boundary="===============0046945430690973180=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: RE: RFC: Neighbouring Cell Info, take 2
Date: Fri, 12 Feb 2010 10:26:32 +0200
Message-ID: <1265963192.2241.4.camel@phoenix.elisa-laajakaista.fi>
In-Reply-To: <97D5E1BB8FC13D4EA3B34BAE8E6898C9BD651580@orsmsx508.amr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0046945430690973180==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

to, 2010-02-11 kello 20:25 +0100, ext Bastian, Waldo kirjoitti:
> > > void ofono_cell_info_query(struct ofono_cell_info *ci,
> > ofono_cell_info_query_cb_t cb, void *data);
> > =

> > What's this for?
> =

> It's basically ofono_cell_info_driver->query(...) for use by a plugin aft=
er it has acquired the atom, something like:
> cell_info_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_CELL_IN=
FO);
> cell_info =3D __ofono_atom_get_data(cell_info_atom);
> ofono_cell_info_query(cell_info, plugin_query_cb, plugin_data);

Right, but if the atom already exposes a D-Bus API, what is the purpose
of this plugin interface?

Cheers,
Aki


--===============0046945430690973180==--

