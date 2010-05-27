Content-Type: multipart/mixed; boundary="===============7569365767242930591=="
MIME-Version: 1.0
From: pasi.miettinen@ixonos.com
Subject: [PATCH 10/11] Some naming changes to enum sms_status_report_result.
Date: Thu, 27 May 2010 13:54:49 +0300
Message-ID: <1274957690-4893-10-git-send-email-pasi.miettinen@ixonos.com>
In-Reply-To: <1274957690-4893-9-git-send-email-pasi.miettinen@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7569365767242930591==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pasi Miettinen <pasi.miettinen@ixonos.com>

---
 src/sms.c     |   21 +++++++++++----------
 src/smsutil.h |    8 ++++----
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/src/sms.c b/src/sms.c
index 0a8bf05..de2d367 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -72,7 +72,7 @@ struct ofono_sms {
 =

 struct mr_number {
 	guint8 mr;
-	enum sms_status_report_state delivery_status;
+	enum sms_status_report_result delivery_status;
 };
 =

 struct pending_status_report_mr_numbers {
@@ -289,7 +289,8 @@ static void add_pending_status_report(struct ofono_sms =
*sms, int mr,
 			/*Relate new MR-number to existing ofono_msg_id*/
 			new_mr =3D g_new0(struct mr_number, 1);
 			new_mr->mr =3D mr;
-			new_mr->delivery_status =3D SMS_STATUS_REPORT_PENDING;
+			new_mr->delivery_status =3D
+				SMS_STATUS_REPORT_STATUS_PENDING;
 			status_report_mr_numbers->pending_mr_numbers =3D
 				g_slist_append(status_report_mr_numbers-> \
 						pending_mr_numbers, new_mr);
@@ -305,7 +306,7 @@ static void add_pending_status_report(struct ofono_sms =
*sms, int mr,
 =

 	new_mr =3D g_new0(struct mr_number, 1);
 	new_mr->mr =3D mr;
-	new_mr->delivery_status =3D SMS_STATUS_REPORT_PENDING;
+	new_mr->delivery_status =3D SMS_STATUS_REPORT_STATUS_PENDING;
 	status_report_mr_numbers->pending_mr_numbers =3D
 		g_slist_append(status_report_mr_numbers-> \
 					pending_mr_numbers, new_mr);
@@ -600,7 +601,7 @@ static void dispatch_text_message(struct ofono_sms *sms,
 }
 =

 static void update_pending_status_report_mr_number(struct ofono_sms *sms,
-		guint8 mr, enum sms_status_report_state status_report_state)
+		guint8 mr, enum sms_status_report_result status_report_state)
 {
 	struct ofono_modem *modem =3D __ofono_atom_get_modem(sms->atom);
 	struct pending_status_report_mr_numbers *status_report_mr_numbers;
@@ -621,13 +622,13 @@ static void update_pending_status_report_mr_number(st=
ruct ofono_sms *sms,
 			/*Message with current MR-number was delivered*/
 			if(current_mr->mr =3D=3D mr &&
 				status_report_state =3D=3D
-				SMS_STATUS_REPORT_SENDING_SUCCEEDED) {
+				SMS_STATUS_REPORT_MESSAGE_DELIVERED) {
 				current_mr->delivery_status =3D
-					SMS_STATUS_REPORT_SENDING_SUCCEEDED;
+					SMS_STATUS_REPORT_MESSAGE_DELIVERED;
 			}
 =

 			if(current_mr->delivery_status =3D=3D
-				SMS_STATUS_REPORT_PENDING)
+				SMS_STATUS_REPORT_STATUS_PENDING)
 				/*msg_id still relates to pending status report*/
 				delivery_successful =3D FALSE;
 =

@@ -635,7 +636,7 @@ static void update_pending_status_report_mr_number(stru=
ct ofono_sms *sms,
 			  whole message is declared undelivered*/
 			if(current_mr->mr =3D=3D mr &&
 				status_report_state =3D=3D
-					SMS_STATUS_REPORT_SENDING_FAILED) {
+					SMS_STATUS_REPORT_MESSAGE_NOT_DELIVERED) {
 =

 				DBG("SMS-STATUS-REPORT: message %d not "\
 				"delivered", status_report_mr_numbers-> \
@@ -755,14 +756,14 @@ static void dispatch_sms_status_report(struct ofono_s=
ms *sms,
 		ofono_dbus_dict_append(&dict, "Message was delivered to",
 							DBUS_TYPE_STRING, &str);
 		update_pending_status_report_mr_number(sms, mr,
-					SMS_STATUS_REPORT_SENDING_SUCCEEDED);
+					SMS_STATUS_REPORT_MESSAGE_DELIVERED);
 	}
 	else{
 		str =3D sms_address_to_string(raddr);
 		ofono_dbus_dict_append(&dict, "Message was not delivered to",
 							DBUS_TYPE_STRING, &str);
 		update_pending_status_report_mr_number(sms, mr,
-					SMS_STATUS_REPORT_SENDING_FAILED);
+					SMS_STATUS_REPORT_MESSAGE_NOT_DELIVERED);
 	}
 =

 	/*dbus-message assembled*/
diff --git a/src/smsutil.h b/src/smsutil.h
index c5dc819..40ceead 100644
--- a/src/smsutil.h
+++ b/src/smsutil.h
@@ -178,10 +178,10 @@ enum sms_pid_type {
 	SMS_PID_TYPE_USIM_DOWNLOAD =3D 0x7f,
 };
 =

-enum sms_status_report_state {
-	SMS_STATUS_REPORT_PENDING =3D 0,
-	SMS_STATUS_REPORT_SENDING_FAILED =3D1,
-	SMS_STATUS_REPORT_SENDING_SUCCEEDED =3D 2,
+enum sms_status_report_result {
+	SMS_STATUS_REPORT_STATUS_PENDING =3D 0,
+	SMS_STATUS_REPORT_MESSAGE_NOT_DELIVERED =3D 1,
+	SMS_STATUS_REPORT_MESSAGE_DELIVERED =3D 2,
 };
 =

 enum cbs_language {
-- =

1.6.0.4


--===============7569365767242930591==--

