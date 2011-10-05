Content-Type: multipart/mixed; boundary="===============4672891441200732934=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv9 10/16] mbpi: Add mbpi_ap_type()
Date: Wed, 05 Oct 2011 16:18:33 +0300
Message-ID: <1317820719-23609-11-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1317820719-23609-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4672891441200732934==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/mbpi.c      |   15 +++++++++++++++
 plugins/mbpi.h      |    2 ++
 plugins/provision.c |    1 +
 3 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/plugins/mbpi.c b/plugins/mbpi.c
index e4496c9..3ab60c4 100644
--- a/plugins/mbpi.c
+++ b/plugins/mbpi.c
@@ -44,6 +44,8 @@
 =

 #include "mbpi.h"
 =

+#define _(x) case x: return (#x)
+
 enum MBPI_ERROR {
 	MBPI_ERROR_DUPLICATE,
 };
@@ -56,6 +58,19 @@ struct gsm_data {
 	gboolean allow_duplicates;
 };
 =

+const char *mbpi_ap_type(enum ofono_gprs_context_type type)
+{
+	switch (type) {
+		_(OFONO_GPRS_CONTEXT_TYPE_ANY);
+		_(OFONO_GPRS_CONTEXT_TYPE_INTERNET);
+		_(OFONO_GPRS_CONTEXT_TYPE_MMS);
+		_(OFONO_GPRS_CONTEXT_TYPE_WAP);
+		_(OFONO_GPRS_CONTEXT_TYPE_IMS);
+	}
+
+	return "OFONO_GPRS_CONTEXT_TYPE_<UNKNOWN>";
+}
+
 static GQuark mbpi_error_quark(void)
 {
 	return g_quark_from_static_string("ofono-mbpi-error-quark");
diff --git a/plugins/mbpi.h b/plugins/mbpi.h
index fc9f738..5a844d1 100644
--- a/plugins/mbpi.h
+++ b/plugins/mbpi.h
@@ -19,6 +19,8 @@
  *
  */
 =

+const char *mbpi_ap_type(enum ofono_gprs_context_type type);
+
 void mbpi_provision_data_free(struct ofono_gprs_provision_data *data);
 =

 GSList *mbpi_lookup(const char *mcc, const char *mnc,
diff --git a/plugins/provision.c b/plugins/provision.c
index 3c74472..c099891 100644
--- a/plugins/provision.c
+++ b/plugins/provision.c
@@ -84,6 +84,7 @@ static int provision_get_settings(const char *mcc, const =
char *mnc,
 =

 		DBG("Name: '%s'", ap->name);
 		DBG("APN: '%s'", ap->apn);
+		DBG("Type: %s", mbpi_ap_type(ap->type));
 		DBG("Username: '%s'", ap->username);
 		DBG("Password: '%s'", ap->password);
 =

-- =

1.7.4.1


--===============4672891441200732934==--

