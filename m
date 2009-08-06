Content-Type: multipart/mixed; boundary="===============3227668896691011948=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] Make SimManager property SubscriberNumbers writable.
Date: Thu, 06 Aug 2009 22:29:32 +0200
Message-ID: <1249590572-18743-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3227668896691011948==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This implements writing SubscriberNumbers if the SIM allows this (optional
to the SIM provider).  Because the property is an array of phone numbers,
setting the property needs to write multiple records on the SIM so it's not
atomic and potentially can fail partially.  In this case we have to report
a write error to DBus client but at the same time file may be changed and
we send a PropertyChanged.
---
 src/sim.c |  205 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++--
 1 files changed, 200 insertions(+), 5 deletions(-)

diff --git a/src/sim.c b/src/sim.c
index b7832f5..0bdf9ab 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -59,6 +59,7 @@
 =

 static gboolean sim_op_next(gpointer user_data);
 static gboolean sim_op_retrieve_next(gpointer user);
+static void sim_own_numbers_update(struct ofono_modem *modem);
 =

 struct sim_file_op {
 	int id;
@@ -80,6 +81,15 @@ struct sim_manager_data {
 	GSList *ready_notify;
 	gboolean ready;
 	GQueue *simop_q;
+
+	int efmsisdn_length;
+};
+
+struct msisdn_set_request {
+	struct ofono_modem *modem;
+	int pending;
+	int failed;
+	DBusMessage *msg;
 };
 =

 static char **get_own_numbers(GSList *own_numbers)
@@ -172,8 +182,151 @@ static DBusMessage *sim_get_properties(DBusConnection=
 *conn,
 	return reply;
 }
 =

+static void msisdn_set_done(struct msisdn_set_request *req)
+{
+	DBusMessage *reply;
+
+	if (req->failed)
+		reply =3D __ofono_error_failed(req->msg);
+	else
+		reply =3D dbus_message_new_method_return(req->msg);
+
+	__ofono_dbus_pending_reply(&req->msg, reply);
+
+	/* Re-read the numbers and emit signal if needed */
+	sim_own_numbers_update(req->modem);
+
+	g_free(req);
+}
+
+static void msisdn_set_cb(struct ofono_modem *modem, int ok, void *data)
+{
+	struct msisdn_set_request *req =3D data;
+
+	if (!ok)
+		req->failed++;
+
+	req->pending--;
+
+	if (!req->pending)
+		msisdn_set_done(req);
+}
+
+static void set_own_numbers(struct ofono_modem *modem,
+		GSList *new_numbers, DBusMessage *msg)
+{
+	struct sim_manager_data *sim =3D modem->sim_manager;
+	struct msisdn_set_request *req;
+	int record;
+	unsigned char efmsisdn[255];
+	struct ofono_phone_number *number;
+
+	if (!sim->own_numbers || g_slist_length(new_numbers) !=3D
+			g_slist_length(sim->own_numbers)) {
+		g_slist_foreach(new_numbers, (GFunc) g_free, 0);
+		g_slist_free(new_numbers);
+
+		msg =3D dbus_message_ref(msg);
+		__ofono_dbus_pending_reply(&msg,
+				__ofono_error_invalid_args(msg));
+
+		return;
+	}
+
+	req =3D g_new0(struct msisdn_set_request, 1);
+
+	req->modem =3D modem;
+	req->msg =3D dbus_message_ref(msg);
+
+	for (record =3D 1; new_numbers; record++) {
+		number =3D new_numbers->data;
+		new_numbers =3D g_slist_delete_link(new_numbers, new_numbers);
+
+		sim_adn_build(efmsisdn, sim->efmsisdn_length, number);
+		g_free(number);
+
+		if (ofono_sim_write(req->modem, SIM_EFMSISDN_FILEID,
+				msisdn_set_cb, OFONO_SIM_FILE_STRUCTURE_FIXED,
+				record++, efmsisdn,
+				sim->efmsisdn_length, req) =3D=3D 0)
+			req->pending++;
+		else
+			req->failed++;
+	}
+
+	if (!req->pending)
+		msisdn_set_done(req);
+}
+
+static DBusMessage *sim_set_property(DBusConnection *conn, DBusMessage *ms=
g,
+					void *data)
+{
+	struct ofono_modem *modem =3D data;
+	struct sim_manager_data *sim =3D modem->sim_manager;
+	DBusMessageIter iter;
+	DBusMessageIter var;
+	DBusMessageIter var_elem;
+	const char *name, *value;
+	struct ofono_phone_number *own;
+	GSList *own_numbers =3D NULL;
+
+	if (!dbus_message_iter_init(msg, &iter))
+		return __ofono_error_invalid_args(msg);
+
+	if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_STRING)
+		return __ofono_error_invalid_args(msg);
+
+	dbus_message_iter_get_basic(&iter, &name);
+
+	if (!strcmp(name, "SubscriberNumbers")) {
+		if (sim->efmsisdn_length =3D=3D 0)
+			return __ofono_error_busy(msg);
+
+		dbus_message_iter_next(&iter);
+
+		if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_VARIANT)
+			return __ofono_error_invalid_args(msg);
+
+		dbus_message_iter_recurse(&iter, &var);
+
+		if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_ARRAY ||
+				dbus_message_iter_get_element_type(&var) !=3D
+				DBUS_TYPE_STRING)
+			return __ofono_error_invalid_args(msg);
+
+		dbus_message_iter_recurse(&var, &var_elem);
+
+		do {
+			if (dbus_message_iter_get_arg_type(&var_elem) !=3D
+					DBUS_TYPE_STRING)
+				goto error;
+
+			dbus_message_iter_get_basic(&var_elem, &value);
+
+			if (!valid_phone_number_format(value))
+				goto error;
+
+			own =3D g_new0(struct ofono_phone_number, 1);
+			string_to_phone_number(value, own);
+
+			own_numbers =3D g_slist_prepend(own_numbers, own);
+		} while (dbus_message_iter_next(&var_elem));
+
+		set_own_numbers(modem, g_slist_reverse(own_numbers), msg);
+		return NULL;
+	}
+
+error:
+	g_slist_foreach(own_numbers, (GFunc) g_free, 0);
+	g_slist_free(own_numbers);
+
+	return __ofono_error_invalid_args(msg);
+}
+
 static GDBusMethodTable sim_manager_methods[] =3D {
 	{ "GetProperties",	"",	"a{sv}",	sim_get_properties	},
+	{ "SetProperty",	"sv",	"",		sim_set_property,
+							G_DBUS_METHOD_FLAG_ASYNC },
 	{ }
 };
 =

