Content-Type: multipart/mixed; boundary="===============4988498637971812934=="
MIME-Version: 1.0
From: Antti Paila <antti.paila@nokia.com>
Subject: [PATCH 0/5] Cell info for ISI modem
Date: Mon, 07 Mar 2011 12:24:29 +0200
Message-ID: <1299493474-12982-1-git-send-email-antti.paila@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4988498637971812934==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

 This series of patches brings the neighbor
 cell info support for ISI modems.

Antti Paila (5):
  isimodem: new enums declared for cell info
  isimodem: Driver implementation
  isimodem: cell info init and exit functions
  isimodem: cell info creation to post_online
  isimodem: Makefile modifications

 Makefile.am                  |   13 +-
 drivers/isimodem/cell-info.c |  375 ++++++++++++++++++++++++++++++++++++++=
++++
 drivers/isimodem/debug.c     |    5 +
 drivers/isimodem/isimodem.c  |    2 +
 drivers/isimodem/isimodem.h  |    3 +
 drivers/isimodem/network.h   |    8 +
 plugins/isiusb.c             |    3 +
 7 files changed, 404 insertions(+), 5 deletions(-)
 create mode 100644 drivers/isimodem/cell-info.c


--===============4988498637971812934==--

