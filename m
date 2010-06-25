Content-Type: multipart/mixed; boundary="===============4017699555544702180=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: [SMS D-Bus 22/23] SMS: set the SRR bit in outgoing PDUs if WFA is
 requested
Date: Fri, 25 Jun 2010 16:15:44 -0700
Message-ID: <573bb219ad28699c9c68e1eab80b7ef1659ab1ea.1277507431.git.inaky.perez-gonzalez@intel.com>
In-Reply-To: <cover.1277507431.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4017699555544702180==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>

When calling sms_text_prepare(), pass a new argument (srr) that
denotes if the TP-SRR bit in the PDU should be set to request an
Status Report from the Service Center.
---
 src/sms.c     |   13 ++++++++++---
 src/smsutil.h |    2 ++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/src/sms.c b/src/sms.c
index 96315b2..1b35fa9 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -752,6 +752,7 @@ struct tx_queue_entry *sms_msg_send(
 	struct sms_address receiver;
 	DECLARE_SMS_ADDR_STR(receiver_str);
 	const char *sms_path =3D __ofono_atom_get_path(sms->atom);
+	gboolean status_report;
 =

 	if (valid_phone_number_format(to) =3D=3D FALSE)
 		return NULL;
@@ -767,8 +768,14 @@ struct tx_queue_entry *sms_msg_send(
 	    =3D=3D FALSE)
 		return NULL;
 =

-	msg_list =3D sms_text_prepare(text, 0, TRUE, &ref_offset,
-					sms->use_delivery_reports);
+	/*
+	 * Request submit report? Set it in sms->submit for the
+	 * encoding code to decide how to encode it, take the default
+	 * from the SMS manager object.
+	 */
+	status_report =3D flags & SMS_MSG_SEND_STATUS_REPORT ?
+		TRUE : sms->use_delivery_reports;
+	msg_list =3D sms_text_prepare(text, 0, TRUE, &ref_offset, status_report);
 =

 	if (!msg_list)
 		return NULL;
@@ -790,7 +797,7 @@ struct tx_queue_entry *sms_msg_send(
 =

 	g_slist_foreach(msg_list, (GFunc)g_free, NULL);
 	g_slist_free(msg_list);
-	entry->status_report =3D sms->use_delivery_reports;
+	entry->status_report =3D status_report;
 	entry->name =3D g_strdup_printf(SMS_MSG_NAME_FMT, sms_path,
 				      msg_id_str, entry->num_pdus);
 	ofono_debug("sms/entry %p name %s\n", entry, entry->name);
diff --git a/src/smsutil.h b/src/smsutil.h
index ad1e560..bf23f0c 100644
--- a/src/smsutil.h
+++ b/src/smsutil.h
@@ -569,6 +569,8 @@ enum sms_msg_cancel_flags {
 	 * tries to cancel it if in transit.
 	 */
 	SMS_MSG_CANCEL_IN_NETWORK =3D 0x1,
+	/* Request and wait for receipt acknowledgement from the network */
+	SMS_MSG_SEND_STATUS_REPORT =3D 0x02,
 };
 =

 struct tx_queue_entry;
-- =

1.6.6.1


--===============4017699555544702180==--

