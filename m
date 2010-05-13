Content-Type: multipart/mixed; boundary="===============7955636443322568265=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 23/27] stkutil: Add power on card command parser
Date: Thu, 13 May 2010 18:48:40 +0800
Message-ID: <1273747724-28019-23-git-send-email-yang.gu@intel.com>
In-Reply-To: <1273747724-28019-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7955636443322568265==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 8d7ca9b..ae074d8 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -2681,6 +2681,19 @@ static gboolean parse_power_off_card(struct stk_comm=
and *command,
 	return TRUE;
 }
 =

+static gboolean parse_power_on_card(struct stk_command *command,
+					struct comprehension_tlv_iter *iter)
+{
+	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
+		return FALSE;
+
+	if ((command->dst < STK_DEVICE_IDENTITY_TYPE_CARD_READER_0) ||
+			(command->dst > STK_DEVICE_IDENTITY_TYPE_CARD_READER_7))
+		return FALSE;
+
+	return TRUE;
+}
+
 struct stk_command *stk_command_new_from_pdu(const unsigned char *pdu,
 						unsigned int len)
 {
@@ -2787,6 +2800,9 @@ struct stk_command *stk_command_new_from_pdu(const un=
signed char *pdu,
 	case STK_COMMAND_TYPE_POWER_OFF_CARD:
 		ok =3D parse_power_off_card(command, &iter);
 		break;
+	case STK_COMMAND_TYPE_POWER_ON_CARD:
+		ok =3D parse_power_on_card(command, &iter);
+		break;
 	default:
 		ok =3D FALSE;
 		break;
-- =

1.7.0.4


--===============7955636443322568265==--

