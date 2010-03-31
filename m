Content-Type: multipart/mixed; boundary="===============3796580198431240224=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 02/11] Add parser for items next action indicator objects
Date: Wed, 31 Mar 2010 17:16:54 +0800
Message-ID: <1270027023-21468-2-git-send-email-yang.gu@intel.com>
In-Reply-To: <1270027023-21468-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3796580198431240224==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   20 ++++++++++++++++++++
 src/stkutil.h |    9 +++++++++
 2 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index c737395..37db3c3 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -592,6 +592,24 @@ static gboolean parse_dataobj_default_text(struct comp=
rehension_tlv_iter *iter,
 	return TRUE;
 }
 =

+/* Defined in TS 102.223 Section 8.24 */
+static gboolean parse_dataobj_items_next_action_indicator(
+		struct comprehension_tlv_iter *iter, void *user)
+{
+	struct stk_items_next_action_indicator *inai =3D user;
+	const unsigned char *data;
+	unsigned int len =3D comprehension_tlv_iter_get_length(iter);
+
+	if ((len < 1) || (len > sizeof(inai->list)))
+		return FALSE;
+
+	data =3D comprehension_tlv_iter_get_data(iter);
+	inai->len =3D len;
+	memcpy(inai->list, data, len);
+
+	return TRUE;
+}
+
 /* Defined in TS 102.223 Section 8.31 */
 static gboolean parse_dataobj_icon_id(struct comprehension_tlv_iter *iter,
 					void *user)
@@ -698,6 +716,8 @@ static dataobj_handler handler_for_type(enum stk_data_o=
bject_type type)
 		return parse_dataobj_network_measurement_results;
 	case STK_DATA_OBJECT_TYPE_DEFAULT_TEXT:
 		return parse_dataobj_default_text;
+	case STK_DATA_OBJECT_TYPE_ITEMS_NEXT_ACTION_INDICATOR:
+		return parse_dataobj_items_next_action_indicator;
 	case STK_DATA_OBJECT_TYPE_ICON_ID:
 		return parse_dataobj_icon_id;
 	case STK_DATA_OBJECT_TYPE_IMMEDIATE_RESPONSE:
diff --git a/src/stkutil.h b/src/stkutil.h
index b0b09df..fb7a2d0 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -361,6 +361,15 @@ struct stk_location_info {
 };
 =

 /*
+ * According to 102.223 Section 8.24 the length of CTLV is 1 byte. This me=
ans
+ * that the maximum size is 127 according to the rules of CTLVs.
+ */
+struct stk_items_next_action_indicator {
+	unsigned char list[127];
+	unsigned int len;
+};
+
+/*
  * Defined in TS 102.223 Section 8.31
  * Icon ID denotes a file on the SIM filesystem.  Since EF cannot have rec=
ord
  * ids of 0, we use icon_id with 0 to denote empty icon_identifier objects
-- =

1.6.3.3


--===============3796580198431240224==--

