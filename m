Content-Type: multipart/mixed; boundary="===============3502588497623718538=="
MIME-Version: 1.0
From: Bastian, Waldo <waldo.bastian@intel.com>
Subject: RE: [RFC PATCH 2/5 v2] cell-info: Header file for cell-info atom
Date: Fri, 24 Dec 2010 10:54:45 -0800
Message-ID: <97D5E1BB8FC13D4EA3B34BAE8E6898C9015A323449@orsmsx508.amr.corp.intel.com>
In-Reply-To: <1293010539-9524-3-git-send-email-antti.paila@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3502588497623718538==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> +struct gsm {
> +	int lac;
> +	int ci;
> +	int ta;
> +	int no_cells;
> +	struct geran_neigh_cell{
> +		int arfcn;
> +		int bsic;
> +		int rxlev;
> +
> +	} nmr[OFONO_MAX_NMR_COUNT];
> +};

What about the frequency of the serving cell? I was under the impression th=
at
there was a need for that one as well.

Even though the serving cell may be included already in the nmr, do you see=
 a need =

to explicitly provide the arfcn, bsic and rxlev of the serving cell as well?

What about LAC and CI for the neighbouring cells?

Cheers,
Waldo


--===============3502588497623718538==--

