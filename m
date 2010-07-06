Content-Type: multipart/mixed; boundary="===============6656928307987300875=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 03/14] stk: Handle the More Time proactive command as a nop.
Date: Wed, 07 Jul 2010 00:38:58 +0200
Message-ID: <1278455949-2823-4-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1278455949-2823-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6656928307987300875==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index 66b0a6b..ba66fe2 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -143,6 +143,15 @@ static void stk_command_cb(const struct ofono_error *e=
rror, void *data)
 	DBG("TERMINAL RESPONSE to a command reported no errors");
 }
 =

+static gboolean handle_command_more_time(const struct stk_command *cmd,
+						struct stk_response *rsp,
+						struct ofono_stk *stk)
+{
+	/* Do nothing */
+
+	return TRUE;
+}
+
 static void stk_proactive_command_cancel(struct ofono_stk *stk)
 {
 	if (!stk->pending_cmd)
@@ -213,6 +222,10 @@ void ofono_stk_proactive_command_notify(struct ofono_s=
tk *stk,
 			rsp.result.type =3D
 				STK_RESULT_TYPE_COMMAND_NOT_UNDERSTOOD;
 			break;
+		case STK_COMMAND_TYPE_MORE_TIME:
+			respond =3D handle_command_more_time(stk->pending_cmd,
+								&rsp, stk);
+			break;
 		}
 =

 		if (respond)
-- =

1.7.1.86.g0e460.dirty


--===============6656928307987300875==--

