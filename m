Content-Type: multipart/mixed; boundary="===============4738845309909628051=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 2/2] hfp_hf_bluez5: Send HFP version when registering the
 profile
Date: Wed, 20 Feb 2013 19:26:19 -0300
Message-ID: <1361399179-16734-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1361399179-16734-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4738845309909628051==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch adds the supported HFP version in the RegisterProfile method
arguments since the default in BlueZ is 1.5. The version is required
to create the service record containing the correct profile version.
---
 plugins/bluez5.c        | 4 +++-
 plugins/bluez5.h        | 3 ++-
 plugins/hfp_ag_bluez5.c | 8 ++++++--
 plugins/hfp_hf_bluez5.c | 2 +-
 4 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/plugins/bluez5.c b/plugins/bluez5.c
index f2cd4bb..9233a2b 100644
--- a/plugins/bluez5.c
+++ b/plugins/bluez5.c
@@ -108,7 +108,8 @@ done:
 }
 =

 int bt_register_profile(DBusConnection *conn, const char *uuid,
-					const char *name, const char *object)
+					uint16_t version, const char *name,
+					const char *object)
 {
 	DBusMessageIter iter, dict;
 	DBusPendingCall *c;
@@ -125,6 +126,7 @@ int bt_register_profile(DBusConnection *conn, const cha=
r *uuid,
 =

 	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY, "{sv}", &dict);
 	ofono_dbus_dict_append(&dict, "Name", DBUS_TYPE_STRING, &name);
+	ofono_dbus_dict_append(&dict, "Version", DBUS_TYPE_UINT16, &version);
 =

 	dbus_message_iter_close_container(&iter, &dict);
 =

diff --git a/plugins/bluez5.h b/plugins/bluez5.h
index 3155901..1432068 100644
--- a/plugins/bluez5.h
+++ b/plugins/bluez5.h
@@ -70,7 +70,8 @@ int bt_ba2str(const bdaddr_t *ba, char *str);
 int bt_bacmp(const bdaddr_t *ba1, const bdaddr_t *ba2);
 =

 int bt_register_profile(DBusConnection *conn, const char *uuid,
-					const char *name, const char *object);
+					uint16_t version, const char *name,
+					const char *object);
 =

 void bt_unregister_profile(DBusConnection *conn, const char *object);
 =

diff --git a/plugins/hfp_ag_bluez5.c b/plugins/hfp_ag_bluez5.c
index 03a46fb..a81adfd 100644
--- a/plugins/hfp_ag_bluez5.c
+++ b/plugins/hfp_ag_bluez5.c
@@ -30,11 +30,15 @@
 #include <glib.h>
 #include <ofono.h>
 =

+#include <gdbus.h>
+#include <gatchat.h>
+
 #define OFONO_API_SUBJECT_TO_CHANGE
 #include <ofono/plugin.h>
 #include <ofono/log.h>
 #include <ofono/modem.h>
-#include <gdbus.h>
+
+#include <drivers/hfpmodem/slc.h>
 =

 #include "bluez5.h"
 =

@@ -176,7 +180,7 @@ static void sim_state_watch(enum ofono_sim_state new_st=
ate, void *data)
 	if (modems->next !=3D NULL)
 		return;
 =

-	bt_register_profile(conn, HFP_AG_UUID, "hfp_ag",
+	bt_register_profile(conn, HFP_AG_UUID, HFP_VERSION_1_5, "hfp_ag",
 						HFP_AG_EXT_PROFILE_PATH);
 }
 =

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index cc4e0a2..7057d71 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -528,7 +528,7 @@ static void connect_handler(DBusConnection *conn, void =
*user_data)
 {
 	DBG("Registering External Profile handler ...");
 =

-	bt_register_profile(conn, HFP_HS_UUID, "hfp_hf",
+	bt_register_profile(conn, HFP_HS_UUID, local_hfp_version, "hfp_hf",
 						HFP_EXT_PROFILE_PATH);
 }
 =

-- =

1.7.11.7


--===============4738845309909628051==--

