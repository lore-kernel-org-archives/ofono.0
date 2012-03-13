Content-Type: multipart/mixed; boundary="===============9203110429848413222=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv3 09/12] call-forwarding: Cache cfs on CFU removal
Date: Tue, 13 Mar 2012 15:46:30 +0200
Message-ID: <1331646393-5249-10-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1331646393-5249-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9203110429848413222==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Since the re-querying is done, cache the call forwardings.
---
 src/call-forwarding.c |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/src/call-forwarding.c b/src/call-forwarding.c
index 575d96d..7109c21 100644
--- a/src/call-forwarding.c
+++ b/src/call-forwarding.c
@@ -38,6 +38,7 @@
 =

 #define CALL_FORWARDING_FLAG_CACHED	0x1
 #define CALL_FORWARDING_FLAG_CPHS_CFF	0x2
+#define CALL_FORWARDING_FLAG_CACHE	0x4
 =

 /* According to 27.007 Spec */
 #define DEFAULT_NO_REPLY_TIMEOUT 20
@@ -635,7 +636,8 @@ static void set_query_cf_callback(const struct ofono_er=
ror *error, int total,
 =

 	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
 		ofono_error("Setting succeeded, but query failed");
-		cf->flags &=3D ~CALL_FORWARDING_FLAG_CACHED;
+		cf->flags &=3D ~(CALL_FORWARDING_FLAG_CACHED |
+				CALL_FORWARDING_FLAG_CACHE);
 		__ofono_dbus_pending_reply(&cf->pending,
 					__ofono_error_failed(cf->pending));
 		return;
@@ -655,6 +657,11 @@ static void set_query_cf_callback(const struct ofono_e=
rror *error, int total,
 		cf->flags ^=3D CALL_FORWARDING_FLAG_CACHED;
 =

 	if (cf->query_next =3D=3D cf->query_end) {
+		if (cf->flags & CALL_FORWARDING_FLAG_CACHE) {
+			cf->flags &=3D ~CALL_FORWARDING_FLAG_CACHE;
+			cf->flags |=3D CALL_FORWARDING_FLAG_CACHED;
+		}
+
 		__ofono_dbus_pending_reply(&cf->pending,
 				dbus_message_new_method_return(cf->pending));
 		return;
@@ -701,12 +708,13 @@ static DBusMessage *set_property_request(struct ofono=
_call_forwarding *cf,
 	cf->query_next =3D type;
 =

 	if (type =3D=3D CALL_FORWARDING_TYPE_UNCONDITIONAL &&
-		ph->number[0] =3D=3D '\0' && is_cfu_enabled(cf))
+		ph->number[0] =3D=3D '\0' && is_cfu_enabled(cf)) {
 		/*
 		 * CFU is removed, conditionals need to be updated
 		 */
 		cf->query_end =3D CALL_FORWARDING_TYPE_NOT_REACHABLE;
-	else
+		cf->flags |=3D CALL_FORWARDING_FLAG_CACHE;
+	} else
 		cf->query_end =3D type;
 =

 	DBG("Farming off request, will be erasure: %d", ph->number[0] =3D=3D '\0'=
);
-- =

1.7.5.4


--===============9203110429848413222==--

