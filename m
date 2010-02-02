Content-Type: multipart/mixed; boundary="===============7920665846825424797=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH 1/2] clean up audio/gateway.c
Date: Tue, 02 Feb 2010 19:41:07 -0200
Message-ID: <1265146868-22016-1-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7920665846825424797==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

remove all code related to the AT engine
---
 audio/gateway.c |  760 +--------------------------------------------------=
----
 1 files changed, 1 insertions(+), 759 deletions(-)

diff --git a/audio/gateway.c b/audio/gateway.c
index a1c1ea2..3dc09ff 100644
--- a/audio/gateway.c
+++ b/audio/gateway.c
@@ -53,52 +53,6 @@
 #include "dbus-common.h"
 =

 #define RFCOMM_BUF_SIZE 256
-/* not-more-then-16 defined by GSM + 1 for NULL + padding */
-#define AG_INDICATOR_DESCR_SIZE 20
-#define AG_CALLER_NUM_SIZE 64	/* size of number + type */
-
-/* commands */
-#define AG_FEATURES "AT+BRSF=3D26\r"     /* =3D 0x7F =3D All features supp=
orted */
-#define AG_INDICATORS_SUPP "AT+CIND=3D?\r"
-#define AG_INDICATORS_VAL "AT+CIND?\r"
-#define AG_INDICATORS_ENABLE "AT+CMER=3D3,0,0,1\r"
-#define AG_HOLD_MPTY_SUPP "AT+CHLD=3D?\r"
-#define AG_CALLER_IDENT_ENABLE "AT+CLIP=3D1\r"
-#define AG_CARRIER_FORMAT "AT+COPS=3D3,0\r"
-#define AG_EXTENDED_RESULT_CODE "AT+CMEE=3D1\r"
-
-#define AG_FEATURE_3WAY 0x1
-#define AG_FEATURE_EXTENDED_RES_CODE 0x100
-/* Hold and multipary AG features.
- * Comments below are copied from hands-free spec for reference */
-/* Releases all held calls or sets User Determined User Busy (UDUB)
- * for a waiting call */
-#define AG_CHLD_0 0x01
-/* Releases all active calls (if any exist) and accepts the other
- * (held or waiting) call */
-#define AG_CHLD_1 0x02
-/* Releases specified active call only <x> */
-#define AG_CHLD_1x 0x04
-/* Places all active calls (if any exist) on hold and accepts the other
- * (held or waiting) call */
-#define AG_CHLD_2 0x08
-/* Request private consultation mode with specified call <x> (Place all
- * calls on hold EXCEPT the call <x>) */
-#define AG_CHLD_2x 0x10
-/* Adds a held call to the conversation */
-#define AG_CHLD_3 0x20
-/* Connects the two calls and disconnects the subscriber from both calls
- * (Explicit Call Transfer). Support for this value and its associated
- * functionality is optional for the HF. */
-#define AG_CHLD_4 0x40
-
-#define OK_RESPONSE "\r\nOK\r\n"
-#define ERROR_RESPONSE "\r\nERROR\r\n"
-
-struct indicator {
-	gchar descr[AG_INDICATOR_DESCR_SIZE];
-	gint value;
-};
 =

 struct gateway {
 	gateway_state_t state;
@@ -108,387 +62,10 @@ struct gateway {
 	gateway_stream_cb_t sco_start_cb;
 	void *sco_start_cb_data;
 	DBusMessage *connect_message;
-	guint ag_features;
-	guint hold_multiparty_features;
-	GSList *indies;
-	gboolean is_dialing;
-	gboolean call_active;
-
-	int sp_gain;
-	int mic_gain;
 };
 =

-static gboolean rfcomm_ag_data_cb(GIOChannel *chan, GIOCondition cond,
-					struct audio_device *device);
-
 int gateway_close(struct audio_device *device);
 =

-static void rfcomm_start_watch(struct audio_device *dev)
-{
-	struct gateway *gw =3D dev->gateway;
-
-	gw->rfcomm_watch_id =3D g_io_add_watch(gw->rfcomm,
-			G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
-			(GIOFunc) rfcomm_ag_data_cb, dev);
-}
-
-static void rfcomm_stop_watch(struct audio_device *dev)
-{
-	struct gateway *gw =3D dev->gateway;
-
-	g_source_remove(gw->rfcomm_watch_id);
-}
-
-static gboolean io_channel_write_all(GIOChannel *io, gchar *data,
-					gsize count)
-{
-	gsize written =3D 0;
-	GIOStatus status;
-
-	while (count > 0) {
-		status =3D g_io_channel_write_chars(io, data, count, &written,
-						NULL);
-		if (status !=3D G_IO_STATUS_NORMAL)
-			return FALSE;
-
-		data +=3D written;
-		count -=3D written;
-	}
-	return TRUE;
-}
-
-/* it's worth to mention that data and response could be the same pointers=
 */
-static gboolean rfcomm_send_and_read(struct gateway *gw, gchar *data,
-                                    gchar *response, gsize count)
-{
-	GIOChannel *rfcomm =3D gw->rfcomm;
-	gsize read =3D 0;
-	gboolean got_ok =3D FALSE;
-	gboolean got_error =3D FALSE;
-	gchar *resp_buf =3D response;
-	gsize toread =3D RFCOMM_BUF_SIZE - 1;
-	GIOStatus status;
-
-	if (!io_channel_write_all(rfcomm, data, count))
-		return FALSE;
-
-	while (!(got_ok || got_error)) {
-		status =3D g_io_channel_read_chars(rfcomm, resp_buf, toread,
-						&read, NULL);
-		if (status =3D=3D G_IO_STATUS_NORMAL)
-			resp_buf[read] =3D '\0';
-		else {
-			debug("rfcomm_send_and_read(): %m");
-			return FALSE;
-		}
-		got_ok =3D NULL !=3D strstr(resp_buf, OK_RESPONSE);
-		got_error =3D NULL !=3D strstr(resp_buf, ERROR_RESPONSE);
-		resp_buf +=3D read;
-		toread -=3D read;
-	}
-	return TRUE;
-}
-
-/* get <descr> from the names: (<descr>, (<values>)), (<descr>, (<values>))
- * ... */
-static GSList *parse_indicator_names(gchar *names, GSList *indies)
-{
-	gchar *current =3D names - 1;
-	GSList *result =3D indies;
-	gchar *next;
-	struct indicator *ind;
-
-	while (current !=3D NULL) {
-		current +=3D 2;
-		next =3D strstr(current, ",(");
-		ind =3D g_slice_new(struct indicator);
-		strncpy(ind->descr, current, 20);
-		ind->descr[(intptr_t) next - (intptr_t) current] =3D '\0';
-		result =3D g_slist_append(result, (gpointer) ind);
-		current =3D strstr(next + 1, ",(");
-	}
-	return result;
-}
-
-/* get values from <val0>,<val1>,... */
-static GSList *parse_indicator_values(gchar *values, GSList *indies)
-{
-	gint val;
-	gchar *current =3D values - 1;
-	GSList *runner =3D indies;
-	struct indicator *ind;
-
-	while (current !=3D NULL) {
-		current +=3D 1;
-		sscanf(current, "%d", &val);
-		current =3D strchr(current, ',');
-		ind =3D g_slist_nth_data(runner, 0);
-		ind->value =3D val;
-		runner =3D g_slist_next(runner);
-	}
-	return indies;
-}
-
-/* get values from <val0>,<val1>,... */
-static guint get_hold_mpty_features(gchar *features)
-{
-	guint result =3D 0;
-
-	if (strstr(features, "0"))
-		result |=3D AG_CHLD_0;
-
-	if (strstr(features, "1"))
-		result |=3D AG_CHLD_1;
-
-	if (strstr(features, "1x"))
-		result |=3D AG_CHLD_1x;
-
-	if (strstr(features, "2"))
-		result |=3D AG_CHLD_2;
-
-	if (strstr(features, "2x"))
-		result |=3D AG_CHLD_2x;
-
-	if (strstr(features, "3"))
-		result |=3D AG_CHLD_3;
-
-	if (strstr(features, "4"))
-		result |=3D AG_CHLD_4;
-
-	return result;
-}
-
-static gboolean establish_service_level_conn(struct gateway *gw)
-{
-	gchar buf[RFCOMM_BUF_SIZE];
-	gboolean res;
-
-	debug("at the begin of establish_service_level_conn()");
-	res =3D rfcomm_send_and_read(gw, AG_FEATURES, buf,
-				sizeof(AG_FEATURES) - 1);
-	if (!res || sscanf(buf, "\r\n+BRSF:%d", &gw->ag_features) !=3D 1)
-		return FALSE;
-
-	debug("features are 0x%X", gw->ag_features);
-	res =3D rfcomm_send_and_read(gw, AG_INDICATORS_SUPP, buf,
-				sizeof(AG_INDICATORS_SUPP) - 1);
-	if (!res || !strstr(buf, "+CIND:"))
-		return FALSE;
-
-	gw->indies =3D parse_indicator_names(strchr(buf, '('), NULL);
-
-	res =3D rfcomm_send_and_read(gw, AG_INDICATORS_VAL, buf,
-		sizeof(AG_INDICATORS_VAL) - 1);
-	if (!res || !strstr(buf, "+CIND:"))
-		return FALSE;
-
-	gw->indies =3D parse_indicator_values(strchr(buf, ':') + 1, gw->indies);
-
-	res =3D rfcomm_send_and_read(gw, AG_INDICATORS_ENABLE, buf,
-				sizeof(AG_INDICATORS_ENABLE) - 1);
-	if (!res || !strstr(buf, "OK"))
-		return FALSE;
-
-	if ((gw->ag_features & AG_FEATURE_3WAY) !=3D 0) {
-		res =3D rfcomm_send_and_read(gw, AG_HOLD_MPTY_SUPP, buf,
-				sizeof(AG_HOLD_MPTY_SUPP) - 1);
-		if (!res || !strstr(buf, "+CHLD:")) {
-			g_slice_free1(RFCOMM_BUF_SIZE, buf);
-			return FALSE;
-		}
-		gw->hold_multiparty_features =3D get_hold_mpty_features(
-							strchr(buf, '('));
-
-	} else
-		gw->hold_multiparty_features =3D 0;
-
-	debug("Service layer connection successfully established!");
-	rfcomm_send_and_read(gw, AG_CALLER_IDENT_ENABLE, buf,
-			sizeof(AG_CALLER_IDENT_ENABLE) - 1);
-	rfcomm_send_and_read(gw, AG_CARRIER_FORMAT, buf,
-			sizeof(AG_CARRIER_FORMAT) - 1);
-	if ((gw->ag_features & AG_FEATURE_EXTENDED_RES_CODE) !=3D 0)
-		rfcomm_send_and_read(gw, AG_EXTENDED_RESULT_CODE, buf,
-			sizeof(AG_EXTENDED_RESULT_CODE) - 1);
-
-	return TRUE;
-}
-
-static void process_ind_change(struct audio_device *dev, guint index,
-							gint value)
-{
-	struct gateway *gw =3D dev->gateway;
-	struct indicator *ind =3D g_slist_nth_data(gw->indies, index - 1);
-	gchar *name =3D ind->descr;
-
-	ind->value =3D value;
-
-	debug("at the begin of process_ind_change, name is %s", name);
-	if (!strcmp(name, "\"call\"")) {
-		if (value > 0) {
-			g_dbus_emit_signal(dev->conn, dev->path,
-					AUDIO_GATEWAY_INTERFACE,
-					"CallStarted", DBUS_TYPE_INVALID);
-			gw->is_dialing =3D FALSE;
-			gw->call_active =3D TRUE;
-		} else {
-			g_dbus_emit_signal(dev->conn, dev->path,
-					AUDIO_GATEWAY_INTERFACE,
-					"CallEnded", DBUS_TYPE_INVALID);
-			gw->call_active =3D FALSE;
-		}
-
-	} else if (!strcmp(name, "\"callsetup\"")) {
-		if (value =3D=3D 0 && gw->is_dialing) {
-			g_dbus_emit_signal(dev->conn, dev->path,
-					AUDIO_GATEWAY_INTERFACE,
-					"CallTerminated",
-					DBUS_TYPE_INVALID);
-			gw->is_dialing =3D FALSE;
-		} else if (!gw->is_dialing && value > 0)
-			gw->is_dialing =3D TRUE;
-
-	} else if (!strcmp(name, "\"callheld\"")) {
-		/* FIXME: The following code is based on assumptions only.
-		 * Has to be tested for interoperability
-		 * I assume that callheld=3D2 would be sent when dial from HF
-		 * failed in case of 3-way call
-		 * Unfortunately this path is not covered by the HF spec so
-		 * the code has to be tested for interop
-		*/
-		/* '2' means: all calls held, no active calls */
-		if (value =3D=3D 2) {
-			if (gw->is_dialing) {
-				g_dbus_emit_signal(dev->conn, dev->path,
-					AUDIO_GATEWAY_INTERFACE,
-					"CallTerminated",
-					DBUS_TYPE_INVALID);
-				gw->is_dialing =3D FALSE;
-			}
-		}
-	} else if (!strcmp(name, "\"service\""))
-		emit_property_changed(dev->conn, dev->path,
-				AUDIO_GATEWAY_INTERFACE, "RegistrationStatus",
-				DBUS_TYPE_UINT16, &value);
-	else if (!strcmp(name, "\"signal\""))
-		emit_property_changed(dev->conn, dev->path,
-				AUDIO_GATEWAY_INTERFACE, "SignalStrength",
-				DBUS_TYPE_UINT16, &value);
-	else if (!strcmp(name, "\"roam\""))
-		emit_property_changed(dev->conn, dev->path,
-				AUDIO_GATEWAY_INTERFACE, "RoamingStatus",
-				DBUS_TYPE_UINT16, &value);
-	else if (!strcmp(name, "\"battchg\""))
-		emit_property_changed(dev->conn, dev->path,
-				AUDIO_GATEWAY_INTERFACE, "BatteryCharge",
-				DBUS_TYPE_UINT16, &value);
-}
-
-static void process_ring(struct audio_device *device, GIOChannel *chan,
-			gchar *buf)
-{
-	gchar number[AG_CALLER_NUM_SIZE];
-	gchar *cli;
-	gchar *sep;
-	gsize read;
-	GIOStatus status;
-
-	rfcomm_stop_watch(device);
-	status =3D g_io_channel_read_chars(chan, buf, RFCOMM_BUF_SIZE - 1, &read,=
 NULL);
-	if (status !=3D G_IO_STATUS_NORMAL)
-		return;
-
-	debug("at the begin of process_ring");
-	if (strlen(buf) > AG_CALLER_NUM_SIZE + 10)
-		error("process_ring(): buf is too long '%s'", buf);
-	else if ((cli =3D strstr(buf, "\r\n+CLIP"))) {
-		if (sscanf(cli, "\r\n+CLIP: \"%s", number) =3D=3D 1) {
-			sep =3D strchr(number, '"');
-			sep[0] =3D '\0';
-
-			/* FIXME:signal will be emitted on each RING+CLIP.
-			 * That's bad */
-			cli =3D number;
-			g_dbus_emit_signal(device->conn, device->path,
-					AUDIO_GATEWAY_INTERFACE, "Ring",
-					DBUS_TYPE_STRING, &cli,
-					DBUS_TYPE_INVALID);
-			device->gateway->is_dialing =3D TRUE;
-		} else
-			error("process_ring(): '%s' in place of +CLIP after RING", buf);
-
-	}
-
-	rfcomm_start_watch(device);
-}
-
-static gboolean rfcomm_ag_data_cb(GIOChannel *chan, GIOCondition cond,
-					struct audio_device *device)
-{
-	gchar buf[RFCOMM_BUF_SIZE];
-	struct gateway *gw;
-	gsize read;
-	/* some space for value */
-	gchar indicator[AG_INDICATOR_DESCR_SIZE + 4];
-	gint value;
-	guint index;
-	gchar *sep;
-
-	debug("at the begin of rfcomm_ag_data_cb()");
-	if (cond & G_IO_NVAL)
-		return FALSE;
-
-	gw =3D device->gateway;
-
-	if (cond & (G_IO_ERR | G_IO_HUP)) {
-		debug("connection with remote BT is closed");
-		gateway_close(device);
-		return FALSE;
-	}
-
-	if (g_io_channel_read_chars(chan, buf, sizeof(buf) - 1, &read, NULL)
-			!=3D G_IO_STATUS_NORMAL)
-		return TRUE;
-	buf[read] =3D '\0';
-
-	if (strlen(buf) > AG_INDICATOR_DESCR_SIZE + 14)
-		error("rfcomm_ag_data_cb(): buf is too long '%s'", buf);
-	else if (sscanf(buf, "\r\n+CIEV:%s\r\n", indicator) =3D=3D 1) {
-		sep =3D strchr(indicator, ',');
-		sep[0] =3D '\0';
-		sep +=3D 1;
-		index =3D atoi(indicator);
-		value =3D atoi(sep);
-		process_ind_change(device, index, value);
-	} else if (strstr(buf, "RING"))
-		process_ring(device, chan, buf);
-	else if (sscanf(buf, "\r\n+BVRA:%d\r\n", &value) =3D=3D 1) {
-		if (value =3D=3D 0)
-			g_dbus_emit_signal(device->conn, device->path,
-					AUDIO_GATEWAY_INTERFACE,
-					"VoiceRecognitionActive",
-					DBUS_TYPE_INVALID);
-		else
-			g_dbus_emit_signal(device->conn, device->path,
-					AUDIO_GATEWAY_INTERFACE,
-					"VoiceRecognitionInactive",
-					DBUS_TYPE_INVALID);
-	} else if (sscanf(buf, "\r\n+VGS:%d\r\n", &value) =3D=3D 1) {
-		gw->sp_gain =3D value;
-		emit_property_changed(device->conn, device->path,
-				AUDIO_GATEWAY_INTERFACE, "SpeakerGain",
-				DBUS_TYPE_UINT16, &value);
-	} else if (sscanf(buf, "\r\n+VGM:%d\r\n", &value) =3D=3D 1) {
-		gw->mic_gain =3D value;
-		emit_property_changed(device->conn, device->path,
-				AUDIO_GATEWAY_INTERFACE, "MicrophoneGain",
-				DBUS_TYPE_UINT16, &value);
-	} else
-		error("rfcomm_ag_data_cb(): read wrong data '%s'", buf);
-
-	return TRUE;
-}
-
 static gboolean sco_io_cb(GIOChannel *chan, GIOCondition cond,
 			struct audio_device *dev)
 {
@@ -541,7 +118,6 @@ static void rfcomm_connect_cb(GIOChannel *chan, GError =
*err,
 {
 	struct audio_device *dev =3D user_data;
 	struct gateway *gw =3D dev->gateway;
-	DBusMessage *conn_mes =3D gw->connect_message;
 	gchar gw_addr[18];
 	GIOFlags flags;
 =

@@ -563,29 +139,6 @@ static void rfcomm_connect_cb(GIOChannel *chan, GError=
 *err,
 	if (!gw->rfcomm)
 		gw->rfcomm =3D g_io_channel_ref(chan);
 =

-	if (establish_service_level_conn(dev->gateway)) {
-		gboolean value =3D TRUE;
-
-		debug("%s: Connected to %s", dev->path, gw_addr);
-		rfcomm_start_watch(dev);
-		if (conn_mes) {
-			DBusMessage *reply =3D
-				dbus_message_new_method_return(conn_mes);
-			dbus_connection_send(dev->conn, reply, NULL);
-			dbus_message_unref(reply);
-			dbus_message_unref(conn_mes);
-			gw->connect_message =3D NULL;
-		}
-
-		gw->state =3D GATEWAY_STATE_CONNECTED;
-		emit_property_changed(dev->conn, dev->path,
-				AUDIO_GATEWAY_INTERFACE,
-				"Connected", DBUS_TYPE_BOOLEAN,	&value);
-		return;
-	} else
-		error("%s: Failed to establish service layer connection to %s",
-			dev->path, gw_addr);
-
 	if (NULL !=3D gw->sco_start_cb)
 		gw->sco_start_cb(NULL, gw->sco_start_cb_data);
 =

@@ -732,321 +285,20 @@ static DBusMessage *ag_disconnect(DBusConnection *co=
nn, DBusMessage *msg,
 	return reply;
 }
 =

-static DBusMessage *process_ag_reponse(DBusMessage *msg, gchar *response)
-{
-	DBusMessage *reply;
-
-
-	debug("in process_ag_reponse, response is %s", response);
-	if (strstr(response, OK_RESPONSE))
-		reply =3D dbus_message_new_method_return(msg);
-	else {
-		/* FIXME: some code should be here to processes errors
-		 *  in better fasion */
-		debug("AG responded with '%s' to %s method call", response,
-				dbus_message_get_member(msg));
-		reply =3D dbus_message_new_error(msg, ERROR_INTERFACE
-					".OperationFailed",
-					"Operation failed.See log for details");
-	}
-	return reply;
-}
-
-static DBusMessage *process_simple(DBusMessage *msg, struct audio_device *=
dev,
-					gchar *data)
-{
-	struct gateway *gw =3D dev->gateway;
-	gchar buf[RFCOMM_BUF_SIZE];
-
-	rfcomm_stop_watch(dev);
-	rfcomm_send_and_read(gw, data, buf, strlen(data));
-	rfcomm_start_watch(dev);
-	return process_ag_reponse(msg, buf);
-}
-
-#define AG_ANSWER "ATA\r"
-
-static DBusMessage *ag_answer(DBusConnection *conn, DBusMessage *msg,
-				void *data)
-{
-	struct audio_device *dev =3D data;
-	struct gateway *gw =3D dev->gateway;
-
-	if (!gw->rfcomm)
-		return g_dbus_create_error(msg, ERROR_INTERFACE
-					".NotConnected",
-					"Not Connected");
-
-	if (gw->call_active)
-		return g_dbus_create_error(msg, ERROR_INTERFACE
-					".CallAlreadyAnswered",
-					"Call AlreadyAnswered");
-
-	return process_simple(msg, dev, AG_ANSWER);
-}
-
-#define AG_HANGUP "AT+CHUP\r"
-
-static DBusMessage *ag_terminate_call(DBusConnection *conn, DBusMessage *m=
sg,
-				void *data)
-{
-	struct audio_device *dev =3D data;
-	struct gateway *gw =3D dev->gateway;
-
-	if (!gw->rfcomm)
-		return g_dbus_create_error(msg, ERROR_INTERFACE
-					".NotConnected",
-					"Not Connected");
-
-	return process_simple(msg, dev, AG_HANGUP);
-}
-
-/* according to GSM spec */
-#define ALLOWED_NUMBER_SYMBOLS "1234567890*#ABCD"
-#define AG_PLACE_CALL "ATD%s;\r"
-/* dialing from memory is not supported as headset spec doesn't define a w=
ay
- * to retreive phone memory entries.
- */
-static DBusMessage *ag_call(DBusConnection *conn, DBusMessage *msg,
-				void *data)
-{
-	struct audio_device *device =3D data;
-	struct gateway *gw =3D device->gateway;
-	gchar buf[RFCOMM_BUF_SIZE];
-	gchar *number;
-	gint atd_len;
-	DBusMessage *result;
-
-	debug("at the begin of ag_call()");
-	if (!gw->rfcomm)
-		return g_dbus_create_error(msg, ERROR_INTERFACE
-					".NotConnected",
-					"Not Connected");
-
-	dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &number,
-				DBUS_TYPE_INVALID);
-	if (strlen(number) !=3D strspn(number, ALLOWED_NUMBER_SYMBOLS))
-		return dbus_message_new_error(msg,
-			ERROR_INTERFACE ".BadNumber",
-			"Number contains characters which are not allowed");
-
-	atd_len =3D sprintf(buf, AG_PLACE_CALL, number);
-	rfcomm_stop_watch(device);
-	rfcomm_send_and_read(gw, buf, buf, atd_len);
-	rfcomm_start_watch(device);
-
-	result =3D process_ag_reponse(msg, buf);
-	return result;
-}
-
-#define AG_GET_CARRIER "AT+COPS?\r"
-
-static DBusMessage *ag_get_operator(DBusConnection *conn, DBusMessage *msg,
-					void *data)
-{
-	struct audio_device *dev =3D (struct audio_device *) data;
-	struct gateway *gw =3D dev->gateway;
-	gchar buf[RFCOMM_BUF_SIZE];
-	GIOChannel *rfcomm =3D gw->rfcomm;
-	gsize read;
-	gchar *result, *sep;
-	DBusMessage *reply;
-	GIOStatus status;
-
-	if (!gw->rfcomm)
-		return g_dbus_create_error(msg, ERROR_INTERFACE
-					".NotConnected",
-					"Not Connected");
-
-	rfcomm_stop_watch(dev);
-	io_channel_write_all(rfcomm, AG_GET_CARRIER, strlen(AG_GET_CARRIER));
-
-	status =3D g_io_channel_read_chars(rfcomm, buf, RFCOMM_BUF_SIZE - 1,
-						&read, NULL);
-	rfcomm_start_watch(dev);
-	if (G_IO_STATUS_NORMAL =3D=3D status) {
-		buf[read] =3D '\0';
-		if (strstr(buf, "+COPS")) {
-			if (!strrchr(buf, ','))
-				result =3D "0";
-			else {
-				result =3D strchr(buf, '\"') + 1;
-				sep =3D strchr(result, '\"');
-				sep[0] =3D '\0';
-			}
-
-			reply =3D dbus_message_new_method_return(msg);
-			dbus_message_append_args(reply, DBUS_TYPE_STRING,
-						&result, DBUS_TYPE_INVALID);
-		} else {
-			info("ag_get_operator(): '+COPS' expected but"
-				" '%s' received", buf);
-			reply =3D dbus_message_new_error(msg, ERROR_INTERFACE
-						".Failed",
-						"Unexpected response from AG");
-		}
-	} else {
-		error("ag_get_operator(): %m");
-		reply =3D dbus_message_new_error(msg, ERROR_INTERFACE
-					".ConnectionFailed",
-					"Failed to receive response from AG");
-	}
-
-	return reply;
-}
-
-#define AG_SEND_DTMF "AT+VTS=3D%c\r"
-static DBusMessage *ag_send_dtmf(DBusConnection *conn, DBusMessage *msg,
-				void *data)
-{
-	struct audio_device *device =3D data;
-	struct gateway *gw =3D device->gateway;
-	gchar buf[RFCOMM_BUF_SIZE];
-	gchar *number;
-	gint com_len;
-	gboolean got_ok =3D TRUE;
-	gint num_len;
-	gint i =3D 0;
-
-	if (!gw->rfcomm)
-		return g_dbus_create_error(msg, ERROR_INTERFACE
-					".NotConnected",
-					"Not Connected");
-
-	dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &number,
-				DBUS_TYPE_INVALID);
-	if (strlen(number) !=3D strspn(number, ALLOWED_NUMBER_SYMBOLS))
-		return dbus_message_new_error(msg,
-			ERROR_INTERFACE ".BadNumber",
-			"Number contains characters which are not allowed");
-
-	num_len =3D strlen(number);
-	rfcomm_stop_watch(device);
-	while (i < num_len && got_ok) {
-		com_len =3D sprintf(buf, AG_SEND_DTMF, number[i]);
-		rfcomm_send_and_read(gw, buf, buf, com_len);
-		got_ok =3D NULL !=3D strstr(buf, OK_RESPONSE);
-		i +=3D 1;
-	}
-	rfcomm_start_watch(device);
-	return process_ag_reponse(msg, buf);
-}
-
-#define AG_GET_SUBSCRIBER_NUMS "AT+CNUM\r"
-#define CNUM_LEN 5             /* length of "+CNUM" string */
-#define MAX_NUMBER_CNT 16
-static DBusMessage *ag_get_subscriber_num(DBusConnection *conn,
-					DBusMessage *msg, void *data)
-{
-	struct audio_device *device =3D data;
-	struct gateway *gw =3D device->gateway;
-	gchar buf[RFCOMM_BUF_SIZE];
-	gchar *number, *end;
-	DBusMessage *reply =3D dbus_message_new_method_return(msg);
-
-	if (!gw->rfcomm)
-		return g_dbus_create_error(msg, ERROR_INTERFACE
-					".NotConnected",
-					"Not Connected");
-
-	rfcomm_stop_watch(device);
-	rfcomm_send_and_read(gw, AG_GET_SUBSCRIBER_NUMS, buf,
-			strlen(AG_GET_SUBSCRIBER_NUMS));
-	rfcomm_start_watch(device);
-
-	if (strlen(buf) > AG_CALLER_NUM_SIZE + 21)
-		error("ag_get_subscriber_num(): buf is too long '%s'", buf);
-	else if (strstr(buf, "+CNUM")) {
-		number =3D strchr(buf, ',');
-		number++;
-		end =3D strchr(number, ',');
-		if (end) {
-			*end =3D '\0';
-			dbus_message_append_args(reply, DBUS_TYPE_STRING,
-						&number, DBUS_TYPE_INVALID);
-		}
-	} else
-		error("ag_get_subscriber_num(): read wrong data '%s'", buf);
-
-	return reply;
-}
-
 static DBusMessage *ag_get_properties(DBusConnection *conn, DBusMessage *m=
sg,
 					void *data)
 {
-	struct audio_device *device =3D data;
-	struct gateway *gw =3D device->gateway;
-	DBusMessage *reply;
-	DBusMessageIter iter;
-	DBusMessageIter dict;
-	gboolean value;
-	guint index =3D 0;
-	struct indicator *ind;
-
-	reply =3D dbus_message_new_method_return(msg);
-	if (!reply)
-		return NULL;
-
-	dbus_message_iter_init_append(reply, &iter);
-
-	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
-			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
-			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
-			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
-
-	/* Connected */
-	value =3D gateway_is_connected(device);
-	dict_append_entry(&dict, "Connected", DBUS_TYPE_BOOLEAN, &value);
-
-	if (!value)
-		goto done;
-
-	while ((ind =3D g_slist_nth_data(gw->indies, index))) {
-		if(!strcmp(ind->descr, "\"service\""))
-			dict_append_entry(&dict, "RegistrationStatus",
-					DBUS_TYPE_UINT16, &ind->value);
-		else if (!strcmp(ind->descr, "\"signal\""))
-			dict_append_entry(&dict, "SignalStrength",
-					DBUS_TYPE_UINT16, &ind->value);
-		else if (!strcmp(ind->descr, "\"roam\""))
-			dict_append_entry(&dict, "RoamingStatus",
-					DBUS_TYPE_UINT16, &ind->value);
-		else if (!strcmp(ind->descr, "\"battchg\""))
-			dict_append_entry(&dict, "BatteryCharge",
-					DBUS_TYPE_UINT16, &ind->value);
-		index++;
-	}
-
-	/* SpeakerGain */
-	dict_append_entry(&dict, "SpeakerGain", DBUS_TYPE_UINT16,
-				&device->gateway->sp_gain);
-
-	/* MicrophoneGain */
-	dict_append_entry(&dict, "MicrophoneGain", DBUS_TYPE_UINT16,
-				&device->gateway->mic_gain);
-done:
-	dbus_message_iter_close_container(&iter, &dict);
-	return reply;
+	return NULL;
 }
 =

 static GDBusMethodTable gateway_methods[] =3D {
 	{ "Connect", "", "", ag_connect, G_DBUS_METHOD_FLAG_ASYNC },
 	{ "Disconnect", "", "", ag_disconnect },
-	{ "AnswerCall", "", "", ag_answer },
-	{ "TerminateCall", "", "", ag_terminate_call },
-	{ "Call", "s", "", ag_call },
-	{ "GetOperatorName", "", "s", ag_get_operator },
-	{ "SendDTMF", "s", "", ag_send_dtmf },
-	{ "GetSubscriberNumber", "", "s", ag_get_subscriber_num },
 	{ "GetProperties", "", "a{sv}", ag_get_properties },
 	{ NULL, NULL, NULL, NULL }
 };
 =

 static GDBusSignalTable gateway_signals[] =3D {
-	{ "Ring", "s" },
-	{ "CallTerminated", "" },
-	{ "CallStarted", "" },
-	{ "CallEnded", "" },
 	{ "PropertyChanged", "sv" },
 	{ NULL, NULL }
 };
@@ -1063,9 +315,6 @@ struct gateway *gateway_init(struct audio_device *dev)
 =

 	debug("in gateway_init, dev is %p", dev);
 	gw =3D g_new0(struct gateway, 1);
-	gw->indies =3D NULL;
-	gw->is_dialing =3D FALSE;
-	gw->call_active =3D FALSE;
 	gw->state =3D GATEWAY_STATE_DISCONNECTED;
 	return gw;
 =

@@ -1107,11 +356,6 @@ void gateway_start_service(struct audio_device *devic=
e)
 	rfcomm_connect_cb(device->gateway->rfcomm, NULL, device);
 }
 =

-static void indicator_slice_free(gpointer mem)
-{
-	g_slice_free(struct indicator, mem);
-}
-
 int gateway_close(struct audio_device *device)
 {
 	struct gateway *gw =3D device->gateway;
@@ -1119,8 +363,6 @@ int gateway_close(struct audio_device *device)
 	GIOChannel *sco =3D gw->sco;
 	gboolean value =3D FALSE;
 =

-	g_slist_foreach(gw->indies, (GFunc) indicator_slice_free, NULL);
-	g_slist_free(gw->indies);
 	if (rfcomm) {
 		g_io_channel_shutdown(rfcomm, TRUE, NULL);
 		g_io_channel_unref(rfcomm);
-- =

1.6.4.4


--===============7920665846825424797==--

