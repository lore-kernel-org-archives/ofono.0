Content-Type: multipart/mixed; boundary="===============7921223841117865842=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: [PATCH] mbpi: Return provider name to the provisioning plugin
Date: Fri, 18 Apr 2014 15:13:17 +0300
Message-ID: <1397823197-29688-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7921223841117865842==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Second try, this time not touching core interfaces.
---
 plugins/mbpi.c      | 59 ++++++++++++++++++++++++++++++++++++++++++++-----=
----
 plugins/mbpi.h      | 14 ++++++++++++-
 plugins/provision.c | 15 +++++++++++---
 tools/lookup-apn.c  |  5 +++--
 4 files changed, 77 insertions(+), 16 deletions(-)

diff --git a/plugins/mbpi.c b/plugins/mbpi.c
index dff8752..0b30a54 100644
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
@@ -82,7 +83,7 @@ static GQuark mbpi_error_quark(void)
 	return g_quark_from_static_string("ofono-mbpi-error-quark");
 }
 =

-void mbpi_ap_free(struct ofono_gprs_provision_data *ap)
+void mbpi_ap_free(struct mbpi_provision_data *ap)
 {
 	g_free(ap->name);
 	g_free(ap->apn);
@@ -90,6 +91,7 @@ void mbpi_ap_free(struct ofono_gprs_provision_data *ap)
 	g_free(ap->password);
 	g_free(ap->message_proxy);
 	g_free(ap->message_center);
+	g_free(ap->provider_name);
 =

 	g_free(ap);
 }
@@ -117,6 +119,7 @@ static void text_handler(GMarkupParseContext *context,
 {
 	char **string =3D userdata;
 =

+	g_free(*string);
 	*string =3D g_strndup(text, text_len);
 }
 =

@@ -164,7 +167,7 @@ static void apn_start(GMarkupParseContext *context, con=
st gchar *element_name,
 			const gchar **attribute_values,
 			gpointer userdata, GError **error)
 {
-	struct ofono_gprs_provision_data *apn =3D userdata;
+	struct mbpi_provision_data *apn =3D userdata;
 =

 	if (g_str_equal(element_name, "name"))
 		g_markup_parse_context_push(context, &text_parser, &apn->name);
@@ -263,7 +266,7 @@ static void apn_handler(GMarkupParseContext *context, s=
truct gsm_data *gsm,
 			const gchar **attribute_values,
 			GError **error)
 {
-	struct ofono_gprs_provision_data *ap;
+	struct mbpi_provision_data *ap;
 	const char *apn;
 	int i;
 =

@@ -287,7 +290,8 @@ static void apn_handler(GMarkupParseContext *context, s=
truct gsm_data *gsm,
 		return;
 	}
 =

-	ap =3D g_new0(struct ofono_gprs_provision_data, 1);
+	ap =3D g_new0(struct mbpi_provision_data, 1);
+	ap->provider_name =3D g_strdup(gsm->provider_name);
 	ap->apn =3D g_strdup(apn);
 	ap->type =3D OFONO_GPRS_CONTEXT_TYPE_INTERNET;
 	ap->proto =3D OFONO_GPRS_PROTO_IP;
@@ -349,7 +353,7 @@ static void gsm_end(GMarkupParseContext *context, const=
 gchar *element_name,
 			gpointer userdata, GError **error)
 {
 	struct gsm_data *gsm;
-	struct ofono_gprs_provision_data *ap;
+	struct mbpi_provision_data *ap;
 =

 	if (!g_str_equal(element_name, "apn"))
 		return;
@@ -364,7 +368,7 @@ static void gsm_end(GMarkupParseContext *context, const=
 gchar *element_name,
 		GSList *l;
 =

 		for (l =3D gsm->apns; l; l =3D l->next) {
-			struct ofono_gprs_provision_data *pd =3D l->data;
+			struct mbpi_provision_data *pd =3D l->data;
 =

 			if (pd->type !=3D ap->type)
 				continue;
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

diff --git a/plugins/mbpi.h b/plugins/mbpi.h
index 64b7ea5..1680841 100644
--- a/plugins/mbpi.h
+++ b/plugins/mbpi.h
@@ -19,9 +19,21 @@
  *
  */
 =

+struct mbpi_provision_data {
+	enum ofono_gprs_context_type type;
+	enum ofono_gprs_proto proto;
+	char *name;
+	char *apn;
+	char *username;
+	char *password;
+	char *message_proxy;
+	char *message_center;
+	char *provider_name;
+};
+
 const char *mbpi_ap_type(enum ofono_gprs_context_type type);
 =

-void mbpi_ap_free(struct ofono_gprs_provision_data *data);
+void mbpi_ap_free(struct mbpi_provision_data *data);
 =

 GSList *mbpi_lookup_apn(const char *mcc, const char *mnc,
 			gboolean allow_duplicates, GError **error);
diff --git a/plugins/provision.c b/plugins/provision.c
index 99c299e..4bb18fa 100644
--- a/plugins/provision.c
+++ b/plugins/provision.c
@@ -79,17 +79,26 @@ static int provision_get_settings(const char *mcc, cons=
t char *mnc,
 	*count =3D ap_count;
 =

 	for (l =3D apns, i =3D 0; l; l =3D l->next, i++) {
-		struct ofono_gprs_provision_data *ap =3D l->data;
+		struct mbpi_provision_data *ap =3D l->data;
+		struct ofono_gprs_provision_data *p =3D *settings + i;
 =

 		DBG("Name: '%s'", ap->name);
+		DBG("Provider: '%s'", ap->provider_name);
 		DBG("APN: '%s'", ap->apn);
 		DBG("Type: %s", mbpi_ap_type(ap->type));
 		DBG("Username: '%s'", ap->username);
 		DBG("Password: '%s'", ap->password);
 =

-		memcpy(*settings + i, ap,
-			sizeof(struct ofono_gprs_provision_data));
+		p->type =3D ap->type;
+		p->proto =3D ap->proto;
+		p->name =3D ap->name;
+		p->apn =3D ap->apn;
+		p->username =3D ap->username;
+		p->password =3D ap->password;
+		p->message_proxy =3D ap->message_proxy;
+		p->message_center =3D ap->message_center;
 =

+		g_free(ap->provider_name);
 		g_free(ap);
 	}
 =

diff --git a/tools/lookup-apn.c b/tools/lookup-apn.c
index 884b32a..7a6ea7d 100644
--- a/tools/lookup-apn.c
+++ b/tools/lookup-apn.c
@@ -54,9 +54,10 @@ static void lookup_apn(const char *match_mcc, const char=
 *match_mnc,
 	}
 =

 	for (l =3D apns; l; l =3D l->next) {
-		struct ofono_gprs_provision_data *ap =3D l->data;
+		struct mbpi_provision_data *ap =3D l->data;
 =

 		g_print("\n");
+		g_print("Provider: %s\n", ap->provider_name);
 		g_print("Name: %s\n", ap->name);
 		g_print("APN: %s\n", ap->apn);
 		g_print("Type: %s\n", mbpi_ap_type(ap->type));
@@ -85,7 +86,7 @@ int main(int argc, char **argv)
 	GOptionContext *context;
 	GError *error =3D NULL;
 =

-	context =3D g_option_context_new(NULL);
+	context =3D g_option_context_new("MCC MNC");
 	g_option_context_add_main_entries(context, options, NULL);
 =

 	if (g_option_context_parse(context, &argc, &argv, &error) =3D=3D FALSE) {
-- =

1.8.3.2


--===============7921223841117865842==--

