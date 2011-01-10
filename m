Content-Type: multipart/mixed; boundary="===============8088765312026898583=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 0/2] Add ifxmodem support for enable/disable tty
Date: Mon, 10 Jan 2011 17:54:58 +0200
Message-ID: <1294674900-10256-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8088765312026898583==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

 Following patch adds the ifxmodem support for enabling/disabling tty
mode.

Regards,
Jeevaka

Jeevaka Badrappan (2):
  ctm: add ofono_ctm_get_modem interface
  ifxmodem: add enable/disable ctm support

 Makefile.am                 |    3 +-
 drivers/ifxmodem/ctm.c      |  243 +++++++++++++++++++++++++++++++++++++++=
++++
 drivers/ifxmodem/ifxmodem.c |    2 +
 drivers/ifxmodem/ifxmodem.h |    3 +
 include/ctm.h               |    2 +
 src/ctm.c                   |    5 +
 6 files changed, 257 insertions(+), 1 deletions(-)
 create mode 100644 drivers/ifxmodem/ctm.c


--===============8088765312026898583==--

