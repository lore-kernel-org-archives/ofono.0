Content-Type: multipart/mixed; boundary="===============2622830395646509208=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH] Check if ussd is busy when doing ss
Date: Mon, 06 Sep 2010 10:19:55 +0800
Message-ID: <1283739595-11903-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2622830395646509208==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

It's still not clear how ss and ussd interfere with each other. Current
decision is each ss (call-barring, call-forwarding, etc.) has
interference with ussd, but there is no interference within these ss.
That is, call-barring has interference with ussd, but call-barring has
no interference with call-forwarding.
---
 src/call-barring.c    |    8 ++++----
 src/call-forwarding.c |    6 +++---
 src/call-settings.c   |    4 ++--
 src/ofono.h           |    1 +
 src/ussd.c            |   11 +++++++++++
 5 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/src/call-barring.c b/src/call-barring.c
index 7607f3f..a8bb3bd 100644
--- a/src/call-barring.c
+++ b/src/call-barring.c
@@ -669,7 +669,7 @@ static DBusMessage *cb_get_properties(DBusConnection *c=
onn, DBusMessage *msg,
 {
 	struct ofono_call_barring *cb =3D data;
 =

-	if (cb->pending)
+	if (cb->pending || __ofono_ussd_is_busy(cb->ussd))
 		return __ofono_error_busy(msg);
 =

 	if (!cb->driver->query)
@@ -822,7 +822,7 @@ static DBusMessage *cb_set_property(DBusConnection *con=
n, DBusMessage *msg,
 	int cls;
 	int mode;
 =

-	if (cb->pending)
+	if (cb->pending || __ofono_ussd_is_busy(cb->ussd))
 		return __ofono_error_busy(msg);
 =

 	if (!dbus_message_iter_init(msg, &iter))
@@ -894,7 +894,7 @@ static DBusMessage *cb_disable_all(DBusConnection *conn=
, DBusMessage *msg,
 	if (!cb->driver->set)
 		return __ofono_error_not_implemented(msg);
 =

-	if (cb->pending)
+	if (cb->pending || __ofono_ussd_is_busy(cb->ussd))
 		return __ofono_error_busy(msg);
 =

 	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &passwd,
@@ -941,7 +941,7 @@ static DBusMessage *cb_set_passwd(DBusConnection *conn,=
 DBusMessage *msg,
 	if (!cb->driver->set_passwd)
 		return __ofono_error_not_implemented(msg);
 =

-	if (cb->pending)
+	if (cb->pending || __ofono_ussd_is_busy(cb->ussd))
 		return __ofono_error_busy(msg);
 =

 	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &old_passwd,
diff --git a/src/call-forwarding.c b/src/call-forwarding.c
index 4e77144..c8a79b1 100644
--- a/src/call-forwarding.c
+++ b/src/call-forwarding.c
@@ -430,7 +430,7 @@ static DBusMessage *cf_get_properties(DBusConnection *c=
onn, DBusMessage *msg,
 	if (!cf->driver->query)
 		return __ofono_error_not_implemented(msg);
 =

-	if (cf->pending)
+	if (cf->pending || __ofono_ussd_is_busy(cf->ussd))
 		return __ofono_error_busy(msg);
 =

 	cf->pending =3D dbus_message_ref(msg);
@@ -586,7 +586,7 @@ static DBusMessage *cf_set_property(DBusConnection *con=
n, DBusMessage *msg,
 	int cls;
 	int type;
 =

-	if (cf->pending)
+	if (cf->pending || __ofono_ussd_is_busy(cf->ussd))
 		return __ofono_error_busy(msg);
 =

 	if (!dbus_message_iter_init(msg, &iter))
@@ -704,7 +704,7 @@ static DBusMessage *cf_disable_all(DBusConnection *conn=
, DBusMessage *msg,
 	if (!cf->driver->erasure)
 		return __ofono_error_not_implemented(msg);
 =

-	if (cf->pending)
+	if (cf->pending || __ofono_ussd_is_busy(cf->ussd))
 		return __ofono_error_busy(msg);
 =

 	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &strtype,
diff --git a/src/call-settings.c b/src/call-settings.c
index ab20062..ef96345 100644
--- a/src/call-settings.c
+++ b/src/call-settings.c
@@ -950,7 +950,7 @@ static DBusMessage *cs_get_properties(DBusConnection *c=
onn, DBusMessage *msg,
 {
 	struct ofono_call_settings *cs =3D data;
 =

-	if (cs->pending)
+	if (cs->pending || __ofono_ussd_is_busy(cs->ussd))
 		return __ofono_error_busy(msg);
 =

 	if (cs->flags & CALL_SETTINGS_FLAG_CACHED)
@@ -1127,7 +1127,7 @@ static DBusMessage *cs_set_property(DBusConnection *c=
onn, DBusMessage *msg,
 	const char *property;
 	int cls;
 =

-	if (cs->pending)
+	if (cs->pending || __ofono_ussd_is_busy(cs->ussd))
 		return __ofono_error_busy(msg);
 =

 	if (!dbus_message_iter_init(msg, &iter))
diff --git a/src/ofono.h b/src/ofono.h
index d95f2f2..9b2e53f 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -254,6 +254,7 @@ gboolean __ofono_ussd_passwd_register(struct ofono_ussd=
 *ussd, const char *sc,
 					ofono_ussd_passwd_cb_t cb, void *data,
 					ofono_destroy_func destroy);
 void __ofono_ussd_passwd_unregister(struct ofono_ussd *ussd, const char *s=
c);
+gboolean __ofono_ussd_is_busy(struct ofono_ussd *ussd);
 =

 #include <ofono/netreg.h>
 =

diff --git a/src/ussd.c b/src/ussd.c
index 825d560..fbb07d2 100644
--- a/src/ussd.c
+++ b/src/ussd.c
@@ -65,6 +65,17 @@ struct ssc_entry {
 	ofono_destroy_func destroy;
 };
 =

+gboolean __ofono_ussd_is_busy(struct ofono_ussd *ussd)
+{
+	if (!ussd)
+		return FALSE;
+
+	if (ussd->pending || ussd->state !=3D USSD_STATE_IDLE)
+		return TRUE;
+
+	return FALSE;
+}
+
 static struct ssc_entry *ssc_entry_create(const char *sc, void *cb, void *=
data,
 						ofono_destroy_func destroy)
 {
-- =

1.7.0.4


--===============2622830395646509208==--

