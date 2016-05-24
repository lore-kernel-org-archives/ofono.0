Content-Type: multipart/mixed; boundary="===============1152788810969403099=="
MIME-Version: 1.0
From: Rajagopal Aravindan <rajagopalx.aravindan@intel.com>
Subject: [PATCH 2/3] ril_sofia3gr: Added python script to enable throttling
Date: Tue, 24 May 2016 14:14:18 +0530
Message-ID: <1464079459-6525-2-git-send-email-rajagopalx.aravindan@intel.com>
In-Reply-To: <1464079459-6525-1-git-send-email-rajagopalx.aravindan@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1152788810969403099==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am            |  3 ++-
 test/enable-throttling | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)
 create mode 100755 test/enable-throttling

diff --git a/Makefile.am b/Makefile.am
index 7838d2b..f94585a 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -752,7 +752,8 @@ test_scripts =3D test/backtrace \
 		test/set-sms-smsc \
 		test/set-sms-bearer \
 		test/get-serving-cell-info \
-		test/list-allowed-access-points
+		test/list-allowed-access-points \
+		test/enable-throttling
 =

 if TEST
 testdir =3D $(pkglibdir)/test
diff --git a/test/enable-throttling b/test/enable-throttling
new file mode 100755
index 0000000..24b39a4
--- /dev/null
+++ b/test/enable-throttling
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
+print("Enabling transmit power throttling of modem %s ..." % path)
+thermal_management =3D dbus.Interface(bus.get_object('org.ofono', path),
+		'org.ofono.sofia3gr.ThermalManagement')
+thermal_management.SetProperty("TransmitPowerThrottling", dbus.Boolean(1),=
 timeout =3D 30)
-- =

1.9.1


--===============1152788810969403099==--

