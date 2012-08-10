Content-Type: multipart/mixed; boundary="===============3455807604952393827=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: [PATCH] test: Add test script to list services properties
Date: Fri, 10 Aug 2012 17:16:14 +0200
Message-ID: <1344611774-20156-2-git-send-email-ronald.tessier@linux.intel.com>
In-Reply-To: <1344611774-20156-1-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3455807604952393827==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/list-services |   27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100755 test/list-services

diff --git a/test/list-services b/test/list-services
new file mode 100755
index 0000000..bd52d71
--- /dev/null
+++ b/test/list-services
@@ -0,0 +1,27 @@
+#!/usr/bin/python
+
+import dbus
+
+bus =3D dbus.SessionBus()
+
+manager =3D dbus.Interface(bus.get_object('org.ofono.mms', '/org/ofono/mms=
'),
+						'org.ofono.mms.Manager')
+
+services =3D manager.GetServices()
+
+for path, properties in services:
+	print "[ %s ]" % (path)
+
+	object =3D dbus.Interface(bus.get_object('org.ofono.mms', path),
+						'org.ofono.mms.Service')
+
+	try:
+		properties =3D object.GetProperties()
+	except:
+		continue
+
+	for key in properties.keys():
+		val =3D str(properties[key])
+		print "        %s =3D %s" % (key, val)
+
+	print
-- =

1.7.9.5


--===============3455807604952393827==--

