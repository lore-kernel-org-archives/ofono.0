Content-Type: multipart/mixed; boundary="===============6516968511849195607=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: [PATCH 12/12] common: Use new voicecall enums
Date: Thu, 21 Jun 2018 20:21:01 +0300
Message-ID: <1529601661-4856-12-git-send-email-slava.monich@jolla.com>
In-Reply-To: <1529601661-4856-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6516968511849195607==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/common.c | 20 ++++++++++----------
 src/common.h | 33 +--------------------------------
 2 files changed, 11 insertions(+), 42 deletions(-)

diff --git a/src/common.c b/src/common.c
index 3ccaf7c..06b3521 100644
--- a/src/common.c
+++ b/src/common.c
@@ -740,26 +740,26 @@ const char *ofono_uuid_to_str(const struct ofono_uuid=
 *uuid)
 void ofono_call_init(struct ofono_call *call)
 {
 	memset(call, 0, sizeof(struct ofono_call));
-	call->cnap_validity =3D CNAP_VALIDITY_NOT_AVAILABLE;
-	call->clip_validity =3D CLIP_VALIDITY_NOT_AVAILABLE;
+	call->cnap_validity =3D OFONO_CNAP_VALIDITY_NOT_AVAILABLE;
+	call->clip_validity =3D OFONO_CLIP_VALIDITY_NOT_AVAILABLE;
 }
 =

-const char *call_status_to_string(enum call_status status)
+const char *call_status_to_string(enum ofono_call_status status)
 {
 	switch (status) {
-	case CALL_STATUS_ACTIVE:
+	case OFONO_CALL_STATUS_ACTIVE:
 		return "active";
-	case CALL_STATUS_HELD:
+	case OFONO_CALL_STATUS_HELD:
 		return "held";
-	case CALL_STATUS_DIALING:
+	case OFONO_CALL_STATUS_DIALING:
 		return "dialing";
-	case CALL_STATUS_ALERTING:
+	case OFONO_CALL_STATUS_ALERTING:
 		return "alerting";
-	case CALL_STATUS_INCOMING:
+	case OFONO_CALL_STATUS_INCOMING:
 		return "incoming";
-	case CALL_STATUS_WAITING:
+	case OFONO_CALL_STATUS_WAITING:
 		return "waiting";
-	case CALL_STATUS_DISCONNECTED:
+	case OFONO_CALL_STATUS_DISCONNECTED:
 		return "disconnected";
 	}
 =

diff --git a/src/common.h b/src/common.h
index 1b6b01d..5fc9617 100644
--- a/src/common.h
+++ b/src/common.h
@@ -53,13 +53,6 @@ enum operator_status {
 	OPERATOR_STATUS_FORBIDDEN =3D	3,
 };
 =

-/* 27.007 Section 7.6 */
-enum clip_validity {
-	CLIP_VALIDITY_VALID =3D		0,
-	CLIP_VALIDITY_WITHHELD =3D	1,
-	CLIP_VALIDITY_NOT_AVAILABLE =3D	2,
-};
-
 /* 27.007 Section 7.29 */
 enum packet_bearer {
 	PACKET_BEARER_NONE =3D		0,
@@ -72,30 +65,6 @@ enum packet_bearer {
 	PACKET_BEARER_EPS =3D		7,
 };
 =

-/* 27.007 Section 7.30 */
-enum cnap_validity {
-	CNAP_VALIDITY_VALID =3D		0,
-	CNAP_VALIDITY_WITHHELD =3D	1,
-	CNAP_VALIDITY_NOT_AVAILABLE =3D	2,
-};
-
-/* 27.007 Section 7.18 */
-enum call_status {
-	CALL_STATUS_ACTIVE =3D		0,
-	CALL_STATUS_HELD =3D		1,
-	CALL_STATUS_DIALING =3D		2,
-	CALL_STATUS_ALERTING =3D		3,
-	CALL_STATUS_INCOMING =3D		4,
-	CALL_STATUS_WAITING =3D		5,
-	CALL_STATUS_DISCONNECTED
-};
-
-/* 27.007 Section 7.18 */
-enum call_direction {
-	CALL_DIRECTION_MOBILE_ORIGINATED =3D	0,
-	CALL_DIRECTION_MOBILE_TERMINATED =3D	1,
-};
-
 /* 27.007 Section 7.11 */
 enum bearer_class {
 	BEARER_CLASS_VOICE =3D		1,
@@ -184,4 +153,4 @@ const char *registration_tech_to_string(int tech);
 const char *packet_bearer_to_string(int bearer);
 =

 gboolean is_valid_apn(const char *apn);
-const char *call_status_to_string(enum call_status status);
+const char *call_status_to_string(enum ofono_call_status status);
-- =

1.9.1


--===============6516968511849195607==--

