Content-Type: multipart/mixed; boundary="===============1748142235765704714=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 1/3] sms: store pending tx pdus on disk
Date: Tue, 25 Jan 2011 10:47:13 -0200
Message-ID: <1295959635-4987-2-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1295959635-4987-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1748142235765704714==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Based on patch from Kristen Carlson Accardi <kristen@linux.intel.com>
---
 src/sms.c     |   16 ++++++++++++++++
 src/smsutil.c |   25 +++++++++++++++++++++++++
 src/smsutil.h |    3 +++
 3 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/src/sms.c b/src/sms.c
index 7224bdf..5718bba 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -65,6 +65,7 @@ struct ofono_sms {
 	struct sms_assembly *assembly;
 	guint ref;
 	GQueue *txq;
+	unsigned long tx_counter;
 	guint tx_source;
 	struct ofono_message_waiting *mw;
 	unsigned int mw_watch;
@@ -103,6 +104,7 @@ struct tx_queue_entry {
 	ofono_sms_txq_submit_cb_t cb;
 	void *data;
 	ofono_destroy_func destroy;
+	unsigned long id;
 };
 =

 static gboolean uuid_equal(gconstpointer v1, gconstpointer v2)
@@ -1814,6 +1816,8 @@ int __ofono_sms_txq_submit(struct ofono_sms *sms, GSL=
ist *list,
 			sms->ref =3D sms->ref + 1;
 	}
 =

+	entry->id =3D sms->tx_counter++;
+
 	g_queue_push_tail(sms->txq, entry);
 =

 	if (sms->registered && g_queue_get_length(sms->txq) =3D=3D 1)
@@ -1822,6 +1826,18 @@ int __ofono_sms_txq_submit(struct ofono_sms *sms, GS=
List *list,
 	if (uuid)
 		memcpy(uuid, &entry->uuid, sizeof(*uuid));
 =

+	if (flags & OFONO_SMS_SUBMIT_FLAG_EXPOSE_DBUS) {
+		int i;
+		GSList *l;
+
+		for (i =3D 0, l =3D list; l; i++, l =3D l->next) {
+			struct sms *s =3D l->data;
+
+			sms_tx_store(sms->imsi, entry->id, entry->flags,
+					ofono_uuid_to_str(&entry->uuid), s, i);
+		}
+	}
+
 	if (cb)
 		cb(sms, &entry->uuid, data);
 =

diff --git a/src/smsutil.c b/src/smsutil.c
index 3a54fe6..248c1ad 100644
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

@@ -3143,6 +3147,27 @@ void status_report_assembly_expire(struct status_rep=
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
+	 * file name is: imsi/tx_queue/order-flags-uuid/pdu
+	 */
+	if (write_file(buf, len, SMS_BACKUP_MODE, SMS_TX_BACKUP_PATH_FILE,
+					imsi, id, flags, uuid, seq) !=3D len)
+		return FALSE;
+
+	return TRUE;
+}
+
 static inline GSList *sms_list_append(GSList *l, const struct sms *in)
 {
 	struct sms *sms;
diff --git a/src/smsutil.h b/src/smsutil.h
index dd65884..7d27386 100644
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

1.7.3.5


--===============1748142235765704714==--

