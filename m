Content-Type: multipart/mixed; boundary="===============1756969131650475014=="
MIME-Version: 1.0
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v2 00/19] Bluetooth HFP-specific extensions
Date: Wed, 12 Oct 2011 14:35:21 +0200
Message-ID: <1318422940-14955-1-git-send-email-mikel.astiz@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1756969131650475014==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch series is a revision of the HFP extensions proposed before,
including some other minor extensions.

Mikel Astiz (19):
  handsfree: Copyright statement correction
  handsfree: Copyright statement correction
  hfpmodem: Copyright statement correction
  doc: Add initial Handsfree API documentation
  hfpmodem: Set initial state for inband ringing
  hfpmodem: Support for +BSIR unsol. result codes
  doc: Handsfree API support for +BINP=3D1
  handsfree: Expose RequestPhoneNumber in D-Bus API
  hfpmodem: Support of number requests (AT+BINP=3D1)
  handsfree: Removed ASYNC flag from GetProperties
  doc: Voice recognition function added in Handsfree
  include: Voice recognition in handsfree public api
  handsfree: Implement voice recognition function
  hfpmodem: Support for AT+BVRA
  doc: Handsfree exposes supported AG features
  include: AG features added to handsfree public api
  handsfree: Supported AG features exposed in D-Bus
  hfpmodem: Report features supported by AG
  hfp_hf: Switched to permissive AT syntax parser

 doc/handsfree-api.txt        |   65 +++++++++++++
 drivers/hfpmodem/handsfree.c |  133 +++++++++++++++++++++++++++
 include/handsfree.h          |   10 ++
 plugins/hfp_hf.c             |    2 +-
 src/handsfree.c              |  205 ++++++++++++++++++++++++++++++++++++++=
+++-
 5 files changed, 412 insertions(+), 3 deletions(-)
 create mode 100644 doc/handsfree-api.txt

-- =

1.7.6.4


--===============1756969131650475014==--

