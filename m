Content-Type: multipart/mixed; boundary="===============0472405143260232974=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH] Implement HandsfreeGateway Interface
Date: Wed, 03 Feb 2010 23:36:01 -0200
Message-ID: <1265247361-27111-1-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1265225411-19446-1-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0472405143260232974==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Create a interface where a Handsfree agent can register and use BlueZ to
handle the rfcomm and sco links.

Many thanks to Zhenhua Zhang <zhenhua.zhang@intel.com> for his
prototype on this code.
---
 audio/device.c  |    3 +
 audio/gateway.c |  413 ++++++++++++++++++++++++++++++++++++++++++---------=
----
 audio/gateway.h |   11 +-
 audio/manager.c |   19 +--
 audio/unix.c    |    8 +
 doc/hfp-api.txt |   82 +++++++++++
 6 files changed, 424 insertions(+), 112 deletions(-)
 create mode 100644 doc/hfp-api.txt

diff --git a/audio/device.c b/audio/device.c
index f7141e5..b8ea927 100644
--- a/audio/device.c
+++ b/audio/device.c
@@ -663,6 +663,9 @@ void audio_device_unregister(struct audio_device *devic=
e)
 	if (device->headset)
 		headset_unregister(device);
 =

+	if (device->gateway)
+		gateway_unregister(device);
+
 	if (device->sink)
 		sink_unregister(device);
 =

diff --git a/audio/gateway.c b/audio/gateway.c
index 3dc09ff..f8a15ac 100644
--- a/audio/gateway.c
+++ b/audio/gateway.c
@@ -5,6 +5,7 @@
  *  Copyright (C) 2006-2010  Nokia Corporation
  *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
  *  Copyright (C) 2008-2009  Leonid Movshovich <event.riga@gmail.org>
+ *  Copyright (C) 2010  ProFUSION embedded systems
  *
  *
  *  This program is free software; you can redistribute it and/or modify
@@ -52,20 +53,103 @@
 #include "btio.h"
 #include "dbus-common.h"
 =

-#define RFCOMM_BUF_SIZE 256
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
 	GIOChannel *rfcomm;
-	guint rfcomm_watch_id;
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

