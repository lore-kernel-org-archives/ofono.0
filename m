Content-Type: multipart/mixed; boundary="===============4388524691332550480=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 07/11] added stk_response_text_string for USSD result
Date: Wed, 01 Sep 2010 04:00:32 -0700
Message-ID: <1283338836-13572-7-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1283338836-13572-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4388524691332550480==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.h |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.h b/src/stkutil.h
index 44d167a..66d2e55 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -237,6 +237,7 @@ enum stk_result_type {
 	STK_RESULT_TYPE_GO_BACK =3D			0x11,
 	STK_RESULT_TYPE_NO_RESPONSE =3D			0x12,
 	STK_RESULT_TYPE_HELP_REQUESTED =3D		0x13,
+	STK_RESULT_TYPE_USSD_OR_SS_USER_TERMINATION =3D   0x14,
 =

 	/* 0x20 to 0x2F are used to indicate that SIM should retry */
 	STK_RESULT_TYPE_TERMINAL_BUSY =3D			0x20,
@@ -254,6 +255,7 @@ enum stk_result_type {
 	STK_RESULT_TYPE_DATA_NOT_UNDERSTOOD =3D		0x32,
 	STK_RESULT_TYPE_COMMAND_ID_UNKNOWN =3D		0x33,
 	STK_RESULT_TYPE_MINIMUM_NOT_MET =3D		0x36,
+	STK_RESULT_TYPE_USSD_RETURN_ERROR =3D             0x37,
 	STK_RESULT_TYPE_CALL_CONTROL_PERMANENT =3D	0x39,
 	STK_RESULT_TYPE_BIP_ERROR =3D			0x3A,
 	STK_RESULT_TYPE_ACCESS_TECHNOLOGY_ERROR =3D	0x3B,
@@ -1445,6 +1447,11 @@ struct stk_response_run_at_command {
 	const char *at_response;
 };
 =

+struct stk_response_text_string {
+	unsigned char dcs;
+	const unsigned char *text;
+};
+
 struct stk_response {
 	unsigned char number;
 	unsigned char type;
@@ -1474,6 +1481,7 @@ struct stk_response {
 		struct stk_response_generic send_dtmf;
 		struct stk_response_generic language_notification;
 		struct stk_response_generic launch_browser;
+		struct stk_response_text_string send_ussd;
 	};
 =

 	void (*destructor)(struct stk_response *response);
-- =

1.7.0.4



----------------------------------------------------------------
Please note: This e-mail may contain confidential information
intended solely for the addressee. If you have received this
e-mail in error, please do not disclose it to anyone, notify
the sender promptly, and delete the message from your system.
Thank you.



----------------------------------------------------------------
Please note: This e-mail may contain confidential information
intended solely for the addressee. If you have received this
e-mail in error, please do not disclose it to anyone, notify
the sender promptly, and delete the message from your system.
Thank you.


--===============4388524691332550480==--

