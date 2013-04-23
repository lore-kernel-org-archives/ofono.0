Content-Type: multipart/mixed; boundary="===============0065562357445811169=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH v2 1/3] bluez5: Unify bt_register_profile_* into a single
 function
Date: Tue, 23 Apr 2013 18:21:50 -0300
Message-ID: <1366752112-8007-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0065562357445811169==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

It was a cause of confusion for little gain to have separate
functions for registering profiles with extra information, for
example "role" and "features". We remove those helper functions
in favor of a single one with more parameters, "role" and
"feature" when NULL, will be ignored.
---
 dundee/bluez5.c         |  4 ++--
 plugins/bluez5.c        | 17 +++++++----------
 plugins/bluez5.h        |  7 ++-----
 plugins/dun_gw_bluez5.c |  2 +-
 plugins/hfp_ag_bluez5.c |  2 +-
 plugins/hfp_hf_bluez5.c |  2 +-
 6 files changed, 14 insertions(+), 20 deletions(-)

diff --git a/dundee/bluez5.c b/dundee/bluez5.c
index 3f9c646..79b5ade 100644
--- a/dundee/bluez5.c
+++ b/dundee/bluez5.c
@@ -379,8 +379,8 @@ static void connect_handler(DBusConnection *conn, void =
*user_data)
 {
 	DBG("");
 =

-	bt_register_profile_with_role(conn, DUN_GW_UUID, DUN_VERSION_1_2,
-				"dun_dt", DUN_DT_PROFILE_PATH, "client");
+	bt_register_profile(conn, DUN_GW_UUID, DUN_VERSION_1_2, "dun_dt",
+					DUN_DT_PROFILE_PATH, "client", 0);
 }
 =

 int __dundee_bluetooth_init(void)
diff --git a/plugins/bluez5.c b/plugins/bluez5.c
index 0f997da..979076e 100644
--- a/plugins/bluez5.c
+++ b/plugins/bluez5.c
@@ -90,9 +90,10 @@ done:
 	dbus_message_unref(reply);
 }
 =

-int bt_register_profile_with_role(DBusConnection *conn, const char *uuid,
+int bt_register_profile(DBusConnection *conn, const char *uuid,
 					uint16_t version, const char *name,
-					const char *object, const char *role)
+					const char *object, const char *role,
+					uint16_t features)
 {
 	DBusMessageIter iter, dict;
 	DBusPendingCall *c;
@@ -114,6 +115,10 @@ int bt_register_profile_with_role(DBusConnection *conn=
, const char *uuid,
 	if (role)
 		ofono_dbus_dict_append(&dict, "Role", DBUS_TYPE_STRING, &role);
 =

+	if (features)
+		ofono_dbus_dict_append(&dict, "Features", DBUS_TYPE_UINT16,
+								&features);
+
 	dbus_message_iter_close_container(&iter, &dict);
 =

 	if (!dbus_connection_send_with_reply(conn, msg, &c, -1)) {
@@ -130,14 +135,6 @@ int bt_register_profile_with_role(DBusConnection *conn=
, const char *uuid,
 	return 0;
 }
 =

-int bt_register_profile(DBusConnection *conn, const char *uuid,
-					uint16_t version, const char *name,
-							const char *object)
-{
-	return bt_register_profile_with_role(conn, uuid, version, name, object,
-									NULL);
-}
-
 void bt_unregister_profile(DBusConnection *conn, const char *object)
 {
 	DBusMessageIter iter;
diff --git a/plugins/bluez5.h b/plugins/bluez5.h
index 5b8c1f5..db24b1a 100644
--- a/plugins/bluez5.h
+++ b/plugins/bluez5.h
@@ -29,13 +29,10 @@
 #define HFP_HS_UUID	"0000111e-0000-1000-8000-00805f9b34fb"
 #define HFP_AG_UUID	"0000111f-0000-1000-8000-00805f9b34fb"
 =

-int bt_register_profile_with_role(DBusConnection *conn, const char *uuid,
-					uint16_t version, const char *name,
-					const char *object, const char *role);
-
 int bt_register_profile(DBusConnection *conn, const char *uuid,
 					uint16_t version, const char *name,
-					const char *object);
+					const char *object, const char *role,
+					uint16_t features);
 =

 void bt_unregister_profile(DBusConnection *conn, const char *object);
 =

diff --git a/plugins/dun_gw_bluez5.c b/plugins/dun_gw_bluez5.c
index 9844092..faea12b 100644
--- a/plugins/dun_gw_bluez5.c
+++ b/plugins/dun_gw_bluez5.c
@@ -172,7 +172,7 @@ static void gprs_watch(struct ofono_atom *atom,
 =

 	if (modems->next =3D=3D NULL)
 		bt_register_profile(conn, DUN_GW_UUID, DUN_GW_VERSION_1_0,
-					"dun_gw", DUN_GW_EXT_PROFILE_PATH);
+				"dun_gw", DUN_GW_EXT_PROFILE_PATH, NULL, 0);
 }
 =

 static void modem_watch(struct ofono_modem *modem, gboolean added, void *u=
ser)
diff --git a/plugins/hfp_ag_bluez5.c b/plugins/hfp_ag_bluez5.c
index 59e84d2..245de21 100644
--- a/plugins/hfp_ag_bluez5.c
+++ b/plugins/hfp_ag_bluez5.c
@@ -233,7 +233,7 @@ static void sim_state_watch(enum ofono_sim_state new_st=
ate, void *data)
 		return;
 =

 	bt_register_profile(conn, HFP_AG_UUID, HFP_VERSION_1_5, "hfp_ag",
-						HFP_AG_EXT_PROFILE_PATH);
+					HFP_AG_EXT_PROFILE_PATH, NULL, 0);
 }
 =

 static gboolean sim_watch_remove(gpointer key, gpointer value,
diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index 2b9275b..826796f 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -639,7 +639,7 @@ static void connect_handler(DBusConnection *conn, void =
*user_data)
 	DBG("Registering External Profile handler ...");
 =

 	bt_register_profile(conn, HFP_HS_UUID, HFP_VERSION_1_6, "hfp_hf",
-						HFP_EXT_PROFILE_PATH);
+					HFP_EXT_PROFILE_PATH, NULL, 0);
 }
 =

 static gboolean has_hfp_ag_uuid(DBusMessageIter *array)
-- =

1.8.2.1


--===============0065562357445811169==--

