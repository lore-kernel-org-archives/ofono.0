Content-Type: multipart/mixed; boundary="===============4728043628501095994=="
MIME-Version: 1.0
From: Antara Borwankar <antara.borwankar@intel.com>
Subject: [PATCH 2/3] coex: coex agent implementation
Date: Fri, 30 Nov 2018 15:12:56 +0530
Message-ID: <1543570976-20522-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4728043628501095994==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Antara <antara.borwankar@intel.com>

Added implementation for coex agent
---
 plugins/xmm7xxx.c | 995 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 995 insertions(+)

diff --git a/plugins/xmm7xxx.c b/plugins/xmm7xxx.c
index 195f96b..c1a5d75 100644
--- a/plugins/xmm7xxx.c
+++ b/plugins/xmm7xxx.c
@@ -57,16 +57,979 @@
 #include <drivers/atmodem/atutil.h>
 #include <drivers/atmodem/vendor.h>
 =

+#include "ofono.h"
+#include "gdbus.h"
+
+#define OFONO_COEX_INTERFACE OFONO_SERVICE ".intel.LteCoexistence"
+#define OFONO_COEX_AGENT_INTERFACE OFONO_SERVICE ".intel.LteCoexistenceAge=
nt"
+
+#define NET_BAND_LTE_INVALID 0
+#define NET_BAND_LTE_1 101
+#define NET_BAND_LTE_43 143
+#define BAND_LEN 20
+#define MAX_BT_SAFE_VECTOR 15
+#define MAX_WL_SAFE_VECTOR 13
+
 static const char *none_prefix[] =3D { NULL };
 static const char *xsimstate_prefix[] =3D { "+XSIMSTATE:", NULL };
+static const char *xnvmplmn_prefix[] =3D { "+XNVMPLMN:", NULL };
+
+enum coex_agent_result {
+	COEX_AGENT_RESULT_OK,
+	COEX_AGENT_RESULT_BACK,
+	COEX_AGENT_RESULT_TERMINATE,
+	COEX_AGENT_RESULT_TIMEOUT,
+	COEX_AGENT_RESULT_BUSY,};
+
+struct bt_coex_info {
+	int safe_tx_min;
+	int safe_tx_max;
+	int safe_rx_min;
+	int safe_rx_max;
+	int safe_vector[MAX_BT_SAFE_VECTOR];
+	int num_safe_vector;
+};
+
+struct wl_coex_info {
+	int safe_tx_min;
+	int safe_tx_max;
+	int safe_rx_min;
+	int safe_rx_max;
+	int safe_vector[MAX_BT_SAFE_VECTOR];
+	int num_safe_vector;
+};
+
+struct coex_agent {
+	char *path;
+	char *bus;
+	guint disconnect_watch;
+	ofono_bool_t remove_on_terminate;
+	ofono_destroy_func removed_cb;
+	void *removed_data;
+	DBusMessage *msg;
+	int min_length;
+	int max_length;
+	ofono_bool_t hidden_entry;
+};
 =

 struct xmm7xxx_data {
 	GAtChat *chat;		/* AT chat */
 	struct ofono_sim *sim;
 	ofono_bool_t have_sim;
 	ofono_bool_t sms_phonebook_added;
+	unsigned int netreg_watch;
+};
+
+/* Coex Implementation */
+enum wlan_bw {
+	OFONO_WLAN_BW_UNSUPPORTED =3D -1,
+	OFONO_WLAN_BW_20MHZ =3D 0,
+	OFONO_WLAN_BW_40MHZ =3D 1,
+	OFONO_WLAN_BW_80MHZ =3D 2,
+};
+
+struct Plmnhist {
+	unsigned short mnc;
+	unsigned short mcc;
+	unsigned long tdd;
+	unsigned long fdd;
+	unsigned char bw;
 };
 =

