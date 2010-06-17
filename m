Content-Type: multipart/mixed; boundary="===============7071428485521033339=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 1/5] stk: Add parser for send ussd commands
Date: Thu, 17 Jun 2010 18:35:07 +0800
Message-ID: <1276770911-8817-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7071428485521033339==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   61 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/stkutil.h |    9 ++++++++
 2 files changed, 70 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 44a8eff..f03b25c 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -585,6 +585,24 @@ static gboolean parse_dataobj_tone(struct comprehensio=
n_tlv_iter *iter,
 	return parse_dataobj_common_byte(iter, byte);
 }
 =

+/* Defined in TS 102.223 Section 8.17 */
+static gboolean parse_dataobj_ussd(struct comprehension_tlv_iter *iter,
+					void *user)
+{
+	struct stk_ussd_string *us =3D user;
+	unsigned int len =3D comprehension_tlv_iter_get_length(iter);
+	const unsigned char *data =3D comprehension_tlv_iter_get_data(iter);
+
+	if (len <=3D 1)
+		return FALSE;
+
+	us->dcs =3D data[0];
+	us->len =3D len - 1;
+	memcpy(us->string, data + 1, us->len);
+
+	return TRUE;
+}
+
 /* Defined in TS 102.223 Section 8.18 */
 static gboolean parse_dataobj_file_list(struct comprehension_tlv_iter *ite=
r,
 					void *user)
@@ -1996,6 +2014,8 @@ static dataobj_handler handler_for_type(enum stk_data=
_object_type type)
 		return parse_dataobj_text;
 	case STK_DATA_OBJECT_TYPE_TONE:
 		return parse_dataobj_tone;
+	case STK_DATA_OBJECT_TYPE_USSD_STRING:
+		return parse_dataobj_ussd;
 	case STK_DATA_OBJECT_TYPE_FILE_LIST:
 		return parse_dataobj_file_list;
 	case STK_DATA_OBJECT_TYPE_LOCATION_INFO:
@@ -2710,6 +2730,44 @@ static gboolean parse_send_ss(struct stk_command *co=
mmand,
 	return TRUE;
 }
 =

+static void destroy_send_ussd(struct stk_command *command)
+{
+	g_free(command->send_ussd.alpha_id);
+}
+
+static gboolean parse_send_ussd(struct stk_command *command,
+					struct comprehension_tlv_iter *iter)
+{
+	struct stk_command_send_ussd *obj =3D &command->send_ussd;
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
+				STK_DATA_OBJECT_TYPE_USSD_STRING,
+				DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
+				&obj->ussd_string,
+				STK_DATA_OBJECT_TYPE_ICON_ID, 0,
+				&obj->icon_id,
+				STK_DATA_OBJECT_TYPE_TEXT_ATTRIBUTE, 0,
+				&obj->text_attr,
+				STK_DATA_OBJECT_TYPE_FRAME_ID, 0,
+				&obj->frame_id,
+				STK_DATA_OBJECT_TYPE_INVALID);
+
+	command->destructor =3D destroy_send_ussd;
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
@@ -3672,6 +3730,9 @@ struct stk_command *stk_command_new_from_pdu(const un=
signed char *pdu,
 	case STK_COMMAND_TYPE_SEND_SS:
 		ok =3D parse_send_ss(command, &iter);
 		break;
+	case STK_COMMAND_TYPE_SEND_USSD:
+		ok =3D parse_send_ussd(command, &iter);
+		break;
 	case STK_COMMAND_TYPE_SETUP_CALL:
 		ok =3D parse_setup_call(command, &iter);
 		break;
diff --git a/src/stkutil.h b/src/stkutil.h
index 471e10f..6fb49e0 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -1117,6 +1117,14 @@ struct stk_command_send_ss {
 	struct stk_frame_id frame_id;
 };
 =

+struct stk_command_send_ussd {
+	char *alpha_id;
+	struct stk_ussd_string ussd_string;
+	struct stk_icon_id icon_id;
+	struct stk_text_attribute text_attr;
+	struct stk_frame_id frame_id;
+};
+
 struct stk_command_setup_call {
 	char *alpha_id_usr_cfm;
 	struct stk_address addr;
@@ -1295,6 +1303,7 @@ struct stk_command {
 		struct stk_command_select_item select_item;
 		struct stk_command_send_sms send_sms;
 		struct stk_command_send_ss send_ss;
+		struct stk_command_send_ussd send_ussd;
 		struct stk_command_setup_call setup_call;
 		struct stk_command_setup_event_list setup_event_list;
 		struct stk_command_perform_card_apdu perform_card_apdu;
-- =

1.7.0.4


--===============7071428485521033339==--

