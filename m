Content-Type: multipart/mixed; boundary="===============6281693655626576386=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: Re: RFC: Neighbouring Cell Info, take 2
Date: Thu, 11 Feb 2010 09:52:09 +0200
Message-ID: <1265874729.2210.9.camel@phoenix.elisa-laajakaista.fi>
In-Reply-To: <97D5E1BB8FC13D4EA3B34BAE8E6898C9BD5781EA@orsmsx508.amr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6281693655626576386==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

to, 2010-02-11 kello 01:23 +0100, ext Bastian, Waldo kirjoitti:
> Revisited proposal for neighbouring cell info based on previous
> feedback:
> - Low-level driver API instead of oFono.org DBUS API =

> - Polling based, no automatic periodic updates
> - Follows definitions in OMA SUPL v2.0

I like it.

> I'm not particular fond of the nested list -> wcdma.
> measured_results_list[].cell_measured_results[], maybe flatten that
> into a single list?

I agree it's ugly, but I'd keep it like that in the driver API, and
possibly flatten it in the D-Bus API if necessary.

> struct ofono_cell_info_driver {
> 	const char *name;
> 	int (*probe)(struct ofono_cell_info *ci, unsigned int vendor,
> 			void *data);
> 	void (*remove)(struct ofono_cell_info *ci);
> 	void (*query)(struct ofono_cell_info *ci,
> 			ofono_cell_info_query_cb_t cb,
> 			void *data);
> };
> =

> void ofono_cell_info_query(struct ofono_cell_info *ci, ofono_cell_info_qu=
ery_cb_t cb, void *data);

What's this for?

Cheers,
Aki


--===============6281693655626576386==--

