Content-Type: multipart/mixed; boundary="===============0716226490015102454=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 01/12] stk: Add parser for send ss commands
Date: Sun, 13 Jun 2010 17:43:11 +0800
Message-ID: <1276422202-16240-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0716226490015102454==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   70 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/stkutil.h |   15 ++++++++++++
 2 files changed, 85 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 8ac1dba..642e141 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -499,6 +499,32 @@ static gboolean parse_dataobj_gsm_sms_tpdu(struct comp=
rehension_tlv_iter *iter,
 	return TRUE;
 }
 =

+/* Defined in TS 102.223 Section 8.14 */
+static gboolean parse_dataobj_ss(struct comprehension_tlv_iter *iter,
+					void *user)
+{
+	struct stk_ss *ss =3D user;
+	const unsigned char *data;
+	unsigned int len;
+	char *s;
+
+	len =3D comprehension_tlv_iter_get_length(iter);
+	if (len < 2)
+		return FALSE;
+
+	data =3D comprehension_tlv_iter_get_data(iter);
+
+	s =3D g_try_malloc(len * 2 - 1);
+	if (s =3D=3D NULL)
+		return FALSE;
+
+	ss->ton_npi =3D data[0];
+	ss->ss =3D s;
+	sim_extract_bcd_number(data + 1, len - 1, ss->ss);
+
+	return TRUE;
+}
+
 /* Defined in TS 102.223 Section 8.15 */
 static gboolean parse_dataobj_text(struct comprehension_tlv_iter *iter,
 					void *user)
@@ -1864,6 +1890,8 @@ static dataobj_handler handler_for_type(enum stk_data=
_object_type type)
 		return parse_dataobj_result;
 	case STK_DATA_OBJECT_TYPE_GSM_SMS_TPDU:
 		return parse_dataobj_gsm_sms_tpdu;
+	case STK_DATA_OBJECT_TYPE_SS_STRING:
+		return parse_dataobj_ss;
 	case STK_DATA_OBJECT_TYPE_TEXT:
 		return parse_dataobj_text;
 	case STK_DATA_OBJECT_TYPE_TONE:
@@ -2537,6 +2565,45 @@ static gboolean parse_send_sms(struct stk_command *c=
ommand,
 	return TRUE;
 }
 =

+static void destroy_send_ss(struct stk_command *command)
+{
+	g_free(command->send_ss.alpha_id);
+	g_free(command->send_ss.ss.ss);
+}
+
+static gboolean parse_send_ss(struct stk_command *command,
+					struct comprehension_tlv_iter *iter)
+{
+	struct stk_command_send_ss *obj =3D &command->send_ss;
+	gboolean ret;
+
+	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
+		return FALSE;
+
+	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_NETWORK)
+		return FALSE;
+
+	ret =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_ALPHA_ID, 0,
+				&obj->alpha_id,
+				STK_DATA_OBJECT_TYPE_SS_STRING,
+				DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
+				&obj->ss,
+				STK_DATA_OBJECT_TYPE_ICON_ID, 0,
+				&obj->icon_id,
+				STK_DATA_OBJECT_TYPE_TEXT_ATTRIBUTE, 0,
+				&obj->text_attr,
+				STK_DATA_OBJECT_TYPE_FRAME_ID, 0,
+				&obj->frame_id,
+				STK_DATA_OBJECT_TYPE_INVALID);
+
+	command->destructor =3D destroy_send_ss;
+
+	if (ret =3D=3D FALSE)
+		return FALSE;
+
+	return TRUE;
+}
+
 static void destroy_setup_call(struct stk_command *command)
 {
 	g_free(command->setup_call.alpha_id_usr_cfm);
@@ -3062,6 +3129,9 @@ struct stk_command *stk_command_new_from_pdu(const un=
signed char *pdu,
 	case STK_COMMAND_TYPE_SEND_SMS:
 		ok =3D parse_send_sms(command, &iter);
 		break;
+	case STK_COMMAND_TYPE_SEND_SS:
+		ok =3D parse_send_ss(command, &iter);
+		break;
 	case STK_COMMAND_TYPE_SETUP_CALL:
 		ok =3D parse_setup_call(command, &iter);
 		break;
diff --git a/src/stkutil.h b/src/stkutil.h
index 2da787d..d73d5e1 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -525,6 +525,12 @@ struct stk_result {
 	unsigned char *additional;
 };
 =

+/* Defined in TS 102.223 Section 8.14 */
+struct stk_ss {
+	unsigned char ton_npi;
+	char *ss;
+};
+
 /* Define the struct of single file in TS102.223 Section 8.18.
  * According to TS 11.11 Section 6.2, each file id has two bytes, and the
  * maximum Dedicated File level is 2. So the maximum size of file is 8, wh=
ich
@@ -933,6 +939,14 @@ struct stk_command_send_sms {
 	struct stk_frame_id frame_id;
 };
 =

+struct stk_command_send_ss {
+	char *alpha_id;
+	struct stk_ss ss;
+	struct stk_icon_id icon_id;
+	struct stk_text_attribute text_attr;
+	struct stk_frame_id frame_id;
+};
+
 struct stk_command_setup_call {
 	char *alpha_id_usr_cfm;
 	struct stk_address addr;
@@ -1028,6 +1042,7 @@ struct stk_command {
 		struct stk_command_setup_menu setup_menu;
 		struct stk_command_select_item select_item;
 		struct stk_command_send_sms send_sms;
+		struct stk_command_send_ss send_ss;
 		struct stk_command_setup_call setup_call;
 		struct stk_command_setup_event_list setup_event_list;
 		struct stk_command_perform_card_apdu perform_card_apdu;
-- =

1.7.0.4


--===============0716226490015102454==--

