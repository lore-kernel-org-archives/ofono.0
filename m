Content-Type: multipart/mixed; boundary="===============7605520205373829425=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: [PATCH v3 00/13] Add support for BlueZ 5 Profile1 API to dundee
Date: Wed, 20 Mar 2013 19:26:29 -0300
Message-ID: <1363818402-17710-1-git-send-email-paulo.borges@openbossa.org>
In-Reply-To: <1362425590-26075-1-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7605520205373829425==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This series implements support for BlueZ 5 to dundee. It uses the
org.bluez.Profile1 API to register an external profile.

While the interface between BlueZ and dundee has changed, the interfaces
"org.ofono.dundee.Device" and "org.ofono.dundee.Manager" remains
unchanged.

Paulo Borges (13):
  dundee: Rename dundee BlueZ 4 support
  dundee: Start BlueZ 5 support
  bluez5: Add DUN_UUID
  dundee: Initial GDBusClient for BlueZ 5
  dundee: Add mechanism to store bluetooth devices
  dundee: Add tracking of bluetooth devices
  dundee: Listen to devices property changes
  dundee: Add dundee device driver skeleton
  dundee: Register/unregister dundee device
  dundee: Add BlueZ Profile handler
  dundee: Add support for driver connect
  dundee: Add dundee disconnect function
  dundee: Handle Profile connect and disconnect

 Makefile.am        |   15 +-
 dundee/bluetooth.c |  297 ------------------------------------
 dundee/bluez4.c    |  297 ++++++++++++++++++++++++++++++++++++
 dundee/bluez5.c    |  422 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 dundee/device.c    |   14 +-
 dundee/dundee.h    |    5 +
 plugins/bluez5.h   |    1 +
 7 files changed, 746 insertions(+), 305 deletions(-)
 delete mode 100644 dundee/bluetooth.c
 create mode 100644 dundee/bluez4.c
 create mode 100644 dundee/bluez5.c

-- =

1.7.9.5


--===============7605520205373829425==--

