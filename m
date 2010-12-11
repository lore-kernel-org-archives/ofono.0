Content-Type: multipart/mixed; boundary="===============5002806752795218179=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 2/3 v2] sms: delete sent sms messages from backup
Date: Fri, 10 Dec 2010 16:16:58 -0800
Message-ID: <1292026618-16816-1-git-send-email-kristen@linux.intel.com>
In-Reply-To: <4CFD9C64.2030609@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5002806752795218179==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/sms.c     |    7 +++++++
 src/smsutil.c |   45 +++++++++++++++++++++++++++++++++++++++++++++
 src/smsutil.h |    5 +++++
 3 files changed, 57 insertions(+), 0 deletions(-)

diff --git a/src/sms.c b/src/sms.c
index e5e06db..dd4d27c 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -766,6 +766,10 @@ static void tx_finished(const struct ofono_error *erro=
r, int mr, void *data)
 		goto next_q;
 	}
 =

+	sms_tx_backup_remove(sms->imsi, entry->id, entry->flags,
+				ofono_uuid_to_str(&entry->uuid),
+				entry->cur_pdu);
+
 	entry->cur_pdu +=3D 1;
 	entry->retry =3D 0;
 =

@@ -810,6 +814,9 @@ next_q:
 		message_set_state(sms, &entry->uuid, ms);
 	}
 =

+	sms_tx_backup_free(sms->imsi, entry->id, entry->flags,
+			ofono_uuid_to_str(&entry->uuid));
+
 	tx_queue_entry_destroy(entry);
 =

 	if (g_queue_peek_head(sms->txq)) {
diff --git a/src/smsutil.c b/src/smsutil.c
index 9c6596f..09da657 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -3169,6 +3169,51 @@ gboolean sms_tx_store(const char *imsi, unsigned lon=
g id, unsigned long flags,
 	return TRUE;
 }
 =

+void sms_tx_backup_free(const char *imsi, unsigned long id,
+				unsigned long flags, const char *uuid)
+{
+	char *path;
+	struct dirent **entries;
+	int len;
+
+	path =3D g_strdup_printf(SMS_TX_BACKUP_PATH_DIR,
+					imsi, id, flags, uuid);
+
+	len =3D scandir(path, &entries, NULL, versionsort);
+
+	if (len < 0)
+		return;
+
+	while (len--) {
+		struct dirent *dir =3D entries[len];
+		char *file =3D g_strdup_printf("%s/%s", path, dir->d_name);
+
+		unlink(file);
+
+		g_free(file);
+		g_free(entries[len]);
+	}
+
+	g_free(entries);
+
+	rmdir(path);
+
+	g_free(path);
+}
+
+void sms_tx_backup_remove(const char *imsi, unsigned long id,
+				unsigned long flags, const char *uuid,
+				guint8 seq)
+{
+	char *path;
+
+	path =3D g_strdup_printf(SMS_TX_BACKUP_PATH_FILE,
+					imsi, id, flags, uuid, seq);
+	unlink(path);
+
+	g_free(path);
+}
+
 static inline GSList *sms_list_append(GSList *l, const struct sms *in)
 {
 	struct sms *sms;
diff --git a/src/smsutil.h b/src/smsutil.h
index 46084ab..fa4e453 100644
--- a/src/smsutil.h
+++ b/src/smsutil.h
@@ -519,6 +519,11 @@ void status_report_assembly_expire(struct status_repor=
t_assembly *assembly,
 =

 gboolean sms_tx_store(const char *imsi, unsigned long id, unsigned long fl=
ags,
 				const char *uuid, struct sms *s, guint8 seq);
+void sms_tx_backup_remove(const char *imsi, unsigned long id,
+				unsigned long flags, const char *uuid,
+				guint8 seq);
+void sms_tx_backup_free(const char *imsi, unsigned long id,
+				unsigned long flags, const char *uuid);
 =

 GSList *sms_text_prepare(const char *to, const char *utf8, guint16 ref,
 				gboolean use_16bit,
-- =

1.7.2.3


--===============5002806752795218179==--

