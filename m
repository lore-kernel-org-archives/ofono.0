Content-Type: multipart/mixed; boundary="===============8696160498800383659=="
MIME-Version: 1.0
From: Petteri Tikander <petteri.tikander@ixonos.com>
Subject: [RFC PATCH v2 2/4] smsutil: storing/loading sms status report over
 reboot
Date: Thu, 19 Aug 2010 20:41:06 +0300
Message-ID: <1282239666-2659-1-git-send-email-petteri.tikander@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8696160498800383659==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/smsutil.c |  192 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++--
 src/smsutil.h |    2 +-
 2 files changed, 188 insertions(+), 6 deletions(-)

diff --git a/src/smsutil.c b/src/smsutil.c
index c60b8ec..b001a1d 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -45,6 +45,10 @@
 #define SMS_BACKUP_PATH_DIR SMS_BACKUP_PATH "/%s-%i-%i"
 #define SMS_BACKUP_PATH_FILE SMS_BACKUP_PATH_DIR "/%03i"
 =

+#define SMS_SR_BACKUP_PATH STORAGEDIR "/%s/sms_sr"
+#define SMS_SR_BACKUP_PATH_DIR SMS_SR_BACKUP_PATH "/%s"
+#define SMS_SR_BACKUP_PATH_FILE SMS_SR_BACKUP_PATH_DIR "/%i"
+
 #define SMS_ADDR_FMT "%24[0-9A-F]"
 =

 static GSList *sms_assembly_add_fragment_backup(struct sms_assembly *assem=
bly,
@@ -2413,7 +2417,7 @@ static void sms_assembly_backup_free(struct sms_assem=
bly *assembly,
 {
 	char *path;
 	int seq;
-	char straddr[25];
+	DECLARE_SMS_ADDR_STR(straddr);
 =

 	if (!assembly->imsi)
 		return;
@@ -2642,20 +2646,182 @@ void sms_assembly_expire(struct sms_assembly *asse=
mbly, time_t before)
 	}
 }
 =

+static void sr_assembly_load_backup(GHashTable *assembly_table,
+					const char *imsi,
+					const struct dirent *addr_dir)
+{
+	char *path;
+	struct dirent **ids;
+	struct sms_address addr;
+	DECLARE_SMS_ADDR_STR(straddr);
+	struct id_table_node *node;
+	GHashTable *id_table;
+	int len;
+	int r;
+	char *assembly_table_key;
+	unsigned int *id_table_key;
+	struct stat segment_stat;
+
+	if (addr_dir->d_type !=3D DT_DIR)
+		return;
+
+	/* Max of SMS address size is 12 bytes, hex encoded */
+	if (sscanf(addr_dir->d_name, SMS_ADDR_FMT, straddr) < 1)
+		return;
+
+	if (sms_assembly_extract_address(straddr, &addr) =3D=3D FALSE)
+		return;
+
+	/* Go through different msg_ids. */
+	path =3D g_strdup_printf(SMS_SR_BACKUP_PATH "/%s", imsi,
+							addr_dir->d_name);
+	len =3D scandir(path, &ids, NULL, versionsort);
+
+	g_free(path);
+
+	if (len < 0)
+		return;
+
+	id_table =3D g_hash_table_new_full(g_int_hash, g_int_equal,
+							g_free, g_free);
+
+	assembly_table_key =3D g_try_malloc(sizeof(addr.address));
+
+	if (assembly_table_key =3D=3D NULL)
+		return;
+
+	assembly_table_key =3D g_strdup(sms_address_to_string(&addr));
+	g_hash_table_insert(assembly_table, assembly_table_key, id_table);
+
+	while (len--) {
+		path =3D g_strdup_printf(SMS_SR_BACKUP_PATH "/%s/%s",
+				imsi, addr_dir->d_name, ids[len]->d_name);
+
+		node =3D g_new0(struct id_table_node, 1);
+
+		r =3D read_file((unsigned char *) node,
+				sizeof(struct id_table_node),
+				SMS_SR_BACKUP_PATH "/%s/%s",
+				imsi, addr_dir->d_name, ids[len]->d_name);
+
+		if (r < 0) {
+			g_free(path);
+			g_free(ids[len]);
+			g_free(node);
+			continue;
+		}
+
+		r =3D stat(path, &segment_stat);
+
+		if (r !=3D 0) {
+			g_free(path);
+			g_free(ids[len]);
+			g_free(node);
+			continue;
+		}
+
+		/* Node ready, create key and add them to the table */
+		id_table_key =3D g_new0(unsigned int, 1);
+		*id_table_key =3D atoi(ids[len]->d_name);
+
+		g_hash_table_insert(id_table, id_table_key, node);
+
+		g_free(path);
+		g_free(ids[len]);
+	}
+	g_free(ids);
+}
+
 struct status_report_assembly *status_report_assembly_new(const char *imsi)
 {
+	char *path;
+	int len;
+	struct dirent **addresses;
 	struct status_report_assembly *ret =3D
 				g_new0(struct status_report_assembly, 1);
 =

 	ret->assembly_table =3D g_hash_table_new_full(g_str_hash, g_str_equal,
 				g_free, (GDestroyNotify)g_hash_table_destroy);
 =

-	if (imsi)
+	if (imsi) {
 		ret->imsi =3D imsi;
 =

+		/* Restore state from backup */
+		path =3D g_strdup_printf(SMS_SR_BACKUP_PATH, imsi);
+		len =3D scandir(path, &addresses, NULL, alphasort);
+
+		g_free(path);
+
+		if (len < 0)
+			return ret;
+
+		/* Go through different addresses. Each address can relate to
+		 * 1-n msg_ids.
+		 */
+
+		while (len--) {
+			sr_assembly_load_backup(ret->assembly_table, imsi,
+								addresses[len]);
+			g_free(addresses[len]);
+		}
+
+		g_free(addresses);
+	}
+
 	return ret;
 }
 =

+static gboolean sr_assembly_add_fragment_backup(const char *imsi,
+					const struct id_table_node *node,
+					const struct sms_address *addr,
+					unsigned int msg_id)
+{
+	int len =3D sizeof(struct id_table_node);
+	DECLARE_SMS_ADDR_STR(straddr);
+
+	if (!imsi)
+		return FALSE;
+
+	if (sms_address_to_hex_string(addr, straddr) =3D=3D FALSE)
+		return FALSE;
+
+	/* storagedir/%s/sms_sr/%s/%i */
+	if (write_file((unsigned char *) node, len, SMS_BACKUP_MODE,
+			SMS_SR_BACKUP_PATH_FILE, imsi,
+			straddr, msg_id) !=3D len)
+		return FALSE;
+
+	return TRUE;
+}
+
+static gboolean sr_assembly_remove_fragment_backup(const char *imsi,
+					const struct id_table_node *node,
+					const struct sms_address *addr,
+					unsigned int msg_id)
+{
+	char *path;
+	DECLARE_SMS_ADDR_STR(straddr);
+
+	if (!imsi)
+		return FALSE;
+
+	if (sms_address_to_hex_string(addr, straddr) =3D=3D FALSE)
+		return FALSE;
+
+	path =3D g_strdup_printf(SMS_SR_BACKUP_PATH_FILE, imsi, straddr, msg_id);
+
+	unlink(path);
+	g_free(path);
+
+	path =3D g_strdup_printf(SMS_SR_BACKUP_PATH_DIR, imsi, straddr);
+
+	/* If the address does not have relating msg_ids anymore, remove it */
+	rmdir(path);
+	g_free(path);
+
+	return TRUE;
+}
+
 void status_report_assembly_free(struct status_report_assembly *assembly)
 {
 	g_hash_table_destroy(assembly->assembly_table);
@@ -2698,6 +2864,7 @@ gboolean status_report_assembly_report(struct status_=
report_assembly *assembly,
 	GHashTableIter iter;
 	gboolean pending;
 	int i;
+	unsigned int msg_id;
 =

 	/* We ignore temporary or tempfinal status reports */
 	if (sr_st_to_delivered(status_report->status_report.st,
@@ -2714,7 +2881,6 @@ gboolean status_report_assembly_report(struct status_=
report_assembly *assembly,
 	g_hash_table_iter_init(&iter, id_table);
 	while (g_hash_table_iter_next(&iter, &key, &value)) {
 		node =3D value;
-
 		if (node->mrs[offset] & bit)
 			break;
 =

@@ -2743,14 +2909,29 @@ gboolean status_report_assembly_report(struct statu=
s_report_assembly *assembly,
 		}
 	}
 =

-	if (pending =3D=3D TRUE && node->deliverable =3D=3D TRUE)
+	msg_id =3D *(unsigned int *) key;
+
+	if (pending =3D=3D TRUE && node->deliverable =3D=3D TRUE) {
+		/* More status reports expected, and already received
+		 * reports completed. Update backup file.
+		 */
+		sr_assembly_add_fragment_backup(
+					assembly->imsi, node,
+					&status_report->status_report.raddr,
+					msg_id);
+
 		return FALSE;
+	}
 =

 	if (out_delivered)
 		*out_delivered =3D node->deliverable;
 =

 	if (out_id)
-		*out_id =3D *((unsigned int *) key);
+		*out_id =3D msg_id;
+
+	sr_assembly_remove_fragment_backup(assembly->imsi, node,
+					&status_report->status_report.raddr,
+					msg_id);
 =

 	g_hash_table_iter_remove(&iter);
 =

@@ -2804,6 +2985,7 @@ void status_report_assembly_add_fragment(
 	node->mrs[offset] |=3D bit;
 	node->expiration =3D expiration;
 	node->sent_mrs++;
+	sr_assembly_add_fragment_backup(assembly->imsi, node, to, msg_id);
 }
 =

 void status_report_assembly_expire(struct status_report_assembly *assembly,
diff --git a/src/smsutil.h b/src/smsutil.h
index eb70b6d..3c6b3ae 100644
--- a/src/smsutil.h
+++ b/src/smsutil.h
@@ -370,7 +370,7 @@ struct id_table_node {
 	unsigned char total_mrs;
 	unsigned char sent_mrs;
 	gboolean deliverable;
-};
+} __attribute__((packed));
 =

 struct status_report_assembly {
 	const char *imsi;
-- =

1.6.3.3



--===============8696160498800383659==--

