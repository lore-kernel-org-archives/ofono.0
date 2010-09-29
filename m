Content-Type: multipart/mixed; boundary="===============2592599001114052829=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH] stk: Additional info for failed Send USSD case
Date: Wed, 29 Sep 2010 05:28:16 -0700
Message-ID: <1285763296-7208-2-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1285763296-7208-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2592599001114052829==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index bbbc4fd..59771b0 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -1621,6 +1621,7 @@ static void send_ussd_callback(int error, int dcs, co=
nst unsigned char *msg,
 	struct ofono_error failure =3D { .type =3D OFONO_ERROR_TYPE_FAILURE };
 	struct stk_response rsp;
 	enum sms_charset charset;
+	unsigned char addnl;
 =

 	if (stk->pending_cmd->send_ussd.alpha_id &&
 			stk->pending_cmd->send_ussd.alpha_id[0])
@@ -1661,7 +1662,14 @@ static void send_ussd_callback(int error, int dcs, c=
onst unsigned char *msg,
 		break;
 =

 	default:
-		send_simple_response(stk, STK_RESULT_TYPE_USSD_RETURN_ERROR);
+		rsp.result.type =3D STK_RESULT_TYPE_USSD_RETURN_ERROR;
+		addnl =3D 0; /* No specific cause can be given */
+		rsp.result.additional =3D &addnl;
+		rsp.result.additional_len =3D 1;
+
+		if (stk_respond(stk, &rsp, stk_command_cb))
+			stk_command_cb(&failure, stk);
+
 		break;
 	}
 }
-- =

1.7.0.4


--===============2592599001114052829==--

