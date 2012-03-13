Content-Type: multipart/mixed; boundary="===============2600603935095822982=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv3 06/12] call-forwarding: Don't run conditional queries if cfu
 is active
Date: Tue, 13 Mar 2012 15:46:27 +0200
Message-ID: <1331646393-5249-7-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1331646393-5249-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2600603935095822982==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/call-forwarding.c |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/src/call-forwarding.c b/src/call-forwarding.c
index 7e5edcb..ad5050b 100644
--- a/src/call-forwarding.c
+++ b/src/call-forwarding.c
@@ -525,19 +525,18 @@ static void get_query_cf_callback(const struct ofono_=
error *error, int total,
 		DBG("%s conditions:", cf_type_lut[cf->query_next]);
 =

 		cf_cond_list_print(l);
-
-		if (cf->query_next =3D=3D CALL_FORWARDING_TYPE_NOT_REACHABLE)
-			cf->flags |=3D CALL_FORWARDING_FLAG_CACHED;
 	}
 =

-	if (cf->query_next =3D=3D CALL_FORWARDING_TYPE_NOT_REACHABLE) {
-		DBusMessage *reply =3D cf_get_properties_reply(cf->pending, cf);
-		__ofono_dbus_pending_reply(&cf->pending, reply);
+	if (cf->query_next++ < cf->query_end) {
+		get_query_next_cf_cond(cf);
 		return;
 	}
 =

-	cf->query_next++;
-	get_query_next_cf_cond(cf);
+	if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR)
+		cf->flags |=3D CALL_FORWARDING_FLAG_CACHED;
+
+	__ofono_dbus_pending_reply(&cf->pending,
+				cf_get_properties_reply(cf->pending, cf));
 }
 =

 static inline void get_query_next_cf_cond(struct ofono_call_forwarding *cf)
@@ -565,7 +564,9 @@ static DBusMessage *cf_get_properties(DBusConnection *c=
onn, DBusMessage *msg,
 =

 	cf->pending =3D dbus_message_ref(msg);
 	cf->query_next =3D 0;
-
+	cf->query_end =3D is_cfu_enabled(cf) ?
+					CALL_FORWARDING_TYPE_UNCONDITIONAL :
+					CALL_FORWARDING_TYPE_NOT_REACHABLE;
 	get_query_next_cf_cond(cf);
 =

 	return NULL;
-- =

1.7.5.4


--===============2600603935095822982==--

