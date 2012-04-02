Content-Type: multipart/mixed; boundary="===============4236870824226384541=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [PATCH v6 02/16] dundee: Add documentation
Date: Mon, 02 Apr 2012 18:20:00 +0200
Message-ID: <1333383614-4921-3-git-send-email-wagi@monom.org>
In-Reply-To: <1333383614-4921-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4236870824226384541==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 doc/dundee-api.txt |   76 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 76 insertions(+)
 create mode 100644 doc/dundee-api.txt

diff --git a/doc/dundee-api.txt b/doc/dundee-api.txt
new file mode 100644
index 0000000..9f4cfe6
--- /dev/null
+++ b/doc/dundee-api.txt
@@ -0,0 +1,76 @@
+
+Manager hierarchy
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Service		org.ofono.dundee
+Interface	org.ofono.dundee.Manager
+Object path	/
+
+Methods		array{object,dict} GetDevices()
+
+			Get an array of device objects and properties
+			that represent the currently attached devices.
+
+			This method call should only be used once when an
+			application starts up. Further device additions
+			and removal shall be monitored via DeviceAdded and
+			DeviceRemoved signals.
+
+Signals		DeviceAdded(object path, dict properties)
+
+			Signal that is sent when a new device is added.  It
+			contains the object path of new device and its
+			properties.
+
+		DeviceRemoved(object path)
+
+			Signal that is sent when a device has been removed.
+			The object path is no longer accessible after this
+			signal and only emitted for reference.
+
+
+Device hierarchy
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Service		org.ofono.dundee
+Interface	org.ofono.dundee.Device
+Object path	/{device0,device1,...}
+
+Methods		dict GetProperties()
+
+			Returns properties for the device object. See
+			the properties section for available properties.
+
+Signals		PropertyChanged(string name, variant value)
+
+			This signal indicates a changed value of the given
+			property.
+
+Properties	string Name [readonly]
+
+			Friendly name of the device.
+
+		boolean Active [readwrite]
+
+			Holds whether the device is connected. A
+			connection will be established when this value
+			is set to true. A existing connection will be
+			teared down when set to false.
+
+		dict Settings [readonly]
+
+			Holds all the IP network settings.
+
+			string Interface [readonly, optional]
+
+				Holds the interface of the network interface
+				used by this connection (e.g. "ppp0" "usb0")
+
+			string Address [readonly, optional]
+
+				Holds the IP address for this connection.
+
+			array{string} DomainNameServers [readonly, optional]
+
+				Holds the list of domain name servers for this
+				connection.
-- =

1.7.10.rc3.1.gb3065


--===============4236870824226384541==--

