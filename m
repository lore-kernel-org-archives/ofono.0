Content-Type: multipart/mixed; boundary="===============8702501958001218854=="
MIME-Version: 1.0
From: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.com>
Subject: [PATCH 1/9] src: make bearer/operator enums public
Date: Tue, 13 Oct 2015 18:07:50 +0200
Message-ID: <1444752478-18198-2-git-send-email-alfonso.sanchez-beato@canonical.com>
In-Reply-To: <1444752478-18198-1-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8702501958001218854==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Tony Espy <espy@canonical.com>

Move enums for operator_status and packet_bearer to common.h to avoid
duplication in drivers.
---
 src/common.h  | 20 ++++++++++++++++++++
 src/gprs.c    | 12 ------------
 src/network.c |  8 --------
 3 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/src/common.h b/src/common.h
index eb006a7..ef4c58d 100644
--- a/src/common.h
+++ b/src/common.h
@@ -41,6 +41,14 @@ enum network_registration_status {
 	NETWORK_REGISTRATION_STATUS_ROAMING =3D		5,
 };
 =

+/* 27.007 Section 7.3 <stat> */
+enum operator_status {
+	OPERATOR_STATUS_UNKNOWN =3D	0,
+	OPERATOR_STATUS_AVAILABLE =3D	1,
+	OPERATOR_STATUS_CURRENT =3D	2,
+	OPERATOR_STATUS_FORBIDDEN =3D	3,
+};
+
 /* 27.007 Section 7.6 */
 enum clip_validity {
 	CLIP_VALIDITY_VALID =3D		0,
@@ -48,6 +56,18 @@ enum clip_validity {
 	CLIP_VALIDITY_NOT_AVAILABLE =3D	2,
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
 /* 27.007 Section 7.30 */
 enum cnap_validity {
 	CNAP_VALIDITY_VALID =3D		0,
diff --git a/src/gprs.c b/src/gprs.c
index ca24327..344915c 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -58,18 +58,6 @@
 #define MAX_CONTEXTS 256
 #define SUSPEND_TIMEOUT 8
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
diff --git a/src/network.c b/src/network.c
index d1bfca6..1dddcac 100644
--- a/src/network.c
+++ b/src/network.c
@@ -50,14 +50,6 @@ enum network_registration_mode {
 	NETWORK_REGISTRATION_MODE_AUTO_ONLY =3D	5, /* Out of range of 27.007 */
 };
 =

-/* 27.007 Section 7.3 <stat> */
-enum operator_status {
-	OPERATOR_STATUS_UNKNOWN =3D	0,
-	OPERATOR_STATUS_AVAILABLE =3D	1,
-	OPERATOR_STATUS_CURRENT =3D	2,
-	OPERATOR_STATUS_FORBIDDEN =3D	3,
-};
-
 struct ofono_netreg {
 	int status;
 	int location;
-- =

2.1.4


--===============8702501958001218854==--

