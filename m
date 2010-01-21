Content-Type: multipart/mixed; boundary="===============7717286344012994125=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH 2/2] Implement HandsfreeGateway Interface
Date: Thu, 21 Jan 2010 18:31:11 -0200
Message-ID: <1264105871-27322-2-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1264105871-27322-1-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7717286344012994125==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Create a interface where a Handsfree agent can register and use BlueZ to
handle the rfcomm and sco links.

Many thanks to Zhenhua Zhang <zhenhua.zhang@intel.com> for his
prototype on this code.
---
 audio/gateway.c |  428 +++++++++++++++++++++++++++++++++++++++++++--------=
----
 audio/gateway.h |   12 ++-
 audio/manager.c |   20 +--
 audio/unix.c    |    8 +
 doc/hfp-api.txt |   81 +++++++++++
 5 files changed, 439 insertions(+), 110 deletions(-)
 create mode 100644 doc/hfp-api.txt

diff --git a/audio/gateway.c b/audio/gateway.c
index 3dc09ff..8cfb6e9 100644
--- a/audio/gateway.c
+++ b/audio/gateway.c
@@ -5,6 +5,8 @@
  *  Copyright (C) 2006-2010  Nokia Corporation
  *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
  *  Copyright (C) 2008-2009  Leonid Movshovich <event.riga@gmail.org>
+ *  Copyright (C) 2009-2009  Zhenhua Zhang <zhenhua.zhang@intel.com>
+ *  Copyright (C) 2010  Gustavo F. Padovan <padovan@profusion.mobi>
  *
  *
  *  This program is free software; you can redistribute it and/or modify
@@ -32,12 +34,15 @@
 #include <string.h>
 #include <fcntl.h>
 #include <errno.h>
+#include <sys/ioctl.h>
+#include <unistd.h>
 =

 #include <glib.h>
 #include <dbus/dbus.h>
 #include <gdbus.h>
 =

 #include <bluetooth/bluetooth.h>
+#include <bluetooth/rfcomm.h>
 #include <bluetooth/hci.h>
 #include <bluetooth/hci_lib.h>
 #include <bluetooth/sco.h>
@@ -52,20 +57,105 @@
 #include "btio.h"
 #include "dbus-common.h"
 =

-#define RFCOMM_BUF_SIZE 256
+#define MAX_OPEN_TRIES 5
+#define OPEN_WAIT 300
+
+#ifndef DBUS_TYPE_UNIX_FD
+#define DBUS_TYPE_UNIX_FD -1
+#endif
+
+struct hf_agent {
+	char *name;	/* Bus id */
+	char *path;	/* D-Bus path */
+	guint watch;	/* Disconnect watch */
+};
 =

 struct gateway {
 	gateway_state_t state;
-	GIOChannel *rfcomm;
-	guint rfcomm_watch_id;
+	int channel;
+	GIOChannel *rfcomm;	/* remote AG requested rfcomm connection */
 	GIOChannel *sco;
 	gateway_stream_cb_t sco_start_cb;
 	void *sco_start_cb_data;
-	DBusMessage *connect_message;
+	struct hf_agent *agent;
+	DBusMessage *msg;
 };
 =

 int gateway_close(struct audio_device *device);
 =

