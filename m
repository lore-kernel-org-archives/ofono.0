Content-Type: multipart/mixed; boundary="===============8286900596910739717=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH] stkagent: Sanitize any output from the agent
Date: Tue, 28 Aug 2012 15:32:41 +0200
Message-ID: <1346160761-11888-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8286900596910739717==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkagent.c |   56 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
+---
 1 file changed, 53 insertions(+), 3 deletions(-)

diff --git a/src/stkagent.c b/src/stkagent.c
index 63b82f3..dbcc962 100644
--- a/src/stkagent.c
+++ b/src/stkagent.c
@@ -59,6 +59,9 @@ struct stk_agent {
 	DBusPendingCall *call;
 	void *user_cb;
 	void *user_data;
+	int min_length;
+	int max_length;
+	ofono_bool_t hidden_entry;
 	ofono_destroy_func user_destroy;
 =

 	const struct stk_menu *request_selection_menu;
@@ -539,14 +542,24 @@ static void get_digit_cb(DBusPendingCall *call, void =
*data)
 =

 	if (dbus_message_get_args(reply, NULL,
 					DBUS_TYPE_STRING, &digit,
-					DBUS_TYPE_INVALID) =3D=3D FALSE ||
-			strlen(digit) !=3D 1 ||
-			!valid_phone_number_format(digit)) {
+					DBUS_TYPE_INVALID) =3D=3D FALSE) {
 		ofono_error("Can't parse the reply to GetDigit()");
 		remove_agent =3D TRUE;
 		goto error;
 	}
 =

+	if (strlen(digit) !=3D 1 || !strspn(digit, "0123456789*#+")) {
+		ofono_error("Invalid character");
+		remove_agent =3D TRUE;
+		goto error;
+	}
+
+	if (agent->hidden_entry && digit[0] =3D=3D '+') {
+		ofono_error("The character + is not allowed in this mode");
+		remove_agent =3D TRUE;
+		goto error;
+	}
+
 	cb(result, digit, agent->user_data);
 =

 	CALLBACK_END();
@@ -578,6 +591,7 @@ int stk_agent_request_digit(struct stk_agent *agent, co=
nst char *text,
 	agent->user_cb =3D cb;
 	agent->user_data =3D user_data;
 	agent->user_destroy =3D destroy;
+	agent->hidden_entry =3D FALSE;
 =

 	dbus_pending_call_set_notify(agent->call, get_digit_cb, agent, NULL);
 =

@@ -610,6 +624,7 @@ int stk_agent_request_quick_digit(struct stk_agent *age=
nt, const char *text,
 	agent->user_cb =3D cb;
 	agent->user_data =3D user_data;
 	agent->user_destroy =3D destroy;
+	agent->hidden_entry =3D TRUE;
 =

 	dbus_pending_call_set_notify(agent->call, get_digit_cb, agent, NULL);
 =

@@ -692,6 +707,7 @@ static void get_digits_cb(DBusPendingCall *call, void *=
data)
 	enum stk_agent_result result;
 	gboolean remove_agent;
 	char *string;
+	int len, span;
 =

 	if (check_error(agent, reply,
 			ALLOWED_ERROR_GO_BACK | ALLOWED_ERROR_TERMINATE,
@@ -713,6 +729,25 @@ static void get_digits_cb(DBusPendingCall *call, void =
*data)
 		goto error;
 	}
 =

+	len =3D strlen(string);
+
+	if (len < agent->min_length || len > agent->max_length) {
+		ofono_error("Length not acceptable");
+		remove_agent =3D TRUE;
+		goto error;
+	}
+
+	if (agent->hidden_entry)
+		span =3D strspn(string, "0123456789*#");
+	else
+		span =3D strspn(string, "0123456789*#+");
+
+	if (span !=3D len) {
+		ofono_error("Invalid character found");
+		remove_agent =3D TRUE;
+		goto error;
+	}
+
 	cb(result, string, agent->user_data);
 =

 	CALLBACK_END();
@@ -756,6 +791,9 @@ int stk_agent_request_digits(struct stk_agent *agent, c=
onst char *text,
 	agent->user_cb =3D cb;
 	agent->user_data =3D user_data;
 	agent->user_destroy =3D destroy;
+	agent->min_length =3D min_val;
+	agent->max_length =3D max_val;
+	agent->hidden_entry =3D hidden_val;
 =

 	dbus_pending_call_set_notify(agent->call, get_digits_cb, agent, NULL);
 =

@@ -770,6 +808,7 @@ static void get_input_cb(DBusPendingCall *call, void *d=
ata)
 	enum stk_agent_result result;
 	gboolean remove_agent;
 	char *string;
+	int len;
 =

 	if (check_error(agent, reply,
 			ALLOWED_ERROR_GO_BACK | ALLOWED_ERROR_TERMINATE,
@@ -791,6 +830,14 @@ static void get_input_cb(DBusPendingCall *call, void *=
data)
 		goto error;
 	}
 =

+	len =3D g_utf8_strlen(string, -1);
+
+	if (len < agent->min_length || len > agent->max_length) {
+		ofono_error("Length not acceptable");
+		remove_agent =3D TRUE;
+		goto error;
+	}
+
 	cb(result, string, agent->user_data);
 =

 	CALLBACK_END();
@@ -835,6 +882,9 @@ int stk_agent_request_input(struct stk_agent *agent, co=
nst char *text,
 	agent->user_cb =3D cb;
 	agent->user_data =3D user_data;
 	agent->user_destroy =3D destroy;
+	agent->min_length =3D min_val;
+	agent->max_length =3D max_val;
+	agent->hidden_entry =3D hidden_val;
 =

 	dbus_pending_call_set_notify(agent->call, get_input_cb, agent, NULL);
 =

-- =

1.7.9.5


--===============8286900596910739717==--

