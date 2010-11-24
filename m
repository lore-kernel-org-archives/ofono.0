Content-Type: multipart/mixed; boundary="===============7205377965967770225=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 2/3] sms: delete sent sms messages from backup
Date: Wed, 24 Nov 2010 14:53:21 -0800
Message-ID: <1290639202-12221-3-git-send-email-kristen@linux.intel.com>
In-Reply-To: <1290639202-12221-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7205377965967770225==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/sms.c     |    9 +++++++++
 src/smsutil.c |   38 ++++++++++++++++++++++++++++++++++++++
 src/smsutil.h |    4 ++++
 3 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/src/sms.c b/src/sms.c
index 6eab0fa..f987946 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -769,6 +769,10 @@ static void tx_finished(const struct ofono_error *erro=
r, int mr, void *data)
 		goto next_q;
 	}
 =

+	sms_tx_backup_remove(sms->imsi, entry->id,
+				ofono_uuid_to_str(&entry->uuid),
+				entry->cur_pdu);
+
 	entry->cur_pdu +=3D 1;
 	entry->retry =3D 0;
 =

@@ -813,8 +817,13 @@ next_q:
 		message_set_state(sms, &entry->uuid, ms);
 	}
 =

+	sms_tx_backup_destroy(sms->imsi, entry->id,
+			ofono_uuid_to_str(&entry->uuid));
+
 	tx_queue_entry_destroy(entry);
 =

+	tx_counter--;
+
 	if (g_queue_peek_head(sms->txq)) {
 		DBG("Scheduling next");
 		sms->tx_source =3D g_timeout_add(0, tx_next, sms);
diff --git a/src/smsutil.c b/src/smsutil.c
index 4904419..7a6b70a 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -3151,6 +3151,44 @@ gboolean sms_tx_store(const char *imsi, unsigned lon=
g id, const char *uuid,
 	return TRUE;
 }
 =

+void sms_tx_backup_destroy(const char *imsi, unsigned long id, const char =
*uuid)
+{
+	char *path;
+	struct dirent **entries;
+	int len;
+
+	path =3D g_strdup_printf(SMS_TX_BACKUP_PATH_DIR,
+					imsi, id, uuid);
+
+	len =3D scandir(path, &entries, NULL, versionsort);
+	while (len--) {
+		struct dirent *dir =3D entries[len];
+		char *file =3D g_strdup_printf("%s/%s", path, dir->d_name);
+
+		unlink(file);
+
+		g_free(file);
+		g_free(entries[len]);
+	}
+	g_free(entries);
+
+	rmdir(path);
+
+	g_free(path);
+}
+
+void sms_tx_backup_remove(const char *imsi, unsigned long id, const char *=
uuid,
+				guint8 seq)
+{
+	char *path;
+
+	path =3D g_strdup_printf(SMS_TX_BACKUP_PATH_FILE,
+					imsi, id, uuid, seq);
+	unlink(path);
+
+	g_free(path);
+}
+
 static inline GSList *sms_list_append(GSList *l, const struct sms *in)
 {
 	struct sms *sms;
diff --git a/src/smsutil.h b/src/smsutil.h
index 5279489..2e2bae6 100644
--- a/src/smsutil.h
+++ b/src/smsutil.h
@@ -518,6 +518,10 @@ void status_report_assembly_expire(struct status_repor=
t_assembly *assembly,
 =

 gboolean sms_tx_store(const char *imsi, unsigned long id, const char *uuid,
 				struct sms *s, guint8 seq);
+void sms_tx_backup_remove(const char *imsi, unsigned long id, const char *=
uuid,
+				guint8 seq);
+void sms_tx_backup_destroy(const char *imsi, unsigned long id,
+				const char *uuid);
 =

 GSList *sms_text_prepare(const char *to, const char *utf8, guint16 ref,
 				gboolean use_16bit,
-- =

1.7.2.3


--===============7205377965967770225==--

