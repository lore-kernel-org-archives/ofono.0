Content-Type: multipart/mixed; boundary="===============0204073977757876630=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 1/8] stk: Add parser for setup idle mode text commands
Date: Wed, 19 May 2010 18:24:39 +0800
Message-ID: <1274264686-9706-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0204073977757876630==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   40 ++++++++++++++++++++++++++++++++++++++++
 src/stkutil.h |    8 ++++++++
 2 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index e053e2c..3b1e957 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -2710,6 +2710,43 @@ static gboolean parse_timer_mgmt(struct stk_command =
*command,
 	return TRUE;
 }
 =

+static void destroy_setup_idle_mode_text(struct stk_command *command)
+{
+	g_free(command->setup_idle_mode_text.text);
+}
+
+static gboolean parse_setup_idle_mode_text(struct stk_command *command,
+					struct comprehension_tlv_iter *iter)
+{
+	struct stk_command_setup_idle_mode_text *obj =3D
+					&command->setup_idle_mode_text;
+	gboolean ret;
+
+	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
+		return FALSE;
+
+	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_TERMINAL)
+		return FALSE;
+
+	ret =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_TEXT,
+				DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
+				&obj->text,
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
+	command->destructor =3D destroy_setup_idle_mode_text;
+
+	return TRUE;
+}
+
 struct stk_command *stk_command_new_from_pdu(const unsigned char *pdu,
 						unsigned int len)
 {
@@ -2825,6 +2862,9 @@ struct stk_command *stk_command_new_from_pdu(const un=
signed char *pdu,
 	case STK_COMMAND_TYPE_TIMER_MANAGEMENT:
 		ok =3D parse_timer_mgmt(command, &iter);
 		break;
+	case STK_COMMAND_TYPE_SETUP_IDLE_MODE_TEXT:
+		ok =3D parse_setup_idle_mode_text(command, &iter);
+		break;
 	default:
 		ok =3D FALSE;
 		break;
diff --git a/src/stkutil.h b/src/stkutil.h
index 4adbe6b..09e5731 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -965,6 +965,13 @@ struct stk_command_timer_mgmt {
 	struct stk_timer_value timer_value;
 };
 =

+struct stk_command_setup_idle_mode_text {
+	char *text;
+	struct stk_icon_id icon_id;
+	struct stk_text_attribute text_attr;
+	struct stk_frame_id frame_id;
+};
+
 struct stk_command {
 	unsigned char number;
 	unsigned char type;
@@ -986,6 +993,7 @@ struct stk_command {
 		struct stk_command_setup_event_list setup_event_list;
 		struct stk_command_perform_card_apdu perform_card_apdu;
 		struct stk_command_timer_mgmt timer_mgmt;
+		struct stk_command_setup_idle_mode_text setup_idle_mode_text;
 	};
 =

 	void (*destructor)(struct stk_command *command);
-- =

1.7.0.4


--===============0204073977757876630==--

