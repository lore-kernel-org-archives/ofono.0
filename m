Content-Type: multipart/mixed; boundary="===============3748437954152418269=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 5/6] stkutil: Add parser for more time proactive commands
Date: Mon, 26 Apr 2010 18:29:25 +0800
Message-ID: <1272277766-25432-5-git-send-email-yang.gu@intel.com>
In-Reply-To: <1272277766-25432-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3748437954152418269==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 2b43e85..ca0ee26 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -2193,6 +2193,18 @@ static gboolean parse_get_input(struct stk_command *=
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
@@ -2310,6 +2322,9 @@ struct stk_command *stk_command_new_from_pdu(const un=
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


--===============3748437954152418269==--

