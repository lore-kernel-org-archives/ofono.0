Content-Type: multipart/mixed; boundary="===============9205211949481777058=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 1/3] test: Update with RequestQuickDigit API
Date: Thu, 06 Sep 2012 16:38:45 +0200
Message-ID: <1346942327-4448-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9205211949481777058==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/test-stk-menu |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/test/test-stk-menu b/test/test-stk-menu
index a9f92e8..6e7f7b7 100755
--- a/test/test-stk-menu
+++ b/test/test-stk-menu
@@ -127,6 +127,20 @@ class StkAgent(dbus.service.Object):
 			return key
 =

 	@dbus.service.method("org.ofono.SimToolkitAgent",
+				in_signature=3D"sy", out_signature=3D"s")
+	def RequestQuickDigit(self, title, icon):
+		print "Title: (%s)" % (title)
+		print "Icon: (%d)" % (icon)
+		key =3D raw_input("Quick digit (0-9, *, #, t, b):")
+
+		if key =3D=3D 'b':
+			raise GoBack("User wishes to go back");
+		elif key =3D=3D 't':
+			raise EndSession("User wishes to terminate session");
+		else:
+			return key
+
+	@dbus.service.method("org.ofono.SimToolkitAgent",
 				in_signature=3D"sy", out_signature=3D"b")
 	def RequestConfirmation(self, title, icon):
 		print "Title: (%s)" % (title)
-- =

1.7.9.5


--===============9205211949481777058==--

