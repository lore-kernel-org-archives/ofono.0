Content-Type: multipart/mixed; boundary="===============3710387343391327439=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH v4 0/2] Gemalto: support for voicecall
Date: Wed, 17 Oct 2018 06:52:12 +0200
Message-ID: <20181017045214.8771-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3710387343391327439==
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
This version further simplify the treatment of ATD, because even if some old
models support the blocking ATD, these modules are mostly obsolete, and can
anyway be configured to be non-blocking. These old modules are currently
not supported in the Gemalto plugin.

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
 drivers/gemaltomodem/gemaltomodem.h |   6 +
 drivers/gemaltomodem/voicecall.c    | 581 ++++++++++++++++++++++++++++
 plugins/gemalto.c                   |  12 +
 5 files changed, 604 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gemaltomodem/voicecall.c

-- =

2.17.1


--===============3710387343391327439==--

