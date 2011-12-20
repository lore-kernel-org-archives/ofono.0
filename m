Content-Type: multipart/mixed; boundary="===============4755232437766514479=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [RFC v4 00/16] Add DUN support
Date: Tue, 20 Dec 2011 15:47:03 +0100
Message-ID: <1324392439-26508-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4755232437766514479==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

Hi,

and another update. I have changed the series according the comments
from Denis. =


 - Renamed this project dundee
 - Reordering of the patches (doc and test scripts)
 - Move chat/ppp code into device.c
 - Change layering order: Add driver abstraction
 - Move bluetooth handling code from device.c into bluetooth.c

The corresponding patches for ConnMan are on the way. This version works
pretty good for me. =


cheers,
daniel

Daniel Wagner (16):
  bluetooth: Add Serial interface definition
  dundee: Add documentation
  dundee: Add test scripts
  dundee: Add skeleton implementation
  dundee: Add D-Bus error messages
  dundee: Add D-Bus configuration file
  dundee: Add systemd configuration file
  dundee: Add Manager interface
  dundee: Add skeleton implementation for device
  dundee: Manager append devices
  dundee: Add callback helpers
  dundee: Add device un/register
  dundee: Add driver helper functions
  dundee: Add device D-Bus interface
  dundee: Add PPP handling code to device
  dundee: Add Bluetooth DUN driver

 Makefile.am            |   25 ++
 bootstrap-configure    |    1 +
 configure.ac           |    4 +
 doc/dundee-api.txt     |   76 ++++++
 dundee/bluetooth.c     |  347 ++++++++++++++++++++++++++
 dundee/dbus.c          |   45 ++++
 dundee/device.c        |  643 ++++++++++++++++++++++++++++++++++++++++++++=
++++
 dundee/dundee.conf     |   23 ++
 dundee/dundee.h        |  145 +++++++++++
 dundee/dundee.service  |   11 +
 dundee/main.c          |  256 +++++++++++++++++++
 dundee/manager.c       |  119 +++++++++
 plugins/bluetooth.h    |    1 +
 test/dundee-connect    |   20 ++
 test/dundee-disconnect |   20 ++
 test/monitor-dundee    |  109 ++++++++
 16 files changed, 1845 insertions(+), 0 deletions(-)
 create mode 100644 doc/dundee-api.txt
 create mode 100644 dundee/bluetooth.c
 create mode 100644 dundee/dbus.c
 create mode 100644 dundee/device.c
 create mode 100644 dundee/dundee.conf
 create mode 100644 dundee/dundee.h
 create mode 100644 dundee/dundee.service
 create mode 100644 dundee/main.c
 create mode 100644 dundee/manager.c
 create mode 100755 test/dundee-connect
 create mode 100755 test/dundee-disconnect
 create mode 100755 test/monitor-dundee

-- =

1.7.8.110.g4cb5d1


--===============4755232437766514479==--

