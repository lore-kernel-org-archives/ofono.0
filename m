Content-Type: multipart/mixed; boundary="===============7454268262083695738=="
MIME-Version: 1.0
From: Alexander Couzens <lynxis@fe80.eu>
Subject: [PATCH 1/6] voicecall,
 common: promote call_status_to_string() to be public
Date: Thu, 07 Sep 2017 22:22:55 +0200
Message-ID: <20170907202300.23952-1-lynxis@fe80.eu>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7454268262083695738==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

call_status_to_string() is useful for debug output.
Change signature to contain enum call_status
Replace default case to get compiler warning when new enums added
---
 src/common.c    | 21 +++++++++++++++++++++
 src/common.h    |  1 +
 src/voicecall.c | 24 ++----------------------
 3 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/src/common.c b/src/common.c
index ce07b934970d..d99647998a6f 100644
--- a/src/common.c
+++ b/src/common.c
@@ -743,3 +743,24 @@ void ofono_call_init(struct ofono_call *call)
 	call->cnap_validity =3D CNAP_VALIDITY_NOT_AVAILABLE;
 	call->clip_validity =3D CLIP_VALIDITY_NOT_AVAILABLE;
 }
+
+const char *ofono_call_status_to_string(enum call_status status)
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
+	return "unknown";
+}
diff --git a/src/common.h b/src/common.h
index 05f2a851bd57..de72bd418792 100644
--- a/src/common.h
+++ b/src/common.h
@@ -184,3 +184,4 @@ const char *registration_tech_to_string(int tech);
 const char *packet_bearer_to_string(int bearer);
 =

 gboolean is_valid_apn(const char *apn);
+const char *ofono_call_status_to_string(enum call_status status);
diff --git a/src/voicecall.c b/src/voicecall.c
index 6907b5025cb4..c99f11fabc01 100644
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
@@ -421,7 +401,7 @@ static void append_voicecall_properties(struct voicecal=
l *v,
 	ofono_bool_t mpty;
 	dbus_bool_t emergency_call;
 =

-	status =3D call_status_to_string(call->status);
+	status =3D ofono_call_status_to_string(call->status);
 =

 	ofono_dbus_dict_append(dict, "State", DBUS_TYPE_STRING, &status);
 =

@@ -920,7 +900,7 @@ static void voicecall_set_call_status(struct voicecall =
*call, int status)
 =

 	call->call->status =3D status;
 =

-	status_str =3D call_status_to_string(status);
+	status_str =3D ofono_call_status_to_string(status);
 	path =3D voicecall_build_path(call->vc, call->call);
 =

 	ofono_dbus_signal_property_changed(conn, path,
-- =

2.14.1


--===============7454268262083695738==--

