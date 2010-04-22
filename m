Content-Type: multipart/mixed; boundary="===============4245441824058374160=="
MIME-Version: 1.0
From: Yang Gu <gyagp0@gmail.com>
Subject: [PATCH 10/13] Add parser for last envelope objects
Date: Thu, 22 Apr 2010 23:12:27 +0800
Message-ID: <1271949150-9085-10-git-send-email-yang.gu@intel.com>
In-Reply-To: <1271949150-9085-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4245441824058374160==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index f1a6738..83cf500 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -1749,6 +1749,14 @@ static gboolean parse_dataobj_mms_notification(
 	return parse_dataobj_common_byte_array(iter, array);
 }
 =

+/* Defined in TS 102.223 Section 8.87 */
+static gboolean parse_dataobj_last_envelope(struct comprehension_tlv_iter =
*iter,
+						void *user)
+{
+	gboolean *ret =3D user;
+	return parse_dataobj_common_bool(iter, ret);
+}
+
 static dataobj_handler handler_for_type(enum stk_data_object_type type)
 {
 	switch (type) {
@@ -1910,6 +1918,8 @@ static dataobj_handler handler_for_type(enum stk_data=
_object_type type)
 		return parse_dataobj_mms_content_id;
 	case STK_DATA_OBJECT_TYPE_MMS_NOTIFICATION:
 		return parse_dataobj_mms_notification;
+	case STK_DATA_OBJECT_TYPE_LAST_ENVELOPE:
+		return parse_dataobj_last_envelope;
 	default:
 		return NULL;
 	};
-- =

1.7.0.4


--===============4245441824058374160==--

