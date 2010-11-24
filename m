Content-Type: multipart/mixed; boundary="===============8800062067032206018=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 3/3] sms: restore pending tx messages from backup
Date: Wed, 24 Nov 2010 14:53:22 -0800
Message-ID: <1290639202-12221-4-git-send-email-kristen@linux.intel.com>
In-Reply-To: <1290639202-12221-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8800062067032206018==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/ofono.h   |    1 +
 src/sms.c     |   38 +++++++++++++++++++
 src/smsutil.c |  116 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/smsutil.h |    6 +++
 4 files changed, 161 insertions(+), 0 deletions(-)

diff --git a/src/ofono.h b/src/ofono.h
index d1a4bdc..4777f70 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -241,6 +241,7 @@ enum ofono_sms_submit_flag {
 	OFONO_SMS_SUBMIT_FLAG_RECORD_HISTORY =3D	0x2,
 	OFONO_SMS_SUBMIT_FLAG_RETRY =3D		0x4,
 	OFONO_SMS_SUBMIT_FLAG_EXPOSE_DBUS =3D	0x8,
+	OFONO_SMS_SUBMIT_FLAG_REUSE_UUID =3D	0x10,
 };
 =

 typedef void (*ofono_sms_txq_submit_cb_t)(gboolean ok, void *data);
diff --git a/src/sms.c b/src/sms.c
index f987946..be710b1 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -1814,6 +1814,40 @@ static void bearer_init_callback(const struct ofono_=
error *error, void *data)
 		ofono_error("Error bootstrapping SMS Bearer Preference");
 }
 =

