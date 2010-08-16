Content-Type: multipart/mixed; boundary="===============8760731812869213957=="
MIME-Version: 1.0
From: Petteri Tikander <petteri.tikander@ixonos.com>
Subject: [RFC_PATCH 3/4] smsutil:add proper checking of sms-address in status
 report-function
Date: Mon, 16 Aug 2010 10:08:52 +0300
Message-ID: <1281942533-9126-3-git-send-email-petteri.tikander@ixonos.com>
In-Reply-To: <1281942533-9126-2-git-send-email-petteri.tikander@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8760731812869213957==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/smsutil.c |   54 ++++++++++++++++++++++++++----------------------------
 1 files changed, 26 insertions(+), 28 deletions(-)

diff --git a/src/smsutil.c b/src/smsutil.c
index 0972988..25e405c 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -46,7 +46,7 @@
 #define SMS_BACKUP_PATH_FILE SMS_BACKUP_PATH_DIR "/%03i"
 =

 #define SMS_SR_BACKUP_PATH STORAGEDIR "/%s/sms_sr"
-#define SMS_SR_BACKUP_PATH_DIR SMS_SR_BACKUP_PATH "/%s-%i-%i"
+#define SMS_SR_BACKUP_PATH_DIR SMS_SR_BACKUP_PATH "/%s"
 #define SMS_SR_BACKUP_PATH_FILE SMS_SR_BACKUP_PATH_DIR "/%i"
 =

 #define SMS_ADDR_FMT "%24[0-9A-F]"
