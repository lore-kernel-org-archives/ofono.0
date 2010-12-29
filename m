Content-Type: multipart/mixed; boundary="===============1548186584467765046=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [RFC 2/2] stk: add missing text and icon case handling
Date: Wed, 29 Dec 2010 15:16:40 +0200
Message-ID: <1293628600-8684-3-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1293628600-8684-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1548186584467765046==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

As per the ETSI TS 102 223 section 6.5.4,
If the terminal receives an icon, and either
an empty or no alpha identifier/text string
is given by the UICC, than the terminal shall
reject the command with general result
"Command data not understood by terminal".
---
 src/stk.c |  114 ++++++++++++++++++++++++++++++++++++++++++---------------=
----
 1 files changed, 79 insertions(+), 35 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index bec46ea..e3236c1 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -316,6 +316,20 @@ static char *dbus_apply_text_attributes(const char *te=
xt,
 	return stk_text_to_html(text, buf, attr->len / 4);
 }
 =

+static gboolean check_text( const char *in, const unsigned char icon_id,
+				const struct stk_text_attribute *attr,
+				char **out)
+{
+	if ((in =3D=3D NULL || strlen(in) < 1) && icon_id !=3D 0)
+		return FALSE;
+
+	*out =3D dbus_apply_text_attributes(in ? in : "", attr);
+	if (*out =3D=3D NULL)
+		return FALSE;
+
+	return TRUE;
+}
+
 static struct stk_menu *stk_menu_create(const char *title,
 		const struct stk_text_attribute *title_attr,
 		const struct stk_icon_id *icon, GSList *items,
@@ -341,10 +355,8 @@ static struct stk_menu *stk_menu_create(const char *ti=
tle,
 	if (ret =3D=3D NULL)
 		return NULL;
 =

-	ret->title =3D dbus_apply_text_attributes(title ? title : "",
-						title_attr);
-	if (ret->title =3D=3D NULL)
-		ret->title =3D g_strdup(title ? title : "");
+	if (check_text(title, icon->id, title_attr, &ret->title) =3D=3D FALSE)
+		return NULL;
 =

 	memcpy(&ret->icon, icon, sizeof(ret->icon));
 	ret->items =3D g_new0(struct stk_menu_item, len + 1);
@@ -841,6 +853,15 @@ static gboolean handle_command_send_sms(const struct s=
tk_command *cmd,
 	struct ofono_sms *sms;
 	GSList msg_list;
 	struct ofono_uuid uuid;
+	char *text;
+
+	if (check_text(cmd->send_sms.alpha_id, cmd->send_sms.icon_id.id,
+			&cmd->send_sms.text_attr, &text) =3D=3D FALSE) {
+		rsp->result.type =3D STK_RESULT_TYPE_DATA_NOT_UNDERSTOOD;
+		return TRUE;
+	}
+
+	g_free(text);
 =

 	sms_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_SMS);
 =

@@ -880,11 +901,10 @@ static gboolean handle_command_set_idle_text(const st=
ruct stk_command *cmd,
 	const char *path =3D __ofono_atom_get_path(stk->atom);
 	char *idle_mode_text;
 =

-	idle_mode_text =3D dbus_apply_text_attributes(
-					cmd->setup_idle_mode_text.text,
-					&cmd->setup_idle_mode_text.text_attr);
-
-	if (idle_mode_text =3D=3D NULL) {
+	if (check_text(cmd->setup_idle_mode_text.text,
+			cmd->setup_idle_mode_text.icon_id.id,
+			&cmd->setup_idle_mode_text.text_attr,
+			&idle_mode_text) =3D=3D FALSE) {
 		rsp->result.type =3D STK_RESULT_TYPE_DATA_NOT_UNDERSTOOD;
 		return TRUE;
 	}
@@ -1280,10 +1300,11 @@ static gboolean handle_command_display_text(const s=
truct stk_command *cmd,
 	struct stk_command_display_text *dt =3D &stk->pending_cmd->display_text;
 	uint8_t qualifier =3D stk->pending_cmd->qualifier;
 	ofono_bool_t priority =3D (qualifier & (1 << 0)) !=3D 0;
-	char *text =3D dbus_apply_text_attributes(dt->text, &dt->text_attr);
+	char *text;
 	int err;
 =

-	if (text =3D=3D NULL) {
+	if (check_text(dt->text, dt->icon_id.id, &dt->text_attr,
+			&text) =3D=3D FALSE) {
 		rsp->result.type =3D STK_RESULT_TYPE_DATA_NOT_UNDERSTOOD;
 		return TRUE;
 	}
@@ -1436,7 +1457,7 @@ static gboolean handle_command_get_inkey(const struct=
 stk_command *cmd,
 {
 	int timeout =3D stk->timeout * 1000;
 	const struct stk_command_get_inkey *gi =3D &cmd->get_inkey;
-	char *text =3D dbus_apply_text_attributes(gi->text, &gi->text_attr);
+	char *text;
 	uint8_t qualifier =3D stk->pending_cmd->qualifier;
 	gboolean alphabet =3D (qualifier & (1 << 0)) !=3D 0;
 	gboolean ucs2 =3D (qualifier & (1 << 1)) !=3D 0;
@@ -1447,7 +1468,8 @@ static gboolean handle_command_get_inkey(const struct=
 stk_command *cmd,
 	 */
 	int err;
 =

-	if (text =3D=3D NULL) {
+	if (check_text(gi->text, gi->icon_id.id, &gi->text_attr,
+			&text) =3D=3D FALSE) {
 		rsp->result.type =3D STK_RESULT_TYPE_DATA_NOT_UNDERSTOOD;
 		return TRUE;
 	}
@@ -1534,14 +1556,15 @@ static gboolean handle_command_get_input(const stru=
ct stk_command *cmd,
 {
 	int timeout =3D stk->timeout * 1000;
 	const struct stk_command_get_input *gi =3D &cmd->get_input;
-	char *text =3D dbus_apply_text_attributes(gi->text, &gi->text_attr);
+	char *text;
 	uint8_t qualifier =3D stk->pending_cmd->qualifier;
 	gboolean alphabet =3D (qualifier & (1 << 0)) !=3D 0;
 	gboolean ucs2 =3D (qualifier & (1 << 1)) !=3D 0;
 	gboolean hidden =3D (qualifier & (1 << 2)) !=3D 0;
 	int err;
 =

-	if (text =3D=3D NULL) {
+	if (check_text(gi->text, gi->icon_id.id, &gi->text_attr,
+			&text) =3D=3D FALSE) {
 		rsp->result.type =3D STK_RESULT_TYPE_DATA_NOT_UNDERSTOOD;
 		return TRUE;
 	}
@@ -1664,14 +1687,10 @@ static void confirm_call_cb(enum stk_agent_result r=
esult, gboolean confirm,
 		return;
 	}
 =

-	if (sc->alpha_id_call_setup) {
-		alpha_id =3D dbus_apply_text_attributes(sc->alpha_id_call_setup,
-						&sc->text_attr_call_setup);
-		if (alpha_id =3D=3D NULL) {
-			send_simple_response(stk,
-					STK_RESULT_TYPE_DATA_NOT_UNDERSTOOD);
-			return;
-		}
+	if (check_text(sc->alpha_id_call_setup, sc->icon_id_call_setup.id,
+			&sc->text_attr_call_setup, &alpha_id) =3D=3D FALSE) {
+		send_simple_response(stk, STK_RESULT_TYPE_DATA_NOT_UNDERSTOOD);
+		return;
 	}
 =

 	err =3D __ofono_voicecall_dial(vc, sc->addr.number, sc->addr.ton_npi,
@@ -1722,7 +1741,8 @@ static gboolean handle_command_set_up_call(const stru=
ct stk_command *cmd,
 	const struct stk_command_setup_call *sc =3D &cmd->setup_call;
 	uint8_t qualifier =3D cmd->qualifier;
 	static unsigned char busy_on_call_result[] =3D { 0x02 };
-	char *alpha_id =3D NULL;
+	char *alpha_id_usr_cfm;
+	char *alpha_id_cs;
 	struct ofono_voicecall *vc =3D NULL;
 	struct ofono_atom *vc_atom;
 	int err;
@@ -1758,18 +1778,25 @@ static gboolean handle_command_set_up_call(const st=
ruct stk_command *cmd,
 		return TRUE;
 	}
 =

-	alpha_id =3D dbus_apply_text_attributes(sc->alpha_id_usr_cfm ?
-						sc->alpha_id_usr_cfm : "",
-						&sc->text_attr_usr_cfm);
-	if (alpha_id =3D=3D NULL) {
+	if (check_text(sc->alpha_id_call_setup, sc->icon_id_call_setup.id,
+			&sc->text_attr_call_setup, &alpha_id_cs) =3D=3D FALSE) {
 		rsp->result.type =3D STK_RESULT_TYPE_DATA_NOT_UNDERSTOOD;
 		return TRUE;
 	}
 =

-	err =3D stk_agent_confirm_call(stk->current_agent, alpha_id,
-					&sc->icon_id_usr_cfm, confirm_call_cb,
-					stk, NULL, stk->timeout * 1000);
-	g_free(alpha_id);
+	g_free(alpha_id_cs);
+
+	if (check_text(sc->alpha_id_usr_cfm, sc->icon_id_usr_cfm.id,
+			&sc->text_attr_usr_cfm, &alpha_id_usr_cfm) =3D=3D FALSE) {
+		rsp->result.type =3D STK_RESULT_TYPE_DATA_NOT_UNDERSTOOD;
+		return TRUE;
+	}
+
+	err =3D stk_agent_confirm_call(stk->current_agent, alpha_id_usr_cfm,
+			&sc->icon_id_usr_cfm, confirm_call_cb,
+			stk, NULL, stk->timeout * 1000);
+
+	g_free(alpha_id_usr_cfm);
 =

 	if (err < 0) {
 		/*
@@ -1956,9 +1983,18 @@ static gboolean handle_command_refresh(const struct =
stk_command *cmd,
 					struct ofono_stk *stk)
 {
 	GSList *l;
+	char *alpha_id;
 =

 	DBG("");
 =

+	if (check_text(cmd->refresh.alpha_id, cmd->refresh.icon_id.id,
+			&cmd->refresh.text_attr, &alpha_id) =3D=3D FALSE) {
+		rsp->result.type =3D STK_RESULT_TYPE_DATA_NOT_UNDERSTOOD;
+		return TRUE;
+	}
+
+	g_free(alpha_id);
+
 	switch (cmd->qualifier) {
 	case 0:
 		DBG("NAA Initialization and "
@@ -2144,6 +2180,15 @@ static gboolean handle_command_send_dtmf(const struc=
t stk_command *cmd,
 	char *dtmf_from =3D "01234567890abcABC";
 	char *dtmf_to =3D "01234567890*#p*#p";
 	int err, pos;
+	char *alpha_id;
+
+	if (check_text(cmd->send_dtmf.alpha_id, cmd->send_dtmf.icon_id.id,
+			&cmd->send_dtmf.text_attr, &alpha_id) =3D=3D FALSE) {
+		rsp->result.type =3D STK_RESULT_TYPE_DATA_NOT_UNDERSTOOD;
+		return TRUE;
+	}
+
+	g_free(alpha_id);
 =

 	vc_atom =3D __ofono_modem_find_atom(__ofono_atom_get_modem(stk->atom),
 						OFONO_ATOM_TYPE_VOICECALL);
@@ -2299,9 +2344,8 @@ static gboolean handle_command_play_tone(const struct=
 stk_command *cmd,
 		return TRUE;
 	}
 =

-	text =3D dbus_apply_text_attributes(pt->alpha_id ? pt->alpha_id : "",
-						&pt->text_attr);
-	if (text =3D=3D NULL) {
+	if (check_text(pt->alpha_id, pt->icon_id.id, &pt->text_attr,
+			&text) =3D=3D FALSE) {
 		rsp->result.type =3D STK_RESULT_TYPE_DATA_NOT_UNDERSTOOD;
 =

 		return TRUE;
-- =

1.7.0.4


--===============1548186584467765046==--

