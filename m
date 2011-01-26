Content-Type: multipart/mixed; boundary="===============8828681988815010503=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH] test: Add support for DisplayActionInformation
Date: Wed, 26 Jan 2011 14:38:08 +0200
Message-ID: <1296045488-26819-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8828681988815010503==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/test-stk-menu |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/test/test-stk-menu b/test/test-stk-menu
index 85b98ca..639fe77 100755
--- a/test/test-stk-menu
+++ b/test/test-stk-menu
@@ -192,6 +192,12 @@ class StkAgent(dbus.service.Object):
 		if key =3D=3D 't':
 			raise EndSession("User wishes to terminate session");
 =

+	@dbus.service.method("org.ofono.SimToolkitAgent",
+					in_signature=3D"sy", out_signature=3D"")
+	def DisplayActionInformation(self, text, icon):
+		print "Text: %s" % (text)
+		print "Icon: %d" % (icon)
+
 def property_changed(name, value):
 	print "SimToolKit property: %s changed to '%s'" % (name, value)
 =

-- =

1.7.0.4


--===============8828681988815010503==--

