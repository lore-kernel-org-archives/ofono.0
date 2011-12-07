Content-Type: multipart/mixed; boundary="===============4339131238667988105=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v0 6/6] test: Add script to set dormant interval
Date: Wed, 07 Dec 2011 17:05:51 +0100
Message-ID: <1323273951-24162-7-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1323273951-24162-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4339131238667988105==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am                    |    1 +
 test/cdma-set-dormant-interval |   24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+), 0 deletions(-)
 create mode 100755 test/cdma-set-dormant-interval

diff --git a/Makefile.am b/Makefile.am
index 337aeb7..4555c09 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -549,6 +549,7 @@ test_scripts =3D test/backtrace \
 		test/cdma-dial-number \
 		test/cdma-hangup \
 		test/cdma-set-credentials \
+		test/cdma-set-dormant-interval \
 		test/disable-call-forwarding \
 		test/list-messages \
 		test/test-sms \
diff --git a/test/cdma-set-dormant-interval b/test/cdma-set-dormant-interval
new file mode 100755
index 0000000..f41bcd2
--- /dev/null
+++ b/test/cdma-set-dormant-interval
@@ -0,0 +1,24 @@
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
+		cm.SetProperty("DormantInterval", int(sys.argv[1]))
+		print "Setting Dormant Interval to %s seconds" % (sys.argv[1])
-- =

1.7.1


--===============4339131238667988105==--