+static const char *state2str(gateway_state_t i)
+{
+	switch (i) {
+	case GATEWAY_STATE_DISCONNECTED:
+		return "disconnected";
+	case GATEWAY_STATE_CONNECTING:
+		return "connecting";
+	case GATEWAY_STATE_CONNECTED:
+		return "connected";
+	case GATEWAY_STATE_PLAYING:
+		return "playing";
+	default:
+		return "";
+	}
+}
+
+static void agent_free(struct hf_agent *agent)
+{
+	if (!agent)
+		return;
+
+	g_free(agent->name);
+	g_free(agent->path);
+	g_free(agent);
+}
+
+static void change_state(struct audio_device *dev, gateway_state_t new_sta=
te)
+{
+	struct gateway *gw =3D dev->gateway;
+	const char *val =3D state2str(new_state);
+
+	gw->state =3D new_state;
+
+	emit_property_changed(dev->conn, dev->path,
+			AUDIO_GATEWAY_INTERFACE, "State",
+			DBUS_TYPE_STRING, &val);
+}
+
+static void agent_disconnect(struct audio_device *dev, struct hf_agent *ag=
ent)
+{
+	DBusMessage *msg;
+
+	msg =3D dbus_message_new_method_call(agent->name, agent->path,
+			"org.bluez.HandsfreeAgent", "Release");
+
+	dbus_message_set_no_reply(msg, TRUE);
+	g_dbus_send_message(dev->conn, msg);
+
+	g_dbus_remove_watch(dev->conn, agent->watch);
+}
+
+static gboolean agent_sendfd(struct hf_agent *agent, int fd,
+		DBusPendingCallNotifyFunction notify, void *data)
+{
+	struct audio_device *dev =3D data;
+	DBusMessage *msg;
+	DBusPendingCall *call;
+
+	msg =3D dbus_message_new_method_call(agent->name, agent->path,
+			"org.bluez.HandsfreeAgent", "NewConnection");
+
+	dbus_message_append_args(msg, DBUS_TYPE_UNIX_FD, &fd,
+					DBUS_TYPE_INVALID);
+
+	if (dbus_connection_send_with_reply(dev->conn, msg, &call, -1) =3D=3D FAL=
SE)
+		return FALSE;
+
+	dbus_pending_call_set_notify(call, notify, dev, NULL);
+	dbus_pending_call_unref(call);
+
+	return TRUE;
+}
+
 static gboolean sco_io_cb(GIOChannel *chan, GIOCondition cond,
 			struct audio_device *dev)
 {
@@ -79,6 +169,7 @@ static gboolean sco_io_cb(GIOChannel *chan, GIOCondition=
 cond,
 		g_io_channel_shutdown(gw->sco, TRUE, NULL);
 		g_io_channel_unref(gw->sco);
 		gw->sco =3D NULL;
+		change_state(dev, GATEWAY_STATE_CONNECTED);
 		return FALSE;
 	}
 =

@@ -92,63 +183,93 @@ static void sco_connect_cb(GIOChannel *chan, GError *e=
rr, gpointer user_data)
 =

 	debug("at the begin of sco_connect_cb() in gateway.c");
 =

+	gw->sco =3D chan;
+	g_io_channel_ref(chan);
+
 	if (err) {
 		error("sco_connect_cb(): %s", err->message);
-		/* not sure, but from other point of view,
-		 * what is the reason to have headset which
-		 * cannot play audio? */
-		if (gw->sco_start_cb)
-			gw->sco_start_cb(NULL, gw->sco_start_cb_data);
 		gateway_close(dev);
 		return;
 	}
 =

-	gw->sco =3D g_io_channel_ref(chan);
 	if (gw->sco_start_cb)
 		gw->sco_start_cb(dev, gw->sco_start_cb_data);
 =

-	/* why is this here? */
-	fcntl(g_io_channel_unix_get_fd(chan), F_SETFL, 0);
 	g_io_add_watch(gw->sco, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
 				(GIOFunc) sco_io_cb, dev);
 }
 =

