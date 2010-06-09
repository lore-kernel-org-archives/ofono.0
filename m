Content-Type: multipart/mixed; boundary="===============5160081122489312289=="
MIME-Version: 1.0
From: Pasi Miettinen <pasi.miettinen@ixonos.com>
Subject: [RFC PATCH 3/3] sms: status report notify
Date: Wed, 09 Jun 2010 17:01:55 +0300
Message-ID: <1276092115-22684-4-git-send-email-pasi.miettinen@ixonos.com>
In-Reply-To: <1276092115-22684-3-git-send-email-pasi.miettinen@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5160081122489312289==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/history.h |    3 ++
 src/sms.c         |   59 +++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 2 files changed, 61 insertions(+), 1 deletions(-)

diff --git a/include/history.h b/include/history.h
index 300a4fb..61a0dea 100644
--- a/include/history.h
+++ b/include/history.h
@@ -33,6 +33,9 @@ enum ofono_history_sms_status {
 	OFONO_HISTORY_SMS_STATUS_PENDING,
 	OFONO_HISTORY_SMS_STATUS_SUBMITTED,
 	OFONO_HISTORY_SMS_STATUS_SUBMIT_FAILED,
+	OFONO_HISTORY_SMS_STATUS_DELIVERED,
+	OFONO_HISTORY_SMS_STATUS_DELIVER_FAILED,
+	OFONO_HISTORY_SMS_STATUS_ERROR,
 };
 =

 struct ofono_history_context {
diff --git a/src/sms.c b/src/sms.c
index c0e9fc4..1e78b9e 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -67,6 +67,8 @@ struct ofono_sms {
 	const struct ofono_sms_driver *driver;
 	void *driver_data;
 	struct ofono_atom *atom;
+	ofono_bool_t use_delivery_reports;
+	struct status_report_assembly *sr_assembly;
 };
 =

 struct pending_pdu {
@@ -82,6 +84,8 @@ struct tx_queue_entry {
 	unsigned int msg_id;
 	unsigned int retry;
 	DBusMessage *msg;
+	gboolean status_report;
+	struct sms_address receiver;
 };
 =

 static void set_sca(struct ofono_sms *sms,
@@ -306,6 +310,12 @@ static void tx_finished(const struct ofono_error *erro=
r, int mr, void *data)
 	entry->cur_pdu +=3D 1;
 	entry->retry =3D 0;
 =

+	if (entry->status_report)
+		status_report_assembly_add_fragment(sms->sr_assembly,
+							&entry->msg_id,
+							&entry->receiver,
+							mr, time(NULL));
+
 	if (entry->cur_pdu < entry->num_pdus) {
 		sms->tx_source =3D g_timeout_add(0, tx_next, sms);
 		return;
@@ -436,6 +446,8 @@ static DBusMessage *sms_send_message(DBusConnection *co=
nn, DBusMessage *msg,
 	set_ref_and_to(msg_list, sms->ref, ref_offset, to);
 	entry =3D create_tx_queue_entry(msg_list);
 =

+	sms_address_from_string(&entry->receiver, to);
+
 	g_slist_foreach(msg_list, (GFunc)g_free, NULL);
 	g_slist_free(msg_list);
 =

@@ -448,6 +460,7 @@ static DBusMessage *sms_send_message(DBusConnection *co=
nn, DBusMessage *msg,
 =

 	entry->msg =3D dbus_message_ref(msg);
 	entry->msg_id =3D sms->next_msg_id++;
+	entry->status_report =3D sms->use_delivery_reports;
 =

 	g_queue_push_tail(sms->txq, entry);
 =

@@ -692,6 +705,24 @@ static void handle_deliver(struct ofono_sms *sms, cons=
t struct sms *incoming)
 	g_slist_free(l);
 }
 =

+static void handle_sms_status_report(struct ofono_sms *sms,
+						const struct sms *incoming)
+{
+	unsigned int msg_id;
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(sms->atom);
+
+	if (incoming->status_report.st =3D=3D SMS_ST_COMPLETED_RECEIVED) {
+
+		if (status_report_assembly_report(sms->sr_assembly,
+		incoming, &msg_id) =3D=3D OFONO_HISTORY_SMS_STATUS_DELIVERED)
+			__ofono_history_sms_send_status(modem, msg_id,
+				time(NULL), OFONO_HISTORY_SMS_STATUS_DELIVERED);
+	} else
+		__ofono_history_sms_send_status(modem, msg_id, time(NULL),
+				OFONO_HISTORY_SMS_STATUS_DELIVER_FAILED);
+}
+
+
 static inline gboolean handle_mwi(struct ofono_sms *sms, struct sms *s)
 {
 	gboolean discard;
@@ -823,7 +854,25 @@ out:
 void ofono_sms_status_notify(struct ofono_sms *sms, unsigned char *pdu,
 				int len, int tpdu_len)
 {
-	ofono_error("SMS Status-Report not yet handled");
+	struct sms s;
+	enum sms_class cls;
+
+	if (!sms_decode(pdu, len, FALSE, tpdu_len, &s)) {
+		ofono_error("Unable to decode PDU");
+		return;
+	}
+
+	if (s.type !=3D SMS_TYPE_STATUS_REPORT) {
+		ofono_error("Expecting a STATUS REPORT pdu");
+		return;
+	}
+
+	if (!sms_dcs_decode(s.deliver.dcs, &cls, NULL, NULL, NULL)) {
+		ofono_error("Unknown / Reserved DCS.  Ignoring");
+		return;
+	}
+
+	handle_sms_status_report(sms, &s);
 }
 =

 int ofono_sms_driver_register(const struct ofono_sms_driver *d)
@@ -903,6 +952,11 @@ static void sms_remove(struct ofono_atom *atom)
 		sms->settings =3D NULL;
 	}
 =

+	if (sms->sr_assembly) {
+		status_report_assembly_free(sms->sr_assembly);
+		sms->sr_assembly =3D NULL;
+	}
+
 	g_free(sms);
 }
 =

@@ -1038,9 +1092,12 @@ void ofono_sms_register(struct ofono_sms *sms)
 		imsi =3D ofono_sim_get_imsi(sms->sim);
 		sms->assembly =3D sms_assembly_new(imsi);
 =

+		sms->sr_assembly =3D status_report_assembly_new(imsi);
+
 		sms_load_settings(sms, imsi);
 	} else {
 		sms->assembly =3D sms_assembly_new(NULL);
+		sms->sr_assembly =3D status_report_assembly_new(NULL);
 	}
 =

 	__ofono_atom_register(sms->atom, sms_unregister);
-- =

1.6.0.4



--===============5160081122489312289==--

