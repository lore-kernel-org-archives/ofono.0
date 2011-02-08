Content-Type: multipart/mixed; boundary="===============7110909644613087389=="
MIME-Version: 1.0
From: Dara Spieker-Doyle <dara.spieker-doyle@nokia.com>
Subject: [PATCH 7/7] test: Add CDMA Signal Strength Support
Date: Tue, 08 Feb 2011 13:05:00 -0800
Message-ID: <1297199100-2712-8-git-send-email-dara.spieker-doyle@nokia.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7110909644613087389==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am                                   |    3 ++-
 test/cdma-get-current-network-signal-strength |   21 +++++++++++++++++++++
 2 files changed, 23 insertions(+), 1 deletions(-)
 create mode 100755 test/cdma-get-current-network-signal-strength

diff --git a/Makefile.am b/Makefile.am
index 272e28d..d7048f3 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -481,7 +481,8 @@ test_scripts =3D test/backtrace \
 		test/cdma-hangup \
 		test/disable-call-forwarding \
 		test/list-messages \
-		test/test-sms
+		test/test-sms \
+		test/cdma-get-current-network-signal-strength
 =

 if TEST
 testdir =3D $(pkglibdir)/test
diff --git a/test/cdma-get-current-network-signal-strength b/test/cdma-get-=
current-network-signal-strength
new file mode 100755
index 0000000..3c2a457
--- /dev/null
+++ b/test/cdma-get-current-network-signal-strength
@@ -0,0 +1,21 @@
+#!/usr/bin/python
+
+import dbus, sys
+
+bus =3D dbus.SystemBus()
+
+manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
+                                               'org.ofono.Manager')
+modems =3D manager.GetModems()
+path =3D modems[0][0]
+
+netreg =3D dbus.Interface(bus.get_object('org.ofono', path),
+                               'org.ofono.cdma.NetworkRegistration')
+
+properties =3D netreg.GetProperties()
+
+if properties.has_key('Strength'):
+	print "Returned signal strength for current CDMA network is: '%d'" %\
+					(properties['Strength'])
+else:
+	print "No strength reported with GetProperties"
-- =

1.7.0.4


--===============7110909644613087389==--

