Content-Type: multipart/mixed; boundary="===============2826407869968473275=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH 0/4] bluetooth: add CIND and CIEV support for HFP AG
Date: Fri, 18 Feb 2011 17:34:04 +0100
Message-ID: <1298046848-24622-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2826407869968473275==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add signal strength APIs in netreg atom
Add CIND and CIEV support in emulator atom for service,
roaming and signal indicators

Fr=C3=A9d=C3=A9ric Danis (4):
  emulator: add network info support for HFP
  netreg: add get signal strength API
  netreg: add support for signal strength get and watch APIs
  emulator: add network signal support for HFP

 include/netreg.h |    1 +
 src/emulator.c   |  162 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/network.c    |   61 ++++++++++++++++++++
 src/ofono.h      |   10 +++
 4 files changed, 234 insertions(+), 0 deletions(-)


--===============2826407869968473275==--

