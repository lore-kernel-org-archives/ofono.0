Content-Type: multipart/mixed; boundary="===============7137982414041834495=="
MIME-Version: 1.0
From: Rajagopal Aravindan <rajagopalx.aravindan@intel.com>
Subject: [PATCH 3/3] ril_sofia3gr: Added python script to disable throttling
Date: Tue, 24 May 2016 14:14:19 +0530
Message-ID: <1464079459-6525-3-git-send-email-rajagopalx.aravindan@intel.com>
In-Reply-To: <1464079459-6525-1-git-send-email-rajagopalx.aravindan@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7137982414041834495==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am             |  3 ++-
 test/disable-throttling | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)
 create mode 100755 test/disable-throttling

diff --git a/Makefile.am b/Makefile.am
index f94585a..42116c7 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -753,7 +753,8 @@ test_scripts =3D test/backtrace \
 		test/set-sms-bearer \
 		test/get-serving-cell-info \
 		test/list-allowed-access-points \
-		test/enable-throttling
+		test/enable-throttling \
+		test/disable-throttling
 =

 if TEST
 testdir =3D $(pkglibdir)/test
diff --git a/test/disable-throttling b/test/disable-throttling
new file mode 100755
index 0000000..4d4ac57
--- /dev/null
+++ b/test/disable-throttling
@@ -0,0 +1,18 @@
+#!/usr/bin/python3
+
+import dbus, sys
+
+bus =3D dbus.SystemBus()
+
+if len(sys.argv) =3D=3D 2:
+	path =3D sys.argv[1]
+else:
+	manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
+			'org.ofono.Manager')
+	modems =3D manager.GetModems()
+	path =3D modems[0][0]
+
+print("Disabling transmit power throttling of modem %s ..." % path)
+thermal_management =3D dbus.Interface(bus.get_object('org.ofono', path),
+		'org.ofono.sofia3gr.ThermalManagement')
+thermal_management.SetProperty("TransmitPowerThrottling", dbus.Boolean(0),=
 timeout =3D 30)
-- =

1.9.1


--===============7137982414041834495==--

