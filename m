Content-Type: multipart/mixed; boundary="===============8325749496448013998=="
MIME-Version: 1.0
From: Antara Borwankar <antara.borwankar@intel.com>
Subject: [PATCH] netmon: adding get functionality for neighbouring cell
 information
Date: Fri, 07 Jun 2019 11:17:29 +0530
Message-ID: <1559886449-5853-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8325749496448013998==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Handled the get neighbouring cell information function which returns
an array of signal strength of all neighbouring cells.
---
 src/netmon.c | 258 +++++++++++++++++++++++++++++++++++++++++++------------=
----
 1 file changed, 188 insertions(+), 70 deletions(-)

diff --git a/src/netmon.c b/src/netmon.c
index 6c19df5..4596450 100644
--- a/src/netmon.c
+++ b/src/netmon.c
@@ -50,6 +50,8 @@ struct ofono_netmon {
 	const struct ofono_netmon_driver *driver;
 	DBusMessage *pending;
 	DBusMessage *reply;
+	DBusMessageIter iter;
+	DBusMessageIter arr;
 	void *driver_data;
 	struct ofono_atom *atom;
 	struct netmon_agent *agent;
@@ -69,174 +71,148 @@ static const char *cell_type_to_tech_name(enum ofono_=
netmon_cell_type type)
 	return NULL;
 }
 =

