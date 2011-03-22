Content-Type: multipart/mixed; boundary="===============0243101478673247884=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 0/2] Extend Phonesim to support BIP commands
Date: Tue, 22 Mar 2011 14:10:11 +0100
Message-ID: <1300799413-4479-1-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0243101478673247884==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



Philippe Nunes (2):
  qsimcommand: Add properties and TLV builders to support BIP commands
  simapplication: Add a new SIM applet dedicated to BIP commands

 src/qsimcommand.cpp    |  201 ++++++++++++++++++++++++++++++++++++++++++++=
++--
 src/qsimcommand.h      |   34 ++++++++
 src/simapplication.cpp |  161 ++++++++++++++++++++++++++++++++++++++
 src/simapplication.h   |    2 +
 4 files changed, 391 insertions(+), 7 deletions(-)


--===============0243101478673247884==--

