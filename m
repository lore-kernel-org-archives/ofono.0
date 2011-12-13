Content-Type: multipart/mixed; boundary="===============6188350641138904026=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [RFC v3 16/16] elect: Add documentation
Date: Tue, 13 Dec 2011 16:00:10 +0100
Message-ID: <1323788410-9988-17-git-send-email-wagi@monom.org>
In-Reply-To: <1323788410-9988-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6188350641138904026==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 doc/elect-api.txt |   86 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 86 insertions(+), 0 deletions(-)
 create mode 100644 doc/elect-api.txt

diff --git a/doc/elect-api.txt b/doc/elect-api.txt
new file mode 100644
index 0000000..a603266
--- /dev/null
+++ b/doc/elect-api.txt
@@ -0,0 +1,86 @@
+
+Manager hierarchy
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Service		org.ofono.elect
+Interface	org.ofono.elect.Manager
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
+Service		org.ofono.elect
+Interface	org.ofono.elect.Device
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
+			string Method [readonly, optional]
+
+				Holds the IP network config method.
+					"static"- Set IP network statically
+					"dhcp"  - Set IP network through DHCP
+
+			string Address [readonly, optional]
+
+				Holds the IP address for this connection.
+
+			string Netmask [readonly, optional]
+
+				Holds the Netmask for this connection.
+
+			array{string} DomainNameServers [readonly, optional]
+
+				Holds the list of domain name servers for this
+				connection.
-- =

1.7.8.110.g4cb5d1


--===============6188350641138904026==--

