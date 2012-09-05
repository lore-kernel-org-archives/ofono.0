Content-Type: multipart/mixed; boundary="===============1877034307861672098=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 4/4] stk: AID shall not be displayed in case of self
 explanatory icon
Date: Wed, 05 Sep 2012 19:19:39 +0200
Message-ID: <1346865579-24794-5-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1346865579-24794-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1877034307861672098==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/stk.c b/src/stk.c
index 5c79183..e242bf5 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -539,6 +539,11 @@ static gboolean stk_alpha_id_set(struct ofono_stk *stk,
 	if (stk->current_agent =3D=3D NULL)
 		return FALSE;
 =

+	/* AID shall not be displayed in case of self explanatory icon */
+	if (icon->id !=3D 0 && icon->qualifier =3D=3D
+			STK_ICON_QUALIFIER_TYPE_SELF_EXPLANATORY)
+		alpha[0]=3D'\0';
+
 	if (stk->respond_on_exit)
 		stk_agent_display_action(stk->current_agent, alpha, icon,
 						user_termination_cb, stk, NULL);
-- =

1.7.9.5


--===============1877034307861672098==--

