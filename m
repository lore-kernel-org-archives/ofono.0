Content-Type: multipart/mixed; boundary="===============6860188020240103337=="
MIME-Version: 1.0
From: Philip Paeps <philip@paeps.cx>
Subject: [PATCH v3 0/4] Add a driver for u-blox modems
Date: Thu, 03 Jul 2014 12:32:02 +0200
Message-ID: <1404383526-12790-1-git-send-email-philip@paeps.cx>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6860188020240103337==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Changes since v2:

 o Rebased on master 6df64cd
 o Used none_prefix consistently


Philip Paeps (4):
  udevng: add detection logic for u-blox modems
  plugins: new driver for u-blox SARA-U270 modems
  sim: query u-blox PIN retries with AT+UPINCNT
  atmodem: set the auth method for u-blox modems

 Makefile.am                    |    3 +
 drivers/atmodem/gprs-context.c |   31 ++++-
 drivers/atmodem/sim.c          |   45 ++++++
 plugins/ublox.c                |  293 ++++++++++++++++++++++++++++++++++++=
++++
 plugins/udevng.c               |   42 ++++++
 5 files changed, 411 insertions(+), 3 deletions(-)
 create mode 100644 plugins/ublox.c

-- =

1.7.10.4


--===============6860188020240103337==--

