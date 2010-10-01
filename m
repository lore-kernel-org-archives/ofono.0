Content-Type: multipart/mixed; boundary="===============5871745435267973139=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH] stk: Additional info for failed Send USSD case
Date: Thu, 30 Sep 2010 23:32:57 -0700
Message-ID: <1285914777-25989-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5871745435267973139==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index bbbc4fd..80b4d23 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -1621,6 +1621,7 @@ static void send_ussd_callback(int error, int dcs, co=
nst unsigned char *msg,
 	struct ofono_error failure =3D { .type =3D OFONO_ERROR_TYPE_FAILURE };
 	struct stk_response rsp;
 	enum sms_charset charset;
+	unsigned char no_cause[] =3D { 0x00 };
 =

 	if (stk->pending_cmd->send_ussd.alpha_id &&
 			stk->pending_cmd->send_ussd.alpha_id[0])
@@ -1661,7 +1662,13 @@ static void send_ussd_callback(int error, int dcs, c=
onst unsigned char *msg,
 		break;
 =

 	default:
-		send_simple_response(stk, STK_RESULT_TYPE_USSD_RETURN_ERROR);
+		rsp.result.type =3D STK_RESULT_TYPE_USSD_RETURN_ERROR;
+		rsp.result.additional_len =3D sizeof(no_cause);
+		rsp.result.additional =3D no_cause;
+
+		if (stk_respond(stk, &rsp, stk_command_cb))
+			stk_command_cb(&failure, stk);
+
 		break;
 	}
 }
-- =

1.7.0.4


--===============5871745435267973139==--

