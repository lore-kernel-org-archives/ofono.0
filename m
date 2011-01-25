Content-Type: multipart/mixed; boundary="===============7448521513924317701=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 2/3] sms: delete sent sms messages from backup
Date: Tue, 25 Jan 2011 10:47:14 -0200
Message-ID: <1295959635-4987-3-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1295959635-4987-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7448521513924317701==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Based on patch from Kristen Carlson Accardi <kristen@linux.intel.com>
---
 src/sms.c     |    8 ++++++++
 src/smsutil.c |   47 +++++++++++++++++++++++++++++++++++++++++++++++
 src/smsutil.h |    5 +++++
 3 files changed, 60 insertions(+), 0 deletions(-)

diff --git a/src/sms.c b/src/sms.c
index 5718bba..403e387 100644
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
index 248c1ad..f4e3049 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -3168,6 +3168,53 @@ gboolean sms_tx_store(const char *imsi, unsigned lon=
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
index 7d27386..3d3b72a 100644
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

1.7.3.5


--===============7448521513924317701==--

