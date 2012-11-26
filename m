Content-Type: multipart/mixed; boundary="===============4721427205179880523=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC v1 12/15] hfp_hf: Request secure connections
Date: Mon, 26 Nov 2012 10:27:06 -0300
Message-ID: <1353936429-9997-13-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1353936429-9997-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4721427205179880523==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch changes the HFP external profile registration requesting
authentication and authorization for new connections.
---
 plugins/bluetooth.c | 9 ++++++++-
 plugins/bluetooth.h | 2 +-
 plugins/hfp_hf.c    | 2 +-
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
index a3dccee..3b11b63 100644
--- a/plugins/bluetooth.c
+++ b/plugins/bluetooth.c
@@ -1002,7 +1002,7 @@ done:
 }
 =

 int bluetooth_register_profile(const char *uuid, const char *name,
-							const char *object)
+					const char *object, gboolean secure)
 {
 	DBusMessageIter iter, dict;
 	DBusPendingCall *c;
@@ -1019,6 +1019,13 @@ int bluetooth_register_profile(const char *uuid, con=
st char *name,
 =

 	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY, "{sv}", &dict);
 	dict_append_entry(&dict, "Name", DBUS_TYPE_STRING, &name);
+	if (secure) {
+		dict_append_entry(&dict, "RequireAuthentication",
+						DBUS_TYPE_BOOLEAN, &secure);
+		dict_append_entry(&dict, "RequireAuthorization",
+						DBUS_TYPE_BOOLEAN, &secure);
+	}
+
 	dbus_message_iter_close_container(&iter, &dict);
 =

 	if (!dbus_connection_send_with_reply(connection, msg, &c, -1)) {
diff --git a/plugins/bluetooth.h b/plugins/bluetooth.h
index 5b4d9d4..a3937ac 100644
--- a/plugins/bluetooth.h
+++ b/plugins/bluetooth.h
@@ -70,7 +70,7 @@ int bluetooth_register_uuid(const char *uuid,
 				struct bluetooth_profile *profile);
 void bluetooth_unregister_uuid(const char *uuid);
 int bluetooth_register_profile(const char *uuid, const char *name,
-							const char *object);
+					const char *object, gboolean secure);
 void bluetooth_unregister_profile(const char *object);
 struct server *bluetooth_register_server(guint8 channel, const char *sdp_r=
ecord,
 					ConnectFunc cb, gpointer user_data);
diff --git a/plugins/hfp_hf.c b/plugins/hfp_hf.c
index 70005f0..22514da 100644
--- a/plugins/hfp_hf.c
+++ b/plugins/hfp_hf.c
@@ -497,7 +497,7 @@ static int hfp_init(void)
 	}
 =

 	err =3D bluetooth_register_profile(HFP_HS_UUID, "hfp_hf",
-						HFP_EXT_PROFILE_PATH);
+						HFP_EXT_PROFILE_PATH, TRUE);
 	if (err < 0) {
 		g_dbus_unregister_interface(connection, HFP_EXT_PROFILE_PATH,
 						BLUEZ_PROFILE_INTERFACE);
-- =

1.7.11.7


--===============4721427205179880523==--

