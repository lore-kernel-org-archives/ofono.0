Content-Type: multipart/mixed; boundary="===============5194009789222754611=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: [PATCH] TODO: Add vCard export to SM/ME stores
Date: Mon, 15 Nov 2010 20:38:21 +0100
Message-ID: <1289849901.29148.4.camel@aeonflux>
In-Reply-To: <97D5E1BB8FC13D4EA3B34BAE8E6898C90157C37EC1@orsmsx508.amr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5194009789222754611==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Waldo,

> > To support this feature then first we need to convert the current
> > feature into returning a dict. And then have this feature using a dict
> > as input.
> =

> Does this mean that support for writing to the phonebook is expected to
> be added to the phonebook modem API as part of ofono core functionality?

actually no. General writing of the SIM phonebook will not be supported.

However support for allowing to write an ENTIRE phonebook back to the
SIM card (export) might be added. The emphasis here is clearly on fully
replacing an existing SIM phonebook.

It is the complement of the import function to potentially deal with
Chinese type approval. It is not a functionality that should be
considered for general use. The SIM phonebook is still a pointless
concept these days. Any UI designer wanting to expose this in a moden
smartphone needs to go back to the drawing board.

Regards

Marcel



--===============5194009789222754611==--

