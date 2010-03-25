Content-Type: multipart/mixed; boundary="===============3000812391511959842=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 6/7] Use common bool parser to reimplement immediate response
 object
Date: Fri, 26 Mar 2010 00:07:35 +0800
Message-ID: <1269533256-29095-6-git-send-email-yang.gu@intel.com>
In-Reply-To: <1269533256-29095-5-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3000812391511959842==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   14 ++------------
 1 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index ecf1301..4e42ae4 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -637,18 +637,8 @@ static gboolean parse_dataobj_icon_id(struct comprehen=
sion_tlv_iter *iter,
 static gboolean parse_dataobj_imm_resp(struct comprehension_tlv_iter *iter,
 					void *user)
 {
-	gboolean *resp =3D user;
-
-	if (comprehension_tlv_iter_get_tag(iter) !=3D
-			STK_DATA_OBJECT_TYPE_IMMEDIATE_RESPONSE)
-		return FALSE;
-
-	if (comprehension_tlv_iter_get_length(iter) !=3D 0)
-		return FALSE;
-
-	*resp =3D TRUE;
-
-	return TRUE;
+	return parse_dataobj_common_bool(iter, user,
+				STK_DATA_OBJECT_TYPE_IMMEDIATE_RESPONSE);
 }
 =

 /* Defined in TS 102.223 Section 8.72 */
-- =

1.6.3.3


--===============3000812391511959842==--

