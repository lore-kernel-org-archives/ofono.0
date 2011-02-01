Content-Type: multipart/mixed; boundary="===============4186181606561491629=="
MIME-Version: 1.0
From: Jessica Nilsson <jessica.j.nilsson@stericsson.com>
Subject: [PATCH v2 0/3] ISI modem version detection with plugin
Date: Tue, 01 Feb 2011 15:13:16 +0100
Message-ID: <cover.1296569048.git.jessica.j.nilsson@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4186181606561491629==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The same patch as before, but split up in three parts as per your suggestio=
n.

As before, please note that this does not build unless the gisi patch
"gisi: Updated subscriptions and pipe handling to accomodate additional
isimodem versions" is added first. We are currently looking at your comment=
s on
that one and will send in an update as soon as we can.

Best Regards,
Jessica Nilsson

  u8500: add plugin for u8500
  udev: u8500 support and style fix
  isimodem: header updates for ISI2.5

 Makefile.am                |    4 +
 drivers/isimodem/debug.c   |  132 ++++++++++++
 drivers/isimodem/debug.h   |    9 +
 drivers/isimodem/mtc.h     |   38 ++++
 drivers/isimodem/version.h |   26 +++
 plugins/ofono.rules        |    3 +
 plugins/u8500.c            |  507 ++++++++++++++++++++++++++++++++++++++++=
++++
 plugins/udev.c             |    5 +-
 8 files changed, 723 insertions(+), 1 deletions(-)
 create mode 100644 drivers/isimodem/version.h
 create mode 100644 plugins/u8500.c

--
1.7.3.5


--===============4186181606561491629==--

