Content-Type: multipart/mixed; boundary="===============4717948294152796769=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 16/16] emulator: Add doc/emulator-api.txt
Date: Thu, 13 May 2010 18:02:39 +0800
Message-ID: <1273744959-3711-17-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1273744959-3711-16-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4717948294152796769==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add doc for emulator interface.
---
 doc/emulator-api.txt |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)
 create mode 100644 doc/emulator-api.txt

diff --git a/doc/emulator-api.txt b/doc/emulator-api.txt
new file mode 100644
index 0000000..42af66d
--- /dev/null
+++ b/doc/emulator-api.txt
@@ -0,0 +1,32 @@
+Emulator hierarchy
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Service		org.ofono
+Interface	org.ofono.Emulator
+Object path	[variable prefix]/{modem0,modem1,...}/{emulator01,emulator02,.=
..}
+
+Methods		dict GetProperties()
+
+			Returns all properties for this object. See the
+			properties section for available properties.
+
+		void Destroy()
+
+			Destroy the emulator and unregister from D-Bus
+			interface.
+
+Signals		PropertyChanged(string property, variant value)
+
+			Signal is emitted whenever a property has changed.
+			The new value is passed as the signal argument.
+
+Properties	string Type [readonly]
+
+			Contains the type of current emulator.  The type can be
+			one of:
+				- "DUN" - Dial-Up Network.
+				- "HFP AG" - Hands-free gateway role.
+				- "SPP" - Serial Port Profile.
+
+		string PATH [readonly]
+			Contains the object path of current emulator.
-- =

1.6.3.3


--===============4717948294152796769==--

