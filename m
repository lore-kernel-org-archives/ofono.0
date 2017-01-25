Content-Type: multipart/mixed; boundary="===============1237428515099035832=="
MIME-Version: 1.0
From: Piotr Haber <gluedig@gmail.com>
Subject: [PATCH 0/4] add support for Telit LE910V2
Date: Wed, 25 Jan 2017 11:41:24 +0100
Message-ID: <20170125104128.5254-1-gluedig@gmail.com>
In-Reply-To: <0d2bc051-546f-6c64-885a-7d7ea5501b11@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1237428515099035832==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Telit L910 V2 is a LTE Cat. 4 device.

Piotr Haber (4):
  telitmodem: support for CDC-NCM network adapter
  plugins: support for Telit LE910 V2 modem
  doc: description of Telit LE910V2 network setup
  udevng: setup of Telit LE910V2

 Makefile.am                           |   6 +-
 doc/telit-modem.txt                   |  27 ++
 drivers/telitmodem/gprs-context-ncm.c | 497 ++++++++++++++++++++++++++++++=
++++
 drivers/telitmodem/telitmodem.c       |   2 +
 drivers/telitmodem/telitmodem.h       |   2 +
 plugins/le910v2.c                     | 400 +++++++++++++++++++++++++++
 plugins/udevng.c                      |  38 +++
 7 files changed, 971 insertions(+), 1 deletion(-)
 create mode 100644 drivers/telitmodem/gprs-context-ncm.c
 create mode 100644 plugins/le910v2.c

-- =

2.11.0


--===============1237428515099035832==--

