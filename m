Content-Type: multipart/mixed; boundary="===============6563324144622728152=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH 2/2] common: proto and auth_method conversion functions
Date: Tue, 09 Oct 2018 21:32:42 +0200
Message-ID: <20181009193242.17477-2-gciofono@gmail.com>
In-Reply-To: <20181009193242.17477-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6563324144622728152==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

the following functions:
	gprs_proto_to_string
	gprs_proto_from_string
	gprs_auth_method_to_string
	gprs_auth_method_from_string

are moved from gprs.c to common.c, with related declaration in common.h
so that they can also be accessed from lte core functions
---
 src/common.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/common.h |  8 +++++++
 src/gprs.c   | 62 ----------------------------------------------------
 3 files changed, 70 insertions(+), 62 deletions(-)

diff --git a/src/common.c b/src/common.c
index 0db412a6..0328a98a 100644
--- a/src/common.c
+++ b/src/common.c
@@ -769,3 +769,65 @@ const char *call_status_to_string(enum call_status sta=
tus)
 =

 	return "unknown";
 }
+
+const char *gprs_proto_to_string(enum ofono_gprs_proto proto)
+{
+	switch (proto) {
+	case OFONO_GPRS_PROTO_IP:
+		return "ip";
+	case OFONO_GPRS_PROTO_IPV6:
+		return "ipv6";
+	case OFONO_GPRS_PROTO_IPV4V6:
+		return "dual";
+	};
+
+	return NULL;
+}
+
+gboolean gprs_proto_from_string(const char *str, enum ofono_gprs_proto *pr=
oto)
+{
+	if (g_str_equal(str, "ip")) {
+		*proto =3D OFONO_GPRS_PROTO_IP;
+		return TRUE;
+	} else if (g_str_equal(str, "ipv6")) {
+		*proto =3D OFONO_GPRS_PROTO_IPV6;
+		return TRUE;
+	} else if (g_str_equal(str, "dual")) {
+		*proto =3D OFONO_GPRS_PROTO_IPV4V6;
+		return TRUE;
+	}
+
+	return FALSE;
+}
+
+const char *gprs_auth_method_to_string(enum ofono_gprs_auth_method auth)
+{
+	switch (auth) {
+	case OFONO_GPRS_AUTH_METHOD_CHAP:
+		return "chap";
+	case OFONO_GPRS_AUTH_METHOD_PAP:
+		return "pap";
+	case OFONO_GPRS_AUTH_METHOD_NONE:
+		return "none";
+	};
+
+	return NULL;
+}
+
+gboolean gprs_auth_method_from_string(const char *str,
+					enum ofono_gprs_auth_method *auth)
+{
+	if (g_str_equal(str, "chap")) {
+		*auth =3D OFONO_GPRS_AUTH_METHOD_CHAP;
+		return TRUE;
+	} else if (g_str_equal(str, "pap")) {
+		*auth =3D OFONO_GPRS_AUTH_METHOD_PAP;
+		return TRUE;
+	} else if (g_str_equal(str, "none")) {
+		*auth =3D OFONO_GPRS_AUTH_METHOD_NONE;
+		return TRUE;
+	}
+
+	return FALSE;
+}
+
diff --git a/src/common.h b/src/common.h
index 923470f5..79c05fc4 100644
--- a/src/common.h
+++ b/src/common.h
@@ -187,3 +187,11 @@ const char *packet_bearer_to_string(int bearer);
 =

 gboolean is_valid_apn(const char *apn);
 const char *call_status_to_string(enum call_status status);
+
+const char *gprs_proto_to_string(enum ofono_gprs_proto proto);
+gboolean gprs_proto_from_string(const char *str, enum ofono_gprs_proto *pr=
oto);
+
+const char *gprs_auth_method_to_string(enum ofono_gprs_auth_method auth);
+gboolean gprs_auth_method_from_string(const char *str,
+					enum ofono_gprs_auth_method *auth);
+
diff --git a/src/gprs.c b/src/gprs.c
index 9f87cc98..edd17f23 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -223,68 +223,6 @@ static gboolean gprs_context_string_to_type(const char=
 *str,
 	return FALSE;
 }
 =

-static const char *gprs_proto_to_string(enum ofono_gprs_proto proto)
-{
-	switch (proto) {
-	case OFONO_GPRS_PROTO_IP:
-		return "ip";
-	case OFONO_GPRS_PROTO_IPV6:
-		return "ipv6";
-	case OFONO_GPRS_PROTO_IPV4V6:
-		return "dual";
-	};
-
-	return NULL;
-}
-
-static gboolean gprs_proto_from_string(const char *str,
-					enum ofono_gprs_proto *proto)
-{
-	if (g_str_equal(str, "ip")) {
-		*proto =3D OFONO_GPRS_PROTO_IP;
-		return TRUE;
-	} else if (g_str_equal(str, "ipv6")) {
-		*proto =3D OFONO_GPRS_PROTO_IPV6;
-		return TRUE;
-	} else if (g_str_equal(str, "dual")) {
-		*proto =3D OFONO_GPRS_PROTO_IPV4V6;
-		return TRUE;
-	}
-
-	return FALSE;
-}
-
-static const char *gprs_auth_method_to_string(enum ofono_gprs_auth_method =
auth)
-{
-	switch (auth) {
-	case OFONO_GPRS_AUTH_METHOD_CHAP:
-		return "chap";
-	case OFONO_GPRS_AUTH_METHOD_PAP:
-		return "pap";
-	case OFONO_GPRS_AUTH_METHOD_NONE:
-		return "none";
-	};
-
-	return NULL;
-}
-
-static gboolean gprs_auth_method_from_string(const char *str,
-					enum ofono_gprs_auth_method *auth)
-{
-	if (g_str_equal(str, "chap")) {
-		*auth =3D OFONO_GPRS_AUTH_METHOD_CHAP;
-		return TRUE;
-	} else if (g_str_equal(str, "pap")) {
-		*auth =3D OFONO_GPRS_AUTH_METHOD_PAP;
-		return TRUE;
-	} else if (g_str_equal(str, "none")) {
-		*auth =3D OFONO_GPRS_AUTH_METHOD_NONE;
-		return TRUE;
-	}
-
-	return FALSE;
-}
-
 static unsigned int gprs_cid_alloc(struct ofono_gprs *gprs)
 {
 	return idmap_alloc(gprs->cid_map);
-- =

2.17.1


--===============6563324144622728152==--

