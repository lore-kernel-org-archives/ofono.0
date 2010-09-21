Content-Type: multipart/mixed; boundary="===============8009924693503667654=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 3/5] ss: Use function to judge if it's busy
Date: Tue, 21 Sep 2010 18:21:17 +0800
Message-ID: <1285064479-12907-4-git-send-email-yang.gu@intel.com>
In-Reply-To: <1285064479-12907-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8009924693503667654==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/call-barring.c    |   12 ++++++------
 src/call-forwarding.c |   11 +++++++----
 src/call-settings.c   |   12 ++++++------
 3 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/src/call-barring.c b/src/call-barring.c
index d235211..d1a44cc 100644
--- a/src/call-barring.c
+++ b/src/call-barring.c
@@ -372,7 +372,7 @@ static gboolean cb_ss_control(int type, const char *sc,
 	void *operation =3D NULL;
 	int i;
 =

-	if (cb->pending) {
+	if (__ofono_call_barring_is_busy(cb)) {
 		reply =3D __ofono_error_busy(msg);
 		g_dbus_send_message(conn, reply);
 =

@@ -504,7 +504,7 @@ static gboolean cb_ss_passwd(const char *sc,
 	DBusMessage *reply;
 	const char *fac;
 =

-	if (cb->pending) {
+	if (__ofono_call_barring_is_busy(cb)) {
 		reply =3D __ofono_error_busy(msg);
 		g_dbus_send_message(conn, reply);
 =

@@ -674,7 +674,7 @@ static DBusMessage *cb_get_properties(DBusConnection *c=
onn, DBusMessage *msg,
 {
 	struct ofono_call_barring *cb =3D data;
 =

-	if (cb->pending || __ofono_ussd_is_busy(cb->ussd))
+	if (__ofono_call_barring_is_busy(cb) || __ofono_ussd_is_busy(cb->ussd))
 		return __ofono_error_busy(msg);
 =

 	if (!cb->driver->query)
@@ -827,7 +827,7 @@ static DBusMessage *cb_set_property(DBusConnection *con=
n, DBusMessage *msg,
 	int cls;
 	int mode;
 =

-	if (cb->pending || __ofono_ussd_is_busy(cb->ussd))
+	if (__ofono_call_barring_is_busy(cb) || __ofono_ussd_is_busy(cb->ussd))
 		return __ofono_error_busy(msg);
 =

 	if (!dbus_message_iter_init(msg, &iter))
@@ -899,7 +899,7 @@ static DBusMessage *cb_disable_all(DBusConnection *conn=
, DBusMessage *msg,
 	if (!cb->driver->set)
 		return __ofono_error_not_implemented(msg);
 =

-	if (cb->pending || __ofono_ussd_is_busy(cb->ussd))
+	if (__ofono_call_barring_is_busy(cb) || __ofono_ussd_is_busy(cb->ussd))
 		return __ofono_error_busy(msg);
 =

 	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &passwd,
@@ -946,7 +946,7 @@ static DBusMessage *cb_set_passwd(DBusConnection *conn,=
 DBusMessage *msg,
 	if (!cb->driver->set_passwd)
 		return __ofono_error_not_implemented(msg);
 =

-	if (cb->pending || __ofono_ussd_is_busy(cb->ussd))
+	if (__ofono_call_barring_is_busy(cb) || __ofono_ussd_is_busy(cb->ussd))
 		return __ofono_error_busy(msg);
 =

 	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &old_passwd,
diff --git a/src/call-forwarding.c b/src/call-forwarding.c
index 5eae6cf..ea72913 100644
--- a/src/call-forwarding.c
+++ b/src/call-forwarding.c
@@ -430,7 +430,8 @@ static DBusMessage *cf_get_properties(DBusConnection *c=
onn, DBusMessage *msg,
 	if (!cf->driver->query)
 		return __ofono_error_not_implemented(msg);
 =

-	if (cf->pending || __ofono_ussd_is_busy(cf->ussd))
+	if (__ofono_call_forwarding_is_busy(cf) ||
+			__ofono_ussd_is_busy(cf->ussd))
 		return __ofono_error_busy(msg);
 =

 	cf->pending =3D dbus_message_ref(msg);
@@ -586,7 +587,8 @@ static DBusMessage *cf_set_property(DBusConnection *con=
n, DBusMessage *msg,
 	int cls;
 	int type;
 =

-	if (cf->pending || __ofono_ussd_is_busy(cf->ussd))
+	if (__ofono_call_forwarding_is_busy(cf) ||
+			__ofono_ussd_is_busy(cf->ussd))
 		return __ofono_error_busy(msg);
 =

 	if (!dbus_message_iter_init(msg, &iter))
@@ -704,7 +706,8 @@ static DBusMessage *cf_disable_all(DBusConnection *conn=
, DBusMessage *msg,
 	if (!cf->driver->erasure)
 		return __ofono_error_not_implemented(msg);
 =

-	if (cf->pending || __ofono_ussd_is_busy(cf->ussd))
+	if (__ofono_call_forwarding_is_busy(cf) ||
+			__ofono_ussd_is_busy(cf->ussd))
 		return __ofono_error_busy(msg);
 =

 	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &strtype,
@@ -895,7 +898,7 @@ static gboolean cf_ss_control(int type, const char *sc,
 	if (!cf)
 		return FALSE;
 =

-	if (cf->pending) {
+	if (__ofono_call_forwarding_is_busy(cf)) {
 		reply =3D __ofono_error_busy(msg);
 		g_dbus_send_message(conn, reply);
 =

diff --git a/src/call-settings.c b/src/call-settings.c
index 0c46a2a..16abc5e 100644
--- a/src/call-settings.c
+++ b/src/call-settings.c
@@ -418,7 +418,7 @@ static gboolean cw_ss_control(int type,
 	if (strcmp(sc, "43"))
 		return FALSE;
 =

-	if (cs->pending) {
+	if (__ofono_call_settings_is_busy(cs)) {
 		reply =3D __ofono_error_busy(msg);
 		goto error;
 	}
@@ -576,7 +576,7 @@ static gboolean clip_colp_colr_ss(int type,
 	if (!cs)
 		return FALSE;
 =

-	if (cs->pending) {
+	if (__ofono_call_settings_is_busy(cs)) {
 		DBusMessage *reply =3D __ofono_error_busy(msg);
 		g_dbus_send_message(conn, reply);
 =

@@ -699,7 +699,7 @@ static gboolean clir_ss_control(int type,
 	if (strcmp(sc, "31"))
 		return FALSE;
 =

-	if (cs->pending) {
+	if (__ofono_call_settings_is_busy(cs)) {
 		DBusMessage *reply =3D __ofono_error_busy(msg);
 		g_dbus_send_message(conn, reply);
 =

@@ -955,7 +955,7 @@ static DBusMessage *cs_get_properties(DBusConnection *c=
onn, DBusMessage *msg,
 {
 	struct ofono_call_settings *cs =3D data;
 =

-	if (cs->pending || __ofono_ussd_is_busy(cs->ussd))
+	if (__ofono_call_settings_is_busy(cs) || __ofono_ussd_is_busy(cs->ussd))
 		return __ofono_error_busy(msg);
 =

 	if (cs->flags & CALL_SETTINGS_FLAG_CACHED)
@@ -976,7 +976,7 @@ static void clir_set_query_callback(const struct ofono_=
error *error,
 	struct ofono_call_settings *cs =3D data;
 	DBusMessage *reply;
 =

-	if (!cs->pending)
+	if (!__ofono_call_settings_is_busy(cs))
 		return;
 =

 	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
@@ -1132,7 +1132,7 @@ static DBusMessage *cs_set_property(DBusConnection *c=
onn, DBusMessage *msg,
 	const char *property;
 	int cls;
 =

-	if (cs->pending || __ofono_ussd_is_busy(cs->ussd))
+	if (__ofono_call_settings_is_busy(cs) || __ofono_ussd_is_busy(cs->ussd))
 		return __ofono_error_busy(msg);
 =

 	if (!dbus_message_iter_init(msg, &iter))
-- =

1.7.2.3


--===============8009924693503667654==--

