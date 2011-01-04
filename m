Content-Type: multipart/mixed; boundary="===============0593931817214946587=="
MIME-Version: 1.0
From: Dara Spieker-Doyle <dara.spieker-doyle@nokia.com>
Subject: [PATCH v4, 0/5] Add nokiacdma plugin and CDMA MO Call support
Date: Mon, 03 Jan 2011 17:50:12 -0800
Message-ID: <1294105817-23397-1-git-send-email-dara.spieker-doyle@nokia.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0593931817214946587==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This series of patches is version 4 of foundation support for the nokiacdma
device plugin and the cdma-voicecall atom. This is needed for
testing the changes in the first part of the series, for providing the
foundation cdmamodem driver and simple CDMA MO Call support with hardware.

These patches have been tested against the Nokia 7205 CDMA device in a teth=
ered
mode.

Limitations
-----------
The Nokia 7205 device does not support an AT interface for reporting request
responses, such as the call status and remote/network disconnect reasons, so
these are currently untested.

Dara Spieker-Doyle (5):
  cdmamodem: Add CDMA MO Call support
  test: Add CDMA MO Call Support
  nokiacdma: Add plugin and CDMA MO Call Support
  ofono-rules: Add nokiacdma device
  udev: Add nokiacdma device

 Makefile.am                   |   11 ++-
 drivers/cdmamodem/cdmamodem.c |    3 +
 drivers/cdmamodem/cdmamodem.h |    3 +
 drivers/cdmamodem/voicecall.c |  160 +++++++++++++++++++++++++++++++++
 plugins/nokiacdma.c           |  198 +++++++++++++++++++++++++++++++++++++=
++++
 plugins/ofono.rules           |    4 +
 plugins/udev.c                |   16 ++++
 test/cdma-dial-number         |   24 +++++
 test/cdma-hangup              |   20 ++++
 test/cdma-list-call           |   30 ++++++
 10 files changed, 467 insertions(+), 2 deletions(-)
 create mode 100644 drivers/cdmamodem/voicecall.c
 create mode 100644 plugins/nokiacdma.c
 create mode 100755 test/cdma-dial-number
 create mode 100755 test/cdma-hangup
 create mode 100755 test/cdma-list-call


--===============0593931817214946587==--

