Content-Type: multipart/mixed; boundary="===============8819949994389790019=="
MIME-Version: 1.0
From: Nicolas Bertrand <nicolas.bertrand@linux.intel.com>
Subject: [PATCH 0/5] Add support of remote hangup
Date: Wed, 18 May 2011 15:33:25 +0200
Message-ID: <1305725610-32602-1-git-send-email-nicolas.bertrand@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8819949994389790019==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

These patchs introduce the possibility of remote hangup
by selecting the call in the call table and use the new =

button "hangup".

Nicolas Bertrand (5):
  controlbase: Add hangup button
  callmanager: Remote hangup slot
  hardwaremanipulator: add hangup signal
  control: Handle hangup call
  phonesim: Connect hangup signal

 src/callmanager.cpp       |   23 +++++++++++++++++++++++
 src/callmanager.h         |    3 +++
 src/control.cpp           |   24 +++++++++++++++++++++++-
 src/control.h             |    2 ++
 src/controlbase.ui        |    7 +++++++
 src/hardwaremanipulator.h |    1 +
 src/phonesim.cpp          |    2 ++
 7 files changed, 61 insertions(+), 1 deletions(-)


--===============8819949994389790019==--

