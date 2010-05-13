Content-Type: multipart/mixed; boundary="===============0438722859595462850=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 11/16] emulator: Add voicecall dialing case
Date: Thu, 13 May 2010 18:02:34 +0800
Message-ID: <1273744959-3711-12-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1273744959-3711-11-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0438722859595462850==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/voicecall.c |  208 +++++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 files changed, 207 insertions(+), 1 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index b2bb41f..1b6a6c7 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -36,6 +36,7 @@
 #include "common.h"
 #include "simutil.h"
 #include "smsutil.h"
+#include "gatserver.h"
 =

 #define VOICECALLS_FLAG_MULTI_RELEASE 0x1
 =

@@ -56,6 +57,10 @@ struct ofono_voicecall {
 	struct ofono_sim *sim;
 	unsigned int sim_watch;
 	unsigned int sim_state_watch;
+	struct ofono_emulator *oe;
+	struct emulator *e;
+	unsigned int emulator_watch;
+	unsigned int emulator_status_watch;
 	const struct ofono_voicecall_driver *driver;
 	void *driver_data;
 	struct ofono_atom *atom;
@@ -857,7 +862,7 @@ static struct ofono_call *synthesize_outgoing_call(stru=
ct ofono_voicecall *vc,
 =

 	__ofono_modem_callid_hold(modem, call->id);
 =

-	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &number,
+	if (!msg || dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &number,
 				DBUS_TYPE_INVALID) =3D=3D FALSE)
 		number =3D "";
 	else
@@ -990,6 +995,99 @@ static DBusMessage *manager_dial(DBusConnection *conn,
 	return NULL;
 }
 =

+static void emulator_dial_callback(const struct ofono_error *error, void *=
data)
+{
+	struct ofono_voicecall *vc =3D data;
+	GSList *l;
+	struct ofono_call *call;
+	gboolean need_to_emit =3D FALSE;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		DBG("Dial callback returned error: %s",
+			telephony_error_to_str(error));
+		ofono_emulator_send_final(vc->e, G_AT_SERVER_RESULT_ERROR);
+		return;
+	}
+
+	/* Two things can happen, the call notification arrived before dial
+	 * callback or dial callback was first.	Handle here */
+	for (l =3D vc->call_list; l; l =3D l->next) {
+		struct voicecall *v =3D l->data;
+
+		if (v->call->status =3D=3D CALL_STATUS_DIALING ||
+				v->call->status =3D=3D CALL_STATUS_ALERTING ||
+				v->call->status =3D=3D CALL_STATUS_ACTIVE)
+			break;
+	}
+
+	if (!l) {
+		struct voicecall *v;
+
+		call =3D synthesize_outgoing_call(vc, vc->pending);
+		if (!call) {
+			ofono_emulator_send_final(vc->e,
+						G_AT_SERVER_RESULT_ERROR);
+			return;
+		}
+
+		v =3D voicecall_create(vc, call);
+		if (!v) {
+			ofono_emulator_send_final(vc->e,
+						G_AT_SERVER_RESULT_ERROR);
+			return;
+		}
+
+		v->detect_time =3D time(NULL);
+
+		DBG("Registering new call: %d", call->id);
+		voicecall_dbus_register(v);
+
+		vc->call_list =3D g_slist_insert_sorted(vc->call_list, v,
+					call_compare);
+
+		need_to_emit =3D TRUE;
+	}
+
+	if (need_to_emit)
+		emit_call_list_changed(vc);
+}
+
+static GAtServerResult emulator_dial(struct ofono_voicecall *vc,
+						const char *number)
+{
+	struct ofono_phone_number ph;
+	enum ofono_clir_option clir =3D OFONO_CLIR_OPTION_DEFAULT;
+
+	if (vc->pending)
+		return G_AT_SERVER_RESULT_ERROR;
+
+	if (g_slist_length(vc->call_list) >=3D MAX_VOICE_CALLS)
+		return G_AT_SERVER_RESULT_ERROR;
+
+	if (!valid_phone_number_format(number))
+		return G_AT_SERVER_RESULT_ERROR;
+
+	if (!vc->driver->dial)
+		return G_AT_SERVER_RESULT_ERROR;
+
+	if (voicecalls_have_incoming(vc))
+		return G_AT_SERVER_RESULT_ERROR;
+
+	/* We can't have two dialing/alerting calls, reject outright */
+	if (voicecalls_num_connecting(vc) > 0)
+		return G_AT_SERVER_RESULT_ERROR;
+
+	if (voicecalls_have_active(vc) && voicecalls_have_held(vc))
+		return G_AT_SERVER_RESULT_ERROR;
+
+	string_to_phone_number(number, &ph);
+
+	vc->driver->dial(vc, &ph, clir, OFONO_CUG_OPTION_DEFAULT,
+				emulator_dial_callback, vc);
+
+	return G_AT_SERVER_RESULT_OK;
+}
+
 static DBusMessage *manager_transfer(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
@@ -1731,6 +1829,38 @@ check:
 	set_new_ecc(vc);
 }
 =

