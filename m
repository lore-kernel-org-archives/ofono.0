Content-Type: multipart/mixed; boundary="===============5304227172204613721=="
MIME-Version: 1.0
From: Nicolas Bertrand <nicolas.bertrand@linux.intel.com>
Subject: [PATCH 0/3] Speedup ussd driver
Date: Mon, 16 Apr 2012 17:10:20 +0200
Message-ID: <1334589023-3633-1-git-send-email-nicolas.bertrand@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5304227172204613721==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Speedup is using its own way to handle USSD strings, so the =

implementation of this driver avoid some specific code in atmodem.

Nicolas Bertrand (3):
  Speedup: Add speedup driver to handle USSD
  Speedup: Use speedup specific driver for ussd
  Makefile: Add speedup modem target

 Makefile.am                         |    6 +
 drivers/speedupmodem/speedupmodem.c |   49 ++++++++
 drivers/speedupmodem/speedupmodem.h |   25 ++++
 drivers/speedupmodem/ussd.c         |  225 +++++++++++++++++++++++++++++++=
++++
 plugins/speedup.c                   |    4 +-
 5 files changed, 307 insertions(+), 2 deletions(-)
 create mode 100644 drivers/speedupmodem/speedupmodem.c
 create mode 100644 drivers/speedupmodem/speedupmodem.h
 create mode 100644 drivers/speedupmodem/ussd.c

-- =

1.7.5.4


--===============5304227172204613721==--

