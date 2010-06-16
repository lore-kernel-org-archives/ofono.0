Content-Type: multipart/mixed; boundary="===============7591387887389423070=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/4][RFC] stkutil: Refactor command parser error handling
Date: Wed, 16 Jun 2010 17:26:52 +0200
Message-ID: <1276702015-8711-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7591387887389423070==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When parsing the full command fails but Command Details has been parsed,
return a struct stk_command containing this information and the type of
parsing problem found.  We need the command details to be able to
even respond to the command.

This patch also makes the parser skip over unknown data objects found
in the BER-TLV, if they don't have Comprehension Required set.

The tests succeed but please check that it doesn't break the logic.
---
 src/stkutil.c       |  188 +++++++++++++++++++----------------------------=
----
 src/stkutil.h       |    8 ++
 unit/test-stkutil.c |   38 ++++++++++-
 3 files changed, 113 insertions(+), 121 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 4e11179..5a100b3 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -2121,16 +2121,17 @@ struct dataobj_handler_entry {
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

@@ -2147,45 +2148,59 @@ static gboolean parse_dataobj(struct comprehension_=
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
+			if (entry->flags & DATAOBJ_FLAG_MINIMUM)
+				l2 =3D NULL;
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
-
-		if (comprehension_tlv_iter_get_tag(iter) =3D=3D entry->type) {
-			if (handler(iter, entry->data))
-				entry->parsed =3D TRUE;
+		if (handler(iter, entry->data) =3D=3D FALSE)
+			parse_error =3D TRUE;
 =

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
@@ -2197,7 +2212,6 @@ static gboolean parse_display_text(struct stk_command=
 *command,
 					struct comprehension_tlv_iter *iter)
 {
 	struct stk_command_display_text *obj =3D &command->display_text;
-	gboolean ret;
 =

 	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
 		return FALSE;
@@ -2205,7 +2219,7 @@ static gboolean parse_display_text(struct stk_command=
 *command,
 	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_DISPLAY)
 		return FALSE;
 =

-	ret =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_TEXT,
+	command->status =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_TEXT,
 				DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
 				&obj->text,
 				STK_DATA_OBJECT_TYPE_ICON_ID, 0,
@@ -2222,9 +2236,6 @@ static gboolean parse_display_text(struct stk_command=
 *command,
 =

 	command->destructor =3D destroy_display_text;
 =

-	if (ret =3D=3D FALSE)
-		return FALSE;
-
 	return TRUE;
 }
 =

@@ -2237,7 +2248,6 @@ static gboolean parse_get_inkey(struct stk_command *c=
ommand,
 				struct comprehension_tlv_iter *iter)
 {
 	struct stk_command_get_inkey *obj =3D &command->get_inkey;
-	gboolean ret;
 =

 	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
 		return FALSE;
@@ -2245,7 +2255,7 @@ static gboolean parse_get_inkey(struct stk_command *c=
ommand,
 	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_TERMINAL)
 		return FALSE;
 =

-	ret =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_TEXT,
+	command->status =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_TEXT,
 				DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
 				&obj->text,
 				STK_DATA_OBJECT_TYPE_ICON_ID, 0,
@@ -2260,9 +2270,6 @@ static gboolean parse_get_inkey(struct stk_command *c=
ommand,
 =

 	command->destructor =3D destroy_get_inkey;
 =

-	if (ret =3D=3D FALSE)
-		return FALSE;
-
 	return TRUE;
 }
 =

@@ -2276,7 +2283,6 @@ static gboolean parse_get_input(struct stk_command *c=
ommand,
 					struct comprehension_tlv_iter *iter)
 {
 	struct stk_command_get_input *obj =3D &command->get_input;
-	gboolean ret;
 =

 	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
 		return FALSE;
@@ -2284,7 +2290,7 @@ static gboolean parse_get_input(struct stk_command *c=
ommand,
 	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_TERMINAL)
 		return FALSE;
 =

-	ret =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_TEXT,
+	command->status =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_TEXT,
 				DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
 				&obj->text,
 				STK_DATA_OBJECT_TYPE_RESPONSE_LENGTH,
@@ -2302,9 +2308,6 @@ static gboolean parse_get_input(struct stk_command *c=
ommand,
 =

 	command->destructor =3D destroy_get_input;
 =

-	if (ret =3D=3D FALSE)
-		return FALSE;
-
 	return TRUE;
 }
 =

@@ -2329,7 +2332,6 @@ static gboolean parse_play_tone(struct stk_command *c=
ommand,
 					struct comprehension_tlv_iter *iter)
 {
 	struct stk_command_play_tone *obj =3D &command->play_tone;
-	gboolean ret;
 =

 	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
 		return FALSE;
@@ -2337,7 +2339,7 @@ static gboolean parse_play_tone(struct stk_command *c=
ommand,
 	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_EARPIECE)
 		return FALSE;
 =

-	ret =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_ALPHA_ID, 0,
+	command->status =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_ALPHA_ID, 0,
 				&obj->alpha_id,
 				STK_DATA_OBJECT_TYPE_TONE, 0,
 				&obj->tone,
@@ -2353,9 +2355,6 @@ static gboolean parse_play_tone(struct stk_command *c=
ommand,
 =

 	command->destructor =3D destroy_play_tone;
 =

-	if (ret =3D=3D FALSE)
-		return FALSE;
-
 	return TRUE;
 }
 =

@@ -2363,7 +2362,6 @@ static gboolean parse_poll_interval(struct stk_comman=
d *command,
 					struct comprehension_tlv_iter *iter)
 {
 	struct stk_command_poll_interval *obj =3D &command->poll_interval;
-	gboolean ret;
 =

 	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
 		return FALSE;
@@ -2371,14 +2369,11 @@ static gboolean parse_poll_interval(struct stk_comm=
and *command,
 	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_TERMINAL)
 		return FALSE;
 =

-	ret =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_DURATION,
+	command->status =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_DURATION,
 				DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
 				&obj->duration,
 				STK_DATA_OBJECT_TYPE_INVALID);
 =

-	if (ret =3D=3D FALSE)
-		return FALSE;
-
 	return TRUE;
 }
 =

@@ -2394,7 +2389,6 @@ static gboolean parse_setup_menu(struct stk_command *=
command,
 					struct comprehension_tlv_iter *iter)
 {
 	struct stk_command_setup_menu *obj =3D &command->setup_menu;
-	gboolean ret;
 =

 	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
 		return FALSE;
@@ -2404,7 +2398,7 @@ static gboolean parse_setup_menu(struct stk_command *=
command,
 =

 	command->destructor =3D destroy_setup_menu;
 =

-	ret =3D parse_dataobj(iter,
+	command->status =3D parse_dataobj(iter,
 			STK_DATA_OBJECT_TYPE_ALPHA_ID,
 			DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
 			&obj->alpha_id,
@@ -2423,9 +2417,6 @@ static gboolean parse_setup_menu(struct stk_command *=
command,
 			&obj->item_text_attr_list,
 			STK_DATA_OBJECT_TYPE_INVALID);
 =

-	if (ret =3D=3D FALSE)
-		return FALSE;
-
 	return TRUE;
 }
 =

@@ -2441,7 +2432,6 @@ static gboolean parse_select_item(struct stk_command =
*command,
 					struct comprehension_tlv_iter *iter)
 {
 	struct stk_command_select_item *obj =3D &command->select_item;
-	gboolean ret;
 =

 	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
 		return FALSE;
@@ -2451,7 +2441,7 @@ static gboolean parse_select_item(struct stk_command =
*command,
 =

 	command->destructor =3D destroy_select_item;
 =

-	ret =3D parse_dataobj(iter,
+	command->status =3D parse_dataobj(iter,
 			STK_DATA_OBJECT_TYPE_ALPHA_ID,
 			DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
 			&obj->alpha_id,
@@ -2474,9 +2464,6 @@ static gboolean parse_select_item(struct stk_command =
*command,
 			&obj->frame_id,
 			STK_DATA_OBJECT_TYPE_INVALID);
 =

-	if (ret =3D=3D FALSE)
-		return FALSE;
-
 	if (obj->items =3D=3D NULL)
 		return FALSE;
 =

@@ -2495,7 +2482,6 @@ static gboolean parse_send_sms(struct stk_command *co=
mmand,
 {
 	struct stk_command_send_sms *obj =3D &command->send_sms;
 	struct gsm_sms_tpdu gsm_tpdu;
-	gboolean ret;
 =

 	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
 		return FALSE;
@@ -2504,7 +2490,8 @@ static gboolean parse_send_sms(struct stk_command *co=
mmand,
 		return FALSE;
 =

 	memset(&gsm_tpdu, 0, sizeof(gsm_tpdu));
-	ret =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_ALPHA_ID, 0,
+	command->status =3D parse_dataobj(iter,
+				STK_DATA_OBJECT_TYPE_ALPHA_ID, 0,
 				&obj->alpha_id,
 				STK_DATA_OBJECT_TYPE_ADDRESS, 0,
 				&obj->address,
@@ -2520,10 +2507,10 @@ static gboolean parse_send_sms(struct stk_command *=
command,
 				&obj->frame_id,
 				STK_DATA_OBJECT_TYPE_INVALID);
 =

-	command->destructor =3D destroy_send_sms;
+	if (command->status !=3D STK_PARSE_RESULT_OK)
+		return TRUE;
 =

-	if (ret =3D=3D FALSE)
-		return FALSE;
+	command->destructor =3D destroy_send_sms;
 =

 	if (gsm_tpdu.len =3D=3D 0 && obj->cdma_sms.len =3D=3D 0)
 		return FALSE;
@@ -2562,7 +2549,6 @@ static gboolean parse_setup_call(struct stk_command *=
command,
 					struct comprehension_tlv_iter *iter)
 {
 	struct stk_command_setup_call *obj =3D &command->setup_call;
-	gboolean ret;
 =

 	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
 		return FALSE;
@@ -2570,7 +2556,8 @@ static gboolean parse_setup_call(struct stk_command *=
command,
 	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_NETWORK)
 		return FALSE;
 =

-	ret =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_ALPHA_ID, 0,
+	command->status =3D parse_dataobj(iter,
+				STK_DATA_OBJECT_TYPE_ALPHA_ID, 0,
 				&obj->alpha_id_usr_cfm,
 				STK_DATA_OBJECT_TYPE_ADDRESS,
 				DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
@@ -2597,9 +2584,6 @@ static gboolean parse_setup_call(struct stk_command *=
command,
 =

 	command->destructor =3D destroy_setup_call;
 =

-	if (ret =3D=3D FALSE)
-		return FALSE;
-
 	return TRUE;
 }
 =

@@ -2614,7 +2598,6 @@ static gboolean parse_refresh(struct stk_command *com=
mand,
 					struct comprehension_tlv_iter *iter)
 {
 	struct stk_command_refresh *obj =3D &command->refresh;
-	gboolean ret;
 =

 	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
 		return FALSE;
@@ -2622,7 +2605,8 @@ static gboolean parse_refresh(struct stk_command *com=
mand,
 	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_TERMINAL)
 		return FALSE;
 =

-	ret =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_FILE_LIST, 0,
+	command->status =3D parse_dataobj(iter,
+				STK_DATA_OBJECT_TYPE_FILE_LIST, 0,
 				&obj->file_list,
 				STK_DATA_OBJECT_TYPE_AID, 0,
 				&obj->aid,
@@ -2638,9 +2622,6 @@ static gboolean parse_refresh(struct stk_command *com=
mand,
 =

 	command->destructor =3D destroy_refresh;
 =

-	if (ret =3D=3D FALSE)
-		return FALSE;
-
 	return TRUE;
 }
 =

@@ -2672,7 +2653,6 @@ static gboolean parse_setup_event_list(struct stk_com=
mand *command,
 					struct comprehension_tlv_iter *iter)
 {
 	struct stk_command_setup_event_list *obj =3D &command->setup_event_list;
-	gboolean ret;
 =

 	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
 		return FALSE;
@@ -2680,14 +2660,11 @@ static gboolean parse_setup_event_list(struct stk_c=
ommand *command,
 	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_TERMINAL)
 		return FALSE;
 =

-	ret =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_EVENT_LIST,
+	command->status =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_EVENT_LIST,
 				DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
 				&obj->event_list,
 				STK_DATA_OBJECT_TYPE_INVALID);
 =

-	if (ret =3D=3D FALSE)
-		return FALSE;
-
 	return TRUE;
 }
 =

@@ -2695,7 +2672,6 @@ static gboolean parse_perform_card_apdu(struct stk_co=
mmand *command,
 					struct comprehension_tlv_iter *iter)
 {
 	struct stk_command_perform_card_apdu *obj =3D &command->perform_card_apdu;
-	gboolean ret;
 =

 	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
 		return FALSE;
@@ -2704,14 +2680,11 @@ static gboolean parse_perform_card_apdu(struct stk_=
command *command,
 			(command->dst > STK_DEVICE_IDENTITY_TYPE_CARD_READER_7))
 		return FALSE;
 =

-	ret =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_C_APDU,
+	command->status =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_C_APDU,
 				DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
 				&obj->c_apdu,
 				STK_DATA_OBJECT_TYPE_INVALID);
 =

-	if (ret =3D=3D FALSE)
-		return FALSE;
-
 	return TRUE;
 }
 =

@@ -2769,7 +2742,6 @@ static gboolean parse_timer_mgmt(struct stk_command *=
command,
 					struct comprehension_tlv_iter *iter)
 {
 	struct stk_command_timer_mgmt *obj =3D &command->timer_mgmt;
-	gboolean ret;
 =

 	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
 		return FALSE;
@@ -2777,16 +2749,13 @@ static gboolean parse_timer_mgmt(struct stk_command=
 *command,
 	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_TERMINAL)
 		return FALSE;
 =

-	ret =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_TIMER_ID,
+	command->status =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_TIMER_ID,
 				DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
 				&obj->timer_id,
 				STK_DATA_OBJECT_TYPE_TIMER_VALUE, 0,
 				&obj->timer_value,
 				STK_DATA_OBJECT_TYPE_INVALID);
 =

-	if (ret =3D=3D FALSE)
-		return FALSE;
-
 	return TRUE;
 }
 =

@@ -2800,7 +2769,6 @@ static gboolean parse_setup_idle_mode_text(struct stk=
_command *command,
 {
 	struct stk_command_setup_idle_mode_text *obj =3D
 					&command->setup_idle_mode_text;
-	gboolean ret;
 =

 	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
 		return FALSE;
@@ -2808,7 +2776,7 @@ static gboolean parse_setup_idle_mode_text(struct stk=
_command *command,
 	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_TERMINAL)
 		return FALSE;
 =

-	ret =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_TEXT,
+	command->status =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_TEXT,
 				DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
 				&obj->text,
 				STK_DATA_OBJECT_TYPE_ICON_ID, 0,
@@ -2821,9 +2789,6 @@ static gboolean parse_setup_idle_mode_text(struct stk=
_command *command,
 =

 	command->destructor =3D destroy_setup_idle_mode_text;
 =

-	if (ret =3D=3D FALSE)
-		return FALSE;
-
 	return TRUE;
 }
 =

@@ -2837,7 +2802,6 @@ static gboolean parse_run_at_command(struct stk_comma=
nd *command,
 					struct comprehension_tlv_iter *iter)
 {
 	struct stk_command_run_at_command *obj =3D &command->run_at_command;
-	gboolean ret;
 =

 	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
 		return FALSE;
@@ -2845,7 +2809,8 @@ static gboolean parse_run_at_command(struct stk_comma=
nd *command,
 	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_TERMINAL)
 		return FALSE;
 =

-	ret =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_ALPHA_ID, 0,
+	command->status =3D parse_dataobj(iter,
+				STK_DATA_OBJECT_TYPE_ALPHA_ID, 0,
 				&obj->alpha_id,
 				STK_DATA_OBJECT_TYPE_AT_COMMAND,
 				DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
@@ -2860,9 +2825,6 @@ static gboolean parse_run_at_command(struct stk_comma=
nd *command,
 =

 	command->destructor =3D destroy_run_at_command;
 =

-	if (ret =3D=3D FALSE)
-		return FALSE;
-
 	return TRUE;
 }
 =

@@ -2876,7 +2838,6 @@ static gboolean parse_send_dtmf(struct stk_command *c=
ommand,
 					struct comprehension_tlv_iter *iter)
 {
 	struct stk_command_send_dtmf *obj =3D &command->send_dtmf;
-	gboolean ret;
 =

 	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
 		return FALSE;
@@ -2884,7 +2845,8 @@ static gboolean parse_send_dtmf(struct stk_command *c=
ommand,
 	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_NETWORK)
 		return FALSE;
 =

-	ret =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_ALPHA_ID, 0,
+	command->status =3D parse_dataobj(iter,
+				STK_DATA_OBJECT_TYPE_ALPHA_ID, 0,
 				&obj->alpha_id,
 				STK_DATA_OBJECT_TYPE_DTMF_STRING,
 				DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
@@ -2899,9 +2861,6 @@ static gboolean parse_send_dtmf(struct stk_command *c=
ommand,
 =

 	command->destructor =3D destroy_send_dtmf;
 =

-	if (ret =3D=3D FALSE)
-		return FALSE;
-
 	return TRUE;
 }
 =

@@ -2910,7 +2869,6 @@ static gboolean parse_language_notification(struct st=
k_command *command,
 {
 	struct stk_command_language_notification *obj =3D
 					&command->language_notification;
-	gboolean ret;
 =

 	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
 		return FALSE;
@@ -2918,13 +2876,10 @@ static gboolean parse_language_notification(struct =
stk_command *command,
 	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_TERMINAL)
 		return FALSE;
 =

-	ret =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_LANGUAGE, 0,
+	command->status =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_LANGUAGE, 0,
 				&obj->language,
 				STK_DATA_OBJECT_TYPE_INVALID);
 =

-	if (ret =3D=3D FALSE)
-		return FALSE;
-
 	return TRUE;
 }
 =

@@ -2946,7 +2901,6 @@ static gboolean parse_launch_browser(struct stk_comma=
nd *command,
 					struct comprehension_tlv_iter *iter)
 {
 	struct stk_command_launch_browser *obj =3D &command->launch_browser;
-	gboolean ret;
 =

 	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
 		return FALSE;
@@ -2954,7 +2908,7 @@ static gboolean parse_launch_browser(struct stk_comma=
nd *command,
 	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_TERMINAL)
 		return FALSE;
 =

-	ret =3D parse_dataobj(iter,
+	command->status =3D parse_dataobj(iter,
 				STK_DATA_OBJECT_TYPE_BROWSER_ID, 0,
 				&obj->browser_id,
 				STK_DATA_OBJECT_TYPE_URL,
@@ -2985,9 +2939,6 @@ static gboolean parse_launch_browser(struct stk_comma=
nd *command,
 =

 	command->destructor =3D destroy_launch_browser;
 =

-	if (ret =3D=3D FALSE)
-		return FALSE;
-
 	return TRUE;
 }
 =

@@ -3122,17 +3073,16 @@ struct stk_command *stk_command_new_from_pdu(const =
unsigned char *pdu,
 		ok =3D parse_launch_browser(command, &iter);
 		break;
 	default:
-		ok =3D FALSE;
-		break;
+		command->status =3D STK_PARSE_RESULT_TYPE_NOT_UNDERSTOOD;
+		return command;
 	};
 =

-	if (ok)
-		return command;
+	if (ok =3D=3D FALSE)
+		command->status =3D STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
 =

-fail:
-	if (command->destructor)
-		command->destructor(command);
+	return command;
 =

+fail:
 	g_free(command);
 =

 	return NULL;
diff --git a/src/stkutil.h b/src/stkutil.h
index f6a578a..0337f32 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -1166,12 +1166,20 @@ struct stk_command_launch_browser {
 	char *text_passwd;
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
index a3d7bde..3c70413 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -716,6 +716,7 @@ static void test_display_text(gconstpointer data)
 	command =3D stk_command_new_from_pdu(test->pdu, test->pdu_len);
 =

 	g_assert(command);
+	g_assert(command->status =3D=3D STK_PARSE_RESULT_OK);
 =

 	g_assert(command->number =3D=3D 1);
 	g_assert(command->type =3D=3D STK_COMMAND_TYPE_DISPLAY_TEXT);
@@ -1653,6 +1654,7 @@ static void test_get_inkey(gconstpointer data)
 	command =3D stk_command_new_from_pdu(test->pdu, test->pdu_len);
 =

 	g_assert(command);
+	g_assert(command->status =3D=3D STK_PARSE_RESULT_OK);
 =

 	g_assert(command->number =3D=3D 1);
 	g_assert(command->type =3D=3D STK_COMMAND_TYPE_GET_INKEY);
@@ -2958,6 +2960,7 @@ static void test_get_input(gconstpointer data)
 	command =3D stk_command_new_from_pdu(test->pdu, test->pdu_len);
 =

 	g_assert(command);
+	g_assert(command->status =3D=3D STK_PARSE_RESULT_OK);
 =

 	g_assert(command->number =3D=3D 1);
 	g_assert(command->type =3D=3D STK_COMMAND_TYPE_GET_INPUT);
@@ -3003,6 +3006,7 @@ static void test_more_time(gconstpointer data)
 	command =3D stk_command_new_from_pdu(test->pdu, test->pdu_len);
 =

 	g_assert(command);
+	g_assert(command->status =3D=3D STK_PARSE_RESULT_OK);
 =

 	g_assert(command->number =3D=3D 1);
 	g_assert(command->type =3D=3D STK_COMMAND_TYPE_MORE_TIME);
@@ -4238,6 +4242,7 @@ static void test_play_tone(gconstpointer data)
 	command =3D stk_command_new_from_pdu(test->pdu, test->pdu_len);
 =

 	g_assert(command);
+	g_assert(command->status =3D=3D STK_PARSE_RESULT_OK);
 =

 	g_assert(command->number =3D=3D 1);
 	g_assert(command->type =3D=3D STK_COMMAND_TYPE_PLAY_TONE);
@@ -4286,6 +4291,7 @@ static void test_poll_interval(gconstpointer data)
 	command =3D stk_command_new_from_pdu(test->pdu, test->pdu_len);
 =

 	g_assert(command);
+	g_assert(command->status =3D=3D STK_PARSE_RESULT_OK);
 =

 	g_assert(command->number =3D=3D 1);
 	g_assert(command->type =3D=3D STK_COMMAND_TYPE_POLL_INTERVAL);
@@ -5507,6 +5513,7 @@ static void test_setup_menu(gconstpointer data)
 	command =3D stk_command_new_from_pdu(test->pdu, test->pdu_len);
 =

 	g_assert(command);
+	g_assert(command->status =3D=3D STK_PARSE_RESULT_OK);
 =

 	g_assert(command->number =3D=3D 1);
 	g_assert(command->type =3D=3D STK_COMMAND_TYPE_SETUP_MENU);
@@ -5531,6 +5538,17 @@ static void test_setup_menu(gconstpointer data)
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
@@ -5538,7 +5556,8 @@ static void test_setup_menu_neg(gconstpointer data)
 =

 	command =3D stk_command_new_from_pdu(test->pdu, test->pdu_len);
 =

-	g_assert(!command);
+	g_assert(command);
+	g_assert(command->status =3D=3D STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD);
 }
 =

 struct select_item_test {
@@ -7091,6 +7110,7 @@ static void test_select_item(gconstpointer data)
 	command =3D stk_command_new_from_pdu(test->pdu, test->pdu_len);
 =

 	g_assert(command);
+	g_assert(command->status =3D=3D STK_PARSE_RESULT_OK);
 =

 	g_assert(command->number =3D=3D 1);
 	g_assert(command->type =3D=3D STK_COMMAND_TYPE_SELECT_ITEM);
@@ -8715,6 +8735,7 @@ static void test_send_sms(gconstpointer data)
 	command =3D stk_command_new_from_pdu(test->pdu, test->pdu_len);
 =

 	g_assert(command);
+	g_assert(command->status =3D=3D STK_PARSE_RESULT_OK);
 =

 	g_assert(command->number =3D=3D 1);
 	g_assert(command->type =3D=3D STK_COMMAND_TYPE_SEND_SMS);
@@ -9983,6 +10004,7 @@ static void test_setup_call(gconstpointer data)
 	command =3D stk_command_new_from_pdu(test->pdu, test->pdu_len);
 =

 	g_assert(command);
+	g_assert(command->status =3D=3D STK_PARSE_RESULT_OK);
 =

 	g_assert(command->number =3D=3D 1);
 	g_assert(command->type =3D=3D STK_COMMAND_TYPE_SETUP_CALL);
@@ -10057,6 +10079,7 @@ static void test_refresh(gconstpointer data)
 	command =3D stk_command_new_from_pdu(test->pdu, test->pdu_len);
 =

 	g_assert(command);
+	g_assert(command->status =3D=3D STK_PARSE_RESULT_OK);
 =

 	g_assert(command->number =3D=3D 1);
 	g_assert(command->type =3D=3D STK_COMMAND_TYPE_REFRESH);
@@ -10098,6 +10121,7 @@ static void test_polling_off(gconstpointer data)
 	command =3D stk_command_new_from_pdu(test->pdu, test->pdu_len);
 =

 	g_assert(command);
+	g_assert(command->status =3D=3D STK_PARSE_RESULT_OK);
 =

 	g_assert(command->number =3D=3D 1);
 	g_assert(command->type =3D=3D STK_COMMAND_TYPE_POLLING_OFF);
@@ -10183,6 +10207,7 @@ static void test_provide_local_info(gconstpointer d=
ata)
 	command =3D stk_command_new_from_pdu(test->pdu, test->pdu_len);
 =

 	g_assert(command);
+	g_assert(command->status =3D=3D STK_PARSE_RESULT_OK);
 =

 	g_assert(command->number =3D=3D 1);
 	g_assert(command->type =3D=3D STK_COMMAND_TYPE_PROVIDE_LOCAL_INFO);
@@ -10290,6 +10315,7 @@ static void test_setup_event_list(gconstpointer dat=
a)
 	command =3D stk_command_new_from_pdu(test->pdu, test->pdu_len);
 =

 	g_assert(command);
+	g_assert(command->status =3D=3D STK_PARSE_RESULT_OK);
 =

 	g_assert(command->number =3D=3D 1);
 	g_assert(command->type =3D=3D STK_COMMAND_TYPE_SETUP_EVENT_LIST);
@@ -10515,6 +10541,7 @@ static void test_perform_card_apdu(gconstpointer da=
ta)
 	command =3D stk_command_new_from_pdu(test->pdu, test->pdu_len);
 =

 	g_assert(command);
+	g_assert(command->status =3D=3D STK_PARSE_RESULT_OK);
 =

 	g_assert(command->number =3D=3D 1);
 	g_assert(command->type =3D=3D STK_COMMAND_TYPE_PERFORM_CARD_APDU);
@@ -10552,6 +10579,7 @@ static void test_get_reader_status(gconstpointer da=
ta)
 	command =3D stk_command_new_from_pdu(test->pdu, test->pdu_len);
 =

 	g_assert(command);
+	g_assert(command->status =3D=3D STK_PARSE_RESULT_OK);
 =

 	g_assert(command->number =3D=3D 1);
 	g_assert(command->type =3D=3D STK_COMMAND_TYPE_GET_READER_STATUS);
@@ -11072,6 +11100,7 @@ static void test_timer_mgmt(gconstpointer data)
 	command =3D stk_command_new_from_pdu(test->pdu, test->pdu_len);
 =

 	g_assert(command);
+	g_assert(command->status =3D=3D STK_PARSE_RESULT_OK);
 =

 	g_assert(command->number =3D=3D 1);
 	g_assert(command->type =3D=3D STK_COMMAND_TYPE_TIMER_MANAGEMENT);
@@ -11786,6 +11815,7 @@ static void test_setup_idle_mode_text(gconstpointer=
 data)
 	command =3D stk_command_new_from_pdu(test->pdu, test->pdu_len);
 =

 	g_assert(command);
+	g_assert(command->status =3D=3D STK_PARSE_RESULT_OK);
 =

 	g_assert(command->number =3D=3D 1);
 	g_assert(command->type =3D=3D STK_COMMAND_TYPE_SETUP_IDLE_MODE_TEXT);
@@ -12540,6 +12570,7 @@ static void test_run_at_command(gconstpointer data)
 	command =3D stk_command_new_from_pdu(test->pdu, test->pdu_len);
 =

 	g_assert(command);
+	g_assert(command->status =3D=3D STK_PARSE_RESULT_OK);
 =

 	g_assert(command->number =3D=3D 1);
 	g_assert(command->type =3D=3D STK_COMMAND_TYPE_RUN_AT_COMMAND);
@@ -13205,6 +13236,7 @@ static void test_send_dtmf(gconstpointer data)
 	command =3D stk_command_new_from_pdu(test->pdu, test->pdu_len);
 =

 	g_assert(command);
+	g_assert(command->status =3D=3D STK_PARSE_RESULT_OK);
 =

 	g_assert(command->number =3D=3D 1);
 	g_assert(command->type =3D=3D STK_COMMAND_TYPE_SEND_DTMF);
@@ -13259,6 +13291,7 @@ static void test_language_notification(gconstpointe=
r data)
 	command =3D stk_command_new_from_pdu(test->pdu, test->pdu_len);
 =

 	g_assert(command);
+	g_assert(command->status =3D=3D STK_PARSE_RESULT_OK);
 =

 	g_assert(command->number =3D=3D 1);
 	g_assert(command->type =3D=3D STK_COMMAND_TYPE_LANGUAGE_NOTIFICATION);
@@ -13917,6 +13950,7 @@ static void test_launch_browser(gconstpointer data)
 	command =3D stk_command_new_from_pdu(test->pdu, test->pdu_len);
 =

 	g_assert(command);
+	g_assert(command->status =3D=3D STK_PARSE_RESULT_OK);
 =

 	g_assert(command->number =3D=3D 1);
 	g_assert(command->type =3D=3D STK_COMMAND_TYPE_LAUNCH_BROWSER);
@@ -20251,7 +20285,7 @@ int main(int argc, char **argv)
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


--===============7591387887389423070==--

