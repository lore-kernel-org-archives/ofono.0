Content-Type: multipart/mixed; boundary="===============5095828729920257806=="
MIME-Version: 1.0
From: Pasi Miettinen <pasi.miettinen@ixonos.com>
Subject: [RFC PATCH 5/6] Support for concatenated SMS status report.
Date: Fri, 04 Jun 2010 14:17:36 +0300
Message-ID: <1275650257-30593-6-git-send-email-pasi.miettinen@ixonos.com>
In-Reply-To: <1275650257-30593-5-git-send-email-pasi.miettinen@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5095828729920257806==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/history.h |    2 +
 src/sms.c         |   67 ++++++++++++++++++++----
 src/smsutil.c     |  152 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/smsutil.h     |   32 +++++++++++
 4 files changed, 243 insertions(+), 10 deletions(-)

diff --git a/include/history.h b/include/history.h
index 300a4fb..17445f0 100644
--- a/include/history.h
+++ b/include/history.h
@@ -33,6 +33,8 @@ enum ofono_history_sms_status {
 	OFONO_HISTORY_SMS_STATUS_PENDING,
 	OFONO_HISTORY_SMS_STATUS_SUBMITTED,
 	OFONO_HISTORY_SMS_STATUS_SUBMIT_FAILED,
+	OFONO_HISTORY_SMS_STATUS_DELIVERED,
+	OFONO_HISTORY_SMS_STATUS_DELIVER_FAILED,
 };
 =

 struct ofono_history_context {
diff --git a/src/sms.c b/src/sms.c
index 16a4d41..76b0985 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -68,6 +68,7 @@ struct ofono_sms {
 	void *driver_data;
 	struct ofono_atom *atom;
 	gboolean use_delivery_reports;
+	GSList *pending_status_reports;
 };
 =

 struct pending_pdu {
@@ -83,6 +84,8 @@ struct tx_queue_entry {
 	unsigned int msg_id;
 	unsigned int retry;
 	DBusMessage *msg;
+	gboolean status_report;
+	struct sms_address receiver;
 };
 =

 static void set_sca(struct ofono_sms *sms,
@@ -331,6 +334,10 @@ static void tx_finished(const struct ofono_error *erro=
r, int mr, void *data)
 	entry->cur_pdu +=3D 1;
 	entry->retry =3D 0;
 =

+	if (entry->status_report)
+		add_pending_status_report(&sms->pending_status_reports, mr,
+					entry->msg_id, &entry->receiver);
+
 	if (entry->cur_pdu < entry->num_pdus) {
 		sms->tx_source =3D g_timeout_add(0, tx_next, sms);
 		return;
@@ -462,6 +469,8 @@ static DBusMessage *sms_send_message(DBusConnection *co=
nn, DBusMessage *msg,
 	set_ref_and_to(msg_list, sms->ref, ref_offset, to);
 	entry =3D create_tx_queue_entry(msg_list);
 =

+	sms_address_from_string(&entry->receiver, to);
+
 	g_slist_foreach(msg_list, (GFunc)g_free, NULL);
 	g_slist_free(msg_list);
 =

@@ -474,6 +483,7 @@ static DBusMessage *sms_send_message(DBusConnection *co=
nn, DBusMessage *msg,
 =

 	entry->msg =3D dbus_message_ref(msg);
 	entry->msg_id =3D sms->next_msg_id++;
+	entry->status_report =3D sms->use_delivery_reports;
 =

 	g_queue_push_tail(sms->txq, entry);
 =

@@ -583,10 +593,12 @@ static void dispatch_sms_delivery_report(struct ofono=
_sms *sms,
 					const enum sms_st *st,
 					const struct sms_address *raddr,
 					const struct sms_scts *scts,
-					const struct sms_scts *dt)
+					const struct sms_scts *dt,
+					const guint8 mr)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
 	const char *path =3D __ofono_atom_get_path(sms->atom);
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(sms->atom);
 	DBusMessage *signal;
 	DBusMessageIter iter;
 	DBusMessageIter dict;
@@ -595,6 +607,7 @@ static void dispatch_sms_delivery_report(struct ofono_s=
ms *sms,
 	struct tm remote;
 	struct tm local;
 	const char *str =3D buf;
+	unsigned int relating_msg_id;
 =

 	if (!st) {
 		DBG("status unavailable");
@@ -631,21 +644,45 @@ static void dispatch_sms_delivery_report(struct ofono=
_sms *sms,
 	ofono_dbus_dict_append(&dict, "LocalDeliverTime",
 					DBUS_TYPE_STRING, &str);
 =

+	str =3D sms_address_to_string(raddr);
+
 	/*Status*/
 	if (*st =3D=3D 0x00) {
-		str =3D sms_address_to_string(raddr);
-		ofono_dbus_dict_append(&dict, "delivered",
-					DBUS_TYPE_STRING, &str);
+		enum ofono_history_sms_status status;
+
+		status =3D update_pending_status_report_mr_number(
+					&sms->pending_status_reports, mr, raddr,
+					SMS_STATUS_REPORT_MESSAGE_DELIVERED,
+					&relating_msg_id);
+
+		if (status =3D=3D OFONO_HISTORY_SMS_STATUS_DELIVERED) {
+			ofono_dbus_dict_append(&dict, "delivered",
+						DBUS_TYPE_STRING, &str);
+			/*dbus-message assembled*/
+			dbus_message_iter_close_container(&iter, &dict);
+			g_dbus_send_message(conn, signal);
+
+			__ofono_history_sms_send_status(modem, relating_msg_id,
+					time(NULL),
+					OFONO_HISTORY_SMS_STATUS_DELIVERED);
+		}
 	} else {
-		str =3D sms_address_to_string(raddr);
 		ofono_dbus_dict_append(&dict, "undeliverable",
 					DBUS_TYPE_STRING, &str);
-	}
 =

-	/*dbus-message assembled*/
-	dbus_message_iter_close_container(&iter, &dict);
+		/*dbus-message assembled*/
+		dbus_message_iter_close_container(&iter, &dict);
+		g_dbus_send_message(conn, signal);
 =

-	g_dbus_send_message(conn, signal);
+		update_pending_status_report_mr_number(
+					&sms->pending_status_reports, mr, raddr,
+					SMS_STATUS_REPORT_MESSAGE_NOT_DELIVERED,
+					&relating_msg_id);
+
+		__ofono_history_sms_send_status(modem, relating_msg_id,
+				time(NULL),
+				OFONO_HISTORY_SMS_STATUS_DELIVER_FAILED);
+	}
 }
 =

 static void sms_dispatch(struct ofono_sms *sms, GSList *sms_list)
@@ -763,7 +800,8 @@ static void sms_status_report_dispatch(struct ofono_sms=
 *sms, GSList *sms_list)
 	dispatch_sms_delivery_report(sms, &s->status_report.st,
 					&s->status_report.raddr,
 					&s->status_report.scts,
-					&s->status_report.dt);
+					&s->status_report.dt,
+					s->status_report.mr);
 }
 =

 static void handle_deliver(struct ofono_sms *sms, const struct sms *incomi=
ng)
@@ -1041,6 +1079,15 @@ static void sms_remove(struct ofono_atom *atom)
 		sms->settings =3D NULL;
 	}
 =

+	if (sms->pending_status_reports) {
+
+		g_slist_foreach(sms->pending_status_reports,
+				(GFunc) free_pending_status_report,
+				&sms->pending_status_reports);
+
+		sms->pending_status_reports =3D NULL;
+	}
+
 	g_free(sms);
 }
 =

diff --git a/src/smsutil.c b/src/smsutil.c
index a92089b..6e3caa3 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -2635,6 +2635,158 @@ static inline GSList *sms_list_append(GSList *l, co=
nst struct sms *in)
 	return l;
 }
 =

+static gboolean compare_sms_addresses(const struct sms_address *first,
+					const struct sms_address *second)
+{
+	const char *str1 =3D first->address;
+	const char *str2 =3D second->address;
+
+	if (first->number_type !=3D second->number_type)
+		return FALSE;
+
+	if (first->numbering_plan !=3D second->numbering_plan)
+		return FALSE;
+
+	if (g_strcmp0(str1, str2) !=3D 0)
+		return FALSE;
+
+	return TRUE;
+}
+
+void add_pending_status_report(GSList **pending_status_reports, const int =
mr,
+					const unsigned int msg_id,
+					const struct sms_address *receiver)
+{
+	struct pending_status_report *status_report;
+	GSList *l;
+	struct mr_number *new_mr;
+
+	for (l =3D *pending_status_reports; l; l =3D l->next) {
+		status_report =3D l->data;
+
+		if (status_report->ofono_msg_id =3D=3D msg_id) {
+
+			/*Relate new MR-number to existing ofono_msg_id*/
+			new_mr =3D g_new0(struct mr_number, 1);
+			new_mr->mr =3D mr;
+			new_mr->delivery_status =3D
+					SMS_STATUS_REPORT_STATUS_PENDING;
+			status_report->related_mr_numbers =3D
+				g_slist_append(status_report-> \
+						related_mr_numbers, new_mr);
+			return;
+		}
+	}
+
+	/*Create new ofono_msg_id and relate MR-number to it*/
+	status_report =3D g_new0(struct pending_status_report, 1);
+
+	status_report->ofono_msg_id =3D msg_id;
+	status_report->receiver =3D *receiver;
+
+	new_mr =3D g_new0(struct mr_number, 1);
+	new_mr->mr =3D mr;
+	new_mr->delivery_status =3D SMS_STATUS_REPORT_STATUS_PENDING;
+	status_report->related_mr_numbers =3D
+		g_slist_append(status_report->related_mr_numbers, new_mr);
+
+	*pending_status_reports =3D
+		g_slist_append(*pending_status_reports, status_report);
+}
+
+void free_pending_status_report(struct pending_status_report *status_repor=
t,
+				GSList **pending_status_reports)
+{
+
+	/*Free msg_id and relating MR-numbers*/
+	g_slist_foreach(status_report->related_mr_numbers, (GFunc)g_free, NULL);
+	g_slist_free(status_report->related_mr_numbers);
+
+	*pending_status_reports =3D g_slist_remove(*pending_status_reports,
+								status_report);
+
+	status_report =3D NULL;
+}
+
+enum ofono_history_sms_status update_pending_status_report_mr_number(
+		GSList **pending_status_reports, const guint8 mr,
+		const struct sms_address *receiver,
+		const enum sms_status_report_result status_report_result,
+		unsigned int *relating_msg_id)
+{
+	struct pending_status_report *status_report;
+	GSList *l;
+	GSList *i;
+	struct mr_number *current_mr;
+	gboolean delivery_successful;
+	gboolean mr_number_found =3D FALSE;
+
+	/*Each ofono_msg_id can relate to 1-n mr_numbers*/
+	for (l =3D *pending_status_reports; l; l =3D l->next) {
+		delivery_successful =3D TRUE;
+		status_report =3D l->data;
+
+		/* MR-number does not relate to this msg_id because of
+		 * different addresses
+		 */
+		if (!compare_sms_addresses(&status_report->receiver, receiver))
+			continue;
+
+		for (i =3D status_report->related_mr_numbers; i; i =3D i->next) {
+			current_mr =3D i->data;
+
+			/*Message with current MR-number was delivered*/
+			if (current_mr->mr =3D=3D mr &&
+				status_report_result =3D=3D
+				SMS_STATUS_REPORT_MESSAGE_DELIVERED) {
+				current_mr->delivery_status =3D
+					SMS_STATUS_REPORT_MESSAGE_DELIVERED;
+
+				mr_number_found =3D TRUE;
+
+				continue;
+			}
+
+			/* If one part of the fragmented message is undelivered,
+			 * whole message is declared undelivered
+			 */
+			if (current_mr->mr =3D=3D mr &&
+				status_report_result =3D=3D
+				SMS_STATUS_REPORT_MESSAGE_NOT_DELIVERED) {
+				free_pending_status_report(status_report,
+						pending_status_reports);
+
+				/*Received MR is handled*/
+				return OFONO_HISTORY_SMS_STATUS_DELIVER_FAILED;
+			}
+
+			if (current_mr->delivery_status =3D=3D
+				SMS_STATUS_REPORT_STATUS_PENDING)
+				/*msg_id still relates to pending statusreport*/
+				delivery_successful =3D FALSE;
+		}
+
+		/*all parts of the message succesfully delivered*/
+		if (delivery_successful) {
+			*relating_msg_id =3D status_report->ofono_msg_id;
+			free_pending_status_report(status_report,
+							pending_status_reports);
+
+			/*Received MR is handled*/
+			return OFONO_HISTORY_SMS_STATUS_DELIVERED;
+		}
+	}
+
+	if (!mr_number_found) {
+		/* MR-number is not found in pending_status_reports. Can this
+		 * kind of error occur? Maybe reboot just before MR-number is
+		 * saved to disk? What to do?
+		 */
+	}
+
+	return OFONO_HISTORY_SMS_STATUS_PENDING;
+}
+
 /* Prepares the text for transmission.  Breaks up into fragments if
  * necessary using ref as the concatenated message reference number.
  * Returns a list of sms messages in order.  If ref_offset is given,
diff --git a/src/smsutil.h b/src/smsutil.h
index cfb2765..a809453 100644
--- a/src/smsutil.h
+++ b/src/smsutil.h
@@ -21,6 +21,8 @@
 =

 #define CBS_MAX_GSM_CHARS 93
 =

+#include "history.h"
+
 enum sms_type {
 	SMS_TYPE_DELIVER =3D 0,
 	SMS_TYPE_DELIVER_REPORT_ACK,
@@ -178,6 +180,12 @@ enum sms_pid_type {
 	SMS_PID_TYPE_USIM_DOWNLOAD =3D 0x7f,
 };
 =

+enum sms_status_report_result {
+	SMS_STATUS_REPORT_STATUS_PENDING =3D 0,
+	SMS_STATUS_REPORT_MESSAGE_NOT_DELIVERED =3D 1,
+	SMS_STATUS_REPORT_MESSAGE_DELIVERED =3D 2,
+};
+
 enum cbs_language {
 	CBS_LANGUAGE_GERMAN =3D 0x0,
 	CBS_LANGUAGE_ENGLISH =3D 0x1,
@@ -364,6 +372,17 @@ struct sms_assembly {
 	GSList *assembly_list;
 };
 =

+struct mr_number {
+	guint8 mr;
+	enum sms_status_report_result delivery_status;
+};
+
+struct pending_status_report {
+	unsigned int ofono_msg_id;
+	struct sms_address receiver;
+	GSList *related_mr_numbers;
+};
+
 struct cbs {
 	enum cbs_geo_scope gs;			/* 2 bits */
 	guint16 message_code;			/* 10 bits */
@@ -481,6 +500,19 @@ GSList *sms_assembly_add_fragment(struct sms_assembly =
*assembly,
 					guint16 ref, guint8 max, guint8 seq);
 void sms_assembly_expire(struct sms_assembly *assembly, time_t before);
 =

+void add_pending_status_report(GSList **pending_status_reports, const int =
mr,
+					const unsigned int msg_id,
+					const struct sms_address *receiver);
+
+void free_pending_status_report(struct pending_status_report *status_repor=
t,
+				GSList **pending_status_reports);
+
+enum ofono_history_sms_status update_pending_status_report_mr_number(
+		GSList **pending_status_reports, const guint8 mr,
+		const struct sms_address *receiver,
+		const enum sms_status_report_result status_report_result,
+		unsigned int *relating_msg_id);
+
 GSList *sms_text_prepare(const char *utf8, guint16 ref,
 				gboolean use_16bit, int *ref_offset,
 				const gboolean use_delivery_reports);
-- =

1.6.0.4



--===============5095828729920257806==--

