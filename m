Content-Type: multipart/mixed; boundary="===============4093686802982609263=="
MIME-Version: 1.0
From: Pasi Miettinen <pasi.miettinen@ixonos.com>
Subject: [RFC PATCH 6/6] Save pending SMS Status Reports to disk.
Date: Fri, 04 Jun 2010 14:17:37 +0300
Message-ID: <1275650257-30593-7-git-send-email-pasi.miettinen@ixonos.com>
In-Reply-To: <1275650257-30593-6-git-send-email-pasi.miettinen@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4093686802982609263==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/sms.c     |   11 ++-
 src/smsutil.c |  263 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 src/smsutil.h |    9 ++-
 3 files changed, 273 insertions(+), 10 deletions(-)

diff --git a/src/sms.c b/src/sms.c
index 76b0985..bf54f0b 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -336,7 +336,8 @@ static void tx_finished(const struct ofono_error *error=
, int mr, void *data)
 =

 	if (entry->status_report)
 		add_pending_status_report(&sms->pending_status_reports, mr,
-					entry->msg_id, &entry->receiver);
+					entry->msg_id, &entry->receiver,
+					sms->assembly->imsi);
 =

 	if (entry->cur_pdu < entry->num_pdus) {
 		sms->tx_source =3D g_timeout_add(0, tx_next, sms);
@@ -653,11 +654,12 @@ static void dispatch_sms_delivery_report(struct ofono=
_sms *sms,
 		status =3D update_pending_status_report_mr_number(
 					&sms->pending_status_reports, mr, raddr,
 					SMS_STATUS_REPORT_MESSAGE_DELIVERED,
-					&relating_msg_id);
+					&relating_msg_id, sms->assembly->imsi);
 =

 		if (status =3D=3D OFONO_HISTORY_SMS_STATUS_DELIVERED) {
 			ofono_dbus_dict_append(&dict, "delivered",
 						DBUS_TYPE_STRING, &str);
+
 			/*dbus-message assembled*/
 			dbus_message_iter_close_container(&iter, &dict);
 			g_dbus_send_message(conn, signal);
@@ -677,7 +679,7 @@ static void dispatch_sms_delivery_report(struct ofono_s=
ms *sms,
 		update_pending_status_report_mr_number(
 					&sms->pending_status_reports, mr, raddr,
 					SMS_STATUS_REPORT_MESSAGE_NOT_DELIVERED,
-					&relating_msg_id);
+					&relating_msg_id, sms->assembly->imsi);
 =

 		__ofono_history_sms_send_status(modem, relating_msg_id,
 				time(NULL),
@@ -1226,6 +1228,9 @@ void ofono_sms_register(struct ofono_sms *sms)
 		imsi =3D ofono_sim_get_imsi(sms->sim);
 		sms->assembly =3D sms_assembly_new(imsi);
 =

+		sms->pending_status_reports =3D
+			pending_status_reports_load_backup(imsi);
+
 		sms_load_settings(sms, imsi);
 	} else {
 		sms->assembly =3D sms_assembly_new(NULL);
diff --git a/src/smsutil.c b/src/smsutil.c
index 6e3caa3..1083b76 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -45,6 +45,10 @@
 #define SMS_BACKUP_PATH_DIR SMS_BACKUP_PATH "/%s-%i-%i"
 #define SMS_BACKUP_PATH_FILE SMS_BACKUP_PATH_DIR "/%03i"
 =

+#define SMS_SR_BACKUP_PATH STORAGEDIR "/%s/sms_sr"
+#define SMS_SR_BACKUP_PATH_DIR SMS_SR_BACKUP_PATH "/%s-%i-%i"
+#define SMS_SR_BACKUP_PATH_FILE SMS_SR_BACKUP_PATH_DIR "/%i/%i"
+
 #define SMS_ADDR_FMT "%24[0-9A-F]"
 =

 static GSList *sms_assembly_add_fragment_backup(struct sms_assembly *assem=
bly,
@@ -2635,6 +2639,239 @@ static inline GSList *sms_list_append(GSList *l, co=
nst struct sms *in)
 	return l;
 }
 =

+static gboolean pending_status_report_backup_mr(
+			const struct pending_status_report *status_report,
+			const struct sms_address *receiver, const char *imsi,
+			const struct mr_number *mr)
+{
+	int len =3D sizeof(enum sms_status_report_result);
+	unsigned char buf[3];
+
+	if (!imsi)
+		return FALSE;
+
+	/* storagedir/%s/sms_assembly/%s-%i-%i/%i/%i */
+	if (write_file(buf, len, SMS_BACKUP_MODE, SMS_SR_BACKUP_PATH_FILE, imsi,
+			receiver->address, receiver->number_type,
+			receiver->numbering_plan, status_report->ofono_msg_id,
+			mr->mr) !=3D len)
+		return FALSE;
+
+	return TRUE;
+}
+
+static gboolean pending_status_report_backup_free_mr(
+			const struct pending_status_report *status_report,
+			const struct sms_address *receiver, const char *imsi,
+			const struct mr_number *mr)
+{
+	char *path;
+
+	if (!imsi)
+		return FALSE;
+
+	path =3D g_strdup_printf(SMS_SR_BACKUP_PATH_FILE, imsi, receiver->address,
+				receiver->number_type,
+				receiver->numbering_plan,
+				status_report->ofono_msg_id, mr->mr);
+
+	unlink(path);
+	g_free(path);
+
+	path =3D g_strdup_printf(SMS_SR_BACKUP_PATH_DIR "/%i", imsi,
+				receiver->address, receiver->number_type,
+				receiver->numbering_plan,
+				status_report->ofono_msg_id);
+
+	/* If the msg_id does not have relating MR-numbers anymore, remove it */
+	rmdir(path);
+	g_free(path);
+
+	return TRUE;
+}
+
+static gboolean pending_status_report_backup_update_mr(
+			const struct pending_status_report *status_report,
+			const struct sms_address *receiver,
+			const char *imsi, const struct mr_number *mr)
+{
+	if (!pending_status_report_backup_free_mr(status_report, receiver,
+								imsi, mr))
+		return FALSE;
+
+	if (!pending_status_report_backup_mr(status_report, receiver, imsi, mr))
+		return FALSE;
+
+	return TRUE;
+}
+
+static gboolean pending_status_report_backup_free_id(
+			const struct pending_status_report *status_report,
+			const struct sms_address *receiver, const char *imsi)
+{
+	char *path;
+	GSList *l;
+	struct mr_number *current_mr;
+
+	if (!imsi)
+		return FALSE;
+
+	for (l =3D status_report->related_mr_numbers; l; l =3D l->next) {
+		current_mr =3D l->data;
+
+		pending_status_report_backup_free_mr(status_report, receiver,
+							imsi, current_mr);
+	}
+
+	path =3D g_strdup_printf(SMS_SR_BACKUP_PATH_DIR "/%i", imsi,
+				receiver->address, receiver->number_type,
+				receiver->numbering_plan,
+				status_report->ofono_msg_id);
+
+	rmdir(path);
+	g_free(path);
+
+	path =3D g_strdup_printf(SMS_SR_BACKUP_PATH_DIR, imsi,
+				receiver->address, receiver->number_type,
+				receiver->numbering_plan);
+
+	/* If the address does not have pending msg_ids anymore, remove it */
+	rmdir(path);
+	g_free(path);
+
+	return TRUE;
+}
+
+static void pending_status_reports_load_mrs(
+				struct pending_status_report *status_report,
+				const struct dirent *id_dir,
+				const struct dirent *addr_dir, const char *imsi)
+{
+	char *path;
+	struct dirent **mrs;
+	int len;
+	struct mr_number *mr_nmbr;
+	unsigned char buf[3];
+	int r;
+
+	if (id_dir->d_type !=3D DT_DIR)
+		return;
+
+	if (sscanf(id_dir->d_name, "%i", &status_report->ofono_msg_id) < 1)
+		return;
+
+	/* Go through different MR-numbers. MR-number contains the status of
+	 * the related message.
+	 */
+	path =3D g_strdup_printf(SMS_SR_BACKUP_PATH "/%s/%s",
+		imsi, addr_dir->d_name, id_dir->d_name);
+	len =3D scandir(path, &mrs, NULL, versionsort);
+
+	g_free(path);
+
+	if (len < 0)
+		return;
+
+	while (len--) {
+		mr_nmbr =3D g_new0(struct mr_number, 1);
+		r =3D read_file(buf, sizeof(buf), SMS_SR_BACKUP_PATH "/%s/%s/%s",
+				imsi, addr_dir->d_name,
+				id_dir->d_name, mrs[len]->d_name);
+
+		if (r < 0)
+			return;
+
+		mr_nmbr->mr =3D atoi(mrs[len]->d_name);
+		mr_nmbr->delivery_status =3D atoi((char *)buf);
+		status_report->related_mr_numbers =3D
+			g_slist_append(status_report->related_mr_numbers,
+								mr_nmbr);
+
+		free(mrs[len]);
+	}
+
+	free(mrs);
+}
+
+static void pending_status_reports_load_ids(GSList **pending_status_report=
s,
+						const struct dirent *addr_dir,
+						const char *imsi)
+{
+	char *path;
+	struct dirent **ids;
+	struct sms_address *addr;
+	struct pending_status_report *status_report;
+	int len;
+	if (addr_dir->d_type !=3D DT_DIR)
+		return;
+
+	addr =3D g_new0(struct sms_address, 1);
+
+	if (sscanf(addr_dir->d_name, "%[0-9]-%i-%i",
+			addr->address, (int *) &addr->number_type,
+			(int *) &addr->numbering_plan) < 3)
+		return;
+
+	/* Go through different msg_ids. Each msg_id can relate to
+	 * 1-n MR-numbers.
+	 */
+	path =3D g_strdup_printf(SMS_SR_BACKUP_PATH "/%s", imsi,
+							addr_dir->d_name);
+	len =3D scandir(path, &ids, NULL, versionsort);
+
+	g_free(path);
+
+	if (len < 0)
+		return;
+
+	/* Do not try to load . and .. directories */
+	while (2 < len--) {
+		status_report =3D g_new0(struct pending_status_report, 1);
+		status_report->receiver =3D g_new0(struct sms_address, 1);
+		pending_status_reports_load_mrs(status_report, ids[len],
+								addr_dir, imsi);
+		status_report->ofono_msg_id =3D atoi(ids[len]->d_name);
+		*status_report->receiver =3D *addr;
+
+		*pending_status_reports =3D
+			g_slist_append(*pending_status_reports, status_report);
+		free(ids[len]);
+	}
+
+	free(ids);
+}
+
+GSList *pending_status_reports_load_backup(const char *imsi)
+{
+	GSList *ret =3D NULL;
+	char *path;
+	struct dirent **addresses;
+	int len;
+
+	if (imsi) {
+		/* Restore state from backup */
+		path =3D g_strdup_printf(SMS_SR_BACKUP_PATH, imsi);
+		len =3D scandir(path, &addresses, NULL, alphasort);
+
+		g_free(path);
+
+		if (len < 0)
+			return ret;
+		/* Go through different addresses. Each address can relate to
+		 * 1-n msg_ids. Do not try to load . and .. directories.
+		 */
+		while (2 < len--) {
+			pending_status_reports_load_ids(&ret, addresses[len],
+									imsi);
+			free(addresses[len]);
+		}
+
+		free(addresses);
+	}
+
+	return ret;
+}
+
 static gboolean compare_sms_addresses(const struct sms_address *first,
 					const struct sms_address *second)
 {
@@ -2655,7 +2892,8 @@ static gboolean compare_sms_addresses(const struct sm=
s_address *first,
 =

 void add_pending_status_report(GSList **pending_status_reports, const int =
mr,
 					const unsigned int msg_id,
-					const struct sms_address *receiver)
+					struct sms_address *receiver,
+					const char *imsi)
 {
 	struct pending_status_report *status_report;
 	GSList *l;
@@ -2674,15 +2912,18 @@ void add_pending_status_report(GSList **pending_sta=
tus_reports, const int mr,
 			status_report->related_mr_numbers =3D
 				g_slist_append(status_report-> \
 						related_mr_numbers, new_mr);
+			pending_status_report_backup_mr(status_report, receiver,
+							imsi, new_mr);
 			return;
 		}
 	}
 =

 	/*Create new ofono_msg_id and relate MR-number to it*/
 	status_report =3D g_new0(struct pending_status_report, 1);
+	status_report->receiver =3D g_new0(struct sms_address, 1);
 =

 	status_report->ofono_msg_id =3D msg_id;
-	status_report->receiver =3D *receiver;
+	*status_report->receiver =3D *receiver;
 =

 	new_mr =3D g_new0(struct mr_number, 1);
 	new_mr->mr =3D mr;
@@ -2690,6 +2931,8 @@ void add_pending_status_report(GSList **pending_statu=
s_reports, const int mr,
 	status_report->related_mr_numbers =3D
 		g_slist_append(status_report->related_mr_numbers, new_mr);
 =

+	pending_status_report_backup_mr(status_report, receiver, imsi, new_mr);
+
 	*pending_status_reports =3D
 		g_slist_append(*pending_status_reports, status_report);
 }
@@ -2702,6 +2945,8 @@ void free_pending_status_report(struct pending_status=
_report *status_report,
 	g_slist_foreach(status_report->related_mr_numbers, (GFunc)g_free, NULL);
 	g_slist_free(status_report->related_mr_numbers);
 =

+	g_free(status_report->receiver);
+
 	*pending_status_reports =3D g_slist_remove(*pending_status_reports,
 								status_report);
 =

@@ -2712,7 +2957,7 @@ enum ofono_history_sms_status update_pending_status_r=
eport_mr_number(
 		GSList **pending_status_reports, const guint8 mr,
 		const struct sms_address *receiver,
 		const enum sms_status_report_result status_report_result,
-		unsigned int *relating_msg_id)
+		unsigned int *relating_msg_id, const char *imsi)
 {
 	struct pending_status_report *status_report;
 	GSList *l;
@@ -2729,7 +2974,7 @@ enum ofono_history_sms_status update_pending_status_r=
eport_mr_number(
 		/* MR-number does not relate to this msg_id because of
 		 * different addresses
 		 */
-		if (!compare_sms_addresses(&status_report->receiver, receiver))
+		if (!compare_sms_addresses(status_report->receiver, receiver))
 			continue;
 =

 		for (i =3D status_report->related_mr_numbers; i; i =3D i->next) {
@@ -2742,6 +2987,10 @@ enum ofono_history_sms_status update_pending_status_=
report_mr_number(
 				current_mr->delivery_status =3D
 					SMS_STATUS_REPORT_MESSAGE_DELIVERED;
 =

+				pending_status_report_backup_update_mr(
+						status_report, receiver, imsi,
+								current_mr);
+
 				mr_number_found =3D TRUE;
 =

 				continue;
@@ -2756,6 +3005,9 @@ enum ofono_history_sms_status update_pending_status_r=
eport_mr_number(
 				free_pending_status_report(status_report,
 						pending_status_reports);
 =

+				pending_status_report_backup_free_id(
+						status_report, receiver, imsi);
+
 				/*Received MR is handled*/
 				return OFONO_HISTORY_SMS_STATUS_DELIVER_FAILED;
 			}
@@ -2769,6 +3021,9 @@ enum ofono_history_sms_status update_pending_status_r=
eport_mr_number(
 		/*all parts of the message succesfully delivered*/
 		if (delivery_successful) {
 			*relating_msg_id =3D status_report->ofono_msg_id;
+
+			pending_status_report_backup_free_id(status_report,
+								receiver, imsi);
 			free_pending_status_report(status_report,
 							pending_status_reports);
 =

diff --git a/src/smsutil.h b/src/smsutil.h
index a809453..11481db 100644
--- a/src/smsutil.h
+++ b/src/smsutil.h
@@ -379,7 +379,7 @@ struct mr_number {
 =

 struct pending_status_report {
 	unsigned int ofono_msg_id;
-	struct sms_address receiver;
+	struct sms_address *receiver;
 	GSList *related_mr_numbers;
 };
 =

@@ -500,9 +500,12 @@ GSList *sms_assembly_add_fragment(struct sms_assembly =
*assembly,
 					guint16 ref, guint8 max, guint8 seq);
 void sms_assembly_expire(struct sms_assembly *assembly, time_t before);
 =

+GSList *pending_status_reports_load_backup(const char *imsi);
+
 void add_pending_status_report(GSList **pending_status_reports, const int =
mr,
 					const unsigned int msg_id,
-					const struct sms_address *receiver);
+					struct sms_address *receiver,
+					const char *imsi);
 =

 void free_pending_status_report(struct pending_status_report *status_repor=
t,
 				GSList **pending_status_reports);
@@ -511,7 +514,7 @@ enum ofono_history_sms_status update_pending_status_rep=
ort_mr_number(
 		GSList **pending_status_reports, const guint8 mr,
 		const struct sms_address *receiver,
 		const enum sms_status_report_result status_report_result,
-		unsigned int *relating_msg_id);
+		unsigned int *relating_msg_id, const char *imsi);
 =

 GSList *sms_text_prepare(const char *utf8, guint16 ref,
 				gboolean use_16bit, int *ref_offset,
-- =

1.6.0.4



--===============4093686802982609263==--

