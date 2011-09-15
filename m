Content-Type: multipart/mixed; boundary="===============5004020750977306747=="
MIME-Version: 1.0
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH 00/12] Bluetooth HFP-specific extensions
Date: Thu, 15 Sep 2011 18:34:31 +0200
Message-ID: <1316104483-13144-1-git-send-email-mikel.astiz@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5004020750977306747==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Here you have my first proposals to add a new atom to support HFP-specific
capabilities, and the corresponding implementation in hfpmodem. Only some of
these extensions have been included in this series. Hope this fits the ideas
discussed in the mailing list.

Looking forward to your review,

Mikel

Mikel Astiz (12):
  TODO: Task added for HFP-specific capabilities
  Add handsfree atom for HFP-specific capabilities
  hfpmodem: Driver implements handsfree atom
  hfp_hf: Plugin creates handsfree atom
  handsfree: Atom supports inband ringing status
  hfpmodem: Support for +BSIR unsol. result codes
  handsfree: Support for number requests (AT+BINP=3D1)
  handsfree: Expose RequestInput in D-Bus API
  hfpmodem: Support of number requests (AT+BINP=3D1)
  handsfree: Read-only voice-recognition D-Bus prop
  handsfree: Writable voice-recogn. prop (AT+BVRA)
  hfpmodem: Support for AT+BVRA

 Makefile.am                  |    9 +-
 TODO                         |   11 ++
 drivers/hfpmodem/handsfree.c |  223 ++++++++++++++++++++++++
 drivers/hfpmodem/hfpmodem.c  |    2 +
 drivers/hfpmodem/hfpmodem.h  |    3 +
 include/dbus.h               |    1 +
 include/handsfree.h          |   74 ++++++++
 plugins/hfp_hf.c             |    2 +
 src/handsfree.c              |  385 ++++++++++++++++++++++++++++++++++++++=
++++
 src/ofono.h                  |    1 +
 10 files changed, 708 insertions(+), 3 deletions(-)
 create mode 100644 drivers/hfpmodem/handsfree.c
 create mode 100644 include/handsfree.h
 create mode 100644 src/handsfree.c

-- =

1.7.6


--===============5004020750977306747==--

