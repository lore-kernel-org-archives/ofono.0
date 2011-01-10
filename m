Content-Type: multipart/mixed; boundary="===============1455132415594881754=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH v3 0/6] Query retry counters
Date: Mon, 10 Jan 2011 19:02:25 -0200
Message-ID: <1294693351-25475-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1455132415594881754==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Diff from previous version:
 - memset(retries, -1, sizeof(retries)) works, but it's just because of luc=
k in
   2's complement logic. Use a loop instead.
 - "^CPIN" command is exclusive to HUAWEI. So change "xcpin" prefix to
   "huawei_cpin" and passs OFONO_VENDOR_HUAWEI quirk on sim creation. This =
change
   needed 2 more patches (the first ones) in order to make it work.
 - space cleanup
 - use memcmp to compare the pin_retries array instead of a loop

Lucas De Marchi (6):
  atmodem: check for VENDOR_HUAWEI on sim atom
  huawei: use VENDOR_HUAWEI quirk on sim creation
  include: add method to query pin Retries
  sim: query remaining pin retries
  doc: detail Retries property
  atmodem: implement query for remaining pin retries

 doc/sim-api.txt       |   12 ++++++
 drivers/atmodem/sim.c |   95 +++++++++++++++++++++++++++++++++++++++++++++=
+++-
 include/sim.h         |    5 +++
 plugins/huawei.c      |    2 +-
 src/sim.c             |   90 ++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 202 insertions(+), 2 deletions(-)

-- =

1.7.3.5


--===============1455132415594881754==--

