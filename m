Content-Type: multipart/mixed; boundary="===============6157718793547277954=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv4 05/13] call-forwarding: Streamline cf_find_timeout() logic
Date: Tue, 10 Apr 2012 15:17:26 +0300
Message-ID: <1334060254-29547-6-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1334060254-29547-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6157718793547277954==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/call-forwarding.c |   13 ++++---------
 1 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/src/call-forwarding.c b/src/call-forwarding.c
index 5e68bba..424b111 100644
--- a/src/call-forwarding.c
+++ b/src/call-forwarding.c
@@ -104,16 +104,11 @@ static struct ofono_call_forwarding_condition *cf_con=
d_find(GSList *l, int cls)
 	return NULL;
 }
 =

-static int cf_find_timeout(GSList *cf_list, int cls)
+static int cf_cond_find_timeout(GSList *l, int cls)
 {
-	struct ofono_call_forwarding_condition *c;
+	struct ofono_call_forwarding_condition *cond =3D cf_cond_find(l, cls);
 =

-	c =3D cf_cond_find(cf_list, cls);
-
-	if (c =3D=3D NULL)
-		return DEFAULT_NO_REPLY_TIMEOUT;
-
-	return c->time;
+	return cond ? cond->time : DEFAULT_NO_REPLY_TIMEOUT;
 }
 =

 static void cf_cond_list_print(GSList *l)
@@ -813,7 +808,7 @@ static DBusMessage *cf_set_property(DBusConnection *con=
n, DBusMessage *msg,
 		if (number[0] !=3D '\0')
 			string_to_phone_number(number, &ph);
 =

-		timeout =3D cf_find_timeout(cf->cf_conditions[type], cls);
+		timeout =3D cf_cond_find_timeout(cf->cf_conditions[type], cls);
 =

 		return set_property_request(cf, msg, type, cls, &ph,
 						timeout);
-- =

1.7.5.4


--===============6157718793547277954==--

