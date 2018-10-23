Content-Type: multipart/mixed; boundary="===============6877469165438262168=="
MIME-Version: 1.0
From: Antara Borwankar <antara.borwankar@intel.com>
Subject: [PATCH 1/2] coex: Coex implemnetation for xmm7modem plugin
Date: Tue, 23 Oct 2018 14:26:03 +0530
Message-ID: <1540284963-8316-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6877469165438262168==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Antara <antara.borwankar@intel.com>

Added coex implementation in xmm7modem plugin
---
 Makefile.am       |   3 +-
 doc/coex-api.txt  | 122 +++++++++
 plugins/xmm7xxx.c | 724 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 848 insertions(+), 1 deletion(-)
 create mode 100644 doc/coex-api.txt

diff --git a/Makefile.am b/Makefile.am
index e8e4ed9..578af2f 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -669,7 +669,8 @@ src_ofonod_SOURCES =3D $(builtin_sources) $(gatchat_sou=
rces) src/ofono.ver \
 			src/handsfree-audio.c src/bluetooth.h \
 			src/hfp.h src/siri.c \
 			src/netmon.c src/lte.c src/ims.c \
-			src/netmonagent.c src/netmonagent.h
+			src/netmonagent.c src/netmonagent.h \
+			src/coexagent.c src/coexagent.h
 =

 src_ofonod_LDADD =3D gdbus/libgdbus-internal.la $(builtin_libadd) \
 			@GLIB_LIBS@ @DBUS_LIBS@ -ldl
