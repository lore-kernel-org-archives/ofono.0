Content-Type: multipart/mixed; boundary="===============3278379200468907221=="
MIME-Version: 1.0
From: Antara Borwankar <antara.borwankar@intel.com>
Subject: [PATCH 3/4] netmon: adding get functionality for neighbouring cell
 information
Date: Thu, 30 May 2019 14:52:21 +0530
Message-ID: <1559208141-3588-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3278379200468907221==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Handled the get neighbouring cell information function which returns
an array of signal strength of all neighbouring cells.
---
 src/netmon.c | 136 +++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 136 insertions(+)

diff --git a/src/netmon.c b/src/netmon.c
index 6c19df5..5896089 100644
--- a/src/netmon.c
+++ b/src/netmon.c
@@ -403,6 +403,139 @@ static DBusMessage *netmon_unregister_agent(DBusConne=
ction *conn,
 	return dbus_message_new_method_return(msg);
 }
 =

+
+void ofono_netmon_neighbouring_cell_notify(struct ofono_netmon *netmon,
+					void *cell_list)
+{
+	DBusMessageIter iter;
+	DBusMessageIter arr;
+	GSList *l;
+
+	if (netmon->pending =3D=3D NULL)
+		return;
+
+	netmon->reply =3D dbus_message_new_method_return(netmon->pending);
+	dbus_message_iter_init_append(netmon->reply, &iter);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+					DBUS_STRUCT_BEGIN_CHAR_AS_STRING
+					DBUS_TYPE_ARRAY_AS_STRING
+					DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+					DBUS_TYPE_STRING_AS_STRING
+					DBUS_TYPE_VARIANT_AS_STRING
+					DBUS_DICT_ENTRY_END_CHAR_AS_STRING
+					DBUS_STRUCT_END_CHAR_AS_STRING,
+					&arr);
+
+	for (l =3D cell_list; l; l =3D l->next) {
+		DBusMessageIter dict;
+		DBusMessageIter strct;
+		struct ofono_netmon_neighbouring_cell *cell =3D l->data;
+		const char *tech =3D cell_type_to_tech_name(cell->cell_type);
+
+		dbus_message_iter_open_container(&arr, DBUS_TYPE_STRUCT,
+					NULL, &strct);
+		dbus_message_iter_open_container(&strct, DBUS_TYPE_ARRAY,
+					OFONO_PROPERTIES_ARRAY_SIGNATURE,
+					&dict);
+
+		ofono_dbus_dict_append(&dict, "Technology",
+					DBUS_TYPE_STRING, &tech);
+		ofono_dbus_dict_append(&dict, "MobileCountryCode",
+					DBUS_TYPE_UINT16, &cell->mcc);
+		ofono_dbus_dict_append(&dict, "MobileNetworkCode",
+					DBUS_TYPE_UINT16, &cell->mnc);
+		ofono_dbus_dict_append(&dict, "CellId",
+					DBUS_TYPE_UINT16, &cell->cell_id);
+
+		switch (cell->cell_type) {
+		case OFONO_NETMON_CELL_TYPE_GSM:
+			ofono_dbus_dict_append(&dict,
+					"Strength",
+					DBUS_TYPE_UINT16,
+					&cell->cell_meas.gsm.rssi);
+			ofono_dbus_dict_append(&dict,
+					"BitErrorRate",
+					DBUS_TYPE_UINT16,
+					&cell->cell_meas.gsm.ber);
+			break;
+
+		case OFONO_NETMON_CELL_TYPE_UMTS:
+			ofono_dbus_dict_append(&dict,
+					"ReceivedSignalCodePower",
+					DBUS_TYPE_UINT16,
+					&cell->cell_meas.umts.rscp);
+			ofono_dbus_dict_append(&dict,
+					"ReceivedEnergyRatio",
+					DBUS_TYPE_UINT16,
+					&cell->cell_meas.umts.ecno);
+			break;
+
+		case OFONO_NETMON_CELL_TYPE_LTE:
+			ofono_dbus_dict_append(&dict,
+					"ReferenceSignalReceivedQuality",
+					DBUS_TYPE_UINT16,
+					&cell->cell_meas.lte.rsrq);
+			ofono_dbus_dict_append(&dict,
+					"ReferenceSignalReceivedPower",
+					DBUS_TYPE_UINT16,
+					&cell->cell_meas.lte.rsrp);
+			break;
+		}
+
+		dbus_message_iter_close_container(&strct, &dict);
+		dbus_message_iter_close_container(&arr, &strct);
+	}
+
+	dbus_message_iter_close_container(&iter, &arr);
+}
+
+static void neighbouring_cell_info_callback(const struct ofono_error *erro=
r,
+		void *data)
+{
+	struct ofono_netmon *netmon =3D data;
+	DBusMessage *reply =3D netmon->reply;
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
@@ -413,6 +546,9 @@ static const GDBusMethodTable netmon_methods[] =3D {
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


--===============3278379200468907221==--

