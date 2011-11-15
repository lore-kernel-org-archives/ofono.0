Content-Type: multipart/mixed; boundary="===============7693349606393961031=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 1/3] mbpi: mbpi_lookup becomes mbpi_lookup_apn
Date: Tue, 15 Nov 2011 14:04:13 +0100
Message-ID: <1321362255-11262-2-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1321362255-11262-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7693349606393961031==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/mbpi.c      |   71 +++++++++++++++++++++++++----------------------=
----
 plugins/mbpi.h      |    2 +-
 plugins/provision.c |    2 +-
 tools/lookup-apn.c  |    2 +-
 4 files changed, 38 insertions(+), 39 deletions(-)

diff --git a/plugins/mbpi.c b/plugins/mbpi.c
index 53d4b27..1e41ecb 100644
--- a/plugins/mbpi.c
+++ b/plugins/mbpi.c
@@ -347,7 +347,7 @@ static const GMarkupParser gsm_parser =3D {
 	NULL,
 };
 =

-static void toplevel_start(GMarkupParseContext *context,
+static void toplevel_gsm_start(GMarkupParseContext *context,
 					const gchar *element_name,
 					const gchar **atribute_names,
 					const gchar **attribute_values,
@@ -362,7 +362,7 @@ static void toplevel_start(GMarkupParseContext *context,
 		g_markup_parse_context_push(context, &skip_parser, NULL);
 }
 =

-static void toplevel_end(GMarkupParseContext *context,
+static void toplevel_gsm_end(GMarkupParseContext *context,
 					const gchar *element_name,
 					gpointer userdata, GError **error)
 {
@@ -371,42 +371,22 @@ static void toplevel_end(GMarkupParseContext *context,
 		g_markup_parse_context_pop(context);
 }
 =

-static const GMarkupParser toplevel_parser =3D {
-	toplevel_start,
-	toplevel_end,
+static const GMarkupParser toplevel_gsm_parser =3D {
+	toplevel_gsm_start,
+	toplevel_gsm_end,
 	NULL,
 	NULL,
 	NULL,
 };
 =

-static gboolean mbpi_parse(const char *data, ssize_t size,
-				struct gsm_data *gsm, GError **error)
-{
-	GMarkupParseContext *context;
-	gboolean ret;
-
-	context =3D g_markup_parse_context_new(&toplevel_parser,
-						G_MARKUP_TREAT_CDATA_AS_TEXT,
-						gsm, NULL);
-
-	ret =3D g_markup_parse_context_parse(context, data, size, error);
-
-	if (ret =3D=3D TRUE)
-		g_markup_parse_context_end_parse(context, error);
-
-	g_markup_parse_context_free(context);
-
-	return ret;
-}
-
-GSList *mbpi_lookup(const char *mcc, const char *mnc,
-			gboolean allow_duplicates, GError **error)
+static gboolean mbpi_parse(const GMarkupParser *parser, gpointer userdata,
+				GError **error)
 {
 	struct stat st;
 	char *db;
 	int fd;
-	struct gsm_data gsm;
-	GSList *l;
+	GMarkupParseContext *context;
+	gboolean ret;
 =

 	fd =3D open(MBPI_DATABASE, O_RDONLY);
 	if (fd < 0) {
@@ -414,7 +394,7 @@ GSList *mbpi_lookup(const char *mcc, const char *mnc,
 				g_file_error_from_errno(errno),
 				"open(%s) failed: %s", MBPI_DATABASE,
 				g_strerror(errno));
-		return NULL;
+		return FALSE;
 	}
 =

 	if (fstat(fd, &st) < 0) {
@@ -423,7 +403,7 @@ GSList *mbpi_lookup(const char *mcc, const char *mnc,
 				g_file_error_from_errno(errno),
 				"fstat(%s) failed: %s", MBPI_DATABASE,
 				g_strerror(errno));
-		return NULL;
+		return FALSE;
 	}
 =

 	db =3D mmap(NULL, st.st_size, PROT_READ, MAP_SHARED, fd, 0);
@@ -433,15 +413,37 @@ GSList *mbpi_lookup(const char *mcc, const char *mnc,
 				g_file_error_from_errno(errno),
 				"mmap(%s) failed: %s", MBPI_DATABASE,
 				g_strerror(errno));
-		return NULL;
+		return FALSE;
 	}
 =

+	context =3D g_markup_parse_context_new(parser,
+						G_MARKUP_TREAT_CDATA_AS_TEXT,
+						userdata, NULL);
+
+	ret =3D g_markup_parse_context_parse(context, db, st.st_size, error);
+
+	if (ret =3D=3D TRUE)
+		g_markup_parse_context_end_parse(context, error);
+
+	munmap(db, st.st_size);
+	close(fd);
+	g_markup_parse_context_free(context);
+
+	return ret;
+}
+
+GSList *mbpi_lookup_apn(const char *mcc, const char *mnc,
+			gboolean allow_duplicates, GError **error)
+{
+	struct gsm_data gsm;
+	GSList *l;
+
 	memset(&gsm, 0, sizeof(gsm));
 	gsm.match_mcc =3D mcc;
 	gsm.match_mnc =3D mnc;
 	gsm.allow_duplicates =3D allow_duplicates;
 =

-	if (mbpi_parse(db, st.st_size, &gsm, error) =3D=3D FALSE) {
+	if (mbpi_parse(&toplevel_gsm_parser, &gsm, error) =3D=3D FALSE) {
 		for (l =3D gsm.apns; l; l =3D l->next)
 			mbpi_ap_free(l->data);
 =

@@ -449,8 +451,5 @@ GSList *mbpi_lookup(const char *mcc, const char *mnc,
 		gsm.apns =3D NULL;
 	}
 =

-	munmap(db, st.st_size);
-	close(fd);
-
 	return gsm.apns;
 }
diff --git a/plugins/mbpi.h b/plugins/mbpi.h
index 42e439b..6d34358 100644
--- a/plugins/mbpi.h
+++ b/plugins/mbpi.h
@@ -23,5 +23,5 @@ const char *mbpi_ap_type(enum ofono_gprs_context_type typ=
e);
 =

 void mbpi_ap_free(struct ofono_gprs_provision_data *data);
 =

-GSList *mbpi_lookup(const char *mcc, const char *mnc,
+GSList *mbpi_lookup_apn(const char *mcc, const char *mnc,
 			gboolean allow_duplicates, GError **error);
diff --git a/plugins/provision.c b/plugins/provision.c
index 06cba6f..99c299e 100644
--- a/plugins/provision.c
+++ b/plugins/provision.c
@@ -50,7 +50,7 @@ static int provision_get_settings(const char *mcc, const =
char *mnc,
 =

 	DBG("Provisioning for MCC %s, MNC %s, SPN '%s'", mcc, mnc, spn);
 =

-	apns =3D mbpi_lookup(mcc, mnc, FALSE, &error);
+	apns =3D mbpi_lookup_apn(mcc, mnc, FALSE, &error);
 	if (apns =3D=3D NULL) {
 		if (error !=3D NULL) {
 			ofono_error("%s", error->message);
diff --git a/tools/lookup-apn.c b/tools/lookup-apn.c
index b833b6c..884b32a 100644
--- a/tools/lookup-apn.c
+++ b/tools/lookup-apn.c
@@ -42,7 +42,7 @@ static void lookup_apn(const char *match_mcc, const char =
*match_mnc,
 =

 	g_print("Searching for info for network: %s%s\n", match_mcc, match_mnc);
 =

-	apns =3D mbpi_lookup(match_mcc, match_mnc, allow_duplicates, &error);
+	apns =3D mbpi_lookup_apn(match_mcc, match_mnc, allow_duplicates, &error);
 =

 	if (apns =3D=3D NULL) {
 		if (error !=3D NULL) {
-- =

1.7.1


--===============7693349606393961031==--

