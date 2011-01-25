Content-Type: multipart/mixed; boundary="===============1143657998748469897=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 3/3] sms: restore pending tx messages from backup
Date: Tue, 25 Jan 2011 10:47:15 -0200
Message-ID: <1295959635-4987-4-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1295959635-4987-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1143657998748469897==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Based on patch from: Kristen Carlson Accardi <kristen@linux.intel.com>
---
 src/ofono.h   |    1 +
 src/sms.c     |   83 +++++++++++++++++++++++++++++++
 src/smsutil.c |  151 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/smsutil.h |    8 +++
 4 files changed, 243 insertions(+), 0 deletions(-)

diff --git a/src/ofono.h b/src/ofono.h
index e48dbf6..14f958e 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -245,6 +245,7 @@ enum ofono_sms_submit_flag {
 	OFONO_SMS_SUBMIT_FLAG_RECORD_HISTORY =3D	0x2,
 	OFONO_SMS_SUBMIT_FLAG_RETRY =3D		0x4,
 	OFONO_SMS_SUBMIT_FLAG_EXPOSE_DBUS =3D	0x8,
+	OFONO_SMS_SUBMIT_FLAG_REUSE_UUID =3D	0x10,
 };
 =

 typedef void (*ofono_sms_txq_submit_cb_t)(gboolean ok, void *data);
diff --git a/src/sms.c b/src/sms.c
index 403e387..1c3109c 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -798,6 +798,9 @@ static struct tx_queue_entry *tx_queue_entry_new(GSList=
 *msg_list,
 				pdu->pdu_len, pdu->tpdu_len);
 	}
 =

+	if (flags & OFONO_SMS_SUBMIT_FLAG_REUSE_UUID)
+		return entry;
+
 	if (sms_uuid_from_pdus(entry->pdus, entry->num_pdus, &entry->uuid))
 		return entry;
 =

@@ -1694,6 +1697,84 @@ static void bearer_init_callback(const struct ofono_=
error *error, void *data)
 		ofono_error("Error bootstrapping SMS Bearer Preference");
 }
 =

