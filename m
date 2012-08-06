Content-Type: multipart/mixed; boundary="===============5979264626141499785=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: [PATCH 4/4] test: Add a script to set the delivery-report flag
Date: Mon, 06 Aug 2012 17:31:00 +0200
Message-ID: <1344267060-5541-5-git-send-email-ronald.tessier@linux.intel.com>
In-Reply-To: <1344267060-5541-1-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5979264626141499785==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/set-dr |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100755 test/set-dr

diff --git a/test/set-dr b/test/set-dr
new file mode 100755
index 0000000..99c72b1
--- /dev/null
+++ b/test/set-dr
@@ -0,0 +1,25 @@
+#!/usr/bin/python
+
+import sys
+import dbus
+
+bus =3D dbus.SessionBus()
+
+manager =3D dbus.Interface(bus.get_object('org.ofono.mms', '/org/ofono/mms=
'),
+					'org.ofono.mms.Manager')
+
+services =3D manager.GetServices()
+path =3D services[0][0]
+
+service =3D dbus.Interface(bus.get_object('org.ofono.mms', path),
+						'org.ofono.mms.Service')
+
+if len(sys.argv) > 1:
+	allowed =3D dbus.Boolean(int(sys.argv[1]))
+else:
+	allowed =3D dbus.Boolean(1)
+
+service.SetProperty("UseDeliveryReports", allowed)
+
+print "Setting delivery report use for %s...(UseDeliveryReports=3D%d)" %\
+	(path, allowed)
-- =

1.7.9.5


--===============5979264626141499785==--

