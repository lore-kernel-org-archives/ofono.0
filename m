Content-Type: multipart/mixed; boundary="===============7477946693432145796=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: [PATCH 3/6] util: Add best dialect picker API
Date: Thu, 03 Feb 2011 15:20:33 +0200
Message-ID: <1296739236-24391-4-git-send-email-aki.niemi@nokia.com>
In-Reply-To: <1296739236-24391-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7477946693432145796==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/util.c |   64 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/util.h |    7 ++++++
 2 files changed, 71 insertions(+), 0 deletions(-)

diff --git a/src/util.c b/src/util.c
index 547f38c..e1e8a0a 100644
--- a/src/util.c
+++ b/src/util.c
@@ -788,6 +788,70 @@ unsigned char *convert_utf8_to_gsm(const char *text, l=
ong len,
 }
 =

 /*!
+ * Converts UTF-8 encoded text to GSM alphabet. It finds an encoding
+ * that uses the minimum set of GSM dialects based on the hint given.
+ *
+ * It first attempts to use the default dialect's single shift and
+ * locking shift tables. It then tries with only the single shift
+ * table of the hinted dialect, and finally with both the single shift
+ * and locking shift tables of the hinted dialect.
+ *
+ * Returns the encoded data or NULL if no suitable encoding could be
+ * found. The data must be freed by the caller. If items_read is not
+ * NULL, it contains the actual number of bytes read. If items_written
+ * is not NULL, it contains the number of bytes written. If
+ * used_locking and used_single are not NULL, they will contain the
+ * dialects used for the locking shift and single shift tables.
+ */
+unsigned char *convert_utf8_to_gsm_best_lang(const char *utf8, long len,
+					long *items_read, long *items_written,
+					unsigned char terminator,
+					enum gsm_dialect hint,
+					enum gsm_dialect *used_locking,
+					enum gsm_dialect *used_single)
+{
+	enum gsm_dialect locking =3D GSM_DIALECT_DEFAULT;
+	enum gsm_dialect single =3D GSM_DIALECT_DEFAULT;
+	unsigned char *encoded;
+
+	encoded =3D convert_utf8_to_gsm_with_lang(utf8, len, items_read,
+						items_written, terminator,
+						locking, single);
+	if (encoded !=3D NULL)
+		return encoded;
+
+	if (hint =3D=3D GSM_DIALECT_DEFAULT)
+		return NULL;
+
+	single =3D hint;
+	encoded =3D convert_utf8_to_gsm_with_lang(utf8, len, items_read,
+						items_written, terminator,
+						locking, single);
+	if (encoded !=3D NULL)
+		return encoded;
+
+	/* Spanish dialect uses the default locking shift table */
+	if (hint =3D=3D GSM_DIALECT_SPANISH)
+		return NULL;
+
+	locking =3D hint;
+	encoded =3D convert_utf8_to_gsm_with_lang(utf8, len, items_read,
+						items_written, terminator,
+						locking, single);
+
+	if (encoded =3D=3D NULL)
+		return NULL;
+
+	if (used_locking !=3D NULL)
+		*used_locking =3D locking;
+
+	if (used_single !=3D NULL)
+		*used_single =3D single;
+
+	return encoded;
+}
+
+/*!
  * Decodes the hex encoded data and converts to a byte array.  If terminat=
or
  * is not 0, the terminator character is appended to the end of the result.
  * This might be useful for converting GSM encoded data if the CSCS is set
diff --git a/src/util.h b/src/util.h
index 8e4b7f3..a1d11b4 100644
--- a/src/util.h
+++ b/src/util.h
@@ -44,6 +44,13 @@ unsigned char *convert_utf8_to_gsm_with_lang(const char =
*text, long len,
 					enum gsm_dialect locking_shift_lang,
 					enum gsm_dialect single_shift_lang);
 =

+unsigned char *convert_utf8_to_gsm_best_lang(const char *utf8, long len,
+					long *items_read, long *items_written,
+					unsigned char terminator,
+					enum gsm_dialect hint,
+					enum gsm_dialect *used_locking,
+					enum gsm_dialect *used_single);
+
 unsigned char *decode_hex_own_buf(const char *in, long len, long *items_wr=
itten,
 					unsigned char terminator,
 					unsigned char *buf);
-- =

1.7.1


--===============7477946693432145796==--

