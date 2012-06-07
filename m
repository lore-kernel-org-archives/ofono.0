Content-Type: multipart/mixed; boundary="===============0761995884155321400=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv5 3/5] call-forwarding: End querying once CFU is active
Date: Thu, 07 Jun 2012 10:21:42 +0300
Message-ID: <1339053704-8749-4-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1339053704-8749-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0761995884155321400==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/call-forwarding.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/src/call-forwarding.c b/src/call-forwarding.c
index 343f958..3df009b 100644
--- a/src/call-forwarding.c
+++ b/src/call-forwarding.c
@@ -542,7 +542,9 @@ static void get_query_cf_callback(const struct ofono_er=
ror *error, int total,
 			cf->flags |=3D CALL_FORWARDING_FLAG_CACHED;
 	}
 =

-	if (cf->query_next =3D=3D CALL_FORWARDING_TYPE_NOT_REACHABLE) {
+	if (cf->query_next =3D=3D CALL_FORWARDING_TYPE_NOT_REACHABLE ||
+			(cf->query_next =3D=3D CALL_FORWARDING_TYPE_UNCONDITIONAL &&
+			is_cfu_enabled(cf))) {
 		__ofono_dbus_pending_reply(&cf->pending,
 				cf_get_properties_reply(cf->pending, cf));
 		return;
-- =

1.7.5.4


--===============0761995884155321400==--

