Content-Type: multipart/mixed; boundary="===============0031645107663287360=="
MIME-Version: 1.0
From: Petteri Tikander <petteri.tikander@ixonos.com>
Subject: [RFC PATCH 1/2] smsutil: add fuzzy address check for status report
Date: Tue, 21 Sep 2010 20:12:04 +0300
Message-ID: <1285089125-23921-1-git-send-email-petteri.tikander@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0031645107663287360==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/smsutil.c |  103 ++++++++++++++++++++++++++++++++++++++++++++++++-----=
----
 1 files changed, 87 insertions(+), 16 deletions(-)

diff --git a/src/smsutil.c b/src/smsutil.c
index cd0fef2..8b05c68 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -2858,35 +2858,104 @@ gboolean status_report_assembly_report(struct stat=
us_report_assembly *assembly,
 	unsigned int offset =3D status_report->status_report.mr / 32;
 	unsigned int bit =3D 1 << (status_report->status_report.mr % 32);
 	struct id_table_node *node =3D NULL;
-	const char *straddr;
+	const char *r_addr, *s_addr;
+	struct sms_address addr;
 	GHashTable *id_table;
 	gpointer key, value;
 	gboolean delivered;
-	GHashTableIter iter;
+	GHashTableIter iter_addr, iter;
 	gboolean pending;
 	int i;
 	unsigned char *msgid;
+	unsigned int len, r_len, s_len;
 =

 	/* We ignore temporary or tempfinal status reports */
 	if (sr_st_to_delivered(status_report->status_report.st,
 				&delivered) =3D=3D FALSE)
 		return FALSE;
 =

-	straddr =3D sms_address_to_string(&status_report->status_report.raddr);
-	id_table =3D g_hash_table_lookup(assembly->assembly_table, straddr);
+	r_addr =3D sms_address_to_string(&status_report->status_report.raddr);
+	id_table =3D g_hash_table_lookup(assembly->assembly_table, r_addr);
 =

-	/* key (receiver address) does not exist in assembly */
-	if (id_table =3D=3D NULL)
-		return FALSE;
+	/* key (receiver address) exists in assembly */
+	if (id_table !=3D NULL) {
 =

-	g_hash_table_iter_init(&iter, id_table);
-	while (g_hash_table_iter_next(&iter, &key, &value)) {
-		node =3D value;
+		/* Found an identical address from assembly. */
+		s_addr =3D r_addr;
 =

-		if (node->mrs[offset] & bit)
-			break;
+		g_hash_table_iter_init(&iter, id_table);
+		while (g_hash_table_iter_next(&iter, &key, &value)) {
+			node =3D value;
+
+			if (node->mrs[offset] & bit)
+				break;
 =

-		node =3D NULL;
+			node =3D NULL;
+		}
+	}
+	/*
+	 * Key (receiver address) does not exist in assembly.
+	 * Some networks can change address to international format,
+	 * although address is sent in the national format.
+	 * Handle also change from national to international format.
+	 * So notify these special cases by comparing only
+	 * last six digits of the assembly addresses and received address.
+	 * If address contains less than six digits,
+	 * compare only existing digits.
+	 */
+	else {
+		g_hash_table_iter_init(&iter_addr, assembly->assembly_table);
+
+		/*
+		 * Go through all addresses using 'fuzzy' address-comparation.
+		 * Each address can relate to 1-n msg_ids.
+		 */
+		while (g_hash_table_iter_next(&iter_addr, (gpointer) &s_addr,
+						(gpointer) &id_table)) {
+
+			/* Notify international <-> national conversions */
+			if (((r_addr[0] =3D=3D '+') && (s_addr[0] !=3D '+')) ||
+				((r_addr[0] !=3D '+') && (s_addr[0] =3D=3D '+'))) {
+
+				r_len =3D strlen(r_addr);
+				s_len =3D strlen(s_addr);
+
+				len =3D MIN(6, MIN(r_len, s_len));
+
+				for (i =3D 0; i < len; i++) {
+					if (s_addr[s_len - i - 1] !=3D
+							r_addr[r_len - i - 1])
+						break;
+				}
+
+				/* Not all digits matched. */
+				if (i < len)
+					continue;
+			}
+			/* No conversions */
+			else
+				continue;
+
+			/* Address matched. Check message reference. */
+			g_hash_table_iter_init(&iter, id_table);
+			while (g_hash_table_iter_next(&iter, &key, &value)) {
+				node =3D value;
+
+				/* Address and MR matched */
+				if (node->mrs[offset] & bit)
+					break;
+
+				node =3D NULL;
+			}
+
+			/*
+			 * Received address with MR matched with one
+			 * of the stored addresses and MR, so no need
+			 * to continue searching.
+			 */
+			if (node)
+				break;
+		}
 	}
 =

 	/* Unable to find a message reference belonging to this address */
@@ -2913,13 +2982,15 @@ gboolean status_report_assembly_report(struct statu=
s_report_assembly *assembly,
 =

 	msgid =3D (unsigned char *) key;
 =

+	sms_address_from_string(&addr, s_addr);
+
 	if (pending =3D=3D TRUE && node->deliverable =3D=3D TRUE) {
 		/*
 		 * More status reports expected, and already received
 		 * reports completed. Update backup file.
 		 */
 		sr_assembly_add_fragment_backup(assembly->imsi, node,
-					&status_report->status_report.raddr,
+					&addr,
 					msgid);
 =

 		return FALSE;
@@ -2932,14 +3003,14 @@ gboolean status_report_assembly_report(struct statu=
s_report_assembly *assembly,
 		memcpy(out_msgid, msgid, SMS_MSGID_LEN);
 =

 	sr_assembly_remove_fragment_backup(assembly->imsi,
-					&status_report->status_report.raddr,
+					&addr,
 					msgid);
 =

 	g_hash_table_iter_remove(&iter);
 =

 	if (g_hash_table_size(id_table) =3D=3D 0)
 		g_hash_table_remove(assembly->assembly_table,
-				status_report->status_report.raddr.address);
+					s_addr);
 =

 	return TRUE;
 }
-- =

1.6.3.3



--===============0031645107663287360==--

