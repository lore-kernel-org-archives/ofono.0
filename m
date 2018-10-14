Content-Type: multipart/mixed; boundary="===============0983459756880248295=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH v2 0/2] Gemalto: support for voicecall
Date: Sun, 14 Oct 2018 16:17:26 +0200
Message-ID: <20181014141728.20227-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0983459756880248295==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This series of patches adds a vendor-specific voicecall atom
for gemaltomodem, and then adds it to the plugin, along with all
other call-related atoms.

related to the first version submitted for RFC, it integrates the
comments from Denis, and only uses the required URCs, leaving out
for example RING.
It also fixes a problem with the first version when the SLCC URC was
parsed exactly like the AT+CLCC command: now it takes into account
that the URC function is called for each line, and not for all
together, while for CLCC all lines are parsed at once.


Giacinto Cifelli (2):
  Gemalto: voicecall atom
  plugins/gemalto: added voice support

 Makefile.am                         |   3 +-
 drivers/gemaltomodem/gemaltomodem.c |   2 +
 drivers/gemaltomodem/gemaltomodem.h |   2 +
 drivers/gemaltomodem/voicecall.c    | 751 ++++++++++++++++++++++++++++
 plugins/gemalto.c                   |  11 +
 5 files changed, 768 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gemaltomodem/voicecall.c

-- =

2.17.1


--===============0983459756880248295==--

