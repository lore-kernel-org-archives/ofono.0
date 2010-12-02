Content-Type: multipart/mixed; boundary="===============4005971227915902172=="
MIME-Version: 1.0
From: Zhigang Li <zhigang.li@intel.com>
Subject: [PATCH] To fix the test agent quit issue when execute play-tone
 command of stk
Date: Thu, 02 Dec 2010 17:29:22 +0800
Message-ID: <1291282162-6970-1-git-send-email-zhigang.li@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4005971227915902172==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/test-stk-menu |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/test/test-stk-menu b/test/test-stk-menu
index 916a527..456a522 100755
--- a/test/test-stk-menu
+++ b/test/test-stk-menu
@@ -138,6 +138,18 @@ class StkAgent(dbus.service.Object):
 	def Cancel(self):
 		print "Cancel"
 =

+	@dbus.service.method("org.ofono.SimToolkitAgent",
+					in_signature=3D"ssy", out_signature=3D"")
+
+	def PlayTone(self, tone, text, icon):
+		print "playtone is %s" % (tone)
+
+        @dbus.service.method("org.ofono.SimToolkitAgent",
+                                in_signature=3D"ssy", out_signature=3D"")
+
+        def LoopTone(self, tone, text, icon):
+                print "the loop tone is %s" % (tone)
+
 if __name__ =3D=3D '__main__':
 	dbus.mainloop.glib.DBusGMainLoop(set_as_default=3DTrue)
 =

-- =

1.6.5.2


--===============4005971227915902172==--

