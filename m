Content-Type: multipart/mixed; boundary="===============3378476729820492922=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH V3 0/4] Add dial support for HFP emulator
Date: Wed, 01 Jun 2011 13:24:19 +0200
Message-ID: <1306927463-10642-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3378476729820492922==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Create a generic dial function that can be called by DBus or emulator
Add support of ATD and AT+BLDN
Save last dialed number in /var/lib/ofono/<modem>/voicecall to be used
by AT+BLDN

Fr=C3=A9d=C3=A9ric Danis (4):
  voicecall: create generic dial function
  voicecall: add ATD support for HFP emulator
  voicecall: save last dialed number
  voicecall: add +BLDN support for HFP emulator

 src/voicecall.c |  270 +++++++++++++++++++++++++++++++++++++++++++++++++--=
----
 1 files changed, 243 insertions(+), 27 deletions(-)


--===============3378476729820492922==--

