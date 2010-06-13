Content-Type: multipart/mixed; boundary="===============5889677634112883913=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 08/12] stk: Add parser for cell broadcast page objects
Date: Sun, 13 Jun 2010 17:43:18 +0800
Message-ID: <1276422202-16240-8-git-send-email-yang.gu@intel.com>
In-Reply-To: <1276422202-16240-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5889677634112883913==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   24 ++++++++++++++++++++++++
 src/stkutil.h |    6 ++++++
 2 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 268d686..3ca808f 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -355,6 +355,28 @@ static gboolean parse_dataobj_ccp(struct comprehension=
_tlv_iter *iter,
 	return TRUE;
 }
 =

+/* Defined in TS 31.111 Section 8.5 */
+static gboolean parse_dataobj_cbs_page(struct comprehension_tlv_iter *iter,
+					void *user)
+{
+	struct stk_cbs_page *cp =3D user;
+	const unsigned char *data;
+	unsigned int len;
+
+	len =3D comprehension_tlv_iter_get_length(iter);
+	if (len < 1)
+		return FALSE;
+
+	if (len > sizeof(cp->page))
+		return FALSE;
+
+	data =3D comprehension_tlv_iter_get_data(iter);
+	cp->len =3D len;
+	memcpy(cp->page, data, len);
+
+	return TRUE;
+}
+
 /* Described in TS 102.223 Section 8.8 */
 static gboolean parse_dataobj_duration(struct comprehension_tlv_iter *iter,
 					void *user)
@@ -1900,6 +1922,8 @@ static dataobj_handler handler_for_type(enum stk_data=
_object_type type)
 		return parse_dataobj_subaddress;
 	case STK_DATA_OBJECT_TYPE_CCP:
 		return parse_dataobj_ccp;
+	case STK_DATA_OBJECT_TYPE_CBS_PAGE:
+		return parse_dataobj_cbs_page;
 	case STK_DATA_OBJECT_TYPE_DURATION:
 		return parse_dataobj_duration;
 	case STK_DATA_OBJECT_TYPE_ITEM:
diff --git a/src/stkutil.h b/src/stkutil.h
index 6ab5ed1..b0dcd5f 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -494,6 +494,12 @@ struct stk_ccp {
 	unsigned char ccp[16];
 };
 =

+/* Defined in TS 31.111 Section 8.5 */
+struct stk_cbs_page {
+	unsigned char len;
+	unsigned char page[88];
+};
+
 /*
  * According to 102.223 Section 8.8 interval values of 0x00 are reserved.
  * We use this to denote empty duration objects.
-- =

1.7.0.4


--===============5889677634112883913==--

