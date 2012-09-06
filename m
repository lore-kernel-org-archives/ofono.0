Content-Type: multipart/mixed; boundary="===============2700901177468548797=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH v2 2/2] stk: AID shall not be displayed in case of self
 explanatory icon
Date: Thu, 06 Sep 2012 16:26:29 +0200
Message-ID: <1346941589-3335-2-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1346941589-3335-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2700901177468548797==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/src/stk.c b/src/stk.c
index 0a279bf..87b8465 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -539,6 +539,18 @@ static gboolean stk_alpha_id_set(struct ofono_stk *stk,
 	if (stk->current_agent =3D=3D NULL)
 		return FALSE;
 =

+	/*
+	 * According to 3GPP=C2=A0TS=C2=A0102.223 section 8.31:
+	 * If icon is self-explanatory, it replaces the alpha identifier or
+	 * text string.
+	 * If icon is not self-explanatory, it shall be displayed together
+	 * with the alpha identifier or text string.
+	 */
+
+	if (icon->id !=3D 0 && icon->qualifier =3D=3D
+			STK_ICON_QUALIFIER_TYPE_SELF_EXPLANATORY)
+		alpha[0]=3D'\0';
+
 	if (stk->respond_on_exit)
 		stk_agent_display_action(stk->current_agent, alpha, icon,
 						user_termination_cb, stk, NULL);
-- =

1.7.9.5


--===============2700901177468548797==--

