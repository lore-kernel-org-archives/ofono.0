Content-Type: multipart/mixed; boundary="===============1840531908531054986=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 3/9] stk: Handle the More Time command as a nop.
Date: Tue, 29 Jun 2010 12:14:02 +0200
Message-ID: <1277806448-5322-3-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1277806448-5322-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1840531908531054986==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index e513b06..4edf05b 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -154,6 +154,15 @@ void ofono_stk_proactive_command_cancel(struct ofono_s=
tk *stk)
 	stk->cancel_cmd(stk);
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
 void ofono_stk_proactive_command_notify(struct ofono_stk *stk,
 					int length, const unsigned char *pdu)
 {
@@ -192,6 +201,10 @@ void ofono_stk_proactive_command_notify(struct ofono_s=
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


--===============1840531908531054986==--

