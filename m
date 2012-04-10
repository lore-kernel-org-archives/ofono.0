Content-Type: multipart/mixed; boundary="===============2497186000980935867=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv4 02/13] call-forwarding: Refactor cf_condition_find_with_cls()
Date: Tue, 10 Apr 2012 15:17:23 +0300
Message-ID: <1334060254-29547-3-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1334060254-29547-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2497186000980935867==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/call-forwarding.c |   56 ++++++++++++++-------------------------------=
---
 1 files changed, 17 insertions(+), 39 deletions(-)

diff --git a/src/call-forwarding.c b/src/call-forwarding.c
index 2b91250..beae53b 100644
--- a/src/call-forwarding.c
+++ b/src/call-forwarding.c
@@ -94,33 +94,25 @@ static gint cf_cond_compare(gconstpointer a, gconstpoin=
ter b)
 	return ca->cls - cb->cls;
 }
 =

-static gint cf_condition_find_with_cls(gconstpointer a, gconstpointer b)
+static struct ofono_call_forwarding_condition *cf_cond_find(GSList *l, int=
 cls)
 {
-	const struct ofono_call_forwarding_condition *c =3D a;
-	int cls =3D GPOINTER_TO_INT(b);
+	for (; l; l =3D l->next)
+		if (((struct ofono_call_forwarding_condition *)
+				(l->data))->cls =3D=3D cls)
+			return l->data;
 =

-	if (c->cls < cls)
-		return -1;
-
-	if (c->cls > cls)
-		return 1;
-
-	return 0;
+	return NULL;
 }
 =

 static int cf_find_timeout(GSList *cf_list, int cls)
 {
-	GSList *l;
 	struct ofono_call_forwarding_condition *c;
 =

-	l =3D g_slist_find_custom(cf_list, GINT_TO_POINTER(cls),
-		cf_condition_find_with_cls);
+	c =3D cf_cond_find(cf_list, cls);
 =

-	if (l =3D=3D NULL)
+	if (c =3D=3D NULL)
 		return DEFAULT_NO_REPLY_TIMEOUT;
 =

-	c =3D l->data;
-
 	return c->time;
 }
 =

@@ -323,12 +315,8 @@ static void set_new_cond_list(struct ofono_call_forwar=
ding *cf,
 		if (type =3D=3D CALL_FORWARDING_TYPE_NO_REPLY)
 			snprintf(tattr, sizeof(tattr), "%sTimeout", attr);
 =

-		o =3D g_slist_find_custom(old, GINT_TO_POINTER(lc->cls),
-					cf_condition_find_with_cls);
-
-		if (o) { /* On the old list, must be active */
-			oc =3D o->data;
-
+		oc =3D cf_cond_find(old, lc->cls);
+		if (oc) { /* On the old list, must be active */
 			if (oc->phone_number.type !=3D lc->phone_number.type ||
 				strcmp(oc->phone_number.number,
 					lc->phone_number.number)) {
@@ -349,8 +337,8 @@ static void set_new_cond_list(struct ofono_call_forward=
ing *cf,
 						&timeout);
 =

 			/* Remove from the old list */
-			g_free(o->data);
-			old =3D g_slist_remove(old, o->data);
+			old =3D g_slist_remove(old, oc);
+			g_free(oc);
 		} else {
 			number =3D phone_number_to_string(&lc->phone_number);
 =

@@ -428,19 +416,14 @@ static void set_new_cond_list(struct ofono_call_forwa=
rding *cf,
 			if (i =3D=3D CALL_FORWARDING_TYPE_UNCONDITIONAL)
 				continue;
 =

-			l =3D g_slist_find_custom(cf->cf_conditions[i],
-					GINT_TO_POINTER(BEARER_CLASS_VOICE),
-					cf_condition_find_with_cls);
-
-			if (l =3D=3D NULL)
+			lc =3D cf_cond_find(cf->cf_conditions[i],
+						BEARER_CLASS_VOICE);
+			if (lc =3D=3D NULL)
 				continue;
 =

 			if (new_cfu)
 				number =3D "";
 			else {
-				lc =3D l->data;
-
-				number =3D phone_number_to_string(
 							&lc->phone_number);
 			}
 =

@@ -789,7 +772,6 @@ static DBusMessage *cf_set_property(DBusConnection *con=
n, DBusMessage *msg,
 =

 	if (cf_condition_timeout_property(property, &cls)) {
 		dbus_uint16_t timeout;
-		GSList *l;
 		struct ofono_call_forwarding_condition *c;
 =

 		type =3D CALL_FORWARDING_TYPE_NO_REPLY;
@@ -802,15 +784,11 @@ static DBusMessage *cf_set_property(DBusConnection *c=
onn, DBusMessage *msg,
 		if (timeout < 1 || timeout > 30)
 			return __ofono_error_invalid_format(msg);
 =

-		l =3D g_slist_find_custom(cf->cf_conditions[type],
-					GINT_TO_POINTER(cls),
-					cf_condition_find_with_cls);
 =

-		if (l =3D=3D NULL)
+		c =3D cf_cond_find(cf->cf_conditions[type], cls);
+		if (c =3D=3D NULL)
 			return __ofono_error_failed(msg);
 =

-		c =3D l->data;
-
 		return set_property_request(cf, msg, type, cls,
 						&c->phone_number, timeout);
 	} else if (cf_condition_enabled_property(cf, property, &type, &cls)) {
-- =

1.7.5.4


--===============2497186000980935867==--

