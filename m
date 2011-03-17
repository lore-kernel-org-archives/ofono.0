Content-Type: multipart/mixed; boundary="===============2454753785715609506=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH 0/4] HFP: add call, callsetup indicators and +COPS support
Date: Thu, 17 Mar 2011 17:50:52 +0100
Message-ID: <1300380656-8757-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2454753785715609506==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

AT+COPS support needs to be in emulator as HFP plugin should answer requests
even when oFono is not registered on network.

Fr=C3=A9d=C3=A9ric Danis (4):
  emulator: add defines for call and callsetup indicators
  emulator: add call and callsetup indicators
  emulator: add API to set network mode and name
  emulator: add +COPS support

 include/emulator.h |   13 +++++++
 src/emulator.c     |   75 +++++++++++++++++++++++++++++++++++++++++++
 src/network.c      |   90 +++++++++++++++++++++++++++++++++++++++++++++++-=
---
 src/voicecall.c    |   86 +++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 257 insertions(+), 7 deletions(-)


--===============2454753785715609506==--

