Content-Type: multipart/mixed; boundary="===============4068036975159809286=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Dalleau <frederic.dalleau@linux.intel.com>
Subject: [PATCH 0/2] Manage multiparty list in emulator CHLD calls
Date: Wed, 29 Jun 2011 21:38:51 +0200
Message-ID: <1309376333-6076-1-git-send-email-frederic.dalleau@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4068036975159809286==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

These patches will manage the multiparty list in emulator CHLD calls.
This allow the mpty field of +CLCC to be set to 1 or 0 depending if there i=
s a multiparty call or not.

Fr=C3=A9d=C3=A9ric Dalleau (2):
  voicecall: manage multiparty list in AT+CHLD=3D3
  voicecall: manage multiparty list in AT+CHLD=3D2X

 src/voicecall.c |  125 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++-
 1 files changed, 122 insertions(+), 3 deletions(-)


--===============4068036975159809286==--

