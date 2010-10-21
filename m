Content-Type: multipart/mixed; boundary="===============8508191588403270178=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 4/4] stk: Apply STK text attributes as html.
Date: Thu, 21 Oct 2010 07:09:08 +0200
Message-ID: <1287637748-7230-4-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1287637748-7230-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8508191588403270178==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c |  148 ++++++++++++++++++++++++++++++++++++++++++++++++++-------=
---
 1 files changed, 123 insertions(+), 25 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index d42a05f..7a43264 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -257,6 +257,22 @@ void __ofono_cbs_sim_download(struct ofono_stk *stk, c=
onst struct cbs *msg)
 		stk_cbs_download_cb(stk, FALSE, NULL, -1);
 }
 =

+static char *dbus_apply_text_attributes(const char *text,
+					const struct stk_text_attribute *attr)
+{
+	uint16_t buf[256], *i =3D buf;
+	const uint8_t *j =3D attr->attributes;
+	const uint8_t *end =3D j + attr->len;
+
+	if (attr->len & 3)
+		return NULL;
+
+	while (j < end)
+		*i++ =3D *j++;
+
+	return stk_text_to_html(text, buf, attr->len / 4);
+}
+
 static struct stk_menu *stk_menu_create(const char *title,
 		const struct stk_text_attribute *title_attr,
 		const struct stk_icon_id *icon, GSList *items,
@@ -268,6 +284,7 @@ static struct stk_menu *stk_menu_create(const char *tit=
le,
 	struct stk_menu *ret;
 	GSList *l;
 	int i;
+	struct stk_text_attribute attr;
 =

 	DBG("");
 =

@@ -281,7 +298,11 @@ static struct stk_menu *stk_menu_create(const char *ti=
tle,
 	if (ret =3D=3D NULL)
 		return NULL;
 =

-	ret->title =3D g_strdup(title ? title : "");
+	ret->title =3D dbus_apply_text_attributes(title ? title : "",
+						title_attr);
+	if (!ret->title)
+		ret->title =3D g_strdup(title ? title : "");
+
 	memcpy(&ret->icon, icon, sizeof(ret->icon));
 	ret->items =3D g_new0(struct stk_menu_item, len + 1);
 	ret->default_item =3D -1;
@@ -290,10 +311,21 @@ static struct stk_menu *stk_menu_create(const char *t=
itle,
 =

 	for (l =3D items, i =3D 0; l; l =3D l->next, i++) {
 		struct stk_item *item =3D l->data;
+		char *text;
 =

-		ret->items[i].text =3D g_strdup(item->text);
 		ret->items[i].item_id =3D item->id;
 =

+		text =3D NULL;
+		if (item_attrs && item_attrs->len) {
+			memcpy(attr.attributes, &item_attrs->list[i * 4], 4);
+			attr.len =3D 4;
+
+			text =3D dbus_apply_text_attributes(item->text, &attr);
+		}
+		if (!text)
+			text =3D strdup(item->text);
+		ret->items[i].text =3D text;
+
 		if (item_icon_ids && item_icon_ids->len)
 			ret->items[i].icon_id =3D item_icon_ids->list[i];
 =

@@ -390,7 +422,8 @@ static void emit_menu_changed(struct ofono_stk *stk)
 	g_dbus_send_message(conn, signal);
 }
 =

-static void stk_alpha_id_set(struct ofono_stk *stk, const char *text,
+static void stk_alpha_id_set(struct ofono_stk *stk,
+		const char *text, const struct stk_text_attribute *attr,
 		const struct stk_icon_id *icon)
 {
 	/* TODO */
@@ -762,7 +795,8 @@ static gboolean handle_command_send_sms(const struct st=
k_command *cmd,
 =

 	stk->cancel_cmd =3D send_sms_cancel;
 =

-	stk_alpha_id_set(stk, cmd->send_sms.alpha_id, &cmd->send_sms.icon_id);
+	stk_alpha_id_set(stk, cmd->send_sms.alpha_id, &cmd->send_sms.text_attr,
+				&cmd->send_sms.icon_id);
 =

 	return FALSE;
 }
@@ -773,17 +807,26 @@ static gboolean handle_command_set_idle_text(const st=
ruct stk_command *cmd,
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
 	const char *path =3D __ofono_atom_get_path(stk->atom);
-	const char *idle_mode_text;
+	char *idle_mode_text =3D NULL;
 =

-	if (stk->idle_mode_text) {
-		g_free(stk->idle_mode_text);
-		stk->idle_mode_text =3D NULL;
+	if (cmd->setup_idle_mode_text.text) {
+		idle_mode_text =3D dbus_apply_text_attributes(
+					cmd->setup_idle_mode_text.text,
+					&cmd->setup_idle_mode_text.text_attr);
+
+		if (!idle_mode_text) {
+			rsp->result.type =3D STK_RESULT_TYPE_DATA_NOT_UNDERSTOOD;
+
+			return TRUE;
+		}
 	}
 =

-	if (cmd->setup_idle_mode_text.text)
-		stk->idle_mode_text =3D g_strdup(cmd->setup_idle_mode_text.text);
+	if (stk->idle_mode_text)
+		g_free(stk->idle_mode_text);
 =

-	idle_mode_text =3D stk->idle_mode_text ? stk->idle_mode_text : "";
+	stk->idle_mode_text =3D idle_mode_text;
+
+	idle_mode_text =3D idle_mode_text ? idle_mode_text : "";
 	ofono_dbus_signal_property_changed(conn, path, OFONO_STK_INTERFACE,
 						"IdleModeText",
 						DBUS_TYPE_STRING,
@@ -1166,6 +1209,14 @@ static gboolean handle_command_display_text(const st=
ruct stk_command *cmd,
 	struct stk_command_display_text *dt =3D &stk->pending_cmd->display_text;
 	uint8_t qualifier =3D stk->pending_cmd->qualifier;
 	ofono_bool_t priority =3D (qualifier & (1 << 0)) !=3D 0;
+	char *text =3D dbus_apply_text_attributes(dt->text, &dt->text_attr);
+	int err;
+
+	if (!text) {
+		rsp->result.type =3D STK_RESULT_TYPE_DATA_NOT_UNDERSTOOD;
+
+		return TRUE;
+	}
 =

 	if (dt->duration.interval) {
 		timeout =3D dt->duration.interval;
@@ -1179,10 +1230,13 @@ static gboolean handle_command_display_text(const s=
truct stk_command *cmd,
 		}
 	}
 =

-	/* We most likely got an out of memory error, tell SIM to retry */
-	if (stk_agent_display_text(stk->current_agent, dt->text, &dt->icon_id,
+	err =3D stk_agent_display_text(stk->current_agent, text, &dt->icon_id,
 					priority, display_text_cb, stk,
-					display_text_destroy, timeout) < 0) {
+					display_text_destroy, timeout);
+	g_free(text);
+
+	/* We most likely got an out of memory error, tell SIM to retry */
+	if (err < 0) {
 		rsp->result.type =3D STK_RESULT_TYPE_TERMINAL_BUSY;
 		return TRUE;
 	}
@@ -1316,6 +1370,7 @@ static gboolean handle_command_get_inkey(const struct=
 stk_command *cmd,
 {
 	int timeout =3D stk->timeout * 1000;
 	const struct stk_command_get_inkey *gi =3D &cmd->get_inkey;
+	char *text =3D dbus_apply_text_attributes(gi->text, &gi->text_attr);
 	uint8_t qualifier =3D stk->pending_cmd->qualifier;
 	gboolean alphabet =3D (qualifier & (1 << 0)) !=3D 0;
 	gboolean ucs2 =3D (qualifier & (1 << 1)) !=3D 0;
@@ -1326,6 +1381,12 @@ static gboolean handle_command_get_inkey(const struc=
t stk_command *cmd,
 	 */
 	int err;
 =

+	if (!text) {
+		rsp->result.type =3D STK_RESULT_TYPE_DATA_NOT_UNDERSTOOD;
+
+		return TRUE;
+	}
+
 	if (gi->duration.interval) {
 		timeout =3D gi->duration.interval;
 		switch (gi->duration.unit) {
@@ -1342,18 +1403,19 @@ static gboolean handle_command_get_inkey(const stru=
ct stk_command *cmd,
 =

 	if (yesno)
 		err =3D stk_agent_request_confirmation(stk->current_agent,
-							gi->text, &gi->icon_id,
+							text, &gi->icon_id,
 							request_confirmation_cb,
 							stk, NULL, timeout);
 	else if (alphabet)
-		err =3D stk_agent_request_key(stk->current_agent, gi->text,
+		err =3D stk_agent_request_key(stk->current_agent, text,
 						&gi->icon_id, ucs2,
 						request_key_cb, stk, NULL,
 						timeout);
 	else
-		err =3D stk_agent_request_digit(stk->current_agent, gi->text,
+		err =3D stk_agent_request_digit(stk->current_agent, text,
 						&gi->icon_id, request_key_cb,
 						stk, NULL, timeout);
+	g_free(text);
 =

 	if (err < 0) {
 		/*
@@ -1414,26 +1476,34 @@ static gboolean handle_command_get_input(const stru=
ct stk_command *cmd,
 {
 	int timeout =3D stk->timeout * 1000;
 	const struct stk_command_get_input *gi =3D &cmd->get_input;
+	char *text =3D dbus_apply_text_attributes(gi->text, &gi->text_attr);
 	uint8_t qualifier =3D stk->pending_cmd->qualifier;
 	gboolean alphabet =3D (qualifier & (1 << 0)) !=3D 0;
 	gboolean ucs2 =3D (qualifier & (1 << 1)) !=3D 0;
 	gboolean hidden =3D (qualifier & (1 << 2)) !=3D 0;
 	int err;
 =

+	if (!text) {
+		rsp->result.type =3D STK_RESULT_TYPE_DATA_NOT_UNDERSTOOD;
+
+		return TRUE;
+	}
+
 	if (alphabet)
-		err =3D stk_agent_request_input(stk->current_agent, gi->text,
+		err =3D stk_agent_request_input(stk->current_agent, text,
 						&gi->icon_id, gi->default_text,
 						ucs2, gi->resp_len.min,
 						gi->resp_len.max, hidden,
 						request_string_cb,
 						stk, NULL, timeout);
 	else
-		err =3D stk_agent_request_digits(stk->current_agent, gi->text,
+		err =3D stk_agent_request_digits(stk->current_agent, text,
 						&gi->icon_id, gi->default_text,
 						gi->resp_len.min,
 						gi->resp_len.max, hidden,
 						request_string_cb,
 						stk, NULL, timeout);
+	g_free(text);
 =

 	if (err < 0) {
 		/*
@@ -1500,6 +1570,7 @@ static void confirm_call_cb(enum stk_agent_result res=
ult, gboolean confirm,
 	uint8_t qualifier =3D stk->pending_cmd->qualifier;
 	static unsigned char busy_on_call_result[] =3D { 0x02 };
 	static unsigned char no_cause_result[] =3D { 0x00 };
+	char *alpha_id =3D NULL;
 	struct ofono_voicecall *vc =3D NULL;
 	struct ofono_atom *vc_atom;
 	struct stk_response rsp;
@@ -1535,11 +1606,22 @@ static void confirm_call_cb(enum stk_agent_result r=
esult, gboolean confirm,
 		return;
 	}
 =

+	if (sc->alpha_id_call_setup) {
+		alpha_id =3D dbus_apply_text_attributes(sc->alpha_id_call_setup,
+						&sc->text_attr_call_setup);
+		if (!alpha_id) {
+			send_simple_response(stk,
+					STK_RESULT_TYPE_DATA_NOT_UNDERSTOOD);
+			return;
+		}
+	}
+
 	err =3D __ofono_voicecall_dial(vc, sc->addr.number, sc->addr.ton_npi,
-					sc->alpha_id_call_setup,
-					sc->icon_id_call_setup.id,
+					alpha_id, sc->icon_id_call_setup.id,
 					qualifier >> 1, call_setup_connected,
 					stk);
+	g_free(alpha_id);
+
 	if (err >=3D 0) {
 		stk->cancel_cmd =3D call_setup_cancel;
 =

@@ -1582,6 +1664,7 @@ static gboolean handle_command_set_up_call(const stru=
ct stk_command *cmd,
 	const struct stk_command_setup_call *sc =3D &cmd->setup_call;
 	uint8_t qualifier =3D cmd->qualifier;
 	static unsigned char busy_on_call_result[] =3D { 0x02 };
+	char *alpha_id =3D NULL;
 	struct ofono_voicecall *vc =3D NULL;
 	struct ofono_atom *vc_atom;
 	int err;
@@ -1617,9 +1700,19 @@ static gboolean handle_command_set_up_call(const str=
uct stk_command *cmd,
 		return TRUE;
 	}
 =

-	err =3D stk_agent_confirm_call(stk->current_agent, sc->alpha_id_usr_cfm,
+	if (sc->alpha_id_usr_cfm) {
+		alpha_id =3D dbus_apply_text_attributes(sc->alpha_id_usr_cfm,
+							&sc->text_attr_usr_cfm);
+		if (!alpha_id) {
+			rsp->result.type =3D STK_RESULT_TYPE_DATA_NOT_UNDERSTOOD;
+			return TRUE;
+		}
+	}
+
+	err =3D stk_agent_confirm_call(stk->current_agent, alpha_id,
 					&sc->icon_id_usr_cfm, confirm_call_cb,
 					stk, NULL, stk->timeout * 1000);
+	g_free(alpha_id);
 =

 	if (err < 0) {
 		/*
@@ -1794,7 +1887,9 @@ static gboolean handle_command_send_ussd(const struct=
 stk_command *cmd,
 		return TRUE;
 	}
 =

-	stk_alpha_id_set(stk, cmd->send_ussd.alpha_id, &cmd->send_ussd.icon_id);
+	stk_alpha_id_set(stk, cmd->send_ussd.alpha_id,
+				&cmd->send_ussd.text_attr,
+				&cmd->send_ussd.icon_id);
 =

 	return FALSE;
 }
@@ -1974,7 +2069,9 @@ static gboolean handle_command_send_dtmf(const struct=
 stk_command *cmd,
 		return TRUE;
 	}
 =

-	stk_alpha_id_set(stk, cmd->send_dtmf.alpha_id, &cmd->send_dtmf.icon_id);
+	stk_alpha_id_set(stk, cmd->send_dtmf.alpha_id,
+				&cmd->send_dtmf.text_attr,
+				&cmd->send_dtmf.icon_id);
 =

 	/*
 	 * Note that we don't strictly require an agent to be connected,
@@ -2204,7 +2301,8 @@ void ofono_stk_proactive_command_handled_notify(struc=
t ofono_stk *stk,
 =

 	case STK_COMMAND_TYPE_SEND_SMS:
 		stk_alpha_id_set(stk, cmd->send_sms.alpha_id,
-					&cmd->send_sms.icon_id);
+				&cmd->send_sms.text_attr,
+				&cmd->send_sms.icon_id);
 		break;
 	}
 =

-- =

1.7.1.86.g0e460.dirty


--===============8508191588403270178==--

