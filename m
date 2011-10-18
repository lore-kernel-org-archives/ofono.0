Content-Type: multipart/mixed; boundary="===============6758622519481622860=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv10 6/9] mbpi: Rename mbpi_provision_data_free()
Date: Tue, 18 Oct 2011 14:05:02 +0300
Message-ID: <1318935905-9087-7-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1318935905-9087-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6758622519481622860==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/mbpi.c      |    8 ++++----
 plugins/mbpi.h      |    2 +-
 plugins/provision.c |    2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/plugins/mbpi.c b/plugins/mbpi.c
index 7f533bc..5e42287 100644
--- a/plugins/mbpi.c
+++ b/plugins/mbpi.c
@@ -77,7 +77,7 @@ static GQuark mbpi_error_quark(void)
 	return g_quark_from_static_string("ofono-mbpi-error-quark");
 }
 =

-void mbpi_provision_data_free(struct ofono_gprs_provision_data *data)
+void mbpi_ap_free(struct ofono_gprs_provision_data *data)
 {
 	g_free(data->name);
 	g_free(data->apn);
@@ -191,7 +191,7 @@ static void apn_error(GMarkupParseContext *context, GEr=
ror *error,
 	 * be called.  So we always perform cleanup of the allocated
 	 * provision data
 	 */
-	mbpi_provision_data_free(userdata);
+	mbpi_ap_free(userdata);
 }
 =

 static const GMarkupParser apn_parser =3D {
@@ -332,7 +332,7 @@ static void gsm_end(GMarkupParseContext *context, const=
 gchar *element_name,
 						MBPI_ERROR_DUPLICATE,
 						"Duplicate context detected");
 =

-			mbpi_provision_data_free(apn);
+			mbpi_ap_free(apn);
 			return;
 		}
 	}
@@ -444,7 +444,7 @@ GSList *mbpi_lookup(const char *mcc, const char *mnc,
 =

 	if (mbpi_parse(db, st.st_size, &gsm, error) =3D=3D FALSE) {
 		for (l =3D gsm.apns; l; l =3D l->next)
-			mbpi_provision_data_free(l->data);
+			mbpi_ap_free(l->data);
 =

 		g_slist_free(gsm.apns);
 		gsm.apns =3D NULL;
diff --git a/plugins/mbpi.h b/plugins/mbpi.h
index 5a844d1..42e439b 100644
--- a/plugins/mbpi.h
+++ b/plugins/mbpi.h
@@ -21,7 +21,7 @@
 =

 const char *mbpi_ap_type(enum ofono_gprs_context_type type);
 =

-void mbpi_provision_data_free(struct ofono_gprs_provision_data *data);
+void mbpi_ap_free(struct ofono_gprs_provision_data *data);
 =

 GSList *mbpi_lookup(const char *mcc, const char *mnc,
 			gboolean allow_duplicates, GError **error);
diff --git a/plugins/provision.c b/plugins/provision.c
index ca59c6a..06cba6f 100644
--- a/plugins/provision.c
+++ b/plugins/provision.c
@@ -69,7 +69,7 @@ static int provision_get_settings(const char *mcc, const =
char *mnc,
 		ofono_error("Provisioning failed: %s", g_strerror(errno));
 =

 		for (l =3D apns; l; l =3D l->next)
-			mbpi_provision_data_free(l->data);
+			mbpi_ap_free(l->data);
 =

 		g_slist_free(apns);
 =

-- =

1.7.4.1


--===============6758622519481622860==--

