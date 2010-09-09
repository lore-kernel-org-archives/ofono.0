Content-Type: multipart/mixed; boundary="===============2478641272097950675=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: [PATCHv2 5/6] Add message agent support to sms atom
Date: Thu, 09 Sep 2010 12:52:55 +0300
Message-ID: <1284025976-13294-6-git-send-email-aki.niemi@nokia.com>
In-Reply-To: <1284025976-13294-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2478641272097950675==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/sms.c |  207 +++++++++++++++++++++++++++++++++++++++++++++++++++++++--=
----
 1 files changed, 187 insertions(+), 20 deletions(-)

diff --git a/src/sms.c b/src/sms.c
index 461606d..7ef2d12 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -36,6 +36,7 @@
 #include "util.h"
 #include "smsutil.h"
 #include "storage.h"
+#include "smsagent.h"
 =

 #define uninitialized_var(x) x =3D x
 =

@@ -65,6 +66,7 @@ struct ofono_sms {
 	GKeyFile *settings;
 	char *imsi;
 	int bearer;
+	GSList *agents;
 	const struct ofono_sms_driver *driver;
 	void *driver_data;
 	struct ofono_atom *atom;
@@ -121,6 +123,26 @@ static int sms_bearer_from_string(const char *str)
 	return -1;
 }
 =

+static ofono_bool_t sms_agent_type_from_string(const char *str,
+						enum sms_agent_type *outtype)
+{
+	if (!str)
+		return FALSE;
+
+	if (g_str_equal(str, "text/plain"))
+		*outtype =3D SMS_AGENT_TYPE_TEXT;
+	else if (g_str_equal(str, "text/x-vcard"))
+		*outtype =3D SMS_AGENT_TYPE_VCARD;
+	else if (g_str_equal(str, "text/calendar"))
+		*outtype =3D SMS_AGENT_TYPE_VCAL;
+	else if (g_str_equal(str, "application/vnd.oma.push"))
+		*outtype =3D SMS_AGENT_TYPE_WAP_PUSH;
+	else
+		return FALSE;
+
+	return TRUE;
+}
+
 static void set_bearer(struct ofono_sms *sms, int bearer)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
@@ -406,6 +428,91 @@ static DBusMessage *sms_set_property(DBusConnection *c=
onn, DBusMessage *msg,
 	return __ofono_error_invalid_args(msg);
 }
 =

+static void sms_agent_removed(struct sms_agent *agent, void *data)
+{
+	struct ofono_sms *sms =3D data;
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
+	const char *typestr;
+	enum sms_agent_type type;
+
+	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &path,
+					DBUS_TYPE_STRING, &typestr,
+					DBUS_TYPE_INVALID))
+		return __ofono_error_invalid_args(msg);
+
+	if (!__ofono_dbus_valid_object_path(path))
+		return __ofono_error_invalid_format(msg);
+
+	if (!sms_agent_type_from_string(typestr, &type))
+		return __ofono_error_invalid_args(msg);
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
+	agent =3D sms_agent_create(path, name, type, sms_agent_removed, sms);
+	if (!agent)
+		return __ofono_error_failed(msg);
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
+	for (l =3D sms->agents; l; l =3D l->next) {
+		struct sms_agent *agent =3D l->data;
+
+		if (!sms_agent_matches(agent, path, name))
+			continue;
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
@@ -661,6 +768,8 @@ static GDBusMethodTable sms_manager_methods[] =3D {
 							G_DBUS_METHOD_FLAG_ASYNC },
 	{ "SendMessage",	"ss",	"",		sms_send_message,
 							G_DBUS_METHOD_FLAG_ASYNC },
+	{ "RegisterAgent",	"os",	"",		sms_register_agent },
+	{ "UnregisterAgent",	"o",	"",		sms_unregister_agent },
 	{ }
 };
 =

@@ -671,12 +780,52 @@ static GDBusSignalTable sms_manager_signals[] =3D {
 	{ }
 };
 =

