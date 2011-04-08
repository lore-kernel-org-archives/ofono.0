Content-Type: multipart/mixed; boundary="===============7410445155559838940=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 5/6] test-stk-menu: Extend to support ConfirmOpenchannel method
Date: Fri, 08 Apr 2011 18:33:30 +0200
Message-ID: <1302280411-20762-5-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7410445155559838940==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/test-stk-menu |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/test/test-stk-menu b/test/test-stk-menu
index 1fde700..a9f92e8 100755
--- a/test/test-stk-menu
+++ b/test/test-stk-menu
@@ -208,6 +208,20 @@ class StkAgent(dbus.service.Object):
 		if key =3D=3D 't':
 			raise EndSession("User wishes to terminate session")
 =

+	@dbus.service.method("org.ofono.SimToolkitAgent",
+					in_signature=3D"sy", out_signature=3D"b")
+	def ConfirmOpenChannel(self, info, icon):
+		print "Open channel confirmation: (%s)" % (info)
+		print "Icon: (%d)" % (icon)
+		key =3D raw_input("Enter Confirmation (t, y, n):")
+
+		if key =3D=3D 't':
+			raise EndSession("User wishes to terminate session");
+		elif key =3D=3D 'y':
+			return True
+		else:
+			return False
+
 def property_changed(name, value):
 	print "SimToolKit property: %s changed to '%s'" % (name, value)
 =

-- =

1.7.1


--===============7410445155559838940==--

