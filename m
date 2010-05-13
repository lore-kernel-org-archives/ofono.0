Content-Type: multipart/mixed; boundary="===============5467590480015278421=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua2000@gmail.com>
Subject: [PATCH v3 1/1] Add telephony_str_to_error to decode error code
Date: Thu, 13 May 2010 13:02:04 +0000
Message-ID: <1273755711-12358-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5467590480015278421==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use to decode a final error string to error code.
---
 drivers/atmodem/atutil.c |    7 ++---
 src/common.c             |   48 ++++++++++++++++++++++++++++++++++++++++++=
++++
 src/common.h             |    1 +
 3 files changed, 52 insertions(+), 4 deletions(-)

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
index 4eaff5e..f140223 100644
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

@@ -290,6 +291,53 @@ const char *telephony_error_to_str(const struct ofono_=
error *error)
 	return "Unknown error";
 }
 =

+static int telephony_error_code(const char *str, struct error_entry *e,
+						int maxentries)
+{
+	int error_code, i;
+
+	/* To match error like '+CMS ERROR: 500' */
+	error_code =3D atoi(str);
+	if (error_code)
+		return error_code;
+
+	for (i =3D 0; i < maxentries; i++) {
+		if (!strcasecmp(e[i].str, str))
+			return e[i].error;
+	}
+
+	return 0;
+}
+
+void telephony_str_to_error(const char *str, struct ofono_error *error)
+{
+	int maxentries;
+	struct error_entry *e;
+
+	if (g_str_has_prefix(str, "+CME ERROR: ")) {
+		error->type =3D OFONO_ERROR_TYPE_CME;
+		str =3D str + strlen("+CME ERROR: ");
+		maxentries =3D sizeof(cme_errors) / sizeof(struct error_entry);
+		e =3D cme_errors;
+	} else if (g_str_has_prefix(str, "+CMS ERROR: ")) {
+		error->type =3D OFONO_ERROR_TYPE_CMS;
+		str =3D str + strlen("+CMS ERROR: ");
+		maxentries =3D sizeof(cms_errors) / sizeof(struct error_entry);
+		e =3D cms_errors;
+	} else if (g_str_has_prefix(str, "+CEER: ERROR ")) {
+		error->type =3D OFONO_ERROR_TYPE_CEER;
+		str =3D str + strlen("+CEER: ERROR ");
+		maxentries =3D sizeof(ceer_errors) / sizeof(struct error_entry);
+		e =3D ceer_errors;
+	} else {
+		error->type =3D OFONO_ERROR_TYPE_FAILURE;
+		error->error =3D 0;
+		return;
+	}
+
+	error->error =3D telephony_error_code(str, e, maxentries);
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


--===============5467590480015278421==--

