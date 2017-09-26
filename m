Content-Type: multipart/mixed; boundary="===============4528241755545581640=="
MIME-Version: 1.0
From: James Prestwood <james.prestwood@linux.intel.com>
Subject: [PATCH 2/7] sim-auth: implementation of core sim-auth atom
Date: Tue, 26 Sep 2017 09:26:04 -0700
Message-ID: <1506443169-19755-2-git-send-email-james.prestwood@linux.intel.com>
In-Reply-To: <1506443169-19755-1-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4528241755545581640==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The sim-auth module atom can now be used for SIM application
discovery and authentication. The atom will automatically
discovery SIM applications available on the SIM and register
a DBus interface for each. These interfaces will contain the
supported USIM/ISIM authentication algorithms.
---
 src/sim-auth.c | 479 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 479 insertions(+)

diff --git a/src/sim-auth.c b/src/sim-auth.c
index 5d2f075..8626a79 100644
--- a/src/sim-auth.c
+++ b/src/sim-auth.c
@@ -28,19 +28,98 @@
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
+static const char sim_auth_cmd[] =3D { 0x00, 0x88, 0x00 };
+
+enum aid_type {
+	AID_TYPE_USIM,
+	AID_TYPE_ISIM,
+	AID_TYPE_UNKNOWN
+};
+
+struct sim_auth_app {
+	/* Raw AID name returned from app discovery */
+	uint8_t aid[16];
+	enum aid_type type;
+	struct sim_auth_app *next;
+};
+
 struct ofono_sim_auth {
 	const struct ofono_sim_auth_driver *driver;
 	void *driver_data;
 	struct ofono_atom *atom;
+	struct sim_auth_app *app_list;
+	struct ofono_sim *sim;
+	uint8_t gsm_access : 1;
+	uint8_t gsm_context : 1;
+};
+
+/*
+ * Temporary handle used for the command authentication sequence.
+ */
+struct auth_handle {
+	struct ofono_sim_auth *sim;
+	DBusMessage *msg;
+	int session_id;
+	void *rand;
+	void *autn;
+	const char *channel;
+	uint8_t umts : 1;
 };
 =

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
@@ -62,6 +141,9 @@ void ofono_sim_auth_driver_unregister(const struct ofono=
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
@@ -113,9 +195,406 @@ struct ofono_sim_auth *ofono_sim_auth_create(struct o=
fono_modem *modem,
 	return sa;
 }
 =

+static void append_dict_byte_array(DBusMessageIter *iter, const char *key,
+		const void *arr, uint32_t len)
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
+static void handle_umts(struct auth_handle *h, const uint8_t *resp,
+		uint16_t len)
+{
+	struct ofono_sim_auth *sim =3D h->sim;
+	DBusMessage *reply =3D NULL;
+	DBusMessageIter iter;
+	DBusMessageIter dict;
+	const uint8_t *res =3D NULL;
+	const uint8_t *ck =3D NULL;
+	const uint8_t *ik =3D NULL;
+	const uint8_t *auts =3D NULL;
+	const uint8_t *kc =3D NULL;
+
+	switch (resp[0]) {
+	case 0xdb:
+		/* 'DB' + '08' + RES(16) + '10' + CK(32) + '10' + IK(32) =3D 43 */
+		if (len < 43)
+			goto umts_end;
+
+		/* success */
+		if (resp[1] !=3D 0x08)
+			goto umts_end;
+
+		res =3D resp + 2;
+
+		if (resp[10] !=3D 0x10)
+			goto umts_end;
+
+		ck =3D resp + 11;
+
+		if (resp[27] !=3D 0x10)
+			goto umts_end;
+
+		ik =3D resp + 28;
+
+		if (sim->gsm_access) {
+			if (resp[42] !=3D 0x08)
+				goto umts_end;
+
+			kc =3D resp + 43;
+		}
+
+		break;
+	case 0xdc:
+		/* 'DB' + '10' + AUTS(16) =3D 18 */
+		if (len < 18)
+			goto umts_end;
+
+		/* sync error */
+		if (resp[1] !=3D 0x10)
+			goto umts_end;
+
+		auts =3D resp + 2;
+
+		break;
+	default:
+		goto umts_end;
+	}
+
+	if (!auts && (!ik || !ck || !res))
+		goto umts_end;
+
+	reply =3D dbus_message_new_method_return(h->msg);
+
+	dbus_message_iter_init_append(reply, &iter);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+			"{say}", &dict);
+
+	if (auts) {
+		append_dict_byte_array(&dict, "auts", auts, 16);
+	} else {
+		append_dict_byte_array(&dict, "res", res, 8);
+		append_dict_byte_array(&dict, "ck", ck, 16);
+		append_dict_byte_array(&dict, "ik", ik, 16);
+		if (kc)
+			append_dict_byte_array(&dict, "kc", kc, 8);
+	}
+
+	dbus_message_iter_close_container(&iter, &dict);
+
+umts_end:
+	if (!reply)
+		reply =3D __ofono_error_not_supported(h->msg);
+
+	__ofono_dbus_pending_reply(&h->msg, reply);
+
+	sim->driver->close_channel(sim, h->session_id);
+
+	g_free(h);
+}
+
+static void handle_gsm(struct auth_handle *h, const uint8_t *resp, uint16_=
t len)
+{
+	struct ofono_sim_auth *sim =3D h->sim;
+	DBusMessage *reply =3D NULL;
+	const uint8_t *sres =3D NULL;
+	const uint8_t *kc =3D NULL;
+
+	if (len < 14 || !resp)
+		goto gsm_end;
+
+	if (resp[0] !=3D 0x04)
+		goto gsm_end;
+
+	sres =3D resp + 1;
+
+	if (resp[5] !=3D 0x08)
+		goto gsm_end;
+
+	kc =3D resp + 6;
+
+	if (!sres || !kc)
+		goto gsm_end;
+
+	reply =3D dbus_message_new_method_return(h->msg);
+
+	dbus_message_append_args(reply, DBUS_TYPE_ARRAY,
+			DBUS_TYPE_BYTE, &sres, 4, DBUS_TYPE_INVALID);
+	dbus_message_append_args(reply, DBUS_TYPE_ARRAY,
+			DBUS_TYPE_BYTE, &kc, 8, DBUS_TYPE_INVALID);
+
+gsm_end:
+	if (!reply)
+		reply =3D __ofono_error_not_supported(h->msg);
+
+	__ofono_dbus_pending_reply(&h->msg, reply);
+
+	sim->driver->close_channel(sim, h->session_id);
+
+	g_free(h);
+}
+
+static void logical_access_cb(const uint8_t *resp, uint16_t len, void *dat=
a)
+{
+	struct auth_handle *h =3D data;
+
+	if (h->umts)
+		handle_umts(h, resp, len);
+	else
+		handle_gsm(h, resp, len);
+}
+
+static void open_channel_cb(int session_id, void *data)
+{
+	struct auth_handle *h =3D data;
+	struct ofono_sim_auth *sim =3D h->sim;
+	uint8_t *cmd;
+	int ret =3D 0;
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
+	cmd =3D alloca(sizeof(sim_auth_cmd) + (h->umts ? 35 : 17));
+
+	memcpy(cmd, sim_auth_cmd, sizeof(sim_auth_cmd));
+	ret +=3D sizeof(sim_auth_cmd);
+
+	/*
+	 * UMTS AUTHENTICATE: 0x81, 0x22, 0x10, <rand>, 0x10, <autn>, 0x00
+	 * GSM AUTHENTICATE: 0x80, 0x11, 0x10, <rand>, 0x00
+	 */
+	cmd[ret++] =3D h->umts ? 0x81 : 0x80;
+	cmd[ret++] =3D h->umts ? 0x22 : 0x11;
+	cmd[ret++] =3D 0x10;
+
+	memcpy(cmd + ret, h->rand, 16);
+	ret +=3D 16;
+
+	if (h->umts) {
+		cmd[ret++] =3D 0x10;
+		memcpy(cmd + ret, h->autn, 16);
+		ret +=3D 16;
+	}
+
+	cmd[ret++] =3D 0x00;
+
+	sim->driver->logical_access(sim, logical_access_cb, session_id, cmd,
+			ret, h);
+}
+
+static DBusMessage *authenticate_common(DBusConnection *conn, DBusMessage =
*msg,
+					void *data, enum aid_type type,
+					gboolean umts)
+{
+	void *channel;
+	uint8_t *rand =3D NULL;
+	uint8_t *autn =3D NULL;
+	uint32_t rlen;
+	uint32_t alen;
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
+static DBusMessage *isim_ims_authenticate(DBusConnection *conn,
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
+static DBusMessage *usim_umts_authenticate(DBusConnection *conn,
+		DBusMessage *msg, void *data)
+{
+	return authenticate_common(conn, msg, data, AID_TYPE_USIM, 1);
+}
+
+static const GDBusMethodTable sim_auth_usim_app[] =3D {
+	{ GDBUS_ASYNC_METHOD("GsmAuthenticate",
+			GDBUS_ARGS({"rand", "ay"}),
+			GDBUS_ARGS({"sres", "ay"}, {"kc", "ay"}),
+			usim_gsm_authenticate) },
+	{ GDBUS_ASYNC_METHOD("UmtsAuthenticate",
+			GDBUS_ARGS({"rand", "ay"}, {"autn", "ay"}),
+			GDBUS_ARGS({"return", "a{sv}"}),
+			usim_umts_authenticate) },
+	{ }
+};
+
+static const GDBusMethodTable sim_auth_isim_app[] =3D {
+	{ GDBUS_ASYNC_METHOD("ImsAuthenticate",
+			GDBUS_ARGS({"rand", "ay"}, {"autn", "ay"}),
+			GDBUS_ARGS({"return", "a{sv}"}),
+			isim_ims_authenticate) },
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
+		uint8_t len;
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
+					*((uint16_t *)(aid_start + 5)));
+			/*
+			 * If we get here, the SIM application was not ISIM
+			 * or USIM, skip.
+			 */
+			g_free(app);
+			continue;
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
+
+	sa->sim =3D __ofono_atom_find(OFONO_ATOM_TYPE_SIM, modem);
+
+	sa->gsm_access =3D __ofono_sim_service_available(sa->sim,
+			SIM_UST_SERVICE_GSM_ACCESS, 0);
+	sa->gsm_context =3D __ofono_sim_service_available(sa->sim,
+			SIM_UST_SERVICE_GSM_SECURITY_CONTEXT, 0);
 }
 =

 void ofono_sim_auth_remove(struct ofono_sim_auth *sa)
-- =

2.7.4


--===============4528241755545581640==--

