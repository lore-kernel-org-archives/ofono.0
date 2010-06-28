Content-Type: multipart/mixed; boundary="===============2511669279842705462=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: Re: [SMS D-Bus 22/23] SMS: set the SRR bit in outgoing PDUs if WFA is
 requested
Date: Mon, 28 Jun 2010 16:30:35 -0700
Message-ID: <1277767835.3006.30.camel@localhost.localdomain>
In-Reply-To: <573bb219ad28699c9c68e1eab80b7ef1659ab1ea.1277507431.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2511669279842705462==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The final patch in this series for integrating the status report into
D-Bus message state machine is added here -- don't want to resubmit the
whole thing as this is still an RFC.

From 2a22f2cb4328c54fb5cb544056541de63667588c Mon Sep 17 00:00:00 2001
From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
Date: Mon, 28 Jun 2010 16:18:27 -0700
Subject: [PATCH] SMS: hookup status reports to message status machine

When a message is waiting for a delivery report, it gets added to an
special queue and it will show in D-Bus. Make it so that when the
message's delivery is acknowledged, the message's status machine is
updated, and thus, D-Bus signals for it are delivered.
---
 src/sms.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/src/sms.c b/src/sms.c
index 27a3d64..bc0f80f 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -1148,6 +1148,21 @@ static void handle_deliver(struct ofono_sms *sms, co=
nst struct sms *incoming)
 	g_slist_free(l);
 }
 =

+
+static void  __sms_find_destroy_by_msg_id(gpointer _sms_msg, gpointer _msg=
_id)
+{
+	unsigned msg_id =3D (unsigned) _msg_id;
+	struct tx_queue_entry *sms_msg =3D _sms_msg;
+
+	if (sms_msg->msg_id !=3D msg_id)
+		return;
+	ofono_debug("SMS: ACKED %p msg_id match %x", sms_msg, msg_id);
+	g_queue_remove(sms_msg->sms_mgr->tx_wfaq, sms_msg);
+	ofono_sms_tx_state_set(sms_msg, OFONO_SMS_TX_ST_DONE);
+	tx_queue_entry_destroy_free(sms_msg, NULL);
+}
+
+
 static void handle_sms_status_report(struct ofono_sms *sms,
 						const struct sms *incoming)
 {
@@ -1159,6 +1174,9 @@ static void handle_sms_status_report(struct ofono_sms=
 *sms,
 						&delivered) =3D=3D FALSE)
 		return;
 =

+	g_queue_foreach(sms->tx_wfaq, __sms_find_destroy_by_msg_id,
+			(void *) msg_id);
+
 	__ofono_history_sms_send_status(modem, msg_id, time(NULL),
 			delivered ? OFONO_HISTORY_SMS_STATUS_DELIVERED :
 			OFONO_HISTORY_SMS_STATUS_DELIVER_FAILED);



--===============2511669279842705462==--