+static void newconnection_reply(DBusPendingCall *call, void *data)
+{
+	struct audio_device *dev =3D data;
+	DBusMessage *reply =3D dbus_pending_call_steal_reply(call);
+	DBusError derr;
+
+	if (!dev->gateway->rfcomm) {
+		debug("RFCOMM disconnected from server before agent reply");
+		return;
+	}
+
+	dbus_error_init(&derr);
+	if (!dbus_set_error_from_message(&derr, reply)) {
+		debug("Agent reply: file descriptor passed successfuly");
+		return;
+	}
+
+	debug("Agent reply: %s", derr.message);
+
+	dbus_error_free(&derr);
+	gateway_close(dev);
+}
+
 static void rfcomm_connect_cb(GIOChannel *chan, GError *err,
 				gpointer user_data)
 {
 	struct audio_device *dev =3D user_data;
 	struct gateway *gw =3D dev->gateway;
-	gchar gw_addr[18];
-	GIOFlags flags;
+	DBusMessage *reply;
+	int sk;
+	char src[18], dst[18];
 =

 	if (err) {
 		error("connect(): %s", err->message);
 		if (gw->sco_start_cb)
 			gw->sco_start_cb(NULL, gw->sco_start_cb_data);
-		return;
+		goto fail;
 	}
 =

-	ba2str(&dev->dst, gw_addr);
-	/* Blocking mode should be default, but just in case: */
-	flags =3D g_io_channel_get_flags(chan);
-	flags &=3D ~G_IO_FLAG_NONBLOCK;
-	flags &=3D G_IO_FLAG_MASK;
-	g_io_channel_set_flags(chan, flags, NULL);
-	g_io_channel_set_encoding(chan, NULL, NULL);
-	g_io_channel_set_buffered(chan, FALSE);
-	if (!gw->rfcomm)
-		gw->rfcomm =3D g_io_channel_ref(chan);
+	if (!gw->agent)
+		error("Handfree Agent not registered");
 =

-	if (NULL !=3D gw->sco_start_cb)
-		gw->sco_start_cb(NULL, gw->sco_start_cb_data);
+	ba2str(&dev->src, src);
+	ba2str(&dev->dst, dst);
 =

-	gateway_close(dev);
+	sk =3D g_io_channel_unix_get_fd(chan);
+
+	gw->rfcomm =3D g_io_channel_ref(chan);
+
+	change_state(dev, GATEWAY_STATE_CONNECTED);
+
+	if (!agent_sendfd(gw->agent, sk, newconnection_reply, dev)) {
+		reply =3D g_dbus_create_error(gw->msg, ERROR_INTERFACE ".Failed",
+				"Can not pass file descriptor");
+	} else
+		reply =3D dbus_message_new_method_return(gw->msg);
+
+	return;
+
+fail:
+	if (gw->msg) {
+		error_common_reply(dev->conn, gw->msg, ERROR_INTERFACE
+				".Failed", ".Connection attempt failed");
+	}
+	change_state(dev, GATEWAY_STATE_DISCONNECTED);
 }
 =

 static void get_record_cb(sdp_list_t *recs, int perr, gpointer user_data)
 {
 	struct audio_device *dev =3D user_data;
-	DBusMessage *msg =3D dev->gateway->connect_message;
+	struct gateway *gw =3D dev->gateway;
 	int ch =3D -1;
 	sdp_list_t *protos, *classes;
 	uuid_t uuid;
@@ -182,8 +303,6 @@ static void get_record_cb(sdp_list_t *recs, int perr, g=
pointer user_data)
 =

 	if (!sdp_uuid128_to_uuid(&uuid) || uuid.type !=3D SDP_UUID16 ||
 			uuid.value.uuid16 !=3D HANDSFREE_AGW_SVCLASS_ID) {
-		sdp_list_foreach(protos, (sdp_list_func_t) sdp_list_free,
-									NULL);
 		sdp_list_free(protos, NULL);
 		error("Invalid service record or not HFP");
 		goto fail;
@@ -197,6 +316,8 @@ static void get_record_cb(sdp_list_t *recs, int perr, g=
pointer user_data)
 		goto fail;
 	}
 =

+	gw->channel =3D ch;
+
 	io =3D bt_io_connect(BT_IO_RFCOMM, rfcomm_connect_cb, dev, NULL, &err,
 				BT_IO_OPT_SOURCE_BDADDR, &dev->src,
 				BT_IO_OPT_DEST_BDADDR, &dev->dst,
@@ -204,25 +325,24 @@ static void get_record_cb(sdp_list_t *recs, int perr,=
 gpointer user_data)
 				BT_IO_OPT_INVALID);
 	if (!io) {
 		error("Unable to connect: %s", err->message);
-		if (msg) {
-			error_common_reply(dev->conn, msg, ERROR_INTERFACE
-						".ConnectionAttemptFailed",
-						err->message);
-			msg =3D NULL;
-		}
-		g_error_free(err);
+		if (err)
+			g_error_free(err);
 		gateway_close(dev);
+		goto fail;
 	}
 =

 	g_io_channel_unref(io);
+
+	change_state(dev, GATEWAY_STATE_CONNECTING);
 	return;
 =

 fail:
-	if (msg)
-		error_common_reply(dev->conn, msg, ERROR_INTERFACE
-					".NotSupported", "Not supported");
+	if (gw->msg) {
+		error_common_reply(dev->conn, gw->msg, ERROR_INTERFACE
+				".NotSupported", "Not supported");
+	}
 =

-	dev->gateway->connect_message =3D NULL;
+	change_state(dev, GATEWAY_STATE_DISCONNECTED);
 =

 	sco_cb =3D dev->gateway->sco_start_cb;
 	if (sco_cb)
@@ -243,22 +363,55 @@ static DBusMessage *ag_connect(DBusConnection *conn, =
DBusMessage *msg,
 {
 	struct audio_device *au_dev =3D (struct audio_device *) data;
 	struct gateway *gw =3D au_dev->gateway;
+	DBusMessage *reply;
 =

 	debug("at the begin of ag_connect()");
-	if (gw->rfcomm)
+
+	if (!gw->agent)
 		return g_dbus_create_error(msg, ERROR_INTERFACE
-					".AlreadyConnected",
-					"Already Connected");
+				".Failed", "Agent not assined");
 =

-	gw->connect_message =3D dbus_message_ref(msg);
 	if (get_records(au_dev) < 0) {
-		dbus_message_unref(gw->connect_message);
 		return g_dbus_create_error(msg, ERROR_INTERFACE
 					".ConnectAttemptFailed",
 					"Connect Attempt Failed");
 	}
+
+	reply =3D dbus_message_new_method_return(msg);
+	if (!reply)
+		return NULL;
+
 	debug("at the end of ag_connect()");
-	return NULL;
+
+	return reply;
+}
+
+int gateway_close(struct audio_device *device)
+{
+	struct gateway *gw =3D device->gateway;
+	gboolean value =3D FALSE;
+
+	if (gw->rfcomm) {
+		g_io_channel_shutdown(gw->rfcomm, TRUE, NULL);
+		g_io_channel_unref(gw->rfcomm);
+		gw->rfcomm =3D NULL;
+	}
+
+	if (gw->sco) {
+		g_io_channel_shutdown(gw->sco, TRUE, NULL);
+		g_io_channel_unref(gw->sco);
+		gw->sco =3D NULL;
+		gw->sco_start_cb =3D NULL;
+		gw->sco_start_cb_data =3D NULL;
+	}
+
+	gw->state =3D GATEWAY_STATE_DISCONNECTED;
+
+	emit_property_changed(device->conn, device->path,
+				AUDIO_GATEWAY_INTERFACE,
+				"Connected", DBUS_TYPE_BOOLEAN, &value);
+
+	return 0;
 }
 =

 static DBusMessage *ag_disconnect(DBusConnection *conn, DBusMessage *msg,
@@ -269,6 +422,9 @@ static DBusMessage *ag_disconnect(DBusConnection *conn,=
 DBusMessage *msg,
 	DBusMessage *reply =3D NULL;
 	char gw_addr[18];
 =

+	if (!device->conn)
+		return NULL;
+
 	reply =3D dbus_message_new_method_return(msg);
 	if (!reply)
 		return NULL;
@@ -279,22 +435,124 @@ static DBusMessage *ag_disconnect(DBusConnection *co=
nn, DBusMessage *msg,
 						"Device not Connected");
 =

 	gateway_close(device);
+
 	ba2str(&device->dst, gw_addr);
 	debug("Disconnected from %s, %s", gw_addr, device->path);
 =

 	return reply;
 }
 =

+static void agent_exited(DBusConnection *conn, void *data)
+{
+	struct gateway *gateway =3D data;
+	struct hf_agent *agent =3D gateway->agent;
+
+	debug("Agent %s exited", agent->name);
+
+	agent_free(agent);
+	gateway->agent =3D NULL;
+}
+
 static DBusMessage *ag_get_properties(DBusConnection *conn, DBusMessage *m=
sg,
 					void *data)
 {
-	return NULL;
+	struct audio_device *device =3D data;
+	struct gateway *gw =3D device->gateway;
+	DBusMessage *reply;
+	DBusMessageIter iter;
+	DBusMessageIter dict;
+	const char *value;
+
+
+	reply =3D dbus_message_new_method_return(msg);
+	if (!reply)
+		return NULL;
+
+	dbus_message_iter_init_append(reply, &iter);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
+			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
+
+	value =3D state2str(gw->state);
+	dict_append_entry(&dict, "Connected",
+			DBUS_TYPE_STRING, &value);
+
+	dbus_message_iter_close_container(&iter, &dict);
+
+	return reply;
+}
+
+static DBusMessage *register_agent(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	struct audio_device *device =3D data;
+	struct gateway *gw =3D device->gateway;
+	struct hf_agent *agent;
+	const char *path, *name;
+
+
+	if (gw->agent)
+		return g_dbus_create_error(msg,
+				ERROR_INTERFACE ".AlreadyExists",
+				"Agent already exists");
+
+	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &path,
+			DBUS_TYPE_INVALID))
+		return g_dbus_create_error(msg, ERROR_INTERFACE
+				".InvalidArguments", "Invalid argument");
+
+	name =3D dbus_message_get_sender(msg);
+	agent =3D g_new0(struct hf_agent, 1);
+
+	agent->name =3D g_strdup(name);
+	agent->path =3D g_strdup(path);
+
+	agent->watch =3D g_dbus_add_disconnect_watch(conn, name,
+			agent_exited, gw, NULL);
+
+	gw->agent =3D agent;
+
+	gw->msg =3D dbus_message_ref(msg);
+
+	return dbus_message_new_method_return(msg);
+}
+
+static DBusMessage *unregister_agent(DBusConnection *conn,
+				DBusMessage *msg, void *data)
+{
+	struct audio_device *device =3D data;
+	struct gateway *gw =3D device->gateway;
+	struct hf_agent *agent;
+
+	if (!gw->agent)
+		goto done;
+
+	agent =3D gw->agent;
+	if (strcmp(agent->name, dbus_message_get_sender(msg)) !=3D 0)
+		return g_dbus_create_error(msg,
+				ERROR_INTERFACE ".Failed", "Permission denied");
+
+	agent_disconnect(device, gw->agent);
+
+	g_dbus_remove_watch(conn, agent->watch);
+
+	dbus_message_unref(gw->msg);
+
+	agent_free(agent);
+	gw->agent =3D NULL;
+
+done:
+	return dbus_message_new_method_return(msg);
 }
 =

 static GDBusMethodTable gateway_methods[] =3D {
 	{ "Connect", "", "", ag_connect, G_DBUS_METHOD_FLAG_ASYNC },
-	{ "Disconnect", "", "", ag_disconnect },
+	{ "Disconnect", "", "", ag_disconnect, G_DBUS_METHOD_FLAG_ASYNC },
 	{ "GetProperties", "", "a{sv}", ag_get_properties },
+	{ "RegisterAgent", "o", "", register_agent },
+	{ "UnregisterAgent", "o", "", unregister_agent },
 	{ NULL, NULL, NULL, NULL }
 };
 =

