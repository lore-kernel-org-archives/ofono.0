Content-Type: multipart/mixed; boundary="===============0894468070891912420=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCHv2 2/3] stkutil: add missing text and icon check
Date: Tue, 04 Jan 2011 14:42:02 -0800
Message-ID: <1294180923-12241-3-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1294180923-12241-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0894468070891912420==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

As per the ETSI TS 102 223 section 6.5.4, If the terminal
receives an icon, and either an empty or no alpha identifier/text string
is given by the UICC, than the terminal shall reject the command
with general result "Command data not understood by terminal".
---
 src/stkutil.c |  120 +++++++++++++++++++++++++++++++++++++++++++++++++----=
---
 1 files changed, 105 insertions(+), 15 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 8aee8f7..f7ea193 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -74,6 +74,13 @@ struct gsm_sms_tpdu {
 	unsigned char tpdu[184];
 };
 =

+#define CHECK_TEXT_AND_ICON(text, icon_id)			\
+	if (status !=3D STK_PARSE_RESULT_OK)			\
+		return status;					\
+								\
+	if ((text =3D=3D NULL || text[0] =3D=3D '\0') && icon_id !=3D 0)	\
+		status =3D STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;	\
+
 static char *decode_text(unsigned char dcs, int len, const unsigned char *=
data)
 {
 	char *utf8;
@@ -2383,6 +2390,7 @@ static enum stk_command_parse_result parse_display_te=
xt(
 					struct comprehension_tlv_iter *iter)
 {
 	struct stk_command_display_text *obj =3D &command->display_text;
+	enum stk_command_parse_result status;
 =

 	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
 		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
@@ -2392,7 +2400,7 @@ static enum stk_command_parse_result parse_display_te=
xt(
 =

 	command->destructor =3D destroy_display_text;
 =

-	return parse_dataobj(iter, STK_DATA_OBJECT_TYPE_TEXT,
+	status =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_TEXT,
 				DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
 				&obj->text,
 				STK_DATA_OBJECT_TYPE_ICON_ID, 0,
@@ -2406,6 +2414,10 @@ static enum stk_command_parse_result parse_display_t=
ext(
 				STK_DATA_OBJECT_TYPE_FRAME_ID, 0,
 				&obj->frame_id,
 				STK_DATA_OBJECT_TYPE_INVALID);
+
+	CHECK_TEXT_AND_ICON(obj->text, obj->icon_id.id);
+
+	return status;
 }
 =

 static void destroy_get_inkey(struct stk_command *command)
@@ -2418,6 +2430,7 @@ static enum stk_command_parse_result parse_get_inkey(
 					struct comprehension_tlv_iter *iter)
 {
 	struct stk_command_get_inkey *obj =3D &command->get_inkey;
+	enum stk_command_parse_result status;
 =

 	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
 		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
@@ -2427,7 +2440,7 @@ static enum stk_command_parse_result parse_get_inkey(
 =

 	command->destructor =3D destroy_get_inkey;
 =

-	return parse_dataobj(iter, STK_DATA_OBJECT_TYPE_TEXT,
+	status =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_TEXT,
 				DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
 				&obj->text,
 				STK_DATA_OBJECT_TYPE_ICON_ID, 0,
@@ -2439,6 +2452,10 @@ static enum stk_command_parse_result parse_get_inkey(
 				STK_DATA_OBJECT_TYPE_FRAME_ID, 0,
 				&obj->frame_id,
 				STK_DATA_OBJECT_TYPE_INVALID);
+
+	CHECK_TEXT_AND_ICON(obj->text, obj->icon_id.id);
+
+	return status;
 }
 =

 static void destroy_get_input(struct stk_command *command)
@@ -2452,6 +2469,7 @@ static enum stk_command_parse_result parse_get_input(
 					struct comprehension_tlv_iter *iter)
 {
 	struct stk_command_get_input *obj =3D &command->get_input;
+	enum stk_command_parse_result status;
 =

 	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
 		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
@@ -2461,7 +2479,7 @@ static enum stk_command_parse_result parse_get_input(
 =

 	command->destructor =3D destroy_get_input;
 =

-	return parse_dataobj(iter, STK_DATA_OBJECT_TYPE_TEXT,
+	status =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_TEXT,
 				DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
 				&obj->text,
 				STK_DATA_OBJECT_TYPE_RESPONSE_LENGTH,
@@ -2476,6 +2494,10 @@ static enum stk_command_parse_result parse_get_input(
 				STK_DATA_OBJECT_TYPE_FRAME_ID, 0,
 				&obj->frame_id,
 				STK_DATA_OBJECT_TYPE_INVALID);
+
+	CHECK_TEXT_AND_ICON(obj->text, obj->icon_id.id);
+
+	return status;
 }
 =

 static enum stk_command_parse_result parse_more_time(
@@ -2501,6 +2523,7 @@ static enum stk_command_parse_result parse_play_tone(
 					struct comprehension_tlv_iter *iter)
 {
 	struct stk_command_play_tone *obj =3D &command->play_tone;
+	enum stk_command_parse_result status;
 =

 	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
 		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
@@ -2510,7 +2533,7 @@ static enum stk_command_parse_result parse_play_tone(
 =

 	command->destructor =3D destroy_play_tone;
 =

-	return parse_dataobj(iter, STK_DATA_OBJECT_TYPE_ALPHA_ID, 0,
+	status =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_ALPHA_ID, 0,
 				&obj->alpha_id,
 				STK_DATA_OBJECT_TYPE_TONE, 0,
 				&obj->tone,
@@ -2523,6 +2546,10 @@ static enum stk_command_parse_result parse_play_tone(
 				STK_DATA_OBJECT_TYPE_FRAME_ID, 0,
 				&obj->frame_id,
 				STK_DATA_OBJECT_TYPE_INVALID);
+
+	CHECK_TEXT_AND_ICON(obj->alpha_id, obj->icon_id.id);
+
+	return status;
 }
 =

 static enum stk_command_parse_result parse_poll_interval(
@@ -2556,6 +2583,7 @@ static enum stk_command_parse_result parse_setup_menu(
 					struct comprehension_tlv_iter *iter)
 {
 	struct stk_command_setup_menu *obj =3D &command->setup_menu;
+	enum stk_command_parse_result status;
 =

 	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
 		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
@@ -2565,7 +2593,7 @@ static enum stk_command_parse_result parse_setup_menu(
 =

 	command->destructor =3D destroy_setup_menu;
 =

-	return parse_dataobj(iter,
+	status =3D parse_dataobj(iter,
 			STK_DATA_OBJECT_TYPE_ALPHA_ID,
 			DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
 			&obj->alpha_id,
@@ -2583,6 +2611,10 @@ static enum stk_command_parse_result parse_setup_men=
u(
 			STK_DATA_OBJECT_TYPE_ITEM_TEXT_ATTRIBUTE_LIST, 0,
 			&obj->item_text_attr_list,
 			STK_DATA_OBJECT_TYPE_INVALID);
+
+	CHECK_TEXT_AND_ICON(obj->alpha_id, obj->icon_id.id);
+
+	return status;
 }
 =

 static void destroy_select_item(struct stk_command *command)
@@ -2633,6 +2665,8 @@ static enum stk_command_parse_result parse_select_ite=
m(
 	if (status =3D=3D STK_PARSE_RESULT_OK && obj->items =3D=3D NULL)
 		status =3D STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
 =

+	CHECK_TEXT_AND_ICON(obj->alpha_id, obj->icon_id.id);
+
 	return status;
 }
 =

@@ -2679,6 +2713,11 @@ static enum stk_command_parse_result parse_send_sms(
 	if (status !=3D STK_PARSE_RESULT_OK)
 		goto out;
 =

+	CHECK_TEXT_AND_ICON(obj->alpha_id, obj->icon_id.id);
+
+	if (status !=3D STK_PARSE_RESULT_OK)
+		goto out;
+
 	if (gsm_tpdu.len =3D=3D 0 && obj->cdma_sms.len =3D=3D 0) {
 		status =3D STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
 		goto out;
@@ -2814,6 +2853,7 @@ static enum stk_command_parse_result parse_setup_call(
 					struct comprehension_tlv_iter *iter)
 {
 	struct stk_command_setup_call *obj =3D &command->setup_call;
+	enum stk_command_parse_result status;
 =

 	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
 		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
@@ -2823,7 +2863,7 @@ static enum stk_command_parse_result parse_setup_call(
 =

 	command->destructor =3D destroy_setup_call;
 =

-	return parse_dataobj(iter, STK_DATA_OBJECT_TYPE_ALPHA_ID, 0,
+	status =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_ALPHA_ID, 0,
 				&obj->alpha_id_usr_cfm,
 				STK_DATA_OBJECT_TYPE_ADDRESS,
 				DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
@@ -2847,6 +2887,11 @@ static enum stk_command_parse_result parse_setup_cal=
l(
 				STK_DATA_OBJECT_TYPE_FRAME_ID, 0,
 				&obj->frame_id,
 				STK_DATA_OBJECT_TYPE_INVALID);
+
+	CHECK_TEXT_AND_ICON(obj->alpha_id_usr_cfm, obj->icon_id_usr_cfm.id);
+	CHECK_TEXT_AND_ICON(obj->alpha_id_call_setup, obj->icon_id_call_setup.id);
+
+	return status;
 }
 =

 static void destroy_refresh(struct stk_command *command)
@@ -2861,6 +2906,7 @@ static enum stk_command_parse_result parse_refresh(
 					struct comprehension_tlv_iter *iter)
 {
 	struct stk_command_refresh *obj =3D &command->refresh;
+	enum stk_command_parse_result status;
 =

 	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
 		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
@@ -2870,7 +2916,7 @@ static enum stk_command_parse_result parse_refresh(
 =

 	command->destructor =3D destroy_refresh;
 =

-	return parse_dataobj(iter, STK_DATA_OBJECT_TYPE_FILE_LIST, 0,
+	status =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_FILE_LIST, 0,
 				&obj->file_list,
 				STK_DATA_OBJECT_TYPE_AID, 0,
 				&obj->aid,
@@ -2883,6 +2929,10 @@ static enum stk_command_parse_result parse_refresh(
 				STK_DATA_OBJECT_TYPE_FRAME_ID, 0,
 				&obj->frame_id,
 				STK_DATA_OBJECT_TYPE_INVALID);
+
+	CHECK_TEXT_AND_ICON(obj->alpha_id, obj->icon_id.id);
+
+	return status;
 }
 =

 static enum stk_command_parse_result parse_polling_off(
@@ -3036,6 +3086,7 @@ static enum stk_command_parse_result parse_setup_idle=
_mode_text(
 {
 	struct stk_command_setup_idle_mode_text *obj =3D
 					&command->setup_idle_mode_text;
+	enum stk_command_parse_result status;
 =

 	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
 		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
@@ -3045,7 +3096,7 @@ static enum stk_command_parse_result parse_setup_idle=
_mode_text(
 =

 	command->destructor =3D destroy_setup_idle_mode_text;
 =

-	return parse_dataobj(iter, STK_DATA_OBJECT_TYPE_TEXT,
+	status =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_TEXT,
 				DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
 				&obj->text,
 				STK_DATA_OBJECT_TYPE_ICON_ID, 0,
@@ -3055,6 +3106,10 @@ static enum stk_command_parse_result parse_setup_idl=
e_mode_text(
 				STK_DATA_OBJECT_TYPE_FRAME_ID, 0,
 				&obj->frame_id,
 				STK_DATA_OBJECT_TYPE_INVALID);
+
+	CHECK_TEXT_AND_ICON(obj->text, obj->icon_id.id);
+
+	return status;
 }
 =

 static void destroy_run_at_command(struct stk_command *command)
@@ -3068,6 +3123,7 @@ static enum stk_command_parse_result parse_run_at_com=
mand(
 					struct comprehension_tlv_iter *iter)
 {
 	struct stk_command_run_at_command *obj =3D &command->run_at_command;
+	enum stk_command_parse_result status;
 =

 	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
 		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
@@ -3077,7 +3133,7 @@ static enum stk_command_parse_result parse_run_at_com=
mand(
 =

 	command->destructor =3D destroy_run_at_command;
 =

-	return parse_dataobj(iter, STK_DATA_OBJECT_TYPE_ALPHA_ID, 0,
+	status =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_ALPHA_ID, 0,
 				&obj->alpha_id,
 				STK_DATA_OBJECT_TYPE_AT_COMMAND,
 				DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
@@ -3089,6 +3145,10 @@ static enum stk_command_parse_result parse_run_at_co=
mmand(
 				STK_DATA_OBJECT_TYPE_FRAME_ID, 0,
 				&obj->frame_id,
 				STK_DATA_OBJECT_TYPE_INVALID);
+
+	CHECK_TEXT_AND_ICON(obj->alpha_id, obj->icon_id.id);
+
+	return status;
 }
 =

 static void destroy_send_dtmf(struct stk_command *command)
@@ -3102,6 +3162,7 @@ static enum stk_command_parse_result parse_send_dtmf(
 					struct comprehension_tlv_iter *iter)
 {
 	struct stk_command_send_dtmf *obj =3D &command->send_dtmf;
+	enum stk_command_parse_result status;
 =

 	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
 		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
@@ -3111,7 +3172,7 @@ static enum stk_command_parse_result parse_send_dtmf(
 =

 	command->destructor =3D destroy_send_dtmf;
 =

-	return parse_dataobj(iter, STK_DATA_OBJECT_TYPE_ALPHA_ID, 0,
+	status =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_ALPHA_ID, 0,
 				&obj->alpha_id,
 				STK_DATA_OBJECT_TYPE_DTMF_STRING,
 				DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
@@ -3123,6 +3184,10 @@ static enum stk_command_parse_result parse_send_dtmf(
 				STK_DATA_OBJECT_TYPE_FRAME_ID, 0,
 				&obj->frame_id,
 				STK_DATA_OBJECT_TYPE_INVALID);
+
+	CHECK_TEXT_AND_ICON(obj->alpha_id, obj->icon_id.id);
+
+	return status;
 }
 =

 static enum stk_command_parse_result parse_language_notification(
@@ -3213,6 +3278,7 @@ static enum stk_command_parse_result parse_close_chan=
nel(
 					struct comprehension_tlv_iter *iter)
 {
 	struct stk_command_close_channel *obj =3D &command->close_channel;
+	enum stk_command_parse_result status;
 =

 	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
 		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
@@ -3222,7 +3288,7 @@ static enum stk_command_parse_result parse_close_chan=
nel(
 =

 	command->destructor =3D destroy_close_channel;
 =

-	return parse_dataobj(iter, STK_DATA_OBJECT_TYPE_ALPHA_ID, 0,
+	status =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_ALPHA_ID, 0,
 				&obj->alpha_id,
 				STK_DATA_OBJECT_TYPE_ICON_ID, 0,
 				&obj->icon_id,
@@ -3231,6 +3297,10 @@ static enum stk_command_parse_result parse_close_cha=
nnel(
 				STK_DATA_OBJECT_TYPE_FRAME_ID, 0,
 				&obj->frame_id,
 				STK_DATA_OBJECT_TYPE_INVALID);
+
+	CHECK_TEXT_AND_ICON(obj->alpha_id, obj->icon_id.id);
+
+	return status;
 }
 =

 static void destroy_receive_data(struct stk_command *command)
@@ -3243,6 +3313,7 @@ static enum stk_command_parse_result parse_receive_da=
ta(
 					struct comprehension_tlv_iter *iter)
 {
 	struct stk_command_receive_data *obj =3D &command->receive_data;
+	enum stk_command_parse_result status;
 =

 	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
 		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
@@ -3253,7 +3324,7 @@ static enum stk_command_parse_result parse_receive_da=
ta(
 =

 	command->destructor =3D destroy_receive_data;
 =

-	return parse_dataobj(iter, STK_DATA_OBJECT_TYPE_ALPHA_ID, 0,
+	status =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_ALPHA_ID, 0,
 				&obj->alpha_id,
 				STK_DATA_OBJECT_TYPE_ICON_ID, 0,
 				&obj->icon_id,
@@ -3265,6 +3336,10 @@ static enum stk_command_parse_result parse_receive_d=
ata(
 				STK_DATA_OBJECT_TYPE_FRAME_ID, 0,
 				&obj->frame_id,
 				STK_DATA_OBJECT_TYPE_INVALID);
+
+	CHECK_TEXT_AND_ICON(obj->alpha_id, obj->icon_id.id);
+
+	return status;
 }
 =

 static void destroy_send_data(struct stk_command *command)
@@ -3278,6 +3353,7 @@ static enum stk_command_parse_result parse_send_data(
 					struct comprehension_tlv_iter *iter)
 {
 	struct stk_command_send_data *obj =3D &command->send_data;
+	enum stk_command_parse_result status;
 =

 	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
 		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
@@ -3288,7 +3364,7 @@ static enum stk_command_parse_result parse_send_data(
 =

 	command->destructor =3D destroy_send_data;
 =

-	return parse_dataobj(iter, STK_DATA_OBJECT_TYPE_ALPHA_ID, 0,
+	status =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_ALPHA_ID, 0,
 				&obj->alpha_id,
 				STK_DATA_OBJECT_TYPE_ICON_ID, 0,
 				&obj->icon_id,
@@ -3300,6 +3376,10 @@ static enum stk_command_parse_result parse_send_data(
 				STK_DATA_OBJECT_TYPE_FRAME_ID, 0,
 				&obj->frame_id,
 				STK_DATA_OBJECT_TYPE_INVALID);
+
+	CHECK_TEXT_AND_ICON(obj->alpha_id, obj->icon_id.id);
+
+	return status;
 }
 =

 static enum stk_command_parse_result parse_get_channel_status(
@@ -3461,6 +3541,7 @@ static enum stk_command_parse_result parse_retrieve_m=
ms(
 					struct comprehension_tlv_iter *iter)
 {
 	struct stk_command_retrieve_mms *obj =3D &command->retrieve_mms;
+	enum stk_command_parse_result status;
 =

 	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
 		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
@@ -3470,7 +3551,7 @@ static enum stk_command_parse_result parse_retrieve_m=
ms(
 =

 	command->destructor =3D destroy_retrieve_mms;
 =

-	return parse_dataobj(iter, STK_DATA_OBJECT_TYPE_ALPHA_ID, 0,
+	status =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_ALPHA_ID, 0,
 				&obj->alpha_id,
 				STK_DATA_OBJECT_TYPE_ICON_ID, 0,
 				&obj->icon_id,
@@ -3490,6 +3571,10 @@ static enum stk_command_parse_result parse_retrieve_=
mms(
 				STK_DATA_OBJECT_TYPE_FRAME_ID, 0,
 				&obj->frame_id,
 				STK_DATA_OBJECT_TYPE_INVALID);
+
+	CHECK_TEXT_AND_ICON(obj->alpha_id, obj->icon_id.id);
+
+	return status;
 }
 =

 static void destroy_submit_mms(struct stk_command *command)
@@ -3505,6 +3590,7 @@ static enum stk_command_parse_result parse_submit_mms(
 					struct comprehension_tlv_iter *iter)
 {
 	struct stk_command_submit_mms *obj =3D &command->submit_mms;
+	enum stk_command_parse_result status;
 =

 	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
 		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
@@ -3514,7 +3600,7 @@ static enum stk_command_parse_result parse_submit_mms(
 =

 	command->destructor =3D destroy_submit_mms;
 =

-	return parse_dataobj(iter, STK_DATA_OBJECT_TYPE_ALPHA_ID, 0,
+	status =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_ALPHA_ID, 0,
 				&obj->alpha_id,
 				STK_DATA_OBJECT_TYPE_ICON_ID, 0,
 				&obj->icon_id,
@@ -3528,6 +3614,10 @@ static enum stk_command_parse_result parse_submit_mm=
s(
 				STK_DATA_OBJECT_TYPE_FRAME_ID, 0,
 				&obj->frame_id,
 				STK_DATA_OBJECT_TYPE_INVALID);
+
+	CHECK_TEXT_AND_ICON(obj->alpha_id, obj->icon_id.id);
+
+	return status;
 }
 =

 static void destroy_display_mms(struct stk_command *command)
-- =

1.7.0.4


--===============0894468070891912420==--

