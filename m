Content-Type: multipart/mixed; boundary="===============3975734085193360225=="
MIME-Version: 1.0
From: Dara Spieker-Doyle <dara.spieker-doyle@nokia.com>
Subject: [PATCH v5, 0/5] Add nokiacdma plugin and CDMA MO Call support
Date: Mon, 10 Jan 2011 17:45:27 -0800
Message-ID: <1294710332-6028-1-git-send-email-dara.spieker-doyle@nokia.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3975734085193360225==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This series of patches is version 5 of foundation support for the nokiacdma
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

 Makefile.am                   |   12 +++-
 drivers/cdmamodem/cdmamodem.c |    3 +
 drivers/cdmamodem/cdmamodem.h |    3 +
 drivers/cdmamodem/voicecall.c |  160 ++++++++++++++++++++++++++++++++++++++
 plugins/nokiacdma.c           |  171 +++++++++++++++++++++++++++++++++++++=
++++
 plugins/ofono.rules           |    4 +
 plugins/udev.c                |   15 ++++
 test/cdma-dial-number         |   25 ++++++
 test/cdma-hangup              |   20 +++++
 test/cdma-list-call           |   31 ++++++++
 10 files changed, 442 insertions(+), 2 deletions(-)
 create mode 100644 drivers/cdmamodem/voicecall.c
 create mode 100644 plugins/nokiacdma.c
 create mode 100755 test/cdma-dial-number
 create mode 100755 test/cdma-hangup
 create mode 100755 test/cdma-list-call


--===============3975734085193360225==--

