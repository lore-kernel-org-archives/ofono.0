Content-Type: multipart/mixed; boundary="===============8765928886369518645=="
MIME-Version: 1.0
From: Alexander Couzens <lynxis@fe80.eu>
Subject: [PATCH][v2 1/2] voicecall,
 common: move call_status_to_string() to common
Date: Fri, 08 Sep 2017 00:27:32 +0200
Message-ID: <20170907222733.26345-1-lynxis@fe80.eu>
In-Reply-To: <1578d8ed-2356-21fd-e489-e18e5098c8fe@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8765928886369518645==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

call_status_to_string() is useful for debug output.
Change signature to contain enum call_status
Replace default case to get compiler warning when new enums added
---
 src/common.c    | 22 ++++++++++++++++++++++
 src/common.h    |  1 +
 src/voicecall.c | 20 --------------------
 3 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/src/common.c b/src/common.c
index ce07b934970d..d44b001868ca 100644
--- a/src/common.c
+++ b/src/common.c
@@ -743,3 +743,25 @@ void ofono_call_init(struct ofono_call *call)
 	call->cnap_validity =3D CNAP_VALIDITY_NOT_AVAILABLE;
 	call->clip_validity =3D CLIP_VALIDITY_NOT_AVAILABLE;
 }
+
+const char *call_status_to_string(enum call_status status)
+{
+	switch (status) {
+	case CALL_STATUS_ACTIVE:
+		return "active";
+	case CALL_STATUS_HELD:
+		return "held";
+	case CALL_STATUS_DIALING:
+		return "dialing";
+	case CALL_STATUS_ALERTING:
+		return "alerting";
+	case CALL_STATUS_INCOMING:
+		return "incoming";
+	case CALL_STATUS_WAITING:
+		return "waiting";
+	case CALL_STATUS_DISCONNECTED:
+		return "disconnected";
+	}
+
+	return "unknown";
+}
diff --git a/src/common.h b/src/common.h
index 05f2a851bd57..1b6b01d457a5 100644
--- a/src/common.h
+++ b/src/common.h
@@ -184,3 +184,4 @@ const char *registration_tech_to_string(int tech);
 const char *packet_bearer_to_string(int bearer);
 =

 gboolean is_valid_apn(const char *apn);
+const char *call_status_to_string(enum call_status status);
diff --git a/src/voicecall.c b/src/voicecall.c
index 6907b5025cb4..408c72162ca7 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -174,26 +174,6 @@ static const char *disconnect_reason_to_string(enum of=
ono_disconnect_reason r)
 	}
 }
 =

-static const char *call_status_to_string(int status)
-{
-	switch (status) {
-	case CALL_STATUS_ACTIVE:
-		return "active";
-	case CALL_STATUS_HELD:
-		return "held";
-	case CALL_STATUS_DIALING:
-		return "dialing";
-	case CALL_STATUS_ALERTING:
-		return "alerting";
-	case CALL_STATUS_INCOMING:
-		return "incoming";
-	case CALL_STATUS_WAITING:
-		return "waiting";
-	default:
-		return "disconnected";
-	}
-}
-
 static const char *phone_and_clip_to_string(const struct ofono_phone_numbe=
r *n,
 						int clip_validity)
 {
-- =

2.14.1


--===============8765928886369518645==--

