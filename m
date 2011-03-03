Content-Type: multipart/mixed; boundary="===============3930875555704037954=="
MIME-Version: 1.0
From: Antti Paila <antti.paila@nokia.com>
Subject: [PATCH] gisi: Consumer functions for ISI message iterator
Date: Thu, 03 Mar 2011 09:22:39 +0200
Message-ID: <1299136959-22653-1-git-send-email-antti.paila@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3930875555704037954==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gisi/iter.c |   63 +++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 gisi/iter.h |   13 ++++++++++++
 2 files changed, 76 insertions(+), 0 deletions(-)

diff --git a/gisi/iter.c b/gisi/iter.c
index a925b15..f3f6f5a 100644
--- a/gisi/iter.c
+++ b/gisi/iter.c
@@ -55,6 +55,7 @@ void g_isi_sb_iter_init_full(GIsiSubBlockIter *iter, cons=
t GIsiMessage *msg,
 	if (data =3D=3D NULL)
 		len =3D used =3D 0;
 =

+	iter->cursor =3D longhdr ? 4 : 2;
 	iter->start =3D (uint8_t *)data + used;
 	iter->end =3D iter->start + len;
 	iter->longhdr =3D longhdr;
@@ -70,6 +71,7 @@ void g_isi_sb_iter_init(GIsiSubBlockIter *iter, const GIs=
iMessage *msg,
 	if (data =3D=3D NULL)
 		len =3D used =3D 0;
 =

+	iter->cursor =3D 2;
 	iter->start =3D (uint8_t *)data + used;
 	iter->end =3D iter->start + len;
 	iter->longhdr =3D FALSE;
@@ -85,6 +87,7 @@ void g_isi_sb_subiter_init(GIsiSubBlockIter *outer, GIsiS=
ubBlockIter *inner,
 			outer->start + used > outer->end)
 		len =3D used =3D 0;
 =

+	inner->cursor =3D 2;
 	inner->start =3D outer->start + used;
 	inner->end =3D inner->start + len;
 	inner->longhdr =3D FALSE;
@@ -101,6 +104,7 @@ void g_isi_sb_subiter_init_full(GIsiSubBlockIter *outer,
 			outer->start + used > outer->end)
 		len =3D used =3D 0;
 =

+	inner->cursor =3D longhdr ? 4 : 2;
 	inner->start =3D outer->start + used;
 	inner->end =3D inner->start + len;
 	inner->longhdr =3D longhdr;
@@ -188,6 +192,35 @@ gboolean g_isi_sb_iter_get_dword(const GIsiSubBlockIte=
r *restrict iter,
 	return TRUE;
 }
 =

+gboolean g_isi_sb_iter_eat_byte(GIsiSubBlockIter *restrict iter,
+				uint8_t *byte)
+{
+	if (!g_isi_sb_iter_get_byte(iter, byte, iter->cursor))
+		return FALSE;
+
+	iter->cursor +=3D 1;
+	return TRUE;
+}
+gboolean g_isi_sb_iter_eat_word(GIsiSubBlockIter *restrict iter,
+				uint16_t *word)
+{
+	if (!g_isi_sb_iter_get_word(iter, word, iter->cursor))
+		return FALSE;
+
+	iter->cursor +=3D 2;
+	return TRUE;
+}
+
+gboolean g_isi_sb_iter_eat_dword(GIsiSubBlockIter *restrict iter,
+				uint32_t *dword)
+{
+	if (!g_isi_sb_iter_get_dword(iter, dword, iter->cursor))
+		return FALSE;
+
+	iter->cursor +=3D 4;
+	return TRUE;
+}
+
 gboolean g_isi_sb_iter_get_oper_code(const GIsiSubBlockIter *restrict iter,
 					char *mcc, char *mnc, unsigned pos)
 {
@@ -198,6 +231,16 @@ gboolean g_isi_sb_iter_get_oper_code(const GIsiSubBloc=
kIter *restrict iter,
 	return TRUE;
 }
 =

+gboolean g_isi_sb_iter_eat_oper_code(GIsiSubBlockIter *restrict iter,
+					char *mcc, char *mnc)
+{
+	if (!g_isi_sb_iter_get_oper_code(iter, mcc, mnc, iter->cursor))
+		return FALSE;
+
+	iter->cursor +=3D 3;
+	return TRUE;
+}
+
 gboolean g_isi_sb_iter_get_alpha_tag(const GIsiSubBlockIter *restrict iter,
 					char **utf8, size_t len, unsigned pos)
 {
@@ -219,6 +262,15 @@ gboolean g_isi_sb_iter_get_alpha_tag(const GIsiSubBloc=
kIter *restrict iter,
 	return *utf8 !=3D NULL;
 }
 =

+gboolean g_isi_sb_iter_eat_alpha_tag(GIsiSubBlockIter *restrict iter,
+					char **utf8, size_t len)
+{
+	if (!g_isi_sb_iter_get_alpha_tag(iter, utf8, len, iter->cursor))
+		return FALSE;
+
+	iter->cursor +=3D len;
+	return TRUE;
+}
 gboolean g_isi_sb_iter_get_latin_tag(const GIsiSubBlockIter *restrict iter,
 					char **latin, size_t len, unsigned pos)
 {
@@ -243,6 +295,15 @@ gboolean g_isi_sb_iter_get_latin_tag(const GIsiSubBloc=
kIter *restrict iter,
 	return *latin !=3D NULL;
 }
 =

+gboolean g_isi_sb_iter_eat_latin_tag(GIsiSubBlockIter *restrict iter,
+					char **latin, size_t len)
+{
+	if (!g_isi_sb_iter_get_latin_tag(iter, latin, len, iter->cursor))
+		return FALSE;
+
+	iter->cursor +=3D len;
+	return TRUE;
+}
 gboolean g_isi_sb_iter_next(GIsiSubBlockIter *iter)
 {
 	uint8_t len =3D g_isi_sb_iter_get_len(iter);
@@ -256,6 +317,8 @@ gboolean g_isi_sb_iter_next(GIsiSubBlockIter *iter)
 	if (iter->start + len > iter->end)
 		return FALSE;
 =

+
+	iter->cursor =3D iter->longhdr ? 4 : 2;
 	iter->start +=3D len;
 	iter->sub_blocks--;
 =

diff --git a/gisi/iter.h b/gisi/iter.h
index 1dfcfa9..2fe4ec5 100644
--- a/gisi/iter.h
+++ b/gisi/iter.h
@@ -31,6 +31,7 @@ extern "C" {
 #include "message.h"
 =

 struct _GIsiSubBlockIter {
+	uint8_t cursor;
 	uint8_t *start;
 	uint8_t *end;
 	gboolean longhdr;
@@ -63,12 +64,24 @@ gboolean g_isi_sb_iter_get_word(const GIsiSubBlockIter =
*restrict iter,
 				uint16_t *word, unsigned pos);
 gboolean g_isi_sb_iter_get_dword(const GIsiSubBlockIter *restrict iter,
 					uint32_t *dword, unsigned pos);
+gboolean g_isi_sb_iter_eat_byte(GIsiSubBlockIter *restrict iter,
+				uint8_t *byte);
+gboolean g_isi_sb_iter_eat_word(GIsiSubBlockIter *restrict iter,
+				uint16_t *word);
+gboolean g_isi_sb_iter_eat_dword(GIsiSubBlockIter *restrict iter,
+				uint32_t *dword);
 gboolean g_isi_sb_iter_get_oper_code(const GIsiSubBlockIter *restrict iter,
 					char *mcc, char *mnc, unsigned pos);
+gboolean g_isi_sb_iter_eat_oper_code(GIsiSubBlockIter *restrict iter,
+					char *mcc, char *mnc);
 gboolean g_isi_sb_iter_get_alpha_tag(const GIsiSubBlockIter *restrict iter,
 					char **utf8, size_t len, unsigned pos);
+gboolean g_isi_sb_iter_eat_alpha_tag(GIsiSubBlockIter *restrict iter,
+					char **utf8, size_t len);
 gboolean g_isi_sb_iter_get_latin_tag(const GIsiSubBlockIter *restrict iter,
 					char **ascii, size_t len, unsigned pos);
+gboolean g_isi_sb_iter_eat_latin_tag(GIsiSubBlockIter *restrict iter,
+					char **ascii, size_t len);
 gboolean g_isi_sb_iter_get_struct(const GIsiSubBlockIter *restrict iter,
 					void **ptr, size_t len, unsigned pos);
 =

-- =

1.7.1


--===============3930875555704037954==--

