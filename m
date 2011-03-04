Content-Type: multipart/mixed; boundary="===============5125161555881111232=="
MIME-Version: 1.0
From: Antti Paila <antti.paila@nokia.com>
Subject: [PATCH] gisi: M6 coding style violation corrections
Date: Fri, 04 Mar 2011 10:28:44 +0200
Message-ID: <1299227324-10572-1-git-send-email-antti.paila@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5125161555881111232==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gisi/iter.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/gisi/iter.c b/gisi/iter.c
index f3f6f5a..8308c00 100644
--- a/gisi/iter.c
+++ b/gisi/iter.c
@@ -56,7 +56,7 @@ void g_isi_sb_iter_init_full(GIsiSubBlockIter *iter, cons=
t GIsiMessage *msg,
 		len =3D used =3D 0;
 =

 	iter->cursor =3D longhdr ? 4 : 2;
-	iter->start =3D (uint8_t *)data + used;
+	iter->start =3D (uint8_t *) data + used;
 	iter->end =3D iter->start + len;
 	iter->longhdr =3D longhdr;
 	iter->sub_blocks =3D len > used ? sub_blocks : 0;
@@ -72,7 +72,7 @@ void g_isi_sb_iter_init(GIsiSubBlockIter *iter, const GIs=
iMessage *msg,
 		len =3D used =3D 0;
 =

 	iter->cursor =3D 2;
-	iter->start =3D (uint8_t *)data + used;
+	iter->start =3D (uint8_t *) data + used;
 	iter->end =3D iter->start + len;
 	iter->longhdr =3D FALSE;
 	iter->sub_blocks =3D len > used ? iter->start[-1] : 0;
@@ -147,18 +147,18 @@ size_t g_isi_sb_iter_get_len(const GIsiSubBlockIter *=
iter)
 gboolean g_isi_sb_iter_get_data(const GIsiSubBlockIter *restrict iter,
 				void **data, unsigned pos)
 {
-	if ((size_t)pos > g_isi_sb_iter_get_len(iter)
+	if ((size_t) pos > g_isi_sb_iter_get_len(iter)
 			|| iter->start + pos > iter->end)
 		return FALSE;
 =

-	*data =3D (void *)iter->start + pos;
+	*data =3D (void *) iter->start + pos;
 	return TRUE;
 }
 =

 gboolean g_isi_sb_iter_get_byte(const GIsiSubBlockIter *restrict iter,
 				uint8_t *byte, unsigned pos)
 {
-	if ((size_t)pos > g_isi_sb_iter_get_len(iter)
+	if ((size_t) pos > g_isi_sb_iter_get_len(iter)
 			|| iter->start + pos > iter->end)
 		return FALSE;
 =

@@ -257,8 +257,8 @@ gboolean g_isi_sb_iter_get_alpha_tag(const GIsiSubBlock=
Iter *restrict iter,
 	if (ucs2 + len > iter->end)
 		return FALSE;
 =

-	*utf8 =3D g_convert((const char *)ucs2, len, "UTF-8//TRANSLIT", "UCS-2BE",
-				NULL, NULL, NULL);
+	*utf8 =3D g_convert((const char *) ucs2, len, "UTF-8//TRANSLIT",
+				"UCS-2BE", NULL, NULL, NULL);
 	return *utf8 !=3D NULL;
 }
 =

@@ -290,7 +290,7 @@ gboolean g_isi_sb_iter_get_latin_tag(const GIsiSubBlock=
Iter *restrict iter,
 	if (str + len > iter->end)
 		return FALSE;
 =

-	*latin =3D g_strndup((char *)str, len);
+	*latin =3D g_strndup((char *) str, len);
 =

 	return *latin !=3D NULL;
 }
-- =

1.7.1


--===============5125161555881111232==--

