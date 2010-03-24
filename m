Content-Type: multipart/mixed; boundary="===============7875298452561738035=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 6/6] Add parser for help request objects
Date: Wed, 24 Mar 2010 17:35:47 +0800
Message-ID: <1269423347-15508-6-git-send-email-yang.gu@intel.com>
In-Reply-To: <1269423347-15508-5-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7875298452561738035==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 3e423b5..215013d 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -50,6 +50,23 @@ struct gsm_sms_tpdu {
 	unsigned char tpdu[164];
 };
 =

+/* For data object to indicate the existence */
+static gboolean parse_dataobj_common_bool(struct comprehension_tlv_iter *i=
ter,
+		void *user, enum stk_data_object_type type)
+{
+	gboolean *ret =3D user;
+
+	if (comprehension_tlv_iter_get_tag(iter) !=3D type)
+		return FALSE;
+
+	if (comprehension_tlv_iter_get_length(iter) !=3D 0)
+		return FALSE;
+
+	*ret =3D TRUE;
+
+	return TRUE;
+}
+
 /* Defined in TS 102.223 Section 8.1 */
 static gboolean parse_dataobj_address(struct comprehension_tlv_iter *iter,
 					void *user)
@@ -571,6 +588,14 @@ static gboolean parse_dataobj_imei(struct comprehensio=
n_tlv_iter *iter,
 	return TRUE;
 }
 =

+/* Defined in TS 102.223 Section 8.21 */
+static gboolean parse_dataobj_help_request(struct comprehension_tlv_iter *=
iter,
+						void *user)
+{
+	return parse_dataobj_common_bool(iter, user,
+				STK_DATA_OBJECT_TYPE_HELP_REQUEST);
+}
+
 /* Defined in TS 102.223 Section 8.31 */
 static gboolean parse_dataobj_icon_id(struct comprehension_tlv_iter *iter,
 					void *user)
@@ -694,6 +719,8 @@ static dataobj_handler handler_for_type(enum stk_data_o=
bject_type type)
 		return parse_dataobj_location_info;
 	case STK_DATA_OBJECT_TYPE_IMEI:
 		return parse_dataobj_imei;
+	case STK_DATA_OBJECT_TYPE_HELP_REQUEST:
+		return parse_dataobj_help_request;
 	case STK_DATA_OBJECT_TYPE_ICON_ID:
 		return parse_dataobj_icon_id;
 	case STK_DATA_OBJECT_TYPE_IMMEDIATE_RESPONSE:
-- =

1.6.3.3


--===============7875298452561738035==--

