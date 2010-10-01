Content-Type: multipart/mixed; boundary="===============1988695111333907217=="
MIME-Version: 1.0
From: Kai Vehmanen <kai.vehmanen@nokia.com>
Subject: [PATCH 0/2] audio settings support for n900
Date: Fri, 01 Oct 2010 16:04:14 +0300
Message-ID: <1285938256-6423-1-git-send-email-kai.vehmanen@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1988695111333907217==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

here's a set of patches adding support for audio settings atom to
the isimodem driver, and for using this in the N900 plugin.

On the N900, this interface can be used to drive the state machine
of the libcmtspeechdata library. See:
http://gitorious.org/+meego-cellular/meego-cellular/libcmtspeechdata

Kai Vehmanen (2):
  isimodem: Add support for audio settings
  n900: Enable audio settings atom

 Makefile.am                       |    3 +-
 drivers/isimodem/audio-settings.c |  148 +++++++++++++++++++++++++++++++++=
++++
 drivers/isimodem/isimodem.c       |    2 +
 drivers/isimodem/isimodem.h       |    3 +
 plugins/n900.c                    |    2 +
 5 files changed, 157 insertions(+), 1 deletions(-)
 create mode 100644 drivers/isimodem/audio-settings.c


--===============1988695111333907217==--

