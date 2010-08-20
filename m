Content-Type: multipart/mixed; boundary="===============4788329516961681273=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] stk: reorder: Don't access freed memory in Send SMS
Date: Fri, 20 Aug 2010 04:07:09 +0200
Message-ID: <1282270029-2909-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4788329516961681273==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Responding to the stk->pending_cmd frees it, we need to read it
before that.
---
 src/stk.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index ce71075..f391396 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -695,6 +695,10 @@ static void send_sms_submit_cb(gboolean ok, void *data)
 		return;
 	}
 =

+	if (stk->pending_cmd->send_sms.alpha_id &&
+			stk->pending_cmd->send_sms.alpha_id[0])
+		stk_alpha_id_unset(stk);
+
 	memset(&rsp, 0, sizeof(rsp));
 =

 	if (ok =3D=3D FALSE)
@@ -702,10 +706,6 @@ static void send_sms_submit_cb(gboolean ok, void *data)
 =

 	if (stk_respond(stk, &rsp, stk_command_cb))
 		stk_command_cb(&failure, stk);
-
-	if (stk->pending_cmd->send_sms.alpha_id &&
-			stk->pending_cmd->send_sms.alpha_id[0])
-		stk_alpha_id_unset(stk);
 }
 =

 static gboolean handle_command_send_sms(const struct stk_command *cmd,
-- =

1.7.1.86.g0e460.dirty


--===============4788329516961681273==--

