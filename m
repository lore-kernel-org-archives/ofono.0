Content-Type: multipart/mixed; boundary="===============4548161971163445527=="
MIME-Version: 1.0
From: Nicolas Bertrand <nicolas.bertrand@linux.intel.com>
Subject: [PATCH 0/2] Phonesim: add support for CSSU/CSSI notification
Date: Tue, 29 Mar 2011 17:16:34 +0200
Message-ID: <1301411796-18027-1-git-send-email-nicolas.bertrand@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4548161971163445527==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add UI to be able to send CSSU and CSSI notification with phonesim

Nicolas Bertrand (2):
  phonesim: add CSSU/CSSI UI
  phonesim: Add CSSU/CSSI notification support

 src/control.cpp    |   30 +++++++++++++++++++++++-
 src/control.h      |    2 +
 src/controlbase.ui |   65 +++++++++++++++++++++++++++++++++++++++++++-----=
---
 3 files changed, 85 insertions(+), 12 deletions(-)


--===============4548161971163445527==--

