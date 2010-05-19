Content-Type: multipart/mixed; boundary="===============5293105555818673984=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 7/8] stk: Add parser for language notification commands
Date: Wed, 19 May 2010 18:24:45 +0800
Message-ID: <1274264686-9706-7-git-send-email-yang.gu@intel.com>
In-Reply-To: <1274264686-9706-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5293105555818673984==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   26 ++++++++++++++++++++++++++
 src/stkutil.h |    5 +++++
 2 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index c0242cd..62b25e8 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -2825,6 +2825,29 @@ static gboolean parse_send_dtmf(struct stk_command *=
command,
 	return TRUE;
 }
 =

+static gboolean parse_language_notification(struct stk_command *command,
+					struct comprehension_tlv_iter *iter)
+{
+	struct stk_command_language_notification *obj =3D
+					&command->language_notification;
+	gboolean ret;
+
+	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
+		return FALSE;
+
+	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_TERMINAL)
+		return FALSE;
+
+	ret =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_LANGUAGE, 0,
+				&obj->language,
+				STK_DATA_OBJECT_TYPE_INVALID);
+
+	if (ret =3D=3D FALSE)
+		return FALSE;
+
+	return TRUE;
+}
+
 struct stk_command *stk_command_new_from_pdu(const unsigned char *pdu,
 						unsigned int len)
 {
@@ -2949,6 +2972,9 @@ struct stk_command *stk_command_new_from_pdu(const un=
signed char *pdu,
 	case STK_COMMAND_TYPE_SEND_DTMF:
 		ok =3D parse_send_dtmf(command, &iter);
 		break;
+	case STK_COMMAND_TYPE_LANGUAGE_NOTIFICATION:
+		ok =3D parse_language_notification(command, &iter);
+		break;
 	default:
 		ok =3D FALSE;
 		break;
diff --git a/src/stkutil.h b/src/stkutil.h
index dcae839..b58c85c 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -988,6 +988,10 @@ struct stk_command_send_dtmf {
 	struct stk_frame_id frame_id;
 };
 =

+struct stk_command_language_notification {
+	char language[3];
+};
+
 struct stk_command {
 	unsigned char number;
 	unsigned char type;
@@ -1012,6 +1016,7 @@ struct stk_command {
 		struct stk_command_setup_idle_mode_text setup_idle_mode_text;
 		struct stk_command_run_at_command run_at_command;
 		struct stk_command_send_dtmf send_dtmf;
+		struct stk_command_language_notification language_notification;
 	};
 =

 	void (*destructor)(struct stk_command *command);
-- =

1.7.0.4


--===============5293105555818673984==--

