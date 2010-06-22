Content-Type: multipart/mixed; boundary="===============0017879515850537023=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/8] stkutil: Refactor command parser error handling
Date: Tue, 22 Jun 2010 13:20:44 +0200
Message-ID: <1277205651-29369-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0017879515850537023==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When parsing the full command fails but Command Details has been parsed,
return a struct stk_command containing this information and the type of
parsing problem found.  We need the command details to be able to
even respond to the command.

This patch also makes the parser skip over unknown data objects found
in the BER-TLV, if they don't have Comprehension Required set.
---
 src/stkutil.c       |  955 +++++++++++++++++++++--------------------------=
----
 src/stkutil.h       |    8 +
 unit/test-stkutil.c |   40 ++-
 3 files changed, 446 insertions(+), 557 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 6520c8a..c5eca3f 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -2283,16 +2283,17 @@ struct dataobj_handler_entry {
 	enum stk_data_object_type type;
 	int flags;
 	void *data;
-	gboolean parsed;
 };
 =

-static gboolean parse_dataobj(struct comprehension_tlv_iter *iter,
-				enum stk_data_object_type type, ...)
+static enum stk_command_parse_result parse_dataobj(
+					struct comprehension_tlv_iter *iter,
+					enum stk_data_object_type type, ...)
 {
 	GSList *entries =3D NULL;
 	GSList *l;
 	va_list args;
 	gboolean minimum_set =3D TRUE;
+	gboolean parse_error =3D FALSE;
 =

 	va_start(args, type);
 =

@@ -2309,45 +2310,61 @@ static gboolean parse_dataobj(struct comprehension_=
tlv_iter *iter,
 		entries =3D g_slist_prepend(entries, entry);
 	}
 =

-	if (comprehension_tlv_iter_next(iter) !=3D TRUE)
-		goto out;
-
 	entries =3D g_slist_reverse(entries);
 =

-	for (l =3D entries; l; l =3D l->next) {
+	l =3D entries;
+	while (comprehension_tlv_iter_next(iter) =3D=3D TRUE) {
 		dataobj_handler handler;
-		struct dataobj_handler_entry *entry =3D l->data;
+		struct dataobj_handler_entry *entry;
+		GSList *l2;
+
+		for (l2 =3D l; l2; l2 =3D l2->next) {
+			entry =3D l2->data;
+
+			if (comprehension_tlv_iter_get_tag(iter) =3D=3D entry->type)
+				break;
+
+			/* Can't skip over Minimum objects */
+			if (entry->flags & DATAOBJ_FLAG_MINIMUM) {
+				l2 =3D NULL;
+				break;
+			}
+		}
+
+		if (!l2) {
+			if (comprehension_tlv_get_cr(iter) =3D=3D TRUE)
+				parse_error =3D TRUE;
+
+			continue;
+		}
 =

 		if (entry->flags & DATAOBJ_FLAG_LIST)
 			handler =3D list_handler_for_type(entry->type);
 		else
 			handler =3D handler_for_type(entry->type);
 =

-		if (handler =3D=3D NULL)
-			continue;
+		if (handler(iter, entry->data) =3D=3D FALSE)
+			parse_error =3D TRUE;
 =

-		if (comprehension_tlv_iter_get_tag(iter) =3D=3D entry->type) {
-			if (handler(iter, entry->data))
-				entry->parsed =3D TRUE;
-
-			if (comprehension_tlv_iter_next(iter) =3D=3D FALSE)
-				break;
-		}
+		l =3D l2->next;
 	}
 =

-out:
-	for (l =3D entries; l; l =3D l->next) {
+	for (; l; l =3D l->next) {
 		struct dataobj_handler_entry *entry =3D l->data;
 =

-		if ((entry->flags & DATAOBJ_FLAG_MINIMUM) &&
-				entry->parsed =3D=3D FALSE)
+		if (entry->flags & DATAOBJ_FLAG_MINIMUM)
 			minimum_set =3D FALSE;
 	}
 =

 	g_slist_foreach(entries, (GFunc)g_free, NULL);
 	g_slist_free(entries);
 =

-	return minimum_set;
+	if (minimum_set =3D=3D FALSE)
+		return STK_PARSE_RESULT_MISSING_VALUE;
+	if (parse_error =3D=3D TRUE)
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
+
+	return STK_PARSE_RESULT_OK;
 }
 =

 static void destroy_display_text(struct stk_command *command)
@@ -2355,19 +2372,21 @@ static void destroy_display_text(struct stk_command=
 *command)
 	g_free(command->display_text.text);
 }
 =

-static gboolean parse_display_text(struct stk_command *command,
+static enum stk_command_parse_result parse_display_text(
+					struct stk_command *command,
 					struct comprehension_tlv_iter *iter)
 {
 	struct stk_command_display_text *obj =3D &command->display_text;
-	gboolean ret;
 =

 	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
-		return FALSE;
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
 =

 	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_DISPLAY)
-		return FALSE;
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
+
+	command->destructor =3D destroy_display_text;
 =

-	ret =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_TEXT,
+	return parse_dataobj(iter, STK_DATA_OBJECT_TYPE_TEXT,
 				DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
 				&obj->text,
 				STK_DATA_OBJECT_TYPE_ICON_ID, 0,
@@ -2381,13 +2400,6 @@ static gboolean parse_display_text(struct stk_comman=
d *command,
 				STK_DATA_OBJECT_TYPE_FRAME_ID, 0,
 				&obj->frame_id,
 				STK_DATA_OBJECT_TYPE_INVALID);
-
-	command->destructor =3D destroy_display_text;
-
-	if (ret =3D=3D FALSE)
-		return FALSE;
-
-	return TRUE;
 }
 =

 static void destroy_get_inkey(struct stk_command *command)
@@ -2395,19 +2407,21 @@ static void destroy_get_inkey(struct stk_command *c=
ommand)
 	g_free(command->get_inkey.text);
 }
 =

-static gboolean parse_get_inkey(struct stk_command *command,
-				struct comprehension_tlv_iter *iter)
+static enum stk_command_parse_result parse_get_inkey(
+					struct stk_command *command,
+					struct comprehension_tlv_iter *iter)
 {
 	struct stk_command_get_inkey *obj =3D &command->get_inkey;
-	gboolean ret;
 =

 	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
-		return FALSE;
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
 =

 	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_TERMINAL)
-		return FALSE;
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
+
+	command->destructor =3D destroy_get_inkey;
 =

-	ret =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_TEXT,
+	return parse_dataobj(iter, STK_DATA_OBJECT_TYPE_TEXT,
 				DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
 				&obj->text,
 				STK_DATA_OBJECT_TYPE_ICON_ID, 0,
@@ -2419,13 +2433,6 @@ static gboolean parse_get_inkey(struct stk_command *=
command,
 				STK_DATA_OBJECT_TYPE_FRAME_ID, 0,
 				&obj->frame_id,
 				STK_DATA_OBJECT_TYPE_INVALID);
-
-	command->destructor =3D destroy_get_inkey;
-
-	if (ret =3D=3D FALSE)
-		return FALSE;
-
-	return TRUE;
 }
 =

 static void destroy_get_input(struct stk_command *command)
@@ -2434,19 +2441,21 @@ static void destroy_get_input(struct stk_command *c=
ommand)
 	g_free(command->get_input.default_text);
 }
 =

-static gboolean parse_get_input(struct stk_command *command,
+static enum stk_command_parse_result parse_get_input(
+					struct stk_command *command,
 					struct comprehension_tlv_iter *iter)
 {
 	struct stk_command_get_input *obj =3D &command->get_input;
-	gboolean ret;
 =

 	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
-		return FALSE;
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
 =

 	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_TERMINAL)
-		return FALSE;
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
+
+	command->destructor =3D destroy_get_input;
 =

-	ret =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_TEXT,
+	return parse_dataobj(iter, STK_DATA_OBJECT_TYPE_TEXT,
 				DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
 				&obj->text,
 				STK_DATA_OBJECT_TYPE_RESPONSE_LENGTH,
@@ -2461,25 +2470,19 @@ static gboolean parse_get_input(struct stk_command =
*command,
 				STK_DATA_OBJECT_TYPE_FRAME_ID, 0,
 				&obj->frame_id,
 				STK_DATA_OBJECT_TYPE_INVALID);
-
-	command->destructor =3D destroy_get_input;
-
-	if (ret =3D=3D FALSE)
-		return FALSE;
-
-	return TRUE;
 }
 =

-static gboolean parse_more_time(struct stk_command *command,
+static enum stk_command_parse_result parse_more_time(
+					struct stk_command *command,
 					struct comprehension_tlv_iter *iter)
 {
 	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
-		return FALSE;
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
 =

 	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_TERMINAL)
-		return FALSE;
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
 =

-	return TRUE;
+	return STK_PARSE_RESULT_OK;
 }
 =

 static void destroy_play_tone(struct stk_command *command)
@@ -2487,19 +2490,21 @@ static void destroy_play_tone(struct stk_command *c=
ommand)
 	g_free(command->play_tone.alpha_id);
 }
 =

