Content-Type: multipart/mixed; boundary="===============7508116553634032080=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 01/27] stk: Add poll interval proactive command parser
Date: Thu, 13 May 2010 18:48:18 +0800
Message-ID: <1273747724-28019-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7508116553634032080==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   28 ++++++++++++++++++++++++++++
 src/stkutil.h |    5 +++++
 2 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 7d89a63..46f4796 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -2230,6 +2230,31 @@ static gboolean parse_play_tone(struct stk_command *=
command,
 	return TRUE;
 }
 =

+static gboolean parse_poll_interval(struct stk_command *command,
+					struct comprehension_tlv_iter *iter)
+{
+	struct stk_command_poll_interval *obj =3D &command->poll_interval;
+	gboolean ret;
+
+	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
+		return FALSE;
+
+	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_TERMINAL)
+		return FALSE;
+
+	ret =3D parse_dataobj(iter, STK_DATA_OBJECT_TYPE_DURATION,
+				DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
+				&obj->duration,
+				STK_DATA_OBJECT_TYPE_INVALID);
+
+	if (ret =3D=3D FALSE)
+		return FALSE;
+
+	command->destructor =3D NULL;
+
+	return TRUE;
+}
+
 static void destroy_send_sms(struct stk_command *command)
 {
 	g_free(command->send_sms.alpha_id);
@@ -2358,6 +2383,9 @@ struct stk_command *stk_command_new_from_pdu(const un=
signed char *pdu,
 	case STK_COMMAND_TYPE_PLAY_TONE:
 		ok =3D parse_play_tone(command, &iter);
 		break;
+	case STK_COMMAND_TYPE_POLL_INTERVAL:
+		ok =3D parse_poll_interval(command, &iter);
+		break;
 	case STK_COMMAND_TYPE_SEND_SMS:
 		ok =3D parse_send_sms(command, &iter);
 		break;
diff --git a/src/stkutil.h b/src/stkutil.h
index 2d34ca4..02451b4 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -824,6 +824,10 @@ struct stk_command_play_tone {
 	struct stk_frame_id frame_id;
 };
 =

+struct stk_command_poll_interval {
+	struct stk_duration duration;
+};
+
 struct stk_command_send_sms {
 	char *alpha_id;
 	struct stk_address address;
@@ -847,6 +851,7 @@ struct stk_command {
 		struct stk_command_get_input get_input;
 		struct stk_command_play_tone play_tone;
 		struct stk_command_send_sms send_sms;
+		struct stk_command_poll_interval poll_interval;
 	};
 =

 	void (*destructor)(struct stk_command *command);
-- =

1.7.0.4


--===============7508116553634032080==--