diff --git a/doc/coex-api.txt b/doc/coex-api.txt
new file mode 100644
index 0000000..12693a4
--- /dev/null
+++ b/doc/coex-api.txt
@@ -0,0 +1,122 @@
+LTE Coexistence hierarchy
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Service		org.ofono
+Interface	org.ofono.IntelLTECoex*
+Object path	[variable prefix]/{modem0,modem1,...}
+
+Methods		dict GetProperties()
+			Returns all coexistence configuration properties.
+
+			void SetProperty(string property, variant value)
+			Changes the value of the specified property. Only properties that are
+			listed as Read-write are changeable.
+			On success a PropertyChanged signal will be emitted.
+
+			Possible Errors: [service].Error.InProgress
+						[service].Error.InvalidArguments
+						[service].Error.Failed
+
+
+		void RegisterAgent(object path)
+
+			Registers an agent which will be called whenever the
+			modem initiates LTE Coexistence information.
+
+			Possible Errors: [service].Error.InProgress
+					 [service].Error.InvalidArguments
+					 [service].Error.InvalidFormat
+					 [service].Error.Failed
+
+		void UnregisterAgent(object path)
+
+			Unregisters an agent.
+
+			Possible Errors: [service].Error.InvalidArguments
+					 [service].Error.Failed
+
+		a(a{sv}) GetPlmnHistory()
+			Requests for LTE Plmn history list stored in NVM to
+			retrieve geo location history like MobileNetworkCode,
+			MobileCountryCode, LteBandsFDD, LteBandsTDD, ChannelBandwidth.
+			*most recently uused
+			*privacy
+
+			Refer to the sections below for which property types
+			are available, their valid value ranges and
+			applicability to different cell types.
+
+Signals		PropertyChanged(string property, variant value)
+			This signal indicates a changed value of the given property.
+
+
+LTECoexistenceAgent Hierarchy [experimental]
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Service		unique name
+Interface	org.ofono.IntelLTECoexAgent
+Object path	freely definable
+
+Methods		void ReceiveBluetoothNotification(array{byte} notification, dict =
info)
+
+			Requests the agent to process BT related LTE Coexistence information
+			The dictionary info contains vector table with modem recommended Safe
+			Tx/Rx band and range information.The properties involved are
+			'SafeTxMin', 'SafeRxMin', 'SafeTxMax', 'SafeRxMax' and 'SafeVector'.
+
+			Possible Errors: None
+
+		void ReceiveWiFiNotification(array{byte} notification, dict info)
+
+			Requests the agent to process WiFi related LTE Coexistence information
+			The dictionary info contains vector table with modem recommended Safe
+			Tx/Rx band and range information. The properties involved are
+			'SafeTxMin', 'SafeRxMin', 'SafeTxMax', 'SafeRxMax' and 'SafeVector'.
+
+			Possible Errors: None
+
+		void Release() [noreply]
+
+			Agent is being released, possibly because of oFono
+			terminating, Coex interface is being torn down or modem
+			off.  No UnregisterAgent call is needed.
+
+
+Properties	string LTEBand [readwrite]
+			Frequency band in which the modem is operating when using "lte" mode.
+
+			boolean CoexBTActive [readwrite]
+			Maintains whether BT Coex is activated or not.
+
+			boolean CoexWLANActive [readwrite]
+			Maintains whether WLAN Coex is activated or not.
+
+			string CoexWLANBandwidth [readwrite]
+			Maintains at what frequency WLAN Coex is activated, when "CoexWLANActiv=
e"
+			is active.
+			The possible values are:
+			- "20MHz"
+			- "40MHz"
+			- "80MHz"
+
+LTE Plmn history params
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
+string
+	uint16 MobileNetworkCode [readonly, optional]
+		Contains the MNC of the cell.
+
+string
+	uint16 MobileCountryCode [readonly, optional]
+		Contains the MCC of the cell.
+
+	uint32 LteBandsFDD [readonly, optional]
+		Contains the Lte FDD band. Valid range
+		of values is 1 to 32 as per 3GPP 36.101 Section 5.5.
+
+	uint32 LteBandsTDD [readonly, optional]
+		Contains the Lte TDD band. Valid range
+		of values is 33 to 64 as per 3GPP 36.101 Section 5.5.
+
+	uint8 ChannelBandwidth [readonly, optional]
+		Contains the Channel bandwidth. Valid range
+		of values is 0 to 6 as per 3GPP 36.101 Section 5.6.
diff --git a/plugins/xmm7xxx.c b/plugins/xmm7xxx.c
index 1223008..381a90a 100644
--- a/plugins/xmm7xxx.c
+++ b/plugins/xmm7xxx.c
@@ -53,12 +53,23 @@
 #include <ofono/sms.h>
 #include <ofono/phonebook.h>
 #include <ofono/netmon.h>
+#include "coexagent.h"
 =

 #include <drivers/atmodem/atutil.h>
 #include <drivers/atmodem/vendor.h>
 =

+#include "ofono.h"
+#include "gdbus.h"
+
+#define OFONO_COEX_INTERFACE OFONO_SERVICE ".LTECoex"
+#define NET_BAND_LTE_INVALID 0
+#define NET_BAND_LTE_1 101
+#define NET_BAND_LTE_43 143
+#define BAND_LEN 20
+
 static const char *none_prefix[] =3D { NULL };
 static const char *xsimstate_prefix[] =3D { "+XSIMSTATE:", NULL };
