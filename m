Content-Type: multipart/mixed; boundary="===============4215011660769743947=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv9 04/16] mbpi: Fix handling of the usage element
Date: Wed, 05 Oct 2011 16:18:27 +0300
Message-ID: <1317820719-23609-5-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1317820719-23609-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4215011660769743947==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/mbpi.c |   44 +++++++++++++++++++++++---------------------
 1 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/plugins/mbpi.c b/plugins/mbpi.c
index fce70ba..8f3a4b4 100644
--- a/plugins/mbpi.c
+++ b/plugins/mbpi.c
@@ -90,33 +90,36 @@ static const GMarkupParser text_parser =3D {
 	NULL,
 };
 =

-static void usage_handler(GMarkupParseContext *context,
-				const gchar *text, gsize text_len,
-				gpointer userdata, GError **error)
+static void usage_start(const gchar **attribute_names,
+			const gchar **attribute_values,
+			enum ofono_gprs_context_type *type, GError **error)
 {
-	enum ofono_gprs_context_type *type =3D userdata;
+	const char *text =3D NULL;
+	int i;
+
+	for (i =3D 0; attribute_names[i]; i++)
+		if (g_str_equal(attribute_names[i], "type") =3D=3D TRUE)
+			text =3D attribute_values[i];
+
+	if (text =3D=3D NULL) {
+		g_set_error(error, G_MARKUP_ERROR,
+				G_MARKUP_ERROR_MISSING_ATTRIBUTE,
+				"Missing attribute: type");
+		return;
+	}
 =

-	if (strncmp(text, "internet", text_len) =3D=3D 0)
+	if (strcmp(text, "internet") =3D=3D 0)
 		*type =3D OFONO_GPRS_CONTEXT_TYPE_INTERNET;
-	else if (strncmp(text, "mms", text_len) =3D=3D 0)
+	else if (strcmp(text, "mms") =3D=3D 0)
 		*type =3D OFONO_GPRS_CONTEXT_TYPE_MMS;
-	else if (strncmp(text, "wap", text_len) =3D=3D 0)
+	else if (strcmp(text, "wap") =3D=3D 0)
 		*type =3D OFONO_GPRS_CONTEXT_TYPE_WAP;
 	else
 		g_set_error(error, G_MARKUP_ERROR,
 					G_MARKUP_ERROR_UNKNOWN_ATTRIBUTE,
-					"Unknown usage attribute: %.*s",
-					(int) text_len, text);
+					"Unknown usage attribute: %s", text);
 }
 =

-static const GMarkupParser usage_parser =3D {
-	NULL,
-	NULL,
-	usage_handler,
-	NULL,
-	NULL,
-};
-
 static void apn_start(GMarkupParseContext *context, const gchar *element_n=
ame,
 			const gchar **attribute_names,
 			const gchar **attribute_values,
@@ -133,8 +136,8 @@ static void apn_start(GMarkupParseContext *context, con=
st gchar *element_name,
 		g_markup_parse_context_push(context, &text_parser,
 						&apn->password);
 	else if (g_str_equal(element_name, "usage"))
-		g_markup_parse_context_push(context, &usage_parser,
-						&apn->type);
+		usage_start(attribute_names, attribute_values,
+				&apn->type, error);
 }
 =

 static void apn_end(GMarkupParseContext *context, const gchar *element_nam=
e,
@@ -142,8 +145,7 @@ static void apn_end(GMarkupParseContext *context, const=
 gchar *element_name,
 {
 	if (g_str_equal(element_name, "name") ||
 			g_str_equal(element_name, "username") ||
-			g_str_equal(element_name, "password") ||
-			g_str_equal(element_name, "usage"))
+			g_str_equal(element_name, "password"))
 		g_markup_parse_context_pop(context);
 }
 =

-- =

1.7.4.1


--===============4215011660769743947==--