@@ -2417,7 +2417,7 @@ static void sms_assembly_backup_free(struct sms_assem=
bly *assembly,
 {
 	char *path;
 	int seq;
-	char straddr[25];
+	DECLARE_SMS_ADDR_STR(straddr);
 =

 	if (!assembly->imsi)
 		return;
@@ -2652,7 +2652,8 @@ static void sr_assembly_load_backup(GHashTable *assem=
bly_table,
 {
 	char *path;
 	struct dirent **ids;
-	struct sms_address sms_addr, *addr;
+	struct sms_address addr;
+	DECLARE_SMS_ADDR_STR(straddr);
 	struct id_table_node *node;
 	GHashTable *id_table;
 	int len;
@@ -2666,13 +2667,12 @@ static void sr_assembly_load_backup(GHashTable *ass=
embly_table,
 	if (addr_dir->d_type !=3D DT_DIR)
 		return;
 =

-	addr =3D &sms_addr;
+	/* Max of SMS address size is 12 bytes, hex encoded */
+	if (sscanf(addr_dir->d_name, SMS_ADDR_FMT, straddr) < 1)
+		return;
 =

-	if (sscanf(addr_dir->d_name, SMS_ADDR_FMT "-%i-%i",
-			addr->address, (int *) &addr->number_type,
-			(int *) &addr->numbering_plan) < 3) {
+	if (sms_assembly_extract_address(straddr, &addr) =3D=3D FALSE)
 		return;
-	}
 =

 	/* Go through different msg_ids. */
 	path =3D g_strdup_printf(SMS_SR_BACKUP_PATH "/%s", imsi,
@@ -2687,12 +2687,12 @@ static void sr_assembly_load_backup(GHashTable *ass=
embly_table,
 	id_table =3D g_hash_table_new_full(g_int_hash, g_int_equal,
 							g_free, g_free);
 =

-	assembly_table_key =3D g_try_malloc(sizeof(addr->address));
+	assembly_table_key =3D g_try_malloc(sizeof(addr.address));
 =

 	if (assembly_table_key =3D=3D NULL)
 		return;
 =

-	g_strlcpy(assembly_table_key, addr->address, sizeof(addr->address));
+	g_strlcpy(assembly_table_key, addr.address, sizeof(addr.address));
 	g_hash_table_insert(assembly_table, assembly_table_key, id_table);
 =

 	while (len--) {
@@ -2716,7 +2716,7 @@ static void sr_assembly_load_backup(GHashTable *assem=
bly_table,
 		}
 		/* Gather the data for id_table node */
 		node =3D g_new0(struct id_table_node, 1);
-		memcpy(&node->to, addr, sizeof(*addr));
+		memcpy(&node->to, &addr, sizeof(addr));
 		node->expiration =3D segment_stat.st_mtime;
 		memcpy(node->mrs, buf, sizeof(node->mrs));
 		memcpy(&node->total_mrs, buf + sizeof(node->mrs),
@@ -2766,7 +2766,6 @@ struct status_report_assembly *status_report_assembly=
_new(const char *imsi)
 		/* Go through different addresses. Each address can relate to
 		 * 1-n msg_ids.
 		 */
-
 		while (len--) {
 			sr_assembly_load_backup(ret->assembly_table, imsi,
 								addresses[len]);
@@ -2786,10 +2785,14 @@ static gboolean sr_assembly_add_fragment_backup(con=
st char *imsi,
 	int len =3D sizeof(node->mrs) + sizeof(node->total_mrs) +
 			sizeof(node->sent_mrs) + sizeof(node->deliverable);
 	unsigned char buf[len];
+	DECLARE_SMS_ADDR_STR(straddr);
 =

 	if (!imsi)
 		return FALSE;
 =

+	if (sms_address_to_hex_string(&node->to, straddr) =3D=3D FALSE)
+		return FALSE;
+
 	memcpy(buf, node->mrs, sizeof(node->mrs));
 =

 	memcpy(buf + sizeof(node->mrs), &node->total_mrs,
@@ -2801,10 +2804,9 @@ static gboolean sr_assembly_add_fragment_backup(cons=
t char *imsi,
 	memcpy(buf + sizeof(node->mrs) + sizeof(node->total_mrs) +
 	sizeof(node->sent_mrs),	&node->deliverable, sizeof(node->deliverable));
 =

-	/* storagedir/%s/sms_sr/%s-%i-%i/%i */
+	/* storagedir/%s/sms_sr/%s/%i */
 	if (write_file(buf, len, SMS_BACKUP_MODE, SMS_SR_BACKUP_PATH_FILE, imsi,
-			node->to.address, node->to.number_type,
-			node->to.numbering_plan, msg_id) !=3D len)
+			straddr, msg_id) !=3D len)
 		return FALSE;
 =

 	return TRUE;
@@ -2815,19 +2817,20 @@ static gboolean sr_assembly_remove_fragment_backup(=
const char *imsi,
 					unsigned int msg_id)
 {
 	char *path;
+	DECLARE_SMS_ADDR_STR(straddr);
 =

 	if (!imsi)
 		return FALSE;
 =

-	path =3D g_strdup_printf(SMS_SR_BACKUP_PATH_FILE, imsi, node->to.address,
-				node->to.number_type, node->to.numbering_plan,
-				msg_id);
+	if (sms_address_to_hex_string(&node->to, straddr) =3D=3D FALSE)
+		return FALSE;
+
+	path =3D g_strdup_printf(SMS_SR_BACKUP_PATH_FILE, imsi, straddr, msg_id);
 =

 	unlink(path);
 	g_free(path);
 =

-	path =3D g_strdup_printf(SMS_SR_BACKUP_PATH_DIR, imsi, node->to.address,
-				node->to.number_type, node->to.numbering_plan);
+	path =3D g_strdup_printf(SMS_SR_BACKUP_PATH_DIR, imsi, straddr);
 =

 	/* If the address does not have relating msg_ids anymore, remove it */
 	rmdir(path);
@@ -2836,14 +2839,6 @@ static gboolean sr_assembly_remove_fragment_backup(c=
onst char *imsi,
 	return TRUE;
 }
 =

-static gboolean sr_assembly_update_fragment_backup(const char *imsi,
-					const struct id_table_node *node,
-					unsigned int msg_id)
-{
-	return sr_assembly_remove_fragment_backup(imsi, node, msg_id) &&
-			sr_assembly_add_fragment_backup(imsi, node, msg_id);
-}
-
 void status_report_assembly_free(struct status_report_assembly *assembly)
 {
 	g_hash_table_destroy(assembly->assembly_table);
@@ -2930,6 +2925,9 @@ gboolean status_report_assembly_report(struct status_=
report_assembly *assembly,
 	}
 =

 	if (pending =3D=3D TRUE && node->deliverable =3D=3D TRUE) {
+		/* More status reports expected, and already received
+		   reports completed. Update backup file.
+		 */
 		sr_assembly_add_fragment_backup(assembly->imsi, node,
 						*((unsigned int *) key));
 =

-- =

1.6.3.3



--===============8760731812869213957==--

