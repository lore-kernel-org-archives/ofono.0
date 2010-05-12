Content-Type: multipart/mixed; boundary="===============0372224356786504405=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH v2 1/1] Add telephony_str_to_error to decode error code
Date: Wed, 12 May 2010 16:12:53 +0800
Message-ID: <1273651973-2461-2-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1273651973-2461-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0372224356786504405==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use to decode a final error string to error code.
---
 drivers/atmodem/atutil.c |    7 +++----
 src/common.c             |   41 +++++++++++++++++++++++++++++++++++++++++
 src/common.h             |    1 +
 3 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/drivers/atmodem/atutil.c b/drivers/atmodem/atutil.c
index 5a409b8..5b0f3fd 100644
--- a/drivers/atmodem/atutil.c
+++ b/drivers/atmodem/atutil.c
@@ -34,16 +34,15 @@
 =

 #include "atutil.h"
 #include "vendor.h"
+#include "common.h"
 =

 void decode_at_error(struct ofono_error *error, const char *final)
 {
 	if (!strcmp(final, "OK")) {
 		error->type =3D OFONO_ERROR_TYPE_NO_ERROR;
 		error->error =3D 0;
-	} else {
-		error->type =3D OFONO_ERROR_TYPE_FAILURE;
-		error->error =3D 0;
-	}
+	} else
+		telephony_str_to_error(final, error);
 }
 =

 gint at_util_call_compare_by_status(gconstpointer a, gconstpointer b)
diff --git a/src/common.c b/src/common.c
index 4eaff5e..b693dd9 100644
--- a/src/common.c
+++ b/src/common.c
@@ -290,6 +290,47 @@ const char *telephony_error_to_str(const struct ofono_=
error *error)
 	return "Unknown error";
 }
 =

+static gboolean search_entry(const char *str, struct error_entry *e,
+						int maxentries,
+						enum ofono_error_type type,
+						struct ofono_error *error)
+{
+	int i;
+
+	for (i =3D 0; i < maxentries; i++) {
+		if (!strcmp(e[i].str, str)) {
+			error->type =3D type;
+			error->error =3D e[i].error;
+			return TRUE;
+		}
+	}
+
+	return FALSE;
+}
+
+void telephony_str_to_error(const char *str, struct ofono_error *error)
+{
+	int maxentries;
+
+	maxentries =3D sizeof(cme_errors) / sizeof(struct error_entry);
+	if (search_entry(str, cme_errors, maxentries, OFONO_ERROR_TYPE_CME,
+					error))
+		return;
+
+	maxentries =3D sizeof(cms_errors) / sizeof(struct error_entry);
+	if (search_entry(str, cms_errors, maxentries, OFONO_ERROR_TYPE_CMS,
+					error))
+		return;
+
+	maxentries =3D sizeof(ceer_errors) / sizeof(struct error_entry);
+	if (search_entry(str, ceer_errors, maxentries, OFONO_ERROR_TYPE_CEER,
+					error))
+		return;
+
+	error->type =3D OFONO_ERROR_TYPE_FAILURE;
+	error->error =3D 0;
+}
+
 int mmi_service_code_to_bearer_class(int code)
 {
 	int cls =3D 0;
diff --git a/src/common.h b/src/common.h
index c43e46d..ec917d1 100644
--- a/src/common.h
+++ b/src/common.h
@@ -123,6 +123,7 @@ enum pin_type {
 };
 =

 const char *telephony_error_to_str(const struct ofono_error *error);
+void telephony_str_to_error(const char *str, struct ofono_error *error);
 =

 gboolean valid_phone_number_format(const char *number);
 const char *phone_number_to_string(const struct ofono_phone_number *ph);
-- =

1.6.3.3


--===============0372224356786504405==--

