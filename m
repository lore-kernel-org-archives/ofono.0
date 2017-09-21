Content-Type: multipart/mixed; boundary="===============6729751977332498383=="
MIME-Version: 1.0
From: James Prestwood <james.prestwood@linux.intel.com>
Subject: [PATCH 2/7] sim-auth: implementation of core sim-auth atom
Date: Thu, 21 Sep 2017 11:11:55 -0700
Message-ID: <1506017520-22482-2-git-send-email-james.prestwood@linux.intel.com>
In-Reply-To: <1506017520-22482-1-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6729751977332498383==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The sim-auth module atom can now be used for SIM application
discovery and authentication. The atom will automatically
discovery SIM applications available on the SIM and register
a DBus interface for each. These interfaces will contain the
supported USIM/ISIM authentication algorithms.
---
 src/sim-auth.c | 379 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 379 insertions(+)

diff --git a/src/sim-auth.c b/src/sim-auth.c
index 5d2f075..5c71644 100644
--- a/src/sim-auth.c
+++ b/src/sim-auth.c
@@ -28,19 +28,94 @@
 #include <glib.h>
 #include <errno.h>
 #include <unistd.h>
+#include <gdbus.h>
+#include <string.h>
 =

 #include "ofono.h"
 =

 #include "simutil.h"
+#include "util.h"
 =

 static GSList *g_drivers =3D NULL;
 =

+static const char aid_isim[] =3D { 0x10, 0x04 };
+static const char aid_usim[] =3D { 0x10, 0x02 };
+
+enum aid_type {
+	AID_TYPE_USIM,
+	AID_TYPE_ISIM,
+	AID_TYPE_UNKNOWN
+};
+
+struct sim_auth_app {
+	/* Raw AID name returned from app discovery */
+	guint8 aid[16];
+	enum aid_type type;
+	struct sim_auth_app *next;
+};
+
 struct ofono_sim_auth {
 	const struct ofono_sim_auth_driver *driver;
 	void *driver_data;
 	struct ofono_atom *atom;
+	struct sim_auth_app *app_list;
 };
 =

