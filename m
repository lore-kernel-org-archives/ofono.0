Content-Type: multipart/mixed; boundary="===============6066514504122676328=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: [patch 13/20] SMS: encapsulate D-Bus specific data in 'struct
 sms_msg_dbus_data'
Date: Fri, 23 Jul 2010 14:00:01 -0700
Message-ID: <5b31eccef49bc44a558f6a16cbaccbe1d36d06ee.1279918330.git.inaky.perez-gonzalez@intel.com>
In-Reply-To: <cover.1279918330.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6066514504122676328==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>

This will ease adding later on other fields that are D-Bus specific
and needed to export SMS messages in TX transit over D-Bus.
---
 src/sms.c |   21 +++++++++++++++++++--
 1 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/src/sms.c b/src/sms.c
index 5f5df04..7bde919 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -90,6 +90,17 @@ struct tx_queue_entry {
 	ofono_destroy_func destroy;
 };
 =

+/*
+ * Encapsulate information needed to export an SMS message over D-Bus.
+ *
+ * @dbus_path: path of the object in the D-Bus
+ * @dbus_msg: message this originated at
+ */
+struct sms_msg_dbus_data {
+	char *dbus_path;
+	DBusMessage *dbus_msg;
+};
+
 static const char *sms_bearer_to_string(int bearer)
 {
 	switch (bearer) {
@@ -560,7 +571,8 @@ static struct tx_queue_entry *tx_queue_entry_new(GSList=
 *msg_list)
 static void send_message_cb(gboolean ok, void *data)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
-	DBusMessage *msg =3D data;
+	struct sms_msg_dbus_data *dbus_data =3D data;
+	DBusMessage *msg =3D dbus_data->dbus_msg;
 	DBusMessage *reply;
 =

 	if (ok)
@@ -573,9 +585,11 @@ static void send_message_cb(gboolean ok, void *data)
 =

 static void send_message_destroy(void *data)
 {
-	DBusMessage *msg =3D data;
+	struct sms_msg_dbus_data *dbus_data =3D data;
+	DBusMessage *msg =3D dbus_data->dbus_msg;
 =

 	dbus_message_unref(msg);
+	g_free(dbus_data);
 }
 =

 /*
@@ -590,6 +604,9 @@ static void send_message_destroy(void *data)
  * is created by tx_queue_entry_new() and g_queue_push_tail()
  * appends that entry to the SMS transmit queue. Then the tx_next()
  * function is scheduled to run to process the queue.
+ *
+ * @sms is the main SMS driver struct, @entry and @msg_list represent
+ * the current message being processed.
  */
 static DBusMessage *sms_send_message(DBusConnection *conn, DBusMessage *ms=
g,
 					void *data)
-- =

1.6.6.1


--===============6066514504122676328==--