@@ -307,17 +565,15 @@ struct gateway *gateway_init(struct audio_device *dev)
 {
 	struct gateway *gw;
 =

+	gw =3D g_new0(struct gateway, 1);
+
 	if (!g_dbus_register_interface(dev->conn, dev->path,
 					AUDIO_GATEWAY_INTERFACE,
 					gateway_methods, gateway_signals,
 					NULL, dev, NULL))
 		return NULL;
 =

-	debug("in gateway_init, dev is %p", dev);
-	gw =3D g_new0(struct gateway, 1);
-	gw->state =3D GATEWAY_STATE_DISCONNECTED;
 	return gw;
-
 }
 =

 gboolean gateway_is_connected(struct audio_device *dev)
@@ -326,17 +582,6 @@ gboolean gateway_is_connected(struct audio_device *dev)
 			dev->gateway->state =3D=3D GATEWAY_STATE_CONNECTED);
 }
 =

-int gateway_connect_rfcomm(struct audio_device *dev, GIOChannel *io)
-{
-	if (!io)
-		return -EINVAL;
-
-	g_io_channel_ref(io);
-	dev->gateway->rfcomm =3D io;
-
-	return 0;
-}
-
 int gateway_connect_sco(struct audio_device *dev, GIOChannel *io)
 {
 	struct gateway *gw =3D dev->gateway;
@@ -347,42 +592,38 @@ int gateway_connect_sco(struct audio_device *dev, GIO=
Channel *io)
 	gw->sco =3D g_io_channel_ref(io);
 =

 	g_io_add_watch(gw->sco, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
-                                (GIOFunc) sco_io_cb, dev);
+				 (GIOFunc) sco_io_cb, dev);
+
+	change_state(dev, GATEWAY_STATE_PLAYING);
+
 	return 0;
 }
 =

