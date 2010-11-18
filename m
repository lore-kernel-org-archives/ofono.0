Content-Type: multipart/mixed; boundary="===============1492562347219368423=="
MIME-Version: 1.0
From: Bastian, Waldo <waldo.bastian@intel.com>
Subject: RE: [PATCH] ifxmodem: Adding fast dormancy support to Infineon modem
Date: Thu, 18 Nov 2010 12:18:30 -0800
Message-ID: <97D5E1BB8FC13D4EA3B34BAE8E6898C90157D0A819@orsmsx508.amr.corp.intel.com>
In-Reply-To: <CB28AA307186A940B1253A743EA1F20AA60D6C5B@orsmsx507.amr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1492562347219368423==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> According to the doc I have, modem implementation is quite close:
> =

> "Trigger Fast Dormancy +XFDOR
> This command triggers fast dormancy if all conditions are passed successf=
ul it will be send =

> towards the network. There will be no confirmation if the request was exe=
cuted or not as in the =

> last extend the full execution belongs to the network."

+XFDOR triggers fast dormancy once iff conditions are suitable. oFono expec=
ts a mode where
fast dormancy is triggered automatically by the modem _anytime_ conditions =
have been suitable for the duration of a given timeout period. A command fo=
r such mode is not yet available in IFX FW as far as I know.

Cheers,
Waldo

--===============1492562347219368423==--