+static void dial_voicecall(struct ofono_voicecall *vc,
+				struct ofono_emulator_dial_req *req)
+{
+	GAtServerResult res;
+	const char *dial_str =3D req->dial_str;
+	int len =3D strlen(dial_str);
+	char *dial_num;
+	char c;
+
+	DBG("%p %s", vc, dial_str);
+
+	/* Skip last comma */
+	c =3D dial_str[len-1];
+	/* Skip closed user group flag */
+	if (c =3D=3D 'G' || c =3D=3D 'g')
+		len--;
+
+	c =3D dial_str[len-1];
+	/* Skip caller id suppress flag */
+	if (c =3D=3D 'I' || c =3D=3D 'i')
+		len--;
+
+	dial_num =3D g_strndup(dial_str, len);
+
+	/* Voice call */
+	res =3D emulator_dial(vc, dial_num);
+
+	req->cb(res, req->data);
+
+	g_free(dial_num);
+}
+
 int ofono_voicecall_driver_register(const struct ofono_voicecall_driver *d)
 {
 	DBG("driver: %p, name: %s", d, d->name);
@@ -1778,6 +1908,8 @@ static void voicecall_unregister(struct ofono_atom *a=
tom)
 =

 	g_slist_free(vc->call_list);
 =

+	vc->e =3D NULL;
+
 	ofono_modem_remove_interface(modem, OFONO_VOICECALL_MANAGER_INTERFACE);
 	g_dbus_unregister_interface(conn, path,
 					OFONO_VOICECALL_MANAGER_INTERFACE);
@@ -1813,6 +1945,13 @@ static void voicecall_remove(struct ofono_atom *atom)
 		vc->sim =3D NULL;
 	}
 =

+	if (vc->emulator_status_watch) {
+		__ofono_emulator_remove_status_watch(vc->oe,
+						vc->emulator_status_watch);
+		vc->emulator_status_watch =3D 0;
+		vc->oe =3D NULL;
+	}
+
 	g_free(vc);
 }
 =

@@ -1851,6 +1990,61 @@ struct ofono_voicecall *ofono_voicecall_create(struc=
t ofono_modem *modem,
 	return vc;
 }
 =

+static void emulator_status_watch(struct emulator *e,
+					enum ofono_emulator_status status,
+					void *data, void *user_data)
+{
+	struct ofono_voicecall *vc =3D user_data;
+
+	if (e =3D=3D NULL)
+		return;
+
+	switch (status) {
+	case OFONO_EMULATOR_STATUS_CREATE:
+		if (vc->e)
+			return;
+
+		vc->e =3D e;
+		break;
+	case OFONO_EMULATOR_STATUS_DESTROY:
+		if (vc->e !=3D e)
+			return;
+
+		vc->e =3D NULL;
+		break;
+	case OFONO_EMULATOR_STATUS_DIAL_VOICECALL:
+		if (vc->e =3D=3D NULL || data =3D=3D NULL)
+			return;
+
+		if (vc->e !=3D e)
+			return;
+
+		dial_voicecall(vc, data);
+		break;
+	default:
+		break;
+	}
+}
+
+static void emulator_watch(struct ofono_atom *atom,
+					enum ofono_atom_watch_condition cond,
+					void *data)
+{
+	struct ofono_voicecall *vc =3D data;
+	struct ofono_emulator *oe =3D __ofono_atom_get_data(atom);
+
+	if (cond =3D=3D OFONO_ATOM_WATCH_CONDITION_UNREGISTERED) {
+		vc->emulator_status_watch =3D 0;
+		vc->oe =3D NULL;
+		vc->e =3D NULL;
+		return;
+	}
+
+	vc->emulator_status_watch =3D __ofono_emulator_add_status_watch(oe,
+							emulator_status_watch,
+							vc, NULL);
+}
+
 static void sim_state_watch(void *user, enum ofono_sim_state new_state)
 {
 	struct ofono_voicecall *vc =3D user;
@@ -1911,6 +2105,7 @@ void ofono_voicecall_register(struct ofono_voicecall =
*vc)
 	struct ofono_modem *modem =3D __ofono_atom_get_modem(vc->atom);
 	const char *path =3D __ofono_atom_get_path(vc->atom);
 	struct ofono_atom *sim_atom;
+	struct ofono_atom *emulator_atom;
 =

 	if (!g_dbus_register_interface(conn, path,
 					OFONO_VOICECALL_MANAGER_INTERFACE,
@@ -1939,6 +2134,17 @@ void ofono_voicecall_register(struct ofono_voicecall=
 *vc)
 	if (sim_atom && __ofono_atom_get_registered(sim_atom))
 		sim_watch(sim_atom, OFONO_ATOM_WATCH_CONDITION_REGISTERED, vc);
 =

+	vc->emulator_watch =3D __ofono_modem_add_atom_watch(modem,
+						OFONO_ATOM_TYPE_EMULATOR,
+						emulator_watch, vc, NULL);
+
+	emulator_atom =3D __ofono_modem_find_atom(modem,
+						OFONO_ATOM_TYPE_EMULATOR);
+
+	if (emulator_atom && __ofono_atom_get_registered(emulator_atom))
+		emulator_watch(emulator_atom,
+				OFONO_ATOM_WATCH_CONDITION_REGISTERED, vc);
+
 	__ofono_atom_register(vc->atom, voicecall_unregister);
 }
 =

-- =

1.6.3.3


--===============0438722859595462850==--

