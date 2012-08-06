Content-Type: multipart/mixed; boundary="===============0483032018233393303=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v4] test: Add hangup-call script for GCF testing
Date: Mon, 06 Aug 2012 14:10:50 +0200
Message-ID: <1344255050-21833-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0483032018233393303==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am      |    3 ++-
 test/hangup-call |   28 ++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 1 deletions(-)
 create mode 100755 test/hangup-call

diff --git a/Makefile.am b/Makefile.am
index 7e8f12c..8cf6920 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -625,7 +625,8 @@ test_scripts =3D test/backtrace \
 		test/swap-calls \
 		test/release-and-answer \
 		test/hold-and-answer \
-		test/hangup-multiparty
+		test/hangup-multiparty \
+		test/hangup-call
 =

 if TEST
 testdir =3D $(pkglibdir)/test
diff --git a/test/hangup-call b/test/hangup-call
new file mode 100755
index 0000000..0765919
--- /dev/null
+++ b/test/hangup-call
@@ -0,0 +1,28 @@
+#!/usr/bin/python
+
+import sys
+import dbus
+
+bus =3D dbus.SystemBus()
+
+manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
+						'org.ofono.Manager')
+
+modems =3D manager.GetModems()
+path =3D modems[0][0]
+
+manager =3D dbus.Interface(bus.get_object('org.ofono', path),
+						'org.ofono.VoiceCallManager')
+
+calls =3D manager.GetCalls()
+if (len(calls) =3D=3D 0):
+	print "No calls available"
+	sys.exit(1)
+
+if (len(sys.argv) < 2):
+	print "Usage: %s [ Call Path ]" % (sys.argv[0])
+	sys.exit(1)
+
+call =3D dbus.Interface(bus.get_object('org.ofono', sys.argv[1]),
+						'org.ofono.VoiceCall')
+call.Hangup()
-- =

1.7.5.4


--===============0483032018233393303==--

