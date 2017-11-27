Content-Type: multipart/mixed; boundary="===============4762716893435365693=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: [PATCH] sim-auth: Avoid using dbus_message_iter_get_element_count
Date: Mon, 27 Nov 2017 13:06:44 +0200
Message-ID: <1511780804-4383-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4762716893435365693==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

It's the only thing in ofono that requires dbus 1.9.16 or later and it's
not worth it.

And don't leak DBusMessage on format error.
---
 src/sim-auth.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/src/sim-auth.c b/src/sim-auth.c
index f9f74d4..7b65738 100644
--- a/src/sim-auth.c
+++ b/src/sim-auth.c
@@ -369,9 +369,7 @@ static DBusMessage *usim_gsm_authenticate(DBusConnectio=
n *conn,
 	struct ofono_sim_auth *sa =3D data;
 	DBusMessageIter iter;
 	DBusMessageIter array;
-	int i;
 	uint8_t *aid;
-	int rands;
 =

 	if (sa->pending)
 		return __ofono_error_busy(msg);
@@ -381,27 +379,22 @@ static DBusMessage *usim_gsm_authenticate(DBusConnect=
ion *conn,
 	if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_ARRAY)
 		return __ofono_error_invalid_format(msg);
 =

-	rands =3D dbus_message_iter_get_element_count(&iter);
-
-	if (rands > 3 || rands < 2)
-		return __ofono_error_invalid_format(msg);
-
 	sa->pending =3D g_new0(struct auth_request, 1);
-	sa->pending->msg =3D dbus_message_ref(msg);
-	sa->pending->num_rands =3D rands;
 =

 	dbus_message_iter_recurse(&iter, &array);
 =

-	for (i =3D 0; i < sa->pending->num_rands; i++) {
+	while (dbus_message_iter_get_arg_type(&array) =3D=3D DBUS_TYPE_ARRAY) {
 		int nelement;
 		DBusMessageIter in;
 =

 		dbus_message_iter_recurse(&array, &in);
 =

-		if (dbus_message_iter_get_arg_type(&in) !=3D DBUS_TYPE_BYTE)
+		if (dbus_message_iter_get_arg_type(&in) !=3D DBUS_TYPE_BYTE ||
+				sa->pending->num_rands =3D=3D SIM_AUTH_MAX_RANDS)
 			goto format_error;
 =

-		dbus_message_iter_get_fixed_array(&in, &sa->pending->rands[i],
+		dbus_message_iter_get_fixed_array(&in,
+				&sa->pending->rands[sa->pending->num_rands++],
 				&nelement);
 =

 		if (nelement !=3D 16)
@@ -410,12 +403,15 @@ static DBusMessage *usim_gsm_authenticate(DBusConnect=
ion *conn,
 		dbus_message_iter_next(&array);
 	}
 =

+	if (sa->pending->num_rands < 2)
+		goto format_error;
+
 	/*
 	 * retrieve session from SIM
 	 */
 	aid =3D find_aid_by_path(sa->aid_objects, dbus_message_get_path(msg));
 	sa->pending->session =3D __ofono_sim_get_session_by_aid(sa->sim, aid);
-
+	sa->pending->msg =3D dbus_message_ref(msg);
 	sa->pending->watch_id =3D __ofono_sim_add_session_watch(
 			sa->pending->session, get_session_cb, sa, NULL);
 =

-- =

1.9.1


--===============4762716893435365693==--

