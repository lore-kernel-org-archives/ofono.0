Content-Type: multipart/mixed; boundary="===============2298439069781899418=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: [PATCHv4 0/1] STE Modem Init Daemon integration
Date: Tue, 04 Jan 2011 20:07:38 +0100
Message-ID: <1294168059-8839-1-git-send-email-sjurbren@gmail.com>
In-Reply-To: <1294134564.5852.96.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2298439069781899418==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Sjur Br=C3=A6ndeland <sjur.brandeland@stericsson.com>

This is the latest version of the Modem Init Daemon API.

STE Modem Init Deamon Manager
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D

Service		com.stericsson.modeminit
Interface	com.stericsson.modeminit.Manager
Object path	/

Methods		array{object,dict} GetModems()

			Get array of STE Modem objects and their state and
			properties (out signature 'a(oa{sv})').

			The method should only be call once per application.
			Further changes shall be monitored via StateChange
			signals.

STE Modem
=3D=3D=3D=3D=3D=3D=3D=3D=3D
Service		com.stericsson.modeminit
Interface	com.stericsson.modeminit.Modem
Object path	variable

Signals		PropertyChanged(string property, variant value)

			This signal indicates a changed value of the given
			property.

Properties	string State [readonly]

			The modems state is dynamic can can have the following
			values:
			"booting"   Modem is powered up (flashed version)
				    or Modem is powered up and firmware upload
				    is completed. (flashless version)
			"upgrading" Firmware upgrade on going
				    or Flashing manager under execution -
				    modem in service mode.
			"ready"	    Modem has booted and is ready for use.
				    This implies that all AT channels are
				    available, the modem might be in
				    e.g. flight mode.

			"dumping"  Modem has crashed and dump is ongoing
			"off"	    Modem is powered off.

		string Interface[readonly]

			CAIF Link Layer interface to be used for
			CAIF channels for a modem.

		string Serial[optional,readonly]

			Serial Number or IMEI for the Modem. The Serial will
			not be available until the modem can open an AT channel.


Sjur Br=C3=A6ndeland (1):
  plugin: Add ste modem initd integration

 Makefile.am      |    4 +
 plugins/stemgr.c |  345 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 349 insertions(+), 0 deletions(-)
 create mode 100644 plugins/stemgr.c


--===============2298439069781899418==--