+struct ofono_coex {
+	GAtChat *chat;
+	struct ofono_modem *modem;
+
+	DBusMessage *pending;
+	ofono_bool_t bt_active;
+	ofono_bool_t wlan_active;
+	enum wlan_bw wlan_bw;
+	char *lte_band;
+
+	ofono_bool_t pending_bt_active;
+	ofono_bool_t pending_wlan_active;
+	enum wlan_bw pending_wlan_bw;
+	ofono_bool_t lte_active;
+
+	struct coex_agent *session_agent;
+};
+
+ofono_bool_t coex_agent_matches(struct coex_agent *agent,
+			const char *path, const char *sender)
+{
+	return !strcmp(agent->path, path) && !strcmp(agent->bus, sender);
+}
+
+void coex_agent_set_removed_notify(struct coex_agent *agent,
+					ofono_destroy_func destroy,
+					void *user_data)
+{
+	agent->removed_cb =3D destroy;
+	agent->removed_data =3D user_data;
+}
+
+static void coex_agent_send_noreply(struct coex_agent *agent, const char *=
method)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	DBusMessage *message;
+
+	message =3D dbus_message_new_method_call(agent->bus, agent->path,
+					OFONO_COEX_INTERFACE,
+					method);
+	if (message =3D=3D NULL)
+		return;
+
+	dbus_message_set_no_reply(message, TRUE);
+
+	g_dbus_send_message(conn, message);
+}
+
+void coex_agent_send_release(struct coex_agent *agent)
+{
+	coex_agent_send_noreply(agent, "Release");
+}
+
+void coex_agent_free(struct coex_agent *agent)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+
+	if (agent->disconnect_watch) {
+		coex_agent_send_release(agent);
+
+		g_dbus_remove_watch(conn, agent->disconnect_watch);
+		agent->disconnect_watch =3D 0;
+	}
+
+	if (agent->removed_cb)
+		agent->removed_cb(agent->removed_data);
+
+	g_free(agent->path);
+	g_free(agent->bus);
+	g_free(agent);
+}
+
+static void coex_agent_disconnect_cb(DBusConnection *conn, void *user_data)
+{
+	struct coex_agent *agent =3D user_data;
+
+	ofono_debug("Agent exited without calling Unregister");
+
+	agent->disconnect_watch =3D 0;
+
+	coex_agent_free(agent);
+}
+
+struct coex_agent *coex_agent_new(const char *path, const char *sender,
+				ofono_bool_t remove_on_terminate)
+{
+	struct coex_agent *agent =3D g_try_new0(struct coex_agent, 1);
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+
+	DBG("");
+	if (agent =3D=3D NULL)
+		return NULL;
+
+	agent->path =3D g_strdup(path);
+	agent->bus =3D g_strdup(sender);
+
+	agent->remove_on_terminate =3D remove_on_terminate;
+
+	agent->disconnect_watch =3D g_dbus_add_disconnect_watch(conn, sender,
+							coex_agent_disconnect_cb,
+							agent, NULL);
+
+	return agent;
+}
+
+int coex_agent_coex_wlan_notify(struct coex_agent *agent,
+			const struct wl_coex_info wlan_info)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	DBusMessageIter wl_args, wl_dict, wl_array;
+	const dbus_int32_t *pwl_array =3D wlan_info.safe_vector;
+	dbus_int32_t value;
+
+	agent->msg =3D dbus_message_new_method_call(agent->bus, agent->path,
+						OFONO_COEX_AGENT_INTERFACE,
+						"ReceiveWiFiNotification");
+	if (agent->msg =3D=3D NULL)
+		return -ENOMEM;
+
+	dbus_message_iter_init_append(agent->msg, &wl_args);
+
+	dbus_message_iter_open_container(&wl_args, DBUS_TYPE_ARRAY,
+				DBUS_TYPE_INT32_AS_STRING, &wl_array);
+	dbus_message_iter_append_fixed_array(&wl_array, DBUS_TYPE_INT32,
+					&pwl_array, MAX_WL_SAFE_VECTOR);
+
+	dbus_message_iter_close_container(&wl_args, &wl_array);
+
+	dbus_message_iter_open_container(&wl_args, DBUS_TYPE_ARRAY,
+							"{sv}", &wl_dict);
+
+	value =3D wlan_info.safe_tx_min;
+	ofono_dbus_dict_append(&wl_dict, "SafeTxMin",
+			 DBUS_TYPE_UINT32, &value);
+	value =3D wlan_info.safe_tx_max;
+	ofono_dbus_dict_append(&wl_dict, "SafeTxMax",
+			 DBUS_TYPE_UINT32, &value);
+	value =3D wlan_info.safe_rx_min;
+	ofono_dbus_dict_append(&wl_dict, "SafeRxMin",
+			 DBUS_TYPE_UINT32, &value);
+	value =3D wlan_info.safe_rx_max;
+	ofono_dbus_dict_append(&wl_dict, "SafeRxMax",
+			 DBUS_TYPE_UINT32, &value);
+	value =3D wlan_info.num_safe_vector;
+	ofono_dbus_dict_append(&wl_dict, "NumSafeVector",
+			 DBUS_TYPE_UINT32, &value);
+
+	dbus_message_iter_close_container(&wl_args, &wl_dict);
+	dbus_message_set_no_reply(agent->msg, TRUE);
+
+	if (dbus_connection_send(conn, agent->msg, NULL) =3D=3D FALSE)
+		return -EIO;
+
+	dbus_message_unref(agent->msg);
+
+	return 0;
+}
+
+int coex_agent_coex_bt_notify(struct coex_agent *agent,
+			const struct bt_coex_info bt_info)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	DBusMessageIter bt_args, bt_dict, bt_array;
+	const dbus_int32_t *pbt_array =3D bt_info.safe_vector;
+	int len =3D MAX_BT_SAFE_VECTOR;
+	dbus_int32_t value;
+
+	agent->msg =3D dbus_message_new_method_call(agent->bus, agent->path,
+						OFONO_COEX_AGENT_INTERFACE,
+						"ReceiveBTNotification");
+
+	if (agent->msg =3D=3D NULL)
+		return -ENOMEM;
+
+	pbt_array =3D bt_info.safe_vector;
+
+	for (len =3D 0 ; len < MAX_BT_SAFE_VECTOR; len++)
+		DBG("pbt_array[%d] =3D %d", len, pbt_array[len]);
+
+	dbus_message_iter_init_append(agent->msg, &bt_args);
+
+	dbus_message_iter_open_container(&bt_args, DBUS_TYPE_ARRAY,
+					DBUS_TYPE_INT32_AS_STRING, &bt_array);
+
+	dbus_message_iter_append_fixed_array(&bt_array, DBUS_TYPE_INT32,
+					&pbt_array, len);
+
+	dbus_message_iter_close_container(&bt_args, &bt_array);
+
+	dbus_message_iter_open_container(&bt_args,
+					DBUS_TYPE_ARRAY, "{sv}", &bt_dict);
+
+	value =3D bt_info.safe_tx_min;
+	DBG("value =3D %d", value);
+	ofono_dbus_dict_append(&bt_dict, "SafeTxMin",
+			DBUS_TYPE_UINT32, &value);
+	value =3D bt_info.safe_tx_max;
+	DBG("value =3D %d", value);
+	ofono_dbus_dict_append(&bt_dict, "SafeTxMax",
+			DBUS_TYPE_UINT32, &value);
+	value =3D bt_info.safe_rx_min;
+	DBG("value =3D %d", value);
+	ofono_dbus_dict_append(&bt_dict, "SafeRxMin",
+			DBUS_TYPE_UINT32, &value);
+	value =3D bt_info.safe_rx_max;
+	DBG("value =3D %d", value);
+	ofono_dbus_dict_append(&bt_dict, "SafeRxMax",
+			DBUS_TYPE_UINT32, &value);
+	value =3D bt_info.num_safe_vector;
+	DBG("value =3D %d", value);
+	ofono_dbus_dict_append(&bt_dict, "NumSafeVector",
+			DBUS_TYPE_UINT32, &value);
+
+	dbus_message_iter_close_container(&bt_args, &bt_dict);
+
+	if (dbus_connection_send(conn, agent->msg, NULL) =3D=3D FALSE) {
+		return -EIO;
+	}
+
+	dbus_message_unref(agent->msg);
+
+	return 0;
+}
+
+static gboolean coex_wlan_bw_from_string(const char *str,
+				enum wlan_bw *band)
+{
+	if (g_str_equal(str, "20")) {
+		*band =3D OFONO_WLAN_BW_20MHZ;
+		return TRUE;
+	} else if (g_str_equal(str, "40")) {
+		*band =3D OFONO_WLAN_BW_40MHZ;
+		return TRUE;
+	} else if (g_str_equal(str, "80")) {
+		*band =3D OFONO_WLAN_BW_80MHZ;
+		return TRUE;
+	} else
+		*band =3D OFONO_WLAN_BW_UNSUPPORTED;
+
+	return FALSE;
+}
+
+const char *ofono_wlan_bw_to_string(int band)
+{
+	switch (band) {
+	case OFONO_WLAN_BW_20MHZ:
+		return "20MHz";
+	case OFONO_WLAN_BW_40MHZ:
+		return "40MHz";
+	case OFONO_WLAN_BW_80MHZ:
+		return "80MHz";
+	case OFONO_WLAN_BW_UNSUPPORTED:
+		return "UnSupported";
+	}
+
+	return "";
+}
+
+void xmm_get_band_string(int lte_band, char *band)
+{
+	int band_lte =3D lte_band-NET_BAND_LTE_1+1;
+	if (lte_band >=3D NET_BAND_LTE_1 && lte_band <=3D NET_BAND_LTE_43)
+		sprintf(band, "BAND_LTE_%d", band_lte);
+	else
+		sprintf(band, "INVALID");
+}
+
+static DBusMessage *coex_get_properties(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	struct ofono_coex *coex =3D data;
+	DBusMessage *reply;
+	DBusMessageIter iter;
+	DBusMessageIter dict;
+	dbus_bool_t value;
+	const char *band =3D NULL;
+
+	reply =3D dbus_message_new_method_return(msg);
+	if (reply =3D=3D NULL)
+		return NULL;
+
+	dbus_message_iter_init_append(reply, &iter);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+					OFONO_PROPERTIES_ARRAY_SIGNATURE,
+					&dict);
+
+	value =3D coex->bt_active;
+	ofono_dbus_dict_append(&dict, "BTActive",
+								DBUS_TYPE_BOOLEAN, &value);
+
+	value =3D coex->wlan_active;
+	ofono_dbus_dict_append(&dict, "WLANActive",
+								DBUS_TYPE_BOOLEAN, &value);
+
+	band =3D ofono_wlan_bw_to_string(coex->wlan_bw);
+	ofono_dbus_dict_append(&dict, "WLANBandwidth",
+									DBUS_TYPE_STRING, &band);
+
+	band =3D coex->lte_band;
+	ofono_dbus_dict_append(&dict, "Band", DBUS_TYPE_STRING, &band);
+
+	dbus_message_iter_close_container(&iter, &dict);
+
+	return reply;
+}
+
+static void coex_set_params_cb(gboolean ok, GAtResult *result,
+					gpointer user_data)
+{
+	struct ofono_coex *coex =3D user_data;
+	DBusMessage *reply;
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D ofono_modem_get_path(coex->modem);
+
+	DBG("ok %d", ok);
+
+	if (!ok) {
+		coex->pending_bt_active =3D coex->bt_active;
+		coex->pending_wlan_active =3D coex->wlan_active;
+		coex->pending_wlan_bw =3D coex->wlan_bw;
+		reply =3D __ofono_error_failed(coex->pending);
+		__ofono_dbus_pending_reply(&coex->pending, reply);
+		return;
+	}
+
+	if (coex->bt_active !=3D coex->pending_bt_active) {
+		coex->bt_active =3D coex->pending_bt_active;
+		ofono_dbus_signal_property_changed(conn, path,
+						OFONO_COEX_INTERFACE,
+						"BTActive",
+						DBUS_TYPE_BOOLEAN,
+						&(coex->bt_active));
+	}
+
+	if (coex->wlan_active !=3D coex->wlan_active) {
+		coex->wlan_active =3D coex->wlan_active;
+		ofono_dbus_signal_property_changed(conn, path,
+						OFONO_COEX_INTERFACE,
+						"WLANActive",
+						DBUS_TYPE_BOOLEAN,
+						&(coex->wlan_active));
+	}
+
+	if (coex->wlan_bw !=3D coex->pending_wlan_bw) {
+		const char *str_band =3D ofono_wlan_bw_to_string(coex->wlan_bw);
+		coex->wlan_bw =3D coex->pending_wlan_bw;
+
+		ofono_dbus_signal_property_changed(conn, path,
+						OFONO_COEX_INTERFACE,
+						"WLANBandwidth",
+						DBUS_TYPE_STRING,
+						&str_band);
+	}
+
+	reply =3D dbus_message_new_method_return(coex->pending);
+	__ofono_dbus_pending_reply(&coex->pending, reply);
+}
+
+static void coex_set_params(struct ofono_coex *coex, ofono_bool_t bt_activ=
e,
+								ofono_bool_t wlan_active, int wlan_bw)
+{
+	char buf[64];
+	DBusMessage *reply;
+
+	DBG("");
+	sprintf(buf, "AT+XNRTCWS=3D65535,%u,%u,%u", (int)wlan_active,
+					wlan_bw, bt_active);
+	if (g_at_chat_send(coex->chat, buf, none_prefix,
+				coex_set_params_cb, coex, NULL) > 0) {
+		return;
+	}
+
+	coex->pending_bt_active =3D coex->bt_active;
+	coex->pending_wlan_active =3D coex->wlan_active;
+	coex->pending_wlan_bw =3D coex->wlan_bw;
+	reply =3D __ofono_error_failed(coex->pending);
+	__ofono_dbus_pending_reply(&coex->pending, reply);
+}
+
+static DBusMessage *coex_set_property(DBusConnection *conn,
+				DBusMessage *msg, void *data)
+{
+	struct ofono_coex *coex =3D data;
+	DBusMessageIter iter;
+	DBusMessageIter var;
+	const char *property;
+	dbus_bool_t value;
+
+	if (coex->pending)
+		return __ofono_error_busy(msg);
+
+	if (!dbus_message_iter_init(msg, &iter))
+		return __ofono_error_invalid_args(msg);
+
+	if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_STRING)
+		return __ofono_error_invalid_args(msg);
+
+	dbus_message_iter_get_basic(&iter, &property);
+	dbus_message_iter_next(&iter);
+
+	if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_VARIANT)
+		return __ofono_error_invalid_args(msg);
+
+	dbus_message_iter_recurse(&iter, &var);
+
+	if (!strcmp(property, "BTActive")) {
+		if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_BOOLEAN)
+			return __ofono_error_invalid_args(msg);
+
+		dbus_message_iter_get_basic(&var, &value);
+
+		if (coex->bt_active =3D=3D (ofono_bool_t) value)
+			return dbus_message_new_method_return(msg);
+
+		coex->pending_bt_active =3D value;
+		coex->pending =3D dbus_message_ref(msg);
+
+		coex_set_params(coex, value, coex->wlan_active, coex->wlan_bw);
+		return NULL;
+	} else if (!strcmp(property, "WLANActive")) {
+		if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_BOOLEAN)
+			return __ofono_error_invalid_args(msg);
+
+		dbus_message_iter_get_basic(&var, &value);
+
+		if (coex->wlan_active =3D=3D (ofono_bool_t) value)
+			return dbus_message_new_method_return(msg);
+
+		coex->pending_wlan_active =3D value;
+		coex->pending =3D dbus_message_ref(msg);
+
+		coex_set_params(coex, coex->bt_active, value, coex->wlan_bw);
+		return NULL;
+	} else if (g_strcmp0(property, "WLANBandwidth") =3D=3D 0) {
+		const char *value;
+		enum wlan_bw band;
+
+		if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_STRING)
+			return __ofono_error_invalid_args(msg);
+
+		dbus_message_iter_get_basic(&var, &value);
+		if (coex_wlan_bw_from_string(value, &band) =3D=3D FALSE)
+			return __ofono_error_invalid_args(msg);
+
+		if (coex->wlan_bw =3D=3D band)
+			return dbus_message_new_method_return(msg);
+
+		coex->pending_wlan_bw =3D band;
+		coex->pending =3D dbus_message_ref(msg);
+
+		coex_set_params(coex, coex->bt_active, coex->wlan_active, band);
+		return NULL;
+	} else {
+		return __ofono_error_invalid_args(msg);
+	}
+
+	return dbus_message_new_method_return(msg);
+}
+
+static void coex_register_agent_cb(gboolean ok, GAtResult *result,
+					gpointer user_data)
+{
+	struct ofono_coex *coex =3D user_data;
+	DBusMessage *reply;
+
+	if (!ok) {
+		reply =3D __ofono_error_failed(coex->pending);
+		__ofono_dbus_pending_reply(&coex->pending, reply);
+		coex_agent_free(coex->session_agent);
+		return;
+	}
+
+	reply =3D dbus_message_new_method_return(coex->pending);
+	__ofono_dbus_pending_reply(&coex->pending, reply);
+}
+
+static void coex_default_agent_notify(gpointer user_data)
+{
+	struct ofono_coex *coex =3D user_data;
+	coex_agent_free(coex->session_agent);
+
+	g_at_chat_send(coex->chat, "AT+XNRTCWS=3D0", none_prefix,
+				NULL, NULL, NULL);
+}
+
+static DBusMessage *coex_register_agent(DBusConnection *conn,
+				DBusMessage *msg, void *data)
+{
+	struct ofono_coex *coex =3D data;
+	const char *agent_path;
+
+	if (dbus_message_get_args(msg, NULL,
+				DBUS_TYPE_OBJECT_PATH, &agent_path,
+				DBUS_TYPE_INVALID) =3D=3D FALSE)
+		return __ofono_error_invalid_args(msg);
+
+	if (!dbus_validate_path(agent_path, NULL))
+		return __ofono_error_invalid_format(msg);
+
+	if (coex->session_agent) {
+		DBG("Coexistence agent already registered");
+		dbus_message_new_method_return(msg);
+	}
+
+	coex->session_agent =3D coex_agent_new(agent_path,
+					dbus_message_get_sender(msg),
+					FALSE);
+	if (coex->session_agent =3D=3D NULL)
+		return __ofono_error_failed(msg);
+
+	coex_agent_set_removed_notify(coex->session_agent,
+				coex_default_agent_notify, coex);
+
+	if (g_at_chat_send(coex->chat, "AT+XNRTCWS=3D7", none_prefix,
+				coex_register_agent_cb, coex, NULL) > 0) {
+		coex->pending =3D dbus_message_ref(msg);
+		return NULL;
+	}
+
+	coex_agent_free(coex->session_agent);
+	return __ofono_error_failed(msg);
+}
+
+static DBusMessage *coex_unregister_agent(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	struct ofono_coex *coex =3D data;
+	const char *agent_path;
+	const char *agent_bus =3D dbus_message_get_sender(msg);
+
+	if (dbus_message_get_args(msg, NULL,
+					DBUS_TYPE_OBJECT_PATH, &agent_path,
+					DBUS_TYPE_INVALID) =3D=3D FALSE)
+		return __ofono_error_invalid_args(msg);
+
+	if (coex->session_agent =3D=3D NULL)
+		return __ofono_error_failed(msg);
+
+	if (!coex_agent_matches(coex->session_agent, agent_path, agent_bus))
+		return __ofono_error_failed(msg);
+
+	coex_agent_send_release(coex->session_agent);
+	coex_agent_free(coex->session_agent);
+
+	g_at_chat_send(coex->chat, "AT+XNRTCWS=3D0", none_prefix,
+				NULL, NULL, NULL);
+
+	return dbus_message_new_method_return(msg);
+}
+
+static void append_plmn_properties(struct Plmnhist *list,
+					DBusMessageIter *dict)
+{
+	ofono_dbus_dict_append(dict, "MobileCountryCode",
+			DBUS_TYPE_UINT16, &list->mcc);
+	ofono_dbus_dict_append(dict, "MobileNetworkCode",
+			DBUS_TYPE_UINT16, &list->mnc);
+	ofono_dbus_dict_append(dict, "LteBandsFDD",
+			DBUS_TYPE_UINT32, &list->fdd);
+	ofono_dbus_dict_append(dict, "LteBandsTDD",
+			DBUS_TYPE_UINT32, &list->tdd);
+	ofono_dbus_dict_append(dict, "ChannelBandwidth",
+			DBUS_TYPE_UINT32, &list->bw);
+}
+
+static void append_plmn_history_struct_list(struct Plmnhist *list,
+					DBusMessageIter *arr)
+{
+	DBusMessageIter iter;
+	DBusMessageIter dict;
+
+	dbus_message_iter_open_container(arr, DBUS_TYPE_STRUCT, NULL, &iter);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+					OFONO_PROPERTIES_ARRAY_SIGNATURE,
+					&dict);
+
+	append_plmn_properties(list, &dict);
+
+	dbus_message_iter_close_container(&iter, &dict);
+
+	dbus_message_iter_close_container(arr, &iter);
+}
+
+static void coex_get_plmn_history_cb(gboolean ok, GAtResult *result,
+					gpointer user_data)
+{
+	struct ofono_coex *coex =3D user_data;
+	struct Plmnhist *list =3D NULL;
+	GAtResultIter iter;
+	int list_size =3D 0, count;
+	DBusMessage *reply;
+	DBusMessageIter itr, arr;
+
+	DBG("ok %d", ok);
+
+	if (!ok) {
+		__ofono_dbus_pending_reply(&coex->pending,
+				__ofono_error_failed(coex->pending));
+		return;
+	}
+
+	g_at_result_iter_init(&iter, result);
+
+	while (g_at_result_iter_next(&iter, "+XNVMPLMN:")) {
+		if (!list_size)
+			list =3D g_new0(struct Plmnhist, ++list_size);
+		else
+			list =3D g_renew(struct Plmnhist, list, ++list_size);
+
+		g_at_result_iter_next_number(&iter, (int *)&list[list_size - 1].mcc);
+		g_at_result_iter_next_number(&iter, (int *)&list[list_size - 1].mnc);
+		g_at_result_iter_next_number(&iter, (int *)&list[list_size - 1].fdd);
+		g_at_result_iter_next_number(&iter, (int *)&list[list_size - 1].tdd);
+		g_at_result_iter_next_number(&iter, (int *)&list[list_size - 1].bw);
+
+		DBG("list_size =3D %d", list_size);
+	}
+
+	reply =3D dbus_message_new_method_return(coex->pending);
+	dbus_message_iter_init_append(reply, &itr);
+
+	dbus_message_iter_open_container(&itr, DBUS_TYPE_ARRAY,
+				DBUS_STRUCT_BEGIN_CHAR_AS_STRING
+				DBUS_TYPE_ARRAY_AS_STRING
+				DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+				DBUS_TYPE_STRING_AS_STRING
+				DBUS_TYPE_VARIANT_AS_STRING
+				DBUS_DICT_ENTRY_END_CHAR_AS_STRING
+				DBUS_STRUCT_END_CHAR_AS_STRING,
+				&arr);
+
+	for (count =3D 0; count < list_size; count++)
+		append_plmn_history_struct_list(list, &arr);
+
+	dbus_message_iter_close_container(&itr, &arr);
+
+	reply =3D dbus_message_new_method_return(coex->pending);
+	__ofono_dbus_pending_reply(&coex->pending, reply);
+
+	if (list)
+		g_free(list);
+}
+
+static DBusMessage *coex_get_plmn_history(DBusConnection *conn,
+			DBusMessage *msg, void *data)
+{
+	struct ofono_coex *coex =3D data;
+
+	if (coex->pending)
+		return __ofono_error_busy(msg);
+
+	coex->pending =3D dbus_message_ref(msg);
+
+	if (g_at_chat_send(coex->chat, "AT+XNVMPLMN=3D2,2", xnvmplmn_prefix,
+				coex_get_plmn_history_cb, coex, NULL) > 0)
+		return NULL;
+
+	coex->pending =3D NULL;
+	return __ofono_error_failed(msg);
+}
+
+static const GDBusMethodTable coex_methods[] =3D {
+	{ GDBUS_METHOD("GetProperties",
+			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+			coex_get_properties) },
+	{ GDBUS_METHOD("SetProperty",
+			GDBUS_ARGS({ "property", "s" }, { "value", "v" }),
+			NULL, coex_set_property) },
+	{ GDBUS_METHOD("RegisterAgent",
+			GDBUS_ARGS({ "path", "o" }), NULL,
+			coex_register_agent) },
+	{ GDBUS_METHOD("UnregisterAgent",
+			GDBUS_ARGS({ "path", "o" }), NULL,
+			coex_unregister_agent) },
+	{ GDBUS_ASYNC_METHOD("GetPlmnHistory",
+			NULL, GDBUS_ARGS({ "plmnhistory", "a(a{sv})" }),
+			coex_get_plmn_history) },
+	{ }
+};
+
+static const GDBusSignalTable coex_signals[] =3D {
+	{ GDBUS_SIGNAL("PropertyChanged",
+			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
+	{ }
+};
+
+static void xmm_coex_l_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_coex *coex =3D user_data;
+	GAtResultIter iter;
+	int lte_active;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+XNRTCWSL:"))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &lte_active))
+		return;
+
+	DBG("lte_active:%d", lte_active);
+
+	coex->lte_active =3D lte_active;
+}
+
+static void xmm_coex_w_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_coex *coex =3D user_data;
+	GAtResultIter iter;
+	int count;
+	struct wl_coex_info wlan;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+XNRTCWSW:"))
+		return;
+
+	g_at_result_iter_next_number(&iter, &wlan.safe_rx_min);
+
+	g_at_result_iter_skip_next(&iter);
+
+	g_at_result_iter_skip_next(&iter);
+
+	g_at_result_iter_next_number(&iter, &wlan.safe_rx_max);
+
+	g_at_result_iter_skip_next(&iter);
+
+	g_at_result_iter_skip_next(&iter);
+
+	g_at_result_iter_next_number(&iter, &wlan.safe_tx_min);
+
+	g_at_result_iter_skip_next(&iter);
+
+	g_at_result_iter_skip_next(&iter);
+
+	g_at_result_iter_next_number(&iter, &wlan.safe_tx_max);
+
+	g_at_result_iter_skip_next(&iter);
+
+	g_at_result_iter_skip_next(&iter);
+
+	g_at_result_iter_skip_next(&iter);
+
+	g_at_result_iter_next_number(&iter, &wlan.num_safe_vector);
+
+	for (count =3D 0; count < wlan.num_safe_vector; count++) {
+		g_at_result_iter_next_number(&iter, &wlan.safe_vector[count]);
+	}
+
+	DBG("WLAN notification");
+
+	if (coex->session_agent)
+		coex_agent_coex_wlan_notify(coex->session_agent, wlan);
+}
+
+static void xmm_coex_b_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_coex *coex =3D user_data;
+	GAtResultIter iter;
+	struct bt_coex_info bt;
+	int count;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+XNRTCWSB:"))
+		return;
+
+	g_at_result_iter_next_number(&iter, &bt.safe_rx_min);
+
+	g_at_result_iter_next_number(&iter, &bt.safe_rx_max);
+
+	g_at_result_iter_next_number(&iter, &bt.safe_tx_min);
+
+	g_at_result_iter_next_number(&iter, &bt.safe_tx_max);
+
+	g_at_result_iter_next_number(&iter, &bt.num_safe_vector);
+
+	for (count =3D 0; count < bt.num_safe_vector; count++) {
+		g_at_result_iter_next_number(&iter, &bt.safe_vector[count]);
+	}
+
+	DBG("BT notification");
+
+	if (coex->session_agent)
+		coex_agent_coex_bt_notify(coex->session_agent, bt);
+}
+
+static void xmm_lte_band_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_coex *coex =3D user_data;
+	GAtResultIter iter;
+	int lte_band;
+	char band[BAND_LEN];
+	const char *path =3D ofono_modem_get_path(coex->modem);
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+XCCINFO:"))
+		return;
+
+	g_at_result_iter_skip_next(&iter);
+	g_at_result_iter_skip_next(&iter);
+	g_at_result_iter_skip_next(&iter);
+	g_at_result_iter_skip_next(&iter);
+
+	if (!g_at_result_iter_next_number(&iter, &lte_band))
+		return;
+
+	xmm_get_band_string(lte_band, band);
+	DBG("band %s", band);
+
+	if (!strcmp(band, coex->lte_band))
+		return;
+
+	g_free(coex->lte_band);
+	coex->lte_band =3D g_strdup(band);
+
+	if (coex->lte_band =3D=3D NULL)
+		return;
+
+	ofono_dbus_signal_property_changed(conn, path,
+				OFONO_COEX_INTERFACE,
+				"Band", DBUS_TYPE_STRING, &coex->lte_band);
+
+}
+
+static void coex_cleanup(void *data)
+{
+	struct ofono_coex *coex =3D data;
+
+	if (coex->pending)
+		__ofono_dbus_pending_reply(&coex->pending,
+					__ofono_error_canceled(coex->pending));
+
+	if (coex->session_agent) {
+		coex_agent_free(coex->session_agent);
+
+		g_at_chat_send(coex->chat, "AT+XNRTCWS=3D0", none_prefix,
+					NULL, NULL, NULL);
+	}
+
+	g_free(coex);
+}
+
+static int xmm_coex_enable(struct ofono_modem *modem, void *data)
+{
+	struct ofono_coex *coex;
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D ofono_modem_get_path(modem);
+	coex =3D g_new0(struct ofono_coex, 1);
+
+	DBG("coex enable");
+
+	coex->chat =3D data;
+	coex->modem =3D modem;
+	if (!g_dbus_register_interface(conn, path, OFONO_COEX_INTERFACE,
+					coex_methods,
+					coex_signals,
+					NULL, coex, coex_cleanup)) {
+		ofono_error("Could not register %s interface under %s",
+					OFONO_COEX_INTERFACE, path);
+		g_free(coex);
+		return -EIO;
+	}
+
+	ofono_modem_add_interface(modem, OFONO_COEX_INTERFACE);
+
+	g_at_chat_register(coex->chat, "+XNRTCWSL:", xmm_coex_l_notify,
+					FALSE, NULL, NULL);
+	g_at_chat_register(coex->chat, "+XNRTCWSW:", xmm_coex_w_notify,
+					FALSE, NULL, NULL);
+	g_at_chat_register(coex->chat, "+XNRTCWSB:", xmm_coex_b_notify,
+					FALSE, NULL, NULL);
+	g_at_chat_register(coex->chat, "+XCCINFO:", xmm_lte_band_notify,
+					FALSE, NULL, NULL);
+
+	if (g_at_chat_send(coex->chat, "AT+XCCINFO=3D1", none_prefix,
+				NULL, NULL, NULL) < 0)
+		goto out;
+
+	if (g_at_chat_send(coex->chat, "AT+XNRTAPP=3D10,100", none_prefix,
+				NULL, NULL, NULL) > 0)
+		return 0;
+
+out:
+	g_free(coex);
+	return -EIO;
+}
+
+/* Coex Implementation Ends*/
+
 static void xmm7xxx_debug(const char *str, void *user_data)
 {
 	const char *prefix =3D user_data;
@@ -366,6 +1329,29 @@ static void xmm7xxx_post_online(struct ofono_modem *m=
odem)
 	ofono_netmon_create(modem, 0, "xmm7modem", data->chat);
 }
 =

