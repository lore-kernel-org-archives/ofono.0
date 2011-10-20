Content-Type: multipart/mixed; boundary="===============3001488683594917282=="
MIME-Version: 1.0
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v3 00/15] Bluetooth HFP-specific extensions
Date: Thu, 20 Oct 2011 18:38:05 +0200
Message-ID: <1319128700-15841-1-git-send-email-mikel.astiz@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3001488683594917282==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch series mainly includes the modified patches from the previous pr=
oposal. Additionally, some fixes are proposed to avoid potential crashes du=
ring hfpmodem powering.

More significantly, hfpmodem now exposes the BT address through the Serial =
property in org.ofono.Modem. This is achieved by a simple devinfo driver AT=
OM.

Mikel Astiz (15):
  hfpmodem: Support for +BSIR unsol. result codes
  doc: Voice recognition function added in Handsfree
  include: Voice recognition in handsfree public api
  handsfree: Implement voice recognition function
  hfpmodem: Support for AT+BVRA
  doc: Handsfree exposes supported AG features
  include: AG features added to handsfree public api
  handsfree: Supported AG features exposed in D-Bus
  hfpmodem: Report features supported by AG
  hfpmodem: Avoid segfault in network-registration
  hfpmodem: Avoid segfault in call-volume
  hfpmodem: Avoid segfault in handsfree
  hfpmodem: devinfo atom added to export BT address
  hfp_hf: BT address exposed through Serial property
  hfpmodem: minor whitespace fix

 Makefile.am                             |    1 +
 doc/handsfree-api.txt                   |   16 ++++-
 drivers/hfpmodem/call-volume.c          |    9 ++-
 drivers/hfpmodem/devinfo.c              |  133 +++++++++++++++++++++++++++=
++++
 drivers/hfpmodem/handsfree.c            |   81 ++++++++++++++++++-
 drivers/hfpmodem/hfpmodem.c             |    2 +
 drivers/hfpmodem/hfpmodem.h             |    7 ++
 drivers/hfpmodem/network-registration.c |    9 ++-
 include/handsfree.h                     |    9 ++
 plugins/hfp_hf.c                        |    7 ++
 src/handsfree.c                         |  130 +++++++++++++++++++++++++++=
+++
 11 files changed, 399 insertions(+), 5 deletions(-)
 create mode 100644 drivers/hfpmodem/devinfo.c

-- =

1.7.6.4


--===============3001488683594917282==--

