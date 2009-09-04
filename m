Content-Type: multipart/mixed; boundary="===============2356313992083873585=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Add support for SMS national language identifiers
Date: Fri, 04 Sep 2009 11:21:20 -0500
Message-ID: <200909041121.21109.denkenz@gmail.com>
In-Reply-To: <a32762a20909040827k7a3b439dlb4fa9d4083f26150@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2356313992083873585==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

> Hi All,
>
> Here is a set of patches to add support for decoding SMSs that have
> been encoded using national language tables instead of the default GSM
> 7bit tables. I was planning to push a couple of these patches
> directly, but the changes turned out a bit more extensive than I
> originally thought. Please take a look and comment.

Just a couple of minor nitpicks:
+struct single_shift_table {
+	struct codepoint *table;
+	unsigned int len;
+};
+
+static struct single_shift_table gsm_single_shift[] =3D
+{
+	{ default_ext_gsm, TABLE_SIZE(default_ext_gsm) },
+	{ turkish_ext_gsm, TABLE_SIZE(turkish_ext_gsm) },
+	{ spanish_ext_gsm, TABLE_SIZE(spanish_ext_gsm) },
+	{ portuguese_ext_gsm, TABLE_SIZE(portuguese_ext_gsm) }
+};
+
+static struct single_shift_table unicode_single_shift[] =3D
+{
+	{ default_ext_unicode, TABLE_SIZE(default_ext_unicode) },
+	{ turkish_ext_unicode, TABLE_SIZE(turkish_ext_unicode) },
+	{ spanish_ext_unicode, TABLE_SIZE(spanish_ext_unicode) },
+	{ portuguese_ext_unicode, TABLE_SIZE(portuguese_ext_unicode) }
+};
+
+static const unsigned short *gsm_locking_shift[] =3D
+{
+	default_gsm,
+	turkish_gsm,
+	default_gsm,
+	portuguese_gsm
+};
+
+static struct codepoint *unicode_locking_shift[] =3D
+{
+	default_unicode,
+	turkish_unicode,
+	default_unicode,
+	portuguese_unicode

Can we put all of these into a single table?

+char *convert_gsm_to_utf8_with_lang(const unsigned char *text, long len,
+					long *items_read, long *items_written,
+					unsigned char terminator,
+					unsigned int locking_lang,
+					unsigned int single_lang)

locking_lang & single_lang should be unsigned char or an enum.

+gboolean sms_extract_language_variant(const struct sms *sms, int *locking,
+					int *single);

locking & single should use guint8.

+enum sms_language {
+	SMS_LANGUAGE_DEFAULT =3D 0,
+	SMS_LANGUAGE_TURKISH =3D 1,
+	SMS_LANGUAGE_SPANISH =3D 2,
+	SMS_LANGUAGE_PORTUGUESE =3D 3
+};
+

This part isn't used anywhere, should we just keep this out for now?

Regards,
-Denis

--===============2356313992083873585==--

