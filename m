Content-Type: multipart/mixed; boundary="===============7755425574950934170=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH v2 1/6] mbpi: Add mbpi_lookup_cdma_provider_name API
Date: Thu, 17 Nov 2011 17:20:59 +0100
Message-ID: <1321546864-368-2-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1321546864-368-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7755425574950934170==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/mbpi.c |  146 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 plugins/mbpi.h |    2 +
 2 files changed, 148 insertions(+), 0 deletions(-)

diff --git a/plugins/mbpi.c b/plugins/mbpi.c
index 1e41ecb..415633f 100644
--- a/plugins/mbpi.c
+++ b/plugins/mbpi.c
@@ -58,6 +58,12 @@ struct gsm_data {
 	gboolean allow_duplicates;
 };
 =

+struct cdma_data {
+	const char *match_sid;
+	char *provider_name;
+	gboolean match_found;
+};
+
 const char *mbpi_ap_type(enum ofono_gprs_context_type type)
 {
 	switch (type) {
@@ -281,6 +287,32 @@ static void apn_handler(GMarkupParseContext *context, =
struct gsm_data *gsm,
 	g_markup_parse_context_push(context, &apn_parser, ap);
 }
 =

+static void sid_handler(GMarkupParseContext *context,
+				struct cdma_data *cdma,
+				const gchar **attribute_names,
+				const gchar **attribute_values,
+				GError **error)
+{
+	const char *sid =3D NULL;
+	int i;
+
+	for (i =3D 0; attribute_names[i]; i++)
+		if (g_str_equal(attribute_names[i], "value") =3D=3D TRUE) {
+			sid =3D attribute_values[i];
+			break;
+		}
+
+	if (sid =3D=3D NULL) {
+		mbpi_g_set_error(context, error, G_MARKUP_ERROR,
+					G_MARKUP_ERROR_MISSING_ATTRIBUTE,
+					"Missing attribute: sid");
+		return;
+	}
+
+	if (g_str_equal(sid, cdma->match_sid))
+		cdma->match_found =3D TRUE;
+}
+
 static void gsm_start(GMarkupParseContext *context, const gchar *element_n=
ame,
 			const gchar **attribute_names,
 			const gchar **attribute_values,
@@ -347,6 +379,71 @@ static const GMarkupParser gsm_parser =3D {
 	NULL,
 };
 =

+static void cdma_start(GMarkupParseContext *context, const gchar *element_=
name,
+			const gchar **attribute_names,
+			const gchar **attribute_values,
+			gpointer userdata, GError **error)
+{
+	if (g_str_equal(element_name, "sid")) {
+		struct cdma_data *cdma =3D userdata;
+		/*
+		 * For entries with multiple sid elements, don't bother
+		 * searching if we already have a match
+		 */
+		if (cdma->match_found =3D=3D TRUE)
+			return;
+
+		sid_handler(context, cdma, attribute_names, attribute_values,
+				error);
+	}
+}
+
+static const GMarkupParser cdma_parser =3D {
+	cdma_start,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+};
+
+static void provider_start(GMarkupParseContext *context,
+				const gchar *element_name,
+				const gchar **attribute_names,
+				const gchar **attribute_values,
+				gpointer userdata, GError **error)
+{
+	if (g_str_equal(element_name, "name")) {
+		struct cdma_data *cdma =3D userdata;
+
+		g_free(cdma->provider_name);
+		cdma->provider_name =3D NULL;
+		g_markup_parse_context_push(context, &text_parser,
+						&cdma->provider_name);
+	} else if (g_str_equal(element_name, "gsm"))
+		g_markup_parse_context_push(context, &skip_parser, NULL);
+	else if (g_str_equal(element_name, "cdma"))
+		g_markup_parse_context_push(context, &cdma_parser, userdata);
+}
+
+static void provider_end(GMarkupParseContext *context,
+					const gchar *element_name,
+					gpointer userdata, GError **error)
+{
+	if (g_str_equal(element_name, "name") ||
+				g_str_equal(element_name, "gsm") ||
+				g_str_equal(element_name, "cdma"))
+		g_markup_parse_context_pop(context);
+
+}
+
+static const GMarkupParser provider_parser =3D {
+	provider_start,
+	provider_end,
+	NULL,
+	NULL,
+	NULL,
+};
+
 static void toplevel_gsm_start(GMarkupParseContext *context,
 					const gchar *element_name,
 					const gchar **atribute_names,
@@ -379,6 +476,40 @@ static const GMarkupParser toplevel_gsm_parser =3D {
 	NULL,
 };
 =

+static void toplevel_cdma_start(GMarkupParseContext *context,
+					const gchar *element_name,
+					const gchar **atribute_names,
+					const gchar **attribute_values,
+					gpointer userdata, GError **error)
+{
+	struct cdma_data *cdma =3D userdata;
+
+	if (g_str_equal(element_name, "provider")) {
+		if (cdma->match_found =3D=3D TRUE)
+			g_markup_parse_context_push(context, &skip_parser,
+								NULL);
+		else
+			g_markup_parse_context_push(context, &provider_parser,
+								userdata);
+	}
+}
+
+static void toplevel_cdma_end(GMarkupParseContext *context,
+					const gchar *element_name,
+					gpointer userdata, GError **error)
+{
+	if (g_str_equal(element_name, "provider"))
+		g_markup_parse_context_pop(context);
+}
+
+static const GMarkupParser toplevel_cdma_parser =3D {
+	toplevel_cdma_start,
+	toplevel_cdma_end,
+	NULL,
+	NULL,
+	NULL,
+};
+
 static gboolean mbpi_parse(const GMarkupParser *parser, gpointer userdata,
 				GError **error)
 {
@@ -453,3 +584,18 @@ GSList *mbpi_lookup_apn(const char *mcc, const char *m=
nc,
 =

 	return gsm.apns;
 }
+
+char *mbpi_lookup_cdma_provider_name(const char *sid, GError **error)
+{
+	struct cdma_data cdma;
+
+	memset(&cdma, 0, sizeof(cdma));
+	cdma.match_sid =3D sid;
+
+	if (mbpi_parse(&toplevel_cdma_parser, &cdma, error) =3D=3D FALSE) {
+		g_free(cdma.provider_name);
+		cdma.provider_name =3D NULL;
+	}
+
+	return cdma.provider_name;
+}
diff --git a/plugins/mbpi.h b/plugins/mbpi.h
index 6d34358..64b7ea5 100644
--- a/plugins/mbpi.h
+++ b/plugins/mbpi.h
@@ -25,3 +25,5 @@ void mbpi_ap_free(struct ofono_gprs_provision_data *data);
 =

 GSList *mbpi_lookup_apn(const char *mcc, const char *mnc,
 			gboolean allow_duplicates, GError **error);
+
+char *mbpi_lookup_cdma_provider_name(const char *sid, GError **error);
-- =

1.7.1


--===============7755425574950934170==--

