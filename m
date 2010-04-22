Content-Type: multipart/mixed; boundary="===============2331792370182913017=="
MIME-Version: 1.0
From: Yang Gu <gyagp0@gmail.com>
Subject: [PATCH 11/13] Add parser for registry application data objects
Date: Thu, 22 Apr 2010 23:12:28 +0800
Message-ID: <1271949150-9085-11-git-send-email-yang.gu@intel.com>
In-Reply-To: <1271949150-9085-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2331792370182913017==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   28 ++++++++++++++++++++++++++++
 src/stkutil.h |    7 +++++++
 2 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 83cf500..a0c0d25 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -1757,6 +1757,32 @@ static gboolean parse_dataobj_last_envelope(struct c=
omprehension_tlv_iter *iter,
 	return parse_dataobj_common_bool(iter, ret);
 }
 =

+/* Defined in TS 102.223 Section 8.88 */
+static gboolean parse_dataobj_registry_application_data(
+		struct comprehension_tlv_iter *iter, void *user)
+{
+	struct stk_registry_application_data *rad =3D user;
+	const unsigned char *data;
+	char *utf8;
+	unsigned int len =3D comprehension_tlv_iter_get_length(iter);
+
+	if (len < 5)
+		return FALSE;
+
+	data =3D comprehension_tlv_iter_get_data(iter);
+
+	utf8 =3D decode_text(data[2], len - 4, data + 4);
+
+	if (utf8 =3D=3D NULL)
+		return FALSE;
+
+	rad->name =3D utf8;
+	rad->port =3D (data[0] << 8) + data[1];
+	rad->type =3D data[3];
+
+	return TRUE;
+}
+
 static dataobj_handler handler_for_type(enum stk_data_object_type type)
 {
 	switch (type) {
@@ -1920,6 +1946,8 @@ static dataobj_handler handler_for_type(enum stk_data=
_object_type type)
 		return parse_dataobj_mms_notification;
 	case STK_DATA_OBJECT_TYPE_LAST_ENVELOPE:
 		return parse_dataobj_last_envelope;
+	case STK_DATA_OBJECT_TYPE_REGISTRY_APPLICATION_DATA:
+		return parse_dataobj_registry_application_data;
 	default:
 		return NULL;
 	};
diff --git a/src/stkutil.h b/src/stkutil.h
index 267e296..b7341c7 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -757,6 +757,13 @@ struct stk_mms_content_id {
 	unsigned char len;
 };
 =

+/* Defined in TS 102.223 Section 8.88 */
+struct stk_registry_application_data {
+	unsigned short port;
+	unsigned char type;
+	char *name;
+};
+
 struct stk_command_display_text {
 	char *text;
 	struct stk_icon_id icon_id;
-- =

1.7.0.4


--===============2331792370182913017==--

