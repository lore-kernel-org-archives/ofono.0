Content-Type: multipart/mixed; boundary="===============7486734827902930580=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH V5 0/2] Add dial support for HFP emulator
Date: Wed, 08 Jun 2011 15:47:23 +0200
Message-ID: <1307540845-9889-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7486734827902930580==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add support of ATD and AT+BLDN

Fr=C3=A9d=C3=A9ric Danis (2):
  voicecall: add ATD support for HFP emulator
  voicecall: add +BLDN support for HFP emulator

 src/voicecall.c |  199 +++++++++++++++++++++++++++++++++++++++++++++++++--=
---
 1 files changed, 180 insertions(+), 19 deletions(-)


--===============7486734827902930580==--

