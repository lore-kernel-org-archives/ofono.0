Content-Type: multipart/mixed; boundary="===============4625442664678293972=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv10 8/9] mbpi: Minor style issues
Date: Tue, 18 Oct 2011 14:05:04 +0300
Message-ID: <1318935905-9087-9-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1318935905-9087-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4625442664678293972==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/mbpi.c |   42 +++++++++++++++++++++---------------------
 1 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/plugins/mbpi.c b/plugins/mbpi.c
index 5e42287..6f77d9a 100644
--- a/plugins/mbpi.c
+++ b/plugins/mbpi.c
@@ -77,16 +77,16 @@ static GQuark mbpi_error_quark(void)
 	return g_quark_from_static_string("ofono-mbpi-error-quark");
 }
 =

-void mbpi_ap_free(struct ofono_gprs_provision_data *data)
+void mbpi_ap_free(struct ofono_gprs_provision_data *ap)
 {
-	g_free(data->name);
-	g_free(data->apn);
-	g_free(data->username);
-	g_free(data->password);
-	g_free(data->message_proxy);
-	g_free(data->message_center);
-
-	g_free(data);
+	g_free(ap->name);
+	g_free(ap->apn);
+	g_free(ap->username);
+	g_free(ap->password);
+	g_free(ap->message_proxy);
+	g_free(ap->message_center);
+
+	g_free(ap);
 }
 =

 static void mbpi_g_set_error(GMarkupParseContext *context, GError **error,
@@ -250,7 +250,7 @@ static void apn_handler(GMarkupParseContext *context, s=
truct gsm_data *gsm,
 			const gchar **attribute_values,
 			GError **error)
 {
-	struct ofono_gprs_provision_data *pd;
+	struct ofono_gprs_provision_data *ap;
 	const char *apn;
 	int i;
 =

@@ -274,12 +274,12 @@ static void apn_handler(GMarkupParseContext *context,=
 struct gsm_data *gsm,
 		return;
 	}
 =

-	pd =3D g_new0(struct ofono_gprs_provision_data, 1);
-	pd->apn =3D g_strdup(apn);
-	pd->type =3D OFONO_GPRS_CONTEXT_TYPE_INTERNET;
-	pd->proto =3D OFONO_GPRS_PROTO_IP;
+	ap =3D g_new0(struct ofono_gprs_provision_data, 1);
+	ap->apn =3D g_strdup(apn);
+	ap->type =3D OFONO_GPRS_CONTEXT_TYPE_INTERNET;
+	ap->proto =3D OFONO_GPRS_PROTO_IP;
 =

-	g_markup_parse_context_push(context, &apn_parser, pd);
+	g_markup_parse_context_push(context, &apn_parser, ap);
 }
 =

 static void gsm_start(GMarkupParseContext *context, const gchar *element_n=
ame,
@@ -308,15 +308,15 @@ static void gsm_end(GMarkupParseContext *context, con=
st gchar *element_name,
 			gpointer userdata, GError **error)
 {
 	struct gsm_data *gsm;
-	struct ofono_gprs_provision_data *apn;
+	struct ofono_gprs_provision_data *ap;
 =

 	if (!g_str_equal(element_name, "apn"))
 		return;
 =

 	gsm =3D userdata;
 =

-	apn =3D g_markup_parse_context_pop(context);
-	if (apn =3D=3D NULL)
+	ap =3D g_markup_parse_context_pop(context);
+	if (ap =3D=3D NULL)
 		return;
 =

 	if (gsm->allow_duplicates =3D=3D FALSE) {
@@ -325,19 +325,19 @@ static void gsm_end(GMarkupParseContext *context, con=
st gchar *element_name,
 		for (l =3D gsm->apns; l; l =3D l->next) {
 			struct ofono_gprs_provision_data *pd =3D l->data;
 =

-			if (pd->type !=3D apn->type)
+			if (pd->type !=3D ap->type)
 				continue;
 =

 			mbpi_g_set_error(context, error, mbpi_error_quark(),
 						MBPI_ERROR_DUPLICATE,
 						"Duplicate context detected");
 =

-			mbpi_ap_free(apn);
+			mbpi_ap_free(ap);
 			return;
 		}
 	}
 =

-	gsm->apns =3D g_slist_append(gsm->apns, apn);
+	gsm->apns =3D g_slist_append(gsm->apns, ap);
 }
 =

 static const GMarkupParser gsm_parser =3D {
-- =

1.7.4.1


--===============4625442664678293972==--

