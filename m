Content-Type: multipart/mixed; boundary="===============3997894318765906372=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 1/4] bluez5: Rename BlueZ Profile registration functions
Date: Fri, 01 Feb 2013 20:33:06 -0300
Message-ID: <1359761589-18561-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3997894318765906372==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Claudio Takahasi <claudio.takahasi@openbossa.org>

This patch renames external profile registration functions replacing the
prefix from 'bluetooth_' to 'bt_' in order to follow the name convention
adopted for bluez5 functions.
---
 plugins/bluez5.c        | 4 ++--
 plugins/bluez5.h        | 4 ++--
 plugins/hfp_ag_bluez5.c | 4 ++--
 plugins/hfp_hf_bluez5.c | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/plugins/bluez5.c b/plugins/bluez5.c
index d5c566e..c505e71 100644
--- a/plugins/bluez5.c
+++ b/plugins/bluez5.c
@@ -101,7 +101,7 @@ done:
 	dbus_message_unref(reply);
 }
 =

-int bluetooth_register_profile(DBusConnection *conn, const char *uuid,
+int bt_register_profile(DBusConnection *conn, const char *uuid,
 					const char *name, const char *object)
 {
 	DBusMessageIter iter, dict;
@@ -136,7 +136,7 @@ int bluetooth_register_profile(DBusConnection *conn, co=
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
index cdbfe72..16245eb 100644
--- a/plugins/bluez5.h
+++ b/plugins/bluez5.h
@@ -69,7 +69,7 @@ int bt_ba2str(const bdaddr_t *ba, char *str);
 =

 int bt_bacmp(const bdaddr_t *ba1, const bdaddr_t *ba2);
 =

-int bluetooth_register_profile(DBusConnection *conn, const char *uuid,
+int bt_register_profile(DBusConnection *conn, const char *uuid,
 					const char *name, const char *object);
 =

-void bluetooth_unregister_profile(DBusConnection *conn, const char *object=
);
+void bt_unregister_profile(DBusConnection *conn, const char *object);
diff --git a/plugins/hfp_ag_bluez5.c b/plugins/hfp_ag_bluez5.c
index 80dd601..03a46fb 100644
--- a/plugins/hfp_ag_bluez5.c
+++ b/plugins/hfp_ag_bluez5.c
@@ -163,7 +163,7 @@ static void sim_state_watch(enum ofono_sim_state new_st=
ate, void *data)
 		if (modems !=3D NULL)
 			return;
 =

-		bluetooth_unregister_profile(conn, HFP_AG_EXT_PROFILE_PATH);
+		bt_unregister_profile(conn, HFP_AG_EXT_PROFILE_PATH);
 =

 		return;
 	}
@@ -176,7 +176,7 @@ static void sim_state_watch(enum ofono_sim_state new_st=
ate, void *data)
 	if (modems->next !=3D NULL)
 		return;
 =

-	bluetooth_register_profile(conn, HFP_AG_UUID, "hfp_ag",
+	bt_register_profile(conn, HFP_AG_UUID, "hfp_ag",
 						HFP_AG_EXT_PROFILE_PATH);
 }
 =

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index 2f4a89e..cd3f9a6 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -429,7 +429,7 @@ static void connect_handler(DBusConnection *conn, void =
*user_data)
 {
 	DBG("Registering External Profile handler ...");
 =

-	bluetooth_register_profile(conn, HFP_HS_UUID, "hfp_hf",
+	bt_register_profile(conn, HFP_HS_UUID, "hfp_hf",
 						HFP_EXT_PROFILE_PATH);
 }
 =

@@ -606,7 +606,7 @@ static void hfp_exit(void)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
 =

-	bluetooth_unregister_profile(conn, HFP_EXT_PROFILE_PATH);
+	bt_unregister_profile(conn, HFP_EXT_PROFILE_PATH);
 	g_dbus_unregister_interface(conn, HFP_EXT_PROFILE_PATH,
 						BLUEZ_PROFILE_INTERFACE);
 	ofono_modem_driver_unregister(&hfp_driver);
-- =

1.8.1.1


--===============3997894318765906372==--

