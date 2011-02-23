Content-Type: multipart/mixed; boundary="===============1571973050971306041=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH v3 0/3] bluetooth: add CIND and CIEV support in HFP AG
Date: Wed, 23 Feb 2011 16:48:47 +0100
Message-ID: <1298476130-8969-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1571973050971306041==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add indicator support in emulator atom
Add CIND and CIEV support for HFP AG

Fr=C3=A9d=C3=A9ric Danis (3):
  emulator: add indicator support API
  emulator: add support of indicators
  emulator: add CIND support

 include/emulator.h |   11 ++++
 src/emulator.c     |  145 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/network.c      |   77 +++++++++++++++++++++++++++-
 3 files changed, 232 insertions(+), 1 deletions(-)


--===============1571973050971306041==--

