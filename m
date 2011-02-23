Content-Type: multipart/mixed; boundary="===============3554051765872710380=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH v4 0/2] bluetooth: add CIND and CIEV support in HFP AG
Date: Wed, 23 Feb 2011 18:02:12 +0100
Message-ID: <1298480534-12917-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3554051765872710380==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add CIND and CIEV support for HFP AG

Fr=C3=A9d=C3=A9ric Danis (2):
  emulator: add support of indicators
  emulator: add CIND support

 src/emulator.c |  155 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/network.c  |   77 +++++++++++++++++++++++++++-
 2 files changed, 231 insertions(+), 1 deletions(-)


--===============3554051765872710380==--

