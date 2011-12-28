Content-Type: multipart/mixed; boundary="===============0299956390525077361=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCH 1/3] gprs: Minor whitespace and style fixes
Date: Wed, 28 Dec 2011 15:18:42 +0200
Message-ID: <1325078324-30548-2-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1325078324-30548-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0299956390525077361==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/gprs.c |   24 +++++++++++++-----------
 1 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index 90d3a6d..4e46743 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -57,9 +57,6 @@
 #define MAX_CONTEXTS 256
 #define SUSPEND_TIMEOUT 8
 =

-static GSList *g_drivers =3D NULL;
-static GSList *g_context_drivers =3D NULL;
-
 /* 27.007 Section 7.29 */
 enum packet_bearer {
 	PACKET_BEARER_NONE =3D		0,
@@ -152,6 +149,9 @@ struct pri_context {
 static void gprs_netreg_update(struct ofono_gprs *gprs);
 static void gprs_deactivate_next(struct ofono_gprs *gprs);
 =

+static GSList *g_drivers =3D NULL;
+static GSList *g_context_drivers =3D NULL;
+
 const char *packet_bearer_to_string(int bearer)
 {
 	switch (bearer) {
@@ -1285,7 +1285,7 @@ static DBusMessage *pri_set_property(DBusConnection *=
conn,
 static GDBusMethodTable context_methods[] =3D {
 	{ "GetProperties",	"",	"a{sv}",	pri_get_properties },
 	{ "SetProperty",	"sv",	"",		pri_set_property,
-							G_DBUS_METHOD_FLAG_ASYNC },
+						G_DBUS_METHOD_FLAG_ASYNC },
 	{ }
 };
 =

@@ -1404,11 +1404,11 @@ static void update_suspended_property(struct ofono_=
gprs *gprs,
 =

 static gboolean suspend_timeout(gpointer data)
 {
-       struct ofono_gprs *gprs =3D data;
+	struct ofono_gprs *gprs =3D data;
 =

-       gprs->suspend_timeout =3D 0;
-       update_suspended_property(gprs, TRUE);
-       return FALSE;
+	gprs->suspend_timeout =3D 0;
+	update_suspended_property(gprs, TRUE);
+	return FALSE;
 }
 =

 void ofono_gprs_suspend_notify(struct ofono_gprs *gprs, int cause)
@@ -2253,7 +2253,8 @@ void ofono_gprs_context_deactivated(struct ofono_gprs=
_context *gc,
 	}
 }
 =

-int ofono_gprs_context_driver_register(const struct ofono_gprs_context_dri=
ver *d)
+int ofono_gprs_context_driver_register(
+				const struct ofono_gprs_context_driver *d)
 {
 	DBG("driver: %p, name: %s", d, d->name);
 =

@@ -2265,7 +2266,8 @@ int ofono_gprs_context_driver_register(const struct o=
fono_gprs_context_driver *d
 	return 0;
 }
 =

-void ofono_gprs_context_driver_unregister(const struct ofono_gprs_context_=
driver *d)
+void ofono_gprs_context_driver_unregister(
+				const struct ofono_gprs_context_driver *d)
 {
 	DBG("driver: %p, name: %s", d, d->name);
 =

@@ -2346,7 +2348,7 @@ struct ofono_modem *ofono_gprs_context_get_modem(stru=
ct ofono_gprs_context *gc)
 }
 =

 void ofono_gprs_context_set_type(struct ofono_gprs_context *gc,
-                                        enum ofono_gprs_context_type type)
+					enum ofono_gprs_context_type type)
 {
 	DBG("type %d", type);
 =

-- =

1.7.5.4


--===============0299956390525077361==--

