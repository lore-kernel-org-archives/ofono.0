Content-Type: multipart/mixed; boundary="===============1210444492353385126=="
MIME-Version: 1.0
From: Andras Domokos <andras.domokos@nokia.com>
Subject: [RFC PATCH 2/3] voicecall: emergency call handling added
Date: Fri, 22 Oct 2010 19:47:53 +0300
Message-ID: <6e335becb35a0d670ba6bbf658827637836a7b1c.1287763218.git.andras.domokos@nokia.com>
In-Reply-To: <cover.1287763218.git.andras.domokos@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1210444492353385126==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Signed-off-by: Andras Domokos <andras.domokos@nokia.com>
---
 include/voicecall.h |   12 +++
 src/voicecall.c     |  221 ++++++++++++++++++++++++++++++++++++++++++++++-=
---
 2 files changed, 215 insertions(+), 18 deletions(-)

diff --git a/include/voicecall.h b/include/voicecall.h
index 2356fcf..d530148 100644
--- a/include/voicecall.h
+++ b/include/voicecall.h
@@ -38,6 +38,9 @@ typedef void (*ofono_call_list_cb_t)(const struct ofono_e=
rror *error,
 					const struct ofono_call *call_list,
 					void *data);
 =

+typedef void (*ofono_voicecall_emergency_notify_cb_t)(ofono_bool_t state,
+							void *data);
+
 /* Voice call related functionality, including ATD, ATA, +CHLD, CTFR, CLCC
  * and VTS.
  *
@@ -116,6 +119,15 @@ void ofono_voicecall_set_data(struct ofono_voicecall *=
vc, void *data);
 void *ofono_voicecall_get_data(struct ofono_voicecall *vc);
 int ofono_voicecall_get_next_callid(struct ofono_voicecall *vc);
 =

+unsigned int __ofono_voicecall_add_emergency_watch(struct ofono_voicecall =
*vc,
+				ofono_voicecall_emergency_notify_cb_t notify,
+				void *data, ofono_destroy_func destroy);
+void __ofono_voicecall_remove_emergency_watch(struct ofono_voicecall *vc,
+						unsigned int id);
+ofono_bool_t ofono_voicecall_get_emergency_state(struct ofono_voicecall *v=
c);
+void __ofono_voicecall_set_emergency_state(struct ofono_voicecall *vc,
+						int state);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/src/voicecall.c b/src/voicecall.c
index 7b5fe3b..a619b30 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -25,6 +25,7 @@
 =

 #include <string.h>
 #include <stdio.h>
+#include <stdlib.h>
 #include <time.h>
 #include <errno.h>
 #include <stdint.h>
@@ -56,6 +57,9 @@ struct ofono_voicecall {
 	void *driver_data;
 	struct ofono_atom *atom;
 	struct dial_request *dial_req;
+	struct ofono_watchlist *emergency_watches;
+	unsigned int emergency_state;
+	unsigned int modem_state_watch;
 };
 =

 struct voicecall {
@@ -85,6 +89,8 @@ static const char *default_en_list_no_sim[] =3D { "119", =
"118", "999", "110",
 =

 static void generic_callback(const struct ofono_error *error, void *data);
 static void multirelease_callback(const struct ofono_error *err, void *dat=
a);
+static const char *voicecall_build_path(struct ofono_voicecall *vc,
+					const struct ofono_call *call);
 =

 static gint call_compare_by_id(gconstpointer a, gconstpointer b)
 {
@@ -121,6 +127,145 @@ static void add_to_en_list(GSList **l, const char **l=
ist)
 		*l =3D g_slist_prepend(*l, g_strdup(list[i++]));
 }
 =

+static gint number_compare(gconstpointer a, gconstpointer b)
+{
+	const char *s1 =3D a, *s2 =3D b;
+	return strcmp(s1, s2);
+}
+
+static ofono_bool_t emergency_number(struct ofono_voicecall *vc,
+					const char *number)
+{
+	if (!number)
+		return FALSE;
+
+	return g_slist_find_custom(vc->en_list,
+				number, number_compare) ? TRUE : FALSE;
+}
+
+static void notify_emergency_watches(struct ofono_voicecall *vc,
+					ofono_bool_t state)
+{
+	struct ofono_watchlist_item *item;
+	GSList *l;
+	ofono_voicecall_emergency_notify_cb_t notify;
+
+	if (vc->emergency_watches =3D=3D NULL)
+		return;
+
+	for (l =3D vc->emergency_watches->items; l; l =3D l->next) {
+		item =3D l->data;
+		notify =3D item->notify;
+		notify(state, item->notify_data);
+	}
+}
+
+unsigned int __ofono_voicecall_add_emergency_watch(struct ofono_voicecall =
*vc,
+				ofono_voicecall_emergency_notify_cb_t notify,
+				void *data, ofono_destroy_func destroy)
+{
+	struct ofono_watchlist_item *item;
+
+	if (vc =3D=3D NULL || notify =3D=3D NULL)
+		return 0;
+
+	item =3D g_new0(struct ofono_watchlist_item, 1);
+
+	item->notify =3D notify;
+	item->destroy =3D destroy;
+	item->notify_data =3D data;
+
+	return __ofono_watchlist_add_item(vc->emergency_watches, item);
+}
+
+void __ofono_voicecall_remove_emergency_watch(struct ofono_voicecall *vc,
+						unsigned int id)
+{
+	__ofono_watchlist_remove_item(vc->emergency_watches, id);
+}
+
+ofono_bool_t ofono_voicecall_get_emergency_state(struct ofono_voicecall *v=
c)
+{
+	return vc->emergency_state ? 1 : 0;
+}
+
+void __ofono_voicecall_inc_emergency_state(struct ofono_voicecall *vc)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D __ofono_atom_get_path(vc->atom);
+	gboolean state =3D TRUE;
+
+	if (!vc->emergency_state++) {
+		ofono_dbus_signal_property_changed(conn, path,
+						OFONO_VOICECALL_INTERFACE,
+						"EmergencyMode",
+						DBUS_TYPE_BOOLEAN,
+						&state);
+		notify_emergency_watches(vc, state);
+	}
+}
+
+void __ofono_voicecall_dec_emergency_state(struct ofono_voicecall *vc)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D __ofono_atom_get_path(vc->atom);
+	gboolean state =3D FALSE;
+
+	if (!--vc->emergency_state) {
+		ofono_dbus_signal_property_changed(conn, path,
+						OFONO_VOICECALL_INTERFACE,
+						"EmergencyMode",
+						DBUS_TYPE_BOOLEAN,
+						&state);
+		notify_emergency_watches(vc, state);
+	}
+}
+
+static ofono_bool_t clir_string_to_clir(const char *clirstr,
+					enum ofono_clir_option *clir);
+static void manager_dial_callback(const struct ofono_error *error, void *d=
ata);
+static void modem_state_watch(enum ofono_modem_state state, void *data)
+{
+	struct ofono_voicecall *vc =3D data;
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(vc->atom);
+	DBusMessage *reply;
+	const char *number;
+	struct ofono_phone_number ph;
+	const char *clirstr;
+	enum ofono_clir_option clir;
+
+	if (!vc->pending)
+		return;
+
+	if (strcmp(dbus_message_get_member(vc->pending), "Dial"))
+		return;
+
+	if (dbus_message_get_args(vc->pending, NULL, DBUS_TYPE_STRING, &number,
+					DBUS_TYPE_STRING, &clirstr,
+					DBUS_TYPE_INVALID) =3D=3D FALSE) {
+		reply =3D __ofono_error_invalid_args(vc->pending);
+		__ofono_dbus_pending_reply(&vc->pending, reply);
+		return;
+	}
+
+	/* don't care here about non-emergency calls */
+	if (!emergency_number(vc, number))
+		return;
+
+	if (!ofono_modem_get_online(modem)) {
+		reply =3D __ofono_error_failed(vc->pending);
+		__ofono_dbus_pending_reply(&vc->pending, reply);
+		__ofono_voicecall_dec_emergency_state(vc);
+		return;
+	}
+
+	clir_string_to_clir(clirstr, &clir);
+	string_to_phone_number(number, &ph);
+
+	vc->driver->dial(vc, &ph, clir, OFONO_CUG_OPTION_DEFAULT,
+				manager_dial_callback, vc);
+}
+
 static const char *disconnect_reason_to_string(enum ofono_disconnect_reaso=
n r)
 {
 	switch (r) {
@@ -718,7 +863,8 @@ static gboolean voicecalls_can_dtmf(struct ofono_voicec=
all *vc)
 	return FALSE;
 }
 =

-static gboolean voicecalls_have_with_status(struct ofono_voicecall *vc, in=
t status)
+static gboolean voicecalls_have_with_status(struct ofono_voicecall *vc,
+						int status)
 {
 	GSList *l;
 	struct voicecall *v;
@@ -918,6 +1064,7 @@ static DBusMessage *manager_get_properties(DBusConnect=
ion *conn,
 	int i;
 	GSList *l;
 	char **list;
+	ofono_bool_t emergency_state;
 =

 	reply =3D dbus_message_new_method_return(msg);
 =

@@ -930,6 +1077,10 @@ static DBusMessage *manager_get_properties(DBusConnec=
tion *conn,
 					OFONO_PROPERTIES_ARRAY_SIGNATURE,
 					&dict);
 =

+	emergency_state =3D ofono_voicecall_get_emergency_state(vc);
+	ofono_dbus_dict_append(&dict, "EmergencyMode",
+				DBUS_TYPE_BOOLEAN, &emergency_state);
+
 	/* property EmergencyNumbers */
 	list =3D g_new0(char *, g_slist_length(vc->en_list) + 1);
 =

@@ -1066,8 +1217,11 @@ static void manager_dial_callback(const struct ofono=
_error *error, void *data)
 =

 		dbus_message_append_args(reply, DBUS_TYPE_OBJECT_PATH, &path,
 						DBUS_TYPE_INVALID);
-	} else
+	} else {
+		if (emergency_number(vc, number))
+			__ofono_voicecall_dec_emergency_state(vc);
 		reply =3D __ofono_error_failed(vc->pending);
+	}
 =

 	__ofono_dbus_pending_reply(&vc->pending, reply);
 =

@@ -1118,6 +1272,14 @@ static DBusMessage *manager_dial(DBusConnection *con=
n,
 =

 	string_to_phone_number(number, &ph);
 =

+	if (emergency_number(vc, number)) {
+		struct ofono_modem *modem =3D __ofono_atom_get_modem(vc->atom);
+		ofono_bool_t online =3D ofono_modem_get_online(modem);
+		__ofono_voicecall_inc_emergency_state(vc);
+		if (!online)
+			return NULL;
+	}
+
 	vc->driver->dial(vc, &ph, clir, OFONO_CUG_OPTION_DEFAULT,
 				manager_dial_callback, vc);
 =

@@ -1667,7 +1829,7 @@ void ofono_voicecall_disconnected(struct ofono_voicec=
all *vc, int id,
 {
 	struct ofono_modem *modem =3D __ofono_atom_get_modem(vc->atom);
 	GSList *l;
-	struct voicecall *call;
+	struct voicecall *v;
 	time_t ts;
 	enum call_status prev_status;
 =

@@ -1684,48 +1846,52 @@ void ofono_voicecall_disconnected(struct ofono_voic=
ecall *vc, int id,
 		return;
 	}
 =

-	call =3D l->data;
+	v =3D l->data;
 =

 	ts =3D time(NULL);
-	prev_status =3D call->call->status;
+	prev_status =3D v->call->status;
 =

 	l =3D g_slist_find_custom(vc->multiparty_list, GUINT_TO_POINTER(id),
 				call_compare_by_id);
 =

 	if (l) {
 		vc->multiparty_list =3D
-			g_slist_remove(vc->multiparty_list, call);
+			g_slist_remove(vc->multiparty_list, v);
 =

 		if (vc->multiparty_list->next =3D=3D NULL) { /* Size =3D=3D 1 */
-			struct voicecall *v =3D vc->multiparty_list->data;
+			struct voicecall *v2 =3D vc->multiparty_list->data;
 =

-			voicecall_emit_multiparty(v, FALSE);
+			voicecall_emit_multiparty(v2, FALSE);
 			g_slist_free(vc->multiparty_list);
 			vc->multiparty_list =3D 0;
 		}
 	}
 =

-	vc->release_list =3D g_slist_remove(vc->release_list, call);
+	vc->release_list =3D g_slist_remove(vc->release_list, v);
 =

 	if (reason !=3D OFONO_DISCONNECT_REASON_UNKNOWN)
-		voicecall_emit_disconnect_reason(call, reason);
+		voicecall_emit_disconnect_reason(v, reason);
 =

-	voicecall_set_call_status(call, CALL_STATUS_DISCONNECTED);
+	voicecall_set_call_status(v, CALL_STATUS_DISCONNECTED);
 =

-	if (!call->untracked) {
+	if (!v->untracked) {
 		if (prev_status =3D=3D CALL_STATUS_INCOMING ||
 				prev_status =3D=3D CALL_STATUS_WAITING)
-			__ofono_history_call_missed(modem, call->call, ts);
+			__ofono_history_call_missed(modem, v->call, ts);
 		else
-			__ofono_history_call_ended(modem, call->call,
-							call->detect_time, ts);
+			__ofono_history_call_ended(modem, v->call,
+							v->detect_time, ts);
 	}
 =

-	voicecalls_emit_call_removed(vc, call);
+	voicecalls_emit_call_removed(vc, v);
+
+	if (emergency_number(vc,
+			phone_number_to_string(&v->call->phone_number)))
+		__ofono_voicecall_dec_emergency_state(vc);
 =

-	voicecall_dbus_unregister(vc, call);
+	voicecall_dbus_unregister(vc, v);
 =

-	vc->call_list =3D g_slist_remove(vc->call_list, call);
+	vc->call_list =3D g_slist_remove(vc->call_list, v);
 }
 =

 void ofono_voicecall_notify(struct ofono_voicecall *vc,
@@ -1969,6 +2135,9 @@ static void voicecall_unregister(struct ofono_atom *a=
tom)
 		vc->sim_watch =3D 0;
 	}
 =

+	__ofono_watchlist_free(vc->emergency_watches);
+	vc->emergency_watches =3D NULL;
+
 	if (vc->dial_req)
 		dial_request_finish(vc);
 =

@@ -1985,6 +2154,7 @@ static void voicecall_unregister(struct ofono_atom *a=
tom)
 static void voicecall_remove(struct ofono_atom *atom)
 {
 	struct ofono_voicecall *vc =3D __ofono_atom_get_data(atom);
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(atom);
 =

 	DBG("atom: %p", atom);
 =

@@ -2012,6 +2182,11 @@ static void voicecall_remove(struct ofono_atom *atom)
 		vc->sim =3D NULL;
 	}
 =

+	if (vc->modem_state_watch) {
+		__ofono_modem_remove_state_watch(modem, vc->modem_state_watch);
+		vc->modem_state_watch =3D 0;
+	}
+
 	g_free(vc);
 }
 =

@@ -2122,6 +2297,10 @@ void ofono_voicecall_register(struct ofono_voicecall=
 *vc)
 	}
 =

 	ofono_modem_add_interface(modem, OFONO_VOICECALL_MANAGER_INTERFACE);
+	vc->emergency_watches =3D __ofono_watchlist_new(g_free);
+	vc->modem_state_watch =3D __ofono_modem_add_state_watch(modem,
+							modem_state_watch,
+							vc, NULL);
 =

 	/*
 	 * Start out with the 22.101 mandated numbers, if we have a SIM and
@@ -2208,6 +2387,9 @@ static void dial_request_cb(const struct ofono_error =
*error, void *data)
 =

 	if (v =3D=3D NULL) {
 		dial_request_finish(vc);
+		if (emergency_number(vc,
+				phone_number_to_string(&vc->dial_req->ph)))
+			__ofono_voicecall_inc_emergency_state(vc);
 		return;
 	}
 =

@@ -2233,6 +2415,9 @@ static void dial_request_cb(const struct ofono_error =
*error, void *data)
 =

 static void dial_request(struct ofono_voicecall *vc)
 {
+	if (emergency_number(vc, phone_number_to_string(&vc->dial_req->ph)))
+		__ofono_voicecall_inc_emergency_state(vc);
+
 	vc->driver->dial(vc, &vc->dial_req->ph, OFONO_CLIR_OPTION_DEFAULT,
 				OFONO_CUG_OPTION_DEFAULT, dial_request_cb, vc);
 }
-- =

1.7.0.4


--===============1210444492353385126==--

