Content-Type: multipart/mixed; boundary="===============8360082058913277377=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH v2 0/2] HFP: add call related indicators
Date: Fri, 18 Mar 2011 17:10:46 +0100
Message-ID: <1300464648-11074-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8360082058913277377==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add call, callsetup and callheld indicators for +CIEV

Fr=C3=A9d=C3=A9ric Danis (2):
  emulator: add defines for call, callsetup and callheld indicators
  emulator: add call, callsetup and callheld indicators

 include/emulator.h |   12 +++++++
 src/emulator.c     |    5 +++
 src/voicecall.c    |   92 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 109 insertions(+), 0 deletions(-)


--===============8360082058913277377==--