+static const char *state2str(gateway_state_t state)
+{
+	switch (state) {
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
+	const char *val;
+
+	if (gw->state =3D=3D new_state)
+		return;
+
+	val =3D state2str(new_state);
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
@@ -79,6 +163,7 @@ static gboolean sco_io_cb(GIOChannel *chan, GIOCondition=
 cond,
 		g_io_channel_shutdown(gw->sco, TRUE, NULL);
 		g_io_channel_unref(gw->sco);
 		gw->sco =3D NULL;
+		change_state(dev, GATEWAY_STATE_CONNECTED);
 		return FALSE;
 	}
 =

@@ -92,64 +177,99 @@ static void sco_connect_cb(GIOChannel *chan, GError *e=
rr, gpointer user_data)
 =

 	debug("at the begin of sco_connect_cb() in gateway.c");
 =

+	gw->sco =3D g_io_channel_ref(chan);
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
+		goto done;
+	}
+
+	dbus_error_init(&derr);
+	if (!dbus_set_error_from_message(&derr, reply)) {
+		debug("Agent reply: file descriptor passed successfuly");
+		change_state(dev, GATEWAY_STATE_CONNECTED);
+		goto done;
+	}
+
+	debug("Agent reply: %s", derr.message);
+
+	dbus_error_free(&derr);
+	gateway_close(dev);
+
+done:
+	dbus_message_unref(reply);
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
+	if (!gw->agent) {
+		error("Handfree Agent not registered");
+		goto fail;
+	}
 =

-	if (NULL !=3D gw->sco_start_cb)
-		gw->sco_start_cb(NULL, gw->sco_start_cb_data);
+	sk =3D g_io_channel_unix_get_fd(chan);
 =

-	gateway_close(dev);
+	gw->rfcomm =3D g_io_channel_ref(chan);
+
+	if (!agent_sendfd(gw->agent, sk, newconnection_reply, dev))
+		reply =3D g_dbus_create_error(gw->msg, ERROR_INTERFACE ".Failed",
+					"Can not pass file descriptor");
+	else
+		reply =3D dbus_message_new_method_return(gw->msg);
+
+	g_dbus_send_message(dev->conn, reply);
+	dbus_message_unref(gw->msg);
+
+	return;
+
+fail:
+	if (gw->msg) {
+		error_common_reply(dev->conn, gw->msg,
+						ERROR_INTERFACE ".Failed",
+						"Connection attempt failed");
+		dbus_message_unref(gw->msg);
+	}
+
+	change_state(dev, GATEWAY_STATE_DISCONNECTED);
 }
 =

 static void get_record_cb(sdp_list_t *recs, int perr, gpointer user_data)
 {
 	struct audio_device *dev =3D user_data;
-	DBusMessage *msg =3D dev->gateway->connect_message;
-	int ch =3D -1;
+	struct gateway *gw =3D dev->gateway;
+	int ch;
 	sdp_list_t *protos, *classes;
 	uuid_t uuid;
 	gateway_stream_cb_t sco_cb;
@@ -182,8 +302,6 @@ static void get_record_cb(sdp_list_t *recs, int perr, g=
pointer user_data)
 =

 	if (!sdp_uuid128_to_uuid(&uuid) || uuid.type !=3D SDP_UUID16 ||
 			uuid.value.uuid16 !=3D HANDSFREE_AGW_SVCLASS_ID) {
-		sdp_list_foreach(protos, (sdp_list_func_t) sdp_list_free,
-									NULL);
 		sdp_list_free(protos, NULL);
 		error("Invalid service record or not HFP");
 		goto fail;
@@ -204,25 +322,26 @@ static void get_record_cb(sdp_list_t *recs, int perr,=
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
+		error_common_reply(dev->conn, gw->msg,
+					ERROR_INTERFACE ".NotSupported",
+					"Not supported");
+		dbus_message_unref(gw->msg);
+	}
 =

-	dev->gateway->connect_message =3D NULL;
+	change_state(dev, GATEWAY_STATE_DISCONNECTED);
 =

 	sco_cb =3D dev->gateway->sco_start_cb;
 	if (sco_cb)
@@ -244,23 +363,47 @@ static DBusMessage *ag_connect(DBusConnection *conn, =
DBusMessage *msg,
 	struct audio_device *au_dev =3D (struct audio_device *) data;
 	struct gateway *gw =3D au_dev->gateway;
 =

-	debug("at the begin of ag_connect()");
-	if (gw->rfcomm)
+	if (!gw->agent)
 		return g_dbus_create_error(msg, ERROR_INTERFACE
-					".AlreadyConnected",
-					"Already Connected");
+				".Failed", "Agent not assigned");
 =

-	gw->connect_message =3D dbus_message_ref(msg);
-	if (get_records(au_dev) < 0) {
-		dbus_message_unref(gw->connect_message);
+	if (get_records(au_dev) < 0)
 		return g_dbus_create_error(msg, ERROR_INTERFACE
 					".ConnectAttemptFailed",
 					"Connect Attempt Failed");
-	}
-	debug("at the end of ag_connect()");
+
+	gw->msg =3D dbus_message_ref(msg);
+
 	return NULL;
 }
 =

+int gateway_close(struct audio_device *device)
+{
+	struct gateway *gw =3D device->gateway;
+	int sock;
+
+	if (gw->rfcomm) {
+		sock =3D g_io_channel_unix_get_fd(gw->rfcomm);
+		shutdown(sock, SHUT_RDWR);
+
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
+	change_state(device, GATEWAY_STATE_DISCONNECTED);
+
+	return 0;
+}
+
 static DBusMessage *ag_disconnect(DBusConnection *conn, DBusMessage *msg,
 					void *data)
 {
@@ -269,6 +412,9 @@ static DBusMessage *ag_disconnect(DBusConnection *conn,=
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
@@ -285,16 +431,109 @@ static DBusMessage *ag_disconnect(DBusConnection *co=
nn, DBusMessage *msg,
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
+	dict_append_entry(&dict, "State",
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
+	if (gw->agent)
+		return g_dbus_create_error(msg,
+					ERROR_INTERFACE ".AlreadyExists",
+					"Agent already exists");
+
+	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &path,
+						DBUS_TYPE_INVALID))
+		return g_dbus_create_error(msg,
+					ERROR_INTERFACE ".InvalidArguments",
+					"Invalid argument");
+
+	name =3D dbus_message_get_sender(msg);
+	agent =3D g_new0(struct hf_agent, 1);
+
+	agent->name =3D g_strdup(name);
+	agent->path =3D g_strdup(path);
+
+	agent->watch =3D g_dbus_add_disconnect_watch(conn, name,
+						agent_exited, gw, NULL);
+
+	gw->agent =3D agent;
+
+	return dbus_message_new_method_return(msg);
+}
+
+static DBusMessage *unregister_agent(DBusConnection *conn,
+				DBusMessage *msg, void *data)
+{
+	struct audio_device *device =3D data;
+	struct gateway *gw =3D device->gateway;
+
+	if (!gw->agent)
+		goto done;
+
+	if (strcmp(gw->agent->name, dbus_message_get_sender(msg)) !=3D 0)
+		return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed",
+							"Permission denied");
+
+	g_dbus_remove_watch(device->conn, gw->agent->watch);
+
+	agent_free(gw->agent);
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

@@ -303,9 +542,19 @@ static GDBusSignalTable gateway_signals[] =3D {
 	{ NULL, NULL }
 };
 =

+void gateway_unregister(struct audio_device *dev)
+{
+	if (dev->gateway->agent)
+		agent_disconnect(dev, dev->gateway->agent);
+
+	g_dbus_unregister_interface(dev->conn, dev->path,
+						AUDIO_GATEWAY_INTERFACE);
+}
+
 struct gateway *gateway_init(struct audio_device *dev)
 {
-	struct gateway *gw;
+	if (DBUS_TYPE_UNIX_FD < 0)
+		return NULL;
 =

 	if (!g_dbus_register_interface(dev->conn, dev->path,
 					AUDIO_GATEWAY_INTERFACE,
@@ -313,10 +562,7 @@ struct gateway *gateway_init(struct audio_device *dev)
 					NULL, dev, NULL))
 		return NULL;
 =

-	debug("in gateway_init, dev is %p", dev);
-	gw =3D g_new0(struct gateway, 1);
-	gw->state =3D GATEWAY_STATE_DISCONNECTED;
-	return gw;
+	return g_new0(struct gateway, 1);
 =

 }
 =

@@ -331,8 +577,7 @@ int gateway_connect_rfcomm(struct audio_device *dev, GI=
OChannel *io)
 	if (!io)
 		return -EINVAL;
 =

-	g_io_channel_ref(io);
-	dev->gateway->rfcomm =3D io;
+	dev->gateway->rfcomm =3D g_io_channel_ref(io);
 =

 	return 0;
 }
@@ -347,42 +592,25 @@ int gateway_connect_sco(struct audio_device *dev, GIO=
Channel *io)
 	gw->sco =3D g_io_channel_ref(io);
 =

 	g_io_add_watch(gw->sco, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
-                                (GIOFunc) sco_io_cb, dev);
-	return 0;
-}
+						(GIOFunc) sco_io_cb, dev);
 =

