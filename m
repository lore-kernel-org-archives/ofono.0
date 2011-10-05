Content-Type: multipart/mixed; boundary="===============7982451583129596298=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv9 02/16] mbpi: Split gsm_start() for readability
Date: Wed, 05 Oct 2011 16:18:25 +0300
Message-ID: <1317820719-23609-3-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1317820719-23609-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7982451583129596298==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/mbpi.c |  138 +++++++++++++++++++++++++++++++---------------------=
----
 1 files changed, 77 insertions(+), 61 deletions(-)

diff --git a/plugins/mbpi.c b/plugins/mbpi.c
index 91c1ce0..8cb4e23 100644
--- a/plugins/mbpi.c
+++ b/plugins/mbpi.c
@@ -174,16 +174,84 @@ static const GMarkupParser skip_parser =3D {
 	NULL,
 };
 =

+static void network_id_handler(struct gsm_data *gsm,
+				const gchar **attribute_names,
+				const gchar **attribute_values,
+				GError **error)
+{
+	const char *mcc =3D NULL, *mnc =3D NULL;
+	int i;
+
+	for (i =3D 0; attribute_names[i]; i++) {
+		if (g_str_equal(attribute_names[i], "mcc") =3D=3D TRUE)
+			mcc =3D attribute_values[i];
+		if (g_str_equal(attribute_names[i], "mnc") =3D=3D TRUE)
+			mnc =3D attribute_values[i];
+	}
+
+	if (mcc =3D=3D NULL) {
+		g_set_error(error, G_MARKUP_ERROR,
+				G_MARKUP_ERROR_MISSING_ATTRIBUTE,
+				"Missing attribute: mcc");
+		return;
+	}
+
+	if (mnc =3D=3D NULL) {
+		g_set_error(error, G_MARKUP_ERROR,
+				G_MARKUP_ERROR_MISSING_ATTRIBUTE,
+				"Missing attribute: mnc");
+		return;
+	}
+
+	if (g_str_equal(mcc, gsm->match_mcc) &&
+			g_str_equal(mnc, gsm->match_mnc))
+		gsm->match_found =3D TRUE;
+}
+
+static void apn_handler(GMarkupParseContext *context, struct gsm_data *gsm,
+			const gchar **attribute_names,
+			const gchar **attribute_values,
+			GError **error)
+{
+	struct ofono_gprs_provision_data *pd;
+	const char *apn;
+	int i;
+
+	if (gsm->match_found =3D=3D FALSE) {
+		g_markup_parse_context_push(context, &skip_parser, NULL);
+		return;
+	}
+
+	for (i =3D 0, apn =3D NULL; attribute_names[i]; i++) {
+		if (g_str_equal(attribute_names[i], "value") =3D=3D FALSE)
+			continue;
+
+		apn =3D attribute_values[i];
+		break;
+	}
+
+	if (apn =3D=3D NULL) {
+		g_set_error(error, G_MARKUP_ERROR,
+				G_MARKUP_ERROR_MISSING_ATTRIBUTE,
+				"APN attribute missing");
+		return;
+	}
+
+	pd =3D g_new0(struct ofono_gprs_provision_data, 1);
+	pd->apn =3D g_strdup(apn);
+	pd->type =3D OFONO_GPRS_CONTEXT_TYPE_INTERNET;
+	pd->proto =3D OFONO_GPRS_PROTO_IP;
+
+	g_markup_parse_context_push(context, &apn_parser, pd);
+}
+
 static void gsm_start(GMarkupParseContext *context, const gchar *element_n=
ame,
 			const gchar **attribute_names,
 			const gchar **attribute_values,
 			gpointer userdata, GError **error)
 {
-	struct gsm_data *gsm =3D userdata;
-
 	if (g_str_equal(element_name, "network-id")) {
-		const char *mcc =3D NULL, *mnc =3D NULL;
-		int i;
+		struct gsm_data *gsm =3D userdata;
 =

 		/*
 		 * For entries with multiple network-id elements, don't bother
@@ -192,63 +260,11 @@ static void gsm_start(GMarkupParseContext *context, c=
onst gchar *element_name,
 		if (gsm->match_found =3D=3D TRUE)
 			return;
 =

-		for (i =3D 0; attribute_names[i]; i++) {
-			if (g_str_equal(attribute_names[i], "mcc") =3D=3D TRUE)
-				mcc =3D attribute_values[i];
-			if (g_str_equal(attribute_names[i], "mnc") =3D=3D TRUE)
-				mnc =3D attribute_values[i];
-		}
-
-		if (mcc =3D=3D NULL) {
-			g_set_error(error, G_MARKUP_ERROR,
-					G_MARKUP_ERROR_MISSING_ATTRIBUTE,
-					"Missing attribute: mcc");
-			return;
-		}
-
-		if (mnc =3D=3D NULL) {
-			g_set_error(error, G_MARKUP_ERROR,
-					G_MARKUP_ERROR_MISSING_ATTRIBUTE,
-					"Missing attribute: mnc");
-			return;
-		}
-
-		if (g_str_equal(mcc, gsm->match_mcc) &&
-				g_str_equal(mnc, gsm->match_mnc))
-			gsm->match_found =3D TRUE;
-	} else if (g_str_equal(element_name, "apn")) {
-		int i;
-		struct ofono_gprs_provision_data *pd;
-		const char *apn;
-
-		if (gsm->match_found =3D=3D FALSE) {
-			g_markup_parse_context_push(context,
-							&skip_parser, NULL);
-			return;
-		}
-
-		for (i =3D 0, apn =3D NULL; attribute_names[i]; i++) {
-			if (g_str_equal(attribute_names[i], "value") =3D=3D FALSE)
-				continue;
-
-			apn =3D attribute_values[i];
-			break;
-		}
-
-		if (apn =3D=3D NULL) {
-			g_set_error(error, G_MARKUP_ERROR,
-					G_MARKUP_ERROR_MISSING_ATTRIBUTE,
-					"APN attribute missing");
-			return;
-		}
-
-		pd =3D g_new0(struct ofono_gprs_provision_data, 1);
-		pd->apn =3D g_strdup(apn);
-		pd->type =3D OFONO_GPRS_CONTEXT_TYPE_INTERNET;
-		pd->proto =3D OFONO_GPRS_PROTO_IP;
-
-		g_markup_parse_context_push(context, &apn_parser, pd);
-	}
+		network_id_handler(userdata, attribute_names, attribute_values,
+					error);
+	} else if (g_str_equal(element_name, "apn"))
+		apn_handler(context, userdata, attribute_names,
+				attribute_values, error);
 }
 =

 static void gsm_end(GMarkupParseContext *context, const gchar *element_nam=
e,
-- =

1.7.4.1


--===============7982451583129596298==--

