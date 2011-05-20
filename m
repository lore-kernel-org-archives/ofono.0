Content-Type: multipart/mixed; boundary="===============5968476781623128389=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH V2 0/4] Add dial support for HFP emulator
Date: Fri, 20 May 2011 11:40:57 +0200
Message-ID: <1305884461-4476-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5968476781623128389==
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

 src/voicecall.c |  245 +++++++++++++++++++++++++++++++++++++++++++++++++--=
----
 1 files changed, 218 insertions(+), 27 deletions(-)


--===============5968476781623128389==--

