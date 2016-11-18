Content-Type: multipart/mixed; boundary="===============1581771446142389327=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: [PATCH] smsutil: Fix receiving UTF-16 encoded messages with split
 4-byte char
Date: Fri, 18 Nov 2016 14:17:19 +0200
Message-ID: <1479471439-18482-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1581771446142389327==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The spec supports UCS2, but in reality UTF-16 is used, which supports
4-byte characters, which could be split into different message
fragments. Accumulate the entire UTF-16 message before converting to
UTF8.

Author: Martin Jones <martin.jones@jolla.com>
---
 src/smsutil.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/src/smsutil.c b/src/smsutil.c
index b6f7348..cfede03 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -2218,6 +2218,7 @@ char *sms_decode_text(GSList *sms_list)
 	const struct sms *sms;
 	int guess_size =3D g_slist_length(sms_list);
 	char *utf8;
+	GByteArray *utf16 =3D 0;
 =

 	if (guess_size =3D=3D 1)
 		guess_size =3D 160;
@@ -2289,8 +2290,12 @@ char *sms_decode_text(GSList *sms_list)
 								NULL, NULL, 0,
 								locking_shift,
 								single_shift);
+			if (converted) {
+				g_string_append(str, converted);
+				g_free(converted);
+			}
 		} else {
-			const gchar *from =3D (const gchar *) (ud + taken);
+			const guint8 *from =3D ud + taken;
 			/*
 			 * According to the spec: A UCS2 character shall not be
 			 * split in the middle; if the length of the User Data
@@ -2300,15 +2305,32 @@ char *sms_decode_text(GSList *sms_list)
 			gssize num_ucs2_chars =3D (udl_in_bytes - taken) >> 1;
 			num_ucs2_chars =3D num_ucs2_chars << 1;
 =

-			converted =3D g_convert(from, num_ucs2_chars,
-						"UTF-8//TRANSLIT", "UCS-2BE",
-						NULL, NULL, NULL);
+			/*
+			 * In theory SMS supports encoding using UCS2 which
+			 * is 16-bit, however in the real world messages
+			 * are encoded in UTF-16 which can be 4 bytes and
+			 * a multiple fragment message can split a 4-byte
+			 * character in the middle. So accumulate the
+			 * entire message before converting to UTF-8.
+			 */
+			if (!utf16)
+				utf16 =3D g_byte_array_new();
+
+			g_byte_array_append(utf16, from, num_ucs2_chars);
 		}
 =

+	}
+
+	if (utf16) {
+		char *converted =3D g_convert_with_fallback((const gchar *)
+						utf16->data, utf16->len,
+						"UTF-8//TRANSLIT", "UTF-16BE",
+						NULL, NULL, NULL, NULL);
 		if (converted) {
 			g_string_append(str, converted);
 			g_free(converted);
 		}
+		g_byte_array_free(utf16, TRUE);
 	}
 =

 	utf8 =3D g_string_free(str, FALSE);
-- =

1.9.1


--===============1581771446142389327==--

