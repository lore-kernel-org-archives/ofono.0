Content-Type: multipart/mixed; boundary="===============5348782306268759839=="
MIME-Version: 1.0
From: Dragos Tatulea <dragos@endocode.com>
Subject: [PATCH 0/9] allow automatic context activation
Date: Thu, 17 Mar 2016 18:02:11 +0100
Message-ID: <1458234140-7936-1-git-send-email-dragos@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5348782306268759839==
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

Dragos Tatulea (9):
  idmap: add api for finding a certain id in map
  gprs-context.h: add op for reading context config
  gprs.h: automatic context configuration notifier
  gprs: pri_activate_callback: optional msg reply
  gprs: pri_set_apn: make reply msg optional
  gprs: custom cid for assign_context
  gprs: implement ofono_gprs_cid_activated
  atmodem: gprs: handle automatic context activation
  ubloxmodem: support automatic ctx activation

 drivers/atmodem/gprs.c            | 53 ++++++++++++++++++++++
 drivers/ubloxmodem/gprs-context.c | 39 ++++++++++++-----
 include/gprs-context.h            |  3 ++
 include/gprs.h                    |  3 ++
 src/gprs.c                        | 92 +++++++++++++++++++++++++++++++++++=
+---
 src/idmap.c                       | 13 ++++++
 src/idmap.h                       |  1 +
 7 files changed, 188 insertions(+), 16 deletions(-)

-- =

2.5.0


--===============5348782306268759839==--

