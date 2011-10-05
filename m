Content-Type: multipart/mixed; boundary="===============7730275660902935428=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv9 03/16] mbpi: Reflow gsm_end()
Date: Wed, 05 Oct 2011 16:18:26 +0300
Message-ID: <1317820719-23609-4-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1317820719-23609-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7730275660902935428==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/mbpi.c |   42 ++++++++++++++++++++++--------------------
 1 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/plugins/mbpi.c b/plugins/mbpi.c
index 8cb4e23..fce70ba 100644
--- a/plugins/mbpi.c
+++ b/plugins/mbpi.c
@@ -270,35 +270,37 @@ static void gsm_start(GMarkupParseContext *context, c=
onst gchar *element_name,
 static void gsm_end(GMarkupParseContext *context, const gchar *element_nam=
e,
 			gpointer userdata, GError **error)
 {
-	struct gsm_data *gsm =3D userdata;
+	struct gsm_data *gsm;
+	struct ofono_gprs_provision_data *apn;
+
+	if (!g_str_equal(element_name, "apn"))
+		return;
 =

-	if (g_str_equal(element_name, "apn")) {
-		struct ofono_gprs_provision_data *apn =3D
-					g_markup_parse_context_pop(context);
+	gsm =3D userdata;
 =

-		if (apn =3D=3D NULL)
-			return;
+	apn =3D g_markup_parse_context_pop(context);
+	if (apn =3D=3D NULL)
+		return;
 =

-		if (gsm->allow_duplicates =3D=3D FALSE) {
-			GSList *l;
+	if (gsm->allow_duplicates =3D=3D FALSE) {
+		GSList *l;
 =

-			for (l =3D gsm->apns; l; l =3D l->next) {
-				struct ofono_gprs_provision_data *pd =3D l->data;
+		for (l =3D gsm->apns; l; l =3D l->next) {
+			struct ofono_gprs_provision_data *pd =3D l->data;
 =

-				if (pd->type !=3D apn->type)
-					continue;
+			if (pd->type !=3D apn->type)
+				continue;
 =

-				g_set_error(error, mbpi_error_quark(),
-						MBPI_ERROR_DUPLICATE,
-						"Duplicate context detected");
+			g_set_error(error, mbpi_error_quark(),
+					MBPI_ERROR_DUPLICATE,
+					"Duplicate context detected");
 =

-				mbpi_provision_data_free(apn);
-				return;
-			}
+			mbpi_provision_data_free(apn);
+			return;
 		}
-
-		gsm->apns =3D g_slist_append(gsm->apns, apn);
 	}
+
+	gsm->apns =3D g_slist_append(gsm->apns, apn);
 }
 =

 static const GMarkupParser gsm_parser =3D {
-- =

1.7.4.1


--===============7730275660902935428==--

