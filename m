Content-Type: multipart/mixed; boundary="===============0285172510443597622=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH] stk: fix issue in set up menu handling
Date: Mon, 27 Dec 2010 21:07:02 +0200
Message-ID: <1293476822-2532-2-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1293476822-2532-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0285172510443597622==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c |   28 +++++++++++++++-------------
 1 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index 9dcbda6..5e5c2e4 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -1093,26 +1093,28 @@ static gboolean handle_command_set_up_menu(const st=
ruct stk_command *cmd,
 						struct stk_response *rsp,
 						struct ofono_stk *stk)
 {
-	gboolean modified =3D FALSE;
+	struct stk_menu *menu =3D NULL;
 =

-	if (stk->main_menu) {
-		stk_menu_free(stk->main_menu);
-		stk->main_menu =3D NULL;
+	if (cmd->setup_menu.items) {
+		menu =3D stk_menu_create_from_set_up_menu(cmd);
 =

-		modified =3D TRUE;
+		if (menu =3D=3D NULL) {
+			rsp->result.type =3D STK_RESULT_TYPE_DATA_NOT_UNDERSTOOD;
+			return TRUE;
+		}
 	}
 =

-	if (cmd->setup_menu.items) {
-		stk->main_menu =3D stk_menu_create_from_set_up_menu(cmd);
+	if (menu =3D=3D NULL && stk->main_menu =3D=3D NULL)
+		return TRUE;
 =

-		if (stk->main_menu)
-			modified =3D TRUE;
-		else
-			rsp->result.type =3D STK_RESULT_TYPE_DATA_NOT_UNDERSTOOD;
+	if (stk->main_menu) {
+		stk_menu_free(stk->main_menu);
+		stk->main_menu =3D NULL;
 	}
 =

-	if (modified)
-		emit_menu_changed(stk);
+	stk->main_menu =3D menu;
+
+	emit_menu_changed(stk);
 =

 	return TRUE;
 }
-- =

1.7.0.4


--===============0285172510443597622==--

