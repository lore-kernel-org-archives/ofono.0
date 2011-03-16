Content-Type: multipart/mixed; boundary="===============2082268683060118992=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 1/1] stk: fix issue with Get Inkey variable timeout
Date: Wed, 16 Mar 2011 10:57:30 -0700
Message-ID: <1300298250-2205-2-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1300298250-2205-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2082268683060118992==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c |   28 ++++++++++++++++++++++++++--
 1 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index e933e4e..68b6240 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -1396,7 +1396,19 @@ static void request_confirmation_cb(enum stk_agent_r=
esult result,
 		break;
 =

 	case STK_AGENT_RESULT_TIMEOUT:
-		send_simple_response(stk, STK_RESULT_TYPE_NO_RESPONSE);
+		memset(&rsp, 0, sizeof(rsp));
+
+		rsp.result.type =3D STK_RESULT_TYPE_NO_RESPONSE;
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
 		break;
 =

 	case STK_AGENT_RESULT_TERMINATE:
@@ -1439,7 +1451,19 @@ static void request_key_cb(enum stk_agent_result res=
ult, char *string,
 		break;
 =

 	case STK_AGENT_RESULT_TIMEOUT:
-		send_simple_response(stk, STK_RESULT_TYPE_NO_RESPONSE);
+		memset(&rsp, 0, sizeof(rsp));
+
+		rsp.result.type =3D STK_RESULT_TYPE_NO_RESPONSE;
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
 		break;
 =

 	case STK_AGENT_RESULT_TERMINATE:
-- =

1.7.0.4


--===============2082268683060118992==--