-void gateway_start_service(struct audio_device *device)
-{
-	rfcomm_connect_cb(device->gateway->rfcomm, NULL, device);
+	change_state(dev, GATEWAY_STATE_PLAYING);
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
+	if (!bt_io_accept(gw->rfcomm, rfcomm_connect_cb, dev, NULL, &err)) {
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
@@ -410,10 +638,8 @@ gboolean gateway_request_stream(struct audio_device *d=
ev,
 			g_error_free(err);
 			return FALSE;
 		}
-	} else {
-		if (cb)
-			cb(dev, user_data);
-	}
+	} else if (cb)
+		cb(dev, user_data);
 =

 	return TRUE;
 }
@@ -464,4 +690,3 @@ void gateway_suspend_stream(struct audio_device *dev)
 	gw->sco_start_cb =3D NULL;
 	gw->sco_start_cb_data =3D NULL;
 }
-
diff --git a/audio/gateway.h b/audio/gateway.h
index 3b0457f..830e8e0 100644
--- a/audio/gateway.h
+++ b/audio/gateway.h
@@ -22,20 +22,23 @@
  *
  */
 =

-#define AUDIO_GATEWAY_INTERFACE "org.bluez.HeadsetGateway"
+#define AUDIO_GATEWAY_INTERFACE "org.bluez.HandsfreeGateway"
 =

-#define DEFAULT_HSP_HS_CHANNEL 6
 #define DEFAULT_HFP_HS_CHANNEL 7
 =

 typedef enum {
 	GATEWAY_STATE_DISCONNECTED,
-	GATEWAY_STATE_CONNECTED
+	GATEWAY_STATE_CONNECTING,
+	GATEWAY_STATE_CONNECTED,
+	GATEWAY_STATE_PLAYING,
 } gateway_state_t;
 =

 typedef void (*gateway_stream_cb_t) (struct audio_device *dev, void *user_=
data);
+
+void gateway_unregister(struct audio_device *dev);
 struct gateway *gateway_init(struct audio_device *device);
 gboolean gateway_is_connected(struct audio_device *dev);
-int gateway_connect_rfcomm(struct audio_device *dev, GIOChannel *chan);
+int gateway_connect_rfcomm(struct audio_device *dev, GIOChannel *io);
 int gateway_connect_sco(struct audio_device *dev, GIOChannel *chan);
 void gateway_start_service(struct audio_device *device);
 gboolean gateway_request_stream(struct audio_device *dev,
diff --git a/audio/manager.c b/audio/manager.c
index 413c1f3..06c7d78 100644
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
@@ -794,6 +794,7 @@ static void audio_remove(struct btd_device *device)
 	devices =3D g_slist_remove(devices, dev);
 =

 	audio_device_unregister(dev);
+
 }
 =

 static struct audio_adapter *audio_adapter_ref(struct audio_adapter *adp)
@@ -905,22 +906,12 @@ static void headset_server_remove(struct btd_adapter =
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
index 0000000..8180de0
--- /dev/null
+++ b/doc/hfp-api.txt
@@ -0,0 +1,82 @@
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
+			unregisters the agent or whenever the Adapter where
+			the HandsfreeAgent registers itself is removed.
-- =

1.6.4.4


--===============0472405143260232974==--

