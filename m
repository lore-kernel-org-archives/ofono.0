Content-Type: multipart/mixed; boundary="===============0404507330367002482=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 00/14][RESEND] STK patches without agent
Date: Wed, 07 Jul 2010 00:38:55 +0200
Message-ID: <1278455949-2823-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0404507330367002482==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

These are some patches I sent before reordered and refactored to
skip stuff related to the Agent API, i.e. related to the UI.

Andrzej Zaborowski (14):
  stk: Utilities for proactive command/envelope handling.
  mbmmodem: End session on *STKEND.
  stk: Handle the More Time proactive command as a nop.
  Add OFONO_ERROR_TYPE_SIM for negative SIM statuses.
  atmodem: Make sim operations return sim error codes.
  stk: Handle ENVELOPEs in a queue, retry on sim busy.
  Add __ofono_sms_submit for other atoms to submit SMs.
  stk: Handle the Send SMS proactive command.
  Add Dbus interface names for STK.
  stk: Handle the Set Up Idle Text proactive command.
  sktutil: Use the Mandatory flag in parse_dataobj.
  stkutil: Timer Value is conditional, not optional.
  stk: Handle the Timer Management proactive command.
  stk: Handle the Poll Interval proactive command.

 drivers/atmodem/sim.c  |   32 ++-
 drivers/atmodem/stk.c  |   20 +-
 drivers/mbmmodem/stk.c |    3 +
 include/dbus.h         |    2 +
 include/stk.h          |    2 +
 include/types.h        |    1 +
 src/ofono.h            |    7 +-
 src/sms.c              |   39 +++
 src/stk.c              |  667 ++++++++++++++++++++++++++++++++++++++++++++=
++--
 src/stkutil.c          |   12 +-
 10 files changed, 744 insertions(+), 41 deletions(-)


--===============0404507330367002482==--

