Content-Type: multipart/mixed; boundary="===============5567602999255927911=="
MIME-Version: 1.0
From: Piotr Haber <gluedig@gmail.com>
Subject: [PATCH 0/3] support Telit LE910 V2 modem
Date: Fri, 27 Jan 2017 10:54:21 +0100
Message-ID: <20170127095424.19685-1-gluedig@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5567602999255927911==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Introduce CDC-NCM driver for Telit modems.
Handle initialization of LE910V2 via udev.
Add model/variant recognition and setup.

Piotr Haber (3):
  telitmodem: support for CDC-NCM network adapter
  udevng: setup of Telit LE910V2
  xe910: support for Telit LE910V2 modem

 Makefile.am                           |   3 +-
 drivers/telitmodem/gprs-context-ncm.c | 485 ++++++++++++++++++++++++++++++=
++++
 drivers/telitmodem/telitmodem.c       |   2 +
 drivers/telitmodem/telitmodem.h       |   2 +
 plugins/udevng.c                      |  14 +-
 plugins/xe910.c                       |  16 +-
 6 files changed, 516 insertions(+), 6 deletions(-)
 create mode 100644 drivers/telitmodem/gprs-context-ncm.c

-- =

2.11.0


--===============5567602999255927911==--

