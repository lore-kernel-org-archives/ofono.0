Content-Type: multipart/mixed; boundary="===============8100697130451084407=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: Ofono and BT interaction
Date: Thu, 09 Sep 2010 18:59:40 +0200
Message-ID: <1284051580.20451.7.camel@aeonflux.t-mobile.de>
In-Reply-To: <2A84145621092446B6659B8A0F28E26F46D581ED94@irsmsx501.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8100697130451084407==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Emmanuel,

this is an open source mailing list, so please use proper netiquette and
do NOT top post. No ever exceptions.

> It's a good solution for ofono clients, but ofono will still dialogue wit=
h BT Modem (init), which is not very desirable.

If you power on the HFP modem. If not, then oFono will do nothing. You
can always start ofonod with -P hfp and then the HFP support should be
ignored. At least that works for testing.

Regards

Marcel



--===============8100697130451084407==--

