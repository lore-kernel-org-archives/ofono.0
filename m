Content-Type: multipart/mixed; boundary="===============3733889915040068821=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv9 09/16] mbpi: Add filename and line information on error
Date: Wed, 05 Oct 2011 16:18:32 +0300
Message-ID: <1317820719-23609-10-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1317820719-23609-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3733889915040068821==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/mbpi.c |   61 ++++++++++++++++++++++++++++++++++++----------------=
---
 1 files changed, 40 insertions(+), 21 deletions(-)

diff --git a/plugins/mbpi.c b/plugins/mbpi.c
index 0f7cd50..e4496c9 100644
--- a/plugins/mbpi.c
+++ b/plugins/mbpi.c
@@ -73,6 +73,23 @@ void mbpi_provision_data_free(struct ofono_gprs_provisio=
n_data *data)
 	g_free(data);
 }
 =

+static void mbpi_g_set_error(GMarkupParseContext *context, GError **error,
+				GQuark domain, gint code, const gchar *fmt, ...)
+{
+	va_list ap;
+	gint line_number, char_number;
+
+	g_markup_parse_context_get_position(context, &line_number,
+						&char_number);
+	va_start(ap, fmt);
+
+	*error =3D g_error_new_valist(domain, code, fmt, ap);
+
+	va_end(ap);
+
+	g_prefix_error(error, "%s:%d ", MBPI_DATABASE, line_number);
+}
+
 static void text_handler(GMarkupParseContext *context,
 				const gchar *text, gsize text_len,
 				gpointer userdata, GError **error)
@@ -90,7 +107,8 @@ static const GMarkupParser text_parser =3D {
 	NULL,
 };
 =

-static void usage_start(const gchar **attribute_names,
+static void usage_start(GMarkupParseContext *context,
+			const gchar **attribute_names,
 			const gchar **attribute_values,
 			enum ofono_gprs_context_type *type, GError **error)
 {
@@ -102,9 +120,9 @@ static void usage_start(const gchar **attribute_names,
 			text =3D attribute_values[i];
 =

 	if (text =3D=3D NULL) {
-		g_set_error(error, G_MARKUP_ERROR,
-				G_MARKUP_ERROR_MISSING_ATTRIBUTE,
-				"Missing attribute: type");
+		mbpi_g_set_error(context, error, G_MARKUP_ERROR,
+					G_MARKUP_ERROR_MISSING_ATTRIBUTE,
+					"Missing attribute: type");
 		return;
 	}
 =

@@ -115,7 +133,7 @@ static void usage_start(const gchar **attribute_names,
 	else if (strcmp(text, "wap") =3D=3D 0)
 		*type =3D OFONO_GPRS_CONTEXT_TYPE_WAP;
 	else
-		g_set_error(error, G_MARKUP_ERROR,
+		mbpi_g_set_error(context, error, G_MARKUP_ERROR,
 					G_MARKUP_ERROR_UNKNOWN_ATTRIBUTE,
 					"Unknown usage attribute: %s", text);
 }
@@ -136,7 +154,7 @@ static void apn_start(GMarkupParseContext *context, con=
st gchar *element_name,
 		g_markup_parse_context_push(context, &text_parser,
 						&apn->password);
 	else if (g_str_equal(element_name, "usage"))
-		usage_start(attribute_names, attribute_values,
+		usage_start(context, attribute_names, attribute_values,
 				&apn->type, error);
 }
 =

@@ -176,7 +194,8 @@ static const GMarkupParser skip_parser =3D {
 	NULL,
 };
 =

-static void network_id_handler(struct gsm_data *gsm,
+static void network_id_handler(GMarkupParseContext *context,
+				struct gsm_data *gsm,
 				const gchar **attribute_names,
 				const gchar **attribute_values,
 				GError **error)
@@ -192,16 +211,16 @@ static void network_id_handler(struct gsm_data *gsm,
 	}
 =

 	if (mcc =3D=3D NULL) {
-		g_set_error(error, G_MARKUP_ERROR,
-				G_MARKUP_ERROR_MISSING_ATTRIBUTE,
-				"Missing attribute: mcc");
+		mbpi_g_set_error(context, error, G_MARKUP_ERROR,
+					G_MARKUP_ERROR_MISSING_ATTRIBUTE,
+					"Missing attribute: mcc");
 		return;
 	}
 =

 	if (mnc =3D=3D NULL) {
-		g_set_error(error, G_MARKUP_ERROR,
-				G_MARKUP_ERROR_MISSING_ATTRIBUTE,
-				"Missing attribute: mnc");
+		mbpi_g_set_error(context, error, G_MARKUP_ERROR,
+					G_MARKUP_ERROR_MISSING_ATTRIBUTE,
+					"Missing attribute: mnc");
 		return;
 	}
 =

@@ -233,9 +252,9 @@ static void apn_handler(GMarkupParseContext *context, s=
truct gsm_data *gsm,
 	}
 =

 	if (apn =3D=3D NULL) {
-		g_set_error(error, G_MARKUP_ERROR,
-				G_MARKUP_ERROR_MISSING_ATTRIBUTE,
-				"APN attribute missing");
+		mbpi_g_set_error(context, error, G_MARKUP_ERROR,
+					G_MARKUP_ERROR_MISSING_ATTRIBUTE,
+					"APN attribute missing");
 		return;
 	}
 =

@@ -262,8 +281,8 @@ static void gsm_start(GMarkupParseContext *context, con=
st gchar *element_name,
 		if (gsm->match_found =3D=3D TRUE)
 			return;
 =

-		network_id_handler(userdata, attribute_names, attribute_values,
-					error);
+		network_id_handler(context, userdata, attribute_names,
+					attribute_values, error);
 	} else if (g_str_equal(element_name, "apn"))
 		apn_handler(context, userdata, attribute_names,
 				attribute_values, error);
@@ -293,9 +312,9 @@ static void gsm_end(GMarkupParseContext *context, const=
 gchar *element_name,
 			if (pd->type !=3D apn->type)
 				continue;
 =

-			g_set_error(error, mbpi_error_quark(),
-					MBPI_ERROR_DUPLICATE,
-					"Duplicate context detected");
+			mbpi_g_set_error(context, error, mbpi_error_quark(),
+						MBPI_ERROR_DUPLICATE,
+						"Duplicate context detected");
 =

 			mbpi_provision_data_free(apn);
 			return;
-- =

1.7.4.1


--===============3733889915040068821==--

