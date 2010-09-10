Content-Type: multipart/mixed; boundary="===============4038159067763179915=="
MIME-Version: 1.0
From: Petteri Tikander <petteri.tikander@ixonos.com>
Subject: [RFC PATCH v2 1/4] sms_util: status_report_expiration
Date: Fri, 10 Sep 2010 17:28:19 +0300
Message-ID: <1284128902-16727-1-git-send-email-petteri.tikander@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4038159067763179915==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/smsutil.c |   51 ++++++++++++++++++++++++++++++++++++++++++++++++---
 src/smsutil.h |    3 +--
 2 files changed, 49 insertions(+), 5 deletions(-)

diff --git a/src/smsutil.c b/src/smsutil.c
index 0de420b..ae8f1ef 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
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
-- =

1.6.3.3



--===============4038159067763179915==--

