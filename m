Content-Type: multipart/mixed; boundary="===============5587330702312527158=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [RFC v3 00/16] Add DUN support
Date: Tue, 13 Dec 2011 15:59:54 +0100
Message-ID: <1323788410-9988-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5587330702312527158==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

Hi,

Another update on this one. I splittet some patches more, in order to
make it more easy to review.

This version is now tested and works pretty good. The phone does some
funky stuff, but that is BT only. Tomorrow, I should get a BT sniffer
for getting those bugs fixed. This should only touch BlueZ though.

Here the list of changes for v3:

- use ofono_dbus_get_connection()
- splitting initial patch: dbus configuration and systemd configuration pat=
ch
- rename dun.c to dial.c
- change order of adding dial.c
- add ppp gatchat code to dial.c in a separate patch
- use own error name space on dbus (org.ofono.elect.error.Foo)
- pass own Connection Refused error message from bluez
- create and destroy dial object on device creation time. =


cheers,
daniel


Daniel Wagner (16):
  elect: Add skeleton implementation
  elect: Add D-Bus error messages
  elect: Add D-Bus configuration file
  elect: Add systemd configuration file
  elect: Add Manager interface
  elect: Add skeleton implementation for device
  elect: Manager append devices
  bluetooth: Add Serial interface definition
  elect: Add BlueZ hooks to device
  elect: Add device D-Bus interface
  elect: Dis/Connect Serial interface
  elect: Add skeleton dial implementation
  elect: Add ppp callbacks to device
  elect: Add GatChat and PPP handler
  elect: Add test scripts
  elect: Add documentation

 Makefile.am           |   25 ++
 bootstrap-configure   |    1 +
 configure.ac          |    4 +
 doc/elect-api.txt     |   86 ++++++
 elect/dbus.c          |   52 ++++
 elect/device.c        |  697 +++++++++++++++++++++++++++++++++++++++++++++=
++++
 elect/dial.c          |  206 +++++++++++++++
 elect/elect.conf      |   23 ++
 elect/elect.h         |   88 +++++++
 elect/elect.service   |   11 +
 elect/main.c          |  254 ++++++++++++++++++
 elect/manager.c       |  119 +++++++++
 plugins/bluetooth.h   |    1 +
 test/elect-connect    |   20 ++
 test/elect-disconnect |   20 ++
 test/monitor-elect    |  109 ++++++++
 16 files changed, 1716 insertions(+), 0 deletions(-)
 create mode 100644 doc/elect-api.txt
 create mode 100644 elect/dbus.c
 create mode 100644 elect/device.c
 create mode 100644 elect/dial.c
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


--===============5587330702312527158==--

