Content-Type: multipart/mixed; boundary="===============5868324477828599331=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH v3 0/2] Add ifx support for enable/disable tty
Date: Thu, 13 Jan 2011 16:31:20 +0200
Message-ID: <1294929082-19792-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5868324477828599331==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

 Following patch adds the ifxmodem support for enabling/disabling tty mode.

Regards,
Jeevaka

Jeevaka Badrappan (2):
  ifxmodem: add enable/disable ctm support
  plugins: add ctm create to ifx plugin

 Makefile.am                 |    3 +-
 drivers/ifxmodem/ctm.c      |  194 +++++++++++++++++++++++++++++++++++++++=
++++
 drivers/ifxmodem/ifxmodem.c |    2 +
 drivers/ifxmodem/ifxmodem.h |    3 +
 plugins/ifx.c               |    2 +
 5 files changed, 203 insertions(+), 1 deletions(-)
 create mode 100644 drivers/ifxmodem/ctm.c


--===============5868324477828599331==--

