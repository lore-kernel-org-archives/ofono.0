Content-Type: multipart/mixed; boundary="===============3020377271907390202=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v3 1/2] test: Add hangup-multiparty script for GCF testing
Date: Fri, 03 Aug 2012 16:50:01 +0200
Message-ID: <1344005402-15253-2-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1344005402-15253-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3020377271907390202==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am            |    3 ++-
 test/hangup-multiparty |   20 ++++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletions(-)
 create mode 100755 test/hangup-multiparty

diff --git a/Makefile.am b/Makefile.am
index 99d4ab0..7e8f12c 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -624,7 +624,8 @@ test_scripts =3D test/backtrace \
 		test/test-gnss \
 		test/swap-calls \
 		test/release-and-answer \
-		test/hold-and-answer
+		test/hold-and-answer \
+		test/hangup-multiparty
 =

 if TEST
 testdir =3D $(pkglibdir)/test
diff --git a/test/hangup-multiparty b/test/hangup-multiparty
new file mode 100755
index 0000000..48fe342
--- /dev/null
+++ b/test/hangup-multiparty
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
+manager.HangupMultiparty()
-- =

1.7.5.4


--===============3020377271907390202==--

