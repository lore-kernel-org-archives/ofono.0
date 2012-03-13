Content-Type: multipart/mixed; boundary="===============9120601590415234439=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv3 11/12] call-forwarding: Cache cfs on all/all conditional
 removal
Date: Tue, 13 Mar 2012 15:46:32 +0200
Message-ID: <1331646393-5249-12-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1331646393-5249-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9120601590415234439==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Re-run conditional call forwarding queries on cfu removal
via supplementary services path and cache.
---
 src/call-forwarding.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/src/call-forwarding.c b/src/call-forwarding.c
index b168dc3..edfb87a 100644
--- a/src/call-forwarding.c
+++ b/src/call-forwarding.c
@@ -1181,7 +1181,7 @@ static gboolean cf_ss_control(int type, const char *s=
c,
 =

 	cf->pending =3D dbus_message_ref(msg);
 =

-	switch (cf->ss_req->cf_type) {
+	switch (cf_type) {
 	case CALL_FORWARDING_TYPE_UNCONDITIONAL:
 		cf->flags |=3D CALL_FORWARDING_FLAG_CACHE;
 		cf->query_next =3D CALL_FORWARDING_TYPE_UNCONDITIONAL;
@@ -1190,11 +1190,11 @@ static gboolean cf_ss_control(int type, const char =
*sc,
 					CALL_FORWARDING_TYPE_UNCONDITIONAL;
 		break;
 	case CALL_FORWARDING_TYPE_ALL:
-		cf->query_next =3D CALL_FORWARDING_TYPE_UNCONDITIONAL;
-		cf->query_end =3D CALL_FORWARDING_TYPE_NOT_REACHABLE;
-		break;
 	case CALL_FORWARDING_TYPE_ALL_CONDITIONAL:
-		cf->query_next =3D CALL_FORWARDING_TYPE_BUSY;
+		cf->flags |=3D CALL_FORWARDING_FLAG_CACHE;
+		cf->query_next =3D (cf_type =3D=3D CALL_FORWARDING_TYPE_ALL) ?
+					CALL_FORWARDING_TYPE_UNCONDITIONAL :
+					CALL_FORWARDING_TYPE_BUSY;
 		cf->query_end =3D CALL_FORWARDING_TYPE_NOT_REACHABLE;
 		break;
 	default:
-- =

1.7.5.4


--===============9120601590415234439==--

