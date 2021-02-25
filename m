Content-Type: multipart/mixed; boundary="===============5774297341976482239=="
MIME-Version: 1.0
From: Christopher Talbot <chris@talbothome.com>
Subject: [PATCH 7/9] Fix Draft and Sent Bugs
Date: Wed, 24 Feb 2021 19:47:57 -0500
Message-ID: <e12700a294eb10c80f5fe8b20a8540598f3b4e18.camel@talbothome.com>
In-Reply-To: <20210225003933.2871.63570@ml01.vlan13.01.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5774297341976482239==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This fixes some bugs related to sending MMSes:
- Makes sure "sent" has an accurate time
- Allows "Draft" to Go to "Sent" on the dbus
- Allows the time to be preserved if mmsd is closed and opened in sent
and recieved messages
---
 src/mmsutil.h |  2 ++
 src/service.c | 60 +++++++++++++++++++++++++++++++++++++++------------
 2 files changed, 48 insertions(+), 14 deletions(-)

diff --git a/src/mmsutil.h b/src/mmsutil.h
index 00ecc39..ec139f1 100644
--- a/src/mmsutil.h
+++ b/src/mmsutil.h
@@ -120,12 +120,14 @@ struct mms_retrieve_conf {
 	char *priority;
 	char *msgid;
 	time_t date;
+ 	char *datestamp;
 };
 =

 struct mms_send_req {
 	enum mms_message_status status;
 	char *to;
 	time_t date;
+ 	char *datestamp;
 	char *content_type;
 	gboolean dr;
 };
diff --git a/src/service.c b/src/service.c
index dede36d..b0c2428 100644
--- a/src/service.c
+++ b/src/service.c
@@ -18,6 +18,7 @@
  *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-
1301  USA
  *
  */
+#define _XOPEN_SOURCE 700
 =

 #ifdef HAVE_CONFIG_H
 #include <config.h>
@@ -35,6 +36,8 @@
 #include <glib.h>
 #include <glib/gstdio.h>
 #include <gdbus.h>
+#include <time.h>
+#include <stdio.h>
 =

 #include <gweb/gweb.h>
 =

@@ -129,6 +132,11 @@ static DBusConnection *connection;
 =

 static guint32 transaction_id_start =3D 0;
 =

