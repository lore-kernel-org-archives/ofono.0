Content-Type: multipart/mixed; boundary="===============1463235076527594142=="
MIME-Version: 1.0
From: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Subject: [PATCH] atmodem/phonebook: parse text as hexstring
Date: Sun, 08 Aug 2010 19:27:40 -0300
Message-ID: <1281306460-5580-1-git-send-email-cascardo@holoscopio.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1463235076527594142==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Some modems omit the quotes when dumping strings in UCS2. Parsing
them as hexstring already does the hex decoding and accepts missing
quotes.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
---
 drivers/atmodem/phonebook.c |  139 ++++++++++++++++++++-------------------=
---
 1 files changed, 66 insertions(+), 73 deletions(-)

diff --git a/drivers/atmodem/phonebook.c b/drivers/atmodem/phonebook.c
index 5e7a52b..59fcbbc 100644
--- a/drivers/atmodem/phonebook.c
+++ b/drivers/atmodem/phonebook.c
@@ -59,16 +59,50 @@ struct pb_data {
 	GAtChat *chat;
 };
 =

-static char *ucs2_to_utf8(const char *str)
+static void warn_bad_text(const char *text)
 {
-	long len;
-	unsigned char *ucs2;
+	ofono_warn("Name field conversion to UTF8"
+		" failed, this can indicate a"
+		" problem with modem"
+		" integration, as this field"
+		" is required by 27.007."
+		"  Contents of name reported"
+		" by modem: %s", text);
+}
+
+static gboolean parse_text(GAtResultIter *iter, char **str, int encoding)
+{
+	const char *string;
+	const guint8 *hex;
+	int len;
 	char *utf8;
-	ucs2 =3D decode_hex(str, -1, &len, 0);
-	utf8 =3D g_convert((char *)ucs2, len, "UTF-8//TRANSLIT", "UCS-2BE",
-					NULL, NULL, NULL);
-	g_free(ucs2);
-	return utf8;
+	/* charset_current is either CHARSET_UCS2 or CHARSET_UTF8 */
+	if (encoding =3D=3D CHARSET_UCS2) {
+		/* Some devices ommit the quotes, so use hexstring,
+		 * which also decode to hex */
+		if (g_at_result_iter_next_hexstring(iter, &hex, &len))
+			utf8 =3D g_convert((const gchar *)hex, len,
+						"UTF-8//TRANSLIT", "UCS-2BE",
+						NULL, NULL, NULL);
+		else
+			return FALSE;
+		if (utf8) {
+			*str =3D utf8;
+			return TRUE;
+		} else {
+			warn_bad_text(string);
+			return FALSE;
+		}
+	} else {
+		/* In the case of IRA charset, assume these are Latin1
+		 * characters, same as in UTF8
+		 */
+		if (g_at_result_iter_next_string(iter, &string)) {
+				*str =3D g_strdup(string);
+				return TRUE;
+		}
+	}
+	return FALSE;
 }
 =

 static const char *best_charset(int supported)
@@ -110,15 +144,15 @@ static void at_cpbr_notify(GAtResult *result, gpointe=
r user_data)
 		int index;
 		const char *number;
 		int type;
-		const char *text;
+		char *text;
 		int hidden =3D -1;
-		const char *group =3D NULL;
+		char *group =3D NULL;
 		const char *adnumber =3D NULL;
 		int adtype =3D -1;
-		const char *secondtext =3D NULL;
-		const char *email =3D NULL;
-		const char *sip_uri =3D NULL;
-		const char *tel_uri =3D NULL;
+		char *secondtext =3D NULL;
+		char *email =3D NULL;
+		char *sip_uri =3D NULL;
+		char *tel_uri =3D NULL;
 =

 		if (!g_at_result_iter_next_number(&iter, &index))
 			continue;
@@ -129,70 +163,29 @@ static void at_cpbr_notify(GAtResult *result, gpointe=
r user_data)
 		if (!g_at_result_iter_next_number(&iter, &type))
 			continue;
 =

-		if (!g_at_result_iter_next_string(&iter, &text))
+		if (!parse_text(&iter, &text, current))
 			continue;
 =

 		g_at_result_iter_next_number(&iter, &hidden);
-		g_at_result_iter_next_string(&iter, &group);
+		parse_text(&iter, &group, current);
 		g_at_result_iter_next_string(&iter, &adnumber);
 		g_at_result_iter_next_number(&iter, &adtype);
-		g_at_result_iter_next_string(&iter, &secondtext);
-		g_at_result_iter_next_string(&iter, &email);
-		g_at_result_iter_next_string(&iter, &sip_uri);
-		g_at_result_iter_next_string(&iter, &tel_uri);
-
-		/* charset_current is either CHARSET_UCS2 or CHARSET_UTF8 */
-		if (current =3D=3D CHARSET_UCS2) {
-			char *text_utf8;
-			char *group_utf8 =3D NULL;
-			char *secondtext_utf8 =3D NULL;
-			char *email_utf8 =3D NULL;
-			char *sip_uri_utf8 =3D NULL;
-			char *tel_uri_utf8 =3D NULL;
-
-			text_utf8 =3D ucs2_to_utf8(text);
-
-			if (text_utf8 =3D=3D NULL)
-				ofono_warn("Name field conversion to UTF8"
-						" failed, this can indicate a"
-						" problem with modem"
-						" integration, as this field"
-						" is required by 27.007."
-						"  Contents of name reported"
-						" by modem: %s", text);
-
-			if (group)
-				group_utf8 =3D ucs2_to_utf8(group);
-			if (secondtext)
-				secondtext_utf8 =3D ucs2_to_utf8(secondtext);
-			if (email)
-				email_utf8 =3D ucs2_to_utf8(email);
-			if (sip_uri)
-				sip_uri_utf8 =3D ucs2_to_utf8(sip_uri);
-			if (tel_uri)
-				tel_uri_utf8 =3D ucs2_to_utf8(tel_uri);
-
-			ofono_phonebook_entry(pb, index, number, type,
-				text_utf8, hidden, group_utf8, adnumber,
-				adtype, secondtext_utf8, email_utf8,
-				sip_uri_utf8, tel_uri_utf8);
-
-			g_free(text_utf8);
-			g_free(group_utf8);
-			g_free(secondtext_utf8);
-			g_free(email_utf8);
-			g_free(sip_uri_utf8);
-			g_free(tel_uri_utf8);
-		} else {
-			/* In the case of IRA charset, assume these are Latin1
-			 * characters, same as in UTF8
-			 */
-			ofono_phonebook_entry(pb, index, number, type,
-				text, hidden, group, adnumber,
-				adtype, secondtext, email,
-				sip_uri, tel_uri);
-
-		}
+		parse_text(&iter, &secondtext, current);
+		parse_text(&iter, &email, current);
+		parse_text(&iter, &sip_uri, current);
+		parse_text(&iter, &tel_uri, current);
+
+		ofono_phonebook_entry(pb, index, number, type,
+			text, hidden, group, adnumber,
+			adtype, secondtext, email,
+			sip_uri, tel_uri);
+
+		g_free(text);
+		g_free(group);
+		g_free(secondtext);
+		g_free(email);
+		g_free(sip_uri);
+		g_free(tel_uri);
 	}
 }
 =

-- =

1.7.1


--===============1463235076527594142==--

