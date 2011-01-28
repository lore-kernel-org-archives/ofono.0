Content-Type: multipart/mixed; boundary="===============9095655070603443495=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH v3 2/3] sms: delete sent sms messages from backup
Date: Fri, 28 Jan 2011 00:39:56 -0200
Message-ID: <1296182397-31963-3-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1296182397-31963-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9095655070603443495==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Based on patch from Kristen Carlson Accardi <kristen@linux.intel.com>
---
 src/sms.c     |    8 ++++++++
 src/smsutil.c |   47 +++++++++++++++++++++++++++++++++++++++++++++++
 src/smsutil.h |    6 ++++++
 3 files changed, 61 insertions(+), 0 deletions(-)

diff --git a/src/sms.c b/src/sms.c
index 87283d3..2fe67c8 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -571,6 +571,11 @@ static void tx_finished(const struct ofono_error *erro=
r, int mr, void *data)
 		goto next_q;
 	}
 =

+	if (entry->flags & OFONO_SMS_SUBMIT_FLAG_EXPOSE_DBUS)
+		sms_tx_backup_remove(sms->imsi, entry->id, entry->flags,
+						ofono_uuid_to_str(&entry->uuid),
+						entry->cur_pdu);
+
 	entry->cur_pdu +=3D 1;
 	entry->retry =3D 0;
 =

@@ -607,6 +612,9 @@ next_q:
 	if (entry->flags & OFONO_SMS_SUBMIT_FLAG_EXPOSE_DBUS) {
 		enum message_state ms;
 =

+		sms_tx_backup_free(sms->imsi, entry->id, entry->flags,
+						ofono_uuid_to_str(&entry->uuid));
+
 		if (ok)
 			ms =3D MESSAGE_STATE_SENT;
 		else
diff --git a/src/smsutil.c b/src/smsutil.c
index 3e5b7cd..db6881e 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -3172,6 +3172,53 @@ gboolean sms_tx_backup_store(const char *imsi, unsig=
ned long id,
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
+	/* skip '..' and '.' entries */
+	while (len-- > 2) {
+		struct dirent *dir =3D entries[len];
+		char *file =3D g_strdup_printf("%s/%s", path, dir->d_name);
+
+		unlink(file);
+		g_free(file);
+
+		g_free(entries[len]);
+	}
+
+	g_free(entries[1]);
+	g_free(entries[0]);
+	g_free(entries);
+
+	rmdir(path);
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
index 2ae35d7..615b380 100644
--- a/src/smsutil.h
+++ b/src/smsutil.h
@@ -521,6 +521,12 @@ gboolean sms_tx_backup_store(const char *imsi, unsigne=
d long id,
 				unsigned long flags, const char *uuid,
 				guint8 seq, const unsigned char *pdu,
 				int pdu_len, int tpdu_len);
+void sms_tx_backup_remove(const char *imsi, unsigned long id,
+				unsigned long flags, const char *uuid,
+				guint8 seq);
+void sms_tx_backup_free(const char *imsi, unsigned long id,
+				unsigned long flags, const char *uuid);
+
 GSList *sms_text_prepare(const char *to, const char *utf8, guint16 ref,
 				gboolean use_16bit,
 				gboolean use_delivery_reports);
-- =

1.7.3.5


--===============9095655070603443495==--

