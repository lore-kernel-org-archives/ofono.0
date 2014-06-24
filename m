Content-Type: multipart/mixed; boundary="===============7184203958560289943=="
MIME-Version: 1.0
From: Philip Paeps <philip@paeps.cx>
Subject: [PATCH 2/3] mbpi: add support for provisioning the auth method
Date: Tue, 24 Jun 2014 11:57:05 +0200
Message-ID: <1403603826-17021-3-git-send-email-philip@paeps.cx>
In-Reply-To: <1403603826-17021-1-git-send-email-philip@paeps.cx>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7184203958560289943==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use the authentication method from the mobile-broadband-provider-info
database if it is specified and supported (we support CHAP and PAP).
Default to CHAP if the database does not specify a method (i.e.: the
previous behaviour).
---
 plugins/mbpi.c |   35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/plugins/mbpi.c b/plugins/mbpi.c
index dff8752..ae92c76 100644
--- a/plugins/mbpi.c
+++ b/plugins/mbpi.c
@@ -128,6 +128,37 @@ static const GMarkupParser text_parser =3D {
 	NULL,
 };
 =

+static void authentication_start(GMarkupParseContext *context,
+			const gchar **attribute_names,
+			const gchar **attribute_values,
+			enum ofono_gprs_auth_method *auth_method,
+			GError **error)
+{
+	const char *text =3D NULL;
+	int i;
+
+	for (i =3D 0; attribute_names[i]; i++)
+		if (g_str_equal(attribute_names[i], "method") =3D=3D TRUE)
+			text =3D attribute_values[i];
+
+	if (text =3D=3D NULL) {
+		mbpi_g_set_error(context, error, G_MARKUP_ERROR,
+					G_MARKUP_ERROR_MISSING_ATTRIBUTE,
+					"Missing attribute: method");
+		return;
+	}
+
+	if (strcmp(text, "chap") =3D=3D 0)
+		*auth_method =3D OFONO_GPRS_AUTH_METHOD_CHAP;
+	else if (strcmp(text, "pap") =3D=3D 0)
+		*auth_method =3D OFONO_GPRS_AUTH_METHOD_PAP;
+	else
+		mbpi_g_set_error(context, error, G_MARKUP_ERROR,
+					G_MARKUP_ERROR_UNKNOWN_ATTRIBUTE,
+					"Unknown authentication method: %s",
+					text);
+}
+
 static void usage_start(GMarkupParseContext *context,
 			const gchar **attribute_names,
 			const gchar **attribute_values,
@@ -174,6 +205,9 @@ static void apn_start(GMarkupParseContext *context, con=
st gchar *element_name,
 	else if (g_str_equal(element_name, "password"))
 		g_markup_parse_context_push(context, &text_parser,
 						&apn->password);
+	else if (g_str_equal(element_name, "authentication"))
+		authentication_start(context, attribute_names,
+				attribute_values, &apn->auth_method, error);
 	else if (g_str_equal(element_name, "mmsc"))
 		g_markup_parse_context_push(context, &text_parser,
 						&apn->message_center);
@@ -291,6 +325,7 @@ static void apn_handler(GMarkupParseContext *context, s=
truct gsm_data *gsm,
 	ap->apn =3D g_strdup(apn);
 	ap->type =3D OFONO_GPRS_CONTEXT_TYPE_INTERNET;
 	ap->proto =3D OFONO_GPRS_PROTO_IP;
+	ap->auth_method =3D OFONO_GPRS_AUTH_METHOD_CHAP;
 =

 	g_markup_parse_context_push(context, &apn_parser, ap);
 }
-- =

1.7.10.4


--===============7184203958560289943==--

