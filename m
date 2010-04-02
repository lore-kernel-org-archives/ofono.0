Content-Type: multipart/mixed; boundary="===============8644781128042745206=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 12/15] Add parser for bc repeat indicator objects
Date: Fri, 02 Apr 2010 14:20:37 +0800
Message-ID: <1270189240-11650-12-git-send-email-yang.gu@intel.com>
In-Reply-To: <1270189240-11650-11-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8644781128042745206==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index f6da42b..f205ce6 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -937,6 +937,14 @@ static gboolean parse_dataobj_at_response(
 	return parse_dataobj_common_text(iter, response);
 }
 =

+/* Defined in TS 102.223 Section 8.42 */
+static gboolean parse_dataobj_bc_repeat_indicator(
+		struct comprehension_tlv_iter *iter, void *user)
+{
+	unsigned char *byte =3D user;
+	return parse_dataobj_common_byte(iter, byte);
+}
+
 /* Defined in 102.223 Section 8.43 */
 static gboolean parse_dataobj_imm_resp(struct comprehension_tlv_iter *iter,
 					void *user)
@@ -1059,6 +1067,8 @@ static dataobj_handler handler_for_type(enum stk_data=
_object_type type)
 		return parse_dataobj_at_command;
 	case STK_DATA_OBJECT_TYPE_AT_RESPONSE:
 		return parse_dataobj_at_response;
+	case STK_DATA_OBJECT_TYPE_BC_REPEAT_INDICATOR:
+		return parse_dataobj_bc_repeat_indicator;
 	case STK_DATA_OBJECT_TYPE_IMMEDIATE_RESPONSE:
 		return parse_dataobj_imm_resp;
 	case STK_DATA_OBJECT_TYPE_TEXT_ATTRIBUTE:
-- =

1.6.3.3


--===============8644781128042745206==--

