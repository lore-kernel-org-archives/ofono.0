Content-Type: multipart/mixed; boundary="===============1949690311115603054=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: [RFC 00/22] HFP 1.6 AG implementation
Date: Thu, 16 May 2013 14:16:20 -0300
Message-ID: <1368724602-27781-1-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1949690311115603054==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

PTS fails in tests related to codec negotiation when the driverless
approach to AG implementation is used. So I am sending this series that
uses card driver as a RFC to get feedback from the mailing list.

This series needs two not-yet-upstream patches from Vinicius Gomes.

Paulo Borges (22):
  include: Add ofono_emulator_create_card()
  emulator: Implement ofono_emulator_create_card()
  hfp_ag_bluez5: Create card when connect
  emulator: Register card when establish SLC
  emulator: Set local and remote address of card
  hfp_ag_bluez5: Check if card creation fails
  include: Add emulator init and cleanup functions
  emulator: Implement init and cleanup functions
  main: Call emulator init and cleanup functions
  emulator: Add HFP 1.6 AG card driver
  emulator: Set card driver
  hfp_ag_bluez5: Send HFP version to card creation
  hfp_ag_bluez5: Register HFP AG version 1.6
  emulator: Add AT+BAC support
  emulator: Add AT+BCC support
  emulator: Setup codec connection
  emulator: Add AT+BCS support
  emulator: Resend +BCS after receive AT+BAC
  emulator: Setup synchronous connection
  emulator: Reuse last negotiated codec
  emulator: Copy callback mechanism from atutil.h
  emulator: Implement AG card .Connect() for HFP 1.6

 include/emulator.h      |    2 +
 plugins/hfp_ag_bluez5.c |   55 +++++++-
 src/emulator.c          |  345 +++++++++++++++++++++++++++++++++++++++++++=
++++
 src/main.c              |    4 +
 src/ofono.h             |    3 +
 5 files changed, 408 insertions(+), 1 deletion(-)

-- =

1.7.9.5


--===============1949690311115603054==--

