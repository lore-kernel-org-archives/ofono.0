Content-Type: multipart/mixed; boundary="===============7008195868839224756=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 5/6] stk: Handle the Get Inkey proactive command.
Date: Thu, 15 Jul 2010 15:18:10 +0200
Message-ID: <1279199891-22746-5-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1279199891-22746-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7008195868839224756==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c |  168 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 168 insertions(+), 0 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index 8b6c1ca..6fbdbe4 100644
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

@@ -74,6 +75,7 @@ struct stk_app_agent {
 	guint watch;
 	guint send_menu_source;
 	guint cmd_timeout;
+	struct timeval get_inkey_start_ts;
 	void (*cmd_send)(struct ofono_stk *stk, DBusMessage *call);
 	void (*cmd_cb)(struct ofono_stk *stk, enum stk_agent_result result,
 			DBusMessage *reply);
@@ -1321,6 +1323,168 @@ static gboolean handle_command_display_text(const s=
truct stk_command *cmd,
 	return cmd->display_text.immediate_response;
 }
 =

+static void request_get_key_send(struct ofono_stk *stk, DBusMessage *call)
+{
+	struct stk_command_get_inkey *cmd =3D &stk->pending_cmd->get_inkey;
+	uint8_t qualifier =3D stk->pending_cmd->qualifier;
+	dbus_bool_t alphabet =3D (qualifier & (1 << 0)) !=3D 0;
+	dbus_bool_t ucs2 =3D (qualifier & (1 << 1)) !=3D 0;
+	dbus_bool_t yesno =3D (qualifier & (1 << 2)) !=3D 0;
+	dbus_bool_t immediate =3D (qualifier & (1 << 3)) !=3D 0;
+	dbus_bool_t help =3D (qualifier & (1 << 7)) !=3D 0;
+	const char *charset =3D
+		yesno ? "yesno" :
+		(!alphabet ? "digit" :
+		 (ucs2 ? "any" : "gsm"));
+
+	dbus_message_set_member(call, "GetKey");
+
+	dbus_message_append_args(call,
+					DBUS_TYPE_STRING, &cmd->text,
+					DBUS_TYPE_STRING, &charset,
+					DBUS_TYPE_BOOLEAN, &help,
+					DBUS_TYPE_BOOLEAN, &immediate,
+					DBUS_TYPE_INVALID);
+}
+
+static void request_get_key_cb(struct ofono_stk *stk,
+				enum stk_agent_result result,
+				DBusMessage *reply)
+{
+	struct stk_command_get_inkey *cmd =3D &stk->pending_cmd->get_inkey;
+	uint8_t qualifier =3D stk->pending_cmd->qualifier;
+	dbus_bool_t yesno =3D (qualifier & (1 << 2)) !=3D 0;
+	dbus_bool_t help =3D (qualifier & (1 << 7)) !=3D 0;
+	enum stk_result_type type =3D STK_RESULT_TYPE_SUCCESS;
+	struct stk_response rsp;
+	struct ofono_error error =3D { .type =3D OFONO_ERROR_TYPE_FAILURE };
+	char *key;
+
+	switch (result) {
+	case STK_AGENT_RESULT_OK:
+		break;
+
+	case STK_AGENT_RESULT_HELP:
+		if (!help) {
+			type =3D STK_RESULT_TYPE_USER_TERMINATED;
+			ofono_error("Help requested but not available");
+
+			goto send;
+		}
+
+		type =3D STK_RESULT_TYPE_HELP_REQUESTED;
+		goto send;
+
+	case STK_AGENT_RESULT_BACK:
+		type =3D STK_RESULT_TYPE_GO_BACK;
+		goto send;
+
+	case STK_AGENT_RESULT_TIMEOUT:
+		type =3D STK_RESULT_TYPE_NO_RESPONSE;
+		goto send;
+
+	case STK_AGENT_RESULT_TERMINATE:
+	default:
+		type =3D STK_RESULT_TYPE_USER_TERMINATED;
+		goto send;
+
+	case STK_AGENT_RESULT_CANCEL:
+		return;
+	}
+
+	if (dbus_message_get_args(reply, NULL,
+					DBUS_TYPE_STRING, &key,
+					DBUS_TYPE_INVALID) =3D=3D FALSE) {
+		type =3D STK_RESULT_TYPE_USER_TERMINATED;
+		ofono_error("Reply not understood");
+
+		goto send;
+	}
+
+	if (yesno && strcasecmp(key, "yes") && strcasecmp(key, "no")) {
+		type =3D STK_RESULT_TYPE_USER_TERMINATED;
+		ofono_error("Yes/No reply not understood");
+
+		goto send;
+	} else if (yesno && strcasecmp(key, "yes"))
+		key =3D NULL; /* NULL indicates No, non-NULL indicates Yes */
+	else if (!yesno && g_utf8_strlen(key, 10) !=3D 1) {
+		type =3D STK_RESULT_TYPE_USER_TERMINATED;
+		ofono_error("Reply string has incorrect length");
+
+		goto send;
+	}
+
+	/* TODO: check charset? */
+
+send:
+	memset(&rsp, 0, sizeof(rsp));
+	rsp.result.type =3D type;
+
+	if (type =3D=3D STK_RESULT_TYPE_SUCCESS) {
+		rsp.get_inkey.text.text =3D key;
+		rsp.get_inkey.text.packed =3D FALSE;
+		rsp.get_inkey.text.yesno =3D yesno;
+	}
+
+	if (cmd->duration.interval) {
+		struct timeval *start_ts =3D &stk->app_agent->get_inkey_start_ts;
+		struct timeval end_ts;
+		int interval;
+
+		gettimeofday(&end_ts, NULL);
+
+		interval =3D (end_ts.tv_usec + 1099999 - start_ts->tv_usec) /
+			100000;
+		interval +=3D (end_ts.tv_sec - start_ts->tv_sec) * 10;
+		interval -=3D 10;
+
+		switch (cmd->duration.unit) {
+		case STK_DURATION_TYPE_MINUTES:
+			interval =3D (interval + 59) / 60;
+		case STK_DURATION_TYPE_SECONDS:
+			interval =3D (interval + 9) / 10;
+		case STK_DURATION_TYPE_SECOND_TENTHS:
+			break;
+		}
+
+		rsp.get_inkey.duration.unit =3D cmd->duration.unit;
+		rsp.get_inkey.duration.interval =3D interval;
+	}
+
+	if (stk_respond(stk, &rsp, stk_command_cb))
+		stk_command_cb(&error, stk);
+}
+
+static gboolean handle_command_get_inkey(const struct stk_command *cmd,
+						struct stk_response *rsp,
+						struct ofono_stk *stk)
+{
+	int timeout =3D 0;
+
+	if (cmd->get_inkey.duration.interval) {
+		timeout =3D cmd->get_inkey.duration.interval;
+		switch (cmd->get_inkey.duration.unit) {
+		case STK_DURATION_TYPE_MINUTES:
+			timeout *=3D 60;
+		case STK_DURATION_TYPE_SECONDS:
+			timeout *=3D 10;
+		case STK_DURATION_TYPE_SECOND_TENTHS:
+			timeout *=3D 100;
+		}
+	}
+
+	gettimeofday(&stk->app_agent->get_inkey_start_ts, NULL);
+
+	app_agent_request_start(stk,
+				request_get_key_send, request_get_key_cb,
+				timeout);
+
+	stk->cancel_cmd =3D app_agent_request_cancel;
+
+	return FALSE;
+}
+
 static void stk_proactive_command_cancel(struct ofono_stk *stk)
 {
 	if (!stk->pending_cmd)
@@ -1438,6 +1602,10 @@ void ofono_stk_proactive_command_notify(struct ofono=
_stk *stk,
 			respond =3D handle_command_display_text(stk->pending_cmd,
 								&rsp, stk);
 			break;
+		case STK_COMMAND_TYPE_GET_INKEY:
+			respond =3D handle_command_get_inkey(stk->pending_cmd,
+								&rsp, stk);
+			break;
 		}
 =

 		if (respond)
-- =

1.7.1.86.g0e460.dirty


--===============7008195868839224756==--

