Content-Type: multipart/mixed; boundary="===============5075425733293587694=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [RFC 3/4] test: Add support for launch browser command
Date: Mon, 10 Jan 2011 11:43:42 +0200
Message-ID: <1294652623-17287-4-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1294652623-17287-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5075425733293587694==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkagent.c     |    2 +-
 test/test-stk-menu |   13 +++++++++++++
 2 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/src/stkagent.c b/src/stkagent.c
index 03b7c87..f3d22ab 100644
--- a/src/stkagent.c
+++ b/src/stkagent.c
@@ -1037,7 +1037,7 @@ static void confirm_launch_browser_cb(DBusPendingCall=
 *call, void *data)
 	if (dbus_message_get_args(reply, NULL,
 					DBUS_TYPE_BOOLEAN, &confirm,
 					DBUS_TYPE_INVALID) =3D=3D FALSE) {
-		ofono_error("Can't parse the reply to ConfirmLaunchBrowser()");
+		ofono_error("Can't parse the reply to LaunchBrowser()");
 		remove_agent =3D TRUE;
 		goto error;
 	}
diff --git a/test/test-stk-menu b/test/test-stk-menu
index 673b5bc..995cfef 100755
--- a/test/test-stk-menu
+++ b/test/test-stk-menu
@@ -157,6 +157,19 @@ class StkAgent(dbus.service.Object):
 			return False
 =

 	@dbus.service.method("org.ofono.SimToolkitAgent",
+				in_signature=3D"sys", out_signature=3D"b")
+	def LaunchBrowser(self, info, icon, url):
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


--===============5075425733293587694==--

