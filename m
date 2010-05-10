Content-Type: multipart/mixed; boundary="===============7693138418130296218=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 07/19] stkutil: Refactor parser for tone objects
Date: Mon, 10 May 2010 18:38:50 +0800
Message-ID: <1273487942-27213-7-git-send-email-yang.gu@intel.com>
In-Reply-To: <1273487942-27213-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7693138418130296218==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   13 ++-----------
 1 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 0f0ea34..44cef10 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -511,17 +511,8 @@ static gboolean parse_dataobj_text(struct comprehensio=
n_tlv_iter *iter,
 static gboolean parse_dataobj_tone(struct comprehension_tlv_iter *iter,
 					void *user)
 {
-	unsigned char *tone =3D user;
-	const unsigned char *data;
-
-	if (comprehension_tlv_iter_get_length(iter) !=3D  1)
-		return FALSE;
-
-	data =3D comprehension_tlv_iter_get_data(iter);
-
-	*tone =3D data[0];
-
-	return TRUE;
+	unsigned char *byte =3D user;
+	return parse_dataobj_common_byte(iter, byte);
 }
 =

 /* Defined in TS 102.223 Section 8.18 */
-- =

1.7.0.4


--===============7693138418130296218==--