+/*
+ * Temporary handle used for the command authentication sequence.
+ */
+struct auth_handle {
+	struct ofono_sim_auth *sim;
+	DBusMessage *msg;
+	int session_id;
+	void *rand;
+	void *autn;
+	gboolean umts;
+	const char *channel;
+};
+
+/*
+ * Find an AID channel by the human readable name (USIM, ISIM etc)
+ */
+static gboolean find_channel(struct sim_auth_app *list, enum aid_type type,
+		void **channel)
+{
+	struct sim_auth_app *cur =3D list;
+
+	while (cur) {
+		if (cur->type =3D=3D type) {
+			*channel =3D cur->aid;
+			return 1;
+		}
+		cur =3D cur->next;
+	}
+	return 0;
+}
+
+/*
+ * Free all discovered AID's
+ */
+static void free_apps(struct ofono_sim_auth *sa)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D __ofono_atom_get_path(sa->atom);
+	struct sim_auth_app *cur =3D sa->app_list;
+	void *tmp;
+
+	while (cur) {
+		if (cur->type =3D=3D AID_TYPE_USIM)
+			g_dbus_unregister_interface(conn, path,
+					OFONO_USIM_APPLICATION_INTERFACE);
+		else if (cur->type =3D=3D AID_TYPE_ISIM)
+			g_dbus_unregister_interface(conn, path,
+					OFONO_ISIM_APPLICATION_INTERFACE);
+
+		tmp =3D cur->next;
+		g_free(cur);
+		cur =3D tmp;
+	}
+}
+
 int ofono_sim_auth_driver_register(const struct ofono_sim_auth_driver *d)
 {
 	DBG("driver: %p, name: %s", d, d->name);
@@ -62,6 +137,9 @@ void ofono_sim_auth_driver_unregister(const struct ofono=
_sim_auth_driver *d)
 =

 static void sim_auth_unregister(struct ofono_atom *atom)
 {
+	struct ofono_sim_auth *sa =3D __ofono_atom_get_data(atom);
+
+	free_apps(sa);
 }
 =

 static void sim_auth_remove(struct ofono_atom *atom)
@@ -113,9 +191,310 @@ struct ofono_sim_auth *ofono_sim_auth_create(struct o=
fono_modem *modem,
 	return sa;
 }
 =

+static void sim_auth_callback(void *data, const guint8 *sres,
+		const guint8 *kc)
+{
+	struct auth_handle *h =3D data;
+	struct ofono_sim_auth *sim =3D h->sim;
+	DBusMessage *reply;
+
+	if (!kc || !sres) {
+		reply =3D __ofono_error_not_supported(h->msg);
+		goto gsm_end;
+	}
+
+	reply =3D dbus_message_new_method_return(h->msg);
+
+	dbus_message_append_args(reply, DBUS_TYPE_ARRAY,
+			DBUS_TYPE_BYTE, &sres, 4, DBUS_TYPE_INVALID);
+	dbus_message_append_args(reply, DBUS_TYPE_ARRAY,
+			DBUS_TYPE_BYTE, &kc, 8, DBUS_TYPE_INVALID);
+
+gsm_end:
+	__ofono_dbus_pending_reply(&h->msg, reply);
+
+	sim->driver->close_channel(sim, h->session_id);
+
+	g_free(h);
+}
+
+static void append_dict_byte_array(DBusMessageIter *iter, const char* key,
+		const void *arr, guint32 len)
+{
+	DBusMessageIter keyiter;
+	DBusMessageIter valueiter;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_DICT_ENTRY, NULL,
+			&keyiter);
+	dbus_message_iter_append_basic(&keyiter, DBUS_TYPE_STRING, &key);
+	dbus_message_iter_open_container(&keyiter, DBUS_TYPE_ARRAY,
+			"y", &valueiter);
+	dbus_message_iter_append_fixed_array(&valueiter, DBUS_TYPE_BYTE, &arr,
+			len);
+	dbus_message_iter_close_container(&keyiter, &valueiter);
+	dbus_message_iter_close_container(iter, &keyiter);
+}
+
+static void umts_auth_callback(void *data, const guint8 *res, guint8 res_l=
en,
+		const guint8 *ck, const guint8 *ik)
+{
+	struct auth_handle *h =3D data;
+	struct ofono_sim_auth *sim =3D h->sim;
+	DBusMessage *reply;
+	DBusMessageIter iter;
+	DBusMessageIter dict;
+
+	if (!ck || !ik) {
+		reply =3D __ofono_error_not_supported(h->msg);
+		goto umts_end;
+	}
+
+	reply =3D dbus_message_new_method_return(h->msg);
+
+	dbus_message_iter_init_append(reply, &iter);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+			"{say}", &dict);
+
+	/*
+	 * res =3D=3D NULL and res_len =3D=3D 0xFF means sync failure, in this ca=
se
+	 * both ck/ik will point to the AUTS value.
+	 */
+	if (!res && res_len =3D=3D 0xff) {
+		append_dict_byte_array(&dict, "auts", ck, 16);
+	} else {
+		append_dict_byte_array(&dict, "res", res, res_len);
+		append_dict_byte_array(&dict, "ck", ck, 16);
+		append_dict_byte_array(&dict, "ik", ik, 16);
+	}
+
+	dbus_message_iter_close_container(&iter, &dict);
+
+umts_end:
+	__ofono_dbus_pending_reply(&h->msg, reply);
+
+	sim->driver->close_channel(sim, h->session_id);
+
+	g_free(h);
+
+	return;
+}
+
+static void open_channel_cb(int session_id, void *data)
+{
+	struct auth_handle *h =3D data;
+	struct ofono_sim_auth *sim =3D h->sim;
+
+	if (session_id =3D=3D -1) {
+		__ofono_dbus_pending_reply(&h->msg,
+				__ofono_error_failed(h->msg));
+		g_free(h);
+		return;
+	}
+
+	/* save session ID for close_channel() */
+	h->session_id =3D session_id;
+
+	if (h->umts) {
+		sim->driver->umts_authenticate(sim, umts_auth_callback,
+				session_id, h->rand, h->autn, h);
+	} else {
+		sim->driver->gsm_authenticate(sim, sim_auth_callback,
+				session_id, h->rand, h);
+	}
+}
+
+static DBusMessage *authenticate_common(DBusConnection *conn, DBusMessage =
*msg,
+					void *data, enum aid_type type,
+					gboolean umts)
+{
+	void *channel;
+	guint8 *rand =3D NULL;
+	guint8 *autn =3D NULL;
+	guint32 rlen;
+	guint32 alen;
+	struct ofono_sim_auth *sim =3D data;
+	struct auth_handle *h;
+
+	/* get RAND/(AUTN) and setup handle args */
+	if (umts)
+		dbus_message_get_args(msg, NULL, DBUS_TYPE_ARRAY,
+				DBUS_TYPE_BYTE, &rand, &rlen, DBUS_TYPE_ARRAY,
+				DBUS_TYPE_BYTE, &autn, &alen,
+				DBUS_TYPE_INVALID);
+	else
+		dbus_message_get_args(msg, NULL, DBUS_TYPE_ARRAY,
+				DBUS_TYPE_BYTE, &rand, &rlen,
+				DBUS_TYPE_INVALID);
+
+	h =3D malloc(sizeof(struct auth_handle));
+	h->sim =3D sim;
+	h->msg =3D dbus_message_ref(msg);
+	h->rand =3D rand;
+	h->autn =3D autn;
+	h->umts =3D umts;
+
+	if (find_channel(sim->app_list, type, &channel)) {
+		sim->driver->open_channel(sim, open_channel_cb, channel, h);
+	} else {
+		dbus_message_unref(h->msg);
+		g_free(h);
+		return __ofono_error_not_supported(msg);
+	}
+
+	return NULL;
+}
+
+static DBusMessage *isim_gsm_authenticate(DBusConnection *conn,
+		DBusMessage *msg, void *data)
+{
+	return authenticate_common(conn, msg, data, AID_TYPE_ISIM, 0);
+}
+
+static DBusMessage *isim_umts_authenticate(DBusConnection *conn,
+		DBusMessage *msg, void *data)
+{
+	return authenticate_common(conn, msg, data, AID_TYPE_ISIM, 1);
+}
+
+static DBusMessage *usim_gsm_authenticate(DBusConnection *conn,
+		DBusMessage *msg, void *data)
+{
+	return authenticate_common(conn, msg, data, AID_TYPE_USIM, 0);
+}
+
+static const GDBusMethodTable sim_auth_usim_app[] =3D {
+	{ GDBUS_ASYNC_METHOD("GSMAuthenticate",
+			GDBUS_ARGS({"rand", "ay"}),
+			GDBUS_ARGS({"sres", "ay"}, {"kc", "ay"}),
+			usim_gsm_authenticate) },
+	{ }
+};
+
+static const GDBusMethodTable sim_auth_isim_app[] =3D {
+	{ GDBUS_ASYNC_METHOD("GSMAuthenticate",
+			GDBUS_ARGS({"rand", "ay"}),
+			GDBUS_ARGS({"sres", "ay"}, {"kc", "ay"}),
+			isim_gsm_authenticate) },
+	{ GDBUS_ASYNC_METHOD("UMTSAuthenticate",
+			GDBUS_ARGS({"rand", "ay"}, {"autn", "ay"}),
+			GDBUS_ARGS({"return", "a{sv}"}),
+			isim_umts_authenticate) },
+	{ }
+};
+
+static void discover_apps_cb(const struct ofono_error *error,
+		const unsigned char *dataobj,
+		int len, void *data)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	struct ofono_sim_auth *sim =3D data;
+	const char *path =3D __ofono_atom_get_path(sim->atom);
+	int i =3D 0;
+	const unsigned char *aid_start =3D NULL;
+
+	sim->app_list =3D NULL;
+
+	while (i < len) {
+		guint8 len;
+		struct sim_auth_app *app =3D NULL;
+
+		/*
+		 * TODO: There seems to be strings of 'FF' after each AID which
+		 * do not match up to the encoded lengths. Skipping these
+		 * sections until we reach the start of the next AID (not 0xff)
+		 */
+		while (dataobj[i] =3D=3D 0xff)
+			i++;
+
+		/*
+		 * This just means we are@the end of the AID list, not
+		 * a parse error. Any error cases past this point are parse
+		 * errors.
+		 */
+		if (dataobj[i++] !=3D 0x61)
+			break;
+
+		i++;
+
+		if (dataobj[i++] !=3D 0x4f)
+			goto parse_error;
+
+		app =3D g_malloc(sizeof(struct sim_auth_app));
+		if (!app) {
+			ofono_error("failed to alloc SIM application");
+			goto parse_error;
+		}
+
+		len =3D dataobj[i++];
+
+		aid_start =3D dataobj + i;
+
+		i +=3D len;
+
+		memcpy(app->aid, aid_start, 16);
+
+		if (dataobj[i++] !=3D 0x50) {
+			g_free(app->aid);
+			g_free(app);
+			goto parse_error;
+		}
+
+		len =3D dataobj[i++];
+
+		i +=3D len;
+
+		if (!memcmp(aid_start + 5, aid_usim, 2)) {
+			app->type =3D AID_TYPE_USIM;
+			g_dbus_register_interface(conn, path,
+					OFONO_USIM_APPLICATION_INTERFACE,
+					sim_auth_usim_app, NULL, NULL,
+					sim, NULL);
+		} else if (!memcmp(aid_start + 5, aid_isim, 2)) {
+			app->type =3D AID_TYPE_ISIM;
+			g_dbus_register_interface(conn, path,
+					OFONO_ISIM_APPLICATION_INTERFACE,
+					sim_auth_isim_app, NULL, NULL,
+					sim, NULL);
+		} else {
+			DBG("Unknown SIM application '%04x'",
+					*((guint16*)(aid_start + 5)));
+			/*
+			 * If we get here, the SIM application found should
+			 * probably be added to the supported types.
+			 *
+			 * If this was indeed a parsing error then free the
+			 * AID list.
+			 */
+			g_free(app);
+			goto parse_error;
+		}
+
+		app->next =3D sim->app_list;
+		sim->app_list =3D app;
+	}
+
+	return;
+
+parse_error:
+	/*
+	 * Something went wrong parsing the AID list, it can't be assumed that
+	 * any previously parsed AID's are valid so free them all.
+	 */
+	DBG("Error parsing app list");
+	free_apps(sim);
+}
+
 void ofono_sim_auth_register(struct ofono_sim_auth *sa)
 {
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(sa->atom);
+
+	ofono_modem_add_interface(modem, OFONO_PHONEBOOK_INTERFACE);
+
 	__ofono_atom_register(sa->atom, sim_auth_unregister);
+
+	/* Do SIM application discovery, the cb will register DBus ifaces */
+	sa->driver->list_apps(sa, discover_apps_cb, sa);
 }
 =

 void ofono_sim_auth_remove(struct ofono_sim_auth *sa)
-- =

2.7.4


--===============6729751977332498383==--

