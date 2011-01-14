Content-Type: multipart/mixed; boundary="===============2985967781147819821=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 2/3] test: Add support for launch browser command
Date: Fri, 14 Jan 2011 11:38:54 +0200
Message-ID: <1294997935-21814-3-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1294997935-21814-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2985967781147819821==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/test-stk-menu |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/test/test-stk-menu b/test/test-stk-menu
index 673b5bc..85b98ca 100755
--- a/test/test-stk-menu
+++ b/test/test-stk-menu
@@ -157,6 +157,19 @@ class StkAgent(dbus.service.Object):
 			return False
 =

 	@dbus.service.method("org.ofono.SimToolkitAgent",
+				in_signature=3D"sys", out_signature=3D"b")
+	def ConfirmLaunchBrowser(self, info, icon, url):
+		print "Information: (%s)" % (info)
+		print "Icon: (%d)" % (icon)
+		print "URL (%s)" % (url)
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
-- =

1.7.0.4


--===============2985967781147819821==--

