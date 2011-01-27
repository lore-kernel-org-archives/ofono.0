Content-Type: multipart/mixed; boundary="===============3790639760779375299=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH v2 2/3] sms: delete sent sms messages from backup
Date: Thu, 27 Jan 2011 16:43:02 -0200
Message-ID: <1296153783-2633-3-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1296153783-2633-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3790639760779375299==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Based on patch from Kristen Carlson Accardi <kristen@linux.intel.com>
---
 src/sms.c     |    8 ++++++++
 src/smsutil.c |   47 +++++++++++++++++++++++++++++++++++++++++++++++
 src/smsutil.h |    7 +++++++
 3 files changed, 62 insertions(+), 0 deletions(-)

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
index 54a2b9f..72f498a 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -3171,6 +3171,53 @@ gboolean sms_tx_backup_store(const char *imsi, unsig=
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
index 0594195..5857d31 100644
--- a/src/smsutil.h
+++ b/src/smsutil.h
@@ -520,6 +520,13 @@ void status_report_assembly_expire(struct status_repor=
t_assembly *assembly,
 gboolean sms_tx_backup_store(const char *imsi, unsigned long id,
 			unsigned long flags, const char *uuid, guint8 seq,
 			const unsigned char *pdu, int pdu_len, int tpdu_len);
+gboolean sms_tx_store(const char *imsi, unsigned long id, unsigned long fl=
ags,
+				const char *uuid, struct sms *s, guint8 seq);
+void sms_tx_backup_remove(const char *imsi, unsigned long id,
+				unsigned long flags, const char *uuid,
+				guint8 seq);
+void sms_tx_backup_free(const char *imsi, unsigned long id,
+				unsigned long flags, const char *uuid);
 =

 GSList *sms_text_prepare(const char *to, const char *utf8, guint16 ref,
 				gboolean use_16bit,
-- =

1.7.3.5


--===============3790639760779375299==--

