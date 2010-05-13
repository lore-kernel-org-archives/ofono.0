Content-Type: multipart/mixed; boundary="===============0034157597959959466=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 15/16] emulator: Add doc/emulatormanager-api.txt
Date: Thu, 13 May 2010 18:02:38 +0800
Message-ID: <1273744959-3711-16-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1273744959-3711-15-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0034157597959959466==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add doc for emulator manager interface
---
 doc/emulatormanager-api.txt |   42 +++++++++++++++++++++++++++++++++++++++=
+++
 1 files changed, 42 insertions(+), 0 deletions(-)
 create mode 100644 doc/emulatormanager-api.txt

diff --git a/doc/emulatormanager-api.txt b/doc/emulatormanager-api.txt
new file mode 100644
index 0000000..f0966c3
--- /dev/null
+++ b/doc/emulatormanager-api.txt
@@ -0,0 +1,42 @@
+EmulatorManager hierarchy
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
+
+Service		org.ofono
+Interface	org.ofono.EmulatorManager
+Object path	[variable prefix]/{modem0,modem1,...}
+
+Methods		dict GetProperties()
+
+			Returns all global system properties. See the
+			properties section for available properties.
+
+		object Create(string type, int fd)
+
+			Creates an emulator with given type and file
+			descriptor. Returns the object path of the newly
+			created emulator.
+
+			The defined types are:
+				"DUN" - Dial-Up Network.
+				"HFP AG" - Bluetooth Hands-free gateway role.
+					It talks to the HFP unit role client
+					through Bluetooth connection.
+				"SPP" - Serial Port Profile.
+
+			Possible Errors: [service].Error.InvalidArguments
+					 [service].Error.Failed
+
+		void DestroyAll()
+
+			Releases all emulators.
+
+Signals		PropertyChanged(string property, variant value)
+
+			Signal is emitted whenever a property has changed. The
+			new value is passed as the signal argument.
+
+Properties	array{object} Emulators [readonly]
+
+			Returns the list of emulators currently present in the
+			system. If there are no emulators, the list will be
+			empty.
-- =

1.6.3.3


--===============0034157597959959466==--