-void gateway_start_service(struct audio_device *device)
+int gateway_connect_rfcomm(struct audio_device *dev,
+		GIOChannel *chan, int ch)
 {
-	rfcomm_connect_cb(device->gateway->rfcomm, NULL, device);
+	if (!chan)
+		return -EINVAL;
+
+	dev->gateway->rfcomm =3D g_io_channel_ref(chan);
+	dev->gateway->channel =3D ch;
+
+	return 0;
 }
 =

-int gateway_close(struct audio_device *device)
+void gateway_start_service(struct audio_device *dev)
 {
-	struct gateway *gw =3D device->gateway;
-	GIOChannel *rfcomm =3D gw->rfcomm;
-	GIOChannel *sco =3D gw->sco;
-	gboolean value =3D FALSE;
+	struct gateway *gw =3D dev->gateway;
+	GError *err =3D NULL;
 =

-	if (rfcomm) {
-		g_io_channel_shutdown(rfcomm, TRUE, NULL);
-		g_io_channel_unref(rfcomm);
-		gw->rfcomm =3D NULL;
-	}
+	if (gw->rfcomm =3D=3D NULL)
+		return;
 =

-	if (sco) {
-		g_io_channel_shutdown(sco, TRUE, NULL);
-		g_io_channel_unref(sco);
-		gw->sco =3D NULL;
-		gw->sco_start_cb =3D NULL;
-		gw->sco_start_cb_data =3D NULL;
+	if (!bt_io_accept(gw->rfcomm, rfcomm_connect_cb, dev, NULL,
+							&err)) {
+		error("bt_io_accept: %s", err->message);
+		g_error_free(err);
 	}
-
-	gw->state =3D GATEWAY_STATE_DISCONNECTED;
-
-	emit_property_changed(device->conn, device->path,
-				AUDIO_GATEWAY_INTERFACE,
-				"Connected", DBUS_TYPE_BOOLEAN, &value);
-	return 0;
 }
 =

 /* These are functions to be called from unix.c for audio system
@@ -399,8 +640,12 @@ gboolean gateway_request_stream(struct audio_device *d=
ev,
 		gw->sco_start_cb_data =3D user_data;
 		get_records(dev);
 	} else if (!gw->sco) {
+		char source[128], destination[128];
+
 		gw->sco_start_cb =3D cb;
 		gw->sco_start_cb_data =3D user_data;
+		ba2str(&dev->src, source);
+		ba2str(&dev->dst, destination);
 		io =3D bt_io_connect(BT_IO_SCO, sco_connect_cb, dev, NULL, &err,
 				BT_IO_OPT_SOURCE_BDADDR, &dev->src,
 				BT_IO_OPT_DEST_BDADDR, &dev->dst,
@@ -464,4 +709,3 @@ void gateway_suspend_stream(struct audio_device *dev)
 	gw->sco_start_cb =3D NULL;
 	gw->sco_start_cb_data =3D NULL;
 }
-
diff --git a/audio/gateway.h b/audio/gateway.h
index 3b0457f..eaf6801 100644
--- a/audio/gateway.h
+++ b/audio/gateway.h
@@ -4,6 +4,7 @@
  *
  *  Copyright (C) 2006-2010  Nokia Corporation
  *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
+ *  Copyright (C) 2009-2009  Zhenhua Zhang <zhenhua.zhang@intel.com>
  *
  *
  *  This program is free software; you can redistribute it and/or modify
@@ -22,20 +23,25 @@
  *
  */
 =

-#define AUDIO_GATEWAY_INTERFACE "org.bluez.HeadsetGateway"
+#define AUDIO_GATEWAY_INTERFACE "org.bluez.HandsfreeGateway"
 =

 #define DEFAULT_HSP_HS_CHANNEL 6
 #define DEFAULT_HFP_HS_CHANNEL 7
 =

 typedef enum {
 	GATEWAY_STATE_DISCONNECTED,
-	GATEWAY_STATE_CONNECTED
+	GATEWAY_STATE_CONNECTED,
+	GATEWAY_STATE_CONNECTING,
+	GATEWAY_STATE_PLAYING,
 } gateway_state_t;
 =

 typedef void (*gateway_stream_cb_t) (struct audio_device *dev, void *user_=
data);
+
 struct gateway *gateway_init(struct audio_device *device);
+void gateway_exit();
 gboolean gateway_is_connected(struct audio_device *dev);
-int gateway_connect_rfcomm(struct audio_device *dev, GIOChannel *chan);
+int gateway_connect_rfcomm(struct audio_device *dev,
+			GIOChannel *chan, int ch);
 int gateway_connect_sco(struct audio_device *dev, GIOChannel *chan);
 void gateway_start_service(struct audio_device *device);
 gboolean gateway_request_stream(struct audio_device *dev,
diff --git a/audio/manager.c b/audio/manager.c
index 413c1f3..3ac1a60 100644
--- a/audio/manager.c
+++ b/audio/manager.c
@@ -198,7 +198,7 @@ static void handle_uuid(const char *uuidstr, struct aud=
io_device *device)
 		break;
 	case HANDSFREE_AGW_SVCLASS_ID:
 		debug("Found Handsfree AG record");
-		if (device->gateway =3D=3D NULL)
+		if (enabled.gateway && (device->gateway =3D=3D NULL))
 			device->gateway =3D gateway_init(device);
 		break;
 	case AUDIO_SINK_SVCLASS_ID:
@@ -567,8 +567,8 @@ static void hf_io_cb(GIOChannel *chan, gpointer data)
 		return;
 	}
 =

-	server_uuid =3D HFP_HS_UUID;
-	remote_uuid =3D HFP_AG_UUID;
+	server_uuid =3D HFP_AG_UUID;
+	remote_uuid =3D HFP_HS_UUID;
 	svclass =3D HANDSFREE_AGW_SVCLASS_ID;
 =

 	device =3D manager_get_device(&src, &dst, TRUE);
@@ -586,7 +586,7 @@ static void hf_io_cb(GIOChannel *chan, gpointer data)
 		goto drop;
 	}
 =

