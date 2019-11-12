Content-Type: multipart/mixed; boundary="===============1868714595042271672=="
MIME-Version: 1.0
From: Antara Borwankar <antara.borwankar@intel.com>
Subject: [PATCH] xmm7xxx: Introduce eUICC related changes for Gemalto's LPA
Date: Tue, 12 Nov 2019 19:59:38 +0530
Message-ID: <1573568978-12011-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1868714595042271672==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

xmm7xxx modem plugin will support Gemalto's eUICC LPA functionality,
which includes opening a logical channel to ISDR applet in eUICC and
transmitting APDU command for Profile Download, Profile Activate etc.
from LPA to the eUICC and deliver the response from eUICC to LPA.
---
 plugins/xmm7xxx.c | 313 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 313 insertions(+)

diff --git a/plugins/xmm7xxx.c b/plugins/xmm7xxx.c
index a544798..cb0a587 100644
--- a/plugins/xmm7xxx.c
+++ b/plugins/xmm7xxx.c
@@ -62,6 +62,7 @@
 =

 #define OFONO_COEX_INTERFACE OFONO_SERVICE ".intel.LteCoexistence"
 #define OFONO_COEX_AGENT_INTERFACE OFONO_SERVICE ".intel.LteCoexistenceAge=
nt"
+#define OFONO_EUICC_LPA_INTERFACE OFONO_SERVICE ".intel.EuiccLpa"
 =

 #define NET_BAND_LTE_INVALID 0
 #define NET_BAND_LTE_1 101
@@ -73,6 +74,8 @@
 static const char *none_prefix[] =3D { NULL };
 static const char *xsimstate_prefix[] =3D { "+XSIMSTATE:", NULL };
 static const char *xnvmplmn_prefix[] =3D { "+XNVMPLMN:", NULL };
