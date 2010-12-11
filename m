Content-Type: multipart/mixed; boundary="===============6058597650212109664=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 1/3 v2] sms: store pending tx pdus on disk
Date: Fri, 10 Dec 2010 16:16:11 -0800
Message-ID: <1292026571-16774-1-git-send-email-kristen@linux.intel.com>
In-Reply-To: <4CFD9E42.3050109@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6058597650212109664==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/sms.c     |   15 +++++++++++++++
 src/smsutil.c |   26 ++++++++++++++++++++++++++
 src/smsutil.h |    3 +++
 3 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/src/sms.c b/src/sms.c
index 163eab0..e5e06db 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -77,6 +77,7 @@ struct ofono_sms {
 	struct sms_assembly *assembly;
 	guint ref;
 	GQueue *txq;
+	unsigned long tx_counter;
 	guint tx_source;
 	struct ofono_message_waiting *mw;
 	unsigned int mw_watch;
@@ -111,6 +112,7 @@ struct tx_queue_entry {
 	ofono_sms_txq_submit_cb_t cb;
 	void *data;
 	ofono_destroy_func destroy;
+	unsigned long id;
 };
 =

 static gboolean uuid_equal(gconstpointer v1, gconstpointer v2)
@@ -1896,6 +1898,8 @@ int __ofono_sms_txq_submit(struct ofono_sms *sms, GSL=
ist *list,
 {
 	struct message *m =3D NULL;
 	struct tx_queue_entry *entry;
+	int i;
+	GSList *l;
 =

 	entry =3D tx_queue_entry_new(list, flags);
 	if (entry =3D=3D NULL)
@@ -1920,6 +1924,8 @@ int __ofono_sms_txq_submit(struct ofono_sms *sms, GSL=
ist *list,
 			sms->ref =3D sms->ref + 1;
 	}
 =

+	entry->id =3D sms->tx_counter++;
+
 	g_queue_push_tail(sms->txq, entry);
 =

 	if (g_queue_get_length(sms->txq) =3D=3D 1)
@@ -1928,6 +1934,15 @@ int __ofono_sms_txq_submit(struct ofono_sms *sms, GS=
List *list,
 	if (uuid)
 		memcpy(uuid, &entry->uuid, sizeof(*uuid));
 =

+	if (flags & OFONO_SMS_SUBMIT_FLAG_EXPOSE_DBUS) {
+		for (i =3D 0, l =3D list; l; i++, l =3D l->next) {
+			struct sms *s =3D l->data;
+			sms_tx_store(sms->imsi, entry->id, entry->flags,
+					ofono_uuid_to_str(&entry->uuid),
+					s, i);
+		}
+	}
+
 	if (cb)
 		cb(sms, &entry->uuid, data);
 =

diff --git a/src/smsutil.c b/src/smsutil.c
index 5e1d233..9c6596f 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -48,6 +48,10 @@
 #define SMS_SR_BACKUP_PATH STORAGEDIR "/%s/sms_sr"
 #define SMS_SR_BACKUP_PATH_FILE SMS_SR_BACKUP_PATH "/%s-%s"
 =

+#define SMS_TX_BACKUP_PATH STORAGEDIR "/%s/tx_queue"
+#define SMS_TX_BACKUP_PATH_DIR SMS_TX_BACKUP_PATH "/%lu-%lu-%s"
+#define SMS_TX_BACKUP_PATH_FILE SMS_TX_BACKUP_PATH_DIR "/%03i"
+
 #define SMS_ADDR_FMT "%24[0-9A-F]"
 #define SMS_MSGID_FMT "%40[0-9A-F]"
 =

@@ -3143,6 +3147,28 @@ void status_report_assembly_expire(struct status_rep=
ort_assembly *assembly,
 	}
 }
 =

+gboolean sms_tx_store(const char *imsi, unsigned long id, unsigned long fl=
ags,
+			const char *uuid, struct sms *s, guint8 seq)
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
+	 * file name is: imsi/order in tx_queue-flags-uuid/order of pdus
+	 */
+	if (write_file(buf, len, SMS_BACKUP_MODE,
+				SMS_TX_BACKUP_PATH_FILE, imsi, id, flags, uuid,
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
index 4b6159f..46084ab 100644
--- a/src/smsutil.h
+++ b/src/smsutil.h
@@ -517,6 +517,9 @@ void status_report_assembly_add_fragment(struct status_=
report_assembly
 void status_report_assembly_expire(struct status_report_assembly *assembly,
 					time_t before);
 =

+gboolean sms_tx_store(const char *imsi, unsigned long id, unsigned long fl=
ags,
+				const char *uuid, struct sms *s, guint8 seq);
+
 GSList *sms_text_prepare(const char *to, const char *utf8, guint16 ref,
 				gboolean use_16bit,
 				gboolean use_delivery_reports);
-- =

1.7.2.3


--===============6058597650212109664==--

