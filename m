Content-Type: multipart/mixed; boundary="===============1907653814414321195=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 4/4] test: Print the immediate_response argument for
 RequestDigit
Date: Fri, 24 Aug 2012 16:28:25 +0200
Message-ID: <1345818505-17175-5-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1345818505-17175-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1907653814414321195==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/test-stk-menu |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/test/test-stk-menu b/test/test-stk-menu
index a9f92e8..3bd4483 100755
--- a/test/test-stk-menu
+++ b/test/test-stk-menu
@@ -113,10 +113,11 @@ class StkAgent(dbus.service.Object):
 			return key
 =

 	@dbus.service.method("org.ofono.SimToolkitAgent",
-				in_signature=3D"sy", out_signature=3D"s")
-	def RequestDigit(self, title, icon):
+				in_signature=3D"sys", out_signature=3D"s")
+	def RequestDigit(self, title, icon, immediate_response):
 		print "Title: (%s)" % (title)
 		print "Icon: (%d)" % (icon)
+		print "Immediate response: (%s)" % (immediate_response)
 		key =3D raw_input("Enter Digit (t, b):")
 =

 		if key =3D=3D 'b':
-- =

1.7.9.5


--===============1907653814414321195==--

