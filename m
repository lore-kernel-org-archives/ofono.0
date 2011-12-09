Content-Type: multipart/mixed; boundary="===============8715018063396176646=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [RFC v2 00/11] Add DUN support
Date: Fri, 09 Dec 2011 17:35:35 +0100
Message-ID: <1323448546-2728-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8715018063396176646==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

Hi,

This is now the splittet version of the previous huge patch. =

It is only compile tested so far. I have changed a few things
and cleanup stuff. Consider this version just as work in progress.
If you spot something stupid tell me now :)

Have a nice weekend!
daniel

ps: yep, I know the commit message is crap. =


Daniel Wagner (11):
  elect: Add skeleton implementation
  elect: Add Manager interface
  elect: Add skeleton implementation for device
  bluetooth: Add Serial interface definition
  elect: Add BlueZ hooks to device
  elect: Add device D-Bus interface
  elect: Dis/Connect Serial interface
  elect: Add ppp callbacks to device
  elect: Add GatChat and PPP handler
  elect: Add test scripts
  elect: Add documentation

 Makefile.am           |   24 ++
 bootstrap-configure   |    1 +
 configure.ac          |    4 +
 doc/elect-api.txt     |   86 ++++++
 elect/device.c        |  696 +++++++++++++++++++++++++++++++++++++++++++++=
++++
 elect/dun.c           |  207 +++++++++++++++
 elect/elect.conf      |   23 ++
 elect/elect.h         |  100 +++++++
 elect/elect.service   |   11 +
 elect/main.c          |  254 ++++++++++++++++++
 elect/manager.c       |  120 +++++++++
 plugins/bluetooth.h   |    1 +
 test/elect-connect    |   20 ++
 test/elect-disconnect |   20 ++
 test/monitor-elect    |  109 ++++++++
 15 files changed, 1676 insertions(+), 0 deletions(-)
 create mode 100644 doc/elect-api.txt
 create mode 100644 elect/device.c
 create mode 100644 elect/dun.c
 create mode 100644 elect/elect.conf
 create mode 100644 elect/elect.h
 create mode 100644 elect/elect.service
 create mode 100644 elect/main.c
 create mode 100644 elect/manager.c
 create mode 100755 test/elect-connect
 create mode 100755 test/elect-disconnect
 create mode 100755 test/monitor-elect

-- =

1.7.8.110.g4cb5d1


--===============8715018063396176646==--

