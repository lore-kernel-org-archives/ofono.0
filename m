Content-Type: multipart/mixed; boundary="===============3944054874725890466=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 14/27] stkutil: Add polling off proactive command parser
Date: Thu, 13 May 2010 18:48:31 +0800
Message-ID: <1273747724-28019-14-git-send-email-yang.gu@intel.com>
In-Reply-To: <1273747724-28019-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3944054874725890466==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 2227d31..3aaab37 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -2594,6 +2594,18 @@ static gboolean parse_refresh(struct stk_command *co=
mmand,
 	return TRUE;
 }
 =

+static gboolean parse_polling_off(struct stk_command *command,
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
 struct stk_command *stk_command_new_from_pdu(const unsigned char *pdu,
 						unsigned int len)
 {
@@ -2685,6 +2697,9 @@ struct stk_command *stk_command_new_from_pdu(const un=
signed char *pdu,
 	case STK_COMMAND_TYPE_REFRESH:
 		ok =3D parse_refresh(command, &iter);
 		break;
+	case STK_COMMAND_TYPE_POLLING_OFF:
+		ok =3D parse_polling_off(command, &iter);
+		break;
 	default:
 		ok =3D FALSE;
 		break;
-- =

1.7.0.4


--===============3944054874725890466==--

