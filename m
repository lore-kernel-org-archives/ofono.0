Content-Type: multipart/mixed; boundary="===============6229072110064442700=="
MIME-Version: 1.0
From: Petteri Tikander <petteri.tikander@ixonos.com>
Subject: [RFC PATCH 1/2] sms_util: status_report_expiration
Date: Wed, 08 Sep 2010 13:31:26 +0300
Message-ID: <1283941887-20426-1-git-send-email-petteri.tikander@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6229072110064442700==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/smsutil.c   |   55 ++++++++++++++++++++++++++++++++++++++++++++++++++-=
----
 src/smsutil.h   |    3 +--
 unit/test-sms.c |    7 +++++++
 3 files changed, 58 insertions(+), 7 deletions(-)

diff --git a/src/smsutil.c b/src/smsutil.c
index 0de420b..0e756c7 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -46,7 +46,7 @@
 #define SMS_BACKUP_PATH_FILE SMS_BACKUP_PATH_DIR "/%03i"
 =

 #define SMS_SR_BACKUP_PATH STORAGEDIR "/%s/sms_sr"
-#define SMS_SR_BACKUP_PATH_FILE SMS_SR_BACKUP_PATH "/%s-%i"
+#define SMS_SR_BACKUP_PATH_FILE SMS_SR_BACKUP_PATH "/%s-%u"
 =

 #define SMS_ADDR_FMT "%24[0-9A-F]"
 =

@@ -2761,7 +2761,7 @@ static gboolean sr_assembly_add_fragment_backup(const=
 char *imsi,
 	if (sms_address_to_hex_string(addr, straddr) =3D=3D FALSE)
 		return FALSE;
 =

-	/* storagedir/%s/sms_sr/%s-%i */
+	/* storagedir/%s/sms_sr/%s-%u */
 	if (write_file((unsigned char *) node, len, SMS_BACKUP_MODE,
 			SMS_SR_BACKUP_PATH_FILE, imsi,
 			straddr, msg_id) !=3D len)
@@ -2961,10 +2961,55 @@ void status_report_assembly_add_fragment(
 }
 =

 void status_report_assembly_expire(struct status_report_assembly *assembly,
-					time_t before, GFunc foreach_func,
-					gpointer data)
+					time_t before)
 {
-	/*TODO*/
+	GHashTable *id_table;
+	GHashTableIter iter_addr, iter_node;
+	struct sms_address addr;
+	char *straddr;
+	gpointer key;
+	unsigned int msg_id;
+	struct id_table_node *node;
+
+	g_hash_table_iter_init(&iter_addr, assembly->assembly_table);
+
+	/*
+	 * Go through different addresses. Each address can relate to
+	 * 1-n msg_ids.
+	 */
+	while (g_hash_table_iter_next(&iter_addr, (gpointer) &straddr,
+					(gpointer) &id_table)) {
+
+		sms_address_from_string(&addr, straddr);
+		g_hash_table_iter_init(&iter_node, id_table);
+
+		/* Go through different messages. */
+		while (g_hash_table_iter_next(&iter_node, &key,
+						(gpointer) &node)) {
+			msg_id =3D *(unsigned int *) key;
+
+			/*
+			 * If message is expired, removed it from the
+			 * hash-table and remove the backup-file
+			 */
+			if (node->expiration <=3D before) {
+				g_hash_table_iter_remove(&iter_node);
+
+				sr_assembly_remove_fragment_backup(
+								assembly->imsi,
+								node,
+								&addr,
+								msg_id);
+			}
+		}
+
+		/*
+		 * If all messages are removed, remove address
+		 * from the hash-table.
+		 */
+		if (g_hash_table_size(id_table) =3D=3D 0)
+			g_hash_table_iter_remove(&iter_addr);
+	}
 }
 =

 static inline GSList *sms_list_append(GSList *l, const struct sms *in)
diff --git a/src/smsutil.h b/src/smsutil.h
index 3c6b3ae..0e0ddf4 100644
--- a/src/smsutil.h
+++ b/src/smsutil.h
@@ -513,8 +513,7 @@ void status_report_assembly_add_fragment(struct status_=
report_assembly
 					unsigned char mr, time_t expiration,
 					unsigned char total_mrs);
 void status_report_assembly_expire(struct status_report_assembly *assembly,
-					time_t before, GFunc foreach_func,
-					gpointer data);
+					time_t before);
 =

 GSList *sms_text_prepare(const char *utf8, guint16 ref,
 				gboolean use_16bit, int *ref_offset,
diff --git a/unit/test-sms.c b/unit/test-sms.c
index d56cdce..0ff9cd5 100644
--- a/unit/test-sms.c
+++ b/unit/test-sms.c
@@ -1301,6 +1301,13 @@ static void test_sr_assembly()
 	sms_address_from_string(&addr, "+4915259911630");
 =

 	sra =3D status_report_assembly_new(NULL);
+
+	status_report_assembly_add_fragment(sra, 42, &addr, 4, time(NULL), 2);
+	status_report_assembly_add_fragment(sra, 42, &addr, 5, time(NULL), 2);
+
+	status_report_assembly_expire(sra, time(NULL) + 40);
+	g_assert(g_hash_table_size(sra->assembly_table) =3D=3D 0);
+
 	status_report_assembly_add_fragment(sra, 42, &addr, 4, time(NULL), 2);
 	status_report_assembly_add_fragment(sra, 42, &addr, 5, time(NULL), 2);
 =

-- =

1.6.3.3



--===============6229072110064442700==--

