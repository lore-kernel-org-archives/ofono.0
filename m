Content-Type: multipart/mixed; boundary="===============1949260919232450089=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/3][RfC] Add utilities for encoding BTLVs and CTLVs.
Date: Thu, 22 Apr 2010 10:11:40 +0200
Message-ID: <1271923900-3349-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1949260919232450089==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/simutil.c |  396 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/simutil.h |   44 +++++++
 2 files changed, 440 insertions(+), 0 deletions(-)

diff --git a/src/simutil.c b/src/simutil.c
index 822938c..ab2e421 100644
--- a/src/simutil.c
+++ b/src/simutil.c
@@ -486,6 +486,402 @@ static const guint8 *ber_tlv_find_by_tag(const guint8=
 *pdu, guint8 in_tag,
 	return NULL;
 }
 =

+gboolean ber_tlv_constr_init(struct ber_tlv_constr *constr,
+				unsigned char *pdu, unsigned int size)
+{
+	if (size < 2)
+		return FALSE;
+
+	constr->pdu =3D pdu;
+	constr->pos =3D 0;
+	constr->max =3D size;
+	constr->parent =3D NULL;
+
+	return TRUE;
+}
+
+static inline unsigned int ber_tlv_get_tag_len(unsigned char *start)
+{
+	int len =3D 1;
+
+	if (bit_field(start[0], 0, 4) =3D=3D 0x1f)
+		while (start[len] & 0x80)
+			len++;
+
+	return len;
+}
+
+static inline unsigned int ber_tlv_get_len_len(unsigned char *start)
+{
+	return *start >=3D 0x80 ? *start - 0x7f : 1;
+}
+
+gboolean ber_tlv_constr_next(struct ber_tlv_constr *constr)
+{
+	unsigned int taglen =3D ber_tlv_get_tag_len(constr->pdu + constr->pos);
+	unsigned int lenlen =3D 1;
+	unsigned int len =3D constr->pdu[constr->pos + taglen];
+
+	if (len >=3D 0x80) {
+		unsigned int extended_bytes =3D len - 0x80;
+		unsigned int i;
+
+		for (len =3D 0, i =3D 1; i <=3D extended_bytes; i++)
+			len =3D (len << 8) |
+				constr->pdu[constr->pos + taglen + i];
+
+		lenlen +=3D extended_bytes;
+	}
+
+	if (constr->pos + taglen + lenlen + len + 2 > constr->max)
+		return FALSE;
+
+	constr->pos +=3D taglen + lenlen + len;
+	constr->pdu[constr->pos + 0] =3D 0; /* Tag */
+	constr->pdu[constr->pos + 1] =3D 0; /* Length */
+
+	return TRUE;
+}
+
+gboolean ber_tlv_constr_set_tag(struct ber_tlv_constr *constr,
+				enum ber_tlv_data_type class,
+				enum ber_tlv_data_encoding_type encoding,
+				unsigned short tag)
+{
+	if (tag < 0x1f)
+		constr->pdu[constr->pos] =3D
+			(class << 6) | (encoding << 5) | tag;
+	else {
+		int taglen =3D 0;
+		int i;
+
+		while (tag >> (taglen * 7))
+			taglen +=3D 1;
+
+		if (constr->pos + taglen + 2 > constr->max)
+			return FALSE;
+
+		constr->pdu[constr->pos] =3D
+			(class << 6) | (encoding << 5) | 0x1f;
+
+		for (i =3D 1; i < taglen; i +=3D 1)
+			constr->pdu[constr->pos + i] =3D 0x80 |
+				(tag >> ((taglen - i)) * 7);
+
+		constr->pdu[constr->pos + i++] =3D tag & 0x7f;
+		constr->pdu[constr->pos + i] =3D 0; /* Length */
+	}
+
+	return TRUE;
+}
+
+/* Resize the TLV because the content of Value field needs more space.  If
+ * this TLV is part of another TLV, resize that one too.  */
+static unsigned char *ber_tlv_constr_update_len(struct ber_tlv_constr *con=
str,
+						unsigned int new_len,
+						unsigned int pos)
+{
+	unsigned char *tlv =3D constr->pdu + pos;
+	unsigned int taglen =3D ber_tlv_get_tag_len(tlv);
+	unsigned int lenlen =3D 1, new_lenlen =3D 1;
+	unsigned int len =3D tlv[taglen];
+	unsigned int tlv_len, new_tlv_len;
+	unsigned int added_len =3D 0;
+
+	/* How much space do we occupy now */
+	if (len >=3D 0x80) {
+		unsigned int extended_bytes =3D len - 0x80;
+		unsigned int i;
+
+		for (len =3D 0, i =3D 1; i <=3D extended_bytes; i++)
+			len =3D (len << 8) |
+				tlv[taglen + i];
+
+		lenlen +=3D extended_bytes;
+	}
+
+	tlv_len =3D taglen + lenlen + len;
+
+	/* How much do we need */
+	if (new_len >=3D 0x80) {
+		unsigned int extended_bytes =3D 0;
+		while (new_len >> (extended_bytes * 8))
+			extended_bytes +=3D 1;
+		new_lenlen +=3D extended_bytes;
+	}
+
+	new_tlv_len =3D taglen + new_lenlen + new_len;
+
+	/* Check there is enough space */
+	if (constr->pos > pos)
+		added_len =3D constr->pos - (pos + tlv_len);
+
+	if (pos + new_tlv_len + added_len > constr->max)
+		return NULL;
+
+	if (constr->parent) {
+		unsigned char *new_pdu =3D ber_tlv_constr_update_len(
+						constr->parent,
+						pos + new_tlv_len + added_len,
+						constr->parent_pos);
+		if (new_pdu =3D=3D NULL)
+			return NULL;
+
+		constr->pdu =3D new_pdu;
+		tlv =3D constr->pdu + pos;
+	}
+
+	if (added_len > 0 && new_tlv_len !=3D tlv_len) {
+		memmove(tlv + new_tlv_len, tlv + tlv_len, added_len);
+		constr->pos +=3D new_tlv_len - tlv_len;
+	}
+
+	if (new_lenlen !=3D lenlen)
+		memmove(tlv + taglen + new_lenlen, tlv + taglen + lenlen,
+				tlv_len);
+
+	/* Write new length */
+	if (new_len < 0x80)
+		tlv[taglen] =3D new_len;
+	else {
+		unsigned int extended_bytes =3D 0;
+		unsigned int i;
+		while (new_len >> (extended_bytes * 8))
+			extended_bytes +=3D 1;
+
+		for (i =3D 1; i <=3D extended_bytes; i++)
+			tlv[taglen + i] =3D
+				(new_len >> ((extended_bytes - i) * 8)) & 0xff;
+
+		tlv[taglen] =3D 0x80 + extended_bytes;
+	}
+
+	return tlv + taglen + new_lenlen;
+}
+
+gboolean ber_tlv_constr_set_length(struct ber_tlv_constr *constr,
+					unsigned int new_len)
+{
+	return ber_tlv_constr_update_len(constr, new_len, constr->pos) !=3D NULL;
+}
+
+unsigned char *ber_tlv_constr_get_data(struct ber_tlv_constr *constr)
+{
+	unsigned char *tlv =3D constr->pdu + constr->pos;
+	unsigned int taglen =3D ber_tlv_get_tag_len(tlv);
+	unsigned int lenlen =3D ber_tlv_get_len_len(tlv + taglen);
+
+	return tlv + taglen + lenlen;
+}
+
+gboolean ber_tlv_constr_recurse(struct ber_tlv_constr *constr,
+				struct ber_tlv_constr *recurse)
+{
+	unsigned char *end =3D constr->pdu + constr->max;
+	unsigned char *data =3D ber_tlv_constr_get_data(constr);
+	gboolean r =3D ber_tlv_constr_init(recurse, data, end - data);
+
+	if (!r)
+		return FALSE;
+
+	recurse->parent =3D constr;
+	recurse->parent_pos =3D constr->pos;
+
+	return TRUE;
+}
+
+gboolean ber_tlv_constr_recurse_comprehension(struct ber_tlv_constr *const=
r,
+				struct comprehension_tlv_constr *recurse)
+{
+	unsigned char *end =3D constr->pdu + constr->max;
+	unsigned char *data =3D ber_tlv_constr_get_data(constr);
+	gboolean r =3D comprehension_tlv_constr_init(recurse, data, end - data);
+
+	if (!r)
+		return FALSE;
+
+	recurse->parent =3D constr;
+	recurse->parent_pos =3D constr->pos;
+
+	return TRUE;
+}
+
+gboolean comprehension_tlv_constr_init(struct comprehension_tlv_constr *co=
nstr,
+					unsigned char *pdu,
+					unsigned int size)
+{
+	if (size < 2)
+		return FALSE;
+
+	constr->pdu =3D pdu;
+	constr->pos =3D 0;
+	constr->max =3D size;
+	constr->parent =3D NULL;
+
+	return TRUE;
+}
+
+static inline unsigned int comprehension_tlv_get_tag_len(unsigned char *st=
art)
+{
+	return bit_field(*start, 0, 7) =3D=3D 0x7f ? 3 : 1;
+}
+
+static inline unsigned int comprehension_tlv_get_len_len(unsigned char *st=
art)
+{
+	return *start >=3D 0x80 ? *start - 0x7f : 1;
+}
+
+gboolean comprehension_tlv_constr_next(struct comprehension_tlv_constr *co=
nstr)
+{
+	unsigned int taglen =3D
+		comprehension_tlv_get_tag_len(constr->pdu + constr->pos);
+	unsigned int lenlen =3D 1;
+	unsigned int len =3D constr->pdu[constr->pos + taglen];
+
+	if (len >=3D 0x80) {
+		unsigned int extended_bytes =3D len - 0x80;
+		unsigned int i;
+
+		for (len =3D 0, i =3D 1; i <=3D extended_bytes; i++)
+			len =3D (len << 8) |
+				constr->pdu[constr->pos + taglen + i];
+
+		lenlen +=3D extended_bytes;
+	}
+
+	if (constr->pos + taglen + lenlen + len + 2 > constr->max)
+		return FALSE;
+
+	constr->pos +=3D taglen + lenlen + len;
+	constr->pdu[constr->pos + 0] =3D 0; /* Tag */
+	constr->pdu[constr->pos + 1] =3D 0; /* Length */
+
+	return TRUE;
+}
+
+gboolean comprehension_tlv_constr_set_tag(
+					struct comprehension_tlv_constr *constr,
+					gboolean cr, unsigned short tag)
+{
+	if (tag < 0x7f)
+		constr->pdu[constr->pos] =3D (cr ? 0x80 : 0x00) | tag;
+	else {
+		if (constr->pos + 4 > constr->max)
+			return FALSE;
+
+		constr->pdu[constr->pos] =3D 0x7f;
+		constr->pdu[constr->pos + 1] =3D (cr ? 0x80 : 0x00) | (tag >> 8);
+		constr->pdu[constr->pos + 2] =3D tag & 0xff;
+		constr->pdu[constr->pos + 3] =3D 0;
+	}
+
+	return TRUE;
+}
+
+/* Resize the TLV because the content of Value field needs more space.  If
+ * this TLV is part of another TLV, resize that one too.  */
+static unsigned char *comprehension_tlv_constr_update_len(
+					struct comprehension_tlv_constr *constr,
+					unsigned int new_len,
+					unsigned int pos)
+{
+	unsigned char *tlv =3D constr->pdu + pos;
+	unsigned int taglen =3D comprehension_tlv_get_tag_len(tlv);
+	unsigned int lenlen =3D 1, new_lenlen =3D 1;
+	unsigned int len =3D tlv[taglen];
+	unsigned int ctlv_len, new_ctlv_len;
+	unsigned int added_len =3D 0;
+
+	/* How much space do we occupy now */
+	if (len >=3D 0x80) {
+		unsigned int extended_bytes =3D len - 0x80;
+		unsigned int i;
+
+		for (len =3D 0, i =3D 1; i <=3D extended_bytes; i++)
+			len =3D (len << 8) |
+				tlv[taglen + i];
+
+		lenlen +=3D extended_bytes;
+	}
+
+	ctlv_len =3D taglen + lenlen + len;
+
+	/* How much do we need */
+	if (new_len >=3D 0x80) {
+		unsigned int extended_bytes =3D 0;
+		while (new_len >> (extended_bytes * 8))
+			extended_bytes +=3D 1;
+		new_lenlen +=3D extended_bytes;
+	}
+
+	new_ctlv_len =3D taglen + new_lenlen + new_len;
+
+	/* Check there is enough space */
+	if (constr->pos > pos)
+		added_len =3D constr->pos - (pos + ctlv_len);
+
+	if (pos + new_ctlv_len + added_len > constr->max)
+		return NULL;
+
+	if (constr->parent) {
+		unsigned char *new_pdu =3D ber_tlv_constr_update_len(
+						constr->parent,
+						pos + new_ctlv_len + added_len,
+						constr->parent_pos);
+		if (new_pdu =3D=3D NULL)
+			return NULL;
+
+		constr->pdu =3D new_pdu;
+		tlv =3D constr->pdu + pos;
+	}
+
+	if (added_len > 0) {
+		memmove(tlv + new_ctlv_len, tlv + ctlv_len, added_len);
+		constr->pos +=3D new_ctlv_len - ctlv_len;
+	}
+
+	if (new_lenlen > lenlen)
+		memmove(tlv + taglen + new_lenlen, tlv + taglen + lenlen,
+				new_lenlen - lenlen);
+
+	/* Write new length */
+	if (new_len < 0x80)
+		tlv[taglen] =3D new_len;
+	else {
+		unsigned int extended_bytes =3D 0;
+		unsigned int i;
+		while (new_len >> (extended_bytes * 8))
+			extended_bytes +=3D 1;
+
+		for (i =3D 1; i <=3D extended_bytes; i++)
+			tlv[taglen + i] =3D
+				(new_len >> ((extended_bytes - i) * 8)) & 0xff;
+
+		tlv[taglen] =3D 0x80 + extended_bytes;
+	}
+
+	return tlv + taglen + new_lenlen;
+}
+
+gboolean comprehension_tlv_constr_set_length(
+					struct comprehension_tlv_constr *constr,
+					unsigned int new_len)
+{
+	return comprehension_tlv_constr_update_len(constr,
+							new_len,
+							constr->pos) !=3D NULL;
+}
+
+unsigned char *comprehension_tlv_constr_get_data(
+				struct comprehension_tlv_constr *constr)
+{
+	unsigned char *tlv =3D constr->pdu + constr->pos;
+	unsigned int taglen =3D comprehension_tlv_get_tag_len(tlv);
+	unsigned int lenlen =3D comprehension_tlv_get_len_len(tlv + taglen);
+
+	return tlv + taglen + lenlen;
+}
+
 static char *sim_network_name_parse(const unsigned char *buffer, int lengt=
h,
 					gboolean *add_ci)
 {
diff --git a/src/simutil.h b/src/simutil.h
index 7590cca..60db647 100644
--- a/src/simutil.h
+++ b/src/simutil.h
@@ -114,6 +114,22 @@ struct ber_tlv_iter {
 	const unsigned char *data;
 };
 =

+struct ber_tlv_constr {
+	unsigned int max;
+	unsigned int pos;
+	unsigned char *pdu;
+	struct ber_tlv_constr *parent;
+	unsigned int parent_pos;
+};
+
+struct comprehension_tlv_constr {
+	unsigned int max;
+	unsigned int pos;
+	unsigned char *pdu;
+	struct ber_tlv_constr *parent;
+	unsigned int parent_pos;
+};
+
 void simple_tlv_iter_init(struct simple_tlv_iter *iter,
 				const unsigned char *pdu, unsigned int len);
 gboolean simple_tlv_iter_next(struct simple_tlv_iter *iter);
@@ -132,6 +148,18 @@ unsigned int comprehension_tlv_iter_get_length(
 const unsigned char *comprehension_tlv_iter_get_data(
 					struct comprehension_tlv_iter *iter);
 =

+gboolean comprehension_tlv_constr_init(struct comprehension_tlv_constr *co=
nstr,
+					unsigned char *pdu, unsigned int size);
+gboolean comprehension_tlv_constr_next(struct comprehension_tlv_constr *co=
nstr);
+gboolean comprehension_tlv_constr_set_tag(
+					struct comprehension_tlv_constr *constr,
+					gboolean cr, unsigned short tag);
+gboolean comprehension_tlv_constr_set_length(
+					struct comprehension_tlv_constr *constr,
+					unsigned int len);
+unsigned char *comprehension_tlv_constr_get_data(
+				struct comprehension_tlv_constr *constr);
+
 void ber_tlv_iter_init(struct ber_tlv_iter *iter, const unsigned char *pdu,
 			unsigned int len);
 /*
@@ -164,6 +192,22 @@ void ber_tlv_iter_recurse_simple(struct ber_tlv_iter *=
iter,
 void ber_tlv_iter_recurse_comprehension(struct ber_tlv_iter *iter,
 					struct comprehension_tlv_iter *recurse);
 =

+gboolean ber_tlv_constr_init(struct ber_tlv_constr *constr,
+				unsigned char *pdu, unsigned int size);
+gboolean ber_tlv_constr_set_tag(struct ber_tlv_constr *constr,
+				enum ber_tlv_data_type class,
+				enum ber_tlv_data_encoding_type encoding,
+				unsigned short tag);
+gboolean ber_tlv_constr_set_length(struct ber_tlv_constr *constr,
+					unsigned int len);
+unsigned char *ber_tlv_constr_get_data(struct ber_tlv_constr *constr);
+gboolean ber_tlv_constr_next(struct ber_tlv_constr *constr);
+gboolean ber_tlv_constr_recurse(struct ber_tlv_constr *constr,
+				struct ber_tlv_constr *recurse);
+gboolean ber_tlv_constr_recurse_comprehension(struct ber_tlv_constr *const=
r,
+				struct comprehension_tlv_constr *recurse);
+
+
 struct sim_eons *sim_eons_new(int pnn_records);
 void sim_eons_add_pnn_record(struct sim_eons *eons, int record,
 				const guint8 *tlv, int length);
-- =

1.6.1


--===============1949260919232450089==--

