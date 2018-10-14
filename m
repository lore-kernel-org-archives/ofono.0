Content-Type: multipart/mixed; boundary="===============1876854209492059063=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH v3 0/2] Gemalto: support for voicecall
Date: Sun, 14 Oct 2018 19:42:33 +0200
Message-ID: <20181014174235.26678-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1876854209492059063==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This series of patches adds a vendor-specific voicecall atom
for gemaltomodem, and then adds it to the plugin, along with all
other call-related atoms.

related to the previous versions submitted for RFC, it integrates the
comments from Denis and Jonas, uses the required URCs (leaving
out, for example, RING), and doesn't check the memory allocation
anymore: g_new0 instead of g_try_new0.

From the second version, it fixes also a problem with the initial
version, where the SLCC URC was parsed exactly like the AT+CLCC command:
now the code takes into account that the URC function is called for each
line, and not for all together (unlike CLCC parsing, where all lines are
available at once).


Giacinto Cifelli (2):
  Gemalto: voicecall atom
  plugins/gemalto: added voice support

 Makefile.am                         |   3 +-
 drivers/gemaltomodem/gemaltomodem.c |   3 +
 drivers/gemaltomodem/gemaltomodem.h |   3 +
 drivers/gemaltomodem/voicecall.c    | 729 ++++++++++++++++++++++++++++
 plugins/gemalto.c                   |  12 +
 5 files changed, 749 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gemaltomodem/voicecall.c

-- =

2.17.1


--===============1876854209492059063==--

