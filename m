Content-Type: multipart/mixed; boundary="===============2880179418626282403=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 12/27] stkutil: Add refresh proactive command parser
Date: Thu, 13 May 2010 18:48:29 +0800
Message-ID: <1273747724-28019-12-git-send-email-yang.gu@intel.com>
In-Reply-To: <1273747724-28019-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2880179418626282403==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   44 ++++++++++++++++++++++++++++++++++++++++++++
 src/stkutil.h |   10 ++++++++++
 2 files changed, 54 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 39278e7..2227d31 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -2553,6 +2553,47 @@ static gboolean parse_setup_call(struct stk_command =
*command,
 	return TRUE;
 }
 =

+static void destroy_refresh(struct stk_command *command)
+{
+	g_slist_foreach(command->refresh.fl, (GFunc)g_free, NULL);
+	g_slist_free(command->refresh.fl);
+	g_free(command->refresh.alpha_id);
+}
+
+static gboolean parse_refresh(struct stk_command *command,
+					struct comprehension_tlv_iter *iter)
+{
+	struct stk_command_refresh *obj =3D &command->refresh;
+	gboolean ret;
+
+	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
+		return FALSE;
+
+	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_TERMINAL)
+		return FALSE;
+
+	ret =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_FILE_LIST, 0,
+				&obj->fl,
+				STK_DATA_OBJECT_TYPE_AID, 0,
+				&obj->aid,
+				STK_DATA_OBJECT_TYPE_ALPHA_ID, 0,
+				&obj->alpha_id,
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
+	command->destructor =3D destroy_refresh;
+
+	return TRUE;
+}
+
 struct stk_command *stk_command_new_from_pdu(const unsigned char *pdu,
 						unsigned int len)
 {
@@ -2641,6 +2682,9 @@ struct stk_command *stk_command_new_from_pdu(const un=
signed char *pdu,
 	case STK_COMMAND_TYPE_SETUP_CALL:
 		ok =3D parse_setup_call(command, &iter);
 		break;
+	case STK_COMMAND_TYPE_REFRESH:
+		ok =3D parse_refresh(command, &iter);
+		break;
 	default:
 		ok =3D FALSE;
 		break;
diff --git a/src/stkutil.h b/src/stkutil.h
index d0d2486..d974ea1 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -874,6 +874,15 @@ struct stk_command_setup_call {
 	struct stk_frame_id frame_id;
 };
 =

+struct stk_command_refresh {
+	GSList *fl;
+	struct stk_aid aid;
+	char *alpha_id;
+	struct stk_icon_id icon_id;
+	struct stk_text_attribute text_attr;
+	struct stk_frame_id frame_id;
+};
+
 struct stk_command {
 	unsigned char number;
 	unsigned char type;
@@ -891,6 +900,7 @@ struct stk_command {
 		struct stk_command_select_item select_item;
 		struct stk_command_send_sms send_sms;
 		struct stk_command_setup_call setup_call;
+		struct stk_command_refresh refresh;
 	};
 =

 	void (*destructor)(struct stk_command *command);
-- =

1.7.0.4


--===============2880179418626282403==--

