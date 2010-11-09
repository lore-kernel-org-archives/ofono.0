Content-Type: multipart/mixed; boundary="===============2811972922155055959=="
MIME-Version: 1.0
From: Andras Domokos <Andras.Domokos@nokia.com>
Subject: [RFC PATCH 3/3] voicecall: add emergency call handling
Date: Tue, 09 Nov 2010 11:00:00 +0200
Message-ID: <7a8dc913d70a01ce874800a5fe25d026006d2ee6.1289226246.git.Andras.Domokos@nokia.com>
In-Reply-To: <cover.1289226246.git.Andras.Domokos@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2811972922155055959==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Signed-off-by: Andras Domokos <Andras.Domokos@nokia.com>
---
 src/voicecall.c |  101 +++++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 files changed, 100 insertions(+), 1 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index bd64432..0268ce1 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -52,6 +52,7 @@ struct ofono_voicecall {
 	struct ofono_sim *sim;
 	unsigned int sim_watch;
 	unsigned int sim_state_watch;
+	unsigned int modem_online_watch;
 	const struct ofono_voicecall_driver *driver;
 	void *driver_data;
 	struct ofono_atom *atom;
@@ -133,6 +134,22 @@ static void add_to_en_list(GSList **l, const char **li=
st)
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
 static const char *disconnect_reason_to_string(enum ofono_disconnect_reaso=
n r)
 {
 	switch (r) {
@@ -1125,6 +1142,7 @@ static struct voicecall *dial_handle_result(struct of=
ono_voicecall *vc,
 static void manager_dial_callback(const struct ofono_error *error, void *d=
ata)
 {
 	struct ofono_voicecall *vc =3D data;
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(vc->atom);
 	DBusMessage *reply;
 	const char *number;
 	gboolean need_to_emit;
@@ -1143,8 +1161,11 @@ static void manager_dial_callback(const struct ofono=
_error *error, void *data)
 =

 		dbus_message_append_args(reply, DBUS_TYPE_OBJECT_PATH, &path,
 						DBUS_TYPE_INVALID);
-	} else
+	} else {
+		if (emergency_number(vc, number))
+			ofono_modem_dec_emergency_mode(modem);
 		reply =3D __ofono_error_failed(vc->pending);
+	}
 =

 	__ofono_dbus_pending_reply(&vc->pending, reply);
 =

@@ -1156,6 +1177,7 @@ static DBusMessage *manager_dial(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
 	struct ofono_voicecall *vc =3D data;
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(vc->atom);
 	const char *number;
 	struct ofono_phone_number ph;
 	const char *clirstr;
@@ -1195,6 +1217,13 @@ static DBusMessage *manager_dial(DBusConnection *con=
n,
 =

 	string_to_phone_number(number, &ph);
 =

+	if (emergency_number(vc, number)) {
+		ofono_bool_t online =3D ofono_modem_get_online(modem);
+		ofono_modem_inc_emergency_mode(modem);
+		if (!online)
+			return NULL;
+	}
+
 	vc->driver->dial(vc, &ph, clir, OFONO_CUG_OPTION_DEFAULT,
 				manager_dial_callback, vc);
 =

@@ -1748,6 +1777,7 @@ void ofono_voicecall_disconnected(struct ofono_voicec=
all *vc, int id,
 				const struct ofono_error *error)
 {
 	struct ofono_modem *modem =3D __ofono_atom_get_modem(vc->atom);
+	const char *number;
 	GSList *l;
 	struct voicecall *call;
 	time_t ts;
@@ -1767,6 +1797,7 @@ void ofono_voicecall_disconnected(struct ofono_voicec=
all *vc, int id,
 	}
 =

 	call =3D l->data;
+	number =3D phone_number_to_string(&call->call->phone_number);
 =

 	ts =3D time(NULL);
 	prev_status =3D call->call->status;
@@ -1805,6 +1836,9 @@ void ofono_voicecall_disconnected(struct ofono_voicec=
all *vc, int id,
 =

 	voicecalls_emit_call_removed(vc, call);
 =

+	if (emergency_number(vc, number))
+		ofono_modem_dec_emergency_mode(modem);
+
 	voicecall_dbus_unregister(vc, call);
 =

 	vc->call_list =3D g_slist_remove(vc->call_list, call);
@@ -1814,6 +1848,7 @@ void ofono_voicecall_notify(struct ofono_voicecall *v=
c,
 				const struct ofono_call *call)
 {
 	struct ofono_modem *modem =3D __ofono_atom_get_modem(vc->atom);
+	const char *number;
 	GSList *l;
 	struct voicecall *v =3D NULL;
 	struct ofono_call *newcall;
@@ -1860,6 +1895,10 @@ void ofono_voicecall_notify(struct ofono_voicecall *=
vc,
 =

 	vc->call_list =3D g_slist_insert_sorted(vc->call_list, v, call_compare);
 =

+	number =3D phone_number_to_string(&v->call->phone_number);
+	if (emergency_number(vc, number))
+		ofono_modem_inc_emergency_mode(modem);
+
 	voicecalls_emit_call_added(vc, v);
 =

 	return;
@@ -2067,6 +2106,7 @@ static void voicecall_unregister(struct ofono_atom *a=
tom)
 static void voicecall_remove(struct ofono_atom *atom)
 {
 	struct ofono_voicecall *vc =3D __ofono_atom_get_data(atom);
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(atom);
 =

 	DBG("atom: %p", atom);
 =

@@ -2108,6 +2148,12 @@ static void voicecall_remove(struct ofono_atom *atom)
 		g_queue_free(vc->toneq);
 	}
 =

+	if (vc->modem_online_watch) {
+		__ofono_modem_remove_online_watch(modem,
+						vc->modem_online_watch);
+		vc->modem_online_watch =3D 0;
+	}
+
 	g_free(vc);
 }
 =

@@ -2202,6 +2248,47 @@ static void sim_watch(struct ofono_atom *atom,
 	sim_state_watch(ofono_sim_get_state(sim), vc);
 }
 =

+static void modem_online_watch(ofono_bool_t state, void *data)
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
+	if (!emergency_number(vc, number))
+		return;
+
+	if (!ofono_modem_get_online(modem)) {
+		reply =3D __ofono_error_failed(vc->pending);
+		__ofono_dbus_pending_reply(&vc->pending, reply);
+		ofono_modem_dec_emergency_mode(modem);
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
 void ofono_voicecall_register(struct ofono_voicecall *vc)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
@@ -2220,6 +2307,9 @@ void ofono_voicecall_register(struct ofono_voicecall =
*vc)
 	}
 =

 	ofono_modem_add_interface(modem, OFONO_VOICECALL_MANAGER_INTERFACE);
+	vc->modem_online_watch =3D __ofono_modem_add_online_watch(modem,
+							modem_online_watch,
+							vc, NULL);
 =

 	/*
 	 * Start out with the 22.101 mandated numbers, if we have a SIM and
@@ -2297,6 +2387,7 @@ ofono_bool_t __ofono_voicecall_is_busy(struct ofono_v=
oicecall *vc,
 static void dial_request_cb(const struct ofono_error *error, void *data)
 {
 	struct ofono_voicecall *vc =3D data;
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(vc->atom);
 	gboolean need_to_emit;
 	struct voicecall *v;
 =

@@ -2306,6 +2397,9 @@ static void dial_request_cb(const struct ofono_error =
*error, void *data)
 =

 	if (v =3D=3D NULL) {
 		dial_request_finish(vc);
+		if (emergency_number(vc,
+				phone_number_to_string(&vc->dial_req->ph)))
+			ofono_modem_inc_emergency_mode(modem);
 		return;
 	}
 =

@@ -2331,6 +2425,11 @@ static void dial_request_cb(const struct ofono_error=
 *error, void *data)
 =

 static void dial_request(struct ofono_voicecall *vc)
 {
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(vc->atom);
+
+	if (emergency_number(vc, phone_number_to_string(&vc->dial_req->ph)))
+		ofono_modem_inc_emergency_mode(modem);
+
 	vc->driver->dial(vc, &vc->dial_req->ph, OFONO_CLIR_OPTION_DEFAULT,
 				OFONO_CUG_OPTION_DEFAULT, dial_request_cb, vc);
 }
-- =

1.7.0.4


--===============2811972922155055959==--

