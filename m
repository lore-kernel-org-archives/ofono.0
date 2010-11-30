Content-Type: multipart/mixed; boundary="===============4045171193790511215=="
MIME-Version: 1.0
From: Lucas, GuillaumeX <guillaumex.lucas@intel.com>
Subject: [PATCH] stk: Add busy error for the display text command
Date: Tue, 30 Nov 2010 13:21:50 +0000
Message-ID: <9F3EABD6E3419B4C81F34EAABB4D4018813547DA8B@irsmsx501.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4045171193790511215==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Guillaume Lucas <guillaumex.lucas@intel.com>

According to the sequence 1.2 of the ETSI TS 102 384 a busy
screen error should be returns for the display text proactive
command when the ME is not able to display the text.
---
 doc/stk-api.txt |    1 +
 src/stk.c       |   15 +++++++++++++++
 src/stkagent.c  |   12 ++++++++++--
 src/stkagent.h  |    1 +
 4 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/doc/stk-api.txt b/doc/stk-api.txt
index b9ca592..79daee6 100644
--- a/doc/stk-api.txt
+++ b/doc/stk-api.txt
@@ -116,6 +116,7 @@ Methods		byte RequestSelection(string title, byte icon_=
id,
 			cleared prior to the display of this text.
 =

 			Possible Errors: [service].Error.SimToolkit.GoBack
+					 [service].Error.SimToolkit.Busy
 =

 			Implementation notes:
 =

diff --git a/src/stk.c b/src/stk.c
index a4abb7d..7b39f7e 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -1203,6 +1203,9 @@ static void display_text_cb(enum stk_agent_result res=
ult, void *user_data)
 {
 	struct ofono_stk *stk =3D user_data;
 	gboolean confirm;
+	struct stk_response rsp;
+	static unsigned char screen_busy_result[] =3D { 0x01 };
+	static struct ofono_error error =3D { .type =3D OFONO_ERROR_TYPE_FAILURE =
};
 =

 	stk->respond_on_exit =3D FALSE;
 =

@@ -1250,6 +1253,15 @@ static void display_text_cb(enum stk_agent_result re=
sult, void *user_data)
 			STK_RESULT_TYPE_NO_RESPONSE : STK_RESULT_TYPE_SUCCESS);
 		break;
 =

+	case STK_AGENT_RESULT_BUSY:
+		memset(&rsp, 0, sizeof(rsp));
+		rsp.result.type =3D STK_RESULT_TYPE_TERMINAL_BUSY;
+		rsp.result.additional_len =3D sizeof(screen_busy_result);
+		rsp.result.additional =3D screen_busy_result;
+		if (stk_respond(stk, &rsp, stk_command_cb))
+			stk_command_cb(&error, stk);
+		break;
+
 	case STK_AGENT_RESULT_TERMINATE:
 	default:
 		send_simple_response(stk, STK_RESULT_TYPE_USER_TERMINATED);
@@ -1366,6 +1378,7 @@ static void request_confirmation_cb(enum stk_agent_re=
sult result,
 		break;
 =

 	case STK_AGENT_RESULT_TERMINATE:
+	default:
 		send_simple_response(stk, STK_RESULT_TYPE_USER_TERMINATED);
 		break;
 	}
@@ -1408,6 +1421,7 @@ static void request_key_cb(enum stk_agent_result resu=
lt, char *string,
 		break;
 =

 	case STK_AGENT_RESULT_TERMINATE:
+	default:
 		send_simple_response(stk, STK_RESULT_TYPE_USER_TERMINATED);
 		break;
 	}
@@ -1505,6 +1519,7 @@ static void request_string_cb(enum stk_agent_result r=
esult, char *string,
 		break;
 =

 	case STK_AGENT_RESULT_TERMINATE:
+	default:
 		send_simple_response(stk, STK_RESULT_TYPE_USER_TERMINATED);
 		break;
 	}
diff --git a/src/stkagent.c b/src/stkagent.c
index 8315040..874b6dd 100644
--- a/src/stkagent.c
+++ b/src/stkagent.c
@@ -41,6 +41,7 @@
 enum allowed_error {
 	ALLOWED_ERROR_GO_BACK	=3D 0x1,
 	ALLOWED_ERROR_TERMINATE	=3D 0x2,
+	ALLOWED_ERROR_BUSY		=3D 0x4,
 };
 =

 struct stk_agent {
@@ -62,6 +63,7 @@ struct stk_agent {
 #define ERROR_PREFIX OFONO_SERVICE ".Error"
 #define GOBACK_ERROR ERROR_PREFIX ".GoBack"
 #define TERMINATE_ERROR ERROR_PREFIX ".EndSession"
+#define BUSY_ERROR ERROR_PREFIX ".Busy"
 =

 static void stk_agent_send_noreply(struct stk_agent *agent, const char *me=
thod)
 {
@@ -194,6 +196,12 @@ static int check_error(struct stk_agent *agent, DBusMe=
ssage *reply,
 		goto out;
 	}
 =

+	if ((allowed_errors & ALLOWED_ERROR_BUSY) &&
+			g_str_equal(err.name, BUSY_ERROR)) {
+		*out_result =3D STK_AGENT_RESULT_BUSY;
+		goto out;
+	}
+
 	result =3D -EINVAL;
 =

 out:
@@ -376,8 +384,8 @@ static void display_text_cb(DBusPendingCall *call, void=
 *data)
 	gboolean remove_agent;
 =

 	if (check_error(agent, reply,
-			ALLOWED_ERROR_GO_BACK | ALLOWED_ERROR_TERMINATE,
-			&result) =3D=3D -EINVAL) {
+			ALLOWED_ERROR_GO_BACK | ALLOWED_ERROR_TERMINATE | =

+			ALLOWED_ERROR_BUSY, &result) =3D=3D -EINVAL) {
 		remove_agent =3D TRUE;
 		goto error;
 	}
diff --git a/src/stkagent.h b/src/stkagent.h
index c8e1886..517bcfe 100644
--- a/src/stkagent.h
+++ b/src/stkagent.h
@@ -26,6 +26,7 @@ enum stk_agent_result {
 	STK_AGENT_RESULT_BACK,
 	STK_AGENT_RESULT_TERMINATE,
 	STK_AGENT_RESULT_TIMEOUT,
+	STK_AGENT_RESULT_BUSY,
 };
 =

 struct stk_menu_item {
-- =

1.7.0.4

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


--===============4045171193790511215==--

