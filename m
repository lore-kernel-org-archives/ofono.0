Content-Type: multipart/mixed; boundary="===============0484110652274452536=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 2/3] stk: Handle provide local info proactive command
Date: Thu, 25 Nov 2010 20:29:01 +0800
Message-ID: <1290688142-14726-3-git-send-email-yang.gu@intel.com>
In-Reply-To: <1290688142-14726-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0484110652274452536==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/smsutil.c  |    6 +-
 src/stk.c      |  113 +++++++++++++++++++++++++++++++++++++++++
 src/stkagent.c |  153 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/stkagent.h |   14 +++++
 src/stkutil.c  |    2 +-
 5 files changed, 284 insertions(+), 4 deletions(-)

diff --git a/src/smsutil.c b/src/smsutil.c
index e6dbf5f..5394817 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -324,10 +324,10 @@ gboolean sms_encode_scts(const struct sms_scts *in, u=
nsigned char *pdu,
 	if (in->year > 99)
 		return FALSE;
 =

-	if (in->month > 12)
+	if (in->month > 12 || in->month =3D=3D 0)
 		return FALSE;
 =

-	if (in->day > 31)
+	if (in->day > 31 || in->day =3D=3D 0)
 		return FALSE;
 =

 	if (in->hour > 23)
@@ -339,7 +339,7 @@ gboolean sms_encode_scts(const struct sms_scts *in, uns=
igned char *pdu,
 	if (in->second > 59)
 		return FALSE;
 =

-	if ((in->timezone > 12*4-1) || (in->timezone < -(12*4-1)))
+	if ((in->timezone > 12*4) || (in->timezone < -(12*4-1)))
 		return FALSE;
 =

 	pdu =3D pdu + *offset;
diff --git a/src/stk.c b/src/stk.c
index ac2e646..1f3817f 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -1992,6 +1992,114 @@ static gboolean handle_command_refresh(const struct=
 stk_command *cmd,
 	return TRUE;
 }
 =

+static void request_time_cb(enum stk_agent_result result, unsigned char ye=
ar,
+				unsigned char month, unsigned char day,
+				unsigned char hour, unsigned char minute,
+				unsigned char second, char timezone,
+				void *user_data)
+{
+	struct ofono_stk *stk =3D user_data;
+	static struct ofono_error error =3D { .type =3D OFONO_ERROR_TYPE_FAILURE =
};
+	struct stk_response rsp;
+
+	stk->respond_on_exit =3D FALSE;
+
+	switch (result) {
+	case STK_AGENT_RESULT_OK:
+		memset(&rsp, 0, sizeof(rsp));
+
+		rsp.result.type =3D STK_RESULT_TYPE_SUCCESS;
+		rsp.provide_local_info.datetime.year =3D year;
+		rsp.provide_local_info.datetime.month =3D month;
+		rsp.provide_local_info.datetime.day =3D day;
+		rsp.provide_local_info.datetime.hour =3D hour;
+		rsp.provide_local_info.datetime.minute =3D minute;
+		rsp.provide_local_info.datetime.second =3D second;
+		rsp.provide_local_info.datetime.timezone =3D timezone;
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
+	case STK_AGENT_RESULT_TERMINATE:
+		send_simple_response(stk, STK_RESULT_TYPE_USER_TERMINATED);
+		break;
+	}
+}
+
+static void request_lang_cb(enum stk_agent_result result, char *lang,
+				void *user_data)
+{
+	struct ofono_stk *stk =3D user_data;
+	static struct ofono_error error =3D { .type =3D OFONO_ERROR_TYPE_FAILURE =
};
+	struct stk_response rsp;
+
+	stk->respond_on_exit =3D FALSE;
+
+	switch (result) {
+	case STK_AGENT_RESULT_OK:
+		memset(&rsp, 0, sizeof(rsp));
+
+		rsp.result.type =3D STK_RESULT_TYPE_SUCCESS;
+		rsp.provide_local_info.language =3D lang;
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
+	case STK_AGENT_RESULT_TERMINATE:
+		send_simple_response(stk, STK_RESULT_TYPE_USER_TERMINATED);
+		break;
+	}
+}
+
+static gboolean handle_command_provide_local_info(const struct stk_command=
 *cmd,
+				struct stk_response *rsp, struct ofono_stk *stk)
+{
+	int timeout =3D stk->timeout * 1000;
+	int err;
+
+	switch (cmd->qualifier) {
+	case 3:
+		DBG("Date, time and time zone");
+		err =3D stk_agent_request_time(stk->current_agent,
+						request_time_cb,
+						stk, NULL, timeout);
+		return FALSE;
+
+	case 4:
+		DBG("Language setting");
+		err =3D stk_agent_request_lang(stk->current_agent,
+						request_lang_cb,
+						stk, NULL, timeout);
+		return FALSE;
+
+	default:
+		ofono_info("Unsupported Provide Local Info qualifier: %d",
+				cmd->qualifier);
+		rsp->result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
+		return TRUE;
+	}
+}
+
 static void send_dtmf_cancel(struct ofono_stk *stk)
 {
 	struct ofono_voicecall *vc =3D NULL;
@@ -2424,6 +2532,11 @@ void ofono_stk_proactive_command_notify(struct ofono=
_stk *stk,
 							&rsp, stk);
 		break;
 =

+	case STK_COMMAND_TYPE_PROVIDE_LOCAL_INFO:
+		respond =3D handle_command_provide_local_info(stk->pending_cmd,
+								&rsp, stk);
+		break;
+
 	case STK_COMMAND_TYPE_SEND_DTMF:
 		respond =3D handle_command_send_dtmf(stk->pending_cmd,
 							&rsp, stk);
diff --git a/src/stkagent.c b/src/stkagent.c
index 5cf83e4..78620d5 100644
--- a/src/stkagent.c
+++ b/src/stkagent.c
@@ -956,3 +956,156 @@ int stk_agent_loop_tone(struct stk_agent *agent, cons=
t char *text,
 =

 	return 0;
 }
+
+static void get_time_cb(DBusPendingCall *call, void *data)
+{
+	struct stk_agent *agent =3D data;
+	stk_agent_time_cb cb =3D agent->user_cb;
+	DBusMessage *reply =3D dbus_pending_call_steal_reply(call);
+	enum stk_agent_result result;
+	gboolean remove_agent;
+	int year_dbus;
+	unsigned char year;
+	unsigned char month;
+	unsigned char day;
+	unsigned char hour;
+	unsigned char minute;
+	unsigned char second;
+	int timezone_dbus;
+	char timezone;
+
+	if (check_error(agent, reply,
+			ALLOWED_ERROR_GO_BACK | ALLOWED_ERROR_TERMINATE,
+			&result) =3D=3D -EINVAL) {
+		remove_agent =3D TRUE;
+		goto error;
+	}
+
+	if (result !=3D STK_AGENT_RESULT_OK) {
+		cb(result, 0, 0, 0, 0, 0, 0, 0xFF, agent->user_data);
+		goto done;
+	}
+
+	if (dbus_message_get_args(reply, NULL,
+					DBUS_TYPE_INT32, &year_dbus,
+					DBUS_TYPE_BYTE, &month,
+					DBUS_TYPE_BYTE, &day,
+					DBUS_TYPE_BYTE, &hour,
+					DBUS_TYPE_BYTE, &minute,
+					DBUS_TYPE_BYTE, &second,
+					DBUS_TYPE_INT32, &timezone_dbus,
+					DBUS_TYPE_INVALID) =3D=3D FALSE) {
+		ofono_error("Can't parse the reply to RequestTime()");
+		remove_agent =3D TRUE;
+		goto error;
+	}
+
+	if (year_dbus < 1900) {
+		ofono_error("Invalid year");
+		remove_agent =3D TRUE;
+		goto error;
+	}
+
+	if (year_dbus >=3D 2000)
+		year =3D year_dbus - 2000;
+	else
+		year =3D year_dbus - 1900;
+
+	timezone =3D timezone_dbus;
+
+	cb(result, year, month, day, hour, minute, second, timezone,
+							agent->user_data);
+
+	CALLBACK_END();
+}
+
+int stk_agent_request_time(struct stk_agent *agent, stk_agent_time_cb cb,
+				void *user_data, ofono_destroy_func destroy,
+				int timeout)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+
+	agent->msg =3D dbus_message_new_method_call(agent->bus, agent->path,
+							OFONO_SIM_APP_INTERFACE,
+							"RequestTime");
+	if (agent->msg =3D=3D NULL)
+		return -ENOMEM;
+
+	dbus_message_append_args(agent->msg, DBUS_TYPE_INVALID);
+
+	if (dbus_connection_send_with_reply(conn, agent->msg, &agent->call,
+						timeout) =3D=3D FALSE ||
+			agent->call =3D=3D NULL)
+		return -EIO;
+
+	agent->user_cb =3D cb;
+	agent->user_data =3D user_data;
+	agent->user_destroy =3D destroy;
+
+	dbus_pending_call_set_notify(agent->call, get_time_cb, agent, NULL);
+
+	return 0;
+}
+
+static void get_lang_cb(DBusPendingCall *call, void *data)
+{
+	struct stk_agent *agent =3D data;
+	stk_agent_string_cb cb =3D agent->user_cb;
+	DBusMessage *reply =3D dbus_pending_call_steal_reply(call);
+	enum stk_agent_result result;
+	gboolean remove_agent;
+	char *lang;
+
+	if (check_error(agent, reply,
+			ALLOWED_ERROR_GO_BACK | ALLOWED_ERROR_TERMINATE,
+			&result) =3D=3D -EINVAL) {
+		remove_agent =3D TRUE;
+		goto error;
+	}
+
+	if (result !=3D STK_AGENT_RESULT_OK) {
+		cb(result, NULL, agent->user_data);
+		goto done;
+	}
+
+	if (dbus_message_get_args(reply, NULL,
+					DBUS_TYPE_STRING, &lang,
+					DBUS_TYPE_INVALID) =3D=3D FALSE ||
+			strlen(lang) !=3D 2) {
+		ofono_error("Can't parse the reply to RequestLanguage()");
+		remove_agent =3D TRUE;
+		goto error;
+	}
+
+	cb(result, lang, agent->user_data);
+
+	CALLBACK_END();
+}
+
+int stk_agent_request_lang(struct stk_agent *agent, stk_agent_string_cb cb,
+				void *user_data, ofono_destroy_func destroy,
+				int timeout)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+
+	agent->msg =3D dbus_message_new_method_call(agent->bus, agent->path,
+							OFONO_SIM_APP_INTERFACE,
+							"RequestLanguage");
+	if (agent->msg =3D=3D NULL)
+		return -ENOMEM;
+
+	dbus_message_append_args(agent->msg, DBUS_TYPE_INVALID);
+
+	if (dbus_connection_send_with_reply(conn, agent->msg, &agent->call,
+						timeout) =3D=3D FALSE ||
+			agent->call =3D=3D NULL)
+		return -EIO;
+
+	agent->user_cb =3D cb;
+	agent->user_data =3D user_data;
+	agent->user_destroy =3D destroy;
+
+	dbus_pending_call_set_notify(agent->call, get_lang_cb, agent, NULL);
+
+	return 0;
+}
diff --git a/src/stkagent.h b/src/stkagent.h
index c8e1886..a60cf23 100644
--- a/src/stkagent.h
+++ b/src/stkagent.h
@@ -59,6 +59,12 @@ typedef void (*stk_agent_string_cb)(enum stk_agent_resul=
t result,
 typedef void (*stk_agent_tone_cb)(enum stk_agent_result result,
 						void *user_data);
 =

+typedef void (*stk_agent_time_cb)(enum stk_agent_result result,
+				unsigned char year, unsigned char month,
+				unsigned char day, unsigned char hour,
+				unsigned char minute, unsigned char second,
+				char timezone, void *user_data);
+
 struct stk_agent *stk_agent_new(const char *path, const char *sender,
 					ofono_bool_t remove_on_terminate);
 =

@@ -136,3 +142,11 @@ int stk_agent_loop_tone(struct stk_agent *agent, const=
 char *text,
 =

 void append_menu_items_variant(DBusMessageIter *iter,
 				const struct stk_menu_item *items);
+
+int stk_agent_request_time(struct stk_agent *agent, stk_agent_time_cb cb,
+			void *user_data, ofono_destroy_func destroy,
+			int timeout);
+
+int stk_agent_request_lang(struct stk_agent *agent, stk_agent_string_cb cb,
+			void *user_data, ofono_destroy_func destroy,
+			int timeout);
diff --git a/src/stkutil.c b/src/stkutil.c
index 377ceff..48ce93b 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -4553,7 +4553,7 @@ static gboolean build_dataobj_datetime_timezone(struc=
t stk_tlv_builder *tlv,
 		return TRUE;
 =

 	/* Time zone information is optional */
-	if (scts->timezone =3D=3D (gint8) 0xff) {
+	if (scts->timezone =3D=3D -48) {
 		memcpy(&timestamp, scts, sizeof(timestamp));
 		timestamp.timezone =3D 0;
 		if (sms_encode_scts(&timestamp, value, &offset) !=3D TRUE)
-- =

1.7.2.3


--===============0484110652274452536==--

