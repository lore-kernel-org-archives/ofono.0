Content-Type: multipart/mixed; boundary="===============0786549692447495980=="
MIME-Version: 1.0
From: Philip Paeps <philip@paeps.cx>
Subject: [PATCH 0/4] Add a driver for Quectel UC15 modules
Date: Tue, 24 Jun 2014 12:08:38 +0200
Message-ID: <1403604522-22645-1-git-send-email-philip@paeps.cx>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0786549692447495980==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Not very exciting as drivers go. :)

Philip Paeps (4):
  atmodem: add vendor Quectel
  udevng: add setup logic for Quectel UC15 modules
  plugins: add a new driver for Quectel UC15 modules
  sim: query Quectel UC15 PIN retries with AT+QPINQ

 Makefile.am              |    3 +
 drivers/atmodem/sim.c    |   49 +++++++
 drivers/atmodem/vendor.h |    3 +-
 plugins/quectel.c        |  335 ++++++++++++++++++++++++++++++++++++++++++=
++++
 plugins/udevng.c         |   37 +++++
 5 files changed, 426 insertions(+), 1 deletion(-)
 create mode 100644 plugins/quectel.c

-- =

1.7.10.4


--===============0786549692447495980==--

