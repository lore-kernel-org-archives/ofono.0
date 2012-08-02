Content-Type: multipart/mixed; boundary="===============8044463517742893560=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v3 1/3] test: Add hold-and-answer script for GCF testing
Date: Thu, 02 Aug 2012 11:41:01 +0200
Message-ID: <1343900463-24917-2-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1343900463-24917-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8044463517742893560==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am          |    3 ++-
 test/hold-and-answer |   20 ++++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletions(-)
 create mode 100755 test/hold-and-answer

diff --git a/Makefile.am b/Makefile.am
index b35cf1f..4410043 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -622,7 +622,8 @@ test_scripts =3D test/backtrace \
 		test/set-context-property \
 		test/test-gnss \
 		test/swap-calls \
-		test/release-and-answer
+		test/release-and-answer \
+		test/hold-and-answer
 =

 if TEST
 testdir =3D $(pkglibdir)/test
diff --git a/test/hold-and-answer b/test/hold-and-answer
new file mode 100755
index 0000000..2c47e27
--- /dev/null
+++ b/test/hold-and-answer
@@ -0,0 +1,20 @@
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
+modem =3D modems[0][0]
+
+if (len(sys.argv) =3D=3D 2):
+	modem =3D sys.argv[1]
+
+manager =3D dbus.Interface(bus.get_object('org.ofono', modem),
+						'org.ofono.VoiceCallManager')
+
+manager.HoldAndAnswer(timeout=3D100)
-- =

1.7.5.4


--===============8044463517742893560==--

