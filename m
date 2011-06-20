Content-Type: multipart/mixed; boundary="===============5202817800510767356=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH 0/3] Add ATD>1; support for HFP emulator
Date: Mon, 20 Jun 2011 17:12:40 +0200
Message-ID: <1308582763-3605-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5202817800510767356==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Only ATD>1; will be managed through HFP AG, and it will call the
voicemail number retrieved from the message-waiting atom.

Fr=C3=A9d=C3=A9ric Danis (3):
  message-waiting: add API to retrieve voicemail number
  message-waiting: API to retrieve voicemail number
  voicecall: add ATD> support for HFP emulator

 include/message-waiting.h |    2 ++
 src/message-waiting.c     |    6 ++++++
 src/voicecall.c           |   30 +++++++++++++++++++++++++++---
 3 files changed, 35 insertions(+), 3 deletions(-)


--===============5202817800510767356==--

