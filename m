Content-Type: multipart/mixed; boundary="===============2135426750554479653=="
MIME-Version: 1.0
From: Vijay Nayani <vijay.nayani@elektrobit.com>
Subject: [RFC PATCH 03/20] gprs: move bearer_to_string to common file
Date: Mon, 11 Apr 2011 13:20:01 +0300
Message-ID: <1302517218-2147-4-git-send-email-vijay.nayani@elektrobit.com>
In-Reply-To: <1302517218-2147-1-git-send-email-vijay.nayani@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2135426750554479653==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Inorder for gprs/context and packet service/context
to coexist packet_bearer_to_string is moved to
common source file.
---
 src/common.c |   23 +++++++++++++++++++++++
 src/common.h |   12 ++++++++++++
 src/gprs.c   |   35 -----------------------------------
 3 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/src/common.c b/src/common.c
index e65a677..45866c0 100644
--- a/src/common.c
+++ b/src/common.c
@@ -696,6 +696,29 @@ const char *registration_tech_to_string(int tech)
 	}
 }
 =

+const char *packet_bearer_to_string(int bearer)
+{
+	switch (bearer) {
+	case PACKET_BEARER_NONE:
+		return "none";
+	case PACKET_BEARER_GPRS:
+		return "gprs";
+	case PACKET_BEARER_EGPRS:
+		return "edge";
+	case PACKET_BEARER_UMTS:
+		return "umts";
+	case PACKET_BEARER_HSUPA:
+		return "hsupa";
+	case PACKET_BEARER_HSDPA:
+		return "hsdpa";
+	case PACKET_BEARER_HSUPA_HSDPA:
+		return "hspa";
+	case PACKET_BEARER_EPS:
+		return "lte";
+	}
+	return "";
+}
+
 gboolean is_valid_apn(const char *apn)
 {
 	int i;
diff --git a/src/common.h b/src/common.h
index 6dc7bff..5fc3ead 100644
--- a/src/common.h
+++ b/src/common.h
@@ -128,6 +128,18 @@ enum context_status {
 	CONTEXT_STATUS_ACTIVATED =3D 1,
 };
 =

+/* 27.007 Section 7.29 */
+enum packet_bearer {
+	PACKET_BEARER_NONE =3D		0,
+	PACKET_BEARER_GPRS =3D		1,
+	PACKET_BEARER_EGPRS =3D		2,
+	PACKET_BEARER_UMTS =3D		3,
+	PACKET_BEARER_HSUPA =3D		4,
+	PACKET_BEARER_HSDPA =3D		5,
+	PACKET_BEARER_HSUPA_HSDPA =3D	6,
+	PACKET_BEARER_EPS =3D		7,
+};
+
 const char *telephony_error_to_str(const struct ofono_error *error);
 =

 gboolean valid_number_format(const char *number, int length);
diff --git a/src/gprs.c b/src/gprs.c
index deffeb8..59a5a70 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -60,18 +60,6 @@
 static GSList *g_drivers =3D NULL;
 static GSList *g_context_drivers =3D NULL;
 =

-/* 27.007 Section 7.29 */
-enum packet_bearer {
-	PACKET_BEARER_NONE =3D		0,
-	PACKET_BEARER_GPRS =3D		1,
-	PACKET_BEARER_EGPRS =3D		2,
-	PACKET_BEARER_UMTS =3D		3,
-	PACKET_BEARER_HSUPA =3D		4,
-	PACKET_BEARER_HSDPA =3D		5,
-	PACKET_BEARER_HSUPA_HSDPA =3D	6,
-	PACKET_BEARER_EPS =3D		7,
-};
-
 struct ofono_gprs {
 	GSList *contexts;
 	ofono_bool_t attached;
@@ -152,29 +140,6 @@ struct pri_context {
 static void gprs_netreg_update(struct ofono_gprs *gprs);
 static void gprs_deactivate_next(struct ofono_gprs *gprs);
 =

-const char *packet_bearer_to_string(int bearer)
-{
-	switch (bearer) {
-	case PACKET_BEARER_NONE:
-		return "none";
-	case PACKET_BEARER_GPRS:
-		return "gprs";
-	case PACKET_BEARER_EGPRS:
-		return "edge";
-	case PACKET_BEARER_UMTS:
-		return "umts";
-	case PACKET_BEARER_HSUPA:
-		return "hsupa";
-	case PACKET_BEARER_HSDPA:
-		return "hsdpa";
-	case PACKET_BEARER_HSUPA_HSDPA:
-		return "hspa";
-	case PACKET_BEARER_EPS:
-		return "lte";
-	}
-	return "";
-}
-
 static const char *gprs_context_default_name(enum ofono_gprs_context_type =
type)
 {
 	switch (type) {
-- =

1.7.0.4


--===============2135426750554479653==--

