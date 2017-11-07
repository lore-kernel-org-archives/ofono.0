Content-Type: multipart/mixed; boundary="===============9199509311426807409=="
MIME-Version: 1.0
From: James Prestwood <james.prestwood@linux.intel.com>
Subject: [PATCH] simauth: use new sim atom functionality for simauth
Date: Tue, 07 Nov 2017 11:39:21 -0800
Message-ID: <1510083561-27128-1-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9199509311426807409==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

All the functionality for the simauth driver was moved
into the sim atom. This patch transitions the simauth
atom to using those API's instead of the simauth driver
API's.

With this change it made more sense to store each AID
as its own object structure so the AID and object path
could be re-used rather than generating it on the fly.

Renamed the simauth 'sim' variable to 'sa' to keep it
consistent now that the simauth structure references
the sim atom as 'sim'.
---
 src/sim-auth.c | 398 +++++++++++++++++++++++++++++++++--------------------=
----
 1 file changed, 229 insertions(+), 169 deletions(-)

diff --git a/src/sim-auth.c b/src/sim-auth.c
index c0b2422..dc9f08e 100644
--- a/src/sim-auth.c
+++ b/src/sim-auth.c
@@ -59,35 +59,41 @@ struct auth_request {
 	int cb_count;
 	void *autn;
 	uint8_t umts : 1;
+	unsigned int watch_id;
+	struct ofono_sim_aid_session *session;
+};
+
+struct aid_object {
+	uint8_t aid[16];
+	char *path;
+	enum sim_app_type type;
 };
 =

 struct ofono_sim_auth {
+	struct ofono_sim *sim;
 	const struct ofono_sim_auth_driver *driver;
 	void *driver_data;
 	struct ofono_atom *atom;
-	GSList *aid_list;
+	GSList *aid_objects;
 	uint8_t gsm_access : 1;
 	uint8_t gsm_context : 1;
 	struct auth_request *pending;
+	char *nai;
 };
 =

 /*
  * Find an application by path. 'path' should be a DBusMessage object path.
  */
