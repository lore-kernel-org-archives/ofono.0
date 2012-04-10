Content-Type: multipart/mixed; boundary="===============0439087857347494511=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv4 09/13] call-forwarding: End querying once cfu is active
Date: Tue, 10 Apr 2012 15:17:30 +0300
Message-ID: <1334060254-29547-10-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1334060254-29547-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0439087857347494511==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/call-forwarding.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/src/call-forwarding.c b/src/call-forwarding.c
index ba52609..786d163 100644
--- a/src/call-forwarding.c
+++ b/src/call-forwarding.c
@@ -533,12 +533,14 @@ static void get_query_cf_callback(const struct ofono_=
error *error, int total,
 		DBG("%s conditions:", cf_type_lut[cf->query_next]);
 =

 		cf_cond_list_print(l);
+	}
 =

-		if (cf->query_next =3D=3D CALL_FORWARDING_TYPE_NOT_REACHABLE)
+	if (cf->query_next =3D=3D CALL_FORWARDING_TYPE_NOT_REACHABLE ||
+			(cf->query_next =3D=3D CALL_FORWARDING_TYPE_UNCONDITIONAL &&
+			is_cfu_enabled(cf))) {
+		if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR)
 			cf->flags |=3D CALL_FORWARDING_FLAG_CACHED;
-	}
 =

-	if (cf->query_next =3D=3D CALL_FORWARDING_TYPE_NOT_REACHABLE) {
 		__ofono_dbus_pending_reply(&cf->pending,
 				cf_get_properties_reply(cf->pending, cf));
 		return;
-- =

1.7.5.4


--===============0439087857347494511==--

