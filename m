Content-Type: multipart/mixed; boundary="===============1332582007199039355=="
MIME-Version: 1.0
From: James Prestwood <james.prestwood@linux.intel.com>
Subject: [PATCH] simauth: fixup adding more dbus return checks
Date: Fri, 13 Oct 2017 11:21:21 -0700
Message-ID: <1507918881-28686-1-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1332582007199039355==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/sim-auth.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/src/sim-auth.c b/src/sim-auth.c
index b9552b5..90f00c9 100644
--- a/src/sim-auth.c
+++ b/src/sim-auth.c
@@ -427,6 +427,7 @@ static DBusMessage *usim_gsm_authenticate(DBusConnectio=
n *conn,
 	DBusMessageIter array;
 	int i;
 	struct sim_app_record *app;
+	int rands;
 =

 	if (sim->pending)
 		return __ofono_error_busy(msg);
@@ -436,11 +437,16 @@ static DBusMessage *usim_gsm_authenticate(DBusConnect=
ion *conn,
 	if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_ARRAY)
 		return __ofono_error_invalid_format(msg);
 =

+	rands =3D dbus_message_iter_get_element_count(&iter);
+
+	if (rands > 3)
+		return __ofono_error_invalid_format(msg);
+
 	sim->pending =3D malloc(sizeof(struct auth_request));
 	sim->pending->msg =3D dbus_message_ref(msg);
 	sim->pending->umts =3D 0;
 	sim->pending->cb_count =3D 0;
-	sim->pending->num_rands =3D dbus_message_iter_get_element_count(&iter);
+	sim->pending->num_rands =3D rands;
 =

 	dbus_message_iter_recurse(&iter, &array);
 =

@@ -450,14 +456,14 @@ static DBusMessage *usim_gsm_authenticate(DBusConnect=
ion *conn,
 =

 		dbus_message_iter_recurse(&array, &in);
 =

+		if (dbus_message_iter_get_arg_type(&in) !=3D DBUS_TYPE_BYTE)
+			goto format_error;
+
 		dbus_message_iter_get_fixed_array(&in, &sim->pending->rands[i],
 				&nelement);
 =

-		if (nelement !=3D 16) {
-			g_free(sim->pending);
-			sim->pending =3D NULL;
-			return __ofono_error_invalid_format(msg);
-		}
+		if (nelement !=3D 16)
+			goto format_error;
 =

 		dbus_message_iter_next(&array);
 	}
@@ -467,6 +473,11 @@ static DBusMessage *usim_gsm_authenticate(DBusConnecti=
on *conn,
 	sim->driver->open_channel(sim, app->aid, open_channel_cb, sim);
 =

 	return NULL;
+
+format_error:
+	g_free(sim->pending);
+	sim->pending =3D NULL;
+	return __ofono_error_invalid_format(msg);
 }
 =

 static DBusMessage *umts_common(DBusConnection *conn, DBusMessage *msg,
-- =

2.7.4


--===============1332582007199039355==--

