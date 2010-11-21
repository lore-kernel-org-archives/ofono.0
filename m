Content-Type: multipart/mixed; boundary="===============3215894771789466321=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: [PATCH 0/2] unit: STE Unit Tests
Date: Sun, 21 Nov 2010 23:02:59 +0100
Message-ID: <1290376981-4248-1-git-send-email-sjurbren@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3215894771789466321==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Sjur Br=C3=A6ndeland <sjur.brandeland@stericsson.com>

This patch set introduces unit tests for functionality in
o CAIF RTNL functions in drivers/stemodem/caif_rtnl.c
o GPRS context handling in drivers/stemodem/gprs-context.c
o Radio State settings in drivers/stemodem/radio-settings.c
o Test for CAIF Character devices are removed as this is not
  supported by upstream version of CAIF.

The unit tests calls functions in the driver and simulates
AT-responses received from the modem.

Patches should apply and compile cleanly. Successful execution
depends on patches:
stemodem: Create network interfaces statically
stemodem: Use RTNL to create network interfaces.

Sjur Br=C3=A6ndeland (2):
  unit: CAIF test: remove character dev tests and add RTNL.
  unit: Add unit tests for STE modem

 Makefile.am      |   19 ++-
 unit/test-caif.c |  108 +++++++----
 unit/test-ste.c  |  554 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 645 insertions(+), 36 deletions(-)
 create mode 100644 unit/test-ste.c


--===============3215894771789466321==--

