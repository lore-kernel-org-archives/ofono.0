Content-Type: multipart/mixed; boundary="===============3859072641831804712=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: [PATCH 6/7] Add agent interface to sms atom
Date: Mon, 27 Sep 2010 19:54:18 +0300
Message-ID: <1285606459-1297-7-git-send-email-aki.niemi@nokia.com>
In-Reply-To: <1285606459-1297-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3859072641831804712==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/sms.c |  146 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++-
 1 files changed, 143 insertions(+), 3 deletions(-)

diff --git a/src/sms.c b/src/sms.c
index e6a2f9c..d86b5ec 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -38,6 +38,8 @@
 #include "smsutil.h"
 #include "storage.h"
 =

+#include "smsagent.h"
+
 #define uninitialized_var(x) x =3D x
 =

 #define MESSAGE_MANAGER_FLAG_CACHED 0x1
@@ -76,6 +78,7 @@ struct ofono_sms {
 	GKeyFile *settings;
 	char *imsi;
 	int bearer;
+	GSList *agents;
 	const struct ofono_sms_driver *driver;
 	void *driver_data;
 	struct ofono_atom *atom;
@@ -631,6 +634,93 @@ static DBusMessage *sms_set_property(DBusConnection *c=
onn, DBusMessage *msg,
 	return __ofono_error_invalid_args(msg);
 }
 =

+static void sms_agent_removed(struct sms_agent *agent, void *data)
+{
+	struct ofono_sms *sms =3D data;
+
+	DBG("Agent %p disconnected without unregistering", agent);
+
+	sms->agents =3D g_slist_remove(sms->agents, agent);
+
+	sms_agent_destroy(agent);
+}
+
+static DBusMessage *sms_register_agent(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	struct ofono_sms *sms =3D data;
+	struct sms_agent *agent;
+	GSList *l;
+	const char *path;
+	const char *name;
+
+	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &path,
+					DBUS_TYPE_INVALID))
+		return __ofono_error_invalid_args(msg);
+
+	if (!__ofono_dbus_valid_object_path(path))
+		return __ofono_error_invalid_format(msg);
+
+	name =3D dbus_message_get_sender(msg);
+
+	for (l =3D sms->agents; l; l =3D l->next) {
+		struct sms_agent *old =3D l->data;
+
+		if (sms_agent_matches(old, path, name))
+			return __ofono_error_in_use(msg);
+	}
+
+	agent =3D sms_agent_create(path, name, sms_agent_removed, sms);
+	if (!agent)
+		return __ofono_error_failed(msg);
+
+	DBG("Registering agent %s at %s (%p)", name, path, agent);
+
+	sms->agents =3D g_slist_append(sms->agents, agent);
+
+	return dbus_message_new_method_return(msg);
+}
+
+static DBusMessage *sms_unregister_agent(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	struct ofono_sms *sms =3D data;
+	GSList *l;
+	const char *path;
+	const char *name;
+	int removed =3D 0;
+
+	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &path,
+					DBUS_TYPE_INVALID))
+		return __ofono_error_invalid_args(msg);
+
+	if (!__ofono_dbus_valid_object_path(path))
+		return __ofono_error_invalid_format(msg);
+
+	name =3D dbus_message_get_sender(msg);
+
+	DBG("Finding %s at %s", name, path);
+
+	for (l =3D sms->agents; l; l =3D l->next) {
+		struct sms_agent *agent =3D l->data;
+
+		if (!sms_agent_matches(agent, path, name))
+			continue;
+
+		DBG("Unregistering agent %s at %s, (%p)", name, path, agent);
+
+		sms->agents =3D g_slist_remove(sms->agents, agent);
+		sms_agent_destroy(agent);
+		removed =3D 1;
+		break;
+	}
+
+	if (!removed)
+		return __ofono_error_not_found(msg);
+
+	return dbus_message_new_method_return(msg);
+}
+
 /*
  * Destroy/release the contents of a 'struct tx_queue_entry'
  *
@@ -1025,6 +1115,8 @@ static GDBusMethodTable sms_manager_methods[] =3D {
 	{ "SendMessage",      "ss",  "o",             sms_send_message,
 						G_DBUS_METHOD_FLAG_ASYNC },
 	{ "GetMessages",       "",    "a(oa{sv})",    sms_get_messages },
+	{ "RegisterAgent",     "o",   "",             sms_register_agent },
+	{ "UnregisterAgent",   "o",   "",             sms_unregister_agent },
 	{ }
 };
 =

@@ -1064,6 +1156,21 @@ static gboolean compute_incoming_msgid(GSList *sms_l=
ist,
 	return TRUE;
 }
 =

+static void agent_dispatch_cb(struct sms_agent *agent,
+				enum sms_agent_result result,
+				void *data)
+{
+	struct ofono_sms *sms =3D data;
+
+	if (result =3D=3D SMS_AGENT_RESULT_OK)
+		return;
+
+	ofono_error("Dispatching agent %p failed, removing", agent);
+
+	sms->agents =3D g_slist_remove(sms->agents, agent);
+	sms_agent_destroy(agent);
+}
+
 static void dispatch_app_datagram(struct ofono_sms *sms,
 					const struct ofono_uuid *uuid,
 					int dst, int src,
@@ -1076,12 +1183,27 @@ static void dispatch_app_datagram(struct ofono_sms =
*sms,
 	time_t ts;
 	struct tm remote;
 	struct tm local;
+	GSList *l;
 =

 	ts =3D sms_scts_to_time(scts, &remote);
 	localtime_r(&ts, &local);
 =

+	for (l =3D sms->agents; l; l =3D l->next) {
+		struct sms_agent *agent =3D l->data;
+		int ret;
+
+		ret =3D sms_agent_dispatch_datagram(agent, sender, &remote, &local,
+							dst, src, buf, len,
+							agent_dispatch_cb, sms,
+							NULL);
+		if (ret < 0)
+			ofono_error("Unable to dispatch datagram to agent %p: "
+					"%d (%s)", agent, ret, strerror(-ret));
+	}
+
 	__ofono_history_datagram_received(modem, uuid, sender, dst, src,
 						&remote, &local, buf, len);
+
 }
 =

 static void dispatch_text_message(struct ofono_sms *sms,
@@ -1103,6 +1225,7 @@ static void dispatch_text_message(struct ofono_sms *s=
ms,
 	struct tm remote;
 	struct tm local;
 	const char *str =3D buf;
+	GSList *l;
 =

 	if (!message)
 		return;
@@ -1144,9 +1267,23 @@ static void dispatch_text_message(struct ofono_sms *=
sms,
 =

 	g_dbus_send_message(conn, signal);
 =

-	if (cls !=3D SMS_CLASS_0)
-		__ofono_history_sms_received(modem, uuid, str,
-						&remote, &local, message);
+	if (cls =3D=3D SMS_CLASS_0)
+		return;
+
+	for (l =3D sms->agents; l; l =3D l->next) {
+		struct sms_agent *agent =3D l->data;
+		int ret;
+
+		ret =3D sms_agent_dispatch_text(agent, str, &remote, &local,
+						message, agent_dispatch_cb,
+						sms, NULL);
+		if (ret < 0)
+			ofono_error("Unable to dispatch text to agent %p",
+					agent);
+	}
+
+	__ofono_history_sms_received(modem, uuid, str, &remote, &local,
+					message);
 }
 =

 static void sms_dispatch(struct ofono_sms *sms, GSList *sms_list)
@@ -1591,6 +1728,9 @@ static void sms_remove(struct ofono_atom *atom)
 		sms->sr_assembly =3D NULL;
 	}
 =

+	g_slist_foreach(sms->agents, (GFunc)sms_agent_destroy, NULL);
+	g_slist_free(sms->agents);
+
 	g_free(sms);
 }
 =

-- =

1.7.0.4


--===============3859072641831804712==--