+static void netreg_watch(struct ofono_atom *atom,
+				enum ofono_atom_watch_condition cond,
+				void *data)
+{
+	struct ofono_modem *modem =3D data;
+	struct xmm7xxx_data *modem_data =3D ofono_modem_get_data(modem);
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D ofono_modem_get_path(modem);
+
+	if (cond =3D=3D OFONO_ATOM_WATCH_CONDITION_UNREGISTERED) {
+		if (g_dbus_unregister_interface(conn, path,
+						OFONO_COEX_INTERFACE))
+			ofono_modem_remove_interface(modem,
+							OFONO_COEX_INTERFACE);
+		return;
+	}
+
+	if (cond =3D=3D OFONO_ATOM_WATCH_CONDITION_REGISTERED) {
+		xmm_coex_enable(modem, modem_data->chat);
+		return;
+	}
+}
+
 static int xmm7xxx_probe(struct ofono_modem *modem)
 {
 	struct xmm7xxx_data *data;
@@ -378,6 +1364,10 @@ static int xmm7xxx_probe(struct ofono_modem *modem)
 =

 	ofono_modem_set_data(modem, data);
 =

+	data->netreg_watch =3D __ofono_modem_add_atom_watch(modem,
+					OFONO_ATOM_TYPE_NETREG,
+					netreg_watch, modem, NULL);
+
 	return 0;
 }
 =

@@ -389,6 +1379,11 @@ static void xmm7xxx_remove(struct ofono_modem *modem)
 =

 	ofono_modem_set_data(modem, NULL);
 =

+	if (data->netreg_watch) {
+		__ofono_modem_remove_atom_watch(modem, data->netreg_watch);
+		data->netreg_watch =3D 0;
+	}
+
 	/* Cleanup after hot-unplug */
 	g_at_chat_unref(data->chat);
 =

-- =

1.9.1


--===============4728043628501095994==--

