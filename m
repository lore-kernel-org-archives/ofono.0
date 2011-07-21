Content-Type: multipart/mixed; boundary="===============0448508537204893485=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v2 4/4] test: add script to set credentials for cdma connection
Date: Thu, 21 Jul 2011 06:40:44 +0200
Message-ID: <1311223244-26904-5-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1311223244-26904-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0448508537204893485==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/create-cdma-credentials |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)
 create mode 100755 test/create-cdma-credentials

diff --git a/test/create-cdma-credentials b/test/create-cdma-credentials
new file mode 100755
index 0000000..0f52a98
--- /dev/null
+++ b/test/create-cdma-credentials
@@ -0,0 +1,29 @@
+#!/usr/bin/python
+
+import dbus
+import sys
+
+bus =3D dbus.SystemBus()
+
+manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
+						'org.ofono.Manager')
+
+modems =3D manager.GetModems()
+
+for path, properties in modems:
+	if "org.ofono.cdma.ConnectionManager" not in properties["Interfaces"]:
+		continue
+
+	cm =3D dbus.Interface(bus.get_object('org.ofono', path),
+					'org.ofono.cdma.ConnectionManager')
+
+	print "Connecting CDMA Packet Data Service on modem %s..." % path
+
+	if len(sys.argv) > 1:
+		cm.SetProperty("Username", (sys.argv[1]))
+		print "Setting Username to %s" % (sys.argv[1])
+
+	if len(sys.argv) > 2:
+		cm.SetProperty("Password", (sys.argv[2]))
+		print "Setting Password to %s" % (sys.argv[2])
+
-- =

1.7.1


--===============0448508537204893485==--

