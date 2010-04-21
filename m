Content-Type: multipart/mixed; boundary="===============6306699693156890067=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 14/15] Add parser for network search mode objects
Date: Wed, 21 Apr 2010 12:55:58 +0800
Message-ID: <1271825759-8898-14-git-send-email-yang.gu@intel.com>
In-Reply-To: <1271825759-8898-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6306699693156890067==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 8582b9f..fcc396b 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -1545,6 +1545,14 @@ static gboolean parse_dataobj_imeisv(struct comprehe=
nsion_tlv_iter *iter,
 	return TRUE;
 }
 =

+/* Defined in TS 102.223 Section 8.75 */
+static gboolean parse_dataobj_network_search_mode(
+		struct comprehension_tlv_iter *iter, void *user)
+{
+	unsigned char *byte =3D user;
+	return parse_dataobj_common_byte(iter, byte);
+}
+
 /* Defined in TS 102.223 Section 8.80 */
 static gboolean parse_dataobj_frame_id(struct comprehension_tlv_iter *iter,
 					void *user)
@@ -1702,6 +1710,8 @@ static dataobj_handler handler_for_type(enum stk_data=
_object_type type)
 		return parse_dataobj_item_text_attribute_list;
 	case STK_DATA_OBJECT_TYPE_IMEISV:
 		return parse_dataobj_imeisv;
+	case STK_DATA_OBJECT_TYPE_NETWORK_SEARCH_MODE:
+		return parse_dataobj_network_search_mode;
 	case STK_DATA_OBJECT_TYPE_FRAME_ID:
 		return parse_dataobj_frame_id;
 	default:
-- =

1.7.0.4


--===============6306699693156890067==--

