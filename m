Content-Type: multipart/mixed; boundary="===============8518565636264029231=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: [PATCH] mbpi: Parse gsm provider name
Date: Wed, 16 Apr 2014 17:00:36 +0300
Message-ID: <1397656836-27803-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8518565636264029231==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This gives the provisioning plugin more information to work with and
improves the chance of automatically picking the right AP in case if
we have more than one for the same mcc/mnc combination.
---
 include/gprs-provision.h |  1 +
 plugins/mbpi.c           | 47 +++++++++++++++++++++++++++++++++++++++++++-=
---
 2 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/include/gprs-provision.h b/include/gprs-provision.h
index e9eec61..0129cd0 100644
--- a/include/gprs-provision.h
+++ b/include/gprs-provision.h
@@ -31,6 +31,7 @@ extern "C" {
 struct ofono_gprs_provision_data {
 	enum ofono_gprs_context_type type;
 	enum ofono_gprs_proto proto;
+	char *provider_name;
 	char *name;
 	char *apn;
 	char *username;
diff --git a/plugins/mbpi.c b/plugins/mbpi.c
index dff8752..f2b00d0 100644
--- a/plugins/mbpi.c
+++ b/plugins/mbpi.c
@@ -53,6 +53,7 @@ enum MBPI_ERROR {
 struct gsm_data {
 	const char *match_mcc;
 	const char *match_mnc;
+	char *provider_name;
 	GSList *apns;
 	gboolean match_found;
 	gboolean allow_duplicates;
@@ -84,6 +85,7 @@ static GQuark mbpi_error_quark(void)
 =

 void mbpi_ap_free(struct ofono_gprs_provision_data *ap)
 {
+	g_free(ap->provider_name);
 	g_free(ap->name);
 	g_free(ap->apn);
 	g_free(ap->username);
@@ -117,6 +119,7 @@ static void text_handler(GMarkupParseContext *context,
 {
 	char **string =3D userdata;
 =

+        g_free(*string);
 	*string =3D g_strndup(text, text_len);
 }
 =

@@ -288,6 +291,7 @@ static void apn_handler(GMarkupParseContext *context, s=
truct gsm_data *gsm,
 	}
 =

 	ap =3D g_new0(struct ofono_gprs_provision_data, 1);
+	ap->provider_name =3D g_strdup(gsm->provider_name);
 	ap->apn =3D g_strdup(apn);
 	ap->type =3D OFONO_GPRS_CONTEXT_TYPE_INTERNET;
 	ap->proto =3D OFONO_GPRS_PROTO_IP;
@@ -454,7 +458,7 @@ static const GMarkupParser provider_parser =3D {
 	NULL,
 };
 =

-static void toplevel_gsm_start(GMarkupParseContext *context,
+static void gsm_provider_start(GMarkupParseContext *context,
 					const gchar *element_name,
 					const gchar **atribute_names,
 					const gchar **attribute_values,
@@ -462,19 +466,53 @@ static void toplevel_gsm_start(GMarkupParseContext *c=
ontext,
 {
 	struct gsm_data *gsm =3D userdata;
 =

-	if (g_str_equal(element_name, "gsm")) {
+	if (g_str_equal(element_name, "name")) {
+		g_free(gsm->provider_name);
+		gsm->provider_name =3D NULL;
+		g_markup_parse_context_push(context, &text_parser,
+						&gsm->provider_name);
+	} else if (g_str_equal(element_name, "gsm")) {
 		gsm->match_found =3D FALSE;
 		g_markup_parse_context_push(context, &gsm_parser, gsm);
 	} else if (g_str_equal(element_name, "cdma"))
 		g_markup_parse_context_push(context, &skip_parser, NULL);
 }
 =

+static void gsm_provider_end(GMarkupParseContext *context,
+					const gchar *element_name,
+					gpointer userdata, GError **error)
+{
+	if (g_str_equal(element_name, "name") ||
+				g_str_equal(element_name, "gsm") ||
+				g_str_equal(element_name, "cdma"))
+		g_markup_parse_context_pop(context);
+}
+
+static const GMarkupParser gsm_provider_parser =3D {
+	gsm_provider_start,
+	gsm_provider_end,
+	NULL,
+	NULL,
+	NULL,
+};
+
+static void toplevel_gsm_start(GMarkupParseContext *context,
+					const gchar *element_name,
+					const gchar **atribute_names,
+					const gchar **attribute_values,
+					gpointer userdata, GError **error)
+{
+	struct gsm_data *gsm =3D userdata;
+
+	if (g_str_equal(element_name, "provider"))
+		g_markup_parse_context_push(context, &gsm_provider_parser, gsm);
+}
+
 static void toplevel_gsm_end(GMarkupParseContext *context,
 					const gchar *element_name,
 					gpointer userdata, GError **error)
 {
-	if (g_str_equal(element_name, "gsm") ||
-			g_str_equal(element_name, "cdma"))
+	if (g_str_equal(element_name, "provider"))
 		g_markup_parse_context_pop(context);
 }
 =

@@ -591,6 +629,7 @@ GSList *mbpi_lookup_apn(const char *mcc, const char *mn=
c,
 		gsm.apns =3D NULL;
 	}
 =

+	g_free(gsm.provider_name);
 	return gsm.apns;
 }
 =

-- =

1.8.3.2


--===============8518565636264029231==--

