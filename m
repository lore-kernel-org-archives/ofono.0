Content-Type: multipart/mixed; boundary="===============5769130015782430988=="
MIME-Version: 1.0
From: sjur.brandeland@stericsson.com
Subject: [RFC v2 0/7] STE-plugin: Second RFC on STE patch-set
Date: Tue, 19 Jan 2010 17:11:46 +0100
Message-ID: <1263917513-6756-1-git-send-email-sjur.brandeland@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5769130015782430988==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Marit Henriksen XX <marit.xx.henriksen@stericsson.com>

This is the second RFC on the STE driver.Most review
comments should be included, except for using glib for
XML parsing and changes to voice-call termination.
We'll have to get back to this later.

Sjur Brandeland (7):
  STE-plugin: Add --disable-stemodem to makefiles.
  STE-plugin: Add vendor STE and quirks in atmodem.
  STE-plugin: STE modem driver definition
  STE-plugin: Add STE plugin
  STE-plugin: Voicecall driver.
  STE-plugin: Add CAIF header files in gcaif.
  STE-plugin: GPRS driver.

 Makefile.am                            |   18 +
 configure.ac                           |    5 +
 drivers/atmodem/atutil.c               |   14 +
 drivers/atmodem/atutil.h               |    1 +
 drivers/atmodem/gprs.c                 |   13 +-
 drivers/atmodem/network-registration.c |   76 ++++-
 drivers/atmodem/vendor.h               |    1 +
 drivers/stemodem/gprs-context.c        |  579 ++++++++++++++++++++++++++++
 drivers/stemodem/stemodem.c            |   53 +++
 drivers/stemodem/stemodem.h            |   29 ++
 drivers/stemodem/voicecall.c           |  648 ++++++++++++++++++++++++++++=
++++
 gcaif/caif_socket.h                    |  171 +++++++++
 gcaif/if_caif.h                        |   70 ++++
 plugins/ste.c                          |  262 +++++++++++++
 14 files changed, 1936 insertions(+), 4 deletions(-)


--===============5769130015782430988==--

