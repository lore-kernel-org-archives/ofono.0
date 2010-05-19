Content-Type: multipart/mixed; boundary="===============4521213531607819228=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 3/8] stk: Add parser for run at command commands
Date: Wed, 19 May 2010 18:24:41 +0800
Message-ID: <1274264686-9706-3-git-send-email-yang.gu@intel.com>
In-Reply-To: <1274264686-9706-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4521213531607819228==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   42 ++++++++++++++++++++++++++++++++++++++++++
 src/stkutil.h |    9 +++++++++
 2 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 3b1e957..9b08e8a 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -2747,6 +2747,45 @@ static gboolean parse_setup_idle_mode_text(struct st=
k_command *command,
 	return TRUE;
 }
 =

+static void destroy_run_at_command(struct stk_command *command)
+{
+	g_free(command->run_at_command.alpha_id);
+	g_free(command->run_at_command.at_command);
+}
+
+static gboolean parse_run_at_command(struct stk_command *command,
+					struct comprehension_tlv_iter *iter)
+{
+	struct stk_command_run_at_command *obj =3D &command->run_at_command;
+	gboolean ret;
+
+	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
+		return FALSE;
+
+	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_TERMINAL)
+		return FALSE;
+
+	ret =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_ALPHA_ID, 0,
+				&obj->alpha_id,
+				STK_DATA_OBJECT_TYPE_AT_COMMAND,
+				DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
+				&obj->at_command,
+				STK_DATA_OBJECT_TYPE_ICON_ID, 0,
+				&obj->icon_id,
+				STK_DATA_OBJECT_TYPE_TEXT_ATTRIBUTE, 0,
+				&obj->text_attr,
+				STK_DATA_OBJECT_TYPE_FRAME_ID, 0,
+				&obj->frame_id,
+				STK_DATA_OBJECT_TYPE_INVALID);
+
+	if (ret =3D=3D FALSE)
+		return FALSE;
+
+	command->destructor =3D destroy_run_at_command;
+
+	return TRUE;
+}
+
 struct stk_command *stk_command_new_from_pdu(const unsigned char *pdu,
 						unsigned int len)
 {
@@ -2865,6 +2904,9 @@ struct stk_command *stk_command_new_from_pdu(const un=
signed char *pdu,
 	case STK_COMMAND_TYPE_SETUP_IDLE_MODE_TEXT:
 		ok =3D parse_setup_idle_mode_text(command, &iter);
 		break;
+	case STK_COMMAND_TYPE_RUN_AT_COMMAND:
+		ok =3D parse_run_at_command(command, &iter);
+		break;
 	default:
 		ok =3D FALSE;
 		break;
diff --git a/src/stkutil.h b/src/stkutil.h
index 09e5731..cd7a1f5 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -972,6 +972,14 @@ struct stk_command_setup_idle_mode_text {
 	struct stk_frame_id frame_id;
 };
 =

+struct stk_command_run_at_command {
+	char *alpha_id;
+	char *at_command;
+	struct stk_icon_id icon_id;
+	struct stk_text_attribute text_attr;
+	struct stk_frame_id frame_id;
+};
+
 struct stk_command {
 	unsigned char number;
 	unsigned char type;
@@ -994,6 +1002,7 @@ struct stk_command {
 		struct stk_command_perform_card_apdu perform_card_apdu;
 		struct stk_command_timer_mgmt timer_mgmt;
 		struct stk_command_setup_idle_mode_text setup_idle_mode_text;
+		struct stk_command_run_at_command run_at_command;
 	};
 =

 	void (*destructor)(struct stk_command *command);
-- =

1.7.0.4


--===============4521213531607819228==--

