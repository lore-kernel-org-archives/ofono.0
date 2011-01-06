Content-Type: multipart/mixed; boundary="===============5724825882088912650=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 1/2] stk: add additional info for terminal busy result
Date: Thu, 06 Jan 2011 11:41:07 -0800
Message-ID: <1294342868-15945-2-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1294342868-15945-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5724825882088912650==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

As per the ETSI TS 102 223 specification 8.12.2, it is
mandatory to provide additional information for the
general result "ME currently unable to process command".
---
 src/stk.c |   45 +++++++++++++++++++++++++++++++++++++--------
 1 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index bec46ea..a00190d 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -99,6 +99,11 @@ struct extern_req {
 static void envelope_queue_run(struct ofono_stk *stk);
 static void timers_update(struct ofono_stk *stk);
 =

+#define ADD_ERROR_RESULT(result, error, addn_info)		\
+		result.type =3D error;				\
+		result.additional_len =3D sizeof(addn_info);	\
+		result.additional =3D addn_info;			\
+
 static int stk_respond(struct ofono_stk *stk, struct stk_response *rsp,
 			ofono_stk_generic_cb_t cb)
 {
@@ -857,7 +862,10 @@ static gboolean handle_command_send_sms(const struct s=
tk_command *cmd,
 	msg_list.next =3D NULL;
 =

 	if (__ofono_sms_txq_submit(sms, &msg_list, 0, &uuid, NULL, NULL) < 0) {
-		rsp->result.type =3D STK_RESULT_TYPE_TERMINAL_BUSY;
+		unsigned char no_cause_result[] =3D { 0x00 };
+
+		ADD_ERROR_RESULT(rsp->result, STK_RESULT_TYPE_TERMINAL_BUSY,
+					no_cause_result);
 		return TRUE;
 	}
 =

@@ -1183,9 +1191,12 @@ static gboolean handle_command_select_item(const str=
uct stk_command *cmd,
 					request_selection_cb, stk,
 					request_selection_destroy,
 					stk->timeout * 1000) < 0) {
+		unsigned char no_cause_result[] =3D { 0x00 };
+
 		request_selection_destroy(stk);
 =

-		rsp->result.type =3D STK_RESULT_TYPE_TERMINAL_BUSY;
+		ADD_ERROR_RESULT(rsp->result, STK_RESULT_TYPE_TERMINAL_BUSY,
+					no_cause_result);
 		return TRUE;
 	}
 =

@@ -1301,7 +1312,10 @@ static gboolean handle_command_display_text(const st=
ruct stk_command *cmd,
 =

 	/* We most likely got an out of memory error, tell SIM to retry */
 	if (err < 0) {
-		rsp->result.type =3D STK_RESULT_TYPE_TERMINAL_BUSY;
+		unsigned char no_cause_result[] =3D { 0x00 };
+
+		ADD_ERROR_RESULT(rsp->result, STK_RESULT_TYPE_TERMINAL_BUSY,
+					no_cause_result);
 		return TRUE;
 	}
 =

@@ -1475,11 +1489,14 @@ static gboolean handle_command_get_inkey(const stru=
ct stk_command *cmd,
 	g_free(text);
 =

 	if (err < 0) {
+		unsigned char no_cause_result[] =3D { 0x00 };
+
 		/*
 		 * We most likely got an out of memory error, tell SIM
 		 * to retry
 		 */
-		rsp->result.type =3D STK_RESULT_TYPE_TERMINAL_BUSY;
+		ADD_ERROR_RESULT(rsp->result, STK_RESULT_TYPE_TERMINAL_BUSY,
+					no_cause_result);
 		return TRUE;
 	}
 =

@@ -1564,11 +1581,14 @@ static gboolean handle_command_get_input(const stru=
ct stk_command *cmd,
 	g_free(text);
 =

 	if (err < 0) {
+		unsigned char no_cause_result[] =3D { 0x00 };
+
 		/*
 		 * We most likely got an out of memory error, tell SIM
 		 * to retry
 		 */
-		rsp->result.type =3D STK_RESULT_TYPE_TERMINAL_BUSY;
+		ADD_ERROR_RESULT(rsp->result, STK_RESULT_TYPE_TERMINAL_BUSY,
+					no_cause_result);
 		return TRUE;
 	}
 =

@@ -1772,11 +1792,14 @@ static gboolean handle_command_set_up_call(const st=
ruct stk_command *cmd,
 	g_free(alpha_id);
 =

 	if (err < 0) {
+		unsigned char no_cause_result[] =3D { 0x00 };
+
 		/*
 		 * We most likely got an out of memory error, tell SIM
 		 * to retry
 		 */
-		rsp->result.type =3D STK_RESULT_TYPE_TERMINAL_BUSY;
+		ADD_ERROR_RESULT(rsp->result, STK_RESULT_TYPE_TERMINAL_BUSY,
+					no_cause_result);
 		return TRUE;
 	}
 =

@@ -2193,11 +2216,14 @@ static gboolean handle_command_send_dtmf(const stru=
ct stk_command *cmd,
 	}
 =

 	if (err < 0) {
+		unsigned char no_cause_result[] =3D { 0x00 };
+
 		/*
 		 * We most likely got an out of memory error, tell SIM
 		 * to retry
 		 */
-		rsp->result.type =3D STK_RESULT_TYPE_TERMINAL_BUSY;
+		ADD_ERROR_RESULT(rsp->result, STK_RESULT_TYPE_TERMINAL_BUSY,
+					no_cause_result);
 		return TRUE;
 	}
 =

@@ -2329,11 +2355,14 @@ static gboolean handle_command_play_tone(const stru=
ct stk_command *cmd,
 	g_free(text);
 =

 	if (err < 0) {
+		unsigned char no_cause_result[] =3D { 0x00 };
+
 		/*
 		 * We most likely got an out of memory error, tell SIM
 		 * to retry
 		 */
-		rsp->result.type =3D STK_RESULT_TYPE_TERMINAL_BUSY;
+		ADD_ERROR_RESULT(rsp->result, STK_RESULT_TYPE_TERMINAL_BUSY,
+					no_cause_result);
 		return TRUE;
 	}
 =

-- =

1.7.0.4


--===============5724825882088912650==--