-static gboolean parse_play_tone(struct stk_command *command,
+static enum stk_command_parse_result parse_play_tone(
+					struct stk_command *command,
 					struct comprehension_tlv_iter *iter)
 {
 	struct stk_command_play_tone *obj =3D &command->play_tone;
-	gboolean ret;
 =

 	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
-		return FALSE;
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
 =

 	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_EARPIECE)
-		return FALSE;
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
 =

-	ret =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_ALPHA_ID, 0,
+	command->destructor =3D destroy_play_tone;
+
+	return parse_dataobj(iter, STK_DATA_OBJECT_TYPE_ALPHA_ID, 0,
 				&obj->alpha_id,
 				STK_DATA_OBJECT_TYPE_TONE, 0,
 				&obj->tone,
@@ -2512,36 +2517,24 @@ static gboolean parse_play_tone(struct stk_command =
*command,
 				STK_DATA_OBJECT_TYPE_FRAME_ID, 0,
 				&obj->frame_id,
 				STK_DATA_OBJECT_TYPE_INVALID);
-
-	command->destructor =3D destroy_play_tone;
-
-	if (ret =3D=3D FALSE)
-		return FALSE;
-
-	return TRUE;
 }
 =

-static gboolean parse_poll_interval(struct stk_command *command,
+static enum stk_command_parse_result parse_poll_interval(
+					struct stk_command *command,
 					struct comprehension_tlv_iter *iter)
 {
 	struct stk_command_poll_interval *obj =3D &command->poll_interval;
-	gboolean ret;
 =

 	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
-		return FALSE;
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
 =

 	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_TERMINAL)
-		return FALSE;
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
 =

-	ret =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_DURATION,
+	return parse_dataobj(iter, STK_DATA_OBJECT_TYPE_DURATION,
 				DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
 				&obj->duration,
 				STK_DATA_OBJECT_TYPE_INVALID);
-
-	if (ret =3D=3D FALSE)
-		return FALSE;
-
-	return TRUE;
 }
 =

 static void destroy_setup_menu(struct stk_command *command)
@@ -2552,21 +2545,21 @@ static void destroy_setup_menu(struct stk_command *=
command)
 	g_slist_free(command->setup_menu.items);
 }
 =