+static const char *xnvmplmn_prefix[] =3D { "+XNVMPLMN:", NULL };
 =

 struct xmm7xxx_data {
 	GAtChat *chat;		/* AT chat */
@@ -67,6 +78,712 @@ struct xmm7xxx_data {
 	ofono_bool_t sms_phonebook_added;
 };
 =

+/* Coex Implementation */
+enum ofono_wlan_bw {
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
+};
+
+struct ofono_coex {
+	GAtChat *chat;
+	struct ofono_modem *modem;
+
+	DBusMessage *pending;
+	ofono_bool_t bt_active;
+	ofono_bool_t wlan_active;
+	enum ofono_wlan_bw wlan_bw;
+	char* lte_band;
+
+	ofono_bool_t pending_bt_active;
+	ofono_bool_t pending_wlan_active;
+	enum ofono_wlan_bw pending_wlan_bw;
+	ofono_bool_t lte_active;
+
+	struct coex_agent *session_agent;
+};
+
+static gboolean coex_wlan_bw_from_string(const char *str,
+				enum ofono_wlan_bw *band)
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
+void xmm_get_band_string(int lte_band, char* band)
+{
+	int band_lte =3D lte_band-NET_BAND_LTE_1+1;
+	if(lte_band >=3D NET_BAND_LTE_1 && lte_band <=3D NET_BAND_LTE_43)
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
+	ofono_dbus_dict_append(&dict, "CoexBTActive",
+			DBUS_TYPE_BOOLEAN, &value);
+
+	value =3D coex->wlan_active;
+	ofono_dbus_dict_append(&dict, "CoexWLANActive",DBUS_TYPE_BOOLEAN, &value);
+
+	band =3D ofono_wlan_bw_to_string(coex->wlan_bw);
+	ofono_dbus_dict_append(&dict, "CoexWLANBandwidth",DBUS_TYPE_STRING, &band=
);
+
+	band =3D coex->lte_band;
+	ofono_dbus_dict_append(&dict, "LTEBand",DBUS_TYPE_STRING, &band);
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
+						"CoexBTActive",
+						DBUS_TYPE_BOOLEAN,
+						&(coex->bt_active));
+	}
+
+	if (coex->wlan_active !=3D coex->wlan_active) {
+		coex->wlan_active =3D coex->wlan_active;
+		ofono_dbus_signal_property_changed(conn, path,
+						OFONO_COEX_INTERFACE,
+						"CoexWLANActive",
+						DBUS_TYPE_BOOLEAN,
+						&(coex->wlan_active));
+	}
+
+	if (coex->wlan_bw !=3D coex->pending_wlan_bw) {
+		const char* str_band =3D ofono_wlan_bw_to_string(coex->wlan_bw);
+		coex->wlan_bw =3D coex->pending_wlan_bw;
+
+		ofono_dbus_signal_property_changed(conn, path,
+						OFONO_COEX_INTERFACE,
+						"CoexWLANBandwidth",
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
+					wlan_bw,bt_active);
+	if(g_at_chat_send(coex->chat, buf, none_prefix,
+				coex_set_params_cb, coex, NULL) > 0) {
+		return;
+	}
+
+	coex->pending_bt_active =3D coex->bt_active;
+	coex->pending_wlan_active =3D coex->wlan_active;
+	coex->pending_wlan_bw =3D coex->wlan_bw;
+	reply =3D __ofono_error_failed(coex->pending);
+	__ofono_dbus_pending_reply(&coex->pending, reply);
+	=

+	return;
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
+	if (!strcmp(property, "CoexBTActive")) {
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
+	} else if (!strcmp(property, "CoexWLANActive")) {
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
+	} else if (g_strcmp0(property, "CoexWLANBandwidth") =3D=3D 0) {
+		const char *value;
+		enum ofono_wlan_bw band;
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
+	coex->session_agent =3D NULL;
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
+				coex_register_agent_cb, coex, NULL) >0) {
+		coex->pending =3D dbus_message_ref(msg);
+		return NULL;
+	}
+
+	return __ofono_error_failed(msg);
+}
+
+static void coex_unregister_agent_cb(gboolean ok, GAtResult *result,
+					gpointer user_data)
+{
+	struct ofono_coex *coex =3D user_data;
+	DBusMessage *reply;
+
+	if (!ok) {
+		reply =3D __ofono_error_failed(coex->pending);
+		__ofono_dbus_pending_reply(&coex->pending, reply);
+		return;
+	}
+
+	reply =3D dbus_message_new_method_return(coex->pending);
+	__ofono_dbus_pending_reply(&coex->pending, reply);
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
+	if(g_at_chat_send(coex->chat, "AT+XNRTCWS=3D0", none_prefix,
+				coex_unregister_agent_cb, coex, NULL) > 0) {
+		coex->pending =3D dbus_message_ref(msg);
+		return NULL;
+	}
+
+	return __ofono_error_failed(msg);
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
+		g_at_result_iter_next_number(&iter, (int*)&list[list_size - 1].mcc);
+		g_at_result_iter_next_number(&iter, (int*)&list[list_size - 1].mnc);
+		g_at_result_iter_next_number(&iter, (int*)&list[list_size - 1].fdd);
+		g_at_result_iter_next_number(&iter, (int*)&list[list_size - 1].tdd);
+		g_at_result_iter_next_number(&iter, (int*)&list[list_size - 1].bw);
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
+	for(count=3D0; count<list_size; count++)
+		append_plmn_history_struct_list(list,&arr);
+
+	dbus_message_iter_close_container(&itr, &arr);
+
+	reply =3D dbus_message_new_method_return(coex->pending);
+	__ofono_dbus_pending_reply(&coex->pending, reply);
+
+	if(list)
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
+	if(g_at_chat_send(coex->chat, "AT+XNVMPLMN=3D2,2", xnvmplmn_prefix,
+				coex_get_plmn_history_cb, coex, NULL) > 0)
+		return NULL;
+
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
+	for(count =3D 0; count < wlan.num_safe_vector; count++) {
+		g_at_result_iter_next_number(&iter, &wlan.safe_vector[count]);
+	}
+
+	DBG("WLAN notification");
+
+	if (coex->session_agent)
+		coex_agent_coex_wlan_notify(coex->session_agent, wlan,
+							FALSE, NULL, NULL);
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
+	for(count =3D 0; count < bt.num_safe_vector; count++) {
+		g_at_result_iter_next_number(&iter, &bt.safe_vector[count]);
+	}
+
+	DBG("BT notification");
+
+	if (coex->session_agent)
+		coex_agent_coex_bt_notify(coex->session_agent, bt,
+							FALSE, NULL, NULL);
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
+	if(!strcmp(band, coex->lte_band))
+		return;
+
+	g_free(coex->lte_band);
+	coex->lte_band =3D g_strdup(band);
+
+	if(coex->lte_band =3D=3D NULL)
+		return;
+
+	ofono_dbus_signal_property_changed(conn, path,
+				OFONO_COEX_INTERFACE,
+				"LTEBand", DBUS_TYPE_STRING, &coex->lte_band);
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
+	if(g_at_chat_send(coex->chat, "AT+XNRTAPP=3D10,100", none_prefix,
+				NULL, NULL, NULL) > 0)
+		return 0;
+
+out:
+	return -EIO;
+}
+
+/* Coex Implementation Ends*/
+
 static void xmm7xxx_debug(const char *str, void *user_data)
 {
 	const char *prefix =3D user_data;
@@ -336,6 +1053,7 @@ static void xmm7xxx_post_sim(struct ofono_modem *modem)
 	ofono_lte_create(modem, 0, "atmodem", data->chat);
 	ofono_radio_settings_create(modem, 0, "xmm7modem", data->chat);
 	ofono_sim_auth_create(modem);
+	xmm_coex_enable(modem, data->chat);
 }
 =

 static void xmm7xxx_post_online(struct ofono_modem *modem)
@@ -378,8 +1096,14 @@ static int xmm7xxx_probe(struct ofono_modem *modem)
 static void xmm7xxx_remove(struct ofono_modem *modem)
 {
 	struct xmm7xxx_data *data =3D ofono_modem_get_data(modem);
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D ofono_modem_get_path(modem);
 =

 	DBG("%p", modem);
+	if (g_dbus_unregister_interface(conn, path,
+					OFONO_COEX_INTERFACE))
+		ofono_modem_remove_interface(modem,
+						OFONO_COEX_INTERFACE);
 =

 	ofono_modem_set_data(modem, NULL);
 =

-- =

1.9.1


--===============6877469165438262168==--

