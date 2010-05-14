Content-Type: multipart/mixed; boundary="===============2047874244975064217=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH] Add telephony_str_to_error to decode error code
Date: Fri, 14 May 2010 11:27:22 +0800
Message-ID: <1273807642-18742-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2047874244975064217==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use to decode a final error string to error code.
---
 drivers/atmodem/atutil.c |    7 +++----
 src/common.c             |   25 +++++++++++++++++++++++++
 src/common.h             |    1 +
 3 files changed, 29 insertions(+), 4 deletions(-)

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
index 4eaff5e..f6c874a 100644
--- a/src/common.c
+++ b/src/common.c
@@ -26,6 +26,7 @@
 #define _GNU_SOURCE
 #include <string.h>
 #include <errno.h>
+#include <stdlib.h>
 =

 #include <glib.h>
 =

@@ -290,6 +291,30 @@ const char *telephony_error_to_str(const struct ofono_=
error *error)
 	return "Unknown error";
 }
 =

+void telephony_str_to_error(const char *str, struct ofono_error *error)
+{
+	const char *cme_prefix =3D "+CME ERROR: ";
+	const char *cms_prefix =3D "+CMS ERROR: ";
+	const char *ceer_prefix =3D "+CEER: ERROR ";
+
+	if (g_str_has_prefix(str, cme_prefix)) {
+		error->type =3D OFONO_ERROR_TYPE_CME;
+		str =3D str + strlen(cme_prefix);
+		error->error =3D atoi(str);
+	} else if (g_str_has_prefix(str, cms_prefix)) {
+		error->type =3D OFONO_ERROR_TYPE_CMS;
+		str =3D str + strlen(cms_prefix);
+		error->error =3D atoi(str);
+	} else if (g_str_has_prefix(str, ceer_prefix)) {
+		error->type =3D OFONO_ERROR_TYPE_CEER;
+		str =3D str + strlen(ceer_prefix);
+		error->error =3D atoi(str);
+	} else {
+		error->type =3D OFONO_ERROR_TYPE_FAILURE;
+		error->error =3D 0;
+	}
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


--===============2047874244975064217==--

