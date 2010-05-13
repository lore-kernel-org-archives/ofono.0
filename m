Content-Type: multipart/mixed; boundary="===============6178889180517264988=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 10/27] stkutil: Add setup call proactive command parser
Date: Thu, 13 May 2010 18:48:27 +0800
Message-ID: <1273747724-28019-10-git-send-email-yang.gu@intel.com>
In-Reply-To: <1273747724-28019-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6178889180517264988==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   55 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++
 src/stkutil.h |   15 +++++++++++++++
 2 files changed, 70 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 1b2297d..39278e7 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -2501,6 +2501,58 @@ static gboolean parse_send_sms(struct stk_command *c=
ommand,
 	return TRUE;
 }
 =

+static void destroy_setup_call(struct stk_command *command)
+{
+	g_free(command->setup_call.alpha_id_usr_cfm);
+	g_free(command->setup_call.addr.number);
+	g_free(command->setup_call.alpha_id_call_setup);
+}
+
+static gboolean parse_setup_call(struct stk_command *command,
+					struct comprehension_tlv_iter *iter)
+{
+	struct stk_command_setup_call *obj =3D &command->setup_call;
+	gboolean ret;
+
+	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
+		return FALSE;
+
+	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_NETWORK)
+		return FALSE;
+
+	ret =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_ALPHA_ID, 0,
+				&obj->alpha_id_usr_cfm,
+				STK_DATA_OBJECT_TYPE_ADDRESS,
+				DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
+				&obj->addr,
+				STK_DATA_OBJECT_TYPE_CCP, 0,
+				&obj->ccp,
+				STK_DATA_OBJECT_TYPE_SUBADDRESS, 0,
+				&obj->subaddr,
+				STK_DATA_OBJECT_TYPE_DURATION, 0,
+				&obj->duration,
+				STK_DATA_OBJECT_TYPE_ICON_ID, 0,
+				&obj->icon_id_usr_cfm,
+				STK_DATA_OBJECT_TYPE_ALPHA_ID, 0,
+				&obj->alpha_id_call_setup,
+				STK_DATA_OBJECT_TYPE_ICON_ID, 0,
+				&obj->icon_id_call_setup,
+				STK_DATA_OBJECT_TYPE_TEXT_ATTRIBUTE, 0,
+				&obj->text_attr_usr_cfm,
+				STK_DATA_OBJECT_TYPE_TEXT_ATTRIBUTE, 0,
+				&obj->text_attr_call_setup,
+				STK_DATA_OBJECT_TYPE_FRAME_ID, 0,
+				&obj->frame_id,
+				STK_DATA_OBJECT_TYPE_INVALID);
+
+	if (ret =3D=3D FALSE)
+		return FALSE;
+
+	command->destructor =3D destroy_setup_call;
+
+	return TRUE;
+}
+
 struct stk_command *stk_command_new_from_pdu(const unsigned char *pdu,
 						unsigned int len)
 {
@@ -2586,6 +2638,9 @@ struct stk_command *stk_command_new_from_pdu(const un=
signed char *pdu,
 	case STK_COMMAND_TYPE_SEND_SMS:
 		ok =3D parse_send_sms(command, &iter);
 		break;
+	case STK_COMMAND_TYPE_SETUP_CALL:
+		ok =3D parse_setup_call(command, &iter);
+		break;
 	default:
 		ok =3D FALSE;
 		break;
diff --git a/src/stkutil.h b/src/stkutil.h
index 0c9fd50..d0d2486 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -860,6 +860,20 @@ struct stk_command_send_sms {
 	struct stk_frame_id frame_id;
 };
 =

+struct stk_command_setup_call {
+	char *alpha_id_usr_cfm;
+	struct stk_address addr;
+	struct stk_ccp ccp;
+	struct stk_subaddress subaddr;
+	struct stk_duration duration;
+	struct stk_icon_id icon_id_usr_cfm;
+	char *alpha_id_call_setup;
+	struct stk_icon_id icon_id_call_setup;
+	struct stk_text_attribute text_attr_usr_cfm;
+	struct stk_text_attribute text_attr_call_setup;
+	struct stk_frame_id frame_id;
+};
+
 struct stk_command {
 	unsigned char number;
 	unsigned char type;
@@ -876,6 +890,7 @@ struct stk_command {
 		struct stk_command_setup_menu setup_menu;
 		struct stk_command_select_item select_item;
 		struct stk_command_send_sms send_sms;
+		struct stk_command_setup_call setup_call;
 	};
 =

 	void (*destructor)(struct stk_command *command);
-- =

1.7.0.4


--===============6178889180517264988==--

