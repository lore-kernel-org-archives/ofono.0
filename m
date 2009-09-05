Content-Type: multipart/mixed; boundary="===============2985418355582879835=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] [RFC] Do the PIN check in SIMManager
Date: Sat, 05 Sep 2009 09:25:53 +0200
Message-ID: <1252135553-32722-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2985418355582879835==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This adds checking whether PIN is required during SIM initialisation and
delaying the sim ready notifications until after correct PIN is given.
According to 31.102 the IMSI should be retrieved after the PIN check
however on the SIMs I've tried it can be retrieved before authentication
and I think it would make sense to provide the imsi to the clients so
they know which card they're authenticating to if they're swapping cards.
---
 drivers/atmodem/sim.c |  171 +++++++++++++++++++++++++++++++++++++++++++++=
++++
 include/sim.h         |   13 ++++
 include/types.h       |   20 ++++++
 src/sim.c             |  136 ++++++++++++++++++++++++++++++++++++++-
 src/simutil.c         |   24 +++++++
 src/simutil.h         |    2 +
 6 files changed, 365 insertions(+), 1 deletions(-)

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index 8333670..fdb972a 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -431,6 +431,174 @@ error:
 	}
 }
 =

+static struct {
+	enum ofono_sim_passwd_type type;
+	const char *name;
+} const at_sim_name[] =3D {
+	{ OFONO_PASSWD_SIM_PIN, "SIM PIN" },
+	{ OFONO_PASSWD_SIM_PUK, "SIM PUK" },
+	{ OFONO_PASSWD_PHSIM_PIN, "PH-SIM PIN" },
+	{ OFONO_PASSWD_PHFSIM_PIN, "PH-FSIM PIN" },
+	{ OFONO_PASSWD_PHFSIM_PUK, "PH-FSIM PUK" },
+	{ OFONO_PASSWD_SIM_PIN2, "SIM PIN2" },
+	{ OFONO_PASSWD_SIM_PUK2, "SIM PUK2" },
+	{ OFONO_PASSWD_PHNET_PIN, "PH-NET PIN" },
+	{ OFONO_PASSWD_PHNET_PUK, "PH-NET PUK" },
+	{ OFONO_PASSWD_PHNETSUB_PIN, "PH-NETSUB PIN" },
+	{ OFONO_PASSWD_PHNETSUB_PUK, "PH-NETSUB PUK" },
+	{ OFONO_PASSWD_PHSP_PIN, "PH-SP PIN" },
+	{ OFONO_PASSWD_PHSP_PUK, "PH-SP PUK" },
+	{ OFONO_PASSWD_PHCORP_PIN, "PH-CORP PIN" },
+	{ OFONO_PASSWD_PHCORP_PUK, "PH-CORP PUK" },
+};
+
+static void at_cpin_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	GAtResultIter iter;
+	ofono_sim_passwd_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+	const char *pin_required;
+	int pin_type;
+	int i;
+	int len =3D sizeof(at_sim_name) / sizeof(*at_sim_name);
+
+	dump_response("at_cpin_cb", ok, result);
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (!ok) {
+		cb(&error, -1, cbd->data);
+		return;
+	}
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CPIN:")) {
+		DECLARE_FAILURE(e);
+
+		cb(&e, -1, cbd->data);
+		return;
+	}
+
+	pin_required =3D g_at_result_iter_raw_line(&iter);
+
+	pin_type =3D -1;
+	if (!strcmp(pin_required, "READY"))
+		pin_type =3D OFONO_PASSWD_NONE;
+	else
+		for (i =3D 0; i < len; i++)
+			if (!g_str_has_suffix(pin_required,
+						at_sim_name[i].name))
+				pin_type =3D at_sim_name[i].type;
+
+	if (pin_type =3D=3D -1) {
+		DECLARE_FAILURE(e);
+
+		cb(&e, -1, cbd->data);
+		return;
+	}
+
+	ofono_debug("crsm_pin_cb: %s", pin_required);
+
+	cb(&error, pin_type, cbd->data);
+}
+
+static void at_pin_query(struct ofono_sim *sim, ofono_sim_passwd_cb_t cb,
+			void *data)
+{
+	GAtChat *chat =3D ofono_sim_get_data(sim);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+
+	if (!cbd)
+		goto error;
+
+	if (g_at_chat_send(chat, "AT+CPIN?", NULL,
+				at_cpin_cb, cbd, g_free) > 0)
+		return;
+
+error:
+	if (cbd)
+		g_free(cbd);
+
+	{
+		DECLARE_FAILURE(error);
+		cb(&error, -1, data);
+	}
+}
+
+static void at_cpin_set_cb(gboolean ok, GAtResult *result, gpointer user_d=
ata)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_sim_passwd_send_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+
+	dump_response("at_cpin_set_cb", ok, result);
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	cb(&error, cbd->data);
+}
+
+static void at_pin_send(struct ofono_sim *sim, const char *passwd,
+			ofono_sim_passwd_send_cb_t cb, void *data)
+{
+	GAtChat *chat =3D ofono_sim_get_data(sim);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+	char buf[64];
+	int ret;
+
+	if (!cbd)
+		goto error;
+
+	snprintf(buf, sizeof(buf), "AT+CPIN=3D\"%s\"", passwd);
+
+	ret =3D g_at_chat_send(chat, buf, NULL, at_cpin_set_cb, cbd, g_free);
+
+	memset(buf, 0, sizeof(buf));
+
+	if (ret > 0)
+		return;
+
+error:
+	if (cbd)
+		g_free(cbd);
+
+	{
+		DECLARE_FAILURE(error);
+		cb(&error, data);
+	}
+}
+
+static void at_pin_send_puk(struct ofono_sim *sim, const char *puk,
+				const char *passwd,
+				ofono_sim_passwd_send_cb_t cb, void *data)
+{
+	GAtChat *chat =3D ofono_sim_get_data(sim);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+	char buf[64];
+	int ret;
+
+	if (!cbd)
+		goto error;
+
+	snprintf(buf, sizeof(buf), "AT+CPIN=3D\"%s\",\"%s\"", puk, passwd);
+
+	ret =3D g_at_chat_send(chat, buf, NULL, at_cpin_set_cb, cbd, g_free);
+
+	memset(buf, 0, sizeof(buf));
+
+	if (ret > 0)
+		return;
+
+error:
+	if (cbd)
+		g_free(cbd);
+
+	{
+		DECLARE_FAILURE(error);
+		cb(&error, data);
+	}
+}
+
 static gboolean at_sim_register(gpointer user)
 {
 	struct ofono_sim *sim =3D user;
@@ -467,6 +635,9 @@ static struct ofono_sim_driver driver =3D {
 	.write_file_linear	=3D at_sim_update_record,
 	.write_file_cyclic	=3D at_sim_update_cyclic,
 	.read_imsi		=3D at_read_imsi,
+	.query_passwd_state	=3D at_pin_query,
+	.send_passwd		=3D at_pin_send,
+	.send_new_passwd	=3D at_pin_send_puk,
 };
 =

 void at_sim_init()
diff --git a/include/sim.h b/include/sim.h
index 1da486c..90bedae 100644
--- a/include/sim.h
+++ b/include/sim.h
@@ -64,6 +64,12 @@ typedef void (*ofono_sim_file_read_cb_t)(int ok,
 =

 typedef void (*ofono_sim_file_write_cb_t)(int ok, void *userdata);
 =

+typedef void (*ofono_sim_passwd_cb_t)(const struct ofono_error *error,
+					int passwd_type, void *data);
+
+typedef void (*ofono_sim_passwd_send_cb_t)(const struct ofono_error *error,
+					void *data);
+
 struct ofono_sim_driver {
 	const char *name;
 	int (*probe)(struct ofono_sim *sim, unsigned int vendor, void *data);
@@ -90,6 +96,13 @@ struct ofono_sim_driver {
 			ofono_sim_write_cb_t cb, void *data);
 	void (*read_imsi)(struct ofono_sim *sim,
 			ofono_sim_imsi_cb_t cb, void *data);
+	void (*query_passwd_state)(struct ofono_sim *sim,
+			ofono_sim_passwd_cb_t cb, void *data);
+	void (*send_passwd)(struct ofono_sim *sim, const char *passwd,
+			ofono_sim_passwd_send_cb_t cb, void *data);
+	void (*send_new_passwd)(struct ofono_sim *sim, const char *puk,
+			const char *passwd,
+			ofono_sim_passwd_send_cb_t cb, void *data);
 };
 =

 int ofono_sim_driver_register(const struct ofono_sim_driver *d);
diff --git a/include/types.h b/include/types.h
index 6a9681d..99e2ca5 100644
--- a/include/types.h
+++ b/include/types.h
@@ -91,6 +91,26 @@ struct ofono_call {
 	int clip_validity;
 };
 =

+enum ofono_sim_passwd_type {
+	OFONO_PASSWD_NONE =3D 0,
+
+	OFONO_PASSWD_SIM_PIN,
+	OFONO_PASSWD_SIM_PUK,
+	OFONO_PASSWD_PHSIM_PIN,
+	OFONO_PASSWD_PHFSIM_PIN,
+	OFONO_PASSWD_PHFSIM_PUK,
+	OFONO_PASSWD_SIM_PIN2,
+	OFONO_PASSWD_SIM_PUK2,
+	OFONO_PASSWD_PHNET_PIN,
+	OFONO_PASSWD_PHNET_PUK,
+	OFONO_PASSWD_PHNETSUB_PIN,
+	OFONO_PASSWD_PHNETSUB_PUK,
+	OFONO_PASSWD_PHSP_PIN,
+	OFONO_PASSWD_PHSP_PUK,
+	OFONO_PASSWD_PHCORP_PIN,
+	OFONO_PASSWD_PHCORP_PUK,
+};
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/src/sim.c b/src/sim.c
index a072c8c..44f0a3b 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -55,6 +55,7 @@ static GSList *g_drivers =3D NULL;
 static gboolean sim_op_next(gpointer user_data);
 static gboolean sim_op_retrieve_next(gpointer user);
 static void sim_own_numbers_update(struct ofono_sim *sim);
+static void sim_pin_check(struct ofono_sim *sim);
 =

 struct sim_file_op {
 	int id;
@@ -77,6 +78,8 @@ struct ofono_sim {
 	GSList *service_numbers;
 	gboolean sdn_ready;
 	gboolean ready;
+	gboolean pin_ready;
+	int pin_type;
 	GQueue *simop_q;
 	gint simop_source;
 	unsigned char efmsisdn_length;
@@ -86,6 +89,7 @@ struct ofono_sim {
 	const struct ofono_sim_driver *driver;
 	void *driver_data;
 	struct ofono_atom *atom;
+	DBusMessage *pending;
 };
 =

 struct msisdn_set_request {
@@ -95,6 +99,7 @@ struct msisdn_set_request {
 	DBusMessage *msg;
 };
 =

+
 struct sim_ready_watch {
 	unsigned int id;
 	ofono_sim_ready_notify_cb_t notify;
@@ -171,6 +176,8 @@ static DBusMessage *sim_get_properties(DBusConnection *=
conn,
 	DBusMessageIter dict;
 	char **own_numbers;
 	char **service_numbers;
+	dbus_bool_t pin_needed;
+	const char *pin_name;
 =

 	reply =3D dbus_message_new_method_return(msg);
 	if (!reply)
@@ -205,6 +212,18 @@ static DBusMessage *sim_get_properties(DBusConnection =
*conn,
 		g_strfreev(service_numbers);
 	}
 =

+	pin_needed =3D !sim->pin_ready;
+	ofono_dbus_dict_append(&dict, "WaitingForPIN",
+				DBUS_TYPE_BOOLEAN, &pin_needed);
+
+	if (sim->pin_type !=3D OFONO_PASSWD_NONE) {
+		pin_name =3D sim_passwd_name(sim->pin_type);
+
+		ofono_dbus_dict_append(&dict, "PINTypeRequired",
+					DBUS_TYPE_STRING,
+					(void *) &pin_name);
+	}
+
 	dbus_message_iter_close_container(&iter, &dict);
 =

 	return reply;
@@ -353,10 +372,64 @@ error:
 	return __ofono_error_invalid_args(msg);
 }
 =

+static void sim_send_pin_cb(const struct ofono_error *error, void *data)
+{
+	struct ofono_sim *sim =3D data;
+	DBusMessage *reply;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR)
+		reply =3D __ofono_error_failed(sim->pending);
+	else
+		reply =3D dbus_message_new_method_return(sim->pending);
+
+
+	__ofono_dbus_pending_reply(&sim->pending, reply);
+
+	/* Re-check the authentication status and update DBus properties
+	 * as needed.  We need to do this regardless of whether the password
+	 * given was correct: if it was incorrect, the number of retries
+	 * may have expired and a different password is being requested now.
+	 * If it was correct, possibly proceed with SIM initialisation.
+	 */
+	sim_pin_check(sim);
+}
+
+static DBusMessage *sim_send_pin(DBusConnection *conn, DBusMessage *msg,
+					void *data)
+{
+	struct ofono_sim *sim =3D data;
+	DBusMessageIter iter;
+	const char *pin;
+
+	if (!sim->driver->send_passwd)
+		return __ofono_error_not_implemented(msg);
+
+	if (sim->pending)
+		return __ofono_error_busy(msg);
+
+	if (!dbus_message_iter_init(msg, &iter))
+		return __ofono_error_invalid_args(msg);
+
+	if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_STRING)
+		return __ofono_error_invalid_args(msg);
+
+	dbus_message_iter_get_basic(&iter, &pin);
+
+	if (!is_valid_pin(pin))
+		return __ofono_error_invalid_format(msg);
+
+	sim->pending =3D dbus_message_ref(msg);
+	sim->driver->send_passwd(sim, pin, sim_send_pin_cb, sim);
+
+	return NULL;
+}
+
 static GDBusMethodTable sim_methods[] =3D {
 	{ "GetProperties",	"",	"a{sv}",	sim_get_properties	},
 	{ "SetProperty",	"sv",	"",		sim_set_property,
 							G_DBUS_METHOD_FLAG_ASYNC },
+	{ "SendPIN",	"s",	"",			sim_send_pin,
+							G_DBUS_METHOD_FLAG_ASYNC },
 	{ }
 };
 =

@@ -612,6 +685,67 @@ static void sim_retrieve_imsi(struct ofono_sim *sim)
 	sim->driver->read_imsi(sim, sim_imsi_cb, sim);
 }
 =

+static void sim_pin_check_done(struct ofono_sim *sim)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D __ofono_atom_get_path(sim->atom);
+	dbus_bool_t value =3D FALSE;
+
+	if (sim->pin_ready =3D=3D FALSE) {
+		sim->pin_ready =3D TRUE;
+
+		ofono_dbus_signal_property_changed(conn, path,
+							SIM_MANAGER_INTERFACE,
+							"WaitingForPIN",
+							DBUS_TYPE_BOOLEAN,
+							&value);
+	}
+
+	sim_retrieve_imsi(sim);
+}
+
+static void sim_pin_query_cb(const struct ofono_error *error, int pin_type,
+		void *data)
+{
+	struct ofono_sim *sim =3D data;
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D __ofono_atom_get_path(sim->atom);
+	const char *pin_name;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		ofono_error("Querrying PIN authentication state failed");
+
+		sim_pin_check_done(sim);
+		return;
+	}
+
+	if (sim->pin_type !=3D pin_type) {
+		sim->pin_type =3D pin_type;
+		pin_name =3D sim_passwd_name(pin_type);
+
+		ofono_dbus_signal_property_changed(conn, path,
+							SIM_MANAGER_INTERFACE,
+							"PINTypeRequired",
+							DBUS_TYPE_STRING,
+							&pin_name);
+	}
+
+	if (pin_type =3D=3D OFONO_PASSWD_NONE)
+		sim_pin_check_done(sim);
+}
+
+static void sim_pin_check(struct ofono_sim *sim)
+{
+	if (!sim->driver->query_passwd_state) {
+		sim_pin_check_done(sim);
+		return;
+	}
+
+	sim->pin_ready =3D FALSE;
+
+	sim->driver->query_passwd_state(sim, sim_pin_query_cb, sim);
+}
+
 static void sim_op_error(struct ofono_sim *sim)
 {
 	struct sim_file_op *op =3D g_queue_pop_head(sim->simop_q);
@@ -1312,7 +1446,7 @@ void ofono_sim_register(struct ofono_sim *sim)
 	 * arbitrary files to be written or read, assuming their presence
 	 * in the EFust
 	 */
-	sim_retrieve_imsi(sim);
+	sim_pin_check(sim);
 }
 =

 void ofono_sim_remove(struct ofono_sim *sim)
diff --git a/src/simutil.c b/src/simutil.c
index b80e014..2b26700 100644
--- a/src/simutil.c
+++ b/src/simutil.c
@@ -488,3 +488,27 @@ void sim_adn_build(unsigned char *data, int length,
 	/* Ext1 unused */
 	*data++ =3D 0xff;
 }
+
+static const char *const passwd_name[] =3D {
+	[OFONO_PASSWD_NONE] =3D "None",
+	[OFONO_PASSWD_SIM_PIN] =3D "SIM PIN",
+	[OFONO_PASSWD_SIM_PUK] =3D "SIM PUK",
+	[OFONO_PASSWD_PHSIM_PIN] =3D "PH-SIM PIN",
+	[OFONO_PASSWD_PHFSIM_PIN] =3D "PH-FSIM PIN",
+	[OFONO_PASSWD_PHFSIM_PUK] =3D "PH-FSIM PUK",
+	[OFONO_PASSWD_SIM_PIN2] =3D "SIM PIN2",
+	[OFONO_PASSWD_SIM_PUK2] =3D "SIM PUK2",
+	[OFONO_PASSWD_PHNET_PIN] =3D "PH-NET PIN",
+	[OFONO_PASSWD_PHNET_PUK] =3D "PH-NET PUK",
+	[OFONO_PASSWD_PHNETSUB_PIN] =3D "PH-NETSUB PIN",
+	[OFONO_PASSWD_PHNETSUB_PUK] =3D "PH-NETSUB PUK",
+	[OFONO_PASSWD_PHSP_PIN] =3D "PH-SP PIN",
+	[OFONO_PASSWD_PHSP_PUK] =3D "PH-SP PUK",
+	[OFONO_PASSWD_PHCORP_PIN] =3D "PH-CORP PIN",
+	[OFONO_PASSWD_PHCORP_PUK] =3D "PH-CORP PUK",
+};
+
+const char *sim_passwd_name(enum ofono_sim_passwd_type type)
+{
+	return passwd_name[type];
+}
diff --git a/src/simutil.h b/src/simutil.h
index de3e55e..fc4f063 100644
--- a/src/simutil.h
+++ b/src/simutil.h
@@ -88,3 +88,5 @@ gboolean sim_adn_parse(const unsigned char *data, int len=
gth,
 void sim_adn_build(unsigned char *data, int length,
 			const struct ofono_phone_number *ph,
 			const char *identifier);
+
+const char *sim_passwd_name(enum ofono_sim_passwd_type type);
-- =

1.6.1


--===============2985418355582879835==--

