Content-Type: multipart/mixed; boundary="===============4209908936842680137=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v1 02/10] bluez5: Rename register/unregister profile
Date: Fri, 18 Jan 2013 20:21:48 -0300
Message-ID: <1358551316-27305-3-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1358551316-27305-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4209908936842680137==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>

Using 'bt_' prefix will be more suitable for the upcoming
functions, and structure names avoiding long names and improving
code readability.
---
 plugins/bluez5.c        | 4 ++--
 plugins/bluez5.h        | 4 ++--
 plugins/hfp_hf_bluez5.c | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/plugins/bluez5.c b/plugins/bluez5.c
index 84ba47d..589658a 100644
--- a/plugins/bluez5.c
+++ b/plugins/bluez5.c
@@ -80,7 +80,7 @@ done:
 	dbus_message_unref(reply);
 }
 =

-int bluetooth_register_profile(DBusConnection *conn, const char *uuid,
+int bt_register_profile(DBusConnection *conn, const char *uuid,
 					const char *name, const char *object)
 {
 	DBusMessageIter iter, dict;
@@ -115,7 +115,7 @@ int bluetooth_register_profile(DBusConnection *conn, co=
nst char *uuid,
 	return 0;
 }
 =

-void bluetooth_unregister_profile(DBusConnection *conn, const char *object)
+void bt_unregister_profile(DBusConnection *conn, const char *object)
 {
 	DBusMessageIter iter;
 	DBusPendingCall *c;
diff --git a/plugins/bluez5.h b/plugins/bluez5.h
index 01ecfe8..3088c7d 100644
--- a/plugins/bluez5.h
+++ b/plugins/bluez5.h
@@ -25,7 +25,7 @@
 =

 #define HFP_HS_UUID	"0000111e-0000-1000-8000-00805f9b34fb"
 =

-int bluetooth_register_profile(DBusConnection *conn, const char *uuid,
+int bt_register_profile(DBusConnection *conn, const char *uuid,
 					const char *name, const char *object);
 =

-void bluetooth_unregister_profile(DBusConnection *conn, const char *object=
);
+void bt_unregister_profile(DBusConnection *conn, const char *object);
diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index e024838..f1f8891 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -168,7 +168,7 @@ static int hfp_init(void)
 		return err;
 	}
 =

-	err =3D bluetooth_register_profile(conn, HFP_HS_UUID, "hfp_hf",
+	err =3D bt_register_profile(conn, HFP_HS_UUID, "hfp_hf",
 						HFP_EXT_PROFILE_PATH);
 	if (err < 0) {
 		g_dbus_unregister_interface(conn, HFP_EXT_PROFILE_PATH,
@@ -184,7 +184,7 @@ static void hfp_exit(void)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
 =

-	bluetooth_unregister_profile(conn, HFP_EXT_PROFILE_PATH);
+	bt_unregister_profile(conn, HFP_EXT_PROFILE_PATH);
 	g_dbus_unregister_interface(conn, HFP_EXT_PROFILE_PATH,
 						BLUEZ_PROFILE_INTERFACE);
 	ofono_modem_driver_unregister(&hfp_driver);
-- =

1.7.11.7


--===============4209908936842680137==--

