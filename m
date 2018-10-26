Content-Type: multipart/mixed; boundary="===============1619493375305797158=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH 0/9] Miscellaneous patches
Date: Fri, 26 Oct 2018 12:13:10 +0200
Message-ID: <20181026101319.27709-1-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1619493375305797158==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This series is just some miscellaneous patches, addressing some compiler
warnings, etc.  The patches are independent of each other.

/Jonas

Jonas Bonn (9):
  test: use python3 for set-ddr
  mbim: remove unused modem data
  atmodem: enlarge command buffer
  qmimodem: prevent use of unitialized variable
  simutil: remove check for impossible condition
  stkutil: remove test for impossible condition
  huaweimodme: prevent use of uninitialized variable
  atmodem: prevent use of uninitialized value
  modem: global data is pre-zeroed

 drivers/atmodem/sms.c      |  2 +-
 drivers/atmodem/ussd.c     |  6 +++---
 drivers/huaweimodem/ussd.c |  6 +++---
 drivers/qmimodem/lte.c     |  2 +-
 plugins/udevng.c           |  2 --
 src/modem.c                | 14 +++++++-------
 src/simutil.c              |  3 ---
 src/stkutil.c              |  3 ---
 test/set-ddr               |  2 +-
 9 files changed, 16 insertions(+), 24 deletions(-)

-- =

2.17.1


--===============1619493375305797158==--

