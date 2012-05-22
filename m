Content-Type: multipart/mixed; boundary="===============5983144362190611823=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [PATCH v7 00/16] Add DUN support
Date: Tue, 22 May 2012 18:33:08 +0200
Message-ID: <1337704404-5260-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5983144362190611823==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

Hi,

Changes v7:
 - Fixed test scripts
 - SetProperty("Active", True) will be deferred until PPP link is up =

   or an error happens
 - GDBUS changes added
 - Fixed a crash in set_property_active: device->ppp can be NULL
 - Copyright year update and whitespace fixes

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

 Makefile.am              |   25 ++
 bootstrap-configure      |    1 +
 configure.ac             |    7 +-
 doc/dundee-api.txt       |   76 ++++++
 dundee/bluetooth.c       |  290 ++++++++++++++++++++
 dundee/dbus.c            |   45 ++++
 dundee/device.c          |  660 ++++++++++++++++++++++++++++++++++++++++++=
++++
 dundee/dundee.conf       |   23 ++
 dundee/dundee.h          |  144 ++++++++++
 dundee/dundee.service.in |   11 +
 dundee/main.c            |  256 ++++++++++++++++++
 dundee/manager.c         |  122 +++++++++
 plugins/bluetooth.h      |    1 +
 test/dundee-connect      |   20 ++
 test/dundee-disconnect   |   20 ++
 test/monitor-dundee      |  109 ++++++++
 16 files changed, 1809 insertions(+), 1 deletion(-)
 create mode 100644 doc/dundee-api.txt
 create mode 100644 dundee/bluetooth.c
 create mode 100644 dundee/dbus.c
 create mode 100644 dundee/device.c
 create mode 100644 dundee/dundee.conf
 create mode 100644 dundee/dundee.h
 create mode 100644 dundee/dundee.service.in
 create mode 100644 dundee/main.c
 create mode 100644 dundee/manager.c
 create mode 100755 test/dundee-connect
 create mode 100755 test/dundee-disconnect
 create mode 100755 test/monitor-dundee

-- =

1.7.10.130.g36e6c


--===============5983144362190611823==--

