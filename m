Content-Type: multipart/mixed; boundary="===============2424315807454865619=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [PATCH v5 00/16] Add DUN support
Date: Wed, 04 Jan 2012 18:17:34 +0100
Message-ID: <1325697470-22227-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2424315807454865619==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

Hi,

I think this series is ready to be considered to be merged *hint* :)

Changes v5:
 - Use Serial.ConnectFD() instead of Serial.Connect()
 - Small bug fix in disconnect callback

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
 dundee/bluetooth.c     |  290 ++++++++++++++++++++++
 dundee/dbus.c          |   45 ++++
 dundee/device.c        |  646 ++++++++++++++++++++++++++++++++++++++++++++=
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
 16 files changed, 1791 insertions(+), 0 deletions(-)
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

1.7.8.2.302.g17b4


--===============2424315807454865619==--

