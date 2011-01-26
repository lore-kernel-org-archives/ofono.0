Content-Type: multipart/mixed; boundary="===============2158302216326408924=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH v3] stk: Fix issue in stk_alpha_id_set
Date: Wed, 26 Jan 2011 12:15:11 -0800
Message-ID: <1296072911-3301-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2158302216326408924==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fixes the crash seen with the null alpha identifier.
Also removed the icon check as icon will always be a valid pointer.
---
 src/stk.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index 29d2087..b0be7b8 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -479,7 +479,12 @@ static void stk_alpha_id_set(struct ofono_stk *stk,
 {
 	char *alpha =3D dbus_apply_text_attributes(text, attr);
 =

-	if (alpha || icon)
+	/*
+	 * Currently, we are treating null data object(len =3D 0, no value part)
+	 * and no alpha identifier cases equally. This may be changed once
+	 * better idea is found out.
+	 */
+	if (alpha !=3D NULL)
 		stk_agent_display_action_info(stk->current_agent, alpha, icon);
 =

 	g_free(alpha);
-- =

1.7.0.4


--===============2158302216326408924==--

