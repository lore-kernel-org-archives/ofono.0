Content-Type: multipart/mixed; boundary="===============7055298479766924508=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH V4 0/2] Add dial support for HFP emulator
Date: Tue, 07 Jun 2011 15:33:09 +0200
Message-ID: <1307453591-17538-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7055298479766924508==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add support of ATD and AT+BLDN

Fr=C3=A9d=C3=A9ric Danis (2):
  voicecall: add ATD support for HFP emulator
  voicecall: add +BLDN support for HFP emulator

 src/voicecall.c |  195 ++++++++++++++++++++++++++++++++++++++++++++++++++-=
----
 1 files changed, 178 insertions(+), 17 deletions(-)


--===============7055298479766924508==--

