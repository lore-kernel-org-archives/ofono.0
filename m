Content-Type: multipart/mixed; boundary="===============1228552484491318648=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: [PATCH 4/6] smsutil: Add alphabet support to encoding
Date: Thu, 03 Feb 2011 15:20:34 +0200
Message-ID: <1296739236-24391-5-git-send-email-aki.niemi@nokia.com>
In-Reply-To: <1296739236-24391-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1228552484491318648==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/smsutil.c |   53 ++++++++++++++++++++++++++++++++++++++++++++++-------
 src/smsutil.h |   12 ++++++++++++
 2 files changed, 58 insertions(+), 7 deletions(-)

diff --git a/src/smsutil.c b/src/smsutil.c
index 5c1ae4c..3fd3397 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -3514,9 +3514,10 @@ GSList *sms_datagram_prepare(const char *to,
  * @use_delivery_reports: value for the Status-Report-Request field
  *     (23.040 3.2.9, 9.2.2.2)
  */
-GSList *sms_text_prepare(const char *to, const char *utf8, guint16 ref,
-				gboolean use_16bit,
-				gboolean use_delivery_reports)
+GSList *sms_text_prepare_with_alphabet(const char *to, const char *utf8,
+					guint16 ref, gboolean use_16bit,
+					gboolean use_delivery_reports,
+					enum sms_alphabet alphabet)
 {
 	struct sms template;
 	int offset =3D 0;
@@ -3526,6 +3527,8 @@ GSList *sms_text_prepare(const char *to, const char *=
utf8, guint16 ref,
 	long left;
 	guint8 seq;
 	GSList *r =3D NULL;
+	enum gsm_dialect used_locking;
+	enum gsm_dialect used_single;
 =

 	memset(&template, 0, sizeof(struct sms));
 	template.type =3D SMS_TYPE_SUBMIT;
@@ -3537,8 +3540,13 @@ GSList *sms_text_prepare(const char *to, const char =
*utf8, guint16 ref,
 	template.submit.vp.relative =3D 0xA7; /* 24 Hours */
 	sms_address_from_string(&template.submit.daddr, to);
 =

-	/* UDHI, UDL, UD and DCS actually depend on what we have in the text */
-	gsm_encoded =3D convert_utf8_to_gsm(utf8, -1, NULL, &written, 0);
+	/*
+	 * UDHI, UDL, UD and DCS actually depend on the contents of
+	 * the text, and also on the GSM dialect we use to encode it.
+	 */
+	gsm_encoded =3D convert_utf8_to_gsm_best_lang(utf8, -1, NULL, &written, 0,
+							alphabet, &used_locking,
+							&used_single);
 	if (gsm_encoded =3D=3D NULL) {
 		gsize converted;
 =

@@ -3550,13 +3558,35 @@ GSList *sms_text_prepare(const char *to, const char=
 *utf8, guint16 ref,
 	if (gsm_encoded =3D=3D NULL && ucs2_encoded =3D=3D NULL)
 		return NULL;
 =

-	if (gsm_encoded)
+	if (gsm_encoded !=3D NULL)
 		template.submit.dcs =3D 0x00; /* Class Unspecified, 7 Bit */
 	else
 		template.submit.dcs =3D 0x08; /* Class Unspecified, UCS2 */
 =

+	if (gsm_encoded !=3D NULL && used_single !=3D GSM_DIALECT_DEFAULT) {
+		if (!offset)
+			offset =3D 1;
+
+		template.submit.ud[0] +=3D 3;
+		template.submit.ud[offset] =3D SMS_IEI_NATIONAL_LANGUAGE_SINGLE_SHIFT;
+		template.submit.ud[offset + 1] =3D 1;
+		template.submit.ud[offset + 2] =3D used_single;
+		offset +=3D 3;
+	}
+
+	if (gsm_encoded !=3D NULL && used_locking !=3D GSM_DIALECT_DEFAULT) {
+		if (!offset)
+			offset =3D 1;
+
+		template.submit.ud[0] +=3D 3;
+		template.submit.ud[offset] =3D SMS_IEI_NATIONAL_LANGUAGE_LOCKING_SHIFT;
+		template.submit.ud[offset + 1] =3D 1;
+		template.submit.ud[offset + 2] =3D used_locking;
+		offset +=3D 3;
+	}
+
 	if (offset !=3D 0)
-		template.submit.udhi =3D FALSE;
+		template.submit.udhi =3D TRUE;
 =

 	if (gsm_encoded && (written <=3D sms_text_capacity_gsm(160, offset))) {
 		template.submit.udl =3D written + (offset * 8 + 6) / 7;
@@ -3668,6 +3698,15 @@ GSList *sms_text_prepare(const char *to, const char =
*utf8, guint16 ref,
 	return r;
 }
 =

+GSList *sms_text_prepare(const char *to, const char *utf8, guint16 ref,
+				gboolean use_16bit,
+				gboolean use_delivery_reports)
+{
+	return sms_text_prepare_with_alphabet(to, utf8, ref, use_16bit,
+						use_delivery_reports,
+						SMS_ALPHABET_DEFAULT);
+}
+
 gboolean cbs_dcs_decode(guint8 dcs, gboolean *udhi, enum sms_class *cls,
 			enum sms_charset *charset, gboolean *compressed,
 			enum cbs_language *language, gboolean *iso639)
diff --git a/src/smsutil.h b/src/smsutil.h
index 16b5350..fc81eb1 100644
--- a/src/smsutil.h
+++ b/src/smsutil.h
@@ -154,6 +154,13 @@ enum sms_charset {
 	SMS_CHARSET_UCS2 =3D 2,
 };
 =

+enum sms_alphabet {
+	SMS_ALPHABET_DEFAULT =3D 0,
+	SMS_ALPHABET_TURKISH,
+	SMS_ALPHABET_SPANISH,
+	SMS_ALPHABET_PORTUGUESE,
+};
+
 enum sms_mwi_type {
 	SMS_MWI_TYPE_VOICE =3D 0,
 	SMS_MWI_TYPE_FAX =3D 1,
@@ -538,6 +545,11 @@ GSList *sms_text_prepare(const char *to, const char *u=
tf8, guint16 ref,
 				gboolean use_16bit,
 				gboolean use_delivery_reports);
 =

+GSList *sms_text_prepare_with_alphabet(const char *to, const char *utf8,
+				guint16 ref, gboolean use_16bit,
+				gboolean use_delivery_reports,
+				enum sms_alphabet alphabet);
+
 GSList *sms_datagram_prepare(const char *to,
 				const unsigned char *data, unsigned int len,
 				guint16 ref, gboolean use_16bit_ref,
-- =

1.7.1


--===============1228552484491318648==--

