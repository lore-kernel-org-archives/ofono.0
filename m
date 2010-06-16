Content-Type: multipart/mixed; boundary="===============2141859678790935804=="
MIME-Version: 1.0
From: Pasi Miettinen <pasi.miettinen@ixonos.com>
Subject: [RFC PATCH 4/5] sms: Status report notify
Date: Wed, 16 Jun 2010 17:08:25 +0300
Message-ID: <1276697306-1587-5-git-send-email-pasi.miettinen@ixonos.com>
In-Reply-To: <1276697306-1587-4-git-send-email-pasi.miettinen@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2141859678790935804==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/sms.c |   71 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 files changed, 70 insertions(+), 1 deletions(-)

diff --git a/src/sms.c b/src/sms.c
index bf6d261..e6a2dca 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -68,6 +68,8 @@ struct ofono_sms {
 	void *driver_data;
 	struct ofono_atom *atom;
 	ofono_bool_t use_delivery_reports;
+	struct status_report_assembly *sr_assembly;
+
 };
 =

 struct pending_pdu {
@@ -83,6 +85,8 @@ struct tx_queue_entry {
 	unsigned int msg_id;
 	unsigned int retry;
 	DBusMessage *msg;
+	gboolean status_report;
+	struct sms_address receiver;
 };
 =

 static void set_sca(struct ofono_sms *sms,
@@ -331,6 +335,13 @@ static void tx_finished(const struct ofono_error *erro=
r, int mr, void *data)
 	entry->cur_pdu +=3D 1;
 	entry->retry =3D 0;
 =

+	if (entry->status_report)
+		status_report_assembly_add_fragment(sms->sr_assembly,
+							entry->msg_id,
+							&entry->receiver,
+							mr, time(NULL),
+							entry->num_pdus);
+
 	if (entry->cur_pdu < entry->num_pdus) {
 		sms->tx_source =3D g_timeout_add(0, tx_next, sms);
 		return;
@@ -462,6 +473,8 @@ static DBusMessage *sms_send_message(DBusConnection *co=
nn, DBusMessage *msg,
 	set_ref_and_to(msg_list, sms->ref, ref_offset, to);
 	entry =3D create_tx_queue_entry(msg_list);
 =

+	sms_address_from_string(&entry->receiver, to);
+
 	g_slist_foreach(msg_list, (GFunc)g_free, NULL);
 	g_slist_free(msg_list);
 =

@@ -474,6 +487,7 @@ static DBusMessage *sms_send_message(DBusConnection *co=
nn, DBusMessage *msg,
 =

 	entry->msg =3D dbus_message_ref(msg);
 	entry->msg_id =3D sms->next_msg_id++;
+	entry->status_report =3D sms->use_delivery_reports;
 =

 	g_queue_push_tail(sms->txq, entry);
 =

@@ -718,6 +732,30 @@ static void handle_deliver(struct ofono_sms *sms, cons=
t struct sms *incoming)
 	g_slist_free(l);
 }
 =

+static void handle_sms_status_report(struct ofono_sms *sms,
+						const struct sms *incoming)
+{
+	gboolean delivered;
+	unsigned int msg_id;
+	gboolean update_history;
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(sms->atom);
+
+	update_history =3D status_report_assembly_report(sms->sr_assembly,
+						incoming, &msg_id, &delivered);
+
+	if (update_history) {
+
+		if (delivered)
+			__ofono_history_sms_send_status(modem, msg_id,
+				time(NULL), OFONO_HISTORY_SMS_STATUS_DELIVERED);
+		else
+			__ofono_history_sms_send_status(modem, msg_id,
+				time(NULL),
+				OFONO_HISTORY_SMS_STATUS_DELIVER_FAILED);
+	}
+}
+
+
 static inline gboolean handle_mwi(struct ofono_sms *sms, struct sms *s)
 {
 	gboolean discard;
@@ -849,7 +887,30 @@ out:
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
+	if (s.status_report.srq) {
+		ofono_error("Waiting an answer to SMS-SUBMIT, not SMS-COMMAND");
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
@@ -932,6 +993,11 @@ static void sms_remove(struct ofono_atom *atom)
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

@@ -1069,9 +1135,12 @@ void ofono_sms_register(struct ofono_sms *sms)
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



--===============2141859678790935804==--

