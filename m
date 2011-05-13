Content-Type: multipart/mixed; boundary="===============0971695699538006751=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH v3 1/7] stk: Clear 'respond_on_exit' flag after sending the
 terminal response
Date: Fri, 13 May 2011 19:21:58 +0200
Message-ID: <1305307324-19548-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0971695699538006751==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c |   27 ++-------------------------
 1 files changed, 2 insertions(+), 25 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index c86cbfb..8214b65 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -128,6 +128,7 @@ static int stk_respond(struct ofono_stk *stk, struct st=
k_response *rsp,
 	stk_command_free(stk->pending_cmd);
 	stk->pending_cmd =3D NULL;
 	stk->cancel_cmd =3D NULL;
+	stk->respond_on_exit =3D FALSE;
 =

 	stk->driver->terminal_response(stk, tlv_len, tlv, cb, stk);
 =

@@ -477,10 +478,8 @@ static void user_termination_cb(enum stk_agent_result =
result, void *user_data)
 {
 	struct ofono_stk *stk =3D user_data;
 =

-	if (result =3D=3D STK_AGENT_RESULT_TERMINATE) {
-		stk->respond_on_exit =3D FALSE;
+	if (result =3D=3D STK_AGENT_RESULT_TERMINATE)
 		send_simple_response(stk, STK_RESULT_TYPE_USER_TERMINATED);
-	}
 }
 =

 static void stk_alpha_id_set(struct ofono_stk *stk,
@@ -598,7 +597,6 @@ static void default_agent_notify(gpointer user_data)
 =

 	stk->default_agent =3D NULL;
 	stk->current_agent =3D stk->session_agent;
-	stk->respond_on_exit =3D FALSE;
 }
 =

 static void session_agent_notify(gpointer user_data)
@@ -617,7 +615,6 @@ static void session_agent_notify(gpointer user_data)
 =

 	stk->session_agent =3D NULL;
 	stk->current_agent =3D stk->default_agent;
-	stk->respond_on_exit =3D FALSE;
 =

 	if (stk->remove_agent_source) {
 		g_source_remove(stk->remove_agent_source);
@@ -1159,8 +1156,6 @@ static void request_selection_cb(enum stk_agent_resul=
t result, uint8_t id,
 {
 	struct ofono_stk *stk =3D user_data;
 =

-	stk->respond_on_exit =3D FALSE;
-
 	switch (result) {
 	case STK_AGENT_RESULT_OK:
 	{
@@ -1243,8 +1238,6 @@ static void display_text_cb(enum stk_agent_result res=
ult, void *user_data)
 	static unsigned char screen_busy_result[] =3D { 0x01 };
 	static struct ofono_error error =3D { .type =3D OFONO_ERROR_TYPE_FAILURE =
};
 =

-	stk->respond_on_exit =3D FALSE;
-
 	/*
 	 * There are four possible paths for DisplayText with immediate
 	 * response flag set:
@@ -1386,8 +1379,6 @@ static void request_confirmation_cb(enum stk_agent_re=
sult result,
 	struct stk_command_get_inkey *cmd =3D &stk->pending_cmd->get_inkey;
 	struct stk_response rsp;
 =

-	stk->respond_on_exit =3D FALSE;
-
 	switch (result) {
 	case STK_AGENT_RESULT_OK:
 		memset(&rsp, 0, sizeof(rsp));
@@ -1442,8 +1433,6 @@ static void request_key_cb(enum stk_agent_result resu=
lt, char *string,
 	struct stk_command_get_inkey *cmd =3D &stk->pending_cmd->get_inkey;
 	struct stk_response rsp;
 =

-	stk->respond_on_exit =3D FALSE;
-
 	switch (result) {
 	case STK_AGENT_RESULT_OK:
 		memset(&rsp, 0, sizeof(rsp));
@@ -1560,8 +1549,6 @@ static void request_string_cb(enum stk_agent_result r=
esult, char *string,
 	gboolean packed =3D (qualifier & (1 << 3)) !=3D 0;
 	struct stk_response rsp;
 =

-	stk->respond_on_exit =3D FALSE;
-
 	switch (result) {
 	case STK_AGENT_RESULT_OK:
 		memset(&rsp, 0, sizeof(rsp));
@@ -1699,8 +1686,6 @@ static void confirm_call_cb(enum stk_agent_result res=
ult, gboolean confirm,
 	struct stk_response rsp;
 	int err;
 =

-	stk->respond_on_exit =3D FALSE;
-
 	switch (result) {
 	case STK_AGENT_RESULT_TIMEOUT:
 		confirm =3D FALSE;
@@ -2283,8 +2268,6 @@ static void send_dtmf_cancel(struct ofono_stk *stk)
 	struct ofono_voicecall *vc =3D NULL;
 	struct ofono_atom *vc_atom;
 =

-	stk->respond_on_exit =3D FALSE;
-
 	vc_atom =3D __ofono_modem_find_atom(__ofono_atom_get_modem(stk->atom),
 						OFONO_ATOM_TYPE_VOICECALL);
 	if (vc_atom)
@@ -2300,8 +2283,6 @@ static void dtmf_sent_cb(int error, void *user_data)
 {
 	struct ofono_stk *stk =3D user_data;
 =

-	stk->respond_on_exit =3D FALSE;
-
 	stk_alpha_id_unset(stk);
 =

 	if (error =3D=3D ENOENT) {
@@ -2413,8 +2394,6 @@ static void play_tone_cb(enum stk_agent_result result=
, void *user_data)
 {
 	struct ofono_stk *stk =3D user_data;
 =

-	stk->respond_on_exit =3D FALSE;
-
 	switch (result) {
 	case STK_AGENT_RESULT_OK:
 	case STK_AGENT_RESULT_TIMEOUT:
@@ -2547,8 +2526,6 @@ static void confirm_launch_browser_cb(enum stk_agent_=
result result,
 	struct ofono_error failure =3D { .type =3D OFONO_ERROR_TYPE_FAILURE };
 	struct stk_response rsp;
 =

-	stk->respond_on_exit =3D FALSE;
-
 	switch (result) {
 	case STK_AGENT_RESULT_TIMEOUT:
 		confirm =3D FALSE;
-- =

1.7.1


--===============0971695699538006751==--

