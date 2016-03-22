Content-Type: multipart/mixed; boundary="===============1800248804266396863=="
MIME-Version: 1.0
From: Samrat Guha Niyogi <samrat.guha.niyogi@intel.com>
Subject: [PATCH] test: Add sms bearer set and SMSC set scripts
Date: Tue, 22 Mar 2016 16:19:35 +0530
Message-ID: <1458643775-18338-1-git-send-email-samrat.guha.niyogi@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1800248804266396863==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Anirudh Gargi <anirudh.gargi@intel.com>

---
 test/set-sms-bearer | 31 +++++++++++++++++++++++++++++++
 test/set-sms-smsc   | 31 +++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+)
 create mode 100755 test/set-sms-bearer
 create mode 100755 test/set-sms-smsc

diff --git a/test/set-sms-bearer b/test/set-sms-bearer
new file mode 100755
index 0000000..33e64e3
--- /dev/null
+++ b/test/set-sms-bearer
@@ -0,0 +1,31 @@
+#!/usr/bin/python3
+import sys
+import dbus
+
+if len(sys.argv) < 2:
+        print("Usage: %s <bearer> Bearer types: <cs-only> <ps-only> <cs-pr=
eferred> <ps-preferred>" %\
+                                        (sys.argv[0]))
+        sys.exit(1)
+
+def message_bearer(sms, value):
+	try:
+            sms.SetProperty("Bearer", dbus.String(value))
+	except dbus.DBusException as e:
+            print("Unable to set Bearer[%s] - FAIL" % (value))
+            exit(1)
+
+bus =3D dbus.SystemBus()
+manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),'org.ofono.Man=
ager')
+modems =3D manager.GetModems()
+value  =3D sys.argv[1]
+
+for path, properties in modems:
+	print("Setting bearer for [ %s ]" % (path))
+
+	if "org.ofono.MessageManager" not in properties["Interfaces"]:
+		continue
+
+        sms =3D dbus.Interface(bus.get_object('org.ofono', path), 'org.ofo=
no.MessageManager')
+
+        message_bearer(sms, value)
+        print("SMS Bearer updated for [ %s ]" % (path))
diff --git a/test/set-sms-smsc b/test/set-sms-smsc
new file mode 100755
index 0000000..7fc9e4d
--- /dev/null
+++ b/test/set-sms-smsc
@@ -0,0 +1,31 @@
+#!/usr/bin/python3
+import sys
+import dbus
+
+if len(sys.argv) < 2:
+        print("Usage: %s <SMSC address>" % (sys.argv[0]))
+        sys.exit(1)
+
+def message_service_center_address(sms, value):
+        try:
+            sms.SetProperty("ServiceCenterAddress", dbus.String(value))
+        except dbus.DBusException as e:
+            print("Unable to set correct Service Center Address - FAIL")
+	    exit(1)
+
+bus =3D dbus.SystemBus()
+manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),'org.ofono.Man=
ager')
+modems =3D manager.GetModems()
+value  =3D sys.argv[1]
+
+for path, properties in modems:
+	print("Setting SMSC for [ %s ]" % (path))
+
+	if "org.ofono.MessageManager" not in properties["Interfaces"]:
+		continue
+
+	sms =3D dbus.Interface(bus.get_object('org.ofono', path),
+					'org.ofono.MessageManager')
+        =

+        message_service_center_address(sms, value)
+        print("SMSC address Updated for [ %s ]" % (path))
-- =

1.9.1


--===============1800248804266396863==--