-static void dispatch_app_datagram(struct ofono_sms *sms, int dst, int src,
-					unsigned char *buf, long len)
+static void agent_dispatch_cb(struct sms_agent *agent,
+				enum sms_agent_result result,
+				void *data)
 {
-	DBG("Got app datagram for dst port: %d, src port: %d",
-			dst, src);
-	DBG("Contents-Len: %ld", len);
+	struct ofono_sms *sms =3D data;
+
+	if (result =3D=3D SMS_AGENT_RESULT_OK)
+		return;
+
+	sms->agents =3D g_slist_remove(sms->agents, agent);
+	sms_agent_destroy(agent);
+}
+
+static void dispatch_app_datagram(struct ofono_sms *sms, int dst, int src,
+					unsigned char *buf, long len,
+					const struct sms_address *addr,
+					const struct sms_scts *scts)
+
+{	char local_sent[128];
+	char remote_sent[128];
+	time_t ts;
+	struct tm remote;
+	struct tm local;
+	const char *local_str =3D local_sent;
+	const char *remote_str =3D remote_sent;
+	const char *sender;
+	GSList *l;
+
+	ts =3D sms_scts_to_time(scts, &remote);
+	localtime_r(&ts, &local);
+
+	strftime(local_sent, 127, "%Y-%m-%dT%H:%M:%S%z", &local);
+	local_sent[127] =3D '\0';
+
+	strftime(remote_sent, 127, "%Y-%m-%dT%H:%M:%S%z", &remote);
+	remote_sent[127] =3D '\0';
+
+	sender =3D sms_address_to_string(addr);
+
+	for (l =3D sms->agents; l; l =3D l->next) {
+		struct sms_agent *agent =3D l->data;
+
+		sms_agent_dispatch_data(agent, sender, remote_str, local_str,
+					src, dst, buf, len, agent_dispatch_cb,
+					sms, NULL);
+	}
 }
 =

 static void dispatch_text_message(struct ofono_sms *sms,
@@ -691,12 +840,16 @@ static void dispatch_text_message(struct ofono_sms *s=
ms,
 	DBusMessage *signal;
 	DBusMessageIter iter;
 	DBusMessageIter dict;
-	char buf[128];
+	char local_sent[128];
+	char remote_sent[128];
 	const char *signal_name;
 	time_t ts;
 	struct tm remote;
 	struct tm local;
-	const char *str =3D buf;
+	const char *local_str =3D local_sent;
+	const char *remote_str =3D remote_sent;
+	const char *sender;
+	GSList *l;
 =

 	if (!message)
 		return;
@@ -723,26 +876,34 @@ static void dispatch_text_message(struct ofono_sms *s=
ms,
 	ts =3D sms_scts_to_time(scts, &remote);
 	localtime_r(&ts, &local);
 =

-	strftime(buf, 127, "%Y-%m-%dT%H:%M:%S%z", &local);
-	buf[127] =3D '\0';
-	ofono_dbus_dict_append(&dict, "LocalSentTime", DBUS_TYPE_STRING, &str);
+	strftime(local_sent, 127, "%Y-%m-%dT%H:%M:%S%z", &local);
+	local_sent[127] =3D '\0';
+	ofono_dbus_dict_append(&dict, "LocalSentTime", DBUS_TYPE_STRING, &local_s=
tr);
 =

-	strftime(buf, 127, "%Y-%m-%dT%H:%M:%S%z", &remote);
-	buf[127] =3D '\0';
-	ofono_dbus_dict_append(&dict, "SentTime", DBUS_TYPE_STRING, &str);
+	strftime(remote_sent, 127, "%Y-%m-%dT%H:%M:%S%z", &remote);
+	remote_sent[127] =3D '\0';
+	ofono_dbus_dict_append(&dict, "SentTime", DBUS_TYPE_STRING, &remote_str);
 =

-	str =3D sms_address_to_string(addr);
-	ofono_dbus_dict_append(&dict, "Sender", DBUS_TYPE_STRING, &str);
+	sender =3D sms_address_to_string(addr);
+	ofono_dbus_dict_append(&dict, "Sender", DBUS_TYPE_STRING, &sender);
 =

 	dbus_message_iter_close_container(&iter, &dict);
 =

 	g_dbus_send_message(conn, signal);
 =

-	if (cls !=3D SMS_CLASS_0) {
-		__ofono_history_sms_received(modem, sms->next_msg_id, str,
-						&remote, &local, message);
-		sms->next_msg_id +=3D 1;
+	if (cls =3D=3D SMS_CLASS_0)
+		return;
+
+	for (l =3D sms->agents; l; l =3D l->next) {
+		struct sms_agent *agent =3D l->data;
+
+		sms_agent_dispatch_text(agent, sender, remote_str, local_str,
+					message, agent_dispatch_cb, sms, NULL);
 	}
+
+	__ofono_history_sms_received(modem, sms->next_msg_id, sender,
+					&remote, &local, message);
+	sms->next_msg_id +=3D 1;
 }
 =

 static void sms_dispatch(struct ofono_sms *sms, GSList *sms_list)
@@ -835,7 +996,10 @@ static void sms_dispatch(struct ofono_sms *sms, GSList=
 *sms_list)
 		if (!buf)
 			return;
 =

-		dispatch_app_datagram(sms, dstport, srcport, buf, len);
+		s =3D sms_list->data;
+
+		dispatch_app_datagram(sms, dstport, srcport, buf, len,
+					&s->deliver.oaddr, &s->deliver.scts);
 =

 		g_free(buf);
 	} else {
@@ -1157,6 +1321,9 @@ static void sms_remove(struct ofono_atom *atom)
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


--===============2478641272097950675==--

