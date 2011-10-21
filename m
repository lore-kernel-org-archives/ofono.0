Content-Type: multipart/mixed; boundary="===============5231836413333618501=="
MIME-Version: 1.0
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v4 00/12] Bluetooth HFP-specific extensions
Date: Fri, 21 Oct 2011 18:51:25 +0200
Message-ID: <1319215897-6310-1-git-send-email-mikel.astiz@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5231836413333618501==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Modifications to the previously proposed patches, according to the review.

Mikel Astiz (12):
  include: Voice recognition in handsfree public api
  handsfree: Implement voice recognition function
  hfpmodem: Support for AT+BVRA
  doc: Handsfree exposes supported AG features
  handsfree: Supported AG features exposed in D-Bus
  hfpmodem: Report features supported by AG
  hfpmodem: Avoid segfault in network-registration
  hfpmodem: Avoid segfault in call-volume
  hfpmodem: Avoid segfault in handsfree
  devinfo: avoid crash if query_model not supported
  hfpmodem: devinfo atom added to export BT address
  hfp_hf: BT address exposed through Serial property

 Makefile.am                             |    1 +
 doc/handsfree-api.txt                   |    9 ++-
 drivers/hfpmodem/call-volume.c          |    8 ++-
 drivers/hfpmodem/devinfo.c              |  109 +++++++++++++++++++++++++
 drivers/hfpmodem/handsfree.c            |   62 ++++++++++++++-
 drivers/hfpmodem/hfpmodem.c             |    2 +
 drivers/hfpmodem/hfpmodem.h             |    3 +
 drivers/hfpmodem/network-registration.c |    9 ++-
 include/handsfree.h                     |    7 ++
 plugins/hfp_hf.c                        |    4 +
 src/handsfree.c                         |  133 +++++++++++++++++++++++++++=
++++
 src/modem.c                             |    1 +
 12 files changed, 344 insertions(+), 4 deletions(-)
 create mode 100644 drivers/hfpmodem/devinfo.c

-- =

1.7.6.4


--===============5231836413333618501==--

