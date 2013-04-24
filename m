Content-Type: multipart/mixed; boundary="===============4249929133968296921=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: [PATCH 0/6] Add HandsfreeAudioCard to emulator
Date: Wed, 24 Apr 2013 14:13:45 -0300
Message-ID: <1366823631-26262-1-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4249929133968296921==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch series starts to implement HandsfreeAudioCard logic to Audio
Gateway role from HFP version 1.6 profile:

* Patches 01 to 03 implement a function to add a new
HandsfreeAudioCard to an emulator and call it when a new connection
arrives.

* Patch 04 registers the card when the Service Level Connection is
established.

* Patches 05 and 06 stores the remote and local address in the card.

What is expected for upcoming series?

* Card driver for Audio Gateway version 1.6
* Handle specific AT commands from HFP version 1.6 (AT+BAC, ...)

Paulo Borges (6):
  include: Add ofono_emulator_create_card()
  emulator: Implement ofono_emulator_create_card()
  hfp_ag_bluez5: Create card when connect
  emulator: Register card when establish SLC
  emulator: Set local and remote address of card
  hfp_ag_bluez5: Send fd to card creation

 include/emulator.h      |    2 ++
 plugins/hfp_ag_bluez5.c |    8 ++++++
 src/emulator.c          |   63 +++++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 73 insertions(+)

-- =

1.7.9.5


--===============4249929133968296921==--

