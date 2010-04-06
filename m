Content-Type: multipart/mixed; boundary="===============6826623745799931002=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 06/13] Add parser for browser termination cause objects
Date: Tue, 06 Apr 2010 18:06:40 +0800
Message-ID: <1270548407-12042-6-git-send-email-yang.gu@intel.com>
In-Reply-To: <1270548407-12042-5-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6826623745799931002==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   10 ++++++++++
 src/stkutil.h |    5 +++++
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 2b551e2..4998440 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -1084,6 +1084,14 @@ static gboolean parse_dataobj_provisioning_file_refe=
rence(
 	return TRUE;
 }
 =

+/* Defined in 102.223 Section 8.51 */
+static gboolean parse_dataobj_browser_termination_cause(
+		struct comprehension_tlv_iter *iter, void *user)
+{
+	unsigned char *byte =3D user;
+	return parse_dataobj_common_byte(iter, byte);
+}
+
 /* Defined in TS 102.223 Section 8.72 */
 static gboolean parse_dataobj_text_attr(struct comprehension_tlv_iter *ite=
r,
 					void *user)
@@ -1214,6 +1222,8 @@ static dataobj_handler handler_for_type(enum stk_data=
_object_type type)
 		return parse_dataobj_bearer;
 	case STK_DATA_OBJECT_TYPE_PROVISIONING_FILE_REFERENCE:
 		return parse_dataobj_provisioning_file_reference;
+	case STK_DATA_OBJECT_TYPE_BROWSER_TERMINATION_CAUSE:
+		return parse_dataobj_browser_termination_cause;
 	case STK_DATA_OBJECT_TYPE_TEXT_ATTRIBUTE:
 		return parse_dataobj_text_attr;
 	case STK_DATA_OBJECT_TYPE_FRAME_ID:
diff --git a/src/stkutil.h b/src/stkutil.h
index 3dcb2c3..746c5ff 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -316,6 +316,11 @@ enum stk_bearer {
 	STK_BEARER_PS =3D 	0x03
 };
 =

+enum stk_browser_termination_cause {
+	STK_BROWSER_USER_TERMINATION =3D 		0x00,
+	STK_BROWSER_ERROR_TERMINATION =3D 	0x01
+};
+
 /* For data object that only has a byte array with undetermined length */
 struct stk_common_byte_array {
 	unsigned char *array;
-- =

1.6.3.3


--===============6826623745799931002==--

