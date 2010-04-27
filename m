Content-Type: multipart/mixed; boundary="===============7429696620484399028=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 7/7] stkutil: Make get inkey parser use its own struct
Date: Tue, 27 Apr 2010 17:47:12 +0800
Message-ID: <1272361632-21352-7-git-send-email-yang.gu@intel.com>
In-Reply-To: <1272361632-21352-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7429696620484399028==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |    6 ++----
 src/stkutil.h |   10 +++++++++-
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index a0166d0..50fa4c1 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -2116,7 +2116,7 @@ static void destroy_get_inkey(struct stk_command *com=
mand)
 static gboolean parse_get_inkey(struct stk_command *command,
 				struct comprehension_tlv_iter *iter)
 {
-	struct stk_command_display_text *obj =3D &command->get_inkey;
+	struct stk_command_get_inkey *obj =3D &command->get_inkey;
 	gboolean ret;
 =

 	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
@@ -2130,12 +2130,10 @@ static gboolean parse_get_inkey(struct stk_command =
*command,
 				&obj->text,
 				STK_DATA_OBJECT_TYPE_ICON_ID, 0,
 				&obj->icon_id,
-				STK_DATA_OBJECT_TYPE_IMMEDIATE_RESPONSE, 0,
-				&obj->immediate_response,
 				STK_DATA_OBJECT_TYPE_DURATION, 0,
 				&obj->duration,
 				STK_DATA_OBJECT_TYPE_TEXT_ATTRIBUTE, 0,
-				&obj->text_attribute,
+				&obj->text_attr,
 				STK_DATA_OBJECT_TYPE_FRAME_ID, 0,
 				&obj->frame_id,
 				STK_DATA_OBJECT_TYPE_INVALID);
diff --git a/src/stkutil.h b/src/stkutil.h
index cbb6442..41c03a7 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -798,6 +798,14 @@ struct stk_command_display_text {
 	struct stk_frame_id frame_id;
 };
 =

+struct stk_command_get_inkey {
+	char *text;
+	struct stk_icon_id icon_id;
+	struct stk_duration duration;
+	struct stk_text_attribute text_attr;
+	struct stk_frame_id frame_id;
+};
+
 struct stk_command_get_input {
 	char *text;
 	struct stk_response_length response_length;
@@ -825,7 +833,7 @@ struct stk_command {
 =

 	union {
 		struct stk_command_display_text display_text;
-		struct stk_command_display_text get_inkey;
+		struct stk_command_get_inkey get_inkey;
 		struct stk_command_get_input get_input;
 		struct stk_command_send_sms send_sms;
 	};
-- =

1.7.0.4


--===============7429696620484399028==--