-static gboolean parse_setup_menu(struct stk_command *command,
+static enum stk_command_parse_result parse_setup_menu(
+					struct stk_command *command,
 					struct comprehension_tlv_iter *iter)
 {
 	struct stk_command_setup_menu *obj =3D &command->setup_menu;
-	gboolean ret;
 =

 	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
-		return FALSE;
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
 =

 	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_TERMINAL)
-		return FALSE;
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
 =

 	command->destructor =3D destroy_setup_menu;
 =

-	ret =3D parse_dataobj(iter,
+	return parse_dataobj(iter,
 			STK_DATA_OBJECT_TYPE_ALPHA_ID,
 			DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
 			&obj->alpha_id,
@@ -2584,11 +2577,6 @@ static gboolean parse_setup_menu(struct stk_command =
*command,
 			STK_DATA_OBJECT_TYPE_ITEM_TEXT_ATTRIBUTE_LIST, 0,
 			&obj->item_text_attr_list,
 			STK_DATA_OBJECT_TYPE_INVALID);
-
-	if (ret =3D=3D FALSE)
-		return FALSE;
-
-	return TRUE;
 }
 =

 static void destroy_select_item(struct stk_command *command)
@@ -2599,21 +2587,20 @@ static void destroy_select_item(struct stk_command =
*command)
 	g_slist_free(command->select_item.items);
 }
 =

-static gboolean parse_select_item(struct stk_command *command,
+static enum stk_command_parse_result parse_select_item(
+					struct stk_command *command,
 					struct comprehension_tlv_iter *iter)
 {
 	struct stk_command_select_item *obj =3D &command->select_item;
-	gboolean ret;
+	enum stk_command_parse_result status;
 =

 	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
-		return FALSE;
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
 =

 	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_TERMINAL)
-		return FALSE;
-
-	command->destructor =3D destroy_select_item;
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
 =

-	ret =3D parse_dataobj(iter,
+	status =3D parse_dataobj(iter,
 			STK_DATA_OBJECT_TYPE_ALPHA_ID,
 			DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
 			&obj->alpha_id,
@@ -2636,13 +2623,12 @@ static gboolean parse_select_item(struct stk_comman=
d *command,
 			&obj->frame_id,
 			STK_DATA_OBJECT_TYPE_INVALID);
 =

-	if (ret =3D=3D FALSE)
-		return FALSE;
+	command->destructor =3D destroy_select_item;
 =

-	if (obj->items =3D=3D NULL)
-		return FALSE;
+	if (status =3D=3D STK_PARSE_RESULT_OK && obj->items =3D=3D NULL)
+		status =3D STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
 =

-	return TRUE;
+	return status;
 }
 =

 static void destroy_send_sms(struct stk_command *command)
@@ -2652,21 +2638,22 @@ static void destroy_send_sms(struct stk_command *co=
mmand)
 	g_free(command->send_sms.cdma_sms.array);
 }
 =

-static gboolean parse_send_sms(struct stk_command *command,
+static enum stk_command_parse_result parse_send_sms(
+					struct stk_command *command,
 					struct comprehension_tlv_iter *iter)
 {
 	struct stk_command_send_sms *obj =3D &command->send_sms;
+	enum stk_command_parse_result status;
 	struct gsm_sms_tpdu gsm_tpdu;
-	gboolean ret;
 =

 	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
-		return FALSE;
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
 =

 	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_NETWORK)
-		return FALSE;
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
 =

 	memset(&gsm_tpdu, 0, sizeof(gsm_tpdu));
-	ret =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_ALPHA_ID, 0,
+	status =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_ALPHA_ID, 0,
 				&obj->alpha_id,
 				STK_DATA_OBJECT_TYPE_ADDRESS, 0,
 				&obj->address,
@@ -2684,33 +2671,36 @@ static gboolean parse_send_sms(struct stk_command *=
command,
 =

 	command->destructor =3D destroy_send_sms;
 =

-	if (ret =3D=3D FALSE)
-		return FALSE;
+	if (status !=3D STK_PARSE_RESULT_OK)
+		return status;
 =

 	if (gsm_tpdu.len =3D=3D 0 && obj->cdma_sms.len =3D=3D 0)
-		return FALSE;
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
 =

 	if (gsm_tpdu.len > 0 && obj->cdma_sms.len > 0)
-		return FALSE;
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
 =

 	/* We don't process CDMA pdus for now */
 	if (obj->cdma_sms.len > 0)
-		return TRUE;
+		return STK_PARSE_RESULT_OK;
 =

 	/* packing is needed */
-	if (command->qualifier & 0x01)
-		return sms_decode_unpacked_stk_pdu(gsm_tpdu.tpdu, gsm_tpdu.len,
-							&obj->gsm_sms);
+	if (command->qualifier & 0x01) {
+		if (sms_decode_unpacked_stk_pdu(gsm_tpdu.tpdu, gsm_tpdu.len,
+							&obj->gsm_sms) !=3D TRUE)
+			status =3D STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
+		return status;
+	}
 =

 	if (sms_decode(gsm_tpdu.tpdu, gsm_tpdu.len, TRUE,
 				gsm_tpdu.len, &obj->gsm_sms) =3D=3D FALSE)
-		return FALSE;
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
 =

 	if (obj->gsm_sms.type !=3D SMS_TYPE_SUBMIT &&
 			obj->gsm_sms.type !=3D SMS_TYPE_COMMAND)
-		return FALSE;
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
 =

-	return TRUE;
+	return STK_PARSE_RESULT_OK;
 }
 =

 static void destroy_send_ss(struct stk_command *command)
@@ -2719,19 +2709,20 @@ static void destroy_send_ss(struct stk_command *com=
mand)
 	g_free(command->send_ss.ss.ss);
 }
 =

-static gboolean parse_send_ss(struct stk_command *command,
+static enum stk_command_parse_result parse_send_ss(struct stk_command *com=
mand,
 					struct comprehension_tlv_iter *iter)
 {
 	struct stk_command_send_ss *obj =3D &command->send_ss;
-	gboolean ret;
 =

 	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
-		return FALSE;
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
 =

 	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_NETWORK)
-		return FALSE;
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
+
+	command->destructor =3D destroy_send_ss;
 =

-	ret =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_ALPHA_ID, 0,
+	return parse_dataobj(iter, STK_DATA_OBJECT_TYPE_ALPHA_ID, 0,
 				&obj->alpha_id,
 				STK_DATA_OBJECT_TYPE_SS_STRING,
 				DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
@@ -2743,13 +2734,6 @@ static gboolean parse_send_ss(struct stk_command *co=
mmand,
 				STK_DATA_OBJECT_TYPE_FRAME_ID, 0,
 				&obj->frame_id,
 				STK_DATA_OBJECT_TYPE_INVALID);
-
-	command->destructor =3D destroy_send_ss;
-
-	if (ret =3D=3D FALSE)
-		return FALSE;
-
-	return TRUE;
 }
 =

 static void destroy_send_ussd(struct stk_command *command)
@@ -2757,19 +2741,21 @@ static void destroy_send_ussd(struct stk_command *c=
ommand)
 	g_free(command->send_ussd.alpha_id);
 }
 =

-static gboolean parse_send_ussd(struct stk_command *command,
+static enum stk_command_parse_result parse_send_ussd(
+					struct stk_command *command,
 					struct comprehension_tlv_iter *iter)
 {
 	struct stk_command_send_ussd *obj =3D &command->send_ussd;
-	gboolean ret;
 =

 	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
-		return FALSE;
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
 =

 	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_NETWORK)
-		return FALSE;
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
+
+	command->destructor =3D destroy_send_ussd;
 =

-	ret =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_ALPHA_ID, 0,
+	return parse_dataobj(iter, STK_DATA_OBJECT_TYPE_ALPHA_ID, 0,
 				&obj->alpha_id,
 				STK_DATA_OBJECT_TYPE_USSD_STRING,
 				DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
@@ -2781,13 +2767,6 @@ static gboolean parse_send_ussd(struct stk_command *=
command,
 				STK_DATA_OBJECT_TYPE_FRAME_ID, 0,
 				&obj->frame_id,
 				STK_DATA_OBJECT_TYPE_INVALID);
-
-	command->destructor =3D destroy_send_ussd;
-
-	if (ret =3D=3D FALSE)
-		return FALSE;
-
-	return TRUE;
 }
 =

 static void destroy_setup_call(struct stk_command *command)
@@ -2797,19 +2776,21 @@ static void destroy_setup_call(struct stk_command *=
command)
 	g_free(command->setup_call.alpha_id_call_setup);
 }
 =

-static gboolean parse_setup_call(struct stk_command *command,
+static enum stk_command_parse_result parse_setup_call(
+					struct stk_command *command,
 					struct comprehension_tlv_iter *iter)
 {
 	struct stk_command_setup_call *obj =3D &command->setup_call;
-	gboolean ret;
 =

 	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
-		return FALSE;
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
 =

 	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_NETWORK)
-		return FALSE;
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
+
+	command->destructor =3D destroy_setup_call;
 =

-	ret =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_ALPHA_ID, 0,
+	return parse_dataobj(iter, STK_DATA_OBJECT_TYPE_ALPHA_ID, 0,
 				&obj->alpha_id_usr_cfm,
 				STK_DATA_OBJECT_TYPE_ADDRESS,
 				DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
@@ -2833,13 +2814,6 @@ static gboolean parse_setup_call(struct stk_command =
*command,
 				STK_DATA_OBJECT_TYPE_FRAME_ID, 0,
 				&obj->frame_id,
 				STK_DATA_OBJECT_TYPE_INVALID);
-
-	command->destructor =3D destroy_setup_call;
-
-	if (ret =3D=3D FALSE)
-		return FALSE;
-
-	return TRUE;
 }
 =

 static void destroy_refresh(struct stk_command *command)
@@ -2849,19 +2823,21 @@ static void destroy_refresh(struct stk_command *com=
mand)
 	g_free(command->refresh.alpha_id);
 }
 =

-static gboolean parse_refresh(struct stk_command *command,
+static enum stk_command_parse_result parse_refresh(
+					struct stk_command *command,
 					struct comprehension_tlv_iter *iter)
 {
 	struct stk_command_refresh *obj =3D &command->refresh;
-	gboolean ret;
 =

 	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
-		return FALSE;
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
 =

 	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_TERMINAL)
-		return FALSE;
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
 =

-	ret =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_FILE_LIST, 0,
+	command->destructor =3D destroy_refresh;
+
+	return parse_dataobj(iter, STK_DATA_OBJECT_TYPE_FILE_LIST, 0,
 				&obj->file_list,
 				STK_DATA_OBJECT_TYPE_AID, 0,
 				&obj->aid,
@@ -2874,159 +2850,142 @@ static gboolean parse_refresh(struct stk_command =
*command,
 				STK_DATA_OBJECT_TYPE_FRAME_ID, 0,
 				&obj->frame_id,
 				STK_DATA_OBJECT_TYPE_INVALID);
-
-	command->destructor =3D destroy_refresh;
-
-	if (ret =3D=3D FALSE)
-		return FALSE;
-
-	return TRUE;
 }
 =

-static gboolean parse_polling_off(struct stk_command *command,
+static enum stk_command_parse_result parse_polling_off(
+					struct stk_command *command,
 					struct comprehension_tlv_iter *iter)
 {
 	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
-		return FALSE;
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
 =

 	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_TERMINAL)
-		return FALSE;
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
 =

-	return TRUE;
+	return STK_PARSE_RESULT_OK;
 }
 =

-static gboolean parse_provide_local_info(struct stk_command *command,
+static enum stk_command_parse_result parse_provide_local_info(
+					struct stk_command *command,
 					struct comprehension_tlv_iter *iter)
 {
 	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
-		return FALSE;
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
 =

 	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_TERMINAL)
-		return FALSE;
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
 =

-	return TRUE;
+	return STK_PARSE_RESULT_OK;
 }
 =

-static gboolean parse_setup_event_list(struct stk_command *command,
+static enum stk_command_parse_result parse_setup_event_list(
+					struct stk_command *command,
 					struct comprehension_tlv_iter *iter)
 {
 	struct stk_command_setup_event_list *obj =3D &command->setup_event_list;
-	gboolean ret;
 =

 	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
-		return FALSE;
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
 =

 	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_TERMINAL)
-		return FALSE;
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
 =

-	ret =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_EVENT_LIST,
+	return parse_dataobj(iter, STK_DATA_OBJECT_TYPE_EVENT_LIST,
 				DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
 				&obj->event_list,
 				STK_DATA_OBJECT_TYPE_INVALID);
-
-	if (ret =3D=3D FALSE)
-		return FALSE;
-
-	return TRUE;
 }
 =

-static gboolean parse_perform_card_apdu(struct stk_command *command,
+static enum stk_command_parse_result parse_perform_card_apdu(
+					struct stk_command *command,
 					struct comprehension_tlv_iter *iter)
 {
 	struct stk_command_perform_card_apdu *obj =3D &command->perform_card_apdu;
-	gboolean ret;
 =

 	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
-		return FALSE;
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
 =

 	if ((command->dst < STK_DEVICE_IDENTITY_TYPE_CARD_READER_0) ||
 			(command->dst > STK_DEVICE_IDENTITY_TYPE_CARD_READER_7))
-		return FALSE;
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
 =

-	ret =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_C_APDU,
+	return parse_dataobj(iter, STK_DATA_OBJECT_TYPE_C_APDU,
 				DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
 				&obj->c_apdu,
 				STK_DATA_OBJECT_TYPE_INVALID);
-
-	if (ret =3D=3D FALSE)
-		return FALSE;
-
-	return TRUE;
 }
 =

-static gboolean parse_power_off_card(struct stk_command *command,
+static enum stk_command_parse_result parse_power_off_card(
+					struct stk_command *command,
 					struct comprehension_tlv_iter *iter)
 {
 	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
-		return FALSE;
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
 =

 	if ((command->dst < STK_DEVICE_IDENTITY_TYPE_CARD_READER_0) ||
 			(command->dst > STK_DEVICE_IDENTITY_TYPE_CARD_READER_7))
-		return FALSE;
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
 =

-	return TRUE;
+	return STK_PARSE_RESULT_OK;
 }
 =

-static gboolean parse_power_on_card(struct stk_command *command,
+static enum stk_command_parse_result parse_power_on_card(
+					struct stk_command *command,
 					struct comprehension_tlv_iter *iter)
 {
 	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
-		return FALSE;
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
 =

 	if ((command->dst < STK_DEVICE_IDENTITY_TYPE_CARD_READER_0) ||
 			(command->dst > STK_DEVICE_IDENTITY_TYPE_CARD_READER_7))
-		return FALSE;
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
 =

-	return TRUE;
+	return STK_PARSE_RESULT_OK;
 }
 =

-static gboolean parse_get_reader_status(struct stk_command *command,
+static enum stk_command_parse_result parse_get_reader_status(
+					struct stk_command *command,
 					struct comprehension_tlv_iter *iter)
 {
 	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
-		return FALSE;
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
 =

 	switch (command->qualifier) {
 	case STK_QUALIFIER_TYPE_CARD_READER_STATUS:
 		if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_TERMINAL)
-			return FALSE;
+			return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
 		break;
 	case STK_QUALIFIER_TYPE_CARD_READER_ID:
 		if ((command->dst < STK_DEVICE_IDENTITY_TYPE_CARD_READER_0) ||
 				(command->dst >
 					STK_DEVICE_IDENTITY_TYPE_CARD_READER_7))
-			return FALSE;
+			return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
 		break;
 	default:
-		return FALSE;
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
 	}
 =

-	return TRUE;
+	return STK_PARSE_RESULT_OK;
 }
 =

-static gboolean parse_timer_mgmt(struct stk_command *command,
+static enum stk_command_parse_result parse_timer_mgmt(
+					struct stk_command *command,
 					struct comprehension_tlv_iter *iter)
 {
 	struct stk_command_timer_mgmt *obj =3D &command->timer_mgmt;
-	gboolean ret;
 =

 	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
-		return FALSE;
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
 =

 	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_TERMINAL)
-		return FALSE;
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
 =

-	ret =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_TIMER_ID,
+	return parse_dataobj(iter, STK_DATA_OBJECT_TYPE_TIMER_ID,
 				DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
 				&obj->timer_id,
 				STK_DATA_OBJECT_TYPE_TIMER_VALUE, 0,
 				&obj->timer_value,
 				STK_DATA_OBJECT_TYPE_INVALID);
-
-	if (ret =3D=3D FALSE)
-		return FALSE;
-
-	return TRUE;
 }
 =

 static void destroy_setup_idle_mode_text(struct stk_command *command)
@@ -3034,20 +2993,22 @@ static void destroy_setup_idle_mode_text(struct stk=
_command *command)
 	g_free(command->setup_idle_mode_text.text);
 }
 =

-static gboolean parse_setup_idle_mode_text(struct stk_command *command,
+static enum stk_command_parse_result parse_setup_idle_mode_text(
+					struct stk_command *command,
 					struct comprehension_tlv_iter *iter)
 {
 	struct stk_command_setup_idle_mode_text *obj =3D
 					&command->setup_idle_mode_text;
-	gboolean ret;
 =

 	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
-		return FALSE;
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
 =

 	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_TERMINAL)
-		return FALSE;
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
+
+	command->destructor =3D destroy_setup_idle_mode_text;
 =

-	ret =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_TEXT,
+	return parse_dataobj(iter, STK_DATA_OBJECT_TYPE_TEXT,
 				DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
 				&obj->text,
 				STK_DATA_OBJECT_TYPE_ICON_ID, 0,
@@ -3057,13 +3018,6 @@ static gboolean parse_setup_idle_mode_text(struct st=
k_command *command,
 				STK_DATA_OBJECT_TYPE_FRAME_ID, 0,
 				&obj->frame_id,
 				STK_DATA_OBJECT_TYPE_INVALID);
-
-	command->destructor =3D destroy_setup_idle_mode_text;
-
-	if (ret =3D=3D FALSE)
-		return FALSE;
-
-	return TRUE;
 }
 =

 static void destroy_run_at_command(struct stk_command *command)
@@ -3072,19 +3026,21 @@ static void destroy_run_at_command(struct stk_comma=
nd *command)
 	g_free(command->run_at_command.at_command);
 }
 =

-static gboolean parse_run_at_command(struct stk_command *command,
+static enum stk_command_parse_result parse_run_at_command(
+					struct stk_command *command,
 					struct comprehension_tlv_iter *iter)
 {
 	struct stk_command_run_at_command *obj =3D &command->run_at_command;
-	gboolean ret;
 =

 	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
-		return FALSE;
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
 =

 	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_TERMINAL)
-		return FALSE;
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
+
+	command->destructor =3D destroy_run_at_command;
 =

-	ret =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_ALPHA_ID, 0,
+	return parse_dataobj(iter, STK_DATA_OBJECT_TYPE_ALPHA_ID, 0,
 				&obj->alpha_id,
 				STK_DATA_OBJECT_TYPE_AT_COMMAND,
 				DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
@@ -3096,13 +3052,6 @@ static gboolean parse_run_at_command(struct stk_comm=
and *command,
 				STK_DATA_OBJECT_TYPE_FRAME_ID, 0,
 				&obj->frame_id,
 				STK_DATA_OBJECT_TYPE_INVALID);
-
-	command->destructor =3D destroy_run_at_command;
-
-	if (ret =3D=3D FALSE)
-		return FALSE;
-
-	return TRUE;
 }
 =

 static void destroy_send_dtmf(struct stk_command *command)
@@ -3111,19 +3060,21 @@ static void destroy_send_dtmf(struct stk_command *c=
ommand)
 	g_free(command->send_dtmf.dtmf);
 }
 =

-static gboolean parse_send_dtmf(struct stk_command *command,
+static enum stk_command_parse_result parse_send_dtmf(
+					struct stk_command *command,
 					struct comprehension_tlv_iter *iter)
 {
 	struct stk_command_send_dtmf *obj =3D &command->send_dtmf;
-	gboolean ret;
 =

 	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
-		return FALSE;
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
 =

 	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_NETWORK)
-		return FALSE;
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
+
+	command->destructor =3D destroy_send_dtmf;
 =

-	ret =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_ALPHA_ID, 0,
+	return parse_dataobj(iter, STK_DATA_OBJECT_TYPE_ALPHA_ID, 0,
 				&obj->alpha_id,
 				STK_DATA_OBJECT_TYPE_DTMF_STRING,
 				DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
@@ -3135,36 +3086,24 @@ static gboolean parse_send_dtmf(struct stk_command =
*command,
 				STK_DATA_OBJECT_TYPE_FRAME_ID, 0,
 				&obj->frame_id,
 				STK_DATA_OBJECT_TYPE_INVALID);
-
-	command->destructor =3D destroy_send_dtmf;
-
-	if (ret =3D=3D FALSE)
-		return FALSE;
-
-	return TRUE;
 }
 =

-static gboolean parse_language_notification(struct stk_command *command,
+static enum stk_command_parse_result parse_language_notification(
+					struct stk_command *command,
 					struct comprehension_tlv_iter *iter)
 {
 	struct stk_command_language_notification *obj =3D
 					&command->language_notification;
-	gboolean ret;
 =

 	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
-		return FALSE;
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
 =

 	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_TERMINAL)
-		return FALSE;
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
 =

-	ret =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_LANGUAGE, 0,
+	return parse_dataobj(iter, STK_DATA_OBJECT_TYPE_LANGUAGE, 0,
 				&obj->language,
 				STK_DATA_OBJECT_TYPE_INVALID);
-
-	if (ret =3D=3D FALSE)
-		return FALSE;
-
-	return TRUE;
 }
 =

 static void destroy_launch_browser(struct stk_command *command)
@@ -3181,19 +3120,21 @@ static void destroy_launch_browser(struct stk_comma=
nd *command)
 	g_free(command->launch_browser.text_passwd);
 }
 =

-static gboolean parse_launch_browser(struct stk_command *command,
+static enum stk_command_parse_result parse_launch_browser(
+					struct stk_command *command,
 					struct comprehension_tlv_iter *iter)
 {
 	struct stk_command_launch_browser *obj =3D &command->launch_browser;
-	gboolean ret;
 =

 	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
-		return FALSE;
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
 =

 	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_TERMINAL)
-		return FALSE;
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
 =

-	ret =3D parse_dataobj(iter,
+	command->destructor =3D destroy_launch_browser;
+
+	return parse_dataobj(iter,
 				STK_DATA_OBJECT_TYPE_BROWSER_ID, 0,
 				&obj->browser_id,
 				STK_DATA_OBJECT_TYPE_URL,
@@ -3221,13 +3162,6 @@ static gboolean parse_launch_browser(struct stk_comm=
and *command,
 				STK_DATA_OBJECT_TYPE_TEXT, 0,
 				&obj->text_passwd,
 				STK_DATA_OBJECT_TYPE_INVALID);
-
-	command->destructor =3D destroy_launch_browser;
-
-	if (ret =3D=3D FALSE)
-		return FALSE;
-
-	return TRUE;
 }
 =

 /* TODO: parse_open_channel */
@@ -3237,19 +3171,21 @@ static void destroy_close_channel(struct stk_comman=
d *command)
 	g_free(command->close_channel.alpha_id);
 }
 =

-static gboolean parse_close_channel(struct stk_command *command,
+static enum stk_command_parse_result parse_close_channel(
+					struct stk_command *command,
 					struct comprehension_tlv_iter *iter)
 {
 	struct stk_command_close_channel *obj =3D &command->close_channel;
-	gboolean ret;
 =

 	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
-		return FALSE;
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
 =

 	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_TERMINAL)
-		return FALSE;
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
 =

-	ret =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_ALPHA_ID, 0,
+	command->destructor =3D destroy_close_channel;
+
+	return parse_dataobj(iter, STK_DATA_OBJECT_TYPE_ALPHA_ID, 0,
 				&obj->alpha_id,
 				STK_DATA_OBJECT_TYPE_ICON_ID, 0,
 				&obj->icon_id,
@@ -3258,13 +3194,6 @@ static gboolean parse_close_channel(struct stk_comma=
nd *command,
 				STK_DATA_OBJECT_TYPE_FRAME_ID, 0,
 				&obj->frame_id,
 				STK_DATA_OBJECT_TYPE_INVALID);
-
-	command->destructor =3D destroy_close_channel;
-
-	if (ret =3D=3D FALSE)
-		return FALSE;
-
-	return TRUE;
 }
 =

 static void destroy_receive_data(struct stk_command *command)
@@ -3272,20 +3201,22 @@ static void destroy_receive_data(struct stk_command=
 *command)
 	g_free(command->receive_data.alpha_id);
 }
 =

-static gboolean parse_receive_data(struct stk_command *command,
+static enum stk_command_parse_result parse_receive_data(
+					struct stk_command *command,
 					struct comprehension_tlv_iter *iter)
 {
 	struct stk_command_receive_data *obj =3D &command->receive_data;
-	gboolean ret;
 =

 	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
-		return FALSE;
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
 =

 	if ((command->dst < STK_DEVICE_IDENTITY_TYPE_CHANNEL_1) ||
 			(command->dst > STK_DEVICE_IDENTITY_TYPE_CHANNEL_7))
-		return FALSE;
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
+
+	command->destructor =3D destroy_receive_data;
 =

-	ret =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_ALPHA_ID, 0,
+	return parse_dataobj(iter, STK_DATA_OBJECT_TYPE_ALPHA_ID, 0,
 				&obj->alpha_id,
 				STK_DATA_OBJECT_TYPE_ICON_ID, 0,
 				&obj->icon_id,
@@ -3297,13 +3228,6 @@ static gboolean parse_receive_data(struct stk_comman=
d *command,
 				STK_DATA_OBJECT_TYPE_FRAME_ID, 0,
 				&obj->frame_id,
 				STK_DATA_OBJECT_TYPE_INVALID);
-
-	command->destructor =3D destroy_receive_data;
-
-	if (ret =3D=3D FALSE)
-		return FALSE;
-
-	return TRUE;
 }
 =

 static void destroy_send_data(struct stk_command *command)
@@ -3312,20 +3236,22 @@ static void destroy_send_data(struct stk_command *c=
ommand)
 	g_free(command->send_data.data.array);
 }
 =

-static gboolean parse_send_data(struct stk_command *command,
+static enum stk_command_parse_result parse_send_data(
+					struct stk_command *command,
 					struct comprehension_tlv_iter *iter)
 {
 	struct stk_command_send_data *obj =3D &command->send_data;
-	gboolean ret;
 =

 	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
-		return FALSE;
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
 =

 	if ((command->dst < STK_DEVICE_IDENTITY_TYPE_CHANNEL_1) ||
 			(command->dst > STK_DEVICE_IDENTITY_TYPE_CHANNEL_7))
-		return FALSE;
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
+
+	command->destructor =3D destroy_send_data;
 =

-	ret =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_ALPHA_ID, 0,
+	return parse_dataobj(iter, STK_DATA_OBJECT_TYPE_ALPHA_ID, 0,
 				&obj->alpha_id,
 				STK_DATA_OBJECT_TYPE_ICON_ID, 0,
 				&obj->icon_id,
@@ -3337,25 +3263,19 @@ static gboolean parse_send_data(struct stk_command =
*command,
 				STK_DATA_OBJECT_TYPE_FRAME_ID, 0,
 				&obj->frame_id,
 				STK_DATA_OBJECT_TYPE_INVALID);
-
-	command->destructor =3D destroy_send_data;
-
-	if (ret =3D=3D FALSE)
-		return FALSE;
-
-	return TRUE;
 }
 =

-static gboolean parse_get_channel_status(struct stk_command *command,
+static enum stk_command_parse_result parse_get_channel_status(
+					struct stk_command *command,
 					struct comprehension_tlv_iter *iter)
 {
 	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
-		return FALSE;
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
 =

 	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_TERMINAL)
-		return FALSE;
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
 =

-	return TRUE;
+	return STK_PARSE_RESULT_OK;
 }
 =

 static void destroy_service_search(struct stk_command *command)
@@ -3365,19 +3285,21 @@ static void destroy_service_search(struct stk_comma=
nd *command)
 	g_free(command->service_search.dev_filter.dev_filter);
 }
 =

-static gboolean parse_service_search(struct stk_command *command,
+static enum stk_command_parse_result parse_service_search(
+					struct stk_command *command,
 					struct comprehension_tlv_iter *iter)
 {
 	struct stk_command_service_search *obj =3D &command->service_search;
-	gboolean ret;
 =

 	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
-		return FALSE;
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
 =

 	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_TERMINAL)
-		return FALSE;
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
 =

-	ret =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_ALPHA_ID, 0,
+	command->destructor =3D destroy_service_search;
+
+	return parse_dataobj(iter, STK_DATA_OBJECT_TYPE_ALPHA_ID, 0,
 				&obj->alpha_id,
 				STK_DATA_OBJECT_TYPE_ICON_ID, 0,
 				&obj->icon_id,
@@ -3391,13 +3313,6 @@ static gboolean parse_service_search(struct stk_comm=
and *command,
 				STK_DATA_OBJECT_TYPE_FRAME_ID, 0,
 				&obj->frame_id,
 				STK_DATA_OBJECT_TYPE_INVALID);
-
-	command->destructor =3D destroy_service_search;
-
-	if (ret =3D=3D FALSE)
-		return FALSE;
-
-	return TRUE;
 }
 =

 static void destroy_get_service_info(struct stk_command *command)
@@ -3406,19 +3321,21 @@ static void destroy_get_service_info(struct stk_com=
mand *command)
 	g_free(command->get_service_info.attr_info.attr_info);
 }
 =

-static gboolean parse_get_service_info(struct stk_command *command,
+static enum stk_command_parse_result parse_get_service_info(
+					struct stk_command *command,
 					struct comprehension_tlv_iter *iter)
 {
 	struct stk_command_get_service_info *obj =3D &command->get_service_info;
-	gboolean ret;
 =

 	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
-		return FALSE;
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
 =

 	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_TERMINAL)
-		return FALSE;
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
 =

-	ret =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_ALPHA_ID, 0,
+	command->destructor =3D destroy_get_service_info;
+
+	return parse_dataobj(iter, STK_DATA_OBJECT_TYPE_ALPHA_ID, 0,
 				&obj->alpha_id,
 				STK_DATA_OBJECT_TYPE_ICON_ID, 0,
 				&obj->icon_id,
@@ -3430,13 +3347,6 @@ static gboolean parse_get_service_info(struct stk_co=
mmand *command,
 				STK_DATA_OBJECT_TYPE_FRAME_ID, 0,
 				&obj->frame_id,
 				STK_DATA_OBJECT_TYPE_INVALID);
-
-	command->destructor =3D destroy_get_service_info;
-
-	if (ret =3D=3D FALSE)
-		return FALSE;
-
-	return TRUE;
 }
 =

 static void destroy_declare_service(struct stk_command *command)
@@ -3444,46 +3354,41 @@ static void destroy_declare_service(struct stk_comm=
and *command)
 	g_free(command->declare_service.serv_rec.serv_rec);
 }
 =

-static gboolean parse_declare_service(struct stk_command *command,
+static enum stk_command_parse_result parse_declare_service(
+					struct stk_command *command,
 					struct comprehension_tlv_iter *iter)
 {
 	struct stk_command_declare_service *obj =3D &command->declare_service;
-	gboolean ret;
 =

 	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
-		return FALSE;
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
 =

 	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_TERMINAL)
-		return FALSE;
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
+
+	command->destructor =3D destroy_declare_service;
 =

-	ret =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_SERVICE_RECORD,
+	return parse_dataobj(iter, STK_DATA_OBJECT_TYPE_SERVICE_RECORD,
 				DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
 				&obj->serv_rec,
 				STK_DATA_OBJECT_TYPE_UICC_TE_INTERFACE, 0,
 				&obj->intf,
 				STK_DATA_OBJECT_TYPE_INVALID);
-
-	command->destructor =3D destroy_declare_service;
-
-	if (ret =3D=3D FALSE)
-		return FALSE;
-
-	return TRUE;
 }
 =

-static gboolean parse_set_frames(struct stk_command *command,
+static enum stk_command_parse_result parse_set_frames(
+					struct stk_command *command,
 					struct comprehension_tlv_iter *iter)
 {
 	struct stk_command_set_frames *obj =3D &command->set_frames;
-	gboolean ret;
 =

 	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
-		return FALSE;
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
 =

 	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_TERMINAL)
-		return FALSE;
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
 =

-	ret =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_FRAME_ID,
+	return parse_dataobj(iter, STK_DATA_OBJECT_TYPE_FRAME_ID,
 				DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
 				&obj->frame_id,
 				STK_DATA_OBJECT_TYPE_FRAME_LAYOUT, 0,
@@ -3491,23 +3396,19 @@ static gboolean parse_set_frames(struct stk_command=
 *command,
 				STK_DATA_OBJECT_TYPE_FRAME_ID, 0,
 				&obj->frame_id_default,
 				STK_DATA_OBJECT_TYPE_INVALID);
-
-	if (ret =3D=3D FALSE)
-		return FALSE;
-
-	return TRUE;
 }
 =

-static gboolean parse_get_frames_status(struct stk_command *command,
+static enum stk_command_parse_result parse_get_frames_status(
+					struct stk_command *command,
 					struct comprehension_tlv_iter *iter)
 {
 	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
-		return FALSE;
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
 =

 	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_TERMINAL)
-		return FALSE;
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
 =

-	return TRUE;
+	return STK_PARSE_RESULT_OK;
 }
 =

 static void destroy_retrieve_mms(struct stk_command *command)
@@ -3518,19 +3419,21 @@ static void destroy_retrieve_mms(struct stk_command=
 *command)
 	g_slist_free(command->retrieve_mms.mms_rec_files);
 }
 =

-static gboolean parse_retrieve_mms(struct stk_command *command,
+static enum stk_command_parse_result parse_retrieve_mms(
+					struct stk_command *command,
 					struct comprehension_tlv_iter *iter)
 {
 	struct stk_command_retrieve_mms *obj =3D &command->retrieve_mms;
-	gboolean ret;
 =

 	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
-		return FALSE;
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
 =

 	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_NETWORK)
-		return FALSE;
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
+
+	command->destructor =3D destroy_retrieve_mms;
 =

-	ret =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_ALPHA_ID, 0,
+	return parse_dataobj(iter, STK_DATA_OBJECT_TYPE_ALPHA_ID, 0,
 				&obj->alpha_id,
 				STK_DATA_OBJECT_TYPE_ICON_ID, 0,
 				&obj->icon_id,
@@ -3550,13 +3453,6 @@ static gboolean parse_retrieve_mms(struct stk_comman=
d *command,
 				STK_DATA_OBJECT_TYPE_FRAME_ID, 0,
 				&obj->frame_id,
 				STK_DATA_OBJECT_TYPE_INVALID);
-
-	command->destructor =3D destroy_retrieve_mms;
-
-	if (ret =3D=3D FALSE)
-		return FALSE;
-
-	return TRUE;
 }
 =

 static void destroy_submit_mms(struct stk_command *command)
@@ -3567,19 +3463,21 @@ static void destroy_submit_mms(struct stk_command *=
command)
 	g_slist_free(command->submit_mms.mms_subm_files);
 }
 =

-static gboolean parse_submit_mms(struct stk_command *command,
+static enum stk_command_parse_result parse_submit_mms(
+					struct stk_command *command,
 					struct comprehension_tlv_iter *iter)
 {
 	struct stk_command_submit_mms *obj =3D &command->submit_mms;
-	gboolean ret;
 =

 	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
-		return FALSE;
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
 =

 	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_NETWORK)
-		return FALSE;
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
 =

-	ret =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_ALPHA_ID, 0,
+	command->destructor =3D destroy_submit_mms;
+
+	return parse_dataobj(iter, STK_DATA_OBJECT_TYPE_ALPHA_ID, 0,
 				&obj->alpha_id,
 				STK_DATA_OBJECT_TYPE_ICON_ID, 0,
 				&obj->icon_id,
@@ -3593,13 +3491,6 @@ static gboolean parse_submit_mms(struct stk_command =
*command,
 				STK_DATA_OBJECT_TYPE_FRAME_ID, 0,
 				&obj->frame_id,
 				STK_DATA_OBJECT_TYPE_INVALID);
-
-	command->destructor =3D destroy_submit_mms;
-
-	if (ret =3D=3D FALSE)
-		return FALSE;
-
-	return TRUE;
 }
 =

 static void destroy_display_mms(struct stk_command *command)
@@ -3609,19 +3500,21 @@ static void destroy_display_mms(struct stk_command =
*command)
 	g_slist_free(command->display_mms.mms_subm_files);
 }
 =

-static gboolean parse_display_mms(struct stk_command *command,
+static enum stk_command_parse_result parse_display_mms(
+					struct stk_command *command,
 					struct comprehension_tlv_iter *iter)
 {
 	struct stk_command_display_mms *obj =3D &command->display_mms;
-	gboolean ret;
 =

 	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
-		return FALSE;
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
 =

 	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_TERMINAL)
-		return FALSE;
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
 =

-	ret =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_FILE_LIST,
+	command->destructor =3D destroy_display_mms;
+
+	return parse_dataobj(iter, STK_DATA_OBJECT_TYPE_FILE_LIST,
 				DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
 				&obj->mms_subm_files,
 				STK_DATA_OBJECT_TYPE_MMS_ID,
@@ -3632,36 +3525,112 @@ static gboolean parse_display_mms(struct stk_comma=
nd *command,
 				STK_DATA_OBJECT_TYPE_FRAME_ID, 0,
 				&obj->frame_id,
 				STK_DATA_OBJECT_TYPE_INVALID);
-
-	command->destructor =3D destroy_display_mms;
-
-	if (ret =3D=3D FALSE)
-		return FALSE;
-
-	return TRUE;
 }
 =

-static gboolean parse_activate(struct stk_command *command,
+static enum stk_command_parse_result parse_activate(
+					struct stk_command *command,
 					struct comprehension_tlv_iter *iter)
 {
 	struct stk_command_activate *obj =3D &command->activate;
-	gboolean ret;
 =

 	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
-		return FALSE;
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
 =

 	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_TERMINAL)
-		return FALSE;
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
 =

-	ret =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_ACTIVATE_DESCRIPTOR,
+	return parse_dataobj(iter, STK_DATA_OBJECT_TYPE_ACTIVATE_DESCRIPTOR,
 				DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
 				&obj->actv_desc,
 				STK_DATA_OBJECT_TYPE_INVALID);
+}
 =

-	if (ret =3D=3D FALSE)
-		return FALSE;
-
-	return TRUE;
+static enum stk_command_parse_result parse_command_body(
+					struct stk_command *command,
+					struct comprehension_tlv_iter *iter)
+{
+	switch (command->type) {
+	case STK_COMMAND_TYPE_DISPLAY_TEXT:
+		return parse_display_text(command, iter);
+	case STK_COMMAND_TYPE_GET_INKEY:
+		return parse_get_inkey(command, iter);
+	case STK_COMMAND_TYPE_GET_INPUT:
+		return parse_get_input(command, iter);
+	case STK_COMMAND_TYPE_MORE_TIME:
+		return parse_more_time(command, iter);
+	case STK_COMMAND_TYPE_PLAY_TONE:
+		return parse_play_tone(command, iter);
+	case STK_COMMAND_TYPE_POLL_INTERVAL:
+		return parse_poll_interval(command, iter);
+	case STK_COMMAND_TYPE_SETUP_MENU:
+		return parse_setup_menu(command, iter);
+	case STK_COMMAND_TYPE_SELECT_ITEM:
+		return parse_select_item(command, iter);
+	case STK_COMMAND_TYPE_SEND_SMS:
+		return parse_send_sms(command, iter);
+	case STK_COMMAND_TYPE_SEND_SS:
+		return parse_send_ss(command, iter);
+	case STK_COMMAND_TYPE_SEND_USSD:
+		return parse_send_ussd(command, iter);
+	case STK_COMMAND_TYPE_SETUP_CALL:
+		return parse_setup_call(command, iter);
+	case STK_COMMAND_TYPE_REFRESH:
+		return parse_refresh(command, iter);
+	case STK_COMMAND_TYPE_POLLING_OFF:
+		return parse_polling_off(command, iter);
+	case STK_COMMAND_TYPE_PROVIDE_LOCAL_INFO:
+		return parse_provide_local_info(command, iter);
+	case STK_COMMAND_TYPE_SETUP_EVENT_LIST:
+		return parse_setup_event_list(command, iter);
+	case STK_COMMAND_TYPE_PERFORM_CARD_APDU:
+		return parse_perform_card_apdu(command, iter);
+	case STK_COMMAND_TYPE_POWER_OFF_CARD:
+		return parse_power_off_card(command, iter);
+	case STK_COMMAND_TYPE_POWER_ON_CARD:
+		return parse_power_on_card(command, iter);
+	case STK_COMMAND_TYPE_GET_READER_STATUS:
+		return parse_get_reader_status(command, iter);
+	case STK_COMMAND_TYPE_TIMER_MANAGEMENT:
+		return parse_timer_mgmt(command, iter);
+	case STK_COMMAND_TYPE_SETUP_IDLE_MODE_TEXT:
+		return parse_setup_idle_mode_text(command, iter);
+	case STK_COMMAND_TYPE_RUN_AT_COMMAND:
+		return parse_run_at_command(command, iter);
+	case STK_COMMAND_TYPE_SEND_DTMF:
+		return parse_send_dtmf(command, iter);
+	case STK_COMMAND_TYPE_LANGUAGE_NOTIFICATION:
+		return parse_language_notification(command, iter);
+	case STK_COMMAND_TYPE_LAUNCH_BROWSER:
+		return parse_launch_browser(command, iter);
+	case STK_COMMAND_TYPE_CLOSE_CHANNEL:
+		return parse_close_channel(command, iter);
+	case STK_COMMAND_TYPE_RECEIVE_DATA:
+		return parse_receive_data(command, iter);
+	case STK_COMMAND_TYPE_SEND_DATA:
+		return parse_send_data(command, iter);
+	case STK_COMMAND_TYPE_GET_CHANNEL_STATUS:
+		return parse_get_channel_status(command, iter);
+	case STK_COMMAND_TYPE_SERVICE_SEARCH:
+		return parse_service_search(command, iter);
+	case STK_COMMAND_TYPE_GET_SERVICE_INFO:
+		return parse_get_service_info(command, iter);
+	case STK_COMMAND_TYPE_DECLARE_SERVICE:
+		return parse_declare_service(command, iter);
+	case STK_COMMAND_TYPE_SET_FRAMES:
+		return parse_set_frames(command, iter);
+	case STK_COMMAND_TYPE_GET_FRAMES_STATUS:
+		return parse_get_frames_status(command, iter);
+	case STK_COMMAND_TYPE_RETRIEVE_MMS:
+		return parse_retrieve_mms(command, iter);
+	case STK_COMMAND_TYPE_SUBMIT_MMS:
+		return parse_submit_mms(command, iter);
+	case STK_COMMAND_TYPE_DISPLAY_MMS:
+		return parse_display_mms(command, iter);
+	case STK_COMMAND_TYPE_ACTIVATE:
+		return parse_activate(command, iter);
+	default:
+		return STK_PARSE_RESULT_TYPE_NOT_UNDERSTOOD;
+	};
 }
 =

 struct stk_command *stk_command_new_from_pdu(const unsigned char *pdu,
@@ -3671,7 +3640,6 @@ struct stk_command *stk_command_new_from_pdu(const un=
signed char *pdu,
 	struct comprehension_tlv_iter iter;
 	const unsigned char *data;
 	struct stk_command *command;
-	gboolean ok;
 =

 	ber_tlv_iter_init(&ber, pdu, len);
 =

@@ -3706,154 +3674,31 @@ struct stk_command *stk_command_new_from_pdu(const=
 unsigned char *pdu,
 	command->type =3D data[1];
 	command->qualifier =3D data[2];
 =

-	if (comprehension_tlv_iter_next(&iter) !=3D TRUE)
-		goto fail;
+	if (comprehension_tlv_iter_next(&iter) !=3D TRUE) {
+		command->status =3D STK_PARSE_RESULT_MISSING_VALUE;
+		goto out;
+	}
 =

 	if (comprehension_tlv_iter_get_tag(&iter) !=3D
-			STK_DATA_OBJECT_TYPE_DEVICE_IDENTITIES)
-		goto fail;
+			STK_DATA_OBJECT_TYPE_DEVICE_IDENTITIES) {
+		command->status =3D STK_PARSE_RESULT_MISSING_VALUE;
+		goto out;
+	}
 =

-	if (comprehension_tlv_iter_get_length(&iter) !=3D 0x02)
-		goto fail;
+	if (comprehension_tlv_iter_get_length(&iter) !=3D 0x02) {
+		command->status =3D STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
+		goto out;
+	}
 =

 	data =3D comprehension_tlv_iter_get_data(&iter);
 =

 	command->src =3D data[0];
 	command->dst =3D data[1];
 =

-	switch (command->type) {
-	case STK_COMMAND_TYPE_DISPLAY_TEXT:
-		ok =3D parse_display_text(command, &iter);
-		break;
-	case STK_COMMAND_TYPE_GET_INKEY:
-		ok =3D parse_get_inkey(command, &iter);
-		break;
-	case STK_COMMAND_TYPE_GET_INPUT:
-		ok =3D parse_get_input(command, &iter);
-		break;
-	case STK_COMMAND_TYPE_MORE_TIME:
-		ok =3D parse_more_time(command, &iter);
-		break;
-	case STK_COMMAND_TYPE_PLAY_TONE:
-		ok =3D parse_play_tone(command, &iter);
-		break;
-	case STK_COMMAND_TYPE_POLL_INTERVAL:
-		ok =3D parse_poll_interval(command, &iter);
-		break;
-	case STK_COMMAND_TYPE_SETUP_MENU:
-		ok =3D parse_setup_menu(command, &iter);
-		break;
-	case STK_COMMAND_TYPE_SELECT_ITEM:
-		ok =3D parse_select_item(command, &iter);
-		break;
-	case STK_COMMAND_TYPE_SEND_SMS:
-		ok =3D parse_send_sms(command, &iter);
-		break;
-	case STK_COMMAND_TYPE_SEND_SS:
-		ok =3D parse_send_ss(command, &iter);
-		break;
-	case STK_COMMAND_TYPE_SEND_USSD:
-		ok =3D parse_send_ussd(command, &iter);
-		break;
-	case STK_COMMAND_TYPE_SETUP_CALL:
-		ok =3D parse_setup_call(command, &iter);
-		break;
-	case STK_COMMAND_TYPE_REFRESH:
-		ok =3D parse_refresh(command, &iter);
-		break;
-	case STK_COMMAND_TYPE_POLLING_OFF:
-		ok =3D parse_polling_off(command, &iter);
-		break;
-	case STK_COMMAND_TYPE_PROVIDE_LOCAL_INFO:
-		ok =3D parse_provide_local_info(command, &iter);
-		break;
-	case STK_COMMAND_TYPE_SETUP_EVENT_LIST:
-		ok =3D parse_setup_event_list(command, &iter);
-		break;
-	case STK_COMMAND_TYPE_PERFORM_CARD_APDU:
-		ok =3D parse_perform_card_apdu(command, &iter);
-		break;
-	case STK_COMMAND_TYPE_POWER_OFF_CARD:
-		ok =3D parse_power_off_card(command, &iter);
-		break;
-	case STK_COMMAND_TYPE_POWER_ON_CARD:
-		ok =3D parse_power_on_card(command, &iter);
-		break;
-	case STK_COMMAND_TYPE_GET_READER_STATUS:
-		ok =3D parse_get_reader_status(command, &iter);
-		break;
-	case STK_COMMAND_TYPE_TIMER_MANAGEMENT:
-		ok =3D parse_timer_mgmt(command, &iter);
-		break;
-	case STK_COMMAND_TYPE_SETUP_IDLE_MODE_TEXT:
-		ok =3D parse_setup_idle_mode_text(command, &iter);
-		break;
-	case STK_COMMAND_TYPE_RUN_AT_COMMAND:
-		ok =3D parse_run_at_command(command, &iter);
-		break;
-	case STK_COMMAND_TYPE_SEND_DTMF:
-		ok =3D parse_send_dtmf(command, &iter);
-		break;
-	case STK_COMMAND_TYPE_LANGUAGE_NOTIFICATION:
-		ok =3D parse_language_notification(command, &iter);
-		break;
-	case STK_COMMAND_TYPE_LAUNCH_BROWSER:
-		ok =3D parse_launch_browser(command, &iter);
-		break;
-	case STK_COMMAND_TYPE_CLOSE_CHANNEL:
-		ok =3D parse_close_channel(command, &iter);
-		break;
-	case STK_COMMAND_TYPE_RECEIVE_DATA:
-		ok =3D parse_receive_data(command, &iter);
-		break;
-	case STK_COMMAND_TYPE_SEND_DATA:
-		ok =3D parse_send_data(command, &iter);
-		break;
-	case STK_COMMAND_TYPE_GET_CHANNEL_STATUS:
-		ok =3D parse_get_channel_status(command, &iter);
-		break;
-	case STK_COMMAND_TYPE_SERVICE_SEARCH:
-		ok =3D parse_service_search(command, &iter);
-		break;
-	case STK_COMMAND_TYPE_GET_SERVICE_INFO:
-		ok =3D parse_get_service_info(command, &iter);
-		break;
-	case STK_COMMAND_TYPE_DECLARE_SERVICE:
-		ok =3D parse_declare_service(command, &iter);
-		break;
-	case STK_COMMAND_TYPE_SET_FRAMES:
-		ok =3D parse_set_frames(command, &iter);
-		break;
-	case STK_COMMAND_TYPE_GET_FRAMES_STATUS:
-		ok =3D parse_get_frames_status(command, &iter);
-		break;
-	case STK_COMMAND_TYPE_RETRIEVE_MMS:
-		ok =3D parse_retrieve_mms(command, &iter);
-		break;
-	case STK_COMMAND_TYPE_SUBMIT_MMS:
-		ok =3D parse_submit_mms(command, &iter);
-		break;
-	case STK_COMMAND_TYPE_DISPLAY_MMS:
-		ok =3D parse_display_mms(command, &iter);
-		break;
-	case STK_COMMAND_TYPE_ACTIVATE:
-		ok =3D parse_activate(command, &iter);
-		break;
-	default:
-		ok =3D FALSE;
-		break;
-	};
-
-	if (ok)
-		return command;
-
-fail:
-	if (command->destructor)
-		command->destructor(command);
+	command->status =3D parse_command_body(command, &iter);
 =

-	g_free(command);
-
-	return NULL;
+out:
+	return command;
 }
 =

 void stk_command_free(struct stk_command *command)
diff --git a/src/stkutil.h b/src/stkutil.h
index ea0f77a..ca4817e 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -1302,12 +1302,20 @@ struct stk_command_activate {
 	unsigned char actv_desc;
 };
 =

+enum stk_command_parse_result {
+	STK_PARSE_RESULT_OK,
+	STK_PARSE_RESULT_TYPE_NOT_UNDERSTOOD,
+	STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD,
+	STK_PARSE_RESULT_MISSING_VALUE,
+};
+
 struct stk_command {
 	unsigned char number;
 	unsigned char type;
 	unsigned char qualifier;
 	enum stk_device_identity_type src;
 	enum stk_device_identity_type dst;
+	enum stk_command_parse_result status;
 =

 	union {
 		struct stk_command_display_text display_text;
diff --git a/unit/test-stkutil.c b/unit/test-stkutil.c
index c586a7b..8b7e254 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -731,6 +731,7 @@ static void test_display_text(gconstpointer data)
 	command =3D stk_command_new_from_pdu(test->pdu, test->pdu_len);
 =

 	g_assert(command);
+	g_assert(command->status =3D=3D STK_PARSE_RESULT_OK);
 =

 	g_assert(command->number =3D=3D 1);
 	g_assert(command->type =3D=3D STK_COMMAND_TYPE_DISPLAY_TEXT);
@@ -1668,6 +1669,7 @@ static void test_get_inkey(gconstpointer data)
 	command =3D stk_command_new_from_pdu(test->pdu, test->pdu_len);
 =

 	g_assert(command);
+	g_assert(command->status =3D=3D STK_PARSE_RESULT_OK);
 =

 	g_assert(command->number =3D=3D 1);
 	g_assert(command->type =3D=3D STK_COMMAND_TYPE_GET_INKEY);
@@ -2973,6 +2975,7 @@ static void test_get_input(gconstpointer data)
 	command =3D stk_command_new_from_pdu(test->pdu, test->pdu_len);
 =

 	g_assert(command);
+	g_assert(command->status =3D=3D STK_PARSE_RESULT_OK);
 =

 	g_assert(command->number =3D=3D 1);
 	g_assert(command->type =3D=3D STK_COMMAND_TYPE_GET_INPUT);
@@ -3018,6 +3021,7 @@ static void test_more_time(gconstpointer data)
 	command =3D stk_command_new_from_pdu(test->pdu, test->pdu_len);
 =

 	g_assert(command);
+	g_assert(command->status =3D=3D STK_PARSE_RESULT_OK);
 =

 	g_assert(command->number =3D=3D 1);
 	g_assert(command->type =3D=3D STK_COMMAND_TYPE_MORE_TIME);
@@ -4253,6 +4257,7 @@ static void test_play_tone(gconstpointer data)
 	command =3D stk_command_new_from_pdu(test->pdu, test->pdu_len);
 =

 	g_assert(command);
+	g_assert(command->status =3D=3D STK_PARSE_RESULT_OK);
 =

 	g_assert(command->number =3D=3D 1);
 	g_assert(command->type =3D=3D STK_COMMAND_TYPE_PLAY_TONE);
@@ -4301,6 +4306,7 @@ static void test_poll_interval(gconstpointer data)
 	command =3D stk_command_new_from_pdu(test->pdu, test->pdu_len);
 =

 	g_assert(command);
+	g_assert(command->status =3D=3D STK_PARSE_RESULT_OK);
 =

 	g_assert(command->number =3D=3D 1);
 	g_assert(command->type =3D=3D STK_COMMAND_TYPE_POLL_INTERVAL);
@@ -5522,6 +5528,7 @@ static void test_setup_menu(gconstpointer data)
 	command =3D stk_command_new_from_pdu(test->pdu, test->pdu_len);
 =

 	g_assert(command);
+	g_assert(command->status =3D=3D STK_PARSE_RESULT_OK);
 =

 	g_assert(command->number =3D=3D 1);
 	g_assert(command->type =3D=3D STK_COMMAND_TYPE_SETUP_MENU);
@@ -5546,6 +5553,17 @@ static void test_setup_menu(gconstpointer data)
 	stk_command_free(command);
 }
 =

+static void test_setup_menu_missing_val(gconstpointer data)
+{
+	const struct setup_menu_test *test =3D data;
+	struct stk_command *command;
+
+	command =3D stk_command_new_from_pdu(test->pdu, test->pdu_len);
+
+	g_assert(command);
+	g_assert(command->status =3D=3D STK_PARSE_RESULT_MISSING_VALUE);
+}
+
 static void test_setup_menu_neg(gconstpointer data)
 {
 	const struct setup_menu_test *test =3D data;
@@ -5553,7 +5571,8 @@ static void test_setup_menu_neg(gconstpointer data)
 =

 	command =3D stk_command_new_from_pdu(test->pdu, test->pdu_len);
 =

-	g_assert(!command);
+	g_assert(command);
+	g_assert(command->status =3D=3D STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD);
 }
 =

 struct select_item_test {
@@ -7106,6 +7125,7 @@ static void test_select_item(gconstpointer data)
 	command =3D stk_command_new_from_pdu(test->pdu, test->pdu_len);
 =

 	g_assert(command);
+	g_assert(command->status =3D=3D STK_PARSE_RESULT_OK);
 =

 	g_assert(command->number =3D=3D 1);
 	g_assert(command->type =3D=3D STK_COMMAND_TYPE_SELECT_ITEM);
@@ -8730,6 +8750,7 @@ static void test_send_sms(gconstpointer data)
 	command =3D stk_command_new_from_pdu(test->pdu, test->pdu_len);
 =

 	g_assert(command);
+	g_assert(command->status =3D=3D STK_PARSE_RESULT_OK);
 =

 	g_assert(command->number =3D=3D 1);
 	g_assert(command->type =3D=3D STK_COMMAND_TYPE_SEND_SMS);
@@ -9703,6 +9724,7 @@ static void test_send_ss(gconstpointer data)
 	command =3D stk_command_new_from_pdu(test->pdu, test->pdu_len);
 =

 	g_assert(command);
+	g_assert(command->status =3D=3D STK_PARSE_RESULT_OK);
 =

 	g_assert(command->number =3D=3D 1);
 	g_assert(command->type =3D=3D STK_COMMAND_TYPE_SEND_SS);
@@ -10935,6 +10957,7 @@ static void test_send_ussd(gconstpointer data)
 	command =3D stk_command_new_from_pdu(test->pdu, test->pdu_len);
 =

 	g_assert(command);
+	g_assert(command->status =3D=3D STK_PARSE_RESULT_OK);
 =

 	g_assert(command->number =3D=3D 1);
 	g_assert(command->type =3D=3D STK_COMMAND_TYPE_SEND_USSD);
@@ -12201,6 +12224,7 @@ static void test_setup_call(gconstpointer data)
 	command =3D stk_command_new_from_pdu(test->pdu, test->pdu_len);
 =

 	g_assert(command);
+	g_assert(command->status =3D=3D STK_PARSE_RESULT_OK);
 =

 	g_assert(command->number =3D=3D 1);
 	g_assert(command->type =3D=3D STK_COMMAND_TYPE_SETUP_CALL);
@@ -12275,6 +12299,7 @@ static void test_refresh(gconstpointer data)
 	command =3D stk_command_new_from_pdu(test->pdu, test->pdu_len);
 =

 	g_assert(command);
+	g_assert(command->status =3D=3D STK_PARSE_RESULT_OK);
 =

 	g_assert(command->number =3D=3D 1);
 	g_assert(command->type =3D=3D STK_COMMAND_TYPE_REFRESH);
@@ -12316,6 +12341,7 @@ static void test_polling_off(gconstpointer data)
 	command =3D stk_command_new_from_pdu(test->pdu, test->pdu_len);
 =

 	g_assert(command);
+	g_assert(command->status =3D=3D STK_PARSE_RESULT_OK);
 =

 	g_assert(command->number =3D=3D 1);
 	g_assert(command->type =3D=3D STK_COMMAND_TYPE_POLLING_OFF);
@@ -12401,6 +12427,7 @@ static void test_provide_local_info(gconstpointer d=
ata)
 	command =3D stk_command_new_from_pdu(test->pdu, test->pdu_len);
 =

 	g_assert(command);
+	g_assert(command->status =3D=3D STK_PARSE_RESULT_OK);
 =

 	g_assert(command->number =3D=3D 1);
 	g_assert(command->type =3D=3D STK_COMMAND_TYPE_PROVIDE_LOCAL_INFO);
@@ -12508,6 +12535,7 @@ static void test_setup_event_list(gconstpointer dat=
a)
 	command =3D stk_command_new_from_pdu(test->pdu, test->pdu_len);
 =

 	g_assert(command);
+	g_assert(command->status =3D=3D STK_PARSE_RESULT_OK);
 =

 	g_assert(command->number =3D=3D 1);
 	g_assert(command->type =3D=3D STK_COMMAND_TYPE_SETUP_EVENT_LIST);
@@ -12733,6 +12761,7 @@ static void test_perform_card_apdu(gconstpointer da=
ta)
 	command =3D stk_command_new_from_pdu(test->pdu, test->pdu_len);
 =

 	g_assert(command);
+	g_assert(command->status =3D=3D STK_PARSE_RESULT_OK);
 =

 	g_assert(command->number =3D=3D 1);
 	g_assert(command->type =3D=3D STK_COMMAND_TYPE_PERFORM_CARD_APDU);
@@ -12770,6 +12799,7 @@ static void test_get_reader_status(gconstpointer da=
ta)
 	command =3D stk_command_new_from_pdu(test->pdu, test->pdu_len);
 =

 	g_assert(command);
+	g_assert(command->status =3D=3D STK_PARSE_RESULT_OK);
 =

 	g_assert(command->number =3D=3D 1);
 	g_assert(command->type =3D=3D STK_COMMAND_TYPE_GET_READER_STATUS);
@@ -13290,6 +13320,7 @@ static void test_timer_mgmt(gconstpointer data)
 	command =3D stk_command_new_from_pdu(test->pdu, test->pdu_len);
 =

 	g_assert(command);
+	g_assert(command->status =3D=3D STK_PARSE_RESULT_OK);
 =

 	g_assert(command->number =3D=3D 1);
 	g_assert(command->type =3D=3D STK_COMMAND_TYPE_TIMER_MANAGEMENT);
@@ -14004,6 +14035,7 @@ static void test_setup_idle_mode_text(gconstpointer=
 data)
 	command =3D stk_command_new_from_pdu(test->pdu, test->pdu_len);
 =

 	g_assert(command);
+	g_assert(command->status =3D=3D STK_PARSE_RESULT_OK);
 =

 	g_assert(command->number =3D=3D 1);
 	g_assert(command->type =3D=3D STK_COMMAND_TYPE_SETUP_IDLE_MODE_TEXT);
@@ -14758,6 +14790,7 @@ static void test_run_at_command(gconstpointer data)
 	command =3D stk_command_new_from_pdu(test->pdu, test->pdu_len);
 =

 	g_assert(command);
+	g_assert(command->status =3D=3D STK_PARSE_RESULT_OK);
 =

 	g_assert(command->number =3D=3D 1);
 	g_assert(command->type =3D=3D STK_COMMAND_TYPE_RUN_AT_COMMAND);
@@ -15423,6 +15456,7 @@ static void test_send_dtmf(gconstpointer data)
 	command =3D stk_command_new_from_pdu(test->pdu, test->pdu_len);
 =

 	g_assert(command);
+	g_assert(command->status =3D=3D STK_PARSE_RESULT_OK);
 =

 	g_assert(command->number =3D=3D 1);
 	g_assert(command->type =3D=3D STK_COMMAND_TYPE_SEND_DTMF);
@@ -15477,6 +15511,7 @@ static void test_language_notification(gconstpointe=
r data)
 	command =3D stk_command_new_from_pdu(test->pdu, test->pdu_len);
 =

 	g_assert(command);
+	g_assert(command->status =3D=3D STK_PARSE_RESULT_OK);
 =

 	g_assert(command->number =3D=3D 1);
 	g_assert(command->type =3D=3D STK_COMMAND_TYPE_LANGUAGE_NOTIFICATION);
@@ -16135,6 +16170,7 @@ static void test_launch_browser(gconstpointer data)
 	command =3D stk_command_new_from_pdu(test->pdu, test->pdu_len);
 =

 	g_assert(command);
+	g_assert(command->status =3D=3D STK_PARSE_RESULT_OK);
 =

 	g_assert(command->number =3D=3D 1);
 	g_assert(command->type =3D=3D STK_COMMAND_TYPE_LAUNCH_BROWSER);
@@ -22494,7 +22530,7 @@ int main(int argc, char **argv)
 				&setup_menu_data_913, test_setup_menu);
 =

 	g_test_add_data_func("/teststk/Setup Menu Negative 1",
-			&setup_menu_data_neg_1, test_setup_menu_neg);
+			&setup_menu_data_neg_1, test_setup_menu_missing_val);
 	g_test_add_data_func("/teststk/Setup Menu Negative 2",
 			&setup_menu_data_neg_2, test_setup_menu_neg);
 	g_test_add_data_func("/teststk/Setup Menu Negative 3",
-- =

1.7.1.86.g0e460.dirty


--===============0017879515850537023==--

