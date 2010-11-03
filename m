Content-Type: multipart/mixed; boundary="===============6860710939207154201=="
MIME-Version: 1.0
From: Bastian, Waldo <waldo.bastian@intel.com>
Subject: RE: [RFC] AGPS Support
Date: Wed, 03 Nov 2010 11:59:12 -0700
Message-ID: <97D5E1BB8FC13D4EA3B34BAE8E6898C9011B7BFECE@orsmsx508.amr.corp.intel.com>
In-Reply-To: <1288780795.9615.44.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6860710939207154201==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> > For other modems sending the raw RRC/RRLP frames I guess the transcodin=
g to XML
> > would need to happen in the ofono driver or in ofono core if you want
> > to expose an
> > oFono XML API.

> so here is my take on XML. If we have to parse it, then in general that
> is a bad idea. Creating XML is just fine.

You need both as it's not only a matter of converting the raw RRC/RRLP fram=
es from
the modem to XML, but the responses from the GPS engine are presumably in X=
ML format as well
then and the modem driver would need to parse that and re-create RRC/RRLP f=
rames again (for modem that expects raw RRC/RRLP frames). See the tables in=
 section 8.55 of 27.007 for the XML schemas. It refers to the ASN.1 syntax =
for the definition of the value ranges.

Cheers,
Waldo

--===============6860710939207154201==--

