Content-Type: multipart/mixed; boundary="===============0740231030059757241=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 0/6] Add conformance sim application
Date: Tue, 11 Jan 2011 16:16:04 +0200
Message-ID: <1294755370-12442-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0740231030059757241==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

 Following set of patches adds the ui support for selecting
sim applications and also adds conformance sim application.
DisplayText, Get Inkey, Get Input and MoreTime test cases
are added to the conformance sim application. Logging of the
result in a file can be done but it is not part of this patch.

Regards,
Jeevaka

Jeevaka Badrappan (6):
  phonesim: add ui support for sim app selection
  phonesim: Add conformance sim application
  phonesim: Add DisplayText test cases
  phonesim: Add Get Inkey test cases
  phonesim: Add Get Input test cases
  phonesim: Add MoreTime test case

 Makefile.am                       |    3 +-
 src/conformancesimapplication.cpp | 1732 +++++++++++++++++++++++++++++++++=
++++
 src/control.cpp                   |    5 +-
 src/controlbase.ui                |   10 +-
 src/hardwaremanipulator.cpp       |   19 +-
 src/hardwaremanipulator.h         |    4 +-
 src/phonesim.cpp                  |   28 +-
 src/phonesim.h                    |    4 +
 src/simapplication.h              |   33 +
 9 files changed, 1808 insertions(+), 30 deletions(-)
 create mode 100644 src/conformancesimapplication.cpp


--===============0740231030059757241==--