+
+static const char *time_to_str(const time_t *t);
+void debug_print(const char* s, void* data);
+
+
 static void mms_load_settings(struct mms_service *service)
 {
 	GError *error;
@@ -220,6 +228,7 @@ static void emit_msg_status_changed(const char
*path, const char *new_status)
 =

 	signal =3D dbus_message_new_signal(path, MMS_MESSAGE_INTERFACE,
 							"PropertyChange
d");
+							=

 	if (signal =3D=3D NULL)
 		return;
 =

@@ -269,6 +278,7 @@ static DBusMessage *msg_mark_read(DBusConnection
*conn,
 	g_free(state);
 =

 	g_key_file_set_boolean(meta, "info", "read", TRUE);
+	mms->rc.status =3D MMS_MESSAGE_STATUS_READ;
 =

 	mms_store_meta_close(service->identity, mms->uuid, meta, TRUE);
 =

@@ -722,6 +732,7 @@ static gboolean result_request_send_conf(struct
mms_request *request)
 =

 	g_key_file_set_string(meta, "info", "state", "sent");
 	g_key_file_set_string(meta, "info", "id", msg->sc.msgid);
+	request->msg->sr.status =3D MMS_MESSAGE_STATUS_SENT;
 =

 	mms_message_free(msg);
 =

@@ -1047,6 +1058,7 @@ static DBusMessage *send_message(DBusConnection
*conn,
 	struct mms_service *service =3D data;
 	struct mms_request *request;
 	GKeyFile *meta;
+	const char *datestr;
 =

 	msg =3D g_new0(struct mms_message, 1);
 	if (msg =3D=3D NULL)
@@ -1059,7 +1071,13 @@ static DBusMessage *send_message(DBusConnection
*conn,
 =

 	msg->sr.dr =3D service->use_delivery_reports;
 =

-	if (send_message_get_args(dbus_msg, msg) =3D=3D FALSE) {
+	time(&msg->sr.date);
+
+	datestr =3D time_to_str(&msg->sr.date);
+
+	msg->sr.datestamp =3D g_strdup(datestr);
+
+	if (send_message_get_args(dbus_msg, msg, service) =3D=3D FALSE) {
 		mms_debug("Invalid arguments");
 =

 		release_attachement_data(msg->attachments);
@@ -1099,6 +1117,7 @@ static DBusMessage *send_message(DBusConnection
*conn,
 	if (meta =3D=3D NULL)
 		goto release_request;
 =

+	g_key_file_set_string(meta, "info", "date",  msg-
>sr.datestamp);
 	g_key_file_set_string(meta, "info", "state", "draft");
 =

 	if (service->use_delivery_reports) {
@@ -1339,10 +1358,12 @@ static gboolean load_message_from_store(const
char *service_id,
 	char *state =3D NULL;
 	gboolean read_status;
 	char *data_path =3D NULL;
+	char *datestr =3D NULL;
 	gboolean success =3D FALSE;
 	gboolean tainted =3D FALSE;
 	void *pdu;
 	size_t len;
+	struct tm tm;
 =

 	meta =3D mms_store_meta_open(service_id, uuid);
 	if (meta =3D=3D NULL)
@@ -1354,6 +1375,13 @@ static gboolean load_message_from_store(const
char *service_id,
 =

 	read_status =3D g_key_file_get_boolean(meta, "info", "read",
NULL);
 =

+	datestr =3D g_key_file_get_string(meta, "info", "date", NULL);
+	if (datestr !=3D NULL) {
+		strptime(datestr, "%Y-%m-%dT%H:%M:%S%z", &tm);
+	} else {
+		mms_error("src/service.c:load_message_from_store()
There is no date stamp!");
+	}
+    =

 	data_path =3D mms_store_get_path(service_id, uuid);
 	if (data_path =3D=3D NULL)
 		goto out;
@@ -1372,25 +1400,28 @@ static gboolean load_message_from_store(const
char *service_id,
 =

 	msg->uuid =3D g_strdup(uuid);
 =

-	if (strcmp(state, "received") =3D=3D 0
-			&& msg->type =3D=3D MMS_MESSAGE_TYPE_RETRIEVE_CONF)
{
+	if (strcmp(state, "received") =3D=3D 0 && msg->type =3D=3D
MMS_MESSAGE_TYPE_RETRIEVE_CONF) {
+        msg->rc.datestamp =3D g_strdup(datestr);
+        msg->rc.date =3D mktime(&tm);
 		if (read_status =3D=3D TRUE)
 			msg->rc.status =3D MMS_MESSAGE_STATUS_READ;
 		else
 			msg->rc.status =3D MMS_MESSAGE_STATUS_RECEIVED;
-	} else if (strcmp(state, "downloaded") =3D=3D 0
-			&& msg->type =3D=3D MMS_MESSAGE_TYPE_RETRIEVE_CONF)
{
+	} else if (strcmp(state, "downloaded") =3D=3D 0 && msg->type =3D=3D
MMS_MESSAGE_TYPE_RETRIEVE_CONF) {
 		msg->rc.status =3D MMS_MESSAGE_STATUS_DOWNLOADED;
 		if (msg->transaction_id =3D=3D NULL)
 			msg->transaction_id =3D "";
-	} else if (strcmp(state, "sent") =3D=3D 0
-			&& msg->type =3D=3D MMS_MESSAGE_TYPE_SEND_REQ)
+	} else if (strcmp(state, "sent") =3D=3D 0 && msg->type =3D=3D
MMS_MESSAGE_TYPE_SEND_REQ) {
+        msg->sr.datestamp =3D g_strdup(datestr);
+        msg->sr.date =3D mktime(&tm);
 		msg->sr.status =3D MMS_MESSAGE_STATUS_SENT;
-	else if (strcmp(state, "draft") =3D=3D 0
-			&& msg->type =3D=3D MMS_MESSAGE_TYPE_SEND_REQ)
+    }
+	else if (strcmp(state, "draft") =3D=3D 0 && msg->type =3D=3D
MMS_MESSAGE_TYPE_SEND_REQ) {
+        msg->sr.datestamp =3D g_strdup(datestr);
+        msg->sr.date =3D mktime(&tm);
 		msg->sr.status =3D MMS_MESSAGE_STATUS_DRAFT;
-	else if (msg->type !=3D MMS_MESSAGE_TYPE_NOTIFICATION_IND &&
-			msg->type !=3D MMS_MESSAGE_TYPE_DELIVERY_IND)
+    }
+	else if (msg->type !=3D MMS_MESSAGE_TYPE_NOTIFICATION_IND && msg-
>type !=3D MMS_MESSAGE_TYPE_DELIVERY_IND)
 		goto out;
 =

 	success =3D TRUE;
@@ -1879,14 +1910,13 @@ static void
append_rc_msg_properties(DBusMessageIter *dict,
 static void append_sr_msg_properties(DBusMessageIter *dict,
 					struct mms_message *msg)
 {
-	const char *date =3D time_to_str(&msg->rc.date);
 	const char *status =3D mms_message_status_get_string(msg-
>sr.status);
 =

 	mms_dbus_dict_append_basic(dict, "Status",
 					DBUS_TYPE_STRING, &status);
 =

 	mms_dbus_dict_append_basic(dict, "Date",
-					DBUS_TYPE_STRING,  &date);
+					DBUS_TYPE_STRING,  &msg-
>sr.datestamp);
 =

 	if (msg->sr.to !=3D NULL)
 		append_msg_recipients(dict, msg);
@@ -2120,6 +2150,9 @@ static gboolean result_request_notify_resp(struct
mms_request *request)
 	if (meta =3D=3D NULL)
 		return FALSE;
 =

+    const char *datestr =3D time_to_str(&msg->rc.date);
+    msg->rc.datestamp =3D g_strdup(datestr);
+    g_key_file_set_string(meta, "info", "date",  msg->rc.datestamp);
 	g_key_file_set_string(meta, "info", "state", "received");
 =

 	mms_store_meta_close(request->service->identity,
@@ -2536,7 +2569,6 @@ void mms_service_bearer_notify(struct mms_service
*service, mms_bool_t active,
 	if (active =3D=3D FALSE)
 		goto interface_down;
 =

-
 	DBG("interface %s proxy %s", interface, proxy);
 =

 	if (service->web !=3D NULL) {
-- =

2.30.0

--===============5774297341976482239==--