-	if (gateway_connect_rfcomm(device, chan) < 0) {
+	if (gateway_connect_rfcomm(device, chan, ch) < 0) {
 		error("Allocating new GIOChannel failed!");
 		goto drop;
 	}
@@ -905,22 +905,12 @@ static void headset_server_remove(struct btd_adapter =
*adapter)
 static int gateway_server_probe(struct btd_adapter *adapter)
 {
 	struct audio_adapter *adp;
-	const gchar *path =3D adapter_get_path(adapter);
-	int ret;
-
-	DBG("path %s", path);
 =

 	adp =3D audio_adapter_get(adapter);
 	if (!adp)
 		return -EINVAL;
 =

-	ret =3D gateway_server_init(adp);
-	if (ret < 0) {
-		audio_adapter_ref(adp);
-		return ret;
-	}
-
-	return 0;
+	return gateway_server_init(adp);
 }
 =

 static void gateway_server_remove(struct btd_adapter *adapter)
diff --git a/audio/unix.c b/audio/unix.c
index 5cf4f94..bd1a415 100644
--- a/audio/unix.c
+++ b/audio/unix.c
@@ -395,6 +395,9 @@ static void gateway_resume_complete(struct audio_device=
 *dev, void *user_data)
 	struct bt_start_stream_rsp *rsp =3D (void *) buf;
 	struct bt_new_stream_ind *ind =3D (void *) buf;
 =

+	if (!dev)
+		goto failed;
+
 	memset(buf, 0, sizeof(buf));
 	rsp->h.type =3D BT_RESPONSE;
 	rsp->h.name =3D BT_START_STREAM;
@@ -416,6 +419,11 @@ static void gateway_resume_complete(struct audio_devic=
e *dev, void *user_data)
 	}
 =

 	client->req_id =3D 0;
