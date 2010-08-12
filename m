Content-Type: multipart/mixed; boundary="===============7102859296369208247=="
MIME-Version: 1.0
From: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Subject: Re: [PATCH] atmodem/phonebook: parse text as hexstring
Date: Thu, 12 Aug 2010 14:55:52 -0300
Message-ID: <20100812175552.GB25956@barata.holoscopio.com>
In-Reply-To: <CE761E84DADF2947A4AF22FB8D97A47328E7DC31@shsmsx501.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7102859296369208247==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 11, 2010 at 03:53:36PM +0800, Gu, Yang wrote:
> Hi, =

> =


Hello, Yang.

Thanks for the comments. I've done this patch in a rush (have done a
worse one before to test and import some data from a cell phone). Your
feedback is important so we can improve it and I can have some doubts
answered.

> =

> >-----Original Message-----
> >From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On Be=
half Of
> >Thadeu Lima de Souza Cascardo
> >Sent: Monday, August 09, 2010 6:28 AM
> >To: ofono(a)ofono.org
> >Subject: [PATCH] atmodem/phonebook: parse text as hexstring
> >
> >Some modems omit the quotes when dumping strings in UCS2. Parsing
> >them as hexstring already does the hex decoding and accepts missing
> >quotes.
> >
> >Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
> >---
> > drivers/atmodem/phonebook.c |  139 ++++++++++++++++++++----------------=
------
> > 1 files changed, 66 insertions(+), 73 deletions(-)
> >
> >diff --git a/drivers/atmodem/phonebook.c b/drivers/atmodem/phonebook.c
> >index 5e7a52b..59fcbbc 100644
> >--- a/drivers/atmodem/phonebook.c
> >+++ b/drivers/atmodem/phonebook.c
> >@@ -59,16 +59,50 @@ struct pb_data {
> > 	GAtChat *chat;
> > };
> >
> >-static char *ucs2_to_utf8(const char *str)
> >+static void warn_bad_text(const char *text)
> > {
> >-	long len;
> >-	unsigned char *ucs2;
> >+	ofono_warn("Name field conversion to UTF8"
> >+		" failed, this can indicate a"
> >+		" problem with modem"
> >+		" integration, as this field"
> >+		" is required by 27.007."
> >+		"  Contents of name reported"
> >+		" by modem: %s", text);
> >+}
> =

> Why this warning is extracted as a function here?
> =


In one of my versions of the patch, it was too much inlined and the
function was already too long. Since it's static, it will probably be
inlined. Should I just put it back in place of its only caller?

