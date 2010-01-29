Content-Type: multipart/mixed; boundary="===============7400042750434053654=="
MIME-Version: 1.0
From: Bastian, Waldo <waldo.bastian@intel.com>
Subject: RE: RFC: API for Neighbouring Cell Info
Date: Fri, 29 Jan 2010 13:04:51 -0800
Message-ID: <97D5E1BB8FC13D4EA3B34BAE8E6898C9BACB21CB@orsmsx508.amr.corp.intel.com>
In-Reply-To: <1264752250.19283.773.camel@phoenix.elisa-laajakaista.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7400042750434053654==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> There are two parts to neighbor cell information. The first part
> provides meta-information on the second part, which is the actual
> measurement data.
> =

> Like you propose, the first part is a dict, with keys like cell type and
> current MCC and MNC.
> =

> The second part is the measurement data, and that is different for
> different types of cells. Not all information is mandatory for all
> modems and all cell types.

The formatting might have been a bit confusing, but I was actually proposin=
g  a single property ("Info") containing an array (one entry for each cell)=
 of dicts, with the dicts having measurement and other info on that particu=
lar cell.

> I think the pattern you use here is wrong. This needs to be a method
> call; a signal won't work. The measurement data is constantly changing,
> and you don't want a constant stream of PropertyChanged() signals.

Ok.

> The important property here is that the location system has a single
> method call that retrieves all relevant information from the modem, so
> that they can then do their triangulation magic.

Yes, it's important to keep things atomic.

> > 			int8 RSCP [readonly, UMTS only]
> >
> > 				Received Signal Code Power [3GPP TS 25.133
> s9.1.1.3] in dBm [-120...-25]
> >
> > 			int8 ECNO [readonly, UMTS only]
> >
> > 				CPICH Ec/No [3GPP TS 25.133 s9.1.2.3] in dB  [-
> 24...0]
> =

> This is already part of the measurement data, which I think should be in
> the per-cell information (the serving cell measurement data is still
> measurement data).

Yes, all this is per-cell, sorry if that wasn't clear.

Cheers,
Waldo

--===============7400042750434053654==--