@@ -182,6 +335,24 @@ static GDBusSignalTable sim_manager_signals[] =3D {
 	{ }
 };
 =

+static gboolean numbers_list_equal(GSList *a, GSList *b)
+{
+	struct ofono_phone_number *num_a, *num_b;
+
+	while (a || b) {
+		if (!a || !b)
+			return FALSE;
+
+		num_a =3D a->data;
+		num_b =3D b->data;
+
+		if (!g_str_equal(num_a->number, num_b->number) ||
+				num_a->type !=3D num_b->type)
+			return FALSE;
+	}
+
+	return TRUE;
+}
 =

 static void sim_msisdn_read_cb(struct ofono_modem *modem, int ok,
 				enum ofono_sim_file_structure structure,
@@ -192,10 +363,13 @@ static void sim_msisdn_read_cb(struct ofono_modem *mo=
dem, int ok,
 	struct sim_manager_data *sim =3D modem->sim_manager;
 	int total;
 	struct ofono_phone_number ph;
+	GSList **new_own_numbers =3D userdata;
 =

 	if (!ok)
 		goto check;
 =

+	sim->efmsisdn_length =3D record_length;
+
 	if (structure !=3D OFONO_SIM_FILE_STRUCTURE_FIXED)
 		return;
 =

@@ -209,19 +383,24 @@ static void sim_msisdn_read_cb(struct ofono_modem *mo=
dem, int ok,
 =

 		own =3D g_new(struct ofono_phone_number, 1);
 		memcpy(own, &ph, sizeof(struct ofono_phone_number));
-		sim->own_numbers =3D g_slist_prepend(sim->own_numbers, own);
+		*new_own_numbers =3D g_slist_prepend(*new_own_numbers, own);
 	}
 =

 	if (record !=3D total)
 		return;
 =

 check:
-	if (sim->own_numbers) {
+	/* All records retrieved */
+	if (*new_own_numbers)
+		*new_own_numbers =3D g_slist_reverse(*new_own_numbers);
+
+	if (!numbers_list_equal(*new_own_numbers, sim->own_numbers)) {
 		char **own_numbers;
 		DBusConnection *conn =3D ofono_dbus_get_connection();
 =

-		/* All records retrieved */
-		sim->own_numbers =3D g_slist_reverse(sim->own_numbers);
+		g_slist_foreach(sim->own_numbers, (GFunc) g_free, NULL);
+		g_slist_free(sim->own_numbers);
+		sim->own_numbers =3D *new_own_numbers;
 =

 		own_numbers =3D get_own_numbers(sim->own_numbers);
 =

@@ -231,12 +410,28 @@ check:
 							DBUS_TYPE_STRING,
 							&own_numbers);
 		g_strfreev(own_numbers);
+	} else {
+		g_slist_foreach(*new_own_numbers, (GFunc) g_free, NULL);
+		g_slist_free(*new_own_numbers);
 	}
+
+	g_free(new_own_numbers);
+}
+
+static void sim_own_numbers_update(struct ofono_modem *modem)
+{
+	GSList **new_own_numbers =3D g_new0(GSList *, 1);
+
+	if (!new_own_numbers)
+		return;
+
+	ofono_sim_read(modem, SIM_EFMSISDN_FILEID,
+			sim_msisdn_read_cb, new_own_numbers);
 }
 =

 static void sim_ready(struct ofono_modem *modem)
 {
-	ofono_sim_read(modem, SIM_EFMSISDN_FILEID, sim_msisdn_read_cb, NULL);
+	sim_own_numbers_update(modem);
 }
 =

 static void sim_imsi_cb(const struct ofono_error *error, const char *imsi,
-- =

1.6.1


--===============3227668896691011948==--