-static struct sim_app_record *find_aid_by_path(GSList *aid_list,
+static uint8_t *find_aid_by_path(GSList *aid_objects,
 		const char *path)
 {
-	GSList *iter =3D aid_list;
-	const char *aid =3D strrchr(path, '/') + 1;
+	GSList *iter =3D aid_objects;
 =

 	while (iter) {
-		struct sim_app_record *app =3D iter->data;
-		char str[33];
-
-		encode_hex_own_buf(app->aid, 16, 0, str);
+		struct aid_object *obj =3D iter->data;
 =

-		if (!strcmp(aid, str))
-			return app;
+		if (!strcmp(path, obj->path))
+			return obj->aid;
 =

 		iter =3D g_slist_next(iter);
 	}
@@ -103,24 +109,22 @@ static void free_apps(struct ofono_sim_auth *sa)
 	DBusConnection *conn =3D ofono_dbus_get_connection();
 	struct ofono_modem *modem =3D __ofono_atom_get_modem(sa->atom);
 	const char *path =3D __ofono_atom_get_path(sa->atom);
-	GSList *iter =3D sa->aid_list;
+	GSList *iter =3D sa->aid_objects;
 =

 	while (iter) {
-		struct sim_app_record *app =3D iter->data;
-		char object[strlen(path) + 33];
-		int ret;
+		struct aid_object *obj =3D iter->data;
 =

-		ret =3D sprintf(object, "%s/", path);
-		encode_hex_own_buf(app->aid, 16, 0, object + ret);
-
-		if (app->type =3D=3D SIM_APP_TYPE_USIM) {
-			g_dbus_unregister_interface(conn, object,
+		if (obj->type =3D=3D SIM_APP_TYPE_USIM) {
+			g_dbus_unregister_interface(conn, obj->path,
 					OFONO_USIM_APPLICATION_INTERFACE);
-		} else if (app->type =3D=3D SIM_APP_TYPE_ISIM) {
-			g_dbus_unregister_interface(conn, object,
+		} else if (obj->type =3D=3D SIM_APP_TYPE_ISIM) {
+			g_dbus_unregister_interface(conn, obj->path,
 					OFONO_ISIM_APPLICATION_INTERFACE);
 		}
 =

+		g_free(obj->path);
+		g_free(obj);
+
 		iter =3D g_slist_next(iter);
 	}
 =

@@ -130,7 +134,7 @@ static void free_apps(struct ofono_sim_auth *sa)
 			OFONO_SIM_AUTHENTICATION_INTERFACE);
 =

 =

-	g_slist_free(sa->aid_list);
+	g_slist_free(sa->aid_objects);
 }
 =

 int ofono_sim_auth_driver_register(const struct ofono_sim_auth_driver *d)
@@ -248,7 +252,7 @@ static void append_dict_byte_array(DBusMessageIter *ite=
r, const char *key,
 	dbus_message_iter_close_container(iter, &keyiter);
 }
 =

-static void handle_umts(struct ofono_sim_auth *sim, const uint8_t *resp,
+static void handle_umts(struct ofono_sim_auth *sa, const uint8_t *resp,
 		uint16_t len)
 {
 	DBusMessage *reply =3D NULL;
@@ -264,7 +268,7 @@ static void handle_umts(struct ofono_sim_auth *sim, con=
st uint8_t *resp,
 			&auts, &kc))
 		goto umts_end;
 =

-	reply =3D dbus_message_new_method_return(sim->pending->msg);
+	reply =3D dbus_message_new_method_return(sa->pending->msg);
 =

 	dbus_message_iter_init_append(reply, &iter);
 =

@@ -285,17 +289,18 @@ static void handle_umts(struct ofono_sim_auth *sim, c=
onst uint8_t *resp,
 =

 umts_end:
 	if (!reply)
-		reply =3D __ofono_error_not_supported(sim->pending->msg);
+		reply =3D __ofono_error_not_supported(sa->pending->msg);
 =

-	__ofono_dbus_pending_reply(&sim->pending->msg, reply);
+	__ofono_dbus_pending_reply(&sa->pending->msg, reply);
 =

-	sim->driver->close_channel(sim, sim->pending->session_id, NULL, NULL);
+	__ofono_sim_remove_session_watch(sa->pending->session,
+			sa->pending->watch_id);
 =

-	g_free(sim->pending);
-	sim->pending =3D NULL;
+	g_free(sa->pending);
+	sa->pending =3D NULL;
 }
 =

-static void handle_gsm(struct ofono_sim_auth *sim, const uint8_t *resp,
+static void handle_gsm(struct ofono_sim_auth *sa, const uint8_t *resp,
 		uint16_t len)
 {
 	DBusMessageIter iter;
@@ -306,130 +311,128 @@ static void handle_gsm(struct ofono_sim_auth *sim, =
const uint8_t *resp,
 		goto gsm_end;
 =

 	/* initial iteration, setup the reply message */
-	if (sim->pending->cb_count =3D=3D 0) {
-		sim->pending->reply =3D dbus_message_new_method_return(
-				sim->pending->msg);
+	if (sa->pending->cb_count =3D=3D 0) {
+		sa->pending->reply =3D dbus_message_new_method_return(
+				sa->pending->msg);
 =

-		dbus_message_iter_init_append(sim->pending->reply,
-				&sim->pending->iter);
+		dbus_message_iter_init_append(sa->pending->reply,
+				&sa->pending->iter);
 =

-		dbus_message_iter_open_container(&sim->pending->iter,
-				DBUS_TYPE_ARRAY, "a{say}", &sim->pending->dict);
+		dbus_message_iter_open_container(&sa->pending->iter,
+				DBUS_TYPE_ARRAY, "a{say}", &sa->pending->dict);
 	}
 =

 	/* append the Nth sres/kc byte arrays */
-	dbus_message_iter_open_container(&sim->pending->dict, DBUS_TYPE_ARRAY,
+	dbus_message_iter_open_container(&sa->pending->dict, DBUS_TYPE_ARRAY,
 			"{say}", &iter);
 	append_dict_byte_array(&iter, "SRES", sres, 4);
 	append_dict_byte_array(&iter, "Kc", kc, 8);
-	dbus_message_iter_close_container(&sim->pending->dict, &iter);
+	dbus_message_iter_close_container(&sa->pending->dict, &iter);
 =

-	sim->pending->cb_count++;
+	sa->pending->cb_count++;
 =

 	/* calculated the number of keys requested, close container */
-	if (sim->pending->cb_count =3D=3D sim->pending->num_rands) {
-		dbus_message_iter_close_container(&sim->pending->iter,
-				&sim->pending->dict);
+	if (sa->pending->cb_count =3D=3D sa->pending->num_rands) {
+		dbus_message_iter_close_container(&sa->pending->iter,
+				&sa->pending->dict);
 		goto gsm_end;
 	}
 =

 	return;
 =

 gsm_end:
-	if (!sim->pending->reply)
-		sim->pending->reply =3D __ofono_error_not_supported(
-				sim->pending->msg);
+	if (!sa->pending->reply)
+		sa->pending->reply =3D __ofono_error_not_supported(
+				sa->pending->msg);
 =

-	__ofono_dbus_pending_reply(&sim->pending->msg, sim->pending->reply);
+	__ofono_dbus_pending_reply(&sa->pending->msg, sa->pending->reply);
 =

-	sim->driver->close_channel(sim, sim->pending->session_id, NULL, NULL);
+	__ofono_sim_remove_session_watch(sa->pending->session,
+			sa->pending->watch_id);
 =

-	g_free(sim->pending);
+	g_free(sa->pending);
 =

-	sim->pending =3D NULL;
+	sa->pending =3D NULL;
 }
 =

 static void logical_access_cb(const struct ofono_error *error,
-		const uint8_t *resp, uint16_t len, void *data)
+		const unsigned char *resp, unsigned int len, void *data)
 {
-	struct ofono_sim_auth *sim =3D data;
+	struct ofono_sim_auth *sa =3D data;
 =

 	/* error must have occurred in a previous CB */
-	if (!sim->pending)
+	if (!sa->pending)
 		return;
 =

 	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
-		__ofono_dbus_pending_reply(&sim->pending->msg,
-				__ofono_error_failed(sim->pending->msg));
-		g_free(sim->pending);
-		sim->pending =3D NULL;
+		__ofono_dbus_pending_reply(&sa->pending->msg,
+				__ofono_error_failed(sa->pending->msg));
+		g_free(sa->pending);
+		sa->pending =3D NULL;
 		return;
 	}
 =

-	if (sim->pending->umts)
-		handle_umts(sim, resp, len);
+	if (sa->pending->umts)
+		handle_umts(sa, resp, len);
 	else
-		handle_gsm(sim, resp, len);
+		handle_gsm(sa, resp, len);
 }
 =

-static void open_channel_cb(const struct ofono_error *error, int session_i=
d,
+static void get_session_cb(ofono_bool_t active, int session_id,
 		void *data)
 {
-	struct ofono_sim_auth *sim =3D data;
+	struct ofono_sim_auth *sa =3D data;
 	int i;
 =

-	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR)
-		goto error;
-
-	if (session_id =3D=3D -1)
+	if (!active)
 		goto error;
 =

 	/* save session ID for close_channel() */
-	sim->pending->session_id =3D session_id;
+	sa->pending->session_id =3D session_id;
 =

 	/*
 	 * This will do the logical access num_rand times, providing a new
 	 * RAND seed each time. In the UMTS case, num_rands should be 1.
 	 */
-	for (i =3D 0; i < sim->pending->num_rands; i++) {
+	for (i =3D 0; i < sa->pending->num_rands; i++) {
 		uint8_t auth_cmd[40];
 		int len =3D 0;
 =

-		if (sim->pending->umts)
+		if (sa->pending->umts)
 			len =3D sim_build_umts_authenticate(auth_cmd, 40,
-					sim->pending->rands[i],
-					sim->pending->autn);
+					sa->pending->rands[i],
+					sa->pending->autn);
 		else
 			len =3D sim_build_gsm_authenticate(auth_cmd, 40,
-					sim->pending->rands[i]);
+					sa->pending->rands[i]);
 =

 		if (!len)
 			goto error;
 =

-		sim->driver->logical_access(sim, session_id, auth_cmd, len,
-				logical_access_cb, sim);
+		ofono_sim_logical_access(sa->sim, session_id, auth_cmd, len,
+				logical_access_cb, sa);
 	}
 =

 	return;
 =

 error:
-	__ofono_dbus_pending_reply(&sim->pending->msg,
-			__ofono_error_failed(sim->pending->msg));
-	g_free(sim->pending);
-	sim->pending =3D NULL;
+	__ofono_dbus_pending_reply(&sa->pending->msg,
+			__ofono_error_failed(sa->pending->msg));
+	g_free(sa->pending);
+	sa->pending =3D NULL;
 }
 =

 static DBusMessage *usim_gsm_authenticate(DBusConnection *conn,
 		DBusMessage *msg, void *data)
 {
-	struct ofono_sim_auth *sim =3D data;
+	struct ofono_sim_auth *sa =3D data;
 	DBusMessageIter iter;
 	DBusMessageIter array;
 	int i;
-	struct sim_app_record *app;
+	uint8_t *aid;
 	int rands;
 =

-	if (sim->pending)
+	if (sa->pending)
 		return __ofono_error_busy(msg);
 =

 	dbus_message_iter_init(msg, &iter);
@@ -442,15 +445,15 @@ static DBusMessage *usim_gsm_authenticate(DBusConnect=
ion *conn,
 	if (rands > 3 || rands < 2)
 		return __ofono_error_invalid_format(msg);
 =

-	sim->pending =3D malloc(sizeof(struct auth_request));
-	sim->pending->msg =3D dbus_message_ref(msg);
-	sim->pending->umts =3D 0;
-	sim->pending->cb_count =3D 0;
-	sim->pending->num_rands =3D rands;
+	sa->pending =3D malloc(sizeof(struct auth_request));
+	sa->pending->msg =3D dbus_message_ref(msg);
+	sa->pending->umts =3D 0;
+	sa->pending->cb_count =3D 0;
+	sa->pending->num_rands =3D rands;
 =

 	dbus_message_iter_recurse(&iter, &array);
 =

-	for (i =3D 0; i < sim->pending->num_rands; i++) {
+	for (i =3D 0; i < sa->pending->num_rands; i++) {
 		int nelement;
 		DBusMessageIter in;
 =

@@ -459,7 +462,7 @@ static DBusMessage *usim_gsm_authenticate(DBusConnectio=
n *conn,
 		if (dbus_message_iter_get_arg_type(&in) !=3D DBUS_TYPE_BYTE)
 			goto format_error;
 =

-		dbus_message_iter_get_fixed_array(&in, &sim->pending->rands[i],
+		dbus_message_iter_get_fixed_array(&in, &sa->pending->rands[i],
 				&nelement);
 =

 		if (nelement !=3D 16)
@@ -468,15 +471,20 @@ static DBusMessage *usim_gsm_authenticate(DBusConnect=
ion *conn,
 		dbus_message_iter_next(&array);
 	}
 =

-	app =3D find_aid_by_path(sim->aid_list, dbus_message_get_path(msg));
+	/*
+	 * retrieve session from SIM
+	 */
+	aid =3D find_aid_by_path(sa->aid_objects, dbus_message_get_path(msg));
+	sa->pending->session =3D __ofono_sim_get_session_by_aid(sa->sim, aid);
 =

-	sim->driver->open_channel(sim, app->aid, open_channel_cb, sim);
+	sa->pending->watch_id =3D __ofono_sim_add_session_watch(
+			sa->pending->session, get_session_cb, sa, NULL);
 =

 	return NULL;
 =

 format_error:
-	g_free(sim->pending);
-	sim->pending =3D NULL;
+	g_free(sa->pending);
+	sa->pending =3D NULL;
 	return __ofono_error_invalid_format(msg);
 }
 =

@@ -487,10 +495,10 @@ static DBusMessage *umts_common(DBusConnection *conn,=
 DBusMessage *msg,
 	uint8_t *autn =3D NULL;
 	uint32_t rlen;
 	uint32_t alen;
-	struct ofono_sim_auth *sim =3D data;
-	struct sim_app_record *app;
+	struct ofono_sim_auth *sa =3D data;
+	uint8_t *aid;
 =

-	if (sim->pending)
+	if (sa->pending)
 		return __ofono_error_busy(msg);
 =

 	/* get RAND/AUTN and setup handle args */
@@ -503,16 +511,21 @@ static DBusMessage *umts_common(DBusConnection *conn,=
 DBusMessage *msg,
 	if (rlen !=3D 16 || alen !=3D 16)
 		return __ofono_error_invalid_format(msg);
 =

-	sim->pending =3D g_new0(struct auth_request, 1);
-	sim->pending->msg =3D dbus_message_ref(msg);
-	sim->pending->rands[0] =3D rand;
-	sim->pending->num_rands =3D 1;
-	sim->pending->autn =3D autn;
-	sim->pending->umts =3D 1;
+	sa->pending =3D g_new0(struct auth_request, 1);
+	sa->pending->msg =3D dbus_message_ref(msg);
+	sa->pending->rands[0] =3D rand;
+	sa->pending->num_rands =3D 1;
+	sa->pending->autn =3D autn;
+	sa->pending->umts =3D 1;
 =

-	app =3D find_aid_by_path(sim->aid_list, dbus_message_get_path(msg));
+	/*
+	 * retrieve session from SIM
+	 */
+	aid =3D find_aid_by_path(sa->aid_objects, dbus_message_get_path(msg));
+	sa->pending->session =3D __ofono_sim_get_session_by_aid(sa->sim, aid);
 =

-	sim->driver->open_channel(sim, app->aid, open_channel_cb, sim);
+	sa->pending->watch_id =3D __ofono_sim_add_session_watch(
+			sa->pending->session, get_session_cb, sa, NULL);
 =

 	return NULL;
 }
@@ -520,10 +533,7 @@ static DBusMessage *umts_common(DBusConnection *conn, =
DBusMessage *msg,
 static DBusMessage *get_applications(DBusConnection *conn,
 		DBusMessage *msg, void *data)
 {
-	struct ofono_sim_auth *sim =3D data;
-	const char *path =3D __ofono_atom_get_path(sim->atom);
-	int ret;
-	char object[strlen(path) + 33];
+	struct ofono_sim_auth *sa =3D data;
 	DBusMessage *reply;
 	DBusMessageIter iter;
 	DBusMessageIter array;
@@ -540,29 +550,28 @@ static DBusMessage *get_applications(DBusConnection *=
conn,
 				&array);
 =

 	/* send empty array */
-	if (!sim->aid_list)
+	if (!sa->aid_objects)
 		goto apps_end;
 =

-	aid_iter =3D sim->aid_list;
+	aid_iter =3D sa->aid_objects;
 =

 	while (aid_iter) {
-		struct sim_app_record *app =3D aid_iter->data;
-
-		ret =3D sprintf(object, "%s/", path);
-		encode_hex_own_buf(app->aid, 16, 0, object + ret);
+		struct aid_object *obj =3D aid_iter->data;
 =

-		switch (app->type) {
+		switch (obj->type) {
 		case SIM_APP_TYPE_ISIM:
 			dbus_message_iter_open_container(&array,
 					DBUS_TYPE_DICT_ENTRY, NULL, &dict);
-			append_dict_application(&dict, object, "Ims", "ISim");
+			append_dict_application(&dict, obj->path, "Ims",
+					"ISim");
 			dbus_message_iter_close_container(&array, &dict);
 =

 			break;
 		case SIM_APP_TYPE_USIM:
 			dbus_message_iter_open_container(&array,
 					DBUS_TYPE_DICT_ENTRY, NULL, &dict);
-			append_dict_application(&dict, object, "Umts", "USim");
+			append_dict_application(&dict, obj->path, "Umts",
+					"USim");
 			dbus_message_iter_close_container(&array, &dict);
 =

 			break;
@@ -579,6 +588,33 @@ apps_end:
 	return reply;
 }
 =

+static DBusMessage *get_sim_auth_properties(DBusConnection *conn,
+		DBusMessage *msg, void *data)
+{
+	struct ofono_sim_auth *sa =3D data;
+	DBusMessage *reply;
+	DBusMessageIter iter;
+	DBusMessageIter dict;
+
+	reply =3D dbus_message_new_method_return(msg);
+	if (reply =3D=3D NULL)
+		return NULL;
+
+	dbus_message_iter_init_append(reply, &iter);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+			OFONO_PROPERTIES_ARRAY_SIGNATURE,
+			&dict);
+
+	if (sa->nai)
+		ofono_dbus_dict_append(&dict, "NetworkAccessIdentity",
+				DBUS_TYPE_STRING, &sa->nai);
+
+	dbus_message_iter_close_container(&iter, &dict);
+
+	return reply;
+}
+
 static DBusMessage *send_properties(DBusConnection *conn, DBusMessage *msg,
 		void *data, const char *type, const char *name)
 {
@@ -632,6 +668,10 @@ static const GDBusMethodTable sim_authentication[] =3D=
 {
 			NULL,
 			GDBUS_ARGS({"applications", "a{oa{sv}}"}),
 			get_applications) },
+	{ GDBUS_METHOD("GetProperties",
+			NULL,
+			GDBUS_ARGS({"properties", "a{sv}"}),
+			get_sim_auth_properties) },
 	{ }
 };
 =

@@ -663,94 +703,114 @@ static const GDBusMethodTable sim_auth_isim_app[] =
=3D {
 	{ }
 };
 =

-static void discover_apps_cb(const struct ofono_error *error,
-		const unsigned char *dataobj,
-		int len, void *data)
+/*
+ * Build NAI according to TS 23.003. This should only be used as an NAI
+ * if the SimManager interface could not find an NAI from the ISim.
+ */
+static char *build_nai(const char *imsi)
 {
-	DBusConnection *conn =3D ofono_dbus_get_connection();
-	struct ofono_sim_auth *sim =3D data;
-	struct ofono_modem *modem =3D __ofono_atom_get_modem(sim->atom);
-	const char *path =3D __ofono_atom_get_path(sim->atom);
-	GSList *iter;
-	char app_path[strlen(path) + 34];
-	int ret;
+	char mcc[3];
+	char mnc[3];
+	char *nai =3D g_try_new0(char, 50);
 =

-	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR)
-		goto parse_error;
+	strncpy(mcc, imsi, 3);
 =

-	sim->aid_list =3D sim_parse_app_template_entries(dataobj, len);
+	if (strlen(imsi) =3D=3D 16) {
+		strncpy(mnc, imsi + 3, 3);
+	} else {
+		mnc[0] =3D '0';
+		strncpy(mnc + 1, imsi + 3, 2);
+	}
+
+	sprintf(nai, "%s(a)ims.mnc%.3s.mcc%.3s.3gppnetwork.org", imsi, mnc, mcc);
 =

-	if (!sim->aid_list)
-		goto parse_error;
+	return nai;
+}
+
+void ofono_sim_auth_register(struct ofono_sim_auth *sa)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D __ofono_atom_get_path(sa->atom);
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(sa->atom);
+	struct ofono_sim *sim =3D __ofono_atom_find(OFONO_ATOM_TYPE_SIM, modem);
+	GSList *iter =3D __ofono_sim_get_aid_list(sim);
+	int ret;
 =

-	iter =3D sim->aid_list;
+	sa->sim =3D sim;
 =

-	ret =3D sprintf(app_path, "%s/", path);
+	if (!iter) {
+		DBG("No AID list");
+		return;
+	}
 =

 	while (iter) {
-		struct sim_app_record *app =3D iter->data;
+		struct sim_app_record *r =3D iter->data;
+		struct aid_object *new =3D g_try_new0(struct aid_object, 1);
 =

-		switch (app->type) {
+		new->type =3D r->type;
+
+		switch (r->type) {
 		case SIM_APP_TYPE_USIM:
-			encode_hex_own_buf(app->aid, 16, 0, app_path + ret);
+			new->path =3D g_try_new0(char, strlen(path) + 34);
+
+			ret =3D sprintf(new->path, "%s/", path);
+
+			encode_hex_own_buf(r->aid, 16, 0, new->path + ret);
 =

-			g_dbus_register_interface(conn, app_path,
+			g_dbus_register_interface(conn, new->path,
 					OFONO_USIM_APPLICATION_INTERFACE,
 					sim_auth_usim_app, NULL, NULL,
-					sim, NULL);
+					sa, NULL);
+
+			memcpy(new->aid, r->aid, 16);
+
 			break;
 		case SIM_APP_TYPE_ISIM:
-			encode_hex_own_buf(app->aid, 16, 0, app_path + ret);
+			new->path =3D g_try_new0(char, strlen(path) + 34);
+
+			ret =3D sprintf(new->path, "%s/", path);
 =

-			g_dbus_register_interface(conn, app_path,
+			encode_hex_own_buf(r->aid, 16, 0, new->path + ret);
+
+			g_dbus_register_interface(conn, new->path,
 					OFONO_ISIM_APPLICATION_INTERFACE,
 					sim_auth_isim_app, NULL, NULL,
-					sim, NULL);
+					sa, NULL);
+
+			memcpy(new->aid, r->aid, 16);
+
 			break;
 		default:
-			DBG("Unknown SIM application '%04x'", app->type);
+			DBG("Unknown SIM application '%04x'", r->type);
 			/*
 			 * If we get here, the SIM application was not ISIM
 			 * or USIM, skip.
 			 */
+			g_free(new);
+
+			goto loop_end;
 		}
 =

+		sa->aid_objects =3D g_slist_prepend(sa->aid_objects, new);
+
+loop_end:
 		iter =3D g_slist_next(iter);
 	}
 =

-	/*
-	 * Now SimAuthentication interface can be registered since app
-	 * discovery has completed
-	 */
+	/* if IMPI is not available, build the NAI */
+	if (!__ofono_sim_get_impi(sa->sim))
+		sa->nai =3D build_nai(ofono_sim_get_imsi(sa->sim));
+	else
+		sa->nai =3D g_strdup(__ofono_sim_get_impi(sa->sim));
+
 	g_dbus_register_interface(conn, path,
 			OFONO_SIM_AUTHENTICATION_INTERFACE,
 			sim_authentication, NULL, NULL,
-			sim, NULL);
-	ofono_modem_add_interface(modem,
-			OFONO_SIM_AUTHENTICATION_INTERFACE);
-
-	return;
-
-parse_error:
-	/*
-	 * Something went wrong parsing the AID list, it can't be assumed that
-	 * any previously parsed AID's are valid so free them all.
-	 */
-	DBG("Error parsing app list");
-}
-
-void ofono_sim_auth_register(struct ofono_sim_auth *sa)
-{
-	struct ofono_modem *modem =3D __ofono_atom_get_modem(sa->atom);
-	struct ofono_sim *sim =3D __ofono_atom_find(OFONO_ATOM_TYPE_SIM, modem);
+			sa, NULL);
+	ofono_modem_add_interface(modem, OFONO_SIM_AUTHENTICATION_INTERFACE);
 =

 	__ofono_atom_register(sa->atom, sim_auth_unregister);
 =

-	/* Do SIM application discovery, the cb will register DBus ifaces */
-	sa->driver->list_apps(sa, discover_apps_cb, sa);
-
-	sim =3D __ofono_atom_find(OFONO_ATOM_TYPE_SIM, modem);
-
 	sa->gsm_access =3D __ofono_sim_ust_service_available(sim,
 			SIM_UST_SERVICE_GSM_ACCESS);
 	sa->gsm_context =3D __ofono_sim_ust_service_available(sim,
-- =

2.7.4


--===============9199509311426807409==--

