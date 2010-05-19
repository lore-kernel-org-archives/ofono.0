Content-Type: multipart/mixed; boundary="===============2053784195547691410=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 5/8] stk: Add parser for send dtmf commands
Date: Wed, 19 May 2010 18:24:43 +0800
Message-ID: <1274264686-9706-5-git-send-email-yang.gu@intel.com>
In-Reply-To: <1274264686-9706-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2053784195547691410==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   42 ++++++++++++++++++++++++++++++++++++++++++
 src/stkutil.h |    9 +++++++++
 2 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 9b08e8a..c0242cd 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -2786,6 +2786,45 @@ static gboolean parse_run_at_command(struct stk_comm=
and *command,
 	return TRUE;
 }
 =

+static void destroy_send_dtmf(struct stk_command *command)
+{
+	g_free(command->send_dtmf.alpha_id);
+	g_free(command->send_dtmf.dtmf);
+}
+
+static gboolean parse_send_dtmf(struct stk_command *command,
+					struct comprehension_tlv_iter *iter)
+{
+	struct stk_command_send_dtmf *obj =3D &command->send_dtmf;
+	gboolean ret;
+
+	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
+		return FALSE;
+
+	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_NETWORK)
+		return FALSE;
+
+	ret =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_ALPHA_ID, 0,
+				&obj->alpha_id,
+				STK_DATA_OBJECT_TYPE_DTMF_STRING,
+				DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
+				&obj->dtmf,
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
+	command->destructor =3D destroy_send_dtmf;
+
+	return TRUE;
+}
+
 struct stk_command *stk_command_new_from_pdu(const unsigned char *pdu,
 						unsigned int len)
 {
@@ -2907,6 +2946,9 @@ struct stk_command *stk_command_new_from_pdu(const un=
signed char *pdu,
 	case STK_COMMAND_TYPE_RUN_AT_COMMAND:
 		ok =3D parse_run_at_command(command, &iter);
 		break;
+	case STK_COMMAND_TYPE_SEND_DTMF:
+		ok =3D parse_send_dtmf(command, &iter);
+		break;
 	default:
 		ok =3D FALSE;
 		break;
diff --git a/src/stkutil.h b/src/stkutil.h
index cd7a1f5..dcae839 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -980,6 +980,14 @@ struct stk_command_run_at_command {
 	struct stk_frame_id frame_id;
 };
 =

+struct stk_command_send_dtmf {
+	char *alpha_id;
+	char *dtmf;
+	struct stk_icon_id icon_id;
+	struct stk_text_attribute text_attr;
+	struct stk_frame_id frame_id;
+};
+
 struct stk_command {
 	unsigned char number;
 	unsigned char type;
@@ -1003,6 +1011,7 @@ struct stk_command {
 		struct stk_command_timer_mgmt timer_mgmt;
 		struct stk_command_setup_idle_mode_text setup_idle_mode_text;
 		struct stk_command_run_at_command run_at_command;
+		struct stk_command_send_dtmf send_dtmf;
 	};
 =

 	void (*destructor)(struct stk_command *command);
-- =

1.7.0.4


--===============2053784195547691410==--

