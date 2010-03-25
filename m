Content-Type: multipart/mixed; boundary="===============4862355030056225152=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 7/7] Add parser for help request objects
Date: Fri, 26 Mar 2010 00:07:36 +0800
Message-ID: <1269533256-29095-7-git-send-email-yang.gu@intel.com>
In-Reply-To: <1269533256-29095-6-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4862355030056225152==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 4e42ae4..9a91a25 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -611,6 +611,14 @@ static gboolean parse_dataobj_imei(struct comprehensio=
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
@@ -724,6 +732,8 @@ static dataobj_handler handler_for_type(enum stk_data_o=
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


--===============4862355030056225152==--

