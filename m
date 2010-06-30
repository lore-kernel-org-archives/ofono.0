Content-Type: multipart/mixed; boundary="===============0419473985521147302=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/6] stk: Handle the Get Inkey proactive command.
Date: Wed, 30 Jun 2010 17:24:13 +0200
Message-ID: <1277911458-4984-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0419473985521147302==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The SimApplication agent method signature is:
string/Back/Terminate/Help GetKey(string message, string charset,
		bool help_available, bool single_key)

	charset is one of:
		"yesno" - response needs to be "yes" or "no"
		"digit" - one of 0-9, *, #, +
		"gsm" - only characters from the GSM SMS charset
		"any"
	single_key indicates that only characters from the device's
	key faces are allowed (e.g. no "+" allowed if device only
	has a basic keypad), and that the key should be returned
	without being shown on screen or waiting for any kind of
	user confirmation.

These patches apply on top of the previous series.
---
 src/stk.c |  160 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 files changed, 159 insertions(+), 1 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index ff47649..a2649b1 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -31,6 +31,7 @@
 #include <glib.h>
 #include <gdbus.h>
 #include <errno.h>
+#include <sys/time.h>
 =

 #include "ofono.h"
 =

@@ -64,6 +65,7 @@ enum stk_agent_state {
 	STK_AGENT_MAIN_MENU,
 	STK_AGENT_SELECT_ITEM,
 	STK_AGENT_DISPLAY_TEXT,
+	STK_AGENT_GET_KEY,
 };
 =

 struct ofono_stk {
@@ -83,6 +85,7 @@ struct ofono_stk {
 =

 	struct stk_menu *main_menu;
 	struct stk_menu *select_item_menu;
+	struct timeval get_inkey_start_ts;
 =

 	gboolean envelope_q_busy;
 	GQueue *envelope_q;
@@ -100,6 +103,7 @@ struct envelope_op {
 #define OFONO_NAVIGATION_PREFIX OFONO_SERVICE ".Navigation."
 #define OFONO_NAVIGATION_GOBACK OFONO_NAVIGATION_PREFIX "Back"
 #define OFONO_NAVIGATION_TERMINATED OFONO_NAVIGATION_PREFIX "Terminated"
+#define OFONO_NAVIGATION_GETHELP OFONO_NAVIGATION_PREFIX "Help"
 =

 static void envelope_queue_run(struct ofono_stk *stk);
 static void display_idle(struct ofono_stk *stk);
@@ -1041,7 +1045,6 @@ out:
 	display_idle(stk);
 }
 =

-
 static gboolean handle_command_display_text(const struct stk_command *cmd,
 						struct stk_response *rsp,
 						struct ofono_stk *stk)
@@ -1067,6 +1070,157 @@ static gboolean handle_command_display_text(const s=
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
+static void request_get_key_cb(struct ofono_stk *stk, DBusMessage *reply)
+{
+	struct stk_command_get_inkey *cmd =3D &stk->pending_cmd->get_inkey;
+	uint8_t qualifier =3D stk->pending_cmd->qualifier;
+	dbus_bool_t yesno =3D (qualifier & (1 << 2)) !=3D 0;
+	dbus_bool_t help =3D (qualifier & (1 << 7)) !=3D 0;
+	DBusError err;
+	enum stk_result_type type =3D STK_RESULT_TYPE_SUCCESS;
+	struct stk_response rsp;
+	struct ofono_error error =3D { .type =3D OFONO_ERROR_TYPE_FAILURE };
+	char *key;
+
+	if (!reply) {
+		if (stk->cmd_timeout) {
+			app_agent_request_cancel(stk);
+
+			display_idle(stk);
+			return;
+		}
+
+		type =3D STK_RESULT_TYPE_NO_RESPONSE;
+
+		goto send;
+	}
+
+	dbus_error_init(&err);
+	if (dbus_set_error_from_message(&err, reply)) {
+		if (g_str_equal(err.name, OFONO_NAVIGATION_TERMINATED))
+			type =3D STK_RESULT_TYPE_USER_TERMINATED;
+		else if (g_str_equal(err.name, OFONO_NAVIGATION_GOBACK))
+			type =3D STK_RESULT_TYPE_GO_BACK;
+		else if (g_str_equal(err.name, OFONO_NAVIGATION_GETHELP) &&
+				help)
+			type =3D STK_RESULT_TYPE_HELP_REQUESTED;
+		else {
+			type =3D STK_RESULT_TYPE_USER_TERMINATED;
+
+			ofono_error("Unknown reply %s", err.name);
+		}
+
+		dbus_error_free(&err);
+		goto send;
+	}
+
+	if (dbus_message_get_args(reply, NULL,
+					DBUS_TYPE_STRING, &key,
+					DBUS_TYPE_INVALID) =3D=3D FALSE) {
+		type =3D STK_RESULT_TYPE_USER_TERMINATED;
+
+		ofono_error("Reply not understood");
+		goto send;
+	}
+
+	if (yesno && strcasecmp(key, "yes") && strcasecmp(key, "no")) {
+		type =3D STK_RESULT_TYPE_USER_TERMINATED;
+
+		ofono_error("Yes/No reply not understood");
+		goto send;
+	} else if (yesno && strcasecmp(key, "yes"))
+		key =3D NULL; /* NULL indicates No, non-NULL indicates Yes */
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
+		struct timeval end_ts;
+		int interval;
+
+		gettimeofday(&end_ts, NULL);
+
+		interval =3D (end_ts.tv_usec + 1099999 -
+				stk->get_inkey_start_ts.tv_usec) / 100000;
+		interval +=3D (end_ts.tv_sec -
+				stk->get_inkey_start_ts.tv_sec) * 10;
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
+	if (stk_respond(stk, &rsp, display_command_cb))
+		display_command_cb(&error, stk);
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
+	gettimeofday(&stk->get_inkey_start_ts, NULL);
+
+	stk->custom_timeout =3D timeout;
+	app_agent_request_start(stk, request_get_key_send, request_get_key_cb,
+				STK_AGENT_GET_KEY);
+
+	return FALSE;
+}
+
 void ofono_stk_proactive_command_cancel(struct ofono_stk *stk)
 {
 	if (!stk->pending_cmd)
@@ -1140,6 +1294,10 @@ void ofono_stk_proactive_command_notify(struct ofono=
_stk *stk,
 		case STK_COMMAND_TYPE_DISPLAY_TEXT:
 			respond =3D handle_command_display_text(stk->pending_cmd,
 								&rsp, stk);
+			break;
+		case STK_COMMAND_TYPE_GET_INKEY:
+			respond =3D handle_command_get_inkey(stk->pending_cmd,
+								&rsp, stk);
 		}
 =

 		if (respond)
-- =

1.7.1.86.g0e460.dirty


--===============0419473985521147302==--

