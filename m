Content-Type: multipart/mixed; boundary="===============2947913298000135898=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: [PATCH] call-forwarding: allow multiple pending GetProperties
Date: Mon, 18 Jul 2016 23:51:44 +0300
Message-ID: <1468875104-13084-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2947913298000135898==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The very first call that that every org.ofono.CallForwarding
client makes is GetProperties. With multiple clients, only the
first one was waiting for the completion of the initial query,
all other calls were rejected with org.ofono.Error.InProgress.
In theory, the clients could retry the call later, but in
reality very few clients actually do that.

This patch allows multiple GetProperties requests to be pending
simultaneously.
---
 src/call-forwarding.c | 37 +++++++++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/src/call-forwarding.c b/src/call-forwarding.c
index 2746771..762fffe 100644
--- a/src/call-forwarding.c
+++ b/src/call-forwarding.c
@@ -60,6 +60,7 @@ struct ofono_call_forwarding {
 	GSList *cf_conditions[4];
 	int flags;
 	DBusMessage *pending;
+	GSList *pending_get_prop;
 	int query_next;
 	int query_end;
 	struct cf_ss_request *ss_req;
@@ -526,6 +527,14 @@ static DBusMessage *cf_get_properties_reply(DBusMessag=
e *msg,
 	return reply;
 }
 =

+static void cf_send_properties(gpointer data, gpointer user_data)
+{
+	DBusMessage *msg =3D data;
+	DBusMessage *reply =3D cf_get_properties_reply(msg, user_data);
+
+	__ofono_dbus_pending_reply(&msg, reply);
+}
+
 static void get_query_cf_callback(const struct ofono_error *error, int tot=
al,
 			const struct ofono_call_forwarding_condition *list,
 			void *data)
@@ -546,8 +555,9 @@ static void get_query_cf_callback(const struct ofono_er=
ror *error, int total,
 	}
 =

 	if (cf->query_next =3D=3D CALL_FORWARDING_TYPE_NOT_REACHABLE) {
-		__ofono_dbus_pending_reply(&cf->pending,
-				cf_get_properties_reply(cf->pending, cf));
+		g_slist_foreach(cf->pending_get_prop, cf_send_properties, cf);
+		g_slist_free(cf->pending_get_prop);
+		cf->pending_get_prop =3D NULL;
 		return;
 	}
 =

@@ -574,11 +584,18 @@ static DBusMessage *cf_get_properties(DBusConnection =
*conn, DBusMessage *msg,
 	if (cf->driver->query =3D=3D NULL)
 		return __ofono_error_not_implemented(msg);
 =

+	if (cf->pending_get_prop) {
+		/* GetProperties is already in progress */
+		cf->pending_get_prop =3D g_slist_append(cf->pending_get_prop,
+							dbus_message_ref(msg));
+		return NULL;
+	}
+
 	if (__ofono_call_forwarding_is_busy(cf) ||
 			__ofono_ussd_is_busy(cf->ussd))
 		return __ofono_error_busy(msg);
 =

-	cf->pending =3D dbus_message_ref(msg);
+	cf->pending_get_prop =3D g_slist_append(NULL, dbus_message_ref(msg));
 	cf->query_next =3D 0;
 =

 	get_query_next_cf_cond(cf);
@@ -1261,7 +1278,7 @@ static void cf_unregister_ss_controls(struct ofono_ca=
ll_forwarding *cf)
 =

 gboolean __ofono_call_forwarding_is_busy(struct ofono_call_forwarding *cf)
 {
-	return cf->pending ? TRUE : FALSE;
+	return cf->pending || cf->pending_get_prop;
 }
 =

 static void sim_cfis_read_cb(int ok, int total_length, int record,
@@ -1371,6 +1388,13 @@ static void sim_cphs_cff_read_cb(int ok, int total_l=
ength, int record,
 					DBUS_TYPE_BOOLEAN, &cfu_voice);
 }
 =

+static void cf_cancel_get_prop(gpointer data)
+{
+	DBusMessage *msg =3D data;
+
+	__ofono_dbus_pending_reply(&msg, __ofono_error_canceled(msg));
+}
+
 static void call_forwarding_unregister(struct ofono_atom *atom)
 {
 	struct ofono_call_forwarding *cf =3D __ofono_atom_get_data(atom);
@@ -1378,6 +1402,11 @@ static void call_forwarding_unregister(struct ofono_=
atom *atom)
 	DBusConnection *conn =3D ofono_dbus_get_connection();
 	struct ofono_modem *modem =3D __ofono_atom_get_modem(cf->atom);
 =

+	if (cf->pending_get_prop) {
+		g_slist_free_full(cf->pending_get_prop, cf_cancel_get_prop);
+		cf->pending_get_prop =3D NULL;
+	}
+
 	ofono_modem_remove_interface(modem, OFONO_CALL_FORWARDING_INTERFACE);
 	g_dbus_unregister_interface(conn, path,
 					OFONO_CALL_FORWARDING_INTERFACE);
-- =

1.9.1


--===============2947913298000135898==--

