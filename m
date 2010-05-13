Content-Type: multipart/mixed; boundary="===============6240970176791458066=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 24/27] stkutil: Add get reader status command parser
Date: Thu, 13 May 2010 18:48:41 +0800
Message-ID: <1273747724-28019-24-git-send-email-yang.gu@intel.com>
In-Reply-To: <1273747724-28019-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6240970176791458066==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   27 +++++++++++++++++++++++++++
 src/stkutil.h |    5 +++++
 2 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index ae074d8..608a679 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -2694,6 +2694,30 @@ static gboolean parse_power_on_card(struct stk_comma=
nd *command,
 	return TRUE;
 }
 =

+static gboolean parse_get_reader_status(struct stk_command *command,
+					struct comprehension_tlv_iter *iter)
+{
+	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
+		return FALSE;
+
+	switch (command->qualifier) {
+	case STK_QUALIFIER_TYPE_CARD_READER_STATUS:
+		if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_TERMINAL)
+			return FALSE;
+		break;
+	case STK_QUALIFIER_TYPE_CARD_READER_ID:
+		if ((command->dst < STK_DEVICE_IDENTITY_TYPE_CARD_READER_0) ||
+				(command->dst >
+					STK_DEVICE_IDENTITY_TYPE_CARD_READER_7))
+			return FALSE;
+		break;
+	default:
+		return FALSE;
+	}
+
+	return TRUE;
+}
+
 struct stk_command *stk_command_new_from_pdu(const unsigned char *pdu,
 						unsigned int len)
 {
@@ -2803,6 +2827,9 @@ struct stk_command *stk_command_new_from_pdu(const un=
signed char *pdu,
 	case STK_COMMAND_TYPE_POWER_ON_CARD:
 		ok =3D parse_power_on_card(command, &iter);
 		break;
+	case STK_COMMAND_TYPE_GET_READER_STATUS:
+		ok =3D parse_get_reader_status(command, &iter);
+		break;
 	default:
 		ok =3D FALSE;
 		break;
diff --git a/src/stkutil.h b/src/stkutil.h
index 809cb8c..5da7cc6 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -198,6 +198,11 @@ enum stk_device_identity_type {
 	STK_DEVICE_IDENTITY_TYPE_NETWORK =3D	0x83,
 };
 =

+enum stk_qualifier_get_reader_status_type {
+	STK_QUALIFIER_TYPE_CARD_READER_STATUS =3D 	0x00,
+	STK_QUALIFIER_TYPE_CARD_READER_ID =3D 		0x01,
+};
+
 enum stk_duration_type {
 	STK_DURATION_TYPE_MINUTES =3D		0x00,
 	STK_DURATION_TYPE_SECONDS =3D		0x01,
-- =

1.7.0.4


--===============6240970176791458066==--

