Content-Type: multipart/mixed; boundary="===============1405644207698297969=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 4/4] test-stk-menu: Extend to support
 DisplayAbortableActionInfo
Date: Mon, 28 Mar 2011 18:32:32 +0200
Message-ID: <1301329952-10152-5-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1405644207698297969==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/test-stk-menu |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/test/test-stk-menu b/test/test-stk-menu
index 639fe77..6c1774f 100755
--- a/test/test-stk-menu
+++ b/test/test-stk-menu
@@ -198,6 +198,16 @@ class StkAgent(dbus.service.Object):
 		print "Text: %s" % (text)
 		print "Icon: %d" % (icon)
 =

+	@dbus.service.method("org.ofono.SimToolkitAgent",
+					in_signature=3D"sy", out_signature=3D"")
+	def DisplayAbortableActionInfo(self, text, icon):
+		print "Text: (%s)" % (text)
+		print "Icon: (%d)" % (icon)
+		key =3D raw_input("Press 't' to terminate the session ")
+
+		if key =3D=3D 't':
+			raise EndSession("User wishes to terminate session")
+
 def property_changed(name, value):
 	print "SimToolKit property: %s changed to '%s'" % (name, value)
 =

-- =

1.7.1


--===============1405644207698297969==--

