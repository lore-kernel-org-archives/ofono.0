Content-Type: multipart/mixed; boundary="===============3886614598596807037=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 3/8] Add STK-specific CTLV encoding utilities.
Date: Mon, 10 May 2010 11:33:58 +0200
Message-ID: <1273484038-32189-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3886614598596807037==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |  155 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 155 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 50fa4c1..e51090c 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -2343,3 +2343,158 @@ void stk_command_free(struct stk_command *command)
 =

 	g_free(command);
 }
+
+struct stk_tlv_builder {
+	struct comprehension_tlv_builder ctlv;
+	unsigned char *value;
+	int len;
+};
+
+static inline void stk_tlv_builder_init(struct stk_tlv_builder *iter,
+					unsigned char *pdu, unsigned int size)
+{
+	comprehension_tlv_builder_init(&iter->ctlv, pdu, size);
+	iter->value =3D NULL;
+}
+
+static inline gboolean stk_tlv_open_container(struct stk_tlv_builder *iter,
+						gboolean cr,
+						unsigned char shorttag,
+						gboolean relocatable)
+{
+	comprehension_tlv_builder_set_tag(&iter->ctlv, cr, shorttag);
+	comprehension_tlv_builder_set_length(&iter->ctlv,
+						relocatable ? 0xff : 0x7f);
+	iter->len =3D 0;
+	iter->value =3D comprehension_tlv_builder_get_data(&iter->ctlv);
+
+	return TRUE;
+}
+
+static inline gboolean stk_tlv_close_container(struct stk_tlv_builder *ite=
r)
+{
+	return comprehension_tlv_builder_set_length(&iter->ctlv, iter->len) &&
+		comprehension_tlv_builder_next(&iter->ctlv);
+}
+
+static inline unsigned int stk_tlv_get_length(struct stk_tlv_builder *iter)
+{
+	return iter->ctlv.pos;
+}
+
+static inline void stk_tlv_append_byte(struct stk_tlv_builder *iter,
+					unsigned char num)
+{
+	iter->value[iter->len++] =3D num;
+}
+
+static inline void stk_tlv_append_short(struct stk_tlv_builder *iter,
+					unsigned short num)
+{
+	iter->value[iter->len++] =3D num >> 8;
+	iter->value[iter->len++] =3D num & 0xff;
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
+		gsm =3D convert_utf8_to_gsm(text, len, NULL, NULL, 0);
+		if (gsm =3D=3D NULL && len > 0)
+			return FALSE;
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
+					"UCS-2BE", "UTF-8//TRANSLIT",
+					NULL, &gwritten, NULL);
+		if (ucs2 =3D=3D NULL)
+			return FALSE;
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
+	memcpy(iter->value + iter->len, data, length);
+	iter->len +=3D length;
+
+	return TRUE;
+}
-- =

1.6.1


--===============3886614598596807037==--

