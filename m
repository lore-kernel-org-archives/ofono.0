Content-Type: multipart/mixed; boundary="===============1638635801604346236=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: [RFC] AGPS Support
Date: Wed, 03 Nov 2010 20:04:36 +0100
Message-ID: <1288811076.9615.58.camel@aeonflux>
In-Reply-To: <97D5E1BB8FC13D4EA3B34BAE8E6898C9011B7BFECE@orsmsx508.amr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1638635801604346236==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Waldo,

> > > For other modems sending the raw RRC/RRLP frames I guess the transcod=
ing to XML
> > > would need to happen in the ofono driver or in ofono core if you want
> > > to expose an
> > > oFono XML API.
> =

> > so here is my take on XML. If we have to parse it, then in general that
> > is a bad idea. Creating XML is just fine.
> =

> You need both as it's not only a matter of converting the raw RRC/RRLP fr=
ames from
> the modem to XML, but the responses from the GPS engine are presumably in=
 XML format as well
> then and the modem driver would need to parse that and re-create RRC/RRLP=
 frames again (for modem that expects raw RRC/RRLP frames). See the tables =
in section 8.55 of 27.007 for the XML schemas. It refers to the ASN.1 synta=
x for the definition of the value ranges.

and so is parsing of ASN.1 actually. Since oFono core will not look into
this and treat it as a stream of bytes, we will have to make one modem
vendor suffer more than others.

So what is useful for the applications using this D-Bus based API?

Regards

Marcel



--===============1638635801604346236==--

