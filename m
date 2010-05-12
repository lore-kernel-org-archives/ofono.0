Content-Type: multipart/mixed; boundary="===============4127034387302872353=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 1/1] Add telephony_str_to_error to decode error code
Date: Wed, 12 May 2010 15:17:35 +0800
Message-ID: <1273648655-22882-2-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1273648655-22882-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4127034387302872353==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use to decode a final error string to error code.
---
 src/common.c |   35 +++++++++++++++++++++++++++++++++++
 src/common.h |    1 +
 2 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/src/common.c b/src/common.c
index 4eaff5e..8fa8f8f 100644
--- a/src/common.c
+++ b/src/common.c
@@ -290,6 +290,41 @@ const char *telephony_error_to_str(const struct ofono_=
error *error)
 	return "Unknown error";
 }
 =

+static gboolean search_entry(const char *str, struct error_entry *e,
+						enum ofono_error_type type,
+						struct ofono_error *error)
+{
+	int maxentries;
+	int i;
+
+	maxentries =3D sizeof(e) / sizeof(struct error_entry);
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
+	if (search_entry(str, cme_errors, OFONO_ERROR_TYPE_CME, error))
+		return;
+
+	if (search_entry(str, cms_errors, OFONO_ERROR_TYPE_CMS, error))
+		return;
+
+	if (search_entry(str, ceer_errors, OFONO_ERROR_TYPE_CEER, error))
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


--===============4127034387302872353==--

