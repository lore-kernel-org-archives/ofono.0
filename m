Content-Type: multipart/mixed; boundary="===============1794251617341985874=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/4] stk: Handle the Get Inkey proactive command.
Date: Wed, 04 Aug 2010 06:55:02 +0200
Message-ID: <1280897704-15361-2-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1280897704-15361-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1794251617341985874==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I don't have any card that actually makes use of Get Inkey so it's
not tested on hardware.
---
 src/stk.c |  200 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 200 insertions(+), 0 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index 4146443..9331934 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -32,6 +32,7 @@
 #include <gdbus.h>
 #include <errno.h>
 #include <time.h>
+#include <sys/time.h>
 =

 #include "ofono.h"
 =

@@ -69,6 +70,7 @@ struct ofono_stk {
 	guint remove_agent_source;
 	struct sms_submit_req *sms_submit_req;
 	char *idle_mode_text;
+	struct timeval get_inkey_start_ts;
 };
 =

 struct envelope_op {
@@ -1134,6 +1136,199 @@ static gboolean handle_command_display_text(const s=
truct stk_command *cmd,
 	return stk->immediate_response;
 }
 =

+static void set_get_inkey_duration(struct stk_duration *duration,
+					struct timeval *start_ts)
+{
+	struct timeval end_ts;
+	int interval;
+
+	gettimeofday(&end_ts, NULL);
+
+	interval =3D (end_ts.tv_usec + 1099999 - start_ts->tv_usec) / 100000;
+	interval +=3D (end_ts.tv_sec - start_ts->tv_sec) * 10;
+	interval -=3D 10;
+
+	switch (duration->unit) {
+	case STK_DURATION_TYPE_MINUTES:
+		interval =3D (interval + 59) / 60;
+	case STK_DURATION_TYPE_SECONDS:
+		interval =3D (interval + 9) / 10;
+	case STK_DURATION_TYPE_SECOND_TENTHS:
+		break;
+	}
+
+	duration->interval =3D interval;
+}
+
+static void request_confirmation_cb(enum stk_agent_result result,
+					gboolean confirm,
+					void *user_data)
+{
+	struct ofono_stk *stk =3D user_data;
+	static struct ofono_error error =3D { .type =3D OFONO_ERROR_TYPE_FAILURE =
};
+	struct stk_command_get_inkey *cmd =3D &stk->pending_cmd->get_inkey;
+	uint8_t qualifier =3D stk->pending_cmd->qualifier;
+	struct stk_response rsp;
+
+	switch (result) {
+	case STK_AGENT_RESULT_OK:
+		memset(&rsp, 0, sizeof(rsp));
+
+		rsp.result.type =3D STK_RESULT_TYPE_SUCCESS;
+		rsp.get_inkey.text.text =3D confirm ? "" : NULL;
+		rsp.get_inkey.text.yesno =3D TRUE;
+
+		if (cmd->duration.interval) {
+			rsp.get_inkey.duration.unit =3D cmd->duration.unit;
+			set_get_inkey_duration(&rsp.get_inkey.duration,
+						&stk->get_inkey_start_ts);
+		}
+
+		if (stk_respond(stk, &rsp, stk_command_cb))
+			stk_command_cb(&error, stk);
+
+		break;
+
+	case STK_AGENT_RESULT_BACK:
+		send_simple_response(stk, STK_RESULT_TYPE_GO_BACK);
+		break;
+
+	case STK_AGENT_RESULT_TIMEOUT:
+		send_simple_response(stk, STK_RESULT_TYPE_NO_RESPONSE);
+		break;
+
+	case STK_AGENT_RESULT_HELP:
+		if ((qualifier & (1 << 7)) =3D=3D 0) {
+			ofono_error("Help requested but not available");
+
+			send_simple_response(stk,
+					STK_RESULT_TYPE_USER_TERMINATED);
+			break;
+		}
+
+		send_simple_response(stk, STK_RESULT_TYPE_HELP_REQUESTED);
+		break;
+
+	case STK_AGENT_RESULT_TERMINATE:
+	default:
+		send_simple_response(stk, STK_RESULT_TYPE_USER_TERMINATED);
+		break;
+	}
+}
+
+static void request_key_cb(enum stk_agent_result result, char *string,
+				void *user_data)
+{
+	struct ofono_stk *stk =3D user_data;
+	static struct ofono_error error =3D { .type =3D OFONO_ERROR_TYPE_FAILURE =
};
+	struct stk_command_get_inkey *cmd =3D &stk->pending_cmd->get_inkey;
+	uint8_t qualifier =3D stk->pending_cmd->qualifier;
+	struct stk_response rsp;
+
+	switch (result) {
+	case STK_AGENT_RESULT_OK:
+		memset(&rsp, 0, sizeof(rsp));
+
+		rsp.result.type =3D STK_RESULT_TYPE_SUCCESS;
+		rsp.get_inkey.text.text =3D string;
+
+		if (cmd->duration.interval) {
+			rsp.get_inkey.duration.unit =3D cmd->duration.unit;
+			set_get_inkey_duration(&rsp.get_inkey.duration,
+						&stk->get_inkey_start_ts);
+		}
+
+		if (stk_respond(stk, &rsp, stk_command_cb))
+			stk_command_cb(&error, stk);
+
+		break;
+
+	case STK_AGENT_RESULT_BACK:
+		send_simple_response(stk, STK_RESULT_TYPE_GO_BACK);
+		break;
+
+	case STK_AGENT_RESULT_TIMEOUT:
+		send_simple_response(stk, STK_RESULT_TYPE_NO_RESPONSE);
+		break;
+
+	case STK_AGENT_RESULT_HELP:
+		if ((qualifier & (1 << 7)) =3D=3D 0) {
+			ofono_error("Help requested but not available");
+
+			send_simple_response(stk,
+					STK_RESULT_TYPE_USER_TERMINATED);
+			break;
+		}
+
+		send_simple_response(stk, STK_RESULT_TYPE_HELP_REQUESTED);
+		break;
+
+	case STK_AGENT_RESULT_TERMINATE:
+	default:
+		send_simple_response(stk, STK_RESULT_TYPE_USER_TERMINATED);
+		break;
+	}
+}
+
+static gboolean handle_command_get_inkey(const struct stk_command *cmd,
+						struct stk_response *rsp,
+						struct ofono_stk *stk)
+{
+	int timeout =3D stk->timeout * 1000;
+	const struct stk_command_get_inkey *gi =3D &cmd->get_inkey;
+	uint8_t qualifier =3D stk->pending_cmd->qualifier;
+	gboolean alphabet =3D (qualifier & (1 << 0)) !=3D 0;
+	gboolean ucs2 =3D (qualifier & (1 << 1)) !=3D 0;
+	gboolean yesno =3D (qualifier & (1 << 2)) !=3D 0;
+	/*
+	 * Note: immediate response and help parameter values are not
+	 * provided by current api.
+	 */
+	uint8_t icon_id =3D 0;
+	int err;
+
+	if (gi->duration.interval) {
+		timeout =3D gi->duration.interval;
+		switch (gi->duration.unit) {
+		case STK_DURATION_TYPE_MINUTES:
+			timeout *=3D 60;
+		case STK_DURATION_TYPE_SECONDS:
+			timeout *=3D 10;
+		case STK_DURATION_TYPE_SECOND_TENTHS:
+			timeout *=3D 100;
+		}
+	}
+
+	gettimeofday(&stk->get_inkey_start_ts, NULL);
+
+	stk->cancel_cmd =3D stk_request_cancel;
+
+	if (yesno)
+		err =3D stk_agent_request_confirmation(stk->current_agent,
+							gi->text, icon_id,
+							request_confirmation_cb,
+							stk, NULL, timeout);
+	else if (alphabet)
+		err =3D stk_agent_request_key(stk->current_agent, gi->text,
+						icon_id, ucs2, request_key_cb,
+						stk, NULL, timeout);
+	else
+		err =3D stk_agent_request_digit(stk->current_agent, gi->text,
+						icon_id, request_key_cb,
+						stk, NULL, timeout);
+
+	if (err < 0) {
+		/*
+		 * We most likely got an out of memory error, tell SIM
+		 * to retry
+		 */
+		rsp->result.type =3D STK_RESULT_TYPE_TERMINAL_BUSY;
+		return TRUE;
+	}
+
+	return FALSE;
+}
+
 static void stk_proactive_command_cancel(struct ofono_stk *stk)
 {
 	if (stk->immediate_response)
@@ -1268,6 +1463,11 @@ void ofono_stk_proactive_command_notify(struct ofono=
_stk *stk,
 							&rsp, stk);
 		break;
 =

+	case STK_COMMAND_TYPE_GET_INKEY:
+		respond =3D handle_command_get_inkey(stk->pending_cmd,
+							&rsp, stk);
+		break;
+
 	default:
 		rsp.result.type =3D STK_RESULT_TYPE_COMMAND_NOT_UNDERSTOOD;
 		break;
-- =

1.7.1.86.g0e460.dirty


--===============1794251617341985874==--

