Content-Type: multipart/mixed; boundary="===============2504313500455185739=="
MIME-Version: 1.0
From: Pasi Miettinen <pasi.miettinen@ixonos.com>
Subject: [RFC PATCH 1/2] smsutil: Status Report assembly
Date: Thu, 10 Jun 2010 10:05:44 +0300
Message-ID: <1276153545-22260-2-git-send-email-pasi.miettinen@ixonos.com>
In-Reply-To: <1276153545-22260-1-git-send-email-pasi.miettinen@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2504313500455185739==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/smsutil.c |  138 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/smsutil.h |   28 ++++++++++++
 2 files changed, 166 insertions(+), 0 deletions(-)

diff --git a/src/smsutil.c b/src/smsutil.c
index 278d335..5c816f8 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -2625,6 +2625,144 @@ void sms_assembly_expire(struct sms_assembly *assem=
bly, time_t before)
 	}
 }
 =

+struct status_report_assembly *status_report_assembly_new(const char *imsi)
+{
+	struct status_report_assembly *ret =3D
+				g_new0(struct status_report_assembly, 1);
+
+	ret->assembly_table =3D g_hash_table_new_full(g_str_hash, g_str_equal,
+				g_free, (GDestroyNotify)g_hash_table_destroy);
+
+	if (imsi)
+		ret->imsi =3D imsi;
+
+	return ret;
+}
+
+void status_report_assembly_free(struct status_report_assembly *assembly)
+{
+	g_hash_table_destroy(assembly->assembly_table);
+}
+
+enum ofono_history_sms_status status_report_assembly_report(
+					struct status_report_assembly *assembly,
+					const struct sms *status_report,
+					unsigned int *msg_id)
+{
+	unsigned int offset =3D status_report->status_report.mr / 32;
+	unsigned int bit =3D 1 << (status_report->status_report.mr % 32);
+	GHashTable *id_table;
+	struct id_table_node *node =3D NULL;
+	gpointer key;
+	gpointer value;
+	GHashTableIter iter;
+	int i;
+
+	id_table =3D g_hash_table_lookup(assembly->assembly_table,
+				status_report->status_report.raddr.address);
+
+	/* ERROR, key (receiver address) does not exist in assembly*/
+	if (!id_table)
+		return OFONO_HISTORY_SMS_STATUS_ERROR;
+
+	g_hash_table_iter_init(&iter, id_table);
+	while (g_hash_table_iter_next(&iter, &key, &value)) {
+		node =3D value;
+
+		if (!(node->mrs[offset] & bit))
+			continue;
+
+		if (status_report->status_report.st =3D=3D
+						SMS_ST_COMPLETED_RECEIVED) {
+			/* mr belongs to this node */
+			node->mrs[offset] ^=3D bit;
+			*msg_id =3D node->ofono_msg_id;
+
+			for (i =3D 0; i < 8; i++) {
+				/* There are still pending mr(s). */
+				if (node->mrs[i] !=3D 0)
+					return OFONO_HISTORY_SMS_STATUS_PENDING;
+			}
+		}
+		/* No more pending mrs for this node. Remove node from id_table
+		 * and free it.
+		 */
+		g_hash_table_iter_remove(&iter);
+		/* id_list empty, remove key and value from assembly_table */
+		if (g_hash_table_size(id_table) =3D=3D 0)
+			g_hash_table_remove(assembly->assembly_table,
+				status_report->status_report.raddr.address);
+
+		return OFONO_HISTORY_SMS_STATUS_DELIVERED;
+	}
+	/* mr not found. */
+	return OFONO_HISTORY_SMS_STATUS_ERROR;
+}
+
+void status_report_assembly_add_fragment(struct status_report_assembly
+					*assembly, unsigned int *msg_id,
+					struct sms_address *to,
+					unsigned char mr, time_t expiration)
+{
+	unsigned int offset =3D mr / 32;
+	unsigned int bit =3D 1 << (mr % 32);
+	GHashTable *id_table;
+	struct id_table_node *node;
+	char *assembly_table_key;
+	unsigned int *id_table_key;
+
+	id_table =3D g_hash_table_lookup(assembly->assembly_table, to->address);
+
+	if (id_table) {
+		node =3D g_hash_table_lookup(id_table, msg_id);
+
+		if (node) {
+			node->mrs[offset] |=3D bit;
+			node->expiration =3D expiration;
+		} else {
+			id_table_key =3D g_new0(unsigned int, 1);
+			node =3D g_new0(struct id_table_node, 1);
+			node->to =3D *to;
+			node->ofono_msg_id =3D *msg_id;
+			node->mrs[offset] |=3D bit;
+			node->expiration =3D expiration;
+
+			*id_table_key =3D *msg_id;
+			g_hash_table_insert(id_table, id_table_key, node);
+		}
+	} else {
+		id_table =3D g_hash_table_new_full(g_int_hash, g_int_equal,
+								g_free, g_free);
+		id_table_key =3D g_new0(unsigned int, 1);
+
+		node =3D g_new0(struct id_table_node, 1);
+		node->to =3D *to;
+		node->ofono_msg_id =3D *msg_id;
+		node->mrs[offset] |=3D bit;
+		node->expiration =3D expiration;
+
+		*id_table_key =3D *msg_id;
+		g_hash_table_insert(id_table, id_table_key, node);
+
+		assembly_table_key =3D g_try_malloc(sizeof(to->address));
+
+		if (assembly_table_key =3D=3D NULL)
+			return;
+
+		g_strlcpy(assembly_table_key, to->address, sizeof(to->address));
+
+		g_hash_table_insert(assembly->assembly_table,
+					assembly_table_key, id_table);
+	}
+}
+
+void status_report_assembly_expire(struct status_report_assembly *assembly,
+					time_t before, GFunc foreach_func,
+					gpointer data)
+{
+	/*TODO*/
+}
+
 static inline GSList *sms_list_append(GSList *l, const struct sms *in)
 {
 	struct sms *sms;
diff --git a/src/smsutil.h b/src/smsutil.h
index a36a9d3..14a01dc 100644
--- a/src/smsutil.h
+++ b/src/smsutil.h
@@ -19,6 +19,8 @@
  *
  */
 =

+#include "history.h"
+
 #define CBS_MAX_GSM_CHARS 93
 =

 enum sms_type {
@@ -364,6 +366,18 @@ struct sms_assembly {
 	GSList *assembly_list;
 };
 =

+struct id_table_node {
+	struct sms_address to;
+	unsigned int ofono_msg_id;
+	unsigned int mrs[8];
+	time_t expiration;
+};
+
+struct status_report_assembly {
+	const char *imsi;
+	GHashTable *assembly_table;
+};
+
 struct cbs {
 	enum cbs_geo_scope gs;			/* 2 bits */
 	guint16 message_code;			/* 10 bits */
@@ -481,6 +495,20 @@ GSList *sms_assembly_add_fragment(struct sms_assembly =
*assembly,
 					guint16 ref, guint8 max, guint8 seq);
 void sms_assembly_expire(struct sms_assembly *assembly, time_t before);
 =

+struct status_report_assembly *status_report_assembly_new(const char *imsi=
);
+void status_report_assembly_free(struct status_report_assembly *assembly);
+enum ofono_history_sms_status status_report_assembly_report(
+					struct status_report_assembly *assembly,
+					const struct sms *status_report,
+					unsigned int *msg_id);
+void status_report_assembly_add_fragment(struct status_report_assembly
+					*assembly, unsigned int *msg_id,
+					struct sms_address *to,
+					unsigned char mr, time_t expiration);
+void status_report_assembly_expire(struct status_report_assembly *assembly,
+					time_t before, GFunc foreach_func,
+					gpointer data);
+
 GSList *sms_text_prepare(const char *utf8, guint16 ref,
 				gboolean use_16bit, int *ref_offset);
 =

-- =

1.6.0.4



--===============2504313500455185739==--

