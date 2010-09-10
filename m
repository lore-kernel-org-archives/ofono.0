Content-Type: multipart/mixed; boundary="===============0982178369239150898=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: Ofono and BT interaction
Date: Fri, 10 Sep 2010 10:07:25 +0200
Message-ID: <1284106045.20451.10.camel@aeonflux.t-mobile.de>
In-Reply-To: <2A84145621092446B6659B8A0F28E26F46D581EE20@irsmsx501.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0982178369239150898==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Emmanuel,

> > this is an open source mailing list, so please use proper netiquette and
> > do NOT top post. No ever exceptions.
> =

> Oops, sorry for that.
> =

> > If you power on the HFP modem. If not, then oFono will do nothing.
> =

> Yes, that's one solution. How to do that at BlueZ level?

no idea actually.

> > You can always start ofonod with -P hfp and then the HFP support should=
 be
> > ignored. At least that works for testing.
> =

> Very interesting.
> I've not found "-P" option in ofono 0.25, nor in the last 0.28 source tre=
e.
> Did I miss something?

No you didn't. It is a ConnMan feature that we never ported over to
oFono. Not a big deal to add, but so far nobody did the work.

Regards

Marcel



--===============0982178369239150898==--

