Content-Type: multipart/mixed; boundary="===============6031841088903704099=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v0] CDMA modem implementation support
Date: Tue, 13 Dec 2011 15:40:36 +0100
Message-ID: <1323787237-8307-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6031841088903704099==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

This is v0 of patch to support CDMA modems into ConnMan ofono plugin.
Please tell me if it needs to be split.

As current implementation is based on context that is GSM specific,
a unique context is created for CDMA modems to be able to add the network as
we can't trigger the context creation from oFono side.
Maybe be should create a add_cdma_network() function no to be context
dependant although we need to have one to store the IPv4/IPv6 settings, ind=
ex,
and modem path.

Kind regards,
Guillaume

Guillaume Zajac (1):
  ofono: Add support of CDMA modems

 plugins/ofono.c |  356 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++--
 1 files changed, 345 insertions(+), 11 deletions(-)


--===============6031841088903704099==--

