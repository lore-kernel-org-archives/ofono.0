Content-Type: multipart/mixed; boundary="===============3769304973441101440=="
MIME-Version: 1.0
From: Yang Gu <gyagp0@gmail.com>
Subject: [PATCH 8/8] Move destructor prior to return
Date: Wed, 26 May 2010 22:39:14 +0800
Message-ID: <1274884754-12977-8-git-send-email-yang.gu@intel.com>
In-Reply-To: <1274884754-12977-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3769304973441101440==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   60 +++++++++++++++++++++++++----------------------------=
---
 1 files changed, 27 insertions(+), 33 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 3adb9e3..1a0c678 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -2116,11 +2116,11 @@ static gboolean parse_display_text(struct stk_comma=
nd *command,
 				&obj->frame_id,
 				STK_DATA_OBJECT_TYPE_INVALID);
 =

+	command->destructor =3D destroy_display_text;
+
 	if (ret =3D=3D FALSE)
 		return FALSE;
 =

-	command->destructor =3D destroy_display_text;
-
 	return TRUE;
 }
 =

@@ -2154,11 +2154,11 @@ static gboolean parse_get_inkey(struct stk_command =
*command,
 				&obj->frame_id,
 				STK_DATA_OBJECT_TYPE_INVALID);
 =

+	command->destructor =3D destroy_get_inkey;
+
 	if (ret =3D=3D FALSE)
 		return FALSE;
 =

-	command->destructor =3D destroy_get_inkey;
-
 	return TRUE;
 }
 =

@@ -2196,11 +2196,11 @@ static gboolean parse_get_input(struct stk_command =
*command,
 				&obj->frame_id,
 				STK_DATA_OBJECT_TYPE_INVALID);
 =

+	command->destructor =3D destroy_get_input;
+
 	if (ret =3D=3D FALSE)
 		return FALSE;
 =

-	command->destructor =3D destroy_get_input;
-
 	return TRUE;
 }
 =

@@ -2247,11 +2247,11 @@ static gboolean parse_play_tone(struct stk_command =
*command,
 				&obj->frame_id,
 				STK_DATA_OBJECT_TYPE_INVALID);
 =

+	command->destructor =3D destroy_play_tone;
+
 	if (ret =3D=3D FALSE)
 		return FALSE;
 =

-	command->destructor =3D destroy_play_tone;
-
 	return TRUE;
 }
 =

@@ -2275,8 +2275,6 @@ static gboolean parse_poll_interval(struct stk_comman=
d *command,
 	if (ret =3D=3D FALSE)
 		return FALSE;
 =

-	command->destructor =3D NULL;
-
 	return TRUE;
 }
 =

@@ -2330,10 +2328,12 @@ static gboolean parse_setup_menu(struct stk_command=
 *command,
 	gboolean ret;
 =

 	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
-		goto error;
+		return FALSE;
 =

 	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_TERMINAL)
-		goto error;
+		return FALSE;
+
+	command->destructor =3D destroy_setup_menu;
 =

 	ret =3D parse_dataobj(iter,
 			STK_DATA_OBJECT_TYPE_ALPHA_ID,
@@ -2342,12 +2342,12 @@ static gboolean parse_setup_menu(struct stk_command=
 *command,
 			STK_DATA_OBJECT_TYPE_INVALID);
 =

 	if (ret =3D=3D FALSE)
-		goto error;
+		return FALSE;
 =

 	obj->items =3D parse_item_list(iter);
 =

 	if (obj->items =3D=3D NULL)
-		goto error;
+		return FALSE;
 =

 	ret =3D parse_dataobj(iter,
 			STK_DATA_OBJECT_TYPE_ITEMS_NEXT_ACTION_INDICATOR, 0,
@@ -2363,15 +2363,9 @@ static gboolean parse_setup_menu(struct stk_command =
*command,
 			STK_DATA_OBJECT_TYPE_INVALID);
 =

 	if (ret =3D=3D FALSE)
-		goto error;
-
-	command->destructor =3D destroy_setup_menu;
+		return FALSE;
 =

 	return TRUE;
-
-error:
-	destroy_setup_menu(command);
-	return FALSE;
 }
 =

 static void destroy_select_item(struct stk_command *command)
@@ -2566,11 +2560,11 @@ static gboolean parse_setup_call(struct stk_command=
 *command,
 				&obj->frame_id,
 				STK_DATA_OBJECT_TYPE_INVALID);
 =

+	command->destructor =3D destroy_setup_call;
+
 	if (ret =3D=3D FALSE)
 		return FALSE;
 =

-	command->destructor =3D destroy_setup_call;
-
 	return TRUE;
 }
 =

@@ -2607,11 +2601,11 @@ static gboolean parse_refresh(struct stk_command *c=
ommand,
 				&obj->frame_id,
 				STK_DATA_OBJECT_TYPE_INVALID);
 =

+	command->destructor =3D destroy_refresh;
+
 	if (ret =3D=3D FALSE)
 		return FALSE;
 =

-	command->destructor =3D destroy_refresh;
-
 	return TRUE;
 }
 =

@@ -2790,11 +2784,11 @@ static gboolean parse_setup_idle_mode_text(struct s=
tk_command *command,
 				&obj->frame_id,
 				STK_DATA_OBJECT_TYPE_INVALID);
 =

+	command->destructor =3D destroy_setup_idle_mode_text;
+
 	if (ret =3D=3D FALSE)
 		return FALSE;
 =

-	command->destructor =3D destroy_setup_idle_mode_text;
-
 	return TRUE;
 }
 =

@@ -2829,11 +2823,11 @@ static gboolean parse_run_at_command(struct stk_com=
mand *command,
 				&obj->frame_id,
 				STK_DATA_OBJECT_TYPE_INVALID);
 =

+	command->destructor =3D destroy_run_at_command;
+
 	if (ret =3D=3D FALSE)
 		return FALSE;
 =

-	command->destructor =3D destroy_run_at_command;
-
 	return TRUE;
 }
 =

@@ -2868,11 +2862,11 @@ static gboolean parse_send_dtmf(struct stk_command =
*command,
 				&obj->frame_id,
 				STK_DATA_OBJECT_TYPE_INVALID);
 =

+	command->destructor =3D destroy_send_dtmf;
+
 	if (ret =3D=3D FALSE)
 		return FALSE;
 =

-	command->destructor =3D destroy_send_dtmf;
-
 	return TRUE;
 }
 =

@@ -2987,11 +2981,11 @@ static gboolean parse_launch_browser(struct stk_com=
mand *command,
 			&obj->text_passwd,
 			STK_DATA_OBJECT_TYPE_INVALID);
 =

+	command->destructor =3D destroy_launch_browser;
+
 	if (ret =3D=3D FALSE)
 		return FALSE;
 =

-	command->destructor =3D destroy_launch_browser;
-
 	return TRUE;
 =

 error:
-- =

1.7.0.4


--===============3769304973441101440==--