+static void sms_restore_tx_queue(struct ofono_sms *sms)
+{
+	GQueue *backupq;
+	struct txq_backup_entry *backup_entry;
+	struct ofono_uuid ofono_uuid;
+
+	DBG("");
+
+	backupq =3D sms_tx_queue_load(sms->imsi);
+
+	if (backupq =3D=3D NULL)
+		return;
+
+	while ((backup_entry =3D g_queue_pop_head(backupq))) {
+		struct message *m;
+		struct tx_queue_entry *txq_entry;
+
+		decode_hex_own_buf(backup_entry->uuid, -1, NULL, 0,
+							ofono_uuid.uuid);
+
+		DBG("Trying to restore: %s", ofono_uuid.uuid);
+
+		backup_entry->flags |=3D OFONO_SMS_SUBMIT_FLAG_REUSE_UUID;
+		txq_entry =3D tx_queue_entry_new(backup_entry->msg_list,
+							backup_entry->flags);
+		if (txq_entry =3D=3D NULL)
+			goto loop_out;
+
+		txq_entry->flags &=3D ~OFONO_SMS_SUBMIT_FLAG_REUSE_UUID;
+		memcpy(&txq_entry->uuid, &ofono_uuid, sizeof(ofono_uuid));
+
+		m =3D message_create(&txq_entry->uuid, sms->atom);
+		if (m =3D=3D NULL) {
+			tx_queue_entry_destroy(txq_entry);
+
+			goto loop_out;
+		}
+
+		if (message_dbus_register(m) =3D=3D FALSE) {
+			tx_queue_entry_destroy(txq_entry);
+
+			goto loop_out;
+		}
+
+		message_set_data(m, txq_entry);
+		g_hash_table_insert(sms->messages, &txq_entry->uuid, m);
+
+		if (backup_entry->msg_list->next !=3D NULL) {
+			if (sms->ref =3D=3D 65536)
+				sms->ref =3D 1;
+			else
+				sms->ref =3D sms->ref + 1;
+		}
+
+		txq_entry->id =3D sms->tx_counter++;
+		g_queue_push_tail(sms->txq, txq_entry);
+
+		/*
+		 * only messsages with OFONO_SMS_SUBMIT_FLAG_EXPOSE_DBUS flag
+		 * are restored, so we can safely emit here without checking
+		 * by this flag
+		 */
+		message_emit_added(m, OFONO_MESSAGE_MANAGER_INTERFACE);
+
+loop_out:
+		g_slist_foreach(backup_entry->msg_list, (GFunc)g_free, NULL);
+		g_slist_free(backup_entry->msg_list);
+
+		g_free(backup_entry->uuid);
+		g_free(backup_entry);
+	}
+
+	if (g_queue_get_length(sms->txq) > 0)
+		sms->tx_source =3D g_timeout_add(0, tx_next, sms);
+
+	g_queue_free(backupq);
+}
+
 /*
  * Indicate oFono that a SMS driver is ready for operation
  *
@@ -1766,6 +1847,8 @@ void ofono_sms_register(struct ofono_sms *sms)
 		sms->driver->bearer_set(sms, sms->bearer,
 						bearer_init_callback, sms);
 =

+	sms_restore_tx_queue(sms);
+
 	sms->text_handlers =3D __ofono_watchlist_new(g_free);
 	sms->datagram_handlers =3D __ofono_watchlist_new(g_free);
 =

diff --git a/src/smsutil.c b/src/smsutil.c
index f4e3049..04759f0 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -2327,6 +2327,15 @@ static gboolean sms_deserialize(const unsigned char =
*buf,
 	return sms_decode(buf + 1, len - 1, FALSE, buf[0], sms);
 }
 =

+static gboolean sms_deserialize_outgoing(const unsigned char *buf,
+		struct sms *sms, int len)
+{
+	if (len < 1)
+		return FALSE;
+
+	return sms_decode(buf + 1, len - 1, TRUE, buf[0], sms);
+}
+
 static gboolean sms_assembly_extract_address(const char *straddr,
 						struct sms_address *out)
 {
@@ -3147,6 +3156,148 @@ void status_report_assembly_expire(struct status_re=
port_assembly *assembly,
 	}
 }
 =

+/*
+ * Each directory contains a file per pdu.
+ */
+static GSList *sms_tx_load(const char *imsi, const struct dirent *dir)
+{
+	GSList *list =3D NULL;
+	struct dirent **pdus;
+	char *path;
+	int len, r;
+	unsigned char buf[177];
+	struct sms s;
+
+	if (dir->d_type !=3D DT_DIR)
+		return NULL;
+
+	path =3D g_strdup_printf(SMS_TX_BACKUP_PATH "/%s", imsi, dir->d_name);
+	len =3D scandir(path, &pdus, NULL, versionsort);
+	g_free(path);
+
+	if (len < 0)
+		return NULL;
+
+	while (len-- > 2) {
+		if (pdus[len]->d_type !=3D DT_REG)
+			goto free_pdu;
+
+		r =3D read_file(buf, sizeof(buf), SMS_TX_BACKUP_PATH "/%s/%s",
+					imsi, dir->d_name, pdus[len]->d_name);
+
+		if (r < 0)
+			goto free_pdu;
+
+		if (sms_deserialize_outgoing(buf, &s, r) =3D=3D FALSE)
+			goto free_pdu;
+
+		list =3D g_slist_prepend(list, g_memdup(&s, sizeof(s)));
+
+free_pdu:
+		g_free(pdus[len]);
+	}
+
+	g_free(pdus[1]);
+	g_free(pdus[0]);
+	g_free(pdus);
+
+	return list;
+}
+
+/*
+ * populate the queue with tx_backup_entry from stored backup
+ * data.
+ */
+GQueue *sms_tx_queue_load(const char *imsi)
+{
+	char *path;
+	GQueue *retq;
+	struct dirent **entries;
+	int len;
+	GSList *msg_list;
+	unsigned long flags;
+	unsigned long i;
+
+	if (imsi =3D=3D NULL)
+		return NULL;
+
+	path =3D g_strdup_printf(SMS_TX_BACKUP_PATH, imsi);
+	if (path =3D=3D NULL)
+		goto nomem_path;
+
+	retq =3D g_queue_new();
+	if (retq =3D=3D NULL)
+		goto nomem_retq;
+
+	len =3D scandir(path, &entries, NULL, versionsort);
+
+	if (len < 0)
+		goto nodir_exit;
+
+	while (len-- > 2) {
+		char *uuid;
+		char *oldpath;
+		struct txq_backup_entry *entry;
+		struct dirent *dir =3D entries[len];
+
+		entry =3D g_try_new0(struct txq_backup_entry, 1);
+		if (entry =3D=3D NULL)
+			goto free_dir;
+
+		msg_list =3D sms_tx_load(imsi, dir);
+
+		if (msg_list =3D=3D NULL) {
+			g_free(entry);
+
+			goto free_dir;
+		}
+
+		sscanf(dir->d_name, "%*u-%lu-%as", &flags, &uuid);
+		oldpath =3D g_strdup_printf("%s/%s", path, dir->d_name);
+
+		entry->msg_list =3D msg_list;
+		entry->uuid =3D uuid;
+		entry->flags =3D flags;
+		entry->oldpath =3D oldpath;
+
+		g_queue_push_head(retq, entry);
+
+free_dir:
+		g_free(dir);
+	}
+
+	g_free(entries[1]);
+	g_free(entries[0]);
+	g_free(entries);
+	g_free(path);
+
+	/* rename directory to reflect new position in queue */
+	for (i =3D 0; i < g_queue_get_length(retq); i++) {
+		char *newpath;
+		struct txq_backup_entry *entry =3D g_queue_peek_nth(retq, i);
+
+		newpath =3D g_strdup_printf(SMS_TX_BACKUP_PATH_DIR,
+                                                        imsi, i, entry->fl=
ags,
+							entry->uuid);
+
+		rename(entry->oldpath, newpath);
+
+		g_free(newpath);
+		g_free(entry->oldpath);
+	}
+
+	return retq;
+
+nodir_exit:
+	g_queue_free(retq);
+
+nomem_retq:
+	g_free(path);
+
+nomem_path:
+	return NULL;
+}
+
 gboolean sms_tx_store(const char *imsi, unsigned long id, unsigned long fl=
ags,
 			const char *uuid, struct sms *s, guint8 seq)
 {
diff --git a/src/smsutil.h b/src/smsutil.h
index 3d3b72a..9e56c5f 100644
--- a/src/smsutil.h
+++ b/src/smsutil.h
@@ -408,6 +408,13 @@ struct cbs_topic_range {
 	unsigned short max;
 };
 =

+struct txq_backup_entry {
+	GSList *msg_list;
+	char *uuid;
+	unsigned long flags;
+	char *oldpath;
+};
+
 static inline gboolean is_bit_set(unsigned char oct, int bit)
 {
 	int mask =3D 0x1 << bit;
@@ -524,6 +531,7 @@ void sms_tx_backup_remove(const char *imsi, unsigned lo=
ng id,
 				guint8 seq);
 void sms_tx_backup_free(const char *imsi, unsigned long id,
 				unsigned long flags, const char *uuid);
+GQueue *sms_tx_queue_load(const char *imsi);
 =

 GSList *sms_text_prepare(const char *to, const char *utf8, guint16 ref,
 				gboolean use_16bit,
-- =

1.7.3.5


--===============1143657998748469897==--