+static void sms_restore_tx_queue(struct ofono_sms *sms)
+{
+	GQueue *backupq;
+	unsigned int flags;
+	struct txq_backup_entry *entry;
+	struct ofono_uuid ofono_uuid;
+
+	DBG("");
+
+	flags =3D OFONO_SMS_SUBMIT_FLAG_RECORD_HISTORY;
+	flags |=3D OFONO_SMS_SUBMIT_FLAG_RETRY;
+	flags |=3D OFONO_SMS_SUBMIT_FLAG_REUSE_UUID;
+
+	if (sms->use_delivery_reports)
+		flags |=3D OFONO_SMS_SUBMIT_FLAG_REQUEST_SR;
+
+	backupq =3D sms_tx_queue_load(sms->imsi);
+
+	while ((entry =3D g_queue_pop_head(backupq))) {
+		decode_hex_own_buf(entry->uuid, -1, NULL, 0, ofono_uuid.uuid);
+
+		__ofono_sms_txq_submit(sms, entry->msg_list, flags,
+					&ofono_uuid, NULL, NULL);
+
+		g_slist_foreach(entry->msg_list, (GFunc)g_free, NULL);
+		g_slist_free(entry->msg_list);
+
+		g_free(entry->uuid);
+		g_free(entry);
+	}
+
+	g_queue_free(backupq);
+}
+
 /*
  * Indicate oFono that a SMS driver is ready for operation
  *
@@ -1877,6 +1911,7 @@ void ofono_sms_register(struct ofono_sms *sms)
 	if (sms->driver->bearer_set)
 		sms->driver->bearer_set(sms, sms->bearer,
 						bearer_init_callback, sms);
+	sms_restore_tx_queue(sms);
 =

 	sms->text_handlers =3D __ofono_watchlist_new(g_free);
 	sms->datagram_handlers =3D __ofono_watchlist_new(g_free);
@@ -1918,6 +1953,9 @@ int __ofono_sms_txq_submit(struct ofono_sms *sms, GSL=
ist *list,
 	if (entry =3D=3D NULL)
 		return -ENOMEM;
 =

+	if (flags & OFONO_SMS_SUBMIT_FLAG_REUSE_UUID)
+		memcpy(&entry->uuid, uuid, sizeof(*uuid));
+
 	if (flags & OFONO_SMS_SUBMIT_FLAG_EXPOSE_DBUS) {
 		m =3D message_create(&entry->uuid);
 		if (m =3D=3D NULL)
diff --git a/src/smsutil.c b/src/smsutil.c
index 7a6b70a..188b96e 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -2309,6 +2309,15 @@ static gboolean sms_deserialize(const unsigned char =
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
@@ -3129,6 +3138,113 @@ void status_report_assembly_expire(struct status_re=
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
+	int len, i, r;
+	unsigned char buf[177];
+	struct sms s;
+
+	if (dir->d_type !=3D DT_DIR)
+		return NULL;
+
+	path =3D g_strdup_printf(SMS_TX_BACKUP_PATH "/%s",
+			imsi, dir->d_name);
+
+	len =3D scandir(path, &pdus, NULL, versionsort);
+	g_free(path);
+
+	if (len < 0)
+		return NULL;
+
+	for (i =3D 0; i < len; i++) {
+		if (pdus[i]->d_type !=3D DT_REG)
+			continue;
+
+		if ((strcmp(dir->d_name, ".") =3D=3D 0) ||
+				(strcmp(dir->d_name, "..") =3D=3D 0))
+			continue;
+
+		r =3D read_file(buf, sizeof(buf), SMS_TX_BACKUP_PATH "/%s/%s",
+				imsi, dir->d_name, pdus[i]->d_name);
+		if (r < 0)
+			continue;
+
+		if (sms_deserialize_outgoing(buf, &s, r) =3D=3D FALSE)
+			continue;
+
+		list =3D g_slist_prepend(list, g_memdup(&s, sizeof(s)));
+	}
+
+	for (i =3D 0; i < len; i++)
+		g_free(pdus[i]);
+
+	g_free(pdus);
+
+	return g_slist_reverse(list);
+}
+
+/*
+ * populate the queue with tx_backup_entry from stored backup
+ * data.
+ */
+GQueue *sms_tx_queue_load(const char *imsi)
+{
+	char *path;
+	struct dirent **entries;
+	int len;
+	GSList *msg_list;
+	char *uuid;
+	GQueue *retq;
+
+	retq =3D g_queue_new();
+	if (retq =3D=3D NULL)
+		return NULL;
+
+	if (imsi) {
+		/* Restore state from backup */
+		path =3D g_strdup_printf(SMS_TX_BACKUP_PATH, imsi);
+		len =3D scandir(path, &entries, NULL, versionsort);
+		g_free(path);
+
+		if (len < 0)
+			return retq;
+
+		while (len--) {
+			struct txq_backup_entry *entry;
+
+			struct dirent *dir =3D entries[len];
+
+			msg_list =3D sms_tx_load(imsi, dir);
+
+			sscanf(dir->d_name, "%*u-%as", &uuid);
+
+			g_free(entries[len]);
+
+			if (g_slist_length(msg_list) =3D=3D 0)
+				continue;
+
+			entry =3D g_try_new0(struct txq_backup_entry, 1);
+			if (entry =3D=3D NULL)
+				continue;
+
+			entry->msg_list =3D msg_list;
+			entry->uuid =3D uuid;
+
+			g_queue_push_head(retq, entry);
+		}
+
+		g_free(entries);
+	}
+
+	return retq;
+}
+
 gboolean sms_tx_store(const char *imsi, unsigned long id, const char *uuid,
 			struct sms *s, guint8 seq)
 {
diff --git a/src/smsutil.h b/src/smsutil.h
index 2e2bae6..8d579a7 100644
--- a/src/smsutil.h
+++ b/src/smsutil.h
@@ -407,6 +407,11 @@ struct cbs_topic_range {
 	unsigned short max;
 };
 =

+struct txq_backup_entry {
+	GSList *msg_list;
+	char *uuid;
+};
+
 static inline gboolean is_bit_set(unsigned char oct, int bit)
 {
 	int mask =3D 0x1 << bit;
@@ -522,6 +527,7 @@ void sms_tx_backup_remove(const char *imsi, unsigned lo=
ng id, const char *uuid,
 				guint8 seq);
 void sms_tx_backup_destroy(const char *imsi, unsigned long id,
 				const char *uuid);
+GQueue *sms_tx_queue_load(const char *imsi);
 =

 GSList *sms_text_prepare(const char *to, const char *utf8, guint16 ref,
 				gboolean use_16bit,
-- =

1.7.2.3


--===============8800062067032206018==--

