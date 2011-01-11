Content-Type: multipart/mixed; boundary="===============5694215787628623967=="
MIME-Version: 1.0
From: Dara Spieker-Doyle <dara.spieker-doyle@nokia.com>
Subject: [PATCH 0/3] Add CDMA devinfo support
Date: Tue, 11 Jan 2011 13:44:58 -0800
Message-ID: <1294782301-8592-1-git-send-email-dara.spieker-doyle@nokia.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5694215787628623967==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This series of patches provide CDMA AT support device info. It re-uses the =
GSM
atom interface and provides cdmamodem driver support, moving common utiliti=
es
to atutil.[ch] for sharing with the atmodem driver.

HW support for testing is implemented in the nokiacdma plugin.

These patches have been tested against the Nokia 7205 CDMA device in a teth=
ered
mode.

Limitations
-----------
Patches 2/3 and 3/3 are dependent on acceptance of the CDMA MO Voicecall v5
patch series.

Dara Spieker-Doyle (3):
  atmodem: Share common devinfo utilities
  cdmamodem: Add CDMA devinfo support
  nokiacdma: Add CDMA devinfo support

 Makefile.am                   |    3 +-
 drivers/atmodem/atutil.c      |   56 ++++++++++++++
 drivers/atmodem/atutil.h      |    2 +
 drivers/atmodem/devinfo.c     |   59 +-------------
 drivers/cdmamodem/cdmamodem.c |    2 +
 drivers/cdmamodem/cdmamodem.h |    2 +
 drivers/cdmamodem/devinfo.c   |  169 +++++++++++++++++++++++++++++++++++++=
++++
 plugins/nokiacdma.c           |    2 +
 8 files changed, 239 insertions(+), 56 deletions(-)
 create mode 100644 drivers/cdmamodem/devinfo.c


--===============5694215787628623967==--

