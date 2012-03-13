Content-Type: multipart/mixed; boundary="===============8041792117208699492=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv3 10/12] call-forwarding: Re-run ss path cfs queries on cfu
 changes
Date: Tue, 13 Mar 2012 15:46:31 +0200
Message-ID: <1331646393-5249-11-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1331646393-5249-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8041792117208699492==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Re-run conditional call forwarding queries on cfu removal
via supplementary services path and cache.
---
 src/call-forwarding.c |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/src/call-forwarding.c b/src/call-forwarding.c
index 7109c21..b168dc3 100644
--- a/src/call-forwarding.c
+++ b/src/call-forwarding.c
@@ -987,7 +987,8 @@ static void ss_set_query_cf_callback(const struct ofono=
_error *error, int total,
 =

 	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
 		ofono_error("Setting succeeded, but query failed");
-		cf->flags &=3D ~CALL_FORWARDING_FLAG_CACHED;
+		cf->flags &=3D ~(CALL_FORWARDING_FLAG_CACHE |
+				CALL_FORWARDING_FLAG_CACHED);
 		reply =3D __ofono_error_failed(cf->pending);
 		__ofono_dbus_pending_reply(&cf->pending, reply);
 		return;
@@ -1000,6 +1001,10 @@ static void ss_set_query_cf_callback(const struct of=
ono_error *error, int total,
 	cf->ss_req->cf_list[cf->query_next] =3D l;
 =

 	if (cf->query_next =3D=3D cf->query_end) {
+		if (cf->flags & CALL_FORWARDING_FLAG_CACHE) {
+			cf->flags &=3D ~CALL_FORWARDING_FLAG_CACHE;
+			cf->flags |=3D CALL_FORWARDING_FLAG_CACHED;
+		}
 		reply =3D cf_ss_control_reply(cf, cf->ss_req);
 		__ofono_dbus_pending_reply(&cf->pending, reply);
 		g_free(cf->ss_req);
@@ -1177,6 +1182,13 @@ static gboolean cf_ss_control(int type, const char *=
sc,
 	cf->pending =3D dbus_message_ref(msg);
 =

 	switch (cf->ss_req->cf_type) {
+	case CALL_FORWARDING_TYPE_UNCONDITIONAL:
+		cf->flags |=3D CALL_FORWARDING_FLAG_CACHE;
+		cf->query_next =3D CALL_FORWARDING_TYPE_UNCONDITIONAL;
+		cf->query_end =3D is_cfu_enabled(cf) ?
+					CALL_FORWARDING_TYPE_NOT_REACHABLE :
+					CALL_FORWARDING_TYPE_UNCONDITIONAL;
+		break;
 	case CALL_FORWARDING_TYPE_ALL:
 		cf->query_next =3D CALL_FORWARDING_TYPE_UNCONDITIONAL;
 		cf->query_end =3D CALL_FORWARDING_TYPE_NOT_REACHABLE;
-- =

1.7.5.4


--===============8041792117208699492==--

