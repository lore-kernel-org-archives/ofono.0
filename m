Content-Type: multipart/mixed; boundary="===============1988666309522865588=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 2/3] stk: fix issue with null text string
Date: Thu, 16 Dec 2010 13:20:17 -0800
Message-ID: <1292534418-13351-3-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1292534418-13351-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1988666309522865588==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c |   42 ++++++++++++++++++++++++++++++++----------
 1 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index 87208d1..a107403 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -875,11 +875,17 @@ static gboolean handle_command_set_idle_text(const st=
ruct stk_command *cmd,
 	const char *path =3D __ofono_atom_get_path(stk->atom);
 	char *idle_mode_text;
 =

+	if (cmd->setup_idle_mode_text.text =3D=3D NULL &&
+			cmd->setup_idle_mode_text.icon_id.id !=3D 0) {
+		rsp->result.type =3D STK_RESULT_TYPE_DATA_NOT_UNDERSTOOD;
+		return TRUE;
+	}
+
 	idle_mode_text =3D dbus_apply_text_attributes(
 					cmd->setup_idle_mode_text.text,
 					&cmd->setup_idle_mode_text.text_attr);
 =

-	if (idle_mode_text =3D=3D NULL) {
+	if (cmd->setup_idle_mode_text.text && idle_mode_text =3D=3D NULL) {
 		rsp->result.type =3D STK_RESULT_TYPE_DATA_NOT_UNDERSTOOD;
 		return TRUE;
 	}
@@ -889,6 +895,7 @@ static gboolean handle_command_set_idle_text(const stru=
ct stk_command *cmd,
 =

 	stk->idle_mode_text =3D idle_mode_text;
 =

+	idle_mode_text =3D idle_mode_text ? idle_mode_text : "";
 	ofono_dbus_signal_property_changed(conn, path, OFONO_STK_INTERFACE,
 						"IdleModeText",
 						DBUS_TYPE_STRING,
@@ -1275,10 +1282,17 @@ static gboolean handle_command_display_text(const s=
truct stk_command *cmd,
 	struct stk_command_display_text *dt =3D &stk->pending_cmd->display_text;
 	uint8_t qualifier =3D stk->pending_cmd->qualifier;
 	ofono_bool_t priority =3D (qualifier & (1 << 0)) !=3D 0;
-	char *text =3D dbus_apply_text_attributes(dt->text, &dt->text_attr);
+	char *text;
 	int err;
 =

-	if (text =3D=3D NULL) {
+	if (dt->text =3D=3D NULL && dt->icon_id.id !=3D 0) {
+		rsp->result.type =3D STK_RESULT_TYPE_DATA_NOT_UNDERSTOOD;
+		return TRUE;
+	}
+
+	text =3D dt->text ? dbus_apply_text_attributes(dt->text, &dt->text_attr) =
: "";
+
+	if (dt->text && text =3D=3D NULL) {
 		rsp->result.type =3D STK_RESULT_TYPE_DATA_NOT_UNDERSTOOD;
 		return TRUE;
 	}
@@ -1292,7 +1306,9 @@ static gboolean handle_command_display_text(const str=
uct stk_command *cmd,
 	err =3D stk_agent_display_text(stk->current_agent, text, &dt->icon_id,
 					priority, display_text_cb, stk,
 					display_text_destroy, timeout);
-	g_free(text);
+
+	if (dt->text)
+		g_free(text);
 =

 	/* We most likely got an out of memory error, tell SIM to retry */
 	if (err < 0) {
@@ -1431,7 +1447,7 @@ static gboolean handle_command_get_inkey(const struct=
 stk_command *cmd,
 {
 	int timeout =3D stk->timeout * 1000;
 	const struct stk_command_get_inkey *gi =3D &cmd->get_inkey;
-	char *text =3D dbus_apply_text_attributes(gi->text, &gi->text_attr);
+	char *text;
 	uint8_t qualifier =3D stk->pending_cmd->qualifier;
 	gboolean alphabet =3D (qualifier & (1 << 0)) !=3D 0;
 	gboolean ucs2 =3D (qualifier & (1 << 1)) !=3D 0;
@@ -1442,7 +1458,9 @@ static gboolean handle_command_get_inkey(const struct=
 stk_command *cmd,
 	 */
 	int err;
 =

-	if (text =3D=3D NULL) {
+	text =3D gi->text ? dbus_apply_text_attributes(gi->text, &gi->text_attr) =
: "";
+
+	if (gi->text && text =3D=3D NULL) {
 		rsp->result.type =3D STK_RESULT_TYPE_DATA_NOT_UNDERSTOOD;
 		return TRUE;
 	}
@@ -1467,7 +1485,8 @@ static gboolean handle_command_get_inkey(const struct=
 stk_command *cmd,
 						&gi->icon_id, request_key_cb,
 						stk, NULL, timeout);
 =

-	g_free(text);
+	if (gi->text)
+		g_free(text);
 =

 	if (err < 0) {
 		/*
@@ -1529,14 +1548,16 @@ static gboolean handle_command_get_input(const stru=
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
+	text =3D gi->text ? dbus_apply_text_attributes(gi->text, &gi->text_attr) =
: "";
+
+	if (gi->text && text =3D=3D NULL) {
 		rsp->result.type =3D STK_RESULT_TYPE_DATA_NOT_UNDERSTOOD;
 		return TRUE;
 	}
@@ -1556,7 +1577,8 @@ static gboolean handle_command_get_input(const struct=
 stk_command *cmd,
 						request_string_cb,
 						stk, NULL, timeout);
 =

-	g_free(text);
+	if (gi->text)
+		g_free(text);
 =

 	if (err < 0) {
 		/*
-- =

1.7.0.4


--===============1988666309522865588==--

