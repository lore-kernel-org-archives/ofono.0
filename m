Content-Type: multipart/mixed; boundary="===============2844852379368009838=="
MIME-Version: 1.0
From: Bastian, Waldo <waldo.bastian@intel.com>
Subject: RE: [PATCH 1/3] Add radio access atom and driver API
Date: Tue, 02 Feb 2010 18:35:38 -0800
Message-ID: <97D5E1BB8FC13D4EA3B34BAE8E6898C9BAD63EF8@orsmsx508.amr.corp.intel.com>
In-Reply-To: <201002021804.04244.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2844852379368009838==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> > This atom provides access to the modem's radio access properties. It
> > currently includes a single rw property, namely the radio access
> > selection mode setting.
> =

> It might be helpful to include the API documentation too.  One thing I
> don't like is the name RadioAccess.  The connotation is a bit too
> low-level. Perhaps BandSelection? RadioBandSelection?

Radio access is a pretty broad high level concept. It's one of those black =
boxes you draw somewhere near the bottom of a phone architecture diagram, s=
o in that sense it is low-level but that comes with the territory. BandSele=
ction in my mind implies frequency band selection, which is a narrow aspect=
 of radio access. The 2G/3G selection covered with this patch is about radi=
o access _technology_, which is distinct from the actual frequency bands us=
ed by those technologies. I think RadioAccess is a fairly good name for an =
interface that has the potential to cover various radio related settings.

Use case for 2G/3G selection:
http://androidcommunity.com/forums/archive/index.php/t-11857.html

Use case for band selection:
http://support.t-mobile.com/doc/tm53294.xml?docid=3D5222&referring%20topici=
d=3D67&A2L.SERVICE=3D&Referring%20TopicID/DocID%20List%20Index=3Dy&navtypei=
d=3D2&pagetypeid=3D26&prevPageIndex=3D3

Cheers,
Waldo

--===============2844852379368009838==--

