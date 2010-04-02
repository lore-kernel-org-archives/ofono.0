Content-Type: multipart/mixed; boundary="===============3682237472655606089=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 05/15] Add parser for timer identifier objects
Date: Fri, 02 Apr 2010 14:20:30 +0800
Message-ID: <1270189240-11650-5-git-send-email-yang.gu@intel.com>
In-Reply-To: <1270189240-11650-4-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3682237472655606089==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 2efa5a4..d999846 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -855,6 +855,15 @@ static gboolean parse_dataobj_r_apdu(
 	return TRUE;
 }
 =

+/* Defined in TS 102.223 Section 8.37 */
+static gboolean parse_dataobj_timer_id(
+		struct comprehension_tlv_iter *iter, void *user)
+{
+	unsigned char *byte =3D user;
+
+	return parse_dataobj_common_byte(iter, byte);
+}
+
 /* Defined in 102.223 Section 8.43 */
 static gboolean parse_dataobj_imm_resp(struct comprehension_tlv_iter *iter,
 					void *user)
@@ -967,6 +976,8 @@ static dataobj_handler handler_for_type(enum stk_data_o=
bject_type type)
 		return parse_dataobj_c_apdu;
 	case STK_DATA_OBJECT_TYPE_R_APDU:
 		return parse_dataobj_r_apdu;
+	case STK_DATA_OBJECT_TYPE_TIMER_ID:
+		return parse_dataobj_timer_id;
 	case STK_DATA_OBJECT_TYPE_IMMEDIATE_RESPONSE:
 		return parse_dataobj_imm_resp;
 	case STK_DATA_OBJECT_TYPE_TEXT_ATTRIBUTE:
-- =

1.6.3.3


--===============3682237472655606089==--

