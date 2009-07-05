Content-Type: multipart/mixed; boundary="===============3027944162354469173=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] Add USC-2 to UTF-8 conversion utility function.
Date: Sun, 05 Jul 2009 05:13:45 +0200
Message-ID: <1246763625-17183-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3027944162354469173==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/util.c |   59 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++
 src/util.h |    4 ++++
 2 files changed, 63 insertions(+), 0 deletions(-)

diff --git a/src/util.c b/src/util.c
index 84ce507..7a96afe 100644
--- a/src/util.c
+++ b/src/util.c
@@ -26,6 +26,7 @@
 #include <stdio.h>
 #include <string.h>
 #include <ctype.h>
+#include <endian.h>
 =

 #include <glib.h>
 =

@@ -692,3 +693,61 @@ unsigned char *pack_7bit(const unsigned char *in, long=
 len, int byte_offset,
 	return pack_7bit_own_buf(in, len, byte_offset, ussd, items_written,
 					terminator, buf);
 }
+
+/*!
+ * Converts text coded using ISO/IEC 10646 UCS-2 encoding into UTF8 encoded
+ * text.  Input buffer length is given in bytes, not words.
+ *
+ * Returns newly-allocated UTF8 encoded string or NULL if the conversion
+ * could not be performed.  Returns the number of bytes read from the
+ * UCS-2 encoded string in items_read (if not NULL), not including the
+ * terminator character.  Returns the number of bytes written into the UTF8
+ * encoded string in items_written (if not NULL) not including the terminal
+ * '\0' character.  The caller is reponsible for freeing the returned valu=
e.
+ */
+char *convert_ucs2_to_utf8(const unsigned char *buffer, long len,
+				long *items_read, long *items_written,
+				unsigned short terminator)
+{
+	int i;
+	unsigned short ucs2;
+#if __BYTE_ORDER =3D=3D __LITTLE_ENDIAN
+	unsigned char *swap_buf;
+#endif
+	unsigned char *ret;
+	GError *error;
+
+	/* All UCS-2 text is valid UTF-16 text but UTF-16 sequences of
+	 * surrogate pairs are not valid in UCS-2 so first check that
+	 * there are no surrogate pairs in the buffer and then use
+	 * g_utf16_to_utf8() on it.  */
+	for (i =3D 0; i < len - 1; i +=3D 2) {
+		ucs2 =3D (buffer[i] << 8) + buffer[i + 1];
+
+		if (ucs2 =3D=3D terminator)
+			break;
+
+		if ((ucs2 & 0xf800) =3D=3D 0xd800)
+			return NULL;
+	}
+
+#if __BYTE_ORDER =3D=3D __LITTLE_ENDIAN
+	swap_buf =3D g_malloc(i);
+	if (!swap_buf)
+		return NULL;
+
+	swab(buffer, swap_buf, i);
+	buffer =3D swap_buf;
+#endif
+
+	ret =3D g_utf16_to_utf8((const gunichar2 *) buffer, i / 2,
+			NULL, items_written, &error);
+	if (ret && items_read)
+		*items_read =3D i;
+
+#if __BYTE_ORDER =3D=3D __LITTLE_ENDIAN
+	g_free(swap_buf);
+#endif
+
+	return ret;
+}
diff --git a/src/util.h b/src/util.h
index 6269630..8589f0c 100644
--- a/src/util.h
+++ b/src/util.h
@@ -56,3 +56,7 @@ unsigned char *pack_7bit_own_buf(const unsigned char *in,=
 long len,
 unsigned char *pack_7bit(const unsigned char *in, long len, int byte_offse=
t,
 				gboolean ussd,
 				long *items_written, unsigned char terminator);
+
+char *convert_ucs2_to_utf8(const unsigned char *buffer, long len,
+				long *items_read, long *items_written,
+				unsigned short terminator);
-- =

1.6.0


--===============3027944162354469173==--

