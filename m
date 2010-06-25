Content-Type: multipart/mixed; boundary="===============6990762705294147642=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: [SMS D-Bus 12/23] SMS: produce a unique,
 persistent name for in-transit messages
Date: Fri, 25 Jun 2010 16:15:34 -0700
Message-ID: <a7f79c4f2e039b2185ca7e8bd232bd7f48f21b13.1277507431.git.inaky.perez-gonzalez@intel.com>
In-Reply-To: <cover.1277507431.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6990762705294147642==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>

This name will be used for persistence and D-Bus object naming. It is
not very humanly readable, but most dependable to avoid collisions.
---
 src/sms.c     |   12 ++++++++++++
 src/smsutil.h |    6 ++++++
 2 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/src/sms.c b/src/sms.c
index d4d08fa..87ea926 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -77,6 +77,9 @@ struct pending_pdu {
 };
 =

 =

+/*
+ * @name: Name for the SMS message object (used by D-Bus)
+ */
 struct tx_queue_entry {
 	struct pending_pdu *pdus;
 	unsigned char num_pdus;
@@ -86,6 +89,7 @@ struct tx_queue_entry {
 	DBusMessage *msg;
 	gboolean status_report;
 	struct sms_address receiver;
+	char *name;
 };
 =

 static void set_sca(struct ofono_sms *sms,
@@ -302,6 +306,7 @@ static DBusMessage *sms_set_property(DBusConnection *co=
nn, DBusMessage *msg,
 static void tx_queue_entry_destroy(struct tx_queue_entry *entry)
 {
 	g_free(entry->pdus);
+	g_free(entry->name);
 }
 =

 static void tx_queue_entry_destroy_free(gpointer _entry, gpointer unused)
@@ -461,6 +466,9 @@ static struct tx_queue_entry *create_tx_queue_entry(GSL=
ist *msg_list)
  * is created by create_tx_queue_entry() and g_queue_push_tail()
  * appends that entry to the SMS transmit queue. Then the tx_next()
  * function is scheduled to run to process the queue.
+ *
+ * @sms is the main SMS driver struct, @entry and @msg_list represent
+ * the current message being processed.
  */
 static DBusMessage *sms_send_message(DBusConnection *conn, DBusMessage *ms=
g,
 					void *data)
@@ -476,6 +484,7 @@ static DBusMessage *sms_send_message(DBusConnection *co=
nn, DBusMessage *msg,
 	DECLARE_SMS_MSG_ID_STRBUF(msg_id_str);
 	struct sms_address receiver;
 	DECLARE_SMS_ADDR_STR(receiver_str);
+	const char *sms_path =3D __ofono_atom_get_path(sms->atom);
 =

 	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &to,
 					DBUS_TYPE_STRING, &text,
@@ -520,6 +529,9 @@ static DBusMessage *sms_send_message(DBusConnection *co=
nn, DBusMessage *msg,
 	g_slist_free(msg_list);
 	entry->msg =3D dbus_message_ref(msg);
 	entry->status_report =3D sms->use_delivery_reports;
+	entry->name =3D g_strdup_printf(SMS_MSG_NAME_FMT, sms_path,
+				      msg_id_str, entry->num_pdus);
+	ofono_debug("sms/entry %p name %s\n", entry, entry->name);
 =

 	g_queue_push_tail(sms->txq, entry);
 =

diff --git a/src/smsutil.h b/src/smsutil.h
index 0d47385..b87dffb 100644
--- a/src/smsutil.h
+++ b/src/smsutil.h
@@ -634,4 +634,10 @@ void sms_msg_id_memcpy(void *, size_t, const struct sm=
s_msg_id *);
 /* for unit testing only */
 gsize __sms_msg_id_hash_length(void);
 =

+/*
+ * UNIQUE-ID_#PDUS -- note we use underscores as to generate a name
+ * suitable to be a D-Bus name.
+ */
+#define SMS_MSG_NAME_FMT "%s/%s_%i"
+
 #endif /* #ifndef __smsutil_h__ */
-- =

1.6.6.1


--===============6990762705294147642==--

