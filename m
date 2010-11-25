Content-Type: multipart/mixed; boundary="===============2303174621961084194=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 3/3] test-stk: Add provide local info
Date: Thu, 25 Nov 2010 20:29:02 +0800
Message-ID: <1290688142-14726-4-git-send-email-yang.gu@intel.com>
In-Reply-To: <1290688142-14726-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2303174621961084194==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/test-stk-menu |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/test/test-stk-menu b/test/test-stk-menu
index 916a527..db3f8b7 100755
--- a/test/test-stk-menu
+++ b/test/test-stk-menu
@@ -134,6 +134,42 @@ class StkAgent(dbus.service.Object):
 			return False
 =

 	@dbus.service.method("org.ofono.SimToolkitAgent",
+				in_signature=3D"", out_signature=3D"iyyyyyi")
+	def RequestTime(self):
+		print "Time should be in format: year, month, day, hour, minute, second[=
, timezone]"
+		userin =3D raw_input("Enter Time (t, b, time):")
+
+		if userin =3D=3D 'b':
+			raise GoBack("User wishes to go back");
+		elif userin =3D=3D 't':
+			raise EndSession("User wishes to terminate session");
+		else:
+			time =3D userin.split(',')
+
+			if len(time) !=3D 6 and len(time) !=3D 7:
+				raise GoBack("The input time is invalid");
+
+			if len(time) =3D=3D 6:
+				timezone =3D -48;
+			else:
+				timezone =3D int(time[6])
+
+			return int(time[0]), int(time[1]), int(time[2]), int(time[3]), int(time=
[4]), int(time[5]), timezone
+
+	@dbus.service.method("org.ofono.SimToolkitAgent",
+				in_signature=3D"", out_signature=3D"s")
+	def RequestLanguage(self):
+		print "Follow ISO 639-1 to input language, that is, a pair of alpha-nume=
ric characters"
+		userin =3D raw_input("Enter Language (t, b):")
+
+		if userin =3D=3D 'b':
+			raise GoBack("User wishes to go back");
+		elif userin =3D=3D 't':
+			raise EndSession("User wishes to terminate session");
+		else:
+			return userin
+
+	@dbus.service.method("org.ofono.SimToolkitAgent",
 					in_signature=3D"", out_signature=3D"")
 	def Cancel(self):
 		print "Cancel"
-- =

1.7.2.3


--===============2303174621961084194==--

