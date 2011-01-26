Content-Type: multipart/mixed; boundary="===============0408842529817246346=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH v2] stk: Fix issue in stk_alpha_id_set
Date: Wed, 26 Jan 2011 11:48:55 -0800
Message-ID: <1296071335-2592-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0408842529817246346==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fixes the crash seen with the null alpha identifier.
Also removed the icon check as icon will always be a valid pointer.
---
 src/stk.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index 29d2087..8ae3346 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -477,9 +477,14 @@ static void stk_alpha_id_set(struct ofono_stk *stk,
 		const char *text, const struct stk_text_attribute *attr,
 		const struct stk_icon_id *icon)
 {
-	char *alpha =3D dbus_apply_text_attributes(text, attr);
+	char *alpha =3D dbus_apply_text_attributes(text ? text : "", attr);
 =

-	if (alpha || icon)
+	/*
+	 * Currently, we are treating null data object(len =3D 0, no value part)
+	 * and no alpha identifier cases equally. This has to be changed once
+	 * better idea is found out.
+	 */
+	if (alpha !=3D NULL)
 		stk_agent_display_action_info(stk->current_agent, alpha, icon);
 =

 	g_free(alpha);
-- =

1.7.0.4


--===============0408842529817246346==--