+	return;
+
+failed:
+	error("gateway_resume_complete: resume failed");
+	unix_ipc_error(client, BT_START_STREAM, EIO);
 }
 =

 static void headset_suspend_complete(struct audio_device *dev, void *user_=
data)
diff --git a/doc/hfp-api.txt b/doc/hfp-api.txt
new file mode 100644
index 0000000..5055046
--- /dev/null
+++ b/doc/hfp-api.txt
@@ -0,0 +1,81 @@
+Gateway hierarchy
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Service		org.bluez
+Interface	org.bluez.HandsfreeGateway
+Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
+
+This interface is available for remote devices which can function in the A=
udio
+Gateway role of the HFP profiles.  It is intended to be used with external
+telephony stacks / handlers of the HFP protocol.
+
+Methods		void Connect()
+
+			Connect to the AG service on the remote device.
+
+		void Disconnect()
+
+			Disconnect from the AG service on the remote device
+
+		dict GetProperties()
+
+			Returns all properties for the interface. See the
+			properties section for available properties.
+
+		void RegisterAgent(object path)
+
+			The object path defines the path the of the agent
+			that will be called when a new Handsfree connection
+			is established.
+
+			If an application disconnects from the bus all of its
+			registered agents will be removed.
+
+		void UnregisterAgent(object path)
+
+			This unregisters the agent that has been previously
+			registered. The object path parameter must match the
+			same value that has been used on registration.
+
+Signals		PropertyChanged(string name, variant value)
+
+			This signal indicates a changed value of the given
+			property.
+
+Properties	string State [readonly]
+
+			Indicates the state of the connection.  Possible
+			values are:
+				"disconnected"
+				"connecting"
+				"connected"
+				"playing"
+
+HandsfreeAgent hierarchy
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Service         unique name
+Interface       org.bluez.HandsfreeAgent
+Object path     freely definable
+
+Methods		void NewConnection(filedescriptor fd)
+
+			This method gets called whenever a new handsfree
+			connection has been established.  The objectpath
+			contains the object path of the remote device.  This
+			method assumes that DBus daemon with file descriptor
+			passing capability is being used.
+
+			The agent should only return successfully once the
+			establishment of the service level connection (SLC)
+			has been completed.  In the case of Handsfree this
+			means that BRSF exchange has been performed and
+			necessary initialization has been done.
+
+			Possible Errors: org.bluez.Error.InvalidArguments
+					 org.bluez.Error.Failed
+
+		void Release()
+
+			This method gets called whenever the service daemon
+			unregisters the agent.
-- =

1.6.4.4


--===============7717286344012994125==--

