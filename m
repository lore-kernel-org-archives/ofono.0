Content-Type: multipart/mixed; boundary="===============0697808330900587488=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH v2 0/2] Add ATD>1; support for HFP emulator
Date: Tue, 21 Jun 2011 18:48:32 +0200
Message-ID: <1308674914-13037-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0697808330900587488==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Only ATD>1; will be managed through HFP AG, and it will call the
voicemail number retrieved from the message-waiting atom.

Fr=C3=A9d=C3=A9ric Danis (2):
  message-waiting: API to retrieve voicemail number
  voicecall: add ATD> support for HFP emulator

 src/message-waiting.c |    7 +++++++
 src/ofono.h           |    4 ++++
 src/voicecall.c       |   30 +++++++++++++++++++++++++++---
 3 files changed, 38 insertions(+), 3 deletions(-)


--===============0697808330900587488==--

