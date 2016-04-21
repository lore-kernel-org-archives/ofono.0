Content-Type: multipart/mixed; boundary="===============8672216712844993513=="
MIME-Version: 1.0
From: Nishanth V <nishanth.v@intel.com>
Subject: [PATCH 4/4] test: Add list allowed access points script
Date: Thu, 21 Apr 2016 09:21:18 +0530
Message-ID: <1461210678-11374-1-git-send-email-nishanth.v@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8672216712844993513==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am                     |  3 ++-
 test/list-allowed-access-points | 25 +++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 1 deletion(-)
 create mode 100755 test/list-allowed-access-points

diff --git a/Makefile.am b/Makefile.am
index c788149..5215b2e 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -749,7 +749,8 @@ test_scripts =3D test/backtrace \
 		test/register-operator \
 		test/set-sms-smsc \
 		test/set-sms-bearer \
-		test/get-serving-cell-info
+		test/get-serving-cell-info \
+		test/list-allowed-access-points
 =

 if TEST
 testdir =3D $(pkglibdir)/test
diff --git a/test/list-allowed-access-points b/test/list-allowed-access-poi=
nts
new file mode 100755
index 0000000..c7bb50c
--- /dev/null
+++ b/test/list-allowed-access-points
@@ -0,0 +1,25 @@
+#!/usr/bin/python3
+
+import dbus
+
+bus =3D dbus.SystemBus()
+
+manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
+						'org.ofono.Manager')
+
+modems =3D manager.GetModems()
+
+for path, properties in modems:
+	if "org.ofono.AllowedAccessPoints" not in properties["Interfaces"]:
+		continue
+
+	allowedAccessPoints =3D dbus.Interface(bus.get_object('org.ofono',
+					path), 'org.ofono.AllowedAccessPoints')
+
+	apns =3D allowedAccessPoints.GetAllowedAccessPoints()
+
+	print("Allowed Access Points for [ %s ]" % (path))
+	for apn in apns:
+		print("    [ %s]" % (apn))
+
+print("")
-- =

1.9.1


--===============8672216712844993513==--

