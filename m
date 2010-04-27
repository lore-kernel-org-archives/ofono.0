Content-Type: multipart/mixed; boundary="===============6541935680750112766=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 4/7] stkutil: Add parser for more time proactive commands
Date: Tue, 27 Apr 2010 17:47:09 +0800
Message-ID: <1272361632-21352-4-git-send-email-yang.gu@intel.com>
In-Reply-To: <1272361632-21352-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6541935680750112766==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index ed48db4..2e0c957 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -2189,6 +2189,18 @@ static gboolean parse_get_input(struct stk_command *=
command,
 	return TRUE;
 }
 =

+static gboolean parse_more_time(struct stk_command *command,
+					struct comprehension_tlv_iter *iter)
+{
+	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
+		return FALSE;
+
+	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_TERMINAL)
+		return FALSE;
+
+	return TRUE;
+}
+
 static void destroy_send_sms(struct stk_command *command)
 {
 	g_free(command->send_sms.alpha_id);
@@ -2303,6 +2315,9 @@ struct stk_command *stk_command_new_from_pdu(const un=
signed char *pdu,
 	case STK_COMMAND_TYPE_GET_INPUT:
 		ok =3D parse_get_input(command, &iter);
 		break;
+	case STK_COMMAND_TYPE_MORE_TIME:
+		ok =3D parse_more_time(command, &iter);
+		break;
 	case STK_COMMAND_TYPE_SEND_SMS:
 		ok =3D parse_send_sms(command, &iter);
 		break;
-- =

1.7.0.4


--===============6541935680750112766==--

