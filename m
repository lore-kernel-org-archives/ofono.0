Content-Type: multipart/mixed; boundary="===============5802982434015943301=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH v2 2/2] SS: Return specific ofono errors after SS failure
Date: Wed, 30 May 2012 15:53:10 +0200
Message-ID: <1338385990-27526-2-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1338385990-27526-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5802982434015943301==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/call-barring.c    |   10 ++++++----
 src/call-forwarding.c |    5 +++--
 src/call-settings.c   |   15 +++++++++------
 3 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/src/call-barring.c b/src/call-barring.c
index ddf4c73..53847fb 100644
--- a/src/call-barring.c
+++ b/src/call-barring.c
@@ -323,9 +323,10 @@ static void cb_ss_set_lock_callback(const struct ofono=
_error *error,
 	struct ofono_call_barring *cb =3D data;
 =

 	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
-		DBG("Enabling/disabling Call Barring via SS failed");
+		DBG("Enabling/disabling Call Barring via SS failed with err:%s",
+			telephony_error_to_str(error));
 		__ofono_dbus_pending_reply(&cb->pending,
-					__ofono_error_failed(cb->pending));
+			__ofono_error_from_error(error, cb->pending));
 		return;
 	}
 =

@@ -485,8 +486,9 @@ static void cb_set_passwd_callback(const struct ofono_e=
rror *error, void *data)
 	if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR)
 		reply =3D dbus_message_new_method_return(cb->pending);
 	else {
-		reply =3D __ofono_error_failed(cb->pending);
-		DBG("Changing Call Barring password via SS failed");
+		DBG("Changing Call Barring password via SS failed with err: %s",
+				telephony_error_to_str(error));
+		reply =3D __ofono_error_from_error(error, cb->pending);
 	}
 =

 	__ofono_dbus_pending_reply(&cb->pending, reply);
diff --git a/src/call-forwarding.c b/src/call-forwarding.c
index 3d9c5c1..5acbd67 100644
--- a/src/call-forwarding.c
+++ b/src/call-forwarding.c
@@ -1020,10 +1020,11 @@ static void cf_ss_control_callback(const struct ofo=
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
+				__ofono_error_from_error(error, cf->pending));
 		g_free(cf->ss_req);
 		cf->ss_req =3D NULL;
 		return;
diff --git a/src/call-settings.c b/src/call-settings.c
index 6bc9658..4bfb561 100644
--- a/src/call-settings.c
+++ b/src/call-settings.c
@@ -477,9 +477,10 @@ static void cw_ss_set_callback(const struct ofono_erro=
r *error, void *data)
 	struct ofono_call_settings *cs =3D data;
 =

 	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
-		DBG("setting CW via SS failed");
+		DBG("setting CW via SS failed with error: %s",
+			telephony_error_to_str(error));
 		__ofono_dbus_pending_reply(&cs->pending,
-					__ofono_error_failed(cs->pending));
+			__ofono_error_from_error(error, cs->pending));
 =

 		return;
 	}
@@ -614,9 +615,10 @@ static void clip_cnap_colp_colr_ss_query_cb(const stru=
ct ofono_error *error,
 	const char *value;
 =

 	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
-		DBG("Error occurred during ss control query");
+		DBG("SS control query failed with error: %s",
+			telephony_error_to_str(error));
 		__ofono_dbus_pending_reply(&cs->pending,
-					__ofono_error_failed(cs->pending));
+			__ofono_error_from_error(error, cs->pending));
 =

 		return;
 	}
@@ -772,9 +774,10 @@ static void clir_ss_set_callback(const struct ofono_er=
ror *error, void *data)
 	struct ofono_call_settings *cs =3D data;
 =

 	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
-		DBG("setting clir via SS failed");
+		DBG("setting clir via SS failed with error: %s",
+			telephony_error_to_str(error));
 		__ofono_dbus_pending_reply(&cs->pending,
-					__ofono_error_failed(cs->pending));
+			__ofono_error_from_error(error, cs->pending));
 =

 		return;
 	}
-- =

1.7.9.5


--===============5802982434015943301==--

