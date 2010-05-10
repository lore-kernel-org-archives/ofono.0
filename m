Content-Type: multipart/mixed; boundary="===============0504916490386225924=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 05/19] stkutil: Add play tone proactive command parser
Date: Mon, 10 May 2010 18:38:48 +0800
Message-ID: <1273487942-27213-5-git-send-email-yang.gu@intel.com>
In-Reply-To: <1273487942-27213-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0504916490386225924==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   42 ++++++++++++++++++++++++++++++++++++++++++
 src/stkutil.h |   10 ++++++++++
 2 files changed, 52 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 5bddb93..0f0ea34 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -2200,6 +2200,45 @@ static gboolean parse_more_time(struct stk_command *=
command,
 	return TRUE;
 }
 =

+static void destroy_play_tone(struct stk_command *command)
+{
+	g_free(command->play_tone.alpha_id);
+}
+
+static gboolean parse_play_tone(struct stk_command *command,
+					struct comprehension_tlv_iter *iter)
+{
+	struct stk_command_play_tone *obj =3D &command->play_tone;
+	gboolean ret;
+
+	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
+		return FALSE;
+
+	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_EARPIECE)
+		return FALSE;
+
+	ret =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_ALPHA_ID, 0,
+				&obj->alpha_id,
+				STK_DATA_OBJECT_TYPE_TONE, 0,
+				&obj->tone,
+				STK_DATA_OBJECT_TYPE_DURATION, 0,
+				&obj->duration,
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
+	command->destructor =3D destroy_play_tone;
+
+	return TRUE;
+}
+
 static void destroy_send_sms(struct stk_command *command)
 {
 	g_free(command->send_sms.alpha_id);
@@ -2317,6 +2356,9 @@ struct stk_command *stk_command_new_from_pdu(const un=
signed char *pdu,
 	case STK_COMMAND_TYPE_MORE_TIME:
 		ok =3D parse_more_time(command, &iter);
 		break;
+	case STK_COMMAND_TYPE_PLAY_TONE:
+		ok =3D parse_play_tone(command, &iter);
+		break;
 	case STK_COMMAND_TYPE_SEND_SMS:
 		ok =3D parse_send_sms(command, &iter);
 		break;
diff --git a/src/stkutil.h b/src/stkutil.h
index 70c6b01..00c001b 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -815,6 +815,15 @@ struct stk_command_get_input {
 	struct stk_frame_id frame_id;
 };
 =

+struct stk_command_play_tone {
+	char *alpha_id;
+	unsigned char tone;
+	struct stk_duration duration;
+	struct stk_icon_id icon_id;
+	struct stk_text_attribute text_attr;
+	struct stk_frame_id frame_id;
+};
+
 struct stk_command_send_sms {
 	char *alpha_id;
 	struct stk_address address;
@@ -835,6 +844,7 @@ struct stk_command {
 		struct stk_command_display_text display_text;
 		struct stk_command_get_inkey get_inkey;
 		struct stk_command_get_input get_input;
+		struct stk_command_play_tone play_tone;
 		struct stk_command_send_sms send_sms;
 	};
 =

-- =

1.7.0.4


--===============0504916490386225924==--