> >+
> >+static gboolean parse_text(GAtResultIter *iter, char **str, int encodin=
g)
> >+{
> >+	const char *string;
> >+	const guint8 *hex;
> >+	int len;
> > 	char *utf8;
> >-	ucs2 =3D decode_hex(str, -1, &len, 0);
> >-	utf8 =3D g_convert((char *)ucs2, len, "UTF-8//TRANSLIT", "UCS-2BE",
> >-					NULL, NULL, NULL);
> >-	g_free(ucs2);
> >-	return utf8;
> >+	/* charset_current is either CHARSET_UCS2 or CHARSET_UTF8 */
> =

> Please help to add CHARSET_IRA here. I know the original code is not corr=
ect.
> =


OK. Any pointers to any documentation about it? UCS2 support worked very
well for me. Some names had characters in the Latin1 range and it was no
problem.

> >+	if (encoding =3D=3D CHARSET_UCS2) {
> >+		/* Some devices ommit the quotes, so use hexstring,
> >+		 * which also decode to hex */
> =

> Misspell the "omit" here. We have guideline to write multiple line commen=
ts, please refer doc/coding_style.txt and section M2.
> =


Thanks. I will take a look and fix those.

> >+		if (g_at_result_iter_next_hexstring(iter, &hex, &len))
> >+			utf8 =3D g_convert((const gchar *)hex, len,
> >+						"UTF-8//TRANSLIT", "UCS-2BE",
> >+						NULL, NULL, NULL);
> >+		else
> >+			return FALSE;
> =

> Please insert a blank line here.
> =

> >+		if (utf8) {
> >+			*str =3D utf8;
> >+			return TRUE;
> >+		} else {
> >+			warn_bad_text(string);
> =

> We only report the warning when the field "name" (i.e., text) couldn't be=
 converted correctly, for it's a mandatory field. Otherwise, we don't issue=
 the warning.
> =


I will add a gboolean mandatory parameter to the function. I've thought
about that, but now I have a pretty good line (mandatory), that's pretty
clear.

> >+			return FALSE;
> >+		}
> >+	} else {
> >+		/* In the case of IRA charset, assume these are Latin1
> >+		 * characters, same as in UTF8
> >+		 */
> =

> Same problem here for the multiple line comment
> =

> >+		if (g_at_result_iter_next_string(iter, &string)) {
> =

> Could the device omit the quote here? If so, this function couldn't handl=
e it correctly either.
> =


Not the device I have. This does not add a regression. If we find any
device that will omit the quote in this case, we may add the fix later.
For now, I am more confortable requiring the quote here and fixing it
for the cases we know some devices will omit it.

In any case, the UCS2 case was already expecting an hexstring, since it
was doing the conversion later. And the hexstring code allowed the
quotes to be omited. This is not the case here, where a string is
expected. I don't know about the IRA case.

> >+				*str =3D g_strdup(string);
> >+				return TRUE;
> >+		}
> >+	}
> >+	return FALSE;
> > }
> >
> > static const char *best_charset(int supported)
> >@@ -110,15 +144,15 @@ static void at_cpbr_notify(GAtResult *result, gpoi=
nter
> >user_data)
> > 		int index;
> > 		const char *number;
> > 		int type;
> >-		const char *text;
> >+		char *text;
> > 		int hidden =3D -1;
> >-		const char *group =3D NULL;
> >+		char *group =3D NULL;
> > 		const char *adnumber =3D NULL;
> > 		int adtype =3D -1;
> >-		const char *secondtext =3D NULL;
> >-		const char *email =3D NULL;
> >-		const char *sip_uri =3D NULL;
> >-		const char *tel_uri =3D NULL;
> >+		char *secondtext =3D NULL;
> >+		char *email =3D NULL;
> >+		char *sip_uri =3D NULL;
> >+		char *tel_uri =3D NULL;
> >
> > 		if (!g_at_result_iter_next_number(&iter, &index))
> > 			continue;
> >@@ -129,70 +163,29 @@ static void at_cpbr_notify(GAtResult *result, gpoi=
nter
> >user_data)
> > 		if (!g_at_result_iter_next_number(&iter, &type))
> > 			continue;
> >
> >-		if (!g_at_result_iter_next_string(&iter, &text))
> >+		if (!parse_text(&iter, &text, current))
> > 			continue;
> >
> > 		g_at_result_iter_next_number(&iter, &hidden);
> >-		g_at_result_iter_next_string(&iter, &group);
> >+		parse_text(&iter, &group, current);
> > 		g_at_result_iter_next_string(&iter, &adnumber);
> > 		g_at_result_iter_next_number(&iter, &adtype);
> >-		g_at_result_iter_next_string(&iter, &secondtext);
> >-		g_at_result_iter_next_string(&iter, &email);
> >-		g_at_result_iter_next_string(&iter, &sip_uri);
> >-		g_at_result_iter_next_string(&iter, &tel_uri);
> >-
> >-		/* charset_current is either CHARSET_UCS2 or CHARSET_UTF8 */
> >-		if (current =3D=3D CHARSET_UCS2) {
> >-			char *text_utf8;
> >-			char *group_utf8 =3D NULL;
> >-			char *secondtext_utf8 =3D NULL;
> >-			char *email_utf8 =3D NULL;
> >-			char *sip_uri_utf8 =3D NULL;
> >-			char *tel_uri_utf8 =3D NULL;
> >-
> >-			text_utf8 =3D ucs2_to_utf8(text);
> >-
> >-			if (text_utf8 =3D=3D NULL)
> >-				ofono_warn("Name field conversion to UTF8"
> >-						" failed, this can indicate a"
> >-						" problem with modem"
> >-						" integration, as this field"
> >-						" is required by 27.007."
> >-						"  Contents of name reported"
> >-						" by modem: %s", text);
> >-
> >-			if (group)
> >-				group_utf8 =3D ucs2_to_utf8(group);
> >-			if (secondtext)
> >-				secondtext_utf8 =3D ucs2_to_utf8(secondtext);
> >-			if (email)
> >-				email_utf8 =3D ucs2_to_utf8(email);
> >-			if (sip_uri)
> >-				sip_uri_utf8 =3D ucs2_to_utf8(sip_uri);
> >-			if (tel_uri)
> >-				tel_uri_utf8 =3D ucs2_to_utf8(tel_uri);
> >-
> >-			ofono_phonebook_entry(pb, index, number, type,
> >-				text_utf8, hidden, group_utf8, adnumber,
> >-				adtype, secondtext_utf8, email_utf8,
> >-				sip_uri_utf8, tel_uri_utf8);
> >-
> >-			g_free(text_utf8);
> >-			g_free(group_utf8);
> >-			g_free(secondtext_utf8);
> >-			g_free(email_utf8);
> >-			g_free(sip_uri_utf8);
> >-			g_free(tel_uri_utf8);
> >-		} else {
> >-			/* In the case of IRA charset, assume these are Latin1
> >-			 * characters, same as in UTF8
> >-			 */
> >-			ofono_phonebook_entry(pb, index, number, type,
> >-				text, hidden, group, adnumber,
> >-				adtype, secondtext, email,
> >-				sip_uri, tel_uri);
> >-
> >-		}
> >+		parse_text(&iter, &secondtext, current);
> >+		parse_text(&iter, &email, current);
> >+		parse_text(&iter, &sip_uri, current);
> >+		parse_text(&iter, &tel_uri, current);
> >+
> >+		ofono_phonebook_entry(pb, index, number, type,
> >+			text, hidden, group, adnumber,
> >+			adtype, secondtext, email,
> >+			sip_uri, tel_uri);
> >+
> >+		g_free(text);
> >+		g_free(group);
> >+		g_free(secondtext);
> >+		g_free(email);
> >+		g_free(sip_uri);
> >+		g_free(tel_uri);
> > 	}
> > }
> >
> >--
> >1.7.1
> =

