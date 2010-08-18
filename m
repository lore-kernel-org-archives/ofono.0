Content-Type: multipart/mixed; boundary="===============2413070718596786447=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 6/6] test: add get-icon script
Date: Wed, 18 Aug 2010 04:25:23 -0700
Message-ID: <1282130723-10488-7-git-send-email-kristen@linux.intel.com>
In-Reply-To: <1282130723-10488-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2413070718596786447==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/get-icon |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)
 create mode 100755 test/get-icon

diff --git a/test/get-icon b/test/get-icon
new file mode 100755
index 0000000..680ae13
--- /dev/null
+++ b/test/get-icon
@@ -0,0 +1,25 @@
+#!/usr/bin/python
+
+import dbus
+import sys
+
+bus =3D dbus.SystemBus()
+
+if len(sys.argv) =3D=3D 3:
+	path =3D sys.argv[1]
+	id =3D int(sys.argv[2], 16)
+elif len(sys.argv) =3D=3D 2:
+	manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
+				 'org.ofono.Manager')
+	properties =3D manager.GetProperties()
+	path =3D properties["Modems"][0]
+	id =3D int(sys.argv[1], 16)
+else:
+	print "%s [PATH] icon_id" % (sys.argv[0])
+
+simmanager =3D dbus.Interface(bus.get_object('org.ofono', path),
+			    'org.ofono.SimManager')
+
+xpm =3D simmanager.GetIcon(id)
+
+print "Received xpm: %s" % (xpm)
-- =

1.7.2.1


--===============2413070718596786447==--

