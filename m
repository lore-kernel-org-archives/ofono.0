Content-Type: multipart/mixed; boundary="===============0200247062206147169=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: [PATCH] TODO: Add vCard export to SM/ME stores
Date: Sat, 13 Nov 2010 00:11:10 +0900
Message-ID: <1289574670.3266.112.camel@aeonflux>
In-Reply-To: <6E42A1B4DD2F7B4D80A1F26BB498BF9F8C9A039CBD@irsmsx501.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0200247062206147169==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jaakko,

> > To support this feature then first we need to convert the current
> > feature into returning a dict. And then have this feature using a dict
> > as input.
> =

> Is there already a specification/draft of the format of this dict? If not=
, I would be tempted to use the 27.007 +CPBR/W field names as keys (e.g. in=
dex, number, type, text, adnumber, secondtext, sip_uri, etc.)

there is not. So you need to propose one here.

> I'm assuming you would then want to have "aa{ss} Import(void)" to import =
and array of contact info dicts from all stores, and respectively "void Exp=
ort(s, aa{ss})" to export one or more contact info dicts to a specified sto=
re?

It would be "aa{sv} Import()" since I want a proper dict with sv and not
just ss. Also "Export(aa{sv})" since it is all or nothing. The export
would delete any other entries in the phonebook.

And let me be pretty clear here. Writing a phonebook to the SIM is still
stupid. It is fully pointless in a modern smartphone. The only reason
why we would be merging such a feature upstream is for weird Chinese
type approval and nothing else.

Any UI designer that thinks exposing this is a good idea, should find
himself/herself a new job ;)

Regards

Marcel



--===============0200247062206147169==--

