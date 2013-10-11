Content-Type: multipart/mixed; boundary="===============3625738642253920990=="
MIME-Version: 1.0
From: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.com>
Subject: [PATCH] plugins,
 mbpi: make mbpi return only APNs of a given type. When provisioning
 for internect connection,
 only OFONO_GPRS_CONTEXT_TYPE_INTERNET APNs will be returned.
Date: Fri, 11 Oct 2013 11:24:38 +0200
Message-ID: <1381483478-16237-1-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3625738642253920990==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Alfonso Sanchez-Beato <alfonsosanchezbeato@yahoo.es>

---
 plugins/mbpi.c      | 7 ++++++-
 plugins/mbpi.h      | 1 +
 plugins/provision.c | 3 ++-
 tools/lookup-apn.c  | 3 ++-
 4 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/plugins/mbpi.c b/plugins/mbpi.c
index 309e1ed..b3e26fd 100644
--- a/plugins/mbpi.c
+++ b/plugins/mbpi.c
@@ -53,6 +53,7 @@ enum MBPI_ERROR {
 struct gsm_data {
 	const char *match_mcc;
 	const char *match_mnc;
+	enum ofono_gprs_context_type match_type;
 	GSList *apns;
 	gboolean match_found;
 	gboolean allow_duplicates;
@@ -370,7 +371,9 @@ static void gsm_end(GMarkupParseContext *context, const=
 gchar *element_name,
 		}
 	}
 =

-	gsm->apns =3D g_slist_append(gsm->apns, ap);
+	if (gsm->match_type =3D=3D OFONO_GPRS_CONTEXT_TYPE_ANY ||
+			gsm->match_type =3D=3D ap->type)
+		gsm->apns =3D g_slist_append(gsm->apns, ap);
 }
 =

 static const GMarkupParser gsm_parser =3D {
@@ -565,6 +568,7 @@ static gboolean mbpi_parse(const GMarkupParser *parser,=
 gpointer userdata,
 }
 =

 GSList *mbpi_lookup_apn(const char *mcc, const char *mnc,
+			enum ofono_gprs_context_type type,
 			gboolean allow_duplicates, GError **error)
 {
 	struct gsm_data gsm;
@@ -573,6 +577,7 @@ GSList *mbpi_lookup_apn(const char *mcc, const char *mn=
c,
 	memset(&gsm, 0, sizeof(gsm));
 	gsm.match_mcc =3D mcc;
 	gsm.match_mnc =3D mnc;
+	gsm.match_type =3D type;
 	gsm.allow_duplicates =3D allow_duplicates;
 =

 	if (mbpi_parse(&toplevel_gsm_parser, &gsm, error) =3D=3D FALSE) {
diff --git a/plugins/mbpi.h b/plugins/mbpi.h
index 64b7ea5..36bbed6 100644
--- a/plugins/mbpi.h
+++ b/plugins/mbpi.h
@@ -24,6 +24,7 @@ const char *mbpi_ap_type(enum ofono_gprs_context_type typ=
e);
 void mbpi_ap_free(struct ofono_gprs_provision_data *data);
 =

 GSList *mbpi_lookup_apn(const char *mcc, const char *mnc,
+			enum ofono_gprs_context_type type,
 			gboolean allow_duplicates, GError **error);
 =

 char *mbpi_lookup_cdma_provider_name(const char *sid, GError **error);
diff --git a/plugins/provision.c b/plugins/provision.c
index 99c299e..39e037b 100644
--- a/plugins/provision.c
+++ b/plugins/provision.c
@@ -50,7 +50,8 @@ static int provision_get_settings(const char *mcc, const =
char *mnc,
 =

 	DBG("Provisioning for MCC %s, MNC %s, SPN '%s'", mcc, mnc, spn);
 =

-	apns =3D mbpi_lookup_apn(mcc, mnc, FALSE, &error);
+	apns =3D mbpi_lookup_apn(mcc, mnc, OFONO_GPRS_CONTEXT_TYPE_INTERNET,
+				FALSE, &error);
 	if (apns =3D=3D NULL) {
 		if (error !=3D NULL) {
 			ofono_error("%s", error->message);
diff --git a/tools/lookup-apn.c b/tools/lookup-apn.c
index 884b32a..4654b03 100644
--- a/tools/lookup-apn.c
+++ b/tools/lookup-apn.c
@@ -42,7 +42,8 @@ static void lookup_apn(const char *match_mcc, const char =
*match_mnc,
 =

 	g_print("Searching for info for network: %s%s\n", match_mcc, match_mnc);
 =

-	apns =3D mbpi_lookup_apn(match_mcc, match_mnc, allow_duplicates, &error);
+	apns =3D mbpi_lookup_apn(match_mcc, match_mnc, OFONO_GPRS_CONTEXT_TYPE_AN=
Y,
+				allow_duplicates, &error);
 =

 	if (apns =3D=3D NULL) {
 		if (error !=3D NULL) {
-- =

1.8.1.2


--===============3625738642253920990==--

