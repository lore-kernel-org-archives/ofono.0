Content-Type: multipart/mixed; boundary="===============8853433927130568595=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH 1/2] types.h: auth_method and proto enumerations
Date: Tue, 09 Oct 2018 21:32:41 +0200
Message-ID: <20181009193242.17477-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8853433927130568595==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

ofono_gprs_proto and ofono_gprs_auth_method, and related length consts,
moved to types.h from gprs-context.h,
so that they can be shared also with lte core functions
---
 include/gprs-context.h | 21 ---------------------
 include/types.h        | 21 +++++++++++++++++++++
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/include/gprs-context.h b/include/gprs-context.h
index 8869c12e..965cefc2 100644
--- a/include/gprs-context.h
+++ b/include/gprs-context.h
@@ -31,21 +31,6 @@ extern "C" {
 struct ofono_gprs_context;
 struct ofono_modem;
 =

-/*
- * ETSI 123.003, Section 9.1:
- * the APN has, after encoding as defined in the paragraph below, a maximum
- * length of 100 octets
- */
-#define OFONO_GPRS_MAX_APN_LENGTH 100
-#define OFONO_GPRS_MAX_USERNAME_LENGTH 63
-#define OFONO_GPRS_MAX_PASSWORD_LENGTH 255
-
-enum ofono_gprs_proto {
-	OFONO_GPRS_PROTO_IP =3D 0,
-	OFONO_GPRS_PROTO_IPV6,
-	OFONO_GPRS_PROTO_IPV4V6,
-};
-
 enum ofono_gprs_context_type {
 	OFONO_GPRS_CONTEXT_TYPE_ANY =3D 0,
 	OFONO_GPRS_CONTEXT_TYPE_INTERNET,
@@ -54,12 +39,6 @@ enum ofono_gprs_context_type {
 	OFONO_GPRS_CONTEXT_TYPE_IMS,
 };
 =

-enum ofono_gprs_auth_method {
-	OFONO_GPRS_AUTH_METHOD_CHAP =3D 0,
-	OFONO_GPRS_AUTH_METHOD_PAP,
-	OFONO_GPRS_AUTH_METHOD_NONE,
-};
-
 struct ofono_gprs_primary_context {
 	unsigned int cid;
 	char apn[OFONO_GPRS_MAX_APN_LENGTH + 1];
diff --git a/include/types.h b/include/types.h
index 90d8c2c9..7e356185 100644
--- a/include/types.h
+++ b/include/types.h
@@ -122,6 +122,27 @@ struct ofono_uuid {
 	unsigned char uuid[OFONO_SHA1_UUID_LEN];
 };
 =

+/*
+ * ETSI 123.003, Section 9.1:
+ * the APN has, after encoding as defined in the paragraph below, a maximum
+ * length of 100 octets
+ */
+#define OFONO_GPRS_MAX_APN_LENGTH 100
+#define OFONO_GPRS_MAX_USERNAME_LENGTH 63
+#define OFONO_GPRS_MAX_PASSWORD_LENGTH 255
+
+enum ofono_gprs_proto {
+	OFONO_GPRS_PROTO_IP =3D 0,
+	OFONO_GPRS_PROTO_IPV6,
+	OFONO_GPRS_PROTO_IPV4V6,
+};
+
+enum ofono_gprs_auth_method {
+	OFONO_GPRS_AUTH_METHOD_CHAP =3D 0,
+	OFONO_GPRS_AUTH_METHOD_PAP,
+	OFONO_GPRS_AUTH_METHOD_NONE,
+};
+
 const char *ofono_uuid_to_str(const struct ofono_uuid *uuid);
 void ofono_call_init(struct ofono_call *call);
 =

-- =

2.17.1


--===============8853433927130568595==--

