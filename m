Content-Type: multipart/mixed; boundary="===============7232738536812874398=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 5/6] Return specific ofono errors according telephony errors
Date: Tue, 29 May 2012 18:38:36 +0200
Message-ID: <1338309517-14808-6-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1338309517-14808-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7232738536812874398==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/call-barring.c    |   11 +++++++----
 src/call-forwarding.c |    6 ++++--
 src/call-settings.c   |   18 ++++++++++--------
 3 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/src/call-barring.c b/src/call-barring.c
index ddf4c73..c983d90 100644
--- a/src/call-barring.c
+++ b/src/call-barring.c
@@ -35,6 +35,7 @@
 #include "ofono.h"
 =

 #include "common.h"
+#include "error-mapping.h"
 =

 #define CALL_BARRING_FLAG_CACHED 0x1
 #define NUM_OF_BARRINGS 5
@@ -323,9 +324,10 @@ static void cb_ss_set_lock_callback(const struct ofono=
_error *error,
 	struct ofono_call_barring *cb =3D data;
 =

 	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
-		DBG("Enabling/disabling Call Barring via SS failed");
+		DBG("Enabling/disabling Call Barring via SS failed with err:%s",
+			telephony_error_to_str(error));
 		__ofono_dbus_pending_reply(&cb->pending,
-					__ofono_error_failed(cb->pending));
+			telephony_error_to_ofono_err(error, cb->pending));
 		return;
 	}
 =

@@ -485,8 +487,9 @@ static void cb_set_passwd_callback(const struct ofono_e=
rror *error, void *data)
 	if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR)
 		reply =3D dbus_message_new_method_return(cb->pending);
 	else {
-		reply =3D __ofono_error_failed(cb->pending);
-		DBG("Changing Call Barring password via SS failed");
+		DBG("Changing Call Barring password via SS failed with err: %s",
+				telephony_error_to_str(error));
+		reply =3D telephony_error_to_ofono_err(error, cb->pending);
 	}
 =

 	__ofono_dbus_pending_reply(&cb->pending, reply);
diff --git a/src/call-forwarding.c b/src/call-forwarding.c
index 3d9c5c1..7525479 100644
--- a/src/call-forwarding.c
+++ b/src/call-forwarding.c
@@ -35,6 +35,7 @@
 =

 #include "common.h"
 #include "simutil.h"
+#include "error-mapping.h"
 =

 #define CALL_FORWARDING_FLAG_CACHED	0x1
 #define CALL_FORWARDING_FLAG_CPHS_CFF	0x2
@@ -1020,10 +1021,11 @@ static void cf_ss_control_callback(const struct ofo=
no_error *error, void *data)
 	struct ofono_call_forwarding *cf =3D data;
 =

 	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
-		DBG("Error occurred during cf ss control set/erasure");
 =

+		DBG("CF ss control set/erasure failed with error: %s",
+						telephony_error_to_str(error));
 		__ofono_dbus_pending_reply(&cf->pending,
-					__ofono_error_failed(cf->pending));
+		telephony_error_to_ofono_err(error, cf->pending));
 		g_free(cf->ss_req);
 		cf->ss_req =3D NULL;
 		return;
diff --git a/src/call-settings.c b/src/call-settings.c
index 6bc9658..e13e3de 100644
--- a/src/call-settings.c
+++ b/src/call-settings.c
@@ -34,6 +34,7 @@
 #include "ofono.h"
 =

 #include "common.h"
+#include "error-mapping.h"
 =

 #define CALL_SETTINGS_FLAG_CACHED 0x1
 =

@@ -477,9 +478,10 @@ static void cw_ss_set_callback(const struct ofono_erro=
r *error, void *data)
 	struct ofono_call_settings *cs =3D data;
 =

 	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
-		DBG("setting CW via SS failed");
+		DBG("setting CW via SS failed with error: %s",
+			telephony_error_to_str(error));
 		__ofono_dbus_pending_reply(&cs->pending,
-					__ofono_error_failed(cs->pending));
+			telephony_error_to_ofono_err(error, cs->pending));
 =

 		return;
 	}
@@ -614,10 +616,10 @@ static void clip_cnap_colp_colr_ss_query_cb(const str=
uct ofono_error *error,
 	const char *value;
 =

 	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
-		DBG("Error occurred during ss control query");
+		DBG("SS control query failed with error: %s",
+			telephony_error_to_str(error));
 		__ofono_dbus_pending_reply(&cs->pending,
-					__ofono_error_failed(cs->pending));
-
+			telephony_error_to_ofono_err(error, cs->pending));
 		return;
 	}
 =

@@ -772,10 +774,10 @@ static void clir_ss_set_callback(const struct ofono_e=
rror *error, void *data)
 	struct ofono_call_settings *cs =3D data;
 =

 	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
-		DBG("setting clir via SS failed");
+		DBG("setting clir via SS failed with error: %s",
+			telephony_error_to_str(error));
 		__ofono_dbus_pending_reply(&cs->pending,
-					__ofono_error_failed(cs->pending));
-
+			telephony_error_to_ofono_err(error, cs->pending));
 		return;
 	}
 =

-- =

1.7.9.5


--===============7232738536812874398==--

