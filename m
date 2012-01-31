Content-Type: multipart/mixed; boundary="===============6572330960245887308=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCH 1/5] call-forwarding: Minor style fixes
Date: Tue, 31 Jan 2012 11:50:33 +0200
Message-ID: <1328003437-20498-2-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1328003437-20498-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6572330960245887308==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/call-forwarding.c |   56 ++++++++++++++++++++++++++-------------------=
---
 1 files changed, 30 insertions(+), 26 deletions(-)

diff --git a/src/call-forwarding.c b/src/call-forwarding.c
index a58ca21..731a38a 100644
--- a/src/call-forwarding.c
+++ b/src/call-forwarding.c
@@ -38,21 +38,19 @@
 =

 #define uninitialized_var(x) x =3D x
 =

-#define CALL_FORWARDING_FLAG_CACHED 0x1
-#define CALL_FORWARDING_FLAG_CPHS_CFF 0x2
+#define CALL_FORWARDING_FLAG_CACHED	0x1
+#define CALL_FORWARDING_FLAG_CPHS_CFF	0x2
 =

 /* According to 27.007 Spec */
 #define DEFAULT_NO_REPLY_TIMEOUT 20
 =

-static GSList *g_drivers =3D NULL;
-
 enum call_forwarding_type {
-	CALL_FORWARDING_TYPE_UNCONDITIONAL =3D		0,
-	CALL_FORWARDING_TYPE_BUSY =3D			1,
-	CALL_FORWARDING_TYPE_NO_REPLY =3D			2,
-	CALL_FORWARDING_TYPE_NOT_REACHABLE =3D		3,
-	CALL_FORWARDING_TYPE_ALL =3D			4,
-	CALL_FORWARDING_TYPE_ALL_CONDITIONAL =3D		5
+	CALL_FORWARDING_TYPE_UNCONDITIONAL =3D	0,
+	CALL_FORWARDING_TYPE_BUSY =3D		1,
+	CALL_FORWARDING_TYPE_NO_REPLY =3D		2,
+	CALL_FORWARDING_TYPE_NOT_REACHABLE =3D	3,
+	CALL_FORWARDING_TYPE_ALL =3D		4,
+	CALL_FORWARDING_TYPE_ALL_CONDITIONAL =3D	5
 };
 =

 struct ofono_call_forwarding {
@@ -72,10 +70,6 @@ struct ofono_call_forwarding {
 	struct ofono_atom *atom;
 };
 =

-static void get_query_next_cf_cond(struct ofono_call_forwarding *cf);
-static void set_query_next_cf_cond(struct ofono_call_forwarding *cf);
-static void ss_set_query_next_cf_cond(struct ofono_call_forwarding *cf);
-
 struct cf_ss_request {
 	int ss_type;
 	int cf_type;
@@ -83,6 +77,12 @@ struct cf_ss_request {
 	GSList *cf_list[4];
 };
 =

+static GSList *g_drivers =3D NULL;
+
+static void get_query_next_cf_cond(struct ofono_call_forwarding *cf);
+static void set_query_next_cf_cond(struct ofono_call_forwarding *cf);
+static void ss_set_query_next_cf_cond(struct ofono_call_forwarding *cf);
+
 static gint cf_condition_compare(gconstpointer a, gconstpointer b)
 {
 	const struct ofono_call_forwarding_condition *ca =3D a;
@@ -163,7 +163,8 @@ static GSList *cf_cond_list_create(int total,
 			if (list[i].status =3D=3D 0)
 				continue;
 =

-			cond =3D g_try_new0(struct ofono_call_forwarding_condition, 1);
+			cond =3D g_try_new0(
+				struct ofono_call_forwarding_condition, 1);
 			if (cond =3D=3D NULL)
 				continue;
 =

@@ -497,7 +498,7 @@ static void property_append_cf_conditions(DBusMessageIt=
er *dict,
 }
 =

 static DBusMessage *cf_get_properties_reply(DBusMessage *msg,
-						struct ofono_call_forwarding *cf)
+					struct ofono_call_forwarding *cf)
 {
 	DBusMessage *reply;
 	DBusMessageIter iter;
@@ -891,11 +892,11 @@ static DBusMessage *cf_disable_all(DBusConnection *co=
nn, DBusMessage *msg,
 =

 static GDBusMethodTable cf_methods[] =3D {
 	{ "GetProperties",	"",	"a{sv}",	cf_get_properties,
-							G_DBUS_METHOD_FLAG_ASYNC },
+						G_DBUS_METHOD_FLAG_ASYNC },
 	{ "SetProperty",	"sv",	"",		cf_set_property,
-							G_DBUS_METHOD_FLAG_ASYNC },
+						G_DBUS_METHOD_FLAG_ASYNC },
 	{ "DisableAll",		"s",	"",		cf_disable_all,
-							G_DBUS_METHOD_FLAG_ASYNC },
+						G_DBUS_METHOD_FLAG_ASYNC },
 	{ }
 };
 =

@@ -1431,7 +1432,8 @@ static void sim_read_cf_indicator(struct ofono_call_f=
orwarding *cf)
 	}
 }
 =

-int ofono_call_forwarding_driver_register(const struct ofono_call_forwardi=
ng_driver *d)
+int ofono_call_forwarding_driver_register(
+				const struct ofono_call_forwarding_driver *d)
 {
 	DBG("driver: %p, name: %s", d, d->name);
 =

@@ -1443,7 +1445,8 @@ int ofono_call_forwarding_driver_register(const struc=
t ofono_call_forwarding_dri
 	return 0;
 }
 =

-void ofono_call_forwarding_driver_unregister(const struct ofono_call_forwa=
rding_driver *d)
+void ofono_call_forwarding_driver_unregister(
+				const struct ofono_call_forwarding_driver *d)
 {
 	DBG("driver: %p, name: %s", d, d->name);
 =

@@ -1467,10 +1470,10 @@ static void call_forwarding_remove(struct ofono_ato=
m *atom)
 	g_free(cf);
 }
 =

-struct ofono_call_forwarding *ofono_call_forwarding_create(struct ofono_mo=
dem *modem,
-							unsigned int vendor,
-							const char *driver,
-							void *data)
+struct ofono_call_forwarding *ofono_call_forwarding_create(
+						struct ofono_modem *modem,
+						unsigned int vendor,
+						const char *driver, void *data)
 {
 	struct ofono_call_forwarding *cf;
 	GSList *l;
@@ -1552,7 +1555,8 @@ void ofono_call_forwarding_remove(struct ofono_call_f=
orwarding *cf)
 	__ofono_atom_free(cf->atom);
 }
 =

-void ofono_call_forwarding_set_data(struct ofono_call_forwarding *cf, void=
 *data)
+void ofono_call_forwarding_set_data(struct ofono_call_forwarding *cf,
+								void *data)
 {
 	cf->driver_data =3D data;
 }
-- =

1.7.5.4


--===============6572330960245887308==--

