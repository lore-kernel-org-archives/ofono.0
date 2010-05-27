Content-Type: multipart/mixed; boundary="===============1833152410834125502=="
MIME-Version: 1.0
From: pasi.miettinen@ixonos.com
Subject: [PATCH 09/11] Support for concatenated SMS status report. And
 ofono_history_sms is now updated according to received status reports.
Date: Thu, 27 May 2010 13:54:48 +0300
Message-ID: <1274957690-4893-9-git-send-email-pasi.miettinen@ixonos.com>
In-Reply-To: <1274957690-4893-8-git-send-email-pasi.miettinen@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1833152410834125502==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pasi Miettinen <pasi.miettinen@ixonos.com>

---
 include/history.h |    2 +
 src/sms.c         |  157 +++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 src/smsutil.h     |    6 ++
 3 files changed, 163 insertions(+), 2 deletions(-)

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
index 2d9088b..0a8bf05 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -67,6 +67,17 @@ struct ofono_sms {
 	const struct ofono_sms_driver *driver;
 	void *driver_data;
 	struct ofono_atom *atom;
+	GSList *pending_status_reports;
+};
+
+struct mr_number {
+	guint8 mr;
+	enum sms_status_report_state delivery_status;
+};
+
+struct pending_status_report_mr_numbers {
+	unsigned int ofono_msg_id;
+	GSList *pending_mr_numbers;
 };
 =

 struct pending_pdu {
@@ -82,6 +93,7 @@ struct tx_queue_entry {
 	unsigned int msg_id;
 	unsigned int retry;
 	DBusMessage *msg;
+	gboolean status_report;
 };
 =

 static void set_sca(struct ofono_sms *sms,
@@ -263,6 +275,47 @@ static DBusMessage *sms_set_property(DBusConnection *c=
onn, DBusMessage *msg,
 	return __ofono_error_invalid_args(msg);
 }
 =

+static void add_pending_status_report(struct ofono_sms *sms, int mr,
+							unsigned int msg_id)
+{
+	struct pending_status_report_mr_numbers *status_report_mr_numbers;
+	GSList *l;
+	struct mr_number *new_mr;
+
+	for (l =3D sms->pending_status_reports; l; l =3D l->next) {
+		status_report_mr_numbers =3D l->data;
+
+		if (status_report_mr_numbers->ofono_msg_id =3D=3D msg_id) {
+			/*Relate new MR-number to existing ofono_msg_id*/
+			new_mr =3D g_new0(struct mr_number, 1);
+			new_mr->mr =3D mr;
+			new_mr->delivery_status =3D SMS_STATUS_REPORT_PENDING;
+			status_report_mr_numbers->pending_mr_numbers =3D
+				g_slist_append(status_report_mr_numbers-> \
+						pending_mr_numbers, new_mr);
+			return;
+		}
+	}
+
+	/*Create new ofono_msg_id and relate MR-number to it*/
+	status_report_mr_numbers =3D
+			g_new0(struct pending_status_report_mr_numbers, 1);
+
+	status_report_mr_numbers->ofono_msg_id =3D msg_id;
+
+	new_mr =3D g_new0(struct mr_number, 1);
+	new_mr->mr =3D mr;
+	new_mr->delivery_status =3D SMS_STATUS_REPORT_PENDING;
+	status_report_mr_numbers->pending_mr_numbers =3D
+		g_slist_append(status_report_mr_numbers-> \
+					pending_mr_numbers, new_mr);
+
+	sms->pending_status_reports =3D
+		g_slist_append(sms->pending_status_reports,
+					status_report_mr_numbers);
+
+}
+
 static void tx_finished(const struct ofono_error *error, int mr, void *dat=
a)
 {
 	struct ofono_sms *sms =3D data;
@@ -306,6 +359,9 @@ static void tx_finished(const struct ofono_error *error=
, int mr, void *data)
 	entry->cur_pdu +=3D 1;
 	entry->retry =3D 0;
 =

+	if(entry->status_report)
+		add_pending_status_report(sms, mr, entry->msg_id);
+
 	if (entry->cur_pdu < entry->num_pdus) {
 		sms->tx_source =3D g_timeout_add(0, tx_next, sms);
 		return;
@@ -437,6 +493,7 @@ static DBusMessage *sms_send_message(DBusConnection *co=
nn, DBusMessage *msg,
 =

 	entry->msg =3D dbus_message_ref(msg);
 	entry->msg_id =3D sms->next_msg_id++;
+	entry->status_report =3D ask_status_report;
 =

 	g_queue_push_tail(sms->txq, entry);
 =

@@ -542,11 +599,102 @@ static void dispatch_text_message(struct ofono_sms *=
sms,
 	}
 }
 =

+static void update_pending_status_report_mr_number(struct ofono_sms *sms,
+		guint8 mr, enum sms_status_report_state status_report_state)
+{
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(sms->atom);
+	struct pending_status_report_mr_numbers *status_report_mr_numbers;
+	GSList *l;
+	GSList *i;
+	struct mr_number *current_mr;
+	gboolean delivery_successful;
+
+	/*Each ofono_msg_id can relate to 1-n mr_numbers*/
+	for (l =3D sms->pending_status_reports; l; l =3D l->next) {
+		delivery_successful =3D TRUE;
+		status_report_mr_numbers =3D l->data;
+
+		for(i =3D status_report_mr_numbers->pending_mr_numbers; i;
+								i =3D i->next) {
+			current_mr =3D i->data;
+
+			/*Message with current MR-number was delivered*/
+			if(current_mr->mr =3D=3D mr &&
+				status_report_state =3D=3D
+				SMS_STATUS_REPORT_SENDING_SUCCEEDED) {
+				current_mr->delivery_status =3D
+					SMS_STATUS_REPORT_SENDING_SUCCEEDED;
+			}
+
+			if(current_mr->delivery_status =3D=3D
+				SMS_STATUS_REPORT_PENDING)
+				/*msg_id still relates to pending status report*/
+				delivery_successful =3D FALSE;
+
+			/*If one part of the fragmented message is undelivered,
+			  whole message is declared undelivered*/
+			if(current_mr->mr =3D=3D mr &&
+				status_report_state =3D=3D
+					SMS_STATUS_REPORT_SENDING_FAILED) {
+
+				DBG("SMS-STATUS-REPORT: message %d not "\
+				"delivered", status_report_mr_numbers-> \
+								ofono_msg_id);
+
+				__ofono_history_sms_send_status(modem,
+				     status_report_mr_numbers->ofono_msg_id,
+				     time(NULL),
+				     OFONO_HISTORY_SMS_STATUS_DELIVER_FAILED);
+
+				/*Free msg_id and relating MR-numbers*/
+				g_slist_foreach(status_report_mr_numbers-> \
+					pending_mr_numbers, (GFunc)g_free,
+					NULL);
+				g_slist_free(status_report_mr_numbers-> \
+					pending_mr_numbers);
+				sms->pending_status_reports =3D
+					g_slist_remove(sms-> \
+						pending_status_reports,
+						status_report_mr_numbers);
+				g_free(status_report_mr_numbers);
+
+				/*Received MR is handled*/
+				return;
+			}
+		}
+
+		/*all parts of the message succesfully delivered*/
+		if(delivery_successful) {
+			DBG("SMS-STATUS-REPORT: message %d delivered",
+				status_report_mr_numbers->ofono_msg_id);
+
+			__ofono_history_sms_send_status(modem,
+					status_report_mr_numbers->ofono_msg_id,
+					time(NULL),
+					OFONO_HISTORY_SMS_STATUS_DELIVERED);
+
+			/*Free msg_id and relating MR-numbers*/
+			g_slist_foreach(status_report_mr_numbers-> \
+				pending_mr_numbers, (GFunc)g_free, NULL);
+			g_slist_free(status_report_mr_numbers-> \
+				pending_mr_numbers);
+			sms->pending_status_reports =3D
+				g_slist_remove(sms->pending_status_reports,
+						status_report_mr_numbers);
+			g_free(status_report_mr_numbers);
+
+			/*Received MR is handled*/
+			return;
+		}
+	}
+}
+
 static void dispatch_sms_status_report(struct ofono_sms *sms,
 					const enum sms_st *st,
 					const struct sms_address *raddr,
 					const struct sms_scts *scts,
-					const struct sms_scts *dt)
+					const struct sms_scts *dt,
+					const guint8 mr)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
 	const char *path =3D __ofono_atom_get_path(sms->atom);
@@ -606,11 +754,15 @@ static void dispatch_sms_status_report(struct ofono_s=
ms *sms,
 		str =3D sms_address_to_string(raddr);
 		ofono_dbus_dict_append(&dict, "Message was delivered to",
 							DBUS_TYPE_STRING, &str);
+		update_pending_status_report_mr_number(sms, mr,
+					SMS_STATUS_REPORT_SENDING_SUCCEEDED);
 	}
 	else{
 		str =3D sms_address_to_string(raddr);
 		ofono_dbus_dict_append(&dict, "Message was not delivered to",
 							DBUS_TYPE_STRING, &str);
+		update_pending_status_report_mr_number(sms, mr,
+					SMS_STATUS_REPORT_SENDING_FAILED);
 	}
 =

 	/*dbus-message assembled*/
@@ -736,7 +888,8 @@ static void sms_status_report_dispatch(struct ofono_sms=
 *sms, GSList *sms_list)
 	dispatch_sms_status_report(sms, &s->status_report.st,
 					&s->status_report.raddr,
 					&s->status_report.scts,
-					&s->status_report.dt);
+					&s->status_report.dt,
+					s->status_report.mr);
 =

 }
 =

diff --git a/src/smsutil.h b/src/smsutil.h
index d55b83a..c5dc819 100644
--- a/src/smsutil.h
+++ b/src/smsutil.h
@@ -178,6 +178,12 @@ enum sms_pid_type {
 	SMS_PID_TYPE_USIM_DOWNLOAD =3D 0x7f,
 };
 =

+enum sms_status_report_state {
+	SMS_STATUS_REPORT_PENDING =3D 0,
+	SMS_STATUS_REPORT_SENDING_FAILED =3D1,
+	SMS_STATUS_REPORT_SENDING_SUCCEEDED =3D 2,
+};
+
 enum cbs_language {
 	CBS_LANGUAGE_GERMAN =3D 0x0,
 	CBS_LANGUAGE_ENGLISH =3D 0x1,
-- =

1.6.0.4


--===============1833152410834125502==--

