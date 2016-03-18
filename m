Content-Type: multipart/mixed; boundary="===============1203375844156189625=="
MIME-Version: 1.0
From: Dragos Tatulea <dragos@endocode.com>
Subject: [PATCH v2 0/9] allow automatic context activation
Date: Fri, 18 Mar 2016 11:47:02 +0100
Message-ID: <1458298030-30455-1-git-send-email-dragos@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1203375844156189625==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

LTE uses default bearer activation. Once register to the network is
received of which context has been activated.

This patchset takes action in the atmodem gprs driver when receiving
the activation event. It reads the cid and apn and sends it to the
gprs core. From there a matching (my apn) pri_context is
found/created and a gprs-context driver is assigned.

A read_settings operation has been added to the gprs-context driver
to read context ip configuration without activating the context.

The last patch in the patchset adds this support to the U-Blox
Toby L2 modem.

Implementation based mostly on ideas from Denis Kenzior.

Changes in patchset v2:
* Removed reliance on pri_activate_callback
* Context recycling: Use failed provision node if no apn match.
* Assign APN to pri_context if apn field is NULL.
* Fixed all suggestions from v1 review.

Dragos Tatulea (5):
  idmap: add api for finding a certain id in map
  gprs-context.h: add op for reading context config
  gprs: implement ofono_gprs_cid_activated
  atmodem: gprs: handle automatic context activation
  ubloxmodem: support automatic ctx activation

 drivers/atmodem/gprs.c            |  50 +++++++++++++++++
 drivers/ubloxmodem/gprs-context.c |  32 +++++++----
 include/gprs-context.h            |   3 +
 src/gprs.c                        | 114 ++++++++++++++++++++++++++++++++++=
++++
 src/idmap.c                       |  12 ++++
 src/idmap.h                       |   1 +
 6 files changed, 202 insertions(+), 10 deletions(-)

-- =

2.5.0


--===============1203375844156189625==--