+static const char *ccho_prefix[] =3D { "+CCHO:", NULL };
+static const char *cgla_prefix[] =3D { "+CGLA:", NULL };
 =

 struct bt_coex_info {
 	int safe_tx_min;
@@ -110,6 +113,312 @@ struct xmm7xxx_data {
 	unsigned int netreg_watch;
 };
 =

+/* eUICC Implementation */
+#define EUICC_EID_CMD "80e2910006BF3E035C015A00"
+#define EUICC_ISDR_AID "A0000005591010FFFFFFFF8900000100"
+
+struct xmm7xxx_euicc {
+	GAtChat *chat;
+	struct ofono_modem *modem;
+
+	char *eid;
+	int channel;
+	char *command;
+	int length;
+	DBusMessage *pending;
+	ofono_bool_t is_registered;
+};
+
+static void euicc_cleanup(void *data)
+{
+	struct xmm7xxx_euicc *euicc =3D data;
+
+	g_free(euicc->command);
+	g_free(euicc->eid);
+	g_free(euicc->pending);
+	g_free(euicc);
+}
+
+static void euicc_release_isdr(struct xmm7xxx_euicc *euicc)
+{
+	char buff[20];
+
+	snprintf(buff, sizeof(buff), "AT+CCHC=3D%u", euicc->channel);
+
+	g_at_chat_send(euicc->chat, buff, none_prefix, NULL, NULL, NULL);
+
+	euicc->channel =3D -1;
+	g_free(euicc->command);
+	euicc->command =3D NULL;
+}
+
+static void euicc_pending_reply(struct xmm7xxx_euicc *euicc,
+							const char *resp)
+{
+	DBusMessage *reply;
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+
+	reply =3D dbus_message_new_method_return(euicc->pending);
+	if (reply =3D=3D NULL)
+		return;
+
+	dbus_message_append_args(reply, DBUS_TYPE_STRING, &resp,
+						DBUS_TYPE_INVALID);
+
+	dbus_connection_flush(conn);
+
+	if (dbus_connection_send(conn, reply, NULL) =3D=3D FALSE)
+		return;
+
+	dbus_message_unref(reply);
+	dbus_message_unref(euicc->pending);
+	euicc->pending =3D NULL;
+}
+
+static DBusMessage *euicc_get_properties(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	struct xmm7xxx_euicc *euicc =3D data;
+	DBusMessage *reply;
+	DBusMessageIter iter;
+	DBusMessageIter dict;
+	const char *eid =3D NULL;
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
+	eid =3D euicc->eid;
+	ofono_dbus_dict_append(&dict, "EID", DBUS_TYPE_STRING, &eid);
+
+	dbus_message_iter_close_container(&iter, &dict);
+
+	return reply;
+}
+
+static DBusMessage *euicc_transmit_pdu(DBusConnection *conn,
+					DBusMessage *msg, void *data);
+
+static const GDBusMethodTable euicc_methods[] =3D {
+	{ GDBUS_ASYNC_METHOD("TransmitLpaApdu",
+			GDBUS_ARGS({ "length", "i" }, { "pdu", "s" }),
+			GDBUS_ARGS({ "pdu", "s" }),
+			euicc_transmit_pdu) },
+	{ GDBUS_ASYNC_METHOD("GetProperties",
+			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+			euicc_get_properties) },
+	{ }
+};
+
+static const GDBusSignalTable euicc_signals[] =3D {
+	{ GDBUS_SIGNAL("PropertyChanged",
+			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
+	{ }
+};
+
+static void euicc_register(struct xmm7xxx_euicc *euicc)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D ofono_modem_get_path(euicc->modem);
+
+	DBG("");
+	if (!g_dbus_register_interface(conn, path, OFONO_EUICC_LPA_INTERFACE,
+					euicc_methods,
+					euicc_signals,
+					NULL, euicc, euicc_cleanup)) {
+		ofono_error("Could not register %s interface under %s",
+					OFONO_EUICC_LPA_INTERFACE, path);
+		return;
+	}
+
+	ofono_modem_add_interface(euicc->modem, OFONO_EUICC_LPA_INTERFACE);
+
+	euicc->is_registered =3D TRUE;
+
+	ofono_dbus_signal_property_changed(conn, path,
+			OFONO_EUICC_LPA_INTERFACE, "EID",
+			DBUS_TYPE_STRING, &euicc->eid);
+}
+
+static void euicc_send_cmd_cb(gboolean ok, GAtResult *result,
+					gpointer user_data)
+{
+	struct xmm7xxx_euicc *euicc =3D user_data;
+	GAtResultIter iter;
+	int length;
+	const char *resp;
+
+	DBG("ok %d", ok);
+
+	euicc_release_isdr(euicc);
+
+	if (!ok) {
+		g_free(euicc->command);
+
+		if (!euicc->is_registered) {
+			g_free(euicc->eid);
+			g_free(euicc);
+		}
+
+		return;
+	}
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CGLA:"))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &length))
+		return;
+
+	if (!g_at_result_iter_next_string(&iter, &resp))
+		return;
+
+	if (!euicc->is_registered) {
+		g_free(euicc->eid);
+		euicc->eid =3D g_strdup(resp+10);
+
+		/* eid is present register interface*/
+		euicc_register(euicc);
+	}
+
+	if (euicc->pending)
+		euicc_pending_reply(euicc, resp);
+}
+
+static int euicc_send_cmd(struct xmm7xxx_euicc *euicc)
+{
+	char buff[100];
+
+	snprintf(buff, sizeof(buff), "AT+CGLA=3D%u,%u,\"%s\"",
+		euicc->channel, euicc->length, euicc->command);
+
+	if (g_at_chat_send(euicc->chat, buff, cgla_prefix,
+			euicc_send_cmd_cb, euicc, NULL))
+		return 0;
+
+	return -1;
+}
+
+static void euicc_select_isdr_cb(gboolean ok, GAtResult *result,
+					gpointer user_data)
+{
+	struct xmm7xxx_euicc *euicc =3D user_data;
+	GAtResultIter iter;
+
+	DBG("ok %d", ok);
+
+	if (!ok) {
+		g_free (euicc->command);
+
+		if (!euicc->is_registered) {
+			g_free(euicc->eid);
+			g_free(euicc);
+		}
+
+		return;
+	}
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CCHO:"))
+		return;
+
+	g_at_result_iter_next_number(&iter, &euicc->channel);
+
+	euicc_send_cmd(euicc);
+}
+
+static void euicc_select_isdr(struct xmm7xxx_euicc *euicc)
+{
+	char buff[50];
+
+	snprintf(buff, sizeof(buff), "AT+CCHO=3D\"%s\"", EUICC_ISDR_AID);
+
+	g_at_chat_send(euicc->chat, buff, ccho_prefix,
+			euicc_select_isdr_cb, euicc, NULL);
+}
+
+static DBusMessage *euicc_transmit_pdu(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	struct xmm7xxx_euicc *euicc =3D data;
+	DBusMessageIter iter;
+	DBusMessageIter var;
+	const char *command;
+
+	DBG("");
+	if (euicc->pending)
+		return __ofono_error_busy(msg);
+
+	if (!dbus_message_iter_init(msg, &iter))
+		return __ofono_error_invalid_args(msg);
+
+	if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_INT32)
+		return __ofono_error_invalid_args(msg);
+
+	dbus_message_iter_get_basic(&iter, &euicc->length);
+
+	dbus_message_iter_next(&iter);
+
+	if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_STRING)
+		return __ofono_error_invalid_args(msg);
+
+	dbus_message_iter_get_basic(&iter, &command);
+	g_free(euicc->command);
+	euicc->command =3D g_strdup(command);
+
+	euicc->pending =3D dbus_message_ref(msg);
+
+	euicc_select_isdr(euicc);
+
+	return NULL;
+}
+
+static void euicc_update_eid(struct xmm7xxx_euicc *euicc)
+{
+	g_free(euicc->command);
+	euicc->command =3D g_strdup(EUICC_EID_CMD);
+	euicc->length =3D sizeof(EUICC_EID_CMD) - 1;
+
+	euicc_select_isdr(euicc);
+}
+
+static void xmm_euicc_enable(struct ofono_modem *modem, void *data)
+{
+	struct xmm7xxx_euicc *euicc =3D g_new0(struct xmm7xxx_euicc, 1);
+
+	DBG("coex enable");
+
+	euicc->chat =3D data;
+	euicc->modem =3D modem;
+	euicc->eid =3D g_strdup("INVALID");
+	euicc->channel =3D -1;
+	euicc->command =3D NULL;
+	euicc->pending =3D NULL;
+	euicc->is_registered =3D FALSE;
+
+	euicc_update_eid(euicc);
+}
+
+static void xmm_euicc_disable(struct ofono_modem *modem)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D ofono_modem_get_path(modem);
+
+	if (g_dbus_unregister_interface(conn, path,
+					OFONO_EUICC_LPA_INTERFACE))
+		ofono_modem_remove_interface(modem,
+						OFONO_EUICC_LPA_INTERFACE);
+}
+/* eUICC Implementation Ends */
+
 /* Coex Implementation */
 enum wlan_bw {
 	WLAN_BW_UNSUPPORTED =3D -1,
@@ -1181,6 +1490,8 @@ static int xmm7xxx_disable(struct ofono_modem *modem)
 		data->netreg_watch =3D 0;
 	}
 =

+	xmm_euicc_disable(modem);
+
 	return -EINPROGRESS;
 }
 =

@@ -1193,6 +1504,7 @@ static void xmm7xxx_pre_sim(struct ofono_modem *modem)
 	ofono_devinfo_create(modem, OFONO_VENDOR_IFX, "atmodem", data->chat);
 	data->sim =3D ofono_sim_create(modem, OFONO_VENDOR_XMM, "atmodem",
 					data->chat);
+	xmm_euicc_enable(modem, data->chat);
 }
 =

 static void set_online_cb(gboolean ok, GAtResult *result, gpointer user_da=
ta)
@@ -1290,6 +1602,7 @@ static int xmm7xxx_probe(struct ofono_modem *modem)
 	DBG("%p", modem);
 =

 	data =3D g_try_new0(struct xmm7xxx_data, 1);
+
 	if (data =3D=3D NULL)
 		return -ENOMEM;
 =

-- =

1.9.1

--===============1868714595042271672==--

