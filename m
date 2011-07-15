Content-Type: multipart/mixed; boundary="===============3588373949600011324=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@linux.intel.com>
Subject: [PATCH] stk: Fix crash seen in stk_alpha_id_unset
Date: Fri, 15 Jul 2011 09:29:27 -0700
Message-ID: <1310747367-6817-1-git-send-email-jeevaka.badrappan@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3588373949600011324==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If there is no default agent, then current agent also will
be NULL. So, call stk_agent_request_cancel only when there is a valid
current agent.
---
 src/stk.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index 4df23b5..e8ffb42 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -529,7 +529,12 @@ static void stk_alpha_id_set(struct ofono_stk *stk,
 =

 static void stk_alpha_id_unset(struct ofono_stk *stk)
 {
-	stk_agent_request_cancel(stk->current_agent);
+	/*
+	 * If there is no default agent, then current agent also will be NULL.
+	 * So, call request cancel only when there is a valid current agent.
+	 */
+	if (stk->current_agent)
+		stk_agent_request_cancel(stk->current_agent);
 }
 =

 static int duration_to_msecs(const struct stk_duration *duration)
-- =

1.7.4.1


--===============3588373949600011324==--

