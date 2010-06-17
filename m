Content-Type: multipart/mixed; boundary="===============7263125651543275622=="
MIME-Version: 1.0
From: Pasi Miettinen <pasi.miettinen@ixonos.com>
Subject: [RFC PATCH 1/5] smsutil: Status report assembly
Date: Thu, 17 Jun 2010 16:14:54 +0300
Message-ID: <1276780498-7573-2-git-send-email-pasi.miettinen@ixonos.com>
In-Reply-To: <1276780498-7573-1-git-send-email-pasi.miettinen@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7263125651543275622==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/smsutil.c |  183 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/smsutil.h |   31 ++++++++++
 2 files changed, 214 insertions(+), 0 deletions(-)

diff --git a/src/smsutil.c b/src/smsutil.c
index 95eca06..3db3d28 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -2625,6 +2625,189 @@ void sms_assembly_expire(struct sms_assembly *assem=
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
+	g_free(assembly);
+}
+
+gboolean status_report_assembly_report(struct status_report_assembly *asse=
mbly,
+					const struct sms *status_report,
+					unsigned int *msg_id,
+					gboolean *msg_delivered)
+{
+	unsigned int offset =3D status_report->status_report.mr / 32;
+	unsigned int bit =3D 1 << (status_report->status_report.mr % 32);
+	GHashTable *id_table;
+	struct id_table_node *node;
+	unsigned int *key;
+	gpointer value;
+	GHashTableIter iter;
+	int i;
+	gboolean pending =3D FALSE;
+	gboolean update_history =3D FALSE;
+
+	id_table =3D g_hash_table_lookup(assembly->assembly_table,
+				status_report->status_report.raddr.address);
+
+	/* ERROR, key (receiver address) does not exist in assembly */
+	if (!id_table) {
+		*msg_delivered =3D FALSE;
+		return FALSE;
+	}
+
+	g_hash_table_iter_init(&iter, id_table);
+	while (g_hash_table_iter_next(&iter, (gpointer)&key, &value)) {
+		node =3D value;
+
+		if (!(node->mrs[offset] & bit))
+			continue;
+
+		/* Mr belongs to this node. */
+		node->mrs[offset] ^=3D bit;
+		*msg_id =3D *key;
+
+		for (i =3D 0; i < 8; i++) {
+				/* There are still pending mr(s). */
+				if (node->mrs[i] !=3D 0 ||
+					(node->sent_mrs < node->total_mrs)) {
+					pending =3D TRUE;
+					break;
+				}
+		}
+		/* Mr is not delivered. */
+		if (status_report->status_report.st !=3D
+				SMS_ST_COMPLETED_RECEIVED) {
+			/* First mr which is not delivered. Update ofono history
+			 * and mark the whole message as undeliverable. Upcoming
+			 * mrs can not change the status to deliverable even if
+			 * they are considered as delivered.
+			 */
+			if (node->deliverable) {
+				node->deliverable =3D FALSE;
+				update_history =3D TRUE;
+			}
+		}
+
+		/* If there are pending mrs that relate to this message, we do
+		 * not delete the node yet.
+		 */
+		if (pending) {
+			*msg_delivered =3D FALSE;
+			return update_history;
+		} else {
+			*msg_delivered =3D node->deliverable;
+
+			g_hash_table_iter_remove(&iter);
+
+			if (g_hash_table_size(id_table) =3D=3D 0)
+				g_hash_table_remove(assembly->assembly_table,
+				status_report->status_report.raddr.address);
+			/* If there has not been undelivered mrs, message is
+			 * delivered and the ofono history needs to be updated.
+			 * If the message is concidered as undelivered, the
+			 * ofono history has already been updated when the first
+			 * undelivered mr arrived, unless this one is the only
+			 * related mr and was marked undelivered.
+			 */
+			return *msg_delivered || update_history;
+		}
+	}
+	/* ERROR, mr not found. */
+	*msg_delivered =3D FALSE;
+	return FALSE;
+}
+
+void status_report_assembly_add_fragment(
+					struct status_report_assembly *assembly,
+					unsigned int msg_id,
+					const struct sms_address *to,
+					unsigned char mr, time_t expiration,
+					unsigned char total_mrs)
+{
+	unsigned int offset =3D mr / 32;
+	unsigned int bit =3D 1 << (mr % 32);
+	GHashTable *id_table;
+	struct id_table_node *node;
+	char *assembly_table_key;
+	unsigned int *id_table_key;
+
+	id_table =3D g_hash_table_lookup(assembly->assembly_table, to->address);
+	/* Create id_table and node */
+	if (id_table =3D=3D NULL) {
+		id_table =3D g_hash_table_new_full(g_int_hash, g_int_equal,
+								g_free, g_free);
+		id_table_key =3D g_new0(unsigned int, 1);
+
+		node =3D g_new0(struct id_table_node, 1);
+		node->to =3D *to;
+		node->mrs[offset] |=3D bit;
+		node->expiration =3D expiration;
+		node->total_mrs =3D total_mrs;
+		node->sent_mrs =3D 1;
+		node->deliverable =3D TRUE;
+
+		*id_table_key =3D msg_id;
+		g_hash_table_insert(id_table, id_table_key, node);
+
+		assembly_table_key =3D g_try_malloc(sizeof(to->address));
+
+		if (assembly_table_key =3D=3D NULL) {
+			g_free(node);
+			return;
+		}
+
+		g_strlcpy(assembly_table_key, to->address, sizeof(to->address));
+
+		g_hash_table_insert(assembly->assembly_table,
+					assembly_table_key, id_table);
+		return;
+	}
+
+	node =3D g_hash_table_lookup(id_table, &msg_id);
+	/* id_table exists, create new node */
+	if (node =3D=3D NULL) {
+		id_table_key =3D g_new0(unsigned int, 1);
+		node =3D g_new0(struct id_table_node, 1);
+		node->to =3D *to;
+		node->mrs[offset] |=3D bit;
+		node->expiration =3D expiration;
+		node->total_mrs =3D total_mrs;
+		node->sent_mrs =3D 1;
+		node->deliverable =3D TRUE;
+
+		*id_table_key =3D msg_id;
+		g_hash_table_insert(id_table, id_table_key, node);
+
+		return;
+	}
+	/* id_table and node both exists */
+	node->mrs[offset] |=3D bit;
+	node->expiration =3D expiration;
+	node->sent_mrs++;
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
index 1bd42bb..5fb187b 100644
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
@@ -364,6 +366,20 @@ struct sms_assembly {
 	GSList *assembly_list;
 };
 =

+struct id_table_node {
+	struct sms_address to;
+	unsigned int mrs[8];
+	time_t expiration;
+	unsigned char total_mrs;
+	unsigned char sent_mrs;
+	gboolean deliverable;
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
@@ -481,6 +497,21 @@ GSList *sms_assembly_add_fragment(struct sms_assembly =
*assembly,
 					guint16 ref, guint8 max, guint8 seq);
 void sms_assembly_expire(struct sms_assembly *assembly, time_t before);
 =

+struct status_report_assembly *status_report_assembly_new(const char *imsi=
);
+void status_report_assembly_free(struct status_report_assembly *assembly);
+gboolean status_report_assembly_report(struct status_report_assembly *asse=
mbly,
+					const struct sms *status_report,
+					unsigned int *msg_id,
+					gboolean *msg_delivered);
+void status_report_assembly_add_fragment(struct status_report_assembly
+					*assembly, unsigned int msg_id,
+					const struct sms_address *to,
+					unsigned char mr, time_t expiration,
+					unsigned char total_mrs);
+void status_report_assembly_expire(struct status_report_assembly *assembly,
+					time_t before, GFunc foreach_func,
+					gpointer data);
+
 GSList *sms_text_prepare(const char *utf8, guint16 ref,
 				gboolean use_16bit, int *ref_offset,
 				gboolean use_delivery_reports);
-- =

1.6.0.4



--===============7263125651543275622==--

