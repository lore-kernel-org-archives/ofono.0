Content-Type: multipart/mixed; boundary="===============8619886578786325717=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 10/15] Add parser for at command objects
Date: Fri, 02 Apr 2010 14:20:35 +0800
Message-ID: <1270189240-11650-10-git-send-email-yang.gu@intel.com>
In-Reply-To: <1270189240-11650-9-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8619886578786325717==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 1846092..c7154c1 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -112,6 +112,28 @@ static gboolean parse_dataobj_common_byte(struct compr=
ehension_tlv_iter *iter,
 	return TRUE;
 }
 =

+/* For data object that only has text terminated by '\0' */
+static gboolean parse_dataobj_common_text(struct comprehension_tlv_iter *i=
ter,
+					unsigned char **text)
+{
+	const unsigned char *data;
+	unsigned int len =3D comprehension_tlv_iter_get_length(iter);
+
+	if (len < 1)
+		return FALSE;
+
+	data =3D comprehension_tlv_iter_get_data(iter);
+
+	*text =3D g_try_malloc(len + 1);
+	if (*text =3D=3D NULL)
+		return FALSE;
+
+	memcpy(*text, data, len);
+	(*text)[len] =3D '\0';
+
+	return TRUE;
+}
+
 /* For data object that only has a byte array with undetermined length */
 static gboolean parse_dataobj_common_byte_array(
 			struct comprehension_tlv_iter *iter,
@@ -899,6 +921,14 @@ static gboolean parse_dataobj_datetime_timezone(
 	return TRUE;
 }
 =

+/* Defined in TS 102.223 Section 8.40 */
+static gboolean parse_dataobj_at_command(
+		struct comprehension_tlv_iter *iter, void *user)
+{
+	unsigned char **command =3D user;
+	return parse_dataobj_common_text(iter, command);
+}
+
 /* Defined in 102.223 Section 8.43 */
 static gboolean parse_dataobj_imm_resp(struct comprehension_tlv_iter *iter,
 					void *user)
@@ -1017,6 +1047,8 @@ static dataobj_handler handler_for_type(enum stk_data=
_object_type type)
 		return parse_dataobj_timer_value;
 	case STK_DATA_OBJECT_TYPE_DATETIME_TIMEZONE:
 		return parse_dataobj_datetime_timezone;
+	case STK_DATA_OBJECT_TYPE_AT_COMMAND:
+		return parse_dataobj_at_command;
 	case STK_DATA_OBJECT_TYPE_IMMEDIATE_RESPONSE:
 		return parse_dataobj_imm_resp;
 	case STK_DATA_OBJECT_TYPE_TEXT_ATTRIBUTE:
-- =

1.6.3.3


--===============8619886578786325717==--

