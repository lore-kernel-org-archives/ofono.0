Content-Type: multipart/mixed; boundary="===============2024213541770020989=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv2 6/8] call-forwarding: Don't run conditional queries if cfu
 is active
Date: Mon, 06 Feb 2012 14:33:59 +0200
Message-ID: <1328531641-10612-7-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1328531641-10612-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2024213541770020989==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/call-forwarding.c |   18 +++++++++++-------
 1 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/src/call-forwarding.c b/src/call-forwarding.c
index 7b086e0..2813005 100644
--- a/src/call-forwarding.c
+++ b/src/call-forwarding.c
@@ -584,20 +584,24 @@ static void get_query_cf_callback(const struct ofono_=
error *error, int total,
 	struct ofono_call_forwarding *cf =3D data;
 =

 	if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR) {
-		GSList *l;
-		l =3D cf_cond_list_create(total, list);
+		GSList *l =3D cf_cond_list_create(total, list);
+
 		set_new_cond_list(cf, cf->query_next, l);
 =

 		DBG("%s conditions:", cf_type_lut[cf->query_next]);
+
 		cf_cond_list_print(l);
+	}
 =

-		if (cf->query_next =3D=3D CALL_FORWARDING_TYPE_NOT_REACHABLE)
+	if ((is_cfu_enabled(cf) &&
+			cf->query_next =3D=3D CALL_FORWARDING_TYPE_UNCONDITIONAL) ||
+			cf->query_next =3D=3D CALL_FORWARDING_TYPE_NOT_REACHABLE) {
+
+		if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR)
 			cf->flags |=3D CALL_FORWARDING_FLAG_CACHED;
-	}
 =

-	if (cf->query_next =3D=3D CALL_FORWARDING_TYPE_NOT_REACHABLE) {
-		DBusMessage *reply =3D cf_get_properties_reply(cf->pending, cf);
-		__ofono_dbus_pending_reply(&cf->pending, reply);
+		__ofono_dbus_pending_reply(&cf->pending,
+				cf_get_properties_reply(cf->pending, cf));
 		return;
 	}
 =

-- =

1.7.5.4


--===============2024213541770020989==--

