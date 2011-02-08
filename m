Content-Type: multipart/mixed; boundary="===============4350366854394624723=="
MIME-Version: 1.0
From: Dara Spieker-Doyle <dara.spieker-doyle@nokia.com>
Subject: [PATCH 0/7] Add CDMA Signal Strength Support
Date: Tue, 08 Feb 2011 13:04:53 -0800
Message-ID: <1297199100-2712-1-git-send-email-dara.spieker-doyle@nokia.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4350366854394624723==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is a series of patches to provide CDMA Signal Strength support for the=
 1xRTT
network. It provides both new atom and driver code.

HW support for testing is implemented in the nokiacdma plugin. This modem d=
oes
not support unsolicited notifications for the signal strength via the AT
interface, so this functionality is implemented with polling for the nokiac=
dma
plugin.

These patches have been tested against the Nokia 7205 CDMA device in a teth=
ered
mode.

Limitations
-----------

The Nokia 7205 device does not support multiple AT ports, so notification of
network properties (such as the signal strength) is not available while the
port is busy with e.g. data traffic.
Support for handling these scenarios is future work.

Dara Spieker-Doyle (7):
  gatchat: Share utility with CDMA network driver
  dbus: Add CDMA netreg atom support
  cdma-netreg: Add Signal Strength Support
  cdma-netreg: Add Signal Strength Support
  cdmamodem: Add Signal Strength Support
  nokiacdma: Add cdma-netreg Support
  test: Add CDMA Signal Strength Support

 Makefile.am                                   |   11 +-
 drivers/cdmamodem/cdmamodem.c                 |    2 +
 drivers/cdmamodem/cdmamodem.h                 |    2 +
 drivers/cdmamodem/network-registration.c      |  211 ++++++++++++++++++++
 gatchat/gatresult.c                           |   11 -
 gatchat/gatresult.h                           |   11 +
 include/cdma-netreg.h                         |   77 +++++++
 include/dbus.h                                |    2 +
 plugins/nokiacdma.c                           |    4 +
 src/cdma-network.c                            |  263 +++++++++++++++++++++=
++++
 src/ofono.h                                   |    2 +
 test/cdma-get-current-network-signal-strength |   21 ++
 12 files changed, 602 insertions(+), 15 deletions(-)
 create mode 100644 drivers/cdmamodem/network-registration.c
 create mode 100644 include/cdma-netreg.h
 create mode 100644 src/cdma-network.c
 create mode 100755 test/cdma-get-current-network-signal-strength


--===============4350366854394624723==--

