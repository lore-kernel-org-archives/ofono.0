Content-Type: multipart/mixed; boundary="===============1148052133494403611=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: [PATCH v2 00/12] Add HandsfreeAudioCard to emulator
Date: Thu, 25 Apr 2013 16:09:01 -0300
Message-ID: <1366916953-12967-1-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1148052133494403611==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch series starts to implement HandsfreeAudioCard logic to Audio
Gateway role from HFP version 1.6 profile.

Changelog v2:

* Extract fd from emulator's GAtServer
* Add card driver for HFP 1.6 AG
* Send HFP version to card creation

Paulo Borges (12):
  include: Add ofono_emulator_create_card()
  emulator: Implement ofono_emulator_create_card()
  hfp_ag_bluez5: Create card when connect
  emulator: Register card when establish SLC
  emulator: Set local and remote address of card
  include: Add emulator init and cleanup functions
  emulator: Implement init and cleanup functions
  main: Call emulator init and cleanup functions
  emulator: Add HFP 1.6 AG card driver
  emulator: Set card driver
  hfp_ag_bluez5: Send HFP version to card creation
  hfp_ag_bluez5: Register HFP AG version 1.6

 include/emulator.h      |    2 +
 plugins/hfp_ag_bluez5.c |   55 ++++++++++++++++++++++-
 src/emulator.c          |  111 +++++++++++++++++++++++++++++++++++++++++++=
++++
 src/main.c              |    4 ++
 src/ofono.h             |    3 ++
 5 files changed, 174 insertions(+), 1 deletion(-)

-- =

1.7.9.5


--===============1148052133494403611==--