> Regards,
> -Yang

Regards,
Cascardo.

--===============7102859296369208247==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEuNC4xMCAoR05V
L0xpbnV4KQoKaVFJY0JBRUJBZ0FHQlFKTVpEV25BQW9KRUVXeFNnN3VkRlpJYVlrUC8xeXVUNUdI
YzFBYUhWV0tic0dNNGNpOAo5NjliY201MzRsYThleG80WEc4QXh0NGpXSUJKZGF5UUUzZFZnZ002
R2VOS2VtUklhSTh1K3N5dXZLdDRoNkJNCk11TzgxTXAwdVN6ektURTAvN2w0QkR5eEFQeDNQeDlo
VytoUTFVUjNzbUNKVTRsZzRnQ3VLZWFvcjdNSk85WUcKVjhhdVQ2SDN1OWtJQTV4NFFQcWs4dlpX
djVhR29PVVFweE94eXJMZDJ0T003NzNoSDh2MFRjbjN5OGNLZkxUSwpZWlpRWUxkbWtwMlhwODFC
ajc4SGNNVWJnWmE3NEZKTWFlSlFUWTZmRnpNM3NGRkJNZkZUVTRMcUJTYkg0RGVWCmtIcmE1UUJo
dllvZ3N5YjAxWkkzZUNUOGlJNHVXMEZKRG53MW9ncm5rMmx1WFBkT0l4T21PSHREM0hPQm5VL2EK
VDFsSVNzMGVKR0lYZ2dhTERrRU44Nk1hMFZKcCtUa1d1UFc2RHozLzh2c3NBSjgzV1M2Sml6Q3Fq
Y09aaXQ3dQpMSXU0Z0pGbUJweGZhbVY4cWVZVEVFTFpjbW1JZFY5dTJwZTZVbC9NRExvYnBONTYz
ODZoQ2U3N2hHVXhsN2tyCnhaQmg5emh6a08rVXpsNEZUWm9iV1RoV0JLQW1QVkZXeXZzaERBRStG
bUlLejN1eWo4b3djbU8yb2RTUFhVa3kKVnNUVXBmb3BsWlBJRjBWM1dRaEdUL1JRSkRxQ29SQVRT
RHl5MXNtWXIwU3BUU054cURacG1iZ0t0WnI1aDliUwpwZDZXU21IaWNid3hjZHFMV25BY0FWL2Zx
TVoxS3pCYlNmVmhXSTFSOXFoVW1xK1NldjJLZmdGbWpCaG56a2ZzCjVwYzR1RzU4dDlGdDBoU0I1
cXVICj03Q0I4Ci0tLS0tRU5EIFBHUCBTSUdOQVRVUkUtLS0tLQo=

--===============7102859296369208247==--

