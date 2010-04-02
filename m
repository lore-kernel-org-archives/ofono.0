Content-Type: multipart/mixed; boundary="===============5445619186527174322=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 11/15] Add parser for at response objects
Date: Fri, 02 Apr 2010 14:20:36 +0800
Message-ID: <1270189240-11650-11-git-send-email-yang.gu@intel.com>
In-Reply-To: <1270189240-11650-10-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5445619186527174322==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index c7154c1..f6da42b 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -929,6 +929,14 @@ static gboolean parse_dataobj_at_command(
 	return parse_dataobj_common_text(iter, command);
 }
 =

+/* Defined in TS 102.223 Section 8.41 */
+static gboolean parse_dataobj_at_response(
+		struct comprehension_tlv_iter *iter, void *user)
+{
+	unsigned char **response =3D user;
+	return parse_dataobj_common_text(iter, response);
+}
+
 /* Defined in 102.223 Section 8.43 */
 static gboolean parse_dataobj_imm_resp(struct comprehension_tlv_iter *iter,
 					void *user)
@@ -1049,6 +1057,8 @@ static dataobj_handler handler_for_type(enum stk_data=
_object_type type)
 		return parse_dataobj_datetime_timezone;
 	case STK_DATA_OBJECT_TYPE_AT_COMMAND:
 		return parse_dataobj_at_command;
+	case STK_DATA_OBJECT_TYPE_AT_RESPONSE:
+		return parse_dataobj_at_response;
 	case STK_DATA_OBJECT_TYPE_IMMEDIATE_RESPONSE:
 		return parse_dataobj_imm_resp;
 	case STK_DATA_OBJECT_TYPE_TEXT_ATTRIBUTE:
-- =

1.6.3.3


--===============5445619186527174322==--