-void ofono_netmon_serving_cell_notify(struct ofono_netmon *netmon,
-					enum ofono_netmon_cell_type type,
-					int info_type, ...)
+static void netmon_cell_info_dict_append(DBusMessageIter *dict,
+					va_list *arglist, int info_type)
 {
-	va_list arglist;
-	DBusMessage *agent_notify =3D NULL;
-	DBusMessageIter iter;
-	DBusMessageIter dict;
-	enum ofono_netmon_info next_info_type =3D info_type;
-	const char *technology =3D cell_type_to_tech_name(type);
 	char *mcc;
 	char *mnc;
+	char *cell_id;
 	int intval;
-
-	if (netmon->pending !=3D NULL) {
-		netmon->reply =3D dbus_message_new_method_return(netmon->pending);
-		dbus_message_iter_init_append(netmon->reply, &iter);
-	} else if (netmon->agent !=3D NULL) {
-		agent_notify =3D netmon_agent_new_method_call(netmon->agent,
-					"ServingCellInformationChanged");
-
-		dbus_message_iter_init_append(agent_notify, &iter);
-	} else
-		return;
-
-	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
-					OFONO_PROPERTIES_ARRAY_SIGNATURE,
-					&dict);
-
-	va_start(arglist, info_type);
-
-	if (technology =3D=3D NULL)
-		goto done;
-
-	ofono_dbus_dict_append(&dict, "Technology",
-						DBUS_TYPE_STRING, &technology);
+	enum ofono_netmon_info next_info_type =3D info_type;
 =

 	while (next_info_type !=3D OFONO_NETMON_INFO_INVALID) {
 		switch (next_info_type) {
 		case OFONO_NETMON_INFO_MCC:
-			mcc =3D va_arg(arglist, char *);
+			mcc =3D va_arg(*arglist, char *);
 =

 			if (mcc && strlen(mcc))
-				ofono_dbus_dict_append(&dict,
+				ofono_dbus_dict_append(dict,
 						"MobileCountryCode",
 						DBUS_TYPE_STRING, &mcc);
 			break;
 =

 		case OFONO_NETMON_INFO_MNC:
-			mnc =3D va_arg(arglist, char *);
+			mnc =3D va_arg(*arglist, char *);
 =

 			if (mnc && strlen(mnc))
-				ofono_dbus_dict_append(&dict,
+				ofono_dbus_dict_append(dict,
 						"MobileNetworkCode",
 						DBUS_TYPE_STRING, &mnc);
 			break;
 =

 		case OFONO_NETMON_INFO_LAC:
-			intval =3D va_arg(arglist, int);
+			intval =3D va_arg(*arglist, int);
 =

-			CELL_INFO_DICT_APPEND(&dict, "LocationAreaCode",
+			CELL_INFO_DICT_APPEND(dict, "LocationAreaCode",
 					intval, uint16_t, DBUS_TYPE_UINT16);
 			break;
 =

 		case OFONO_NETMON_INFO_CI:
-			intval =3D va_arg(arglist, int);
+			cell_id =3D va_arg(*arglist, char *);
 =

-			CELL_INFO_DICT_APPEND(&dict, "CellId",
-					intval, uint32_t, DBUS_TYPE_UINT32);
+			if (cell_id && strlen(cell_id))
+					ofono_dbus_dict_append(dict,
+					"CellId",
+					DBUS_TYPE_STRING, &cell_id);
 			break;
 =

 		case OFONO_NETMON_INFO_ARFCN:
-			intval =3D va_arg(arglist, int);
+			intval =3D va_arg(*arglist, int);
 =

-			CELL_INFO_DICT_APPEND(&dict, "ARFCN",
+			CELL_INFO_DICT_APPEND(dict, "ARFCN",
 					intval, uint16_t, DBUS_TYPE_UINT16);
 			break;
 =

 		case OFONO_NETMON_INFO_BSIC:
-			intval =3D va_arg(arglist, int);
+				intval =3D va_arg(*arglist, int);
 =

-			CELL_INFO_DICT_APPEND(&dict, "BSIC",
+			CELL_INFO_DICT_APPEND(dict, "BSIC",
 					intval, uint8_t, DBUS_TYPE_BYTE);
 			break;
 =

 		case OFONO_NETMON_INFO_RXLEV:
-			intval =3D va_arg(arglist, int);
+				intval =3D va_arg(*arglist, int);
 =

-			CELL_INFO_DICT_APPEND(&dict, "ReceivedSignalStrength",
+			CELL_INFO_DICT_APPEND(dict, "ReceivedSignalStrength",
 					intval, uint8_t, DBUS_TYPE_BYTE);
 			break;
 =

 		case OFONO_NETMON_INFO_TIMING_ADVANCE:
-			intval =3D va_arg(arglist, int);
+			intval =3D va_arg(*arglist, int);
 =

-			CELL_INFO_DICT_APPEND(&dict, "TimingAdvance",
+			CELL_INFO_DICT_APPEND(dict, "TimingAdvance",
 					intval, uint8_t, DBUS_TYPE_BYTE);
 			break;
 =

 		case OFONO_NETMON_INFO_PSC:
-			intval =3D va_arg(arglist, int);
+			intval =3D va_arg(*arglist, int);
 =

-			CELL_INFO_DICT_APPEND(&dict, "PrimaryScramblingCode",
+			CELL_INFO_DICT_APPEND(dict, "PrimaryScramblingCode",
 					intval, uint16_t, DBUS_TYPE_UINT16);
 			break;
 =

 		case OFONO_NETMON_INFO_BER:
-			intval =3D va_arg(arglist, int);
+			intval =3D va_arg(*arglist, int);
 =

-			CELL_INFO_DICT_APPEND(&dict, "BitErrorRate",
+			CELL_INFO_DICT_APPEND(dict, "BitErrorRate",
 					intval, uint8_t, DBUS_TYPE_BYTE);
 			break;
 =

 		case OFONO_NETMON_INFO_RSSI:
-			intval =3D va_arg(arglist, int);
+			intval =3D va_arg(*arglist, int);
 =

-			CELL_INFO_DICT_APPEND(&dict, "Strength",
+			CELL_INFO_DICT_APPEND(dict, "Strength",
 					intval, uint8_t, DBUS_TYPE_BYTE);
 			break;
 =

 		case OFONO_NETMON_INFO_RSCP:
-			intval =3D va_arg(arglist, int);
+			intval =3D va_arg(*arglist, int);
 =

-			CELL_INFO_DICT_APPEND(&dict, "ReceivedSignalCodePower",
+			CELL_INFO_DICT_APPEND(dict, "ReceivedSignalCodePower",
 					intval, uint8_t, DBUS_TYPE_BYTE);
 			break;
 =

 		case OFONO_NETMON_INFO_ECN0:
-			intval =3D va_arg(arglist, int);
+			intval =3D va_arg(*arglist, int);
 =

-			CELL_INFO_DICT_APPEND(&dict, "ReceivedEnergyRatio",
+			CELL_INFO_DICT_APPEND(dict, "ReceivedEnergyRatio",
 					intval, uint8_t, DBUS_TYPE_BYTE);
 			break;
 =

 		case OFONO_NETMON_INFO_RSRQ:
-			intval =3D va_arg(arglist, int);
+			intval =3D va_arg(*arglist, int);
 =

-			CELL_INFO_DICT_APPEND(&dict,
+			CELL_INFO_DICT_APPEND(dict,
 					"ReferenceSignalReceivedQuality",
 					intval, uint8_t, DBUS_TYPE_BYTE);
 			break;
 =

 		case OFONO_NETMON_INFO_RSRP:
-			intval =3D va_arg(arglist, int);
+			intval =3D va_arg(*arglist, int);
 =

-			CELL_INFO_DICT_APPEND(&dict,
+			CELL_INFO_DICT_APPEND(dict,
 					"ReferenceSignalReceivedPower",
 					intval, uint8_t, DBUS_TYPE_BYTE);
 			break;
 =

 		case OFONO_NETMON_INFO_EARFCN:
-			intval =3D va_arg(arglist, int);
+			intval =3D va_arg(*arglist, int);
 =

-			CELL_INFO_DICT_APPEND(&dict, "EARFCN",
+			CELL_INFO_DICT_APPEND(dict, "EARFCN",
 					intval, uint16_t, DBUS_TYPE_UINT16);
 			break;
 =

 		case OFONO_NETMON_INFO_EBAND:
-			intval =3D va_arg(arglist, int);
+			intval =3D va_arg(*arglist, int);
 =

-			CELL_INFO_DICT_APPEND(&dict, "EBand",
+			CELL_INFO_DICT_APPEND(dict, "EBand",
 					intval, uint8_t, DBUS_TYPE_BYTE);
 			break;
 =

 		case OFONO_NETMON_INFO_CQI:
-			intval =3D va_arg(arglist, int);
+			intval =3D va_arg(*arglist, int);
 =

-			CELL_INFO_DICT_APPEND(&dict, "ChannelQualityIndicator",
+			CELL_INFO_DICT_APPEND(dict, "ChannelQualityIndicator",
 					intval, uint8_t, DBUS_TYPE_BYTE);
 			break;
 =

@@ -244,8 +220,44 @@ void ofono_netmon_serving_cell_notify(struct ofono_net=
mon *netmon,
 			break;
 		}
 =

-		next_info_type =3D va_arg(arglist, int);
+		next_info_type =3D va_arg(*arglist, int);
 	}
+}
+
+void ofono_netmon_serving_cell_notify(struct ofono_netmon *netmon,
+					enum ofono_netmon_cell_type type,
+					int info_type, ...)
+{
+	va_list arglist;
+	DBusMessage *agent_notify =3D NULL;
+	DBusMessageIter iter;
+	DBusMessageIter dict;
+	const char *technology =3D cell_type_to_tech_name(type);
+
+	if (netmon->pending !=3D NULL) {
+		netmon->reply =3D dbus_message_new_method_return(netmon->pending);
+		dbus_message_iter_init_append(netmon->reply, &iter);
+	} else if (netmon->agent !=3D NULL) {
+		agent_notify =3D netmon_agent_new_method_call(netmon->agent,
+					"ServingCellInformationChanged");
+
+		dbus_message_iter_init_append(agent_notify, &iter);
+	} else
+		return;
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+					OFONO_PROPERTIES_ARRAY_SIGNATURE,
+					&dict);
+
+	va_start(arglist, info_type);
+
+	if (technology =3D=3D NULL)
+		goto done;
+
+	ofono_dbus_dict_append(&dict, "Technology",
+						DBUS_TYPE_STRING, &technology);
+
+	netmon_cell_info_dict_append(&dict, &arglist, info_type);
 =

 done:
 	va_end(arglist);
@@ -403,6 +415,109 @@ static DBusMessage *netmon_unregister_agent(DBusConne=
ction *conn,
 	return dbus_message_new_method_return(msg);
 }
 =

+
+void ofono_netmon_neighbouring_cell_notify(struct ofono_netmon *netmon,
+					enum ofono_netmon_cell_type type,
+					int info_type, ...)
+{
+	va_list arglist;
+	DBusMessageIter dict;
+	DBusMessageIter strct;
+	const char *tech =3D cell_type_to_tech_name(type);
+
+	if (netmon->pending =3D=3D NULL)
+		return;
+
+	if (!netmon->reply) {
+		netmon->reply =3D dbus_message_new_method_return(netmon->pending);
+		dbus_message_iter_init_append(netmon->reply, &netmon->iter);
+
+		dbus_message_iter_open_container(&netmon->iter, DBUS_TYPE_ARRAY,
+					DBUS_STRUCT_BEGIN_CHAR_AS_STRING
+					DBUS_TYPE_ARRAY_AS_STRING
+					DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+					DBUS_TYPE_STRING_AS_STRING
+					DBUS_TYPE_VARIANT_AS_STRING
+					DBUS_DICT_ENTRY_END_CHAR_AS_STRING
+					DBUS_STRUCT_END_CHAR_AS_STRING,
+					&netmon->arr);
+	}
+
+	tech =3D cell_type_to_tech_name(type);
+
+	dbus_message_iter_open_container(&netmon->arr, DBUS_TYPE_STRUCT,
+						NULL, &strct);
+	dbus_message_iter_open_container(&strct, DBUS_TYPE_ARRAY,
+					OFONO_PROPERTIES_ARRAY_SIGNATURE,
+					&dict);
+
+	va_start(arglist, info_type);
+
+	if (tech =3D=3D NULL)
+		goto done;
+
+	ofono_dbus_dict_append(&dict, "Technology",
+					DBUS_TYPE_STRING, &tech);
+
+	netmon_cell_info_dict_append(&dict, &arglist, info_type);
+
+done:
+	va_end(arglist);
+
+	dbus_message_iter_close_container(&strct, &dict);
+	dbus_message_iter_close_container(&netmon->arr, &strct);
+}
+
+static void neighbouring_cell_info_callback(const struct ofono_error *erro=
r,
+		void *data)
+{
+	struct ofono_netmon *netmon =3D data;
+	DBusMessage *reply =3D netmon->reply;
+
+	DBG("");
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		if (reply)
+			dbus_message_unref(reply);
+
+		reply =3D __ofono_error_failed(netmon->pending);
+        } else if (!reply) {
+		DBusMessageIter iter;
+		DBusMessageIter dict;
+
+		reply =3D dbus_message_new_method_return(netmon->pending);
+		dbus_message_iter_init_append(reply, &iter);
+		dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+					OFONO_PROPERTIES_ARRAY_SIGNATURE,
+					&dict);
+		dbus_message_iter_close_container(&iter, &dict);
+	} else {
+		dbus_message_iter_close_container(&netmon->iter, &netmon->arr);
+	}
+
+	netmon->reply =3D NULL;
+	__ofono_dbus_pending_reply(&netmon->pending, reply);
+}
+
+static DBusMessage *netmon_get_neighbouring_cell_info(DBusConnection *conn,
+			DBusMessage *msg, void *data)
+{
+	struct ofono_netmon *netmon =3D data;
+
+	if (!netmon->driver->neighbouring_cell_update)
+		return __ofono_error_not_implemented(msg);
+
+	if (netmon->pending)
+		return __ofono_error_busy(msg);
+
+	netmon->pending =3D dbus_message_ref(msg);
+
+	netmon->driver->neighbouring_cell_update(netmon,
+				neighbouring_cell_info_callback, netmon);
+
+	return NULL;
+}
+
 static const GDBusMethodTable netmon_methods[] =3D {
 	{ GDBUS_ASYNC_METHOD("GetServingCellInformation",
 			NULL, GDBUS_ARGS({ "cellinfo", "a{sv}" }),
@@ -413,6 +528,9 @@ static const GDBusMethodTable netmon_methods[] =3D {
 	{ GDBUS_METHOD("UnregisterAgent",
 			GDBUS_ARGS({ "agent", "o" }), NULL,
 			netmon_unregister_agent) },
+	{ GDBUS_ASYNC_METHOD("GetNeighbouringCellInformation",
+			NULL, GDBUS_ARGS({ "cellinfo", "a(a{sv})" }),
+			netmon_get_neighbouring_cell_info) },
 	{ }
 };
 =

-- =

1.9.1


--===============8325749496448013998==--

