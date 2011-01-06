Content-Type: multipart/mixed; boundary="===============4716721904909808391=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 2/2] stk: make use of ADD_ERROR_RESULT macro
Date: Thu, 06 Jan 2011 11:41:08 -0800
Message-ID: <1294342868-15945-3-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1294342868-15945-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4716721904909808391==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c |   69 ++++++++++++++++++++++++++-------------------------------=
---
 1 files changed, 30 insertions(+), 39 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index a00190d..b20ea1c 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -1269,9 +1269,8 @@ static void display_text_cb(enum stk_agent_result res=
ult, void *user_data)
 =

 	case STK_AGENT_RESULT_BUSY:
 		memset(&rsp, 0, sizeof(rsp));
-		rsp.result.type =3D STK_RESULT_TYPE_TERMINAL_BUSY;
-		rsp.result.additional_len =3D sizeof(screen_busy_result);
-		rsp.result.additional =3D screen_busy_result;
+		ADD_ERROR_RESULT(rsp.result, STK_RESULT_TYPE_TERMINAL_BUSY,
+					screen_busy_result);
 		if (stk_respond(stk, &rsp, stk_command_cb))
 			stk_command_cb(&error, stk);
 		break;
@@ -1608,9 +1607,9 @@ static void call_setup_connected(struct ofono_call *c=
all, void *data)
 	if (call =3D=3D NULL || call->status =3D=3D CALL_STATUS_DISCONNECTED) {
 		memset(&rsp, 0, sizeof(rsp));
 =

-		rsp.result.type =3D STK_RESULT_TYPE_NETWORK_UNAVAILABLE;
-		rsp.result.additional_len =3D sizeof(facility_rejected_result);
-		rsp.result.additional =3D facility_rejected_result;
+		ADD_ERROR_RESULT(rsp.result,
+					STK_RESULT_TYPE_NETWORK_UNAVAILABLE,
+					facility_rejected_result);
 =

 		if (stk_respond(stk, &rsp, stk_command_cb))
 			stk_command_cb(&error, stk);
@@ -1709,9 +1708,8 @@ static void confirm_call_cb(enum stk_agent_result res=
ult, gboolean confirm,
 	if (err =3D=3D -EBUSY) {
 		memset(&rsp, 0, sizeof(rsp));
 =

-		rsp.result.type =3D STK_RESULT_TYPE_TERMINAL_BUSY;
-		rsp.result.additional_len =3D sizeof(busy_on_call_result);
-		rsp.result.additional =3D busy_on_call_result;
+		ADD_ERROR_RESULT(rsp.result, STK_RESULT_TYPE_TERMINAL_BUSY,
+					busy_on_call_result);
 =

 		if (stk_respond(stk, &rsp, stk_command_cb))
 			stk_command_cb(&error, stk);
@@ -1727,9 +1725,8 @@ static void confirm_call_cb(enum stk_agent_result res=
ult, gboolean confirm,
 =

 	memset(&rsp, 0, sizeof(rsp));
 =

-	rsp.result.type =3D STK_RESULT_TYPE_NETWORK_UNAVAILABLE;
-	rsp.result.additional_len =3D sizeof(no_cause_result);
-	rsp.result.additional =3D no_cause_result;
+	ADD_ERROR_RESULT(rsp.result, STK_RESULT_TYPE_NETWORK_UNAVAILABLE,
+				no_cause_result);
 =

 	if (stk_respond(stk, &rsp, stk_command_cb))
 		stk_command_cb(&error, stk);
@@ -1772,9 +1769,8 @@ static gboolean handle_command_set_up_call(const stru=
ct stk_command *cmd,
 	}
 =

 	if (__ofono_voicecall_is_busy(vc, qualifier >> 1)) {
-		rsp->result.type =3D STK_RESULT_TYPE_TERMINAL_BUSY;
-		rsp->result.additional_len =3D sizeof(busy_on_call_result);
-		rsp->result.additional =3D busy_on_call_result;
+		ADD_ERROR_RESULT(rsp->result, STK_RESULT_TYPE_TERMINAL_BUSY,
+					busy_on_call_result);
 		return TRUE;
 	}
 =

@@ -1872,9 +1868,8 @@ static void send_ussd_callback(int error, int dcs, co=
nst unsigned char *msg,
 		break;
 =

 	default:
-		rsp.result.type =3D STK_RESULT_TYPE_USSD_RETURN_ERROR;
-		rsp.result.additional_len =3D sizeof(no_cause);
-		rsp.result.additional =3D no_cause;
+		ADD_ERROR_RESULT(rsp.result, STK_RESULT_TYPE_USSD_RETURN_ERROR,
+					no_cause);
 =

 		if (stk_respond(stk, &rsp, stk_command_cb))
 			stk_command_cb(&failure, stk);
@@ -1899,9 +1894,9 @@ static gboolean handle_command_send_ussd(const struct=
 stk_command *cmd,
 		struct ofono_call_forwarding *cf =3D __ofono_atom_get_data(atom);
 =

 		if (__ofono_call_forwarding_is_busy(cf)) {
-			rsp->result.type =3D STK_RESULT_TYPE_TERMINAL_BUSY;
-			rsp->result.additional_len =3D sizeof(busy_on_ss_result);
-			rsp->result.additional =3D busy_on_ss_result;
+			ADD_ERROR_RESULT(rsp->result,
+						STK_RESULT_TYPE_TERMINAL_BUSY,
+						busy_on_ss_result);
 			return TRUE;
 		}
 	}
@@ -1911,9 +1906,9 @@ static gboolean handle_command_send_ussd(const struct=
 stk_command *cmd,
 		struct ofono_call_barring *cb =3D __ofono_atom_get_data(atom);
 =

 		if (__ofono_call_barring_is_busy(cb)) {
-			rsp->result.type =3D STK_RESULT_TYPE_TERMINAL_BUSY;
-			rsp->result.additional_len =3D sizeof(busy_on_ss_result);
-			rsp->result.additional =3D busy_on_ss_result;
+			ADD_ERROR_RESULT(rsp->result,
+						STK_RESULT_TYPE_TERMINAL_BUSY,
+						busy_on_ss_result);
 			return TRUE;
 		}
 	}
@@ -1923,9 +1918,9 @@ static gboolean handle_command_send_ussd(const struct=
 stk_command *cmd,
 		struct ofono_call_settings *cs =3D __ofono_atom_get_data(atom);
 =

 		if (__ofono_call_settings_is_busy(cs)) {
-			rsp->result.type =3D STK_RESULT_TYPE_TERMINAL_BUSY;
-			rsp->result.additional_len =3D sizeof(busy_on_ss_result);
-			rsp->result.additional =3D busy_on_ss_result;
+			ADD_ERROR_RESULT(rsp->result,
+						STK_RESULT_TYPE_TERMINAL_BUSY,
+						busy_on_ss_result);
 			return TRUE;
 		}
 	}
@@ -1938,9 +1933,8 @@ static gboolean handle_command_send_ussd(const struct=
 stk_command *cmd,
 =

 	ussd =3D __ofono_atom_get_data(atom);
 	if (__ofono_ussd_is_busy(ussd)) {
-		rsp->result.type =3D STK_RESULT_TYPE_TERMINAL_BUSY;
-		rsp->result.additional_len =3D sizeof(busy_on_ussd_result);
-		rsp->result.additional =3D busy_on_ussd_result;
+		ADD_ERROR_RESULT(rsp->result, STK_RESULT_TYPE_TERMINAL_BUSY,
+					busy_on_ussd_result);
 		return TRUE;
 	}
 =

@@ -1961,9 +1955,8 @@ static gboolean handle_command_send_ussd(const struct=
 stk_command *cmd,
 	}
 =

 	if (err =3D=3D -EBUSY) {
-		rsp->result.type =3D STK_RESULT_TYPE_TERMINAL_BUSY;
-		rsp->result.additional_len =3D sizeof(busy_on_ussd_result);
-		rsp->result.additional =3D busy_on_ussd_result;
+		ADD_ERROR_RESULT(rsp->result, STK_RESULT_TYPE_TERMINAL_BUSY,
+					busy_on_ussd_result);
 		return TRUE;
 	}
 =

@@ -2140,9 +2133,8 @@ static void dtmf_sent_cb(int error, void *user_data)
 =

 		memset(&rsp, 0, sizeof(rsp));
 =

-		rsp.result.type =3D STK_RESULT_TYPE_TERMINAL_BUSY;
-		rsp.result.additional_len =3D sizeof(not_in_speech_call_result);
-		rsp.result.additional =3D not_in_speech_call_result;
+		ADD_ERROR_RESULT(rsp.result, STK_RESULT_TYPE_TERMINAL_BUSY,
+					not_in_speech_call_result);
 =

 		if (stk_respond(stk, &rsp, stk_command_cb))
 			stk_command_cb(&failure, stk);
@@ -2204,9 +2196,8 @@ static gboolean handle_command_send_dtmf(const struct=
 stk_command *cmd,
 	}
 =

 	if (err =3D=3D -ENOENT) {
-		rsp->result.type =3D STK_RESULT_TYPE_TERMINAL_BUSY;
-		rsp->result.additional_len =3D sizeof(not_in_speech_call_result);
-		rsp->result.additional =3D not_in_speech_call_result;
+		ADD_ERROR_RESULT(rsp->result, STK_RESULT_TYPE_TERMINAL_BUSY,
+					not_in_speech_call_result);
 		return TRUE;
 	}
 =

-- =

1.7.0.4


--===============4716721904909808391==--

