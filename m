Content-Type: multipart/mixed; boundary="===============1400173013432798168=="
MIME-Version: 1.0
From: Nicolas Bertrand <nicolas.bertrand@linux.intel.com>
Subject: [PATCH 0/5] Introduce call management buttons
Date: Wed, 11 May 2011 13:46:42 +0200
Message-ID: <1305114407-23796-1-git-send-email-nicolas.bertrand@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1400173013432798168==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch add support of call state management.
Buttons Alerting and Active permit to change the state of on-going call.

Nicolas Bertrand (5):
  controlbase: Add call state management buttons
  hardwaremanipulator: Call state changed signals
  callmanager: Change call state management slots
  control: handle call management buttons
  phonesim: connect call mangagement signals

 src/callmanager.cpp       |    7 +++++++
 src/callmanager.h         |   12 ++++++------
 src/control.cpp           |   12 ++++++++++++
 src/control.h             |    2 ++
 src/controlbase.ui        |   18 ++++++++++++++++++
 src/hardwaremanipulator.h |    2 ++
 src/phonesim.cpp          |    4 ++++
 7 files changed, 51 insertions(+), 6 deletions(-)


--===============1400173013432798168==--

