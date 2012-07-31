Content-Type: multipart/mixed; boundary="===============4371849349386429830=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v2 2/2] test: Add hangup script for GCF testing
Date: Tue, 31 Jul 2012 11:45:27 +0200
Message-ID: <1343727927-15424-3-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1343727927-15424-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4371849349386429830==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am |    3 ++-
 test/hangup |   53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 1 deletions(-)
 create mode 100755 test/hangup

diff --git a/Makefile.am b/Makefile.am
index 4410043..01b79ff 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -623,7 +623,8 @@ test_scripts =3D test/backtrace \
 		test/test-gnss \
 		test/swap-calls \
 		test/release-and-answer \
-		test/hold-and-answer
+		test/hold-and-answer \
+		test/hangup
 =

 if TEST
 testdir =3D $(pkglibdir)/test
diff --git a/test/hangup b/test/hangup
new file mode 100755
index 0000000..186e323
--- /dev/null
+++ b/test/hangup
@@ -0,0 +1,53 @@
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
+		print "No calls available"
+		sys.exit(1)
+
+if (len(sys.argv) < 2):
+	print
+	print "[ call path ]		< call state >"
+	print
+	for path, properties in calls:
+		state =3D properties["State"]
+		print "[ %s ] < %s >" % (path, state)
+		print
+
+	print "Usage: %s < call state >" % (sys.argv[0])
+	print
+	sys.exit(1)
+
+cstate =3D sys.argv[1]
+
+if cstate !=3D "active" and cstate !=3D "waiting" and cstate !=3D "held":
+	print "Valid < call state > is active / waiting / held"
+	sys.exit(1)
+
+for path, properties in calls:
+		print
+		state =3D properties["State"]
+		print "[ %s ] < %s >" % (path, state)
+		print
+
+		if state !=3D cstate:
+			continue
+
+		call =3D dbus.Interface(bus.get_object('org.ofono', path),
+						'org.ofono.VoiceCall')
+
+		call.Hangup()
-- =

1.7.5.4


--===============4371849349386429830==--

