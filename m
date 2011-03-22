Content-Type: multipart/mixed; boundary="===============7376073912703829520=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 6/6] test-stk-menu: Add support for BIP commands
Date: Tue, 22 Mar 2011 13:51:20 +0100
Message-ID: <1300798280-4281-7-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7376073912703829520==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/test-stk-menu |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/test/test-stk-menu b/test/test-stk-menu
index 639fe77..85b9a0b 100755
--- a/test/test-stk-menu
+++ b/test/test-stk-menu
@@ -170,6 +170,18 @@ class StkAgent(dbus.service.Object):
 			return False
 =

 	@dbus.service.method("org.ofono.SimToolkitAgent",
+				in_signature=3D"sy", out_signature=3D"b")
+	def ConfirmOpenChannel(self, info, icon):
+		print "Open channel confirmation: (%s)" % (info)
+		print "Icon: (%d)" % (icon)
+		key =3D raw_input("Enter Confirmation (y, n):")
+
+		if key =3D=3D 'y':
+			return True
+		else:
+			return False
+
+	@dbus.service.method("org.ofono.SimToolkitAgent",
 					in_signature=3D"", out_signature=3D"")
 	def Cancel(self):
 		print "Cancel"
@@ -198,6 +210,16 @@ class StkAgent(dbus.service.Object):
 		print "Text: %s" % (text)
 		print "Icon: %d" % (icon)
 =

+	@dbus.service.method("org.ofono.SimToolkitAgent",
+					in_signature=3D"sy", out_signature=3D"")
+	def DisplayChannelActivity(self, text, icon):
+		print "Channel activity (%s)" % (text)
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


--===============7376073912703829520==--

