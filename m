Content-Type: multipart/mixed; boundary="===============8015859898066217909=="
MIME-Version: 1.0
From: sjur.brandeland@stericsson.com
Subject: [RFC 0/3] STE-plugin: Plugin for ST-Ericsson modems
Date: Sun, 17 Jan 2010 18:28:29 +0100
Message-ID: <1263749312-6567-1-git-send-email-sjur.brandeland@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8015859898066217909==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Sjur Brandeland <sjur.brandeland@stericsson.com>

We are happy to announce ST-Ericsson's participation in the oFono =

community and contribution of an oFono plug-in for ST-Ericsson modems.

This patch set adds a plug-in for use with ST-Ericsson modems. It is =

implemented using AT-commands over a CAIF link to communicate with the
modem. CAIF is the ST-Ericsson IPC mechanism used between host and modem.

Feedback on this patch set is welcome!

This patch-set is based on commit: e433ddc100bda3a437fb81805ea44348f22e9fcb
Sjur Brandeland (3):
  STE-plugin: Add vendor STE
  STE-plugin: Mechanism for inheritance
  STE-plugin: Add STE plugin

 Makefile.am                             |   11 +

 drivers/atmodem/gprs.c                  |   15 +-
 drivers/atmodem/vendor.h                |    5 +
 drivers/stemodem/gprs-context.c         |  612 +++++++++++++++++++++++++++=
+++
 drivers/stemodem/network-registration.c |  225 +++++++++++
 drivers/stemodem/stemodem.c             |  109 ++++++
 drivers/stemodem/stemodem.h             |   33 ++
 drivers/stemodem/voicecall.c            |  615 +++++++++++++++++++++++++++=
++++
 include/netreg.h                        |    5 +
 include/voicecall.h                     |    7 +-
 plugins/modemconf.c                     |    5 +
 plugins/ste.c                           |  246 ++++++++++++
 src/network.c                           |   22 ++
 src/voicecall.c                         |   22 ++
 14 files changed, 1929 insertions(+), 3 deletions(-)


--===============8015859898066217909==--

