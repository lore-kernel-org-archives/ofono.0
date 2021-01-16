Content-Type: multipart/mixed; boundary="===============8865517778399154510=="
MIME-Version: 1.0
From: Sergey Matyukevich <geomatsi@gmail.com>
Subject: [PATCH v3 1/3] simutil: add validate_utf8_tlv
Date: Sat, 16 Jan 2021 22:21:05 +0300
Message-ID: <20210116192107.18568-2-geomatsi@gmail.com>
In-Reply-To: <20210116192107.18568-1-geomatsi@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8865517778399154510==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add helper to validate if TLV value is a valid UTF8 string.
Note that both null-terminated and non null-terminated UTF8
strings are considered valid.
---
 src/simutil.c | 14 ++++++++++++++
 src/simutil.h |  1 +
 2 files changed, 15 insertions(+)

diff --git a/src/simutil.c b/src/simutil.c
index 4e0d3311..5808b14e 100644
--- a/src/simutil.c
+++ b/src/simutil.c
@@ -765,6 +765,20 @@ unsigned char *comprehension_tlv_builder_get_data(
 	return tlv + tag_size + len_size;
 }
 =

+gboolean validate_utf8_tlv(const unsigned char *tlv)
+{
+	int len =3D tlv[1];
+
+	if (len =3D=3D 0)
+		return FALSE;
+
+	/* support both null-termiated and non null-terminated UTF8 TLV value */
+	if (tlv[len + 1] =3D=3D '\0')
+		len -=3D 1;
+
+	return g_utf8_validate_len((const char *)tlv + 2, len, NULL);
+}
+
 static char *sim_network_name_parse(const unsigned char *buffer, int lengt=
h,
 					gboolean *add_ci)
 {
diff --git a/src/simutil.h b/src/simutil.h
index 14a39957..33b775a7 100644
--- a/src/simutil.h
+++ b/src/simutil.h
@@ -403,6 +403,7 @@ gboolean comprehension_tlv_builder_set_length(
 				unsigned int len);
 unsigned char *comprehension_tlv_builder_get_data(
 				struct comprehension_tlv_builder *builder);
+gboolean validate_utf8_tlv(const unsigned char *data);
 =

 void ber_tlv_iter_init(struct ber_tlv_iter *iter, const unsigned char *pdu,
 			unsigned int len);
--===============8865517778399154510==--

