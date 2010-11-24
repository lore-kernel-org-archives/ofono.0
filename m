Content-Type: multipart/mixed; boundary="===============1946795804221526649=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 1/3] sms: store pending tx pdus on disk
Date: Wed, 24 Nov 2010 14:53:20 -0800
Message-ID: <1290639202-12221-2-git-send-email-kristen@linux.intel.com>
In-Reply-To: <1290639202-12221-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1946795804221526649==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/sms.c     |   17 +++++++++++++++++
 src/smsutil.c |   26 ++++++++++++++++++++++++++
 src/smsutil.h |    3 +++
 3 files changed, 46 insertions(+), 0 deletions(-)

diff --git a/src/sms.c b/src/sms.c
index 12988c8..6eab0fa 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -52,6 +52,8 @@ static gboolean tx_next(gpointer user_data);
 =

 static GSList *g_drivers =3D NULL;
 =

+static unsigned long tx_counter =3D 0;
+
 enum message_state {
 	MESSAGE_STATE_PENDING =3D		0,
 	MESSAGE_STATE_SENT,
@@ -111,6 +113,7 @@ struct tx_queue_entry {
 	ofono_sms_txq_submit_cb_t cb;
 	void *data;
 	ofono_destroy_func destroy;
+	int id;
 };
 =

 static gboolean uuid_equal(gconstpointer v1, gconstpointer v2)
@@ -1899,6 +1902,8 @@ int __ofono_sms_txq_submit(struct ofono_sms *sms, GSL=
ist *list,
 {
 	struct message *m =3D NULL;
 	struct tx_queue_entry *entry;
+	int i;
+	GSList *l;
 =

 	entry =3D tx_queue_entry_new(list, flags);
 	if (entry =3D=3D NULL)
@@ -1923,6 +1928,8 @@ int __ofono_sms_txq_submit(struct ofono_sms *sms, GSL=
ist *list,
 			sms->ref =3D sms->ref + 1;
 	}
 =

+	entry->id =3D tx_counter++;
+
 	g_queue_push_tail(sms->txq, entry);
 =

 	if (g_queue_get_length(sms->txq) =3D=3D 1)
@@ -1931,6 +1938,16 @@ int __ofono_sms_txq_submit(struct ofono_sms *sms, GS=
List *list,
 	if (uuid)
 		memcpy(uuid, &entry->uuid, sizeof(*uuid));
 =

+	i =3D 0;
+
+	for (l =3D list; l; l =3D l->next) {
+		struct sms *s =3D l->data;
+		sms_tx_store(sms->imsi, entry->id,
+				ofono_uuid_to_str(&entry->uuid),
+				s, i);
+		i++;
+	}
+
 	if (cb)
 		cb(sms, &entry->uuid, data);
 =

diff --git a/src/smsutil.c b/src/smsutil.c
index e6dbf5f..4904419 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -48,6 +48,10 @@
 #define SMS_SR_BACKUP_PATH STORAGEDIR "/%s/sms_sr"
 #define SMS_SR_BACKUP_PATH_FILE SMS_SR_BACKUP_PATH "/%s-%s"
 =

+#define SMS_TX_BACKUP_PATH STORAGEDIR "/%s/tx_queue"
+#define SMS_TX_BACKUP_PATH_DIR SMS_TX_BACKUP_PATH "/%lu-%s"
+#define SMS_TX_BACKUP_PATH_FILE SMS_TX_BACKUP_PATH_DIR "/%03i"
+
 #define SMS_ADDR_FMT "%24[0-9A-F]"
 #define SMS_MSGID_FMT "%40[0-9A-F]"
 =

@@ -3125,6 +3129,28 @@ void status_report_assembly_expire(struct status_rep=
ort_assembly *assembly,
 	}
 }
 =

+gboolean sms_tx_store(const char *imsi, unsigned long id, const char *uuid,
+			struct sms *s, guint8 seq)
+{
+	int len;
+	unsigned char buf[177];
+
+	if (!imsi)
+		return FALSE;
+
+	len =3D sms_serialize(buf, s);
+
+	/*
+	 * file name is: imsi/order in tx_queue-uuid/order of pdus
+	 */
+	if (write_file(buf, len, SMS_BACKUP_MODE,
+				SMS_TX_BACKUP_PATH_FILE, imsi, id, uuid,
+				seq) !=3D len)
+		return FALSE;
+
+	return TRUE;
+}
+
 static inline GSList *sms_list_append(GSList *l, const struct sms *in)
 {
 	struct sms *sms;
diff --git a/src/smsutil.h b/src/smsutil.h
index 4b05313..5279489 100644
--- a/src/smsutil.h
+++ b/src/smsutil.h
@@ -516,6 +516,9 @@ void status_report_assembly_add_fragment(struct status_=
report_assembly
 void status_report_assembly_expire(struct status_report_assembly *assembly,
 					time_t before);
 =

+gboolean sms_tx_store(const char *imsi, unsigned long id, const char *uuid,
+				struct sms *s, guint8 seq);
+
 GSList *sms_text_prepare(const char *to, const char *utf8, guint16 ref,
 				gboolean use_16bit,
 				gboolean use_delivery_reports);
-- =

1.7.2.3


--===============1946795804221526649==--

