Content-Type: multipart/mixed; boundary="===============7156139765651571851=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH v3 1/3] sms: store pending tx pdus on disk
Date: Fri, 28 Jan 2011 00:39:55 -0200
Message-ID: <1296182397-31963-2-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1296182397-31963-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7156139765651571851==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Based on patch from Kristen Carlson Accardi <kristen@linux.intel.com>
---
 src/sms.c     |   21 +++++++++++++++++++++
 src/smsutil.c |   29 +++++++++++++++++++++++++++++
 src/smsutil.h |    4 ++++
 3 files changed, 54 insertions(+), 0 deletions(-)

diff --git a/src/sms.c b/src/sms.c
index 7224bdf..87283d3 100644
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
@@ -1822,6 +1826,23 @@ int __ofono_sms_txq_submit(struct ofono_sms *sms, GS=
List *list,
 	if (uuid)
 		memcpy(uuid, &entry->uuid, sizeof(*uuid));
 =

+	if (flags & OFONO_SMS_SUBMIT_FLAG_EXPOSE_DBUS) {
+		const char *uuid_str;
+		unsigned char i;
+
+		uuid_str =3D ofono_uuid_to_str(&entry->uuid);
+
+		for (i =3D 0; i < entry->num_pdus; i++) {
+			struct pending_pdu *pdu;
+
+			pdu =3D &entry->pdus[i];
+
+			sms_tx_backup_store(sms->imsi, entry->id, entry->flags,
+						uuid_str, i, pdu->pdu,
+						pdu->pdu_len, pdu->tpdu_len);
+		}
+	}
+
 	if (cb)
 		cb(sms, &entry->uuid, data);
 =

diff --git a/src/smsutil.c b/src/smsutil.c
index 3a54fe6..3e5b7cd 100644
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

@@ -3143,6 +3147,31 @@ void status_report_assembly_expire(struct status_rep=
ort_assembly *assembly,
 	}
 }
 =

+gboolean sms_tx_backup_store(const char *imsi, unsigned long id,
+				unsigned long flags, const char *uuid,
+				guint8 seq, const unsigned char *pdu,
+				int pdu_len, int tpdu_len)
+{
+	unsigned char buf[177];
+	int len;
+
+	if (!imsi)
+		return FALSE;
+
+	memcpy(buf + 1, pdu, pdu_len);
+	buf[0] =3D tpdu_len;
+	len =3D pdu_len + 1;
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
index dd65884..2ae35d7 100644
--- a/src/smsutil.h
+++ b/src/smsutil.h
@@ -517,6 +517,10 @@ void status_report_assembly_add_fragment(struct status=
_report_assembly
 void status_report_assembly_expire(struct status_report_assembly *assembly,
 					time_t before);
 =

+gboolean sms_tx_backup_store(const char *imsi, unsigned long id,
+				unsigned long flags, const char *uuid,
+				guint8 seq, const unsigned char *pdu,
+				int pdu_len, int tpdu_len);
 GSList *sms_text_prepare(const char *to, const char *utf8, guint16 ref,
 				gboolean use_16bit,
 				gboolean use_delivery_reports);
-- =

1.7.3.5


--===============7156139765651571851==--

