Content-Type: multipart/mixed; boundary="===============6152402571576977806=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 09/19] stkutil: Add poll interval proactive command parser
Date: Mon, 10 May 2010 18:38:52 +0800
Message-ID: <1273487942-27213-9-git-send-email-yang.gu@intel.com>
In-Reply-To: <1273487942-27213-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6152402571576977806==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   27 +++++++++++++++++++++++++++
 src/stkutil.h |    1 +
 2 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 44cef10..2074d19 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -2230,6 +2230,30 @@ static gboolean parse_play_tone(struct stk_command *=
command,
 	return TRUE;
 }
 =

+static gboolean parse_poll_interval(struct stk_command *command,
+					struct comprehension_tlv_iter *iter)
+{
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
+				&command->duration,
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
@@ -2350,6 +2374,9 @@ struct stk_command *stk_command_new_from_pdu(const un=
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
index 00c001b..dc25f99 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -841,6 +841,7 @@ struct stk_command {
 	enum stk_device_identity_type dst;
 =

 	union {
+		struct stk_duration duration;
 		struct stk_command_display_text display_text;
 		struct stk_command_get_inkey get_inkey;
 		struct stk_command_get_input get_input;
-- =

1.7.0.4


--===============6152402571576977806==--

