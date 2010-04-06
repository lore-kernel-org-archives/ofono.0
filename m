Content-Type: multipart/mixed; boundary="===============7954694769275553712=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 02/13] Add parser for url objects
Date: Tue, 06 Apr 2010 18:06:36 +0800
Message-ID: <1270548407-12042-2-git-send-email-yang.gu@intel.com>
In-Reply-To: <1270548407-12042-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7954694769275553712==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 3fac701..2fc5287 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -1014,6 +1014,14 @@ static gboolean parse_dataobj_browser_id(struct comp=
rehension_tlv_iter *iter,
 	return parse_dataobj_common_byte(iter, byte);
 }
 =

+/* Defined in TS 102.223 Section 8.48 */
+static gboolean parse_dataobj_url(struct comprehension_tlv_iter *iter,
+					void *user)
+{
+	char **url =3D user;
+	return parse_dataobj_common_text(iter, url);
+}
+
 /* Defined in TS 102.223 Section 8.72 */
 static gboolean parse_dataobj_text_attr(struct comprehension_tlv_iter *ite=
r,
 					void *user)
@@ -1138,6 +1146,8 @@ static dataobj_handler handler_for_type(enum stk_data=
_object_type type)
 		return parse_dataobj_language;
 	case STK_DATA_OBJECT_TYPE_BROWSER_ID:
 		return parse_dataobj_browser_id;
+	case STK_DATA_OBJECT_TYPE_URL:
+		return parse_dataobj_url;
 	case STK_DATA_OBJECT_TYPE_TEXT_ATTRIBUTE:
 		return parse_dataobj_text_attr;
 	case STK_DATA_OBJECT_TYPE_FRAME_ID:
-- =

1.6.3.3


--===============7954694769275553712==--

