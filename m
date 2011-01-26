Content-Type: multipart/mixed; boundary="===============2062756189486734784=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH] stk: Fix issue in stk_alpha_id_set
Date: Wed, 26 Jan 2011 16:43:27 +0200
Message-ID: <1296053007-1110-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2062756189486734784==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fixes the crash seen when the null alpha identifier.
Also removed the icon check as icon will always be a
valid pointer.
---
 src/stk.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index 29d2087..c968eef 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -477,9 +477,9 @@ static void stk_alpha_id_set(struct ofono_stk *stk,
 		const char *text, const struct stk_text_attribute *attr,
 		const struct stk_icon_id *icon)
 {
-	char *alpha =3D dbus_apply_text_attributes(text, attr);
+	char *alpha =3D dbus_apply_text_attributes(text ? text : "", attr);
 =

-	if (alpha || icon)
+	if (alpha !=3D NULL && alpha[0] !=3D '\0')
 		stk_agent_display_action_info(stk->current_agent, alpha, icon);
 =

 	g_free(alpha);
-- =

1.7.0.4


--===============2062756189486734784==--

