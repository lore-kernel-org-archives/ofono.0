Content-Type: multipart/mixed; boundary="===============2329392462622481019=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Dalleau <frederic.dalleau@linux.intel.com>
Subject: [PATCH v2 0/2] Manage multiparty list in emulator CHLD calls
Date: Tue, 05 Jul 2011 07:50:35 +0200
Message-ID: <1309845037-27360-1-git-send-email-frederic.dalleau@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2329392462622481019==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

These patches will manage the multiparty list in emulator CHLD calls.
This allow the mpty field of +CLCC to be set to 1 or 0 depending if there i=
s a multiparty call or not.

Fr=C3=A9d=C3=A9ric Dalleau (2):
  voicecall: manage multiparty list in AT+CHLD=3D3
  voicecall: manage multiparty list in AT+CHLD=3D2X

 src/voicecall.c |  113 +++++++++++++++++++++++++++++++++++++++++++++++++++=
+---
 1 files changed, 107 insertions(+), 6 deletions(-)


--===============2329392462622481019==--

