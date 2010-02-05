Content-Type: multipart/mixed; boundary="===============6407767645742325745=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH] hfp: Fix memory leak when listing bluetooth devices
Date: Fri, 05 Feb 2010 20:06:47 -0300
Message-ID: <1265411207-8350-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6407767645742325745==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/hfp.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/plugins/hfp.c b/plugins/hfp.c
index fe7b78b..f235253 100644
--- a/plugins/hfp.c
+++ b/plugins/hfp.c
@@ -547,7 +547,7 @@ static void parse_get_properties(DBusMessage *reply, co=
nst char *device)
 static void get_properties_cb(DBusPendingCall *call, gpointer user_data)
 {
 	DBusMessage *reply;
-	const char *device =3D user_data;
+	char *device =3D user_data;
 =

 	reply =3D dbus_pending_call_steal_reply(call);
 =

@@ -567,6 +567,7 @@ static void get_properties_cb(DBusPendingCall *call, gp=
ointer user_data)
 	parse_get_properties(reply, device);
 =

 done:
+	g_free(device);
 	dbus_message_unref(reply);
 }
 =

@@ -574,7 +575,7 @@ static void list_devices_cb(DBusPendingCall *call, gpoi=
nter user_data)
 {
 	DBusError err;
 	DBusMessage *reply;
-	const char **device =3D NULL;
+	char **device =3D NULL;
 	int num, ret, i;
 =

 	reply =3D dbus_pending_call_steal_reply(call);
@@ -607,11 +608,14 @@ static void list_devices_cb(DBusPendingCall *call, gp=
ointer user_data)
 				BLUEZ_DEVICE_INTERFACE, "GetProperties",
 				get_properties_cb, (void *)device[i],
 				DBUS_TYPE_INVALID);
-		if (ret < 0)
+		if (ret < 0) {
+			g_free(device[i]);
 			ofono_error("GetProperties failed(%d)", ret);
+		}
 	}
 =

 done:
+	g_free(device);
 	dbus_message_unref(reply);
 }
 =

-- =

1.6.6.1


--===============6407767645742325745==--

