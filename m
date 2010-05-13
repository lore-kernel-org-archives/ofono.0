Content-Type: multipart/mixed; boundary="===============0328371331707856447=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 16/27] stkutil: Add provide local info command parser
Date: Thu, 13 May 2010 18:48:33 +0800
Message-ID: <1273747724-28019-16-git-send-email-yang.gu@intel.com>
In-Reply-To: <1273747724-28019-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0328371331707856447==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 3aaab37..0484687 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -2606,6 +2606,18 @@ static gboolean parse_polling_off(struct stk_command=
 *command,
 	return TRUE;
 }
 =

+static gboolean parse_provide_local_info(struct stk_command *command,
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
@@ -2700,6 +2712,9 @@ struct stk_command *stk_command_new_from_pdu(const un=
signed char *pdu,
 	case STK_COMMAND_TYPE_POLLING_OFF:
 		ok =3D parse_polling_off(command, &iter);
 		break;
+	case STK_COMMAND_TYPE_PROVIDE_LOCAL_INFO:
+		ok =3D parse_provide_local_info(command, &iter);
+		break;
 	default:
 		ok =3D FALSE;
 		break;
-- =

1.7.0.4


--===============0328371331707856447==--

