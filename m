Content-Type: multipart/mixed; boundary="===============6250542290644489614=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjur.brandeland@stericsson.com>
Subject: [PATCH v5 0/8] Resubmitting STE Driver Patches.
Date: Tue, 17 Aug 2010 14:22:26 +0200
Message-ID: <1282047754-15562-1-git-send-email-sjur.brandeland@stericsson.com>
In-Reply-To: <1281966848-14553-1-git-send-email-sjur.brandeland@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6250542290644489614==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Resubmitting same changes as last patch set, but
some of the patches are split up in smaller parts.
The RTNL patch is removed and replaced by a separate RFC.

Sjur Br=C3=A6ndeland (8):
  plugins/ste: SIM - STE registers as MBM to utilize mbm quirks.
  stemodem: Add polling for SIM ready.
  plugins/ste: Add AT Channel configurations (new)
  stemodem: Add Radio Settings to STE Modem
  plugins/ste: Add Radio-Settings
  plugins/modemconf.c add support for Interface for STE plugin. (new)
  plugins/ste: Use SOCK_STREAM for CAIF and enable interface
    specification.
  plugins: Add STE sample to modem.conf (new)

 Makefile.am                       |    2 +
 drivers/stemodem/radio-settings.c |  225 +++++++++++++++++++++++++++++++++=
++++
 drivers/stemodem/stemodem.c       |    2 +
 drivers/stemodem/stemodem.h       |    2 +
 plugins/modem.conf                |    5 +
 plugins/modemconf.c               |    1 +
 plugins/ste.c                     |   79 ++++++++++++-
 7 files changed, 311 insertions(+), 5 deletions(-)
 create mode 100644 drivers/stemodem/radio-settings.c


--===============6250542290644489614==--

