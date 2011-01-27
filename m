Content-Type: multipart/mixed; boundary="===============8206367443619731019=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH v2 3/3] sms: restore pending tx messages from backup
Date: Thu, 27 Jan 2011 16:43:03 -0200
Message-ID: <1296153783-2633-4-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1296153783-2633-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8206367443619731019==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Based on patch from: Kristen Carlson Accardi <kristen@linux.intel.com>
---
 src/ofono.h   |    1 +
 src/sms.c     |   67 +++++++++++++++++++++
 src/smsutil.c |  185 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/smsutil.h |    8 +++
 4 files changed, 261 insertions(+), 0 deletions(-)

diff --git a/src/ofono.h b/src/ofono.h
index df20103..6ba0187 100644
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
index 2fe67c8..7b85257 100644
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

@@ -1694,6 +1697,68 @@ static void bearer_init_callback(const struct ofono_=
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
+		txq_entry->id =3D sms->tx_counter++;
+		g_queue_push_tail(sms->txq, txq_entry);
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
@@ -1766,6 +1831,8 @@ void ofono_sms_register(struct ofono_sms *sms)
 		sms->driver->bearer_set(sms, sms->bearer,
 						bearer_init_callback, sms);
 =

+	sms_restore_tx_queue(sms);
+
 	sms->text_handlers =3D __ofono_watchlist_new(g_free);
 	sms->datagram_handlers =3D __ofono_watchlist_new(g_free);
 =

diff --git a/src/smsutil.c b/src/smsutil.c
index 72f498a..52219b4 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -34,6 +34,7 @@
 =

 #include <glib.h>
 =

+#include <ofono/types.h>
 #include "util.h"
 #include "storage.h"
 #include "smsutil.h"
@@ -2327,6 +2328,15 @@ static gboolean sms_deserialize(const unsigned char =
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
@@ -3147,6 +3157,181 @@ void status_report_assembly_expire(struct status_re=
port_assembly *assembly,
 	}
 }
 =

+static int sms_tx_load_filter(const struct dirent *dent)
+{
+	char *endp;
+	guint8 seq;
+
+	if (dent->d_type !=3D DT_REG)
+		return 0;
+
+	seq =3D strtol(dent->d_name, &endp, 10);
+
+	if (*endp !=3D '\0')
+		return 0;
+
+	return 1;
+}
+
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
+	len =3D scandir(path, &pdus, sms_tx_load_filter, versionsort);
+	g_free(path);
+
+	if (len < 0)
+		return NULL;
+
+	while (len--) {
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
+	g_free(pdus);
+
+	return list;
+}
+
+static int sms_tx_queue_filter(const struct dirent *dirent)
+{
+	if (dirent->d_type !=3D DT_DIR)
+		return 0;
+
+	if (!strcmp(dirent->d_name, ".") || !strcmp(dirent->d_name, ".."))
+		return 0;
+
+	return 1;
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
+	len =3D scandir(path, &entries, sms_tx_queue_filter, versionsort);
+
+	if (len < 0)
+		goto nodir_exit;
+
+	while (len--) {
+		char *uuid;
+		char *oldpath;
+		struct txq_backup_entry *entry;
+		struct dirent *dir =3D entries[len];
+
+		if (sscanf(dir->d_name, "%*u-%lu-%as", &flags, &uuid) !=3D 2)
+			goto err_free_dir;
+
+		if (strlen(uuid) !=3D OFONO_SHA1_UUID_LEN * 2)
+			goto err_free_uuid;
+
+		entry =3D g_try_new0(struct txq_backup_entry, 1);
+		if (entry =3D=3D NULL)
+			goto err_free_uuid;
+
+		oldpath =3D g_strdup_printf("%s/%s", path, dir->d_name);
+		if (oldpath =3D=3D NULL)
+			goto err_free_entry;
+
+		msg_list =3D sms_tx_load(imsi, dir);
+		if (msg_list =3D=3D NULL)
+			goto err_free_oldpath;
+
+		entry->msg_list =3D msg_list;
+		entry->uuid =3D uuid;
+		entry->flags =3D flags;
+		entry->oldpath =3D oldpath;
+
+		g_queue_push_head(retq, entry);
+
+		g_free(dir);
+
+		continue;
+
+err_free_oldpath:
+		g_free(oldpath);
+err_free_entry:
+		g_free(entry);
+err_free_uuid:
+		g_free(uuid);
+err_free_dir:
+		g_free(dir);
+	}
+
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
 gboolean sms_tx_backup_store(const char *imsi, unsigned long id,
 			unsigned long flags, const char *uuid, guint8 seq,
 			const unsigned char *pdu, int pdu_len, int tpdu_len)
diff --git a/src/smsutil.h b/src/smsutil.h
index 5857d31..6d0179d 100644
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
@@ -527,6 +534,7 @@ void sms_tx_backup_remove(const char *imsi, unsigned lo=
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


--===============8206367443619731019==--

