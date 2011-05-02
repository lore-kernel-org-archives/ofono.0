Content-Type: multipart/mixed; boundary="===============3001839243442035592=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Dalleau <frederic.dalleau@linux.intel.com>
Subject: [PATCH 0/7] Add CHLD support to HFP profile
Date: Mon, 02 May 2011 17:48:01 +0200
Message-ID: <1304351288-3894-1-git-send-email-frederic.dalleau@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3001839243442035592==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch adds CHLD support to HFP profile.

AT+CHLD=3D0 uses release_all_held and set_udub
AT+CHLD=3D1 uses release_all_active
AT+CHLD=3D2 uses hold_all_active
AT+CHLD=3D3 uses create_multiparty
AT+CHLD=3D4 uses transfer
AT+CHLD=3D1X uses release_specific
AT+CHLD=3D2X uses private_chat

Best regards!


Fr=C3=A9d=C3=A9ric Dalleau (7):
  voicecall: Fix variable initialization
  voicecall: add +CHLD support for HFP emulator
  voicecall: add +CHLD=3D0 support for HFP emulator
  voicecall: add +CHLD=3D3 support for HFP emulator
  voicecall: add +CHLD=3D4 support for HFP emulator
  voicecall: add +CHLD=3D1X support for HFP emulator
  voicecall: add +CHLD=3D2X support for HFP emulator

 src/voicecall.c |  157 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 157 insertions(+), 0 deletions(-)


--===============3001839243442035592==--

