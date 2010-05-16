Content-Type: multipart/mixed; boundary="===============1366030531033771834=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 01/27] Add utilities for encoding BTLVs and CTLVs.
Date: Sun, 16 May 2010 16:01:28 +0200
Message-ID: <1274018488-6289-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1366030531033771834==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This version merges ber_tlv_builder_next and _set_tag into one function,
same for comprehension tlvs.  The ber_tlv_iter and ber_tlv_builder
structs are not merged because the pointers in _iter need to be const
else ugly casting is needed.
---
 src/simutil.c |  310 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/simutil.h |   47 +++++++++
 2 files changed, 357 insertions(+), 0 deletions(-)

diff --git a/src/simutil.c b/src/simutil.c
index b98c011..a0e824a 100644
--- a/src/simutil.c
+++ b/src/simutil.c
@@ -498,6 +498,316 @@ static const guint8 *ber_tlv_find_by_tag(const guint8=
 *pdu, guint8 in_tag,
 	return NULL;
 }
 =

+#define MAX_BER_TLV_HEADER 8
+
+gboolean ber_tlv_builder_init(struct ber_tlv_builder *builder,
+				unsigned char *pdu, unsigned int size)
+{
+	if (size < MAX_BER_TLV_HEADER)
+		return FALSE;
+
+	builder->pdu =3D pdu;
+	builder->pos =3D 0;
+	builder->max =3D size;
+	builder->parent =3D NULL;
+	builder->tag =3D 0xff;
+	builder->len =3D 0;
+
+	return TRUE;
+}
+
+static void ber_tlv_builder_write_header(struct ber_tlv_builder *builder)
+{
+	int header_len =3D 0;
+	int start =3D builder->pos + MAX_BER_TLV_HEADER;
+
+	/* Write length at end of the header space */
+	if (builder->len <=3D 0x7f)
+		builder->pdu[start - ++header_len] =3D builder->len;
+	else {
+		while (builder->len >> (header_len * 8)) {
+			builder->pdu[start - 1 - header_len] =3D
+				builder->len >> (header_len * 8);
+			header_len++;
+		}
+		builder->pdu[start - 1 - header_len] =3D 0x80 + header_len;
+		header_len++;
+	}
+
+	/* Write the tag before length */
+	if (builder->tag < 0x1f)
+		builder->pdu[start - ++header_len] =3D
+			(builder->class << 6) |
+			(builder->encoding << 5) |
+			builder->tag;
+	else {
+		int i =3D 0;
+
+		while (builder->tag >> (i * 7)) {
+			builder->pdu[start - ++header_len] =3D
+				i ? 0x80 | (builder->tag >> (i * 7)) :
+				(builder->tag & 0x7f);
+			i++;
+		}
+
+		builder->pdu[start - ++header_len] =3D
+			(builder->class << 6) | (builder->encoding << 5) | 0x1f;
+	}
+
+	/* Pad with stuff bytes */
+	if (header_len < MAX_BER_TLV_HEADER)
+		memset(builder->pdu + builder->pos, 0xff,
+				MAX_BER_TLV_HEADER - header_len);
+}
+
+gboolean ber_tlv_builder_next(struct ber_tlv_builder *builder,
+				enum ber_tlv_data_type class,
+				enum ber_tlv_data_encoding_type encoding,
+				unsigned int new_tag)
+{
+	if (builder->tag !=3D 0xff) {
+		ber_tlv_builder_write_header(builder);
+
+		builder->pos +=3D MAX_BER_TLV_HEADER + builder->len;
+	}
+
+	if (builder->pos + MAX_BER_TLV_HEADER > builder->max)
+		return FALSE;
+
+	if (builder->parent)
+		if (ber_tlv_builder_set_length(builder->parent, builder->pos +
+					MAX_BER_TLV_HEADER) =3D=3D FALSE)
+			return FALSE;
+
+	builder->class =3D class;
+	builder->encoding =3D encoding;
+	builder->tag =3D new_tag;
+	builder->len =3D 0;
+
+	return TRUE;
+}
+
+/* Resize the TLV because the content of Value field needs more space.  If
+ * this TLV is part of another TLV, resize that one too.  */
+gboolean ber_tlv_builder_set_length(struct ber_tlv_builder *builder,
+					unsigned int new_len)
+{
+	if (builder->pos + MAX_BER_TLV_HEADER + new_len > builder->max)
+		return FALSE;
+
+	if (builder->parent)
+		if (ber_tlv_builder_set_length(builder->parent,
+					builder->pos + MAX_BER_TLV_HEADER +
+					new_len) =3D=3D FALSE)
+			return FALSE;
+
+	builder->len =3D new_len;
+
+	return TRUE;
+}
+
+unsigned char *ber_tlv_builder_get_data(struct ber_tlv_builder *builder)
+{
+	return builder->pdu + builder->pos + MAX_BER_TLV_HEADER;
+}
+
+gboolean ber_tlv_builder_recurse(struct ber_tlv_builder *builder,
+					struct ber_tlv_builder *recurse)
+{
+	unsigned char *end =3D builder->pdu + builder->max;
+	unsigned char *data =3D ber_tlv_builder_get_data(builder);
+
+	if (ber_tlv_builder_init(recurse, data, end - data) =3D=3D FALSE)
+		return FALSE;
+
+	recurse->parent =3D builder;
+
+	return TRUE;
+}
+
+gboolean ber_tlv_builder_recurse_comprehension(struct ber_tlv_builder *bui=
lder,
+				struct comprehension_tlv_builder *recurse)
+{
+	unsigned char *end =3D builder->pdu + builder->max;
+	unsigned char *data =3D ber_tlv_builder_get_data(builder);
+
+	if (comprehension_tlv_builder_init(recurse, data, end - data) =3D=3D FALS=
E)
+		return FALSE;
+
+	recurse->parent =3D builder;
+
+	return TRUE;
+}
+
+void ber_tlv_builder_optimize(struct ber_tlv_builder *builder,
+				unsigned char **pdu, unsigned int *len)
+{
+	ber_tlv_builder_write_header(builder);
+
+	if (pdu =3D=3D NULL)
+		return;
+
+	*len =3D builder->pos + MAX_BER_TLV_HEADER + builder->len;
+	*pdu =3D builder->pdu;
+
+	while (**pdu =3D=3D 0xff) {
+		(*len)--;
+		(*pdu)++;
+	}
+}
+
+gboolean comprehension_tlv_builder_init(
+				struct comprehension_tlv_builder *builder,
+				unsigned char *pdu, unsigned int size)
+{
+	if (size < 2)
+		return FALSE;
+
+	builder->pdu =3D pdu;
+	builder->pos =3D 0;
+	builder->max =3D size;
+	builder->parent =3D NULL;
+
+	builder->pdu[0] =3D 0;
+	builder->pdu[1] =3D 0;
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
+gboolean comprehension_tlv_builder_next(
+				struct comprehension_tlv_builder *builder,
+				gboolean cr, unsigned short tag)
+{
+	unsigned int taglen =3D 0;
+	unsigned int lenlen =3D 0;
+	unsigned int len =3D 0;
+
+	if (builder->pdu[builder->pos] !=3D 0) {
+		taglen =3D comprehension_tlv_get_tag_len(builder->pdu +
+							builder->pos);
+		lenlen =3D 1;
+		len =3D builder->pdu[builder->pos + taglen];
+
+		if (len >=3D 0x80) {
+			unsigned int extended_bytes =3D len - 0x80;
+			unsigned int i;
+
+			for (len =3D 0, i =3D 1; i <=3D extended_bytes; i++)
+				len =3D (len << 8) |
+					builder->pdu[builder->pos + taglen + i];
+
+			lenlen +=3D extended_bytes;
+		}
+	}
+
+	if (builder->pos + taglen + lenlen + len + (tag < 0x7f ? 1 : 3) + 1 >
+			builder->max)
+		return FALSE;
+
+	builder->pos +=3D taglen + lenlen + len;
+	if (tag < 0x7f) {
+		builder->pdu[builder->pos + 0] =3D (cr ? 0x80 : 0x00) | tag;
+		builder->pdu[builder->pos + 1] =3D 0; /* Length */
+	} else {
+		if (builder->pos + 4 > builder->max)
+			return FALSE;
+
+		builder->pdu[builder->pos + 0] =3D 0x7f;
+		builder->pdu[builder->pos + 1] =3D (cr ? 0x80 : 0) | (tag >> 8);
+		builder->pdu[builder->pos + 2] =3D tag & 0xff;
+		builder->pdu[builder->pos + 3] =3D 0; /* Length */
+	}
+
+	return TRUE;
+}
+
+/* Resize the TLV because the content of Value field needs more space.  If
+ * this TLV is part of another TLV, resize that one too.  */
+gboolean comprehension_tlv_builder_set_length(
+				struct comprehension_tlv_builder *builder,
+				unsigned int new_len)
+{
+	unsigned char *tlv =3D builder->pdu + builder->pos;
+	unsigned int taglen =3D comprehension_tlv_get_tag_len(tlv);
+	unsigned int lenlen =3D 1, new_lenlen =3D 1;
+	unsigned int len =3D tlv[taglen];
+	unsigned int ctlv_len, new_ctlv_len;
+
+	/* How much space do we occupy now */
+	if (len >=3D 0x80) {
+		unsigned int extended_bytes =3D len - 0x80;
+		unsigned int i;
+
+		for (len =3D 0, i =3D 1; i <=3D extended_bytes; i++)
+			len =3D (len << 8) | tlv[taglen + i];
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
+	if (builder->pos + new_ctlv_len > builder->max)
+		return FALSE;
+
+	if (builder->parent)
+		if (ber_tlv_builder_set_length(builder->parent, builder->pos +
+					new_ctlv_len) =3D=3D FALSE)
+			return FALSE;
+
+	len =3D MIN(len, new_len);
+	if (len > 0 && new_lenlen !=3D lenlen)
+		memmove(tlv + taglen + new_lenlen, tlv + taglen + lenlen, len);
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
+	return TRUE;
+}
+
+unsigned char *comprehension_tlv_builder_get_data(
+				struct comprehension_tlv_builder *builder)
+{
+	unsigned char *tlv =3D builder->pdu + builder->pos;
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
index 45b6847..53e7743 100644
--- a/src/simutil.h
+++ b/src/simutil.h
@@ -114,6 +114,25 @@ struct ber_tlv_iter {
 	const unsigned char *data;
 };
 =

+struct ber_tlv_builder {
+	unsigned int max;
+	unsigned int pos;
+	unsigned char *pdu;
+	struct ber_tlv_builder *parent;
+
+	unsigned int tag;
+	enum ber_tlv_data_type class;
+	enum ber_tlv_data_encoding_type encoding;
+	unsigned int len;
+};
+
+struct comprehension_tlv_builder {
+	unsigned int max;
+	unsigned int pos;
+	unsigned char *pdu;
+	struct ber_tlv_builder *parent;
+};
+
 void simple_tlv_iter_init(struct simple_tlv_iter *iter,
 				const unsigned char *pdu, unsigned int len);
 gboolean simple_tlv_iter_next(struct simple_tlv_iter *iter);
@@ -135,6 +154,18 @@ const unsigned char *comprehension_tlv_iter_get_data(
 void comprehension_tlv_iter_copy(struct comprehension_tlv_iter *from,
 					struct comprehension_tlv_iter *to);
 =

+gboolean comprehension_tlv_builder_init(
+				struct comprehension_tlv_builder *builder,
+				unsigned char *pdu, unsigned int size);
+gboolean comprehension_tlv_builder_next(
+				struct comprehension_tlv_builder *builder,
+				gboolean cr, unsigned short tag);
+gboolean comprehension_tlv_builder_set_length(
+				struct comprehension_tlv_builder *builder,
+				unsigned int len);
+unsigned char *comprehension_tlv_builder_get_data(
+				struct comprehension_tlv_builder *builder);
+
 void ber_tlv_iter_init(struct ber_tlv_iter *iter, const unsigned char *pdu,
 			unsigned int len);
 /*
@@ -167,6 +198,22 @@ void ber_tlv_iter_recurse_simple(struct ber_tlv_iter *=
iter,
 void ber_tlv_iter_recurse_comprehension(struct ber_tlv_iter *iter,
 					struct comprehension_tlv_iter *recurse);
 =

+gboolean ber_tlv_builder_init(struct ber_tlv_builder *builder,
+				unsigned char *pdu, unsigned int size);
+gboolean ber_tlv_builder_next(struct ber_tlv_builder *builder,
+				enum ber_tlv_data_type class,
+				enum ber_tlv_data_encoding_type encoding,
+				unsigned int new_tag);
+gboolean ber_tlv_builder_set_length(struct ber_tlv_builder *builder,
+					unsigned int len);
+unsigned char *ber_tlv_builder_get_data(struct ber_tlv_builder *builder);
+gboolean ber_tlv_builder_recurse(struct ber_tlv_builder *builder,
+					struct ber_tlv_builder *recurse);
+gboolean ber_tlv_builder_recurse_comprehension(struct ber_tlv_builder *bui=
lder,
+				struct comprehension_tlv_builder *recurse);
+void ber_tlv_builder_optimize(struct ber_tlv_builder *builder,
+				unsigned char **pdu, unsigned int *len);
+
 struct sim_eons *sim_eons_new(int pnn_records);
 void sim_eons_add_pnn_record(struct sim_eons *eons, int record,
 				const guint8 *tlv, int length);
-- =

1.7.1.86.g0e460.dirty


--===============1366030531033771834==--

