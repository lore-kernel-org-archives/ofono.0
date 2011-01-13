Content-Type: multipart/mixed; boundary="===============3731182452215201971=="
MIME-Version: 1.0
From: Dara Spieker-Doyle <dara.spieker-doyle@nokia.com>
Subject: [PATCH v2, 0/2] Add CDMA devinfo support
Date: Thu, 13 Jan 2011 12:52:14 -0800
Message-ID: <1294951936-23868-1-git-send-email-dara.spieker-doyle@nokia.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3731182452215201971==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is v2 of the series of patches to provide CDMA AT support device info.
It re-uses the GSM atom interface and provides cdmamodem driver support, mo=
ving
common utilities to atutil.[ch] for sharing with the atmodem driver.

HW support for testing is implemented in the nokiacdma plugin.

These patches have been tested against the Nokia 7205 CDMA device in a teth=
ered
mode.

Dara Spieker-Doyle (2):
  cdmamodem: Add CDMA devinfo support
  nokiacdma: Add CDMA devinfo support

 Makefile.am                   |    3 +-
 drivers/cdmamodem/cdmamodem.c |    2 +
 drivers/cdmamodem/cdmamodem.h |    2 +
 drivers/cdmamodem/devinfo.c   |  188 +++++++++++++++++++++++++++++++++++++=
++++
 plugins/nokiacdma.c           |    2 +
 5 files changed, 196 insertions(+), 1 deletions(-)
 create mode 100644 drivers/cdmamodem/devinfo.c


--===============3731182452215201971==--

