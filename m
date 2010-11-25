Content-Type: multipart/mixed; boundary="===============0963481493613897864=="
MIME-Version: 1.0
From: Lucas, GuillaumeX <guillaumex.lucas@intel.com>
Subject: [PATCH] stk: Add busy error for the display text command
Date: Thu, 25 Nov 2010 08:44:15 +0000
Message-ID: <9F3EABD6E3419B4C81F34EAABB4D4018813547CFDD@irsmsx501.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0963481493613897864==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Guillaume Lucas <guillaumex.lucas@intel.com>

According to the sequence 1.2 of the ETSI TS 102 384 a busy
screen error type must be returned for the display text =

proactive command when the message is not urgent and if the
ME is not able to display the text.
---
 doc/stk-api.txt |    1 +
 src/stk.c       |    7 +++++++
 src/stkagent.c  |   12 ++++++++++--
 src/stkagent.h  |    1 +
 4 files changed, 19 insertions(+), 2 deletions(-)

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
index ac2e646..e6b78a4 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -1250,6 +1250,10 @@ static void display_text_cb(enum stk_agent_result re=
sult, void *user_data)
 			STK_RESULT_TYPE_NO_RESPONSE : STK_RESULT_TYPE_SUCCESS);
 		break;
 =

+	case STK_AGENT_RESULT_BUSY:
+		send_simple_response(stk, STK_RESULT_TYPE_TERMINAL_BUSY);
+		break;
+
 	case STK_AGENT_RESULT_TERMINATE:
 	default:
 		send_simple_response(stk, STK_RESULT_TYPE_USER_TERMINATED);
@@ -1363,6 +1367,7 @@ static void request_confirmation_cb(enum stk_agent_re=
sult result,
 		break;
 =

 	case STK_AGENT_RESULT_TERMINATE:
+	default:
 		send_simple_response(stk, STK_RESULT_TYPE_USER_TERMINATED);
 		break;
 	}
@@ -1405,6 +1410,7 @@ static void request_key_cb(enum stk_agent_result resu=
lt, char *string,
 		break;
 =

 	case STK_AGENT_RESULT_TERMINATE:
+	default:
 		send_simple_response(stk, STK_RESULT_TYPE_USER_TERMINATED);
 		break;
 	}
@@ -1502,6 +1508,7 @@ static void request_string_cb(enum stk_agent_result r=
esult, char *string,
 		break;
 =

 	case STK_AGENT_RESULT_TERMINATE:
+	default:
 		send_simple_response(stk, STK_RESULT_TYPE_USER_TERMINATED);
 		break;
 	}
diff --git a/src/stkagent.c b/src/stkagent.c
index 5cf83e4..6e8aff6 100644
--- a/src/stkagent.c
+++ b/src/stkagent.c
@@ -41,6 +41,7 @@
 enum allowed_error {
 	ALLOWED_ERROR_GO_BACK	=3D 0x1,
 	ALLOWED_ERROR_TERMINATE	=3D 0x2,
+	ALLOWED_ERROR_BUSY	=3D 0x4,
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


--===============0963481493613897864==--

