Content-Type: multipart/mixed; boundary="===============6015512602115589949=="
MIME-Version: 1.0
From: sjur.brandeland@stericsson.com
Subject: [PATCH 0/6] STE-plugin
Date: Mon, 25 Jan 2010 20:25:27 +0100
Message-ID: <1264447534-2386-1-git-send-email-sjur.brandeland@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6015512602115589949==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello.

This is a new version of the STE-plugin patch set. Since last RFCv2 we have
stubbed out Voice Call and GPRS Context handling, changed patch order,
cleanup some unnecessary includes, moved CAIF header files, and fixed =

most other review comments (hopefully).

Sjur Brandeland (6):
  STE-plugin: Add at_util_call_compare_by_id
  STE-plugin: Add vendor STE and quirks in atmodem.
  STE-plugin: STE modem driver definition
  STE-plugin: Add CAIF header files in drivers/stemodem.
  STE-plugin: Add STE plugin
  STE-plugin: Add STE to Makefile

 Makefile.am                            |   10 ++
 drivers/atmodem/atutil.c               |   14 ++
 drivers/atmodem/atutil.h               |    1 +
 drivers/atmodem/gprs.c                 |   10 +-
 drivers/atmodem/network-registration.c |   78 ++++++++++-
 drivers/atmodem/vendor.h               |    1 +
 drivers/stemodem/caif_socket.h         |  171 +++++++++++++++++++++
 drivers/stemodem/if_caif.h             |   70 +++++++++
 drivers/stemodem/stemodem.c            |   50 +++++++
 drivers/stemodem/stemodem.h            |   29 ++++
 plugins/ste.c                          |  253 ++++++++++++++++++++++++++++=
++++
 11 files changed, 684 insertions(+), 3 deletions(-)
 create mode 100644 drivers/stemodem/caif_socket.h
 create mode 100644 drivers/stemodem/if_caif.h
 create mode 100644 drivers/stemodem/stemodem.c
 create mode 100644 drivers/stemodem/stemodem.h
 create mode 100644 plugins/ste.c


--===============6015512602115589949==--

