Content-Type: multipart/mixed; boundary="===============1440263995909514262=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/2] stk: Handle the Play Tone proactive command.
Date: Mon, 11 Oct 2010 09:51:58 +0200
Message-ID: <1286783518-5464-2-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1286783518-5464-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1440263995909514262==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c |  140 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 140 insertions(+), 0 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index 22b5270..4879e2c 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -89,6 +89,11 @@ struct extern_req {
 	gboolean cancelled;
 };
 =

+struct tone_info {
+	const char *name;
+	gboolean continuous;
+};
+
 #define ENVELOPE_RETRIES_DEFAULT 5
 =

 static void envelope_queue_run(struct ofono_stk *stk);
@@ -2095,6 +2100,136 @@ static gboolean handle_command_send_dtmf(const stru=
ct stk_command *cmd,
 	return FALSE;
 }
 =

+static void play_tone_cb(enum stk_agent_result result, void *user_data)
+{
+	struct ofono_stk *stk =3D user_data;
+
+	stk->respond_on_exit =3D FALSE;
+
+	switch (result) {
+	case STK_AGENT_RESULT_OK:
+	case STK_AGENT_RESULT_TIMEOUT:
+		send_simple_response(stk, STK_RESULT_TYPE_SUCCESS);
+		break;
+
+	default:
+		send_simple_response(stk, STK_RESULT_TYPE_USER_TERMINATED);
+		break;
+	}
+}
+
+static gboolean handle_command_play_tone(const struct stk_command *cmd,
+						struct stk_response *rsp,
+						struct ofono_stk *stk)
+{
+	static int manufacturer_timeout =3D 10000; /* 10 seconds */
+	/* Continuous true/false according to 02.40 */
+	static const struct tone_info tone_infos[] =3D {
+		/* Default */
+		[0x00] =3D { "dial-tone", TRUE },
+
+		/* Standard */
+		[0x01] =3D { "dial-tone", TRUE },
+		[0x02] =3D { "busy", TRUE },
+		[0x03] =3D { "congestion", TRUE },
+		[0x04] =3D { "radio-path-acknowledge", FALSE },
+		[0x05] =3D { "radio-path-not-available", FALSE },
+		[0x06] =3D { "error", TRUE },
+		[0x07] =3D { "call-waiting", FALSE },
+		[0x08] =3D { "ringing-tone", TRUE },
+
+		/* Proprietary */
+		[0x10] =3D { "general-beep", FALSE },
+		[0x11] =3D { "positive-acknowledgement", FALSE },
+		[0x12] =3D { "negative-acknowledgement", FALSE },
+		[0x13] =3D { "user-ringing-tone", TRUE },
+		[0x14] =3D { "user-sms-alert", FALSE },
+		[0x15] =3D { "critical", FALSE },
+		[0x20] =3D { "vibrate", TRUE },
+
+		/* Themed */
+		[0x30] =3D { "happy", FALSE },
+		[0x31] =3D { "sad", FALSE },
+		[0x32] =3D { "urgent-action", FALSE },
+		[0x33] =3D { "question", FALSE },
+		[0x34] =3D { "message-received", FALSE },
+
+		/* Melody */
+		[0x40] =3D { "melody-1", FALSE },
+		[0x41] =3D { "melody-2", FALSE },
+		[0x42] =3D { "melody-3", FALSE },
+		[0x43] =3D { "melody-4", FALSE },
+		[0x44] =3D { "melody-5", FALSE },
+		[0x45] =3D { "melody-6", FALSE },
+		[0x46] =3D { "melody-7", FALSE },
+		[0x47] =3D { "melody-8", FALSE },
+	};
+
+	const struct stk_command_play_tone *pt =3D &cmd->play_tone;
+	uint8_t qualifier =3D stk->pending_cmd->qualifier;
+	gboolean vibrate =3D (qualifier & (1 << 0)) !=3D 0;
+	char *text;
+	int timeout;
+	int err;
+
+	text =3D dbus_apply_text_attributes(pt->alpha_id ? pt->alpha_id : "",
+						&pt->text_attr);
+
+	if (!text) {
+		rsp->result.type =3D STK_RESULT_TYPE_DATA_NOT_UNDERSTOOD;
+
+		return TRUE;
+	}
+
+	if (!tone_infos[pt->tone].name) {
+		rsp->result.type =3D STK_RESULT_TYPE_DATA_NOT_UNDERSTOOD;
+
+		return TRUE;
+	}
+
+	if (pt->duration.interval) {
+		timeout =3D pt->duration.interval;
+		switch (pt->duration.unit) {
+		case STK_DURATION_TYPE_MINUTES:
+			timeout *=3D 60;
+		case STK_DURATION_TYPE_SECONDS:
+			timeout *=3D 10;
+		case STK_DURATION_TYPE_SECOND_TENTHS:
+			timeout *=3D 100;
+		}
+	} else
+		timeout =3D manufacturer_timeout;
+
+	if (!tone_infos[pt->tone].continuous)
+		/* Duration ignored */
+		err =3D stk_agent_play_tone(stk->current_agent, text,
+						&pt->icon_id, vibrate,
+						tone_infos[pt->tone].name,
+						play_tone_cb, stk, NULL,
+						stk->timeout * 1000);
+	else
+		err =3D stk_agent_loop_tone(stk->current_agent, text,
+						&pt->icon_id, vibrate,
+						tone_infos[pt->tone].name,
+						play_tone_cb, stk, NULL,
+						timeout);
+	g_free(text);
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
+	stk->respond_on_exit =3D TRUE;
+	stk->cancel_cmd =3D stk_request_cancel;
+
+	return FALSE;
+}
+
 static void stk_proactive_command_cancel(struct ofono_stk *stk)
 {
 	if (stk->immediate_response)
@@ -2272,6 +2407,11 @@ void ofono_stk_proactive_command_notify(struct ofono=
_stk *stk,
 							&rsp, stk);
 		break;
 =

+	case STK_COMMAND_TYPE_PLAY_TONE:
+		respond =3D handle_command_play_tone(stk->pending_cmd,
+							&rsp, stk);
+		break;
+
 	default:
 		rsp.result.type =3D STK_RESULT_TYPE_COMMAND_NOT_UNDERSTOOD;
 		break;
-- =

1.7.1.86.g0e460.dirty


--===============1440263995909514262==--

