Content-Type: multipart/mixed; boundary="===============3697704363290331981=="
MIME-Version: 1.0
From: Nicolas Bertrand <nicolas.bertrand@linux.intel.com>
Subject: [PATCH v2 0/6] phonesim: Add call status UI 
Date: Mon, 02 May 2011 11:17:12 +0200
Message-ID: <1304327838-11164-1-git-send-email-nicolas.bertrand@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3697704363290331981==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This  patch introduce a new tab "call" in phonesim UI in order to display c=
alls
informationsi (id, number, status, name and direction).
The interface to send CSSU and CSSI notification is now dynamic based on the
type of current calls.
Fix some coding-style violations.

Nicolas Bertrand (6):
  callmanager: Add signal on call status change
  control: Update UI using call status
  hardwaremanipulator: add callmanagement method
  phonesim: Connect call status signal
  controlbase.ui: Add call mangement tab
  control: Update call view

 src/callmanager.cpp         |   22 +++++++
 src/callmanager.h           |    3 +
 src/control.cpp             |  140 ++++++++++++++++++++++++++++++++++++++-=
----
 src/control.h               |    6 ++
 src/controlbase.ui          |   61 +++++++++++++++++++
 src/hardwaremanipulator.cpp |    4 +
 src/hardwaremanipulator.h   |    2 +
 src/phonesim.cpp            |    2 +
 8 files changed, 224 insertions(+), 16 deletions(-)


--===============3697704363290331981==--

