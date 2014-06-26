Content-Type: multipart/mixed; boundary="===============1644620175148602412=="
MIME-Version: 1.0
From: Philip Paeps <philip@paeps.cx>
Subject: [PATCH v2 0/4] Add a driver for Quectel UC15 modems
Date: Thu, 26 Jun 2014 19:08:10 +0200
Message-ID: <1403802494-4542-1-git-send-email-philip@paeps.cx>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1644620175148602412==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Changes since v1:

 o Ammended udevng probing to also catch the modem when no
   labels have been configured in udev rules.
 o Reworked the enable/retry mechanism to be a little bit less
   hackish.  Commented the rationale in quectel_enable().
 o Use prefixes to help the AT parser match queries to replies.
 o Fixed style issues and unnecessary casts.
 o Make enable() end up in CFUN=3D4 (powered but radio off).


Philip Paeps (4):
  atmodem: add vendor Quectel
  udevng: add detection logic for Quectel modems
  plugins: add a new driver for Quectel UC15 modems
  sim: query Quectel UC15 PIN retries with AT+QPINC?

 Makefile.am              |    3 +
 drivers/atmodem/sim.c    |   49 ++++++
 drivers/atmodem/vendor.h |    3 +-
 plugins/quectel.c        |  371 ++++++++++++++++++++++++++++++++++++++++++=
++++
 plugins/udevng.c         |   42 ++++++
 5 files changed, 467 insertions(+), 1 deletion(-)
 create mode 100644 plugins/quectel.c

-- =

1.7.10.4


--===============1644620175148602412==--

