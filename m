Content-Type: multipart/mixed; boundary="===============6640023204008238277=="
MIME-Version: 1.0
From: Andras Domokos <Andras.Domokos@nokia.com>
Subject: [RFC PATCH 3/3] voicecall: add emergency call handling
Date: Mon, 20 Dec 2010 15:22:14 +0200
Message-ID: <2b17c56e68aeb803844582a58b46d66915cb1f92.1292849833.git.Andras.Domokos@nokia.com>
In-Reply-To: <cover.1292849833.git.Andras.Domokos@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6640023204008238277==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/voicecall.c |  122 +++++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 files changed, 121 insertions(+), 1 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index 0120cd0..370f760 100644
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
@@ -134,6 +135,22 @@ static void add_to_en_list(GSList **l, const char **li=
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
+	if (number =3D=3D NULL)
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
@@ -1134,6 +1151,7 @@ handled:
 static void manager_dial_callback(const struct ofono_error *error, void *d=
ata)
 {
 	struct ofono_voicecall *vc =3D data;
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(vc->atom);
 	DBusMessage *reply;
 	const char *number;
 	gboolean need_to_emit;
@@ -1152,8 +1170,12 @@ static void manager_dial_callback(const struct ofono=
_error *error, void *data)
 =

 		dbus_message_append_args(reply, DBUS_TYPE_OBJECT_PATH, &path,
 						DBUS_TYPE_INVALID);
-	} else
+	} else {
+		if (emergency_number(vc, number))
+			ofono_modem_dec_emergency(modem);
+
 		reply =3D __ofono_error_failed(vc->pending);
+	}
 =

 	__ofono_dbus_pending_reply(&vc->pending, reply);
 =

@@ -1165,6 +1187,7 @@ static DBusMessage *manager_dial(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
 	struct ofono_voicecall *vc =3D data;
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(vc->atom);
 	const char *number;
 	struct ofono_phone_number ph;
 	const char *clirstr;
@@ -1204,6 +1227,16 @@ static DBusMessage *manager_dial(DBusConnection *con=
n,
 =

 	string_to_phone_number(number, &ph);
 =

+	if (emergency_number(vc, number)) {
+		int online;
+
+		ofono_modem_inc_emergency(modem);
+
+		online =3D ofono_modem_get_online(modem);
+		if (online !=3D TRUE)
+			return NULL;
+	}
+
 	vc->driver->dial(vc, &ph, clir, OFONO_CUG_OPTION_DEFAULT,
 				manager_dial_callback, vc);
 =

@@ -1757,6 +1790,7 @@ void ofono_voicecall_disconnected(struct ofono_voicec=
all *vc, int id,
 				const struct ofono_error *error)
 {
 	struct ofono_modem *modem =3D __ofono_atom_get_modem(vc->atom);
+	const char *number;
 	GSList *l;
 	struct voicecall *call;
 	time_t ts;
@@ -1776,6 +1810,7 @@ void ofono_voicecall_disconnected(struct ofono_voicec=
all *vc, int id,
 	}
 =

 	call =3D l->data;
+	number =3D phone_number_to_string(&call->call->phone_number);
 =

 	ts =3D time(NULL);
 	prev_status =3D call->call->status;
@@ -1814,6 +1849,9 @@ void ofono_voicecall_disconnected(struct ofono_voicec=
all *vc, int id,
 =

 	voicecalls_emit_call_removed(vc, call);
 =

+	if (emergency_number(vc, number))
+		ofono_modem_dec_emergency(modem);
+
 	voicecall_dbus_unregister(vc, call);
 =

 	vc->call_list =3D g_slist_remove(vc->call_list, call);
@@ -2074,6 +2112,7 @@ static void voicecall_unregister(struct ofono_atom *a=
tom)
 static void voicecall_remove(struct ofono_atom *atom)
 {
 	struct ofono_voicecall *vc =3D __ofono_atom_get_data(atom);
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(atom);
 =

 	DBG("atom: %p", atom);
 =

@@ -2115,6 +2154,12 @@ static void voicecall_remove(struct ofono_atom *atom)
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

@@ -2212,6 +2257,7 @@ static void sim_watch(struct ofono_atom *atom,
 static void dial_request_cb(const struct ofono_error *error, void *data)
 {
 	struct ofono_voicecall *vc =3D data;
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(vc->atom);
 	gboolean need_to_emit;
 	struct voicecall *v;
 =

@@ -2221,6 +2267,10 @@ static void dial_request_cb(const struct ofono_error=
 *error, void *data)
 =

 	if (v =3D=3D NULL) {
 		dial_request_finish(vc);
+
+		if (emergency_number(vc,
+				phone_number_to_string(&vc->dial_req->ph)))
+			ofono_modem_dec_emergency(modem);
 		return;
 	}
 =

@@ -2244,6 +2294,61 @@ static void dial_request_cb(const struct ofono_error=
 *error, void *data)
 		voicecalls_emit_call_added(vc, v);
 }
 =

+static void modem_online_watch(ofono_bool_t online, void *data)
+{
+	struct ofono_voicecall *vc =3D data;
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(vc->atom);
+	static ofono_bool_t modem_online =3D FALSE;
+	static ofono_bool_t modem_online_prev;
+	const char *number;
+	struct ofono_phone_number ph;
+	const char *clirstr;
+	enum ofono_clir_option clir;
+
+	modem_online_prev =3D modem_online;
+	modem_online =3D online;
+
+	if (ofono_modem_get_emergency(modem) !=3D TRUE)
+		return;
+
+	if (vc->dial_req)
+		vc->driver->dial(vc, &vc->dial_req->ph,
+					OFONO_CLIR_OPTION_DEFAULT,
+					OFONO_CUG_OPTION_DEFAULT,
+					dial_request_cb, vc);
+
+	if (vc->pending =3D=3D NULL)
+		return;
+
+	if (strcmp(dbus_message_get_member(vc->pending), "Dial"))
+		return;
+
+	if (dbus_message_get_args(vc->pending, NULL, DBUS_TYPE_STRING, &number,
+					DBUS_TYPE_STRING, &clirstr,
+					DBUS_TYPE_INVALID) =3D=3D FALSE)
+		return;
+
+	if (emergency_number(vc, number) =3D=3D FALSE)
+		return;
+
+	if (online =3D=3D FALSE) {
+		if (online =3D=3D modem_online_prev) {
+			DBusMessage *reply =3D __ofono_error_failed(vc->pending);
+
+			__ofono_dbus_pending_reply(&vc->pending, reply);
+			ofono_modem_dec_emergency(modem);
+		}
+
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
@@ -2262,6 +2367,9 @@ void ofono_voicecall_register(struct ofono_voicecall =
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
@@ -2338,6 +2446,18 @@ ofono_bool_t __ofono_voicecall_is_busy(struct ofono_=
voicecall *vc,
 =

 static void dial_request(struct ofono_voicecall *vc)
 {
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(vc->atom);
+
+	if (emergency_number(vc, phone_number_to_string(&vc->dial_req->ph))) {
+		int online;
+
+		ofono_modem_inc_emergency(modem);
+
+		online =3D ofono_modem_get_online(modem);
+		if (online !=3D TRUE)
+			return;
+	}
+
 	vc->driver->dial(vc, &vc->dial_req->ph, OFONO_CLIR_OPTION_DEFAULT,
 				OFONO_CUG_OPTION_DEFAULT, dial_request_cb, vc);
 }
-- =

1.7.0.4


--===============6640023204008238277==--

