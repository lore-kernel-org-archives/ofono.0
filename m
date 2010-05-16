Content-Type: multipart/mixed; boundary="===============0557020308831764028=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 03/27] Add STK-specific CTLV encoding utilities.
Date: Sun, 16 May 2010 16:04:36 +0200
Message-ID: <1274018676-6360-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0557020308831764028==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This version is extra defensive.  I think we're doing a lot of useless
length checks to implement the _append_element approach, even though the
length of every ctlv can be known ahead.
---
 src/stkutil.c |  196 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 196 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index e053e2c..e4dcdfb 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -2849,3 +2849,199 @@ void stk_command_free(struct stk_command *command)
 =

 	g_free(command);
 }
+
+struct stk_tlv_builder {
+	struct comprehension_tlv_builder ctlv;
+	unsigned char *value;
+	unsigned int len;
+	unsigned int max_len;
+};
+
+static inline gboolean stk_tlv_builder_init(struct stk_tlv_builder *iter,
+						unsigned char *pdu,
+						unsigned int size)
+{
+	iter->value =3D NULL;
+	iter->len =3D 0;
+
+	return comprehension_tlv_builder_init(&iter->ctlv, pdu, size);
+}
+
+static inline gboolean stk_tlv_open_container(struct stk_tlv_builder *iter,
+						gboolean cr,
+						unsigned char shorttag,
+						gboolean relocatable)
+{
+	if (comprehension_tlv_builder_next(&iter->ctlv, cr, shorttag) !=3D TRUE)
+		return FALSE;
+
+	iter->len =3D 0;
+	iter->max_len =3D relocatable ? 0xff : 0x7f;
+	if (comprehension_tlv_builder_set_length(&iter->ctlv, iter->max_len) !=3D
+			TRUE)
+		return FALSE;
+
+	iter->value =3D comprehension_tlv_builder_get_data(&iter->ctlv);
+
+	return TRUE;
+}
+
+static inline gboolean stk_tlv_close_container(struct stk_tlv_builder *ite=
r)
+{
+	return comprehension_tlv_builder_set_length(&iter->ctlv, iter->len);
+}
+
+static inline unsigned int stk_tlv_get_length(struct stk_tlv_builder *iter)
+{
+	return comprehension_tlv_builder_get_data(&iter->ctlv) -
+		iter->ctlv.pdu + iter->len;
+}
+
+static inline gboolean stk_tlv_append_byte(struct stk_tlv_builder *iter,
+						unsigned char num)
+{
+	if (iter->len >=3D iter->max_len)
+		return FALSE;
+
+	iter->value[iter->len++] =3D num;
+	return TRUE;
+}
+
+static inline gboolean stk_tlv_append_short(struct stk_tlv_builder *iter,
+						unsigned short num)
+{
+	if (iter->len + 2 > iter->max_len)
+		return FALSE;
+
+	iter->value[iter->len++] =3D num >> 8;
+	iter->value[iter->len++] =3D num & 0xff;
+	return TRUE;
+}
+
+static inline gboolean stk_tlv_append_text(struct stk_tlv_builder *iter,
+						int dcs, const char *text)
+{
+	unsigned int len;
+	unsigned char *gsm, *ucs2;
+	long written =3D 0;
+	gsize gwritten;
+
+	if (text =3D=3D NULL)
+		return TRUE;
+
+	len =3D strlen(text);
+
+	switch (dcs) {
+	case 0x00:
+		gsm =3D convert_utf8_to_gsm(text, len, NULL, &written, 0);
+		if (gsm =3D=3D NULL && len > 0)
+			return FALSE;
+		if (iter->len + (written * 7 + 7) / 8 >=3D iter->max_len) {
+			g_free(gsm);
+			return FALSE;
+		}
+
+		iter->value[iter->len++] =3D 0x00;
+
+		pack_7bit_own_buf(gsm, len, 0, FALSE, &written, 0,
+					iter->value + iter->len);
+		g_free(gsm);
+		if (written < 1 && len > 0)
+			return FALSE;
+		iter->len +=3D written;
+
+		return TRUE;
+	case 0x04:
+		gsm =3D convert_utf8_to_gsm(text, len, NULL, &written, 0);
+		if (gsm =3D=3D NULL && len > 0)
+			return FALSE;
+		if (iter->len + written >=3D iter->max_len) {
+			g_free(gsm);
+			return FALSE;
+		}
+
+		iter->value[iter->len++] =3D 0x04;
+
+		memcpy(iter->value + iter->len, gsm, written);
+		iter->len +=3D written;
+
+		g_free(gsm);
+
+		return TRUE;
+	case 0x08:
+		ucs2 =3D (unsigned char *) g_convert((const gchar *) text, len,
+						"UCS-2BE", "UTF-8//TRANSLIT",
+						NULL, &gwritten, NULL);
+		if (ucs2 =3D=3D NULL)
+			return FALSE;
+		if (iter->len + gwritten >=3D iter->max_len) {
+			g_free(ucs2);
+			return FALSE;
+		}
+
+		iter->value[iter->len++] =3D 0x08;
+
+		memcpy(iter->value + iter->len, ucs2, gwritten);
+		iter->len +=3D gwritten;
+
+		g_free(ucs2);
+
+		return TRUE;
+	case -1:
+		/* Fake DCS to mean unpacked GSM alphabet if possible
+		 * to encode the string and UCS2 if not.  */
+		gsm =3D convert_utf8_to_gsm(text, len, NULL, &written, 0);
+
+		if (gsm =3D=3D NULL && len > 0) {
+			/* Use UCS2. */
+			ucs2 =3D (unsigned char *) g_convert(
+					(const gchar *) text, len,
+					"UCS-2BE", "UTF-8//TRANSLIT",
+					NULL, &gwritten, NULL);
+			if (ucs2 =3D=3D NULL)
+				return FALSE;
+			if (iter->len + gwritten >=3D iter->max_len) {
+				g_free(ucs2);
+				return FALSE;
+			}
+
+			iter->value[iter->len++] =3D 0x08;
+
+			memcpy(iter->value + iter->len, ucs2, gwritten);
+			iter->len +=3D gwritten;
+
+			g_free(ucs2);
+
+			return TRUE;
+		}
+
+		if (iter->len + written >=3D iter->max_len) {
+			g_free(gsm);
+			return FALSE;
+		}
+
+		iter->value[iter->len++] =3D 0x04;
+
+		memcpy(iter->value + iter->len, gsm, written);
+		iter->len +=3D written;
+
+		g_free(gsm);
+
+		return TRUE;
+	}
+
+	return FALSE;
+}
+
+static inline gboolean stk_tlv_append_bytes(struct stk_tlv_builder *iter,
+						const unsigned char *data,
+						unsigned int length)
+{
+	if (iter->len + length > iter->max_len)
+		return FALSE;
+
+	memcpy(iter->value + iter->len, data, length);
+	iter->len +=3D length;
+
+	return TRUE;
+}
-- =

1.7.1.86.g0e460.dirty


--===============0557020308831764028==--

