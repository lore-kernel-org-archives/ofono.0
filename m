Content-Type: multipart/mixed; boundary="===============6344261583654385208=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH v3 1/4] Add macro for general result and additional info
Date: Mon, 18 Oct 2010 16:00:28 +0800
Message-ID: <1287388831-27269-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6344261583654385208==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.h |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.h b/src/stkutil.h
index 2d98185..5c75524 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -254,6 +254,8 @@ enum stk_result_type {
 	STK_RESULT_TYPE_COMMAND_NOT_UNDERSTOOD =3D	0x31,
 	STK_RESULT_TYPE_DATA_NOT_UNDERSTOOD =3D		0x32,
 	STK_RESULT_TYPE_COMMAND_ID_UNKNOWN =3D		0x33,
+	STK_RESULT_TYPE_SS_RETURN_ERROR =3D		0x34,
+	STK_RESULT_TYPE_SMS_RP_ERROR =3D			0x35,
 	STK_RESULT_TYPE_MINIMUM_NOT_MET =3D		0x36,
 	STK_RESULT_TYPE_USSD_RETURN_ERROR =3D		0x37,
 	STK_RESULT_TYPE_CALL_CONTROL_PERMANENT =3D	0x39,
@@ -263,6 +265,26 @@ enum stk_result_type {
 	STK_RESULT_TYPE_MMS_ERROR =3D			0x3D,
 };
 =

+/* Defined according to TS 102.223 Section 8.12.2 */
+enum stk_result_addnl_me_pb {
+	STK_RESULT_ADDNL_ME_PB_NO_SPECIFIC_CAUSE =3D	0x00,
+	STK_RESULT_ADDNL_ME_PB_SCREEN_BUSY =3D		0x01,
+	STK_RESULT_ADDNL_ME_PB_BUSY_ON_CALL =3D		0x02,
+	STK_RESULT_ADDNL_ME_PB_SS_BUSY =3D		0x03,
+	STK_RESULT_ADDNL_ME_PB_NO_SERVICE =3D		0x04,
+	STK_RESULT_ADDNL_ME_PB_NO_ACCESS =3D		0x05,
+	STK_RESULT_ADDNL_ME_PB_NO_RADIO_RESOURCE =3D	0x06,
+	STK_RESULT_ADDNL_ME_PB_NOT_IN_SPEECH_CALL =3D	0x07,
+	STK_RESULT_ADDNL_ME_PB_USSD_BUSY =3D		0x08,
+	STK_RESULT_ADDNL_ME_PB_BUSY_ON_SEND_DTMF =3D	0x09,
+	STK_RESULT_ADDNL_ME_PB_NO_NAA_ACTIVE =3D		0x0A
+};
+
+/* Defined according to TS 31.111 Section 8.12.4 */
+enum stk_result_addnl_ss_pb {
+	STK_RESULT_ADDNL_SS_PB_NO_SPECIFIC_CAUSE =3D	0x00
+};
+
 enum stk_tone_type {
 	STK_TONE_TYPE_DIAL_TONE =3D	0x01,
 	STK_TONE_TYPE_BUSY_TONE =3D	0x02,
-- =

1.7.2.3


--===============6344261583654385208==--

