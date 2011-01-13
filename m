Content-Type: multipart/mixed; boundary="===============2632227325275576041=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH v2 0/1] Add ifxmodem support for enable/disable tty
Date: Thu, 13 Jan 2011 13:02:44 +0200
Message-ID: <1294916565-16657-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2632227325275576041==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

 Following patch adds the ifxmodem support for enabling/disabling tty mode.

Regards,
Jeevaka

Jeevaka Badrappan (1):
  ifxmodem: add enable/disable ctm support

 Makefile.am                 |    3 +-
 drivers/ifxmodem/ctm.c      |  194 +++++++++++++++++++++++++++++++++++++++=
++++
 drivers/ifxmodem/ifxmodem.c |    2 +
 drivers/ifxmodem/ifxmodem.h |    3 +
 4 files changed, 201 insertions(+), 1 deletions(-)
 create mode 100644 drivers/ifxmodem/ctm.c


--===============2632227325275576041==--

