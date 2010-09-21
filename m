Content-Type: multipart/mixed; boundary="===============3558763278041943124=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 4/5] ss: Use errno for ssc handling functions
Date: Tue, 21 Sep 2010 18:21:18 +0800
Message-ID: <1285064479-12907-5-git-send-email-yang.gu@intel.com>
In-Reply-To: <1285064479-12907-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3558763278041943124==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/call-barring.c    |   63 ++++++++++++++-------------------------------=
---
 src/call-forwarding.c |   63 +++++++++++++++++----------------------------=
---
 src/call-settings.c   |   34 ++++++++------------------
 src/ussd.c            |   56 ++++++++++++++++++++++++++++--------------
 4 files changed, 89 insertions(+), 127 deletions(-)

diff --git a/src/call-barring.c b/src/call-barring.c
index d1a44cc..3145de5 100644
--- a/src/call-barring.c
+++ b/src/call-barring.c
@@ -359,25 +359,19 @@ static const char *cb_ss_service_to_fac(const char *s=
vc)
 	return NULL;
 }
 =

-static gboolean cb_ss_control(int type, const char *sc,
+static int cb_ss_control(int type, const char *sc,
 				const char *sia, const char *sib,
 				const char *sic, const char *dn,
 				DBusMessage *msg, void *data)
 {
 	struct ofono_call_barring *cb =3D data;
-	DBusConnection *conn =3D ofono_dbus_get_connection();
 	int cls =3D BEARER_CLASS_DEFAULT;
 	const char *fac;
-	DBusMessage *reply;
 	void *operation =3D NULL;
 	int i;
 =

-	if (__ofono_call_barring_is_busy(cb)) {
-		reply =3D __ofono_error_busy(msg);
-		g_dbus_send_message(conn, reply);
-
-		return TRUE;
-	}
+	if (__ofono_call_barring_is_busy(cb))
+		return EBUSY;
 =

 	DBG("Received call barring ss control request");
 =

@@ -386,7 +380,7 @@ static gboolean cb_ss_control(int type, const char *sc,
 =

 	fac =3D cb_ss_service_to_fac(sc);
 	if (!fac)
-		return FALSE;
+		return -ENOENT;
 =

 	cb_set_query_bounds(cb, fac, type =3D=3D SS_CONTROL_TYPE_QUERY);
 =

@@ -397,13 +391,13 @@ static gboolean cb_ss_control(int type, const char *s=
c,
 	cb->ss_req_lock =3D i;
 =

 	if (strlen(sic) > 0)
-		goto bad_format;
+		return EINVAL;
 =

 	if (strlen(dn) > 0)
-		goto bad_format;
+		return EINVAL;
 =

 	if (type !=3D SS_CONTROL_TYPE_QUERY && !is_valid_pin(sia, PIN_TYPE_NET))
-		goto bad_format;
+		return EINVAL;
 =

 	switch (type) {
 	case SS_CONTROL_TYPE_ACTIVATION:
@@ -419,12 +413,8 @@ static gboolean cb_ss_control(int type, const char *sc,
 		break;
 	}
 =

-	if (!operation) {
-		reply =3D __ofono_error_not_implemented(msg);
-		g_dbus_send_message(conn, reply);
-
-		return TRUE;
-	}
+	if (!operation)
+		return ENOSYS;
 =

 	/* According to 27.007, AG, AC and AB only work with mode =3D 0
 	 * We support query by querying all relevant types, since we must
@@ -433,7 +423,7 @@ static gboolean cb_ss_control(int type, const char *sc,
 	if ((!strcmp(fac, "AG") || !strcmp(fac, "AC") || !strcmp(fac, "AB")) &&
 		(type =3D=3D SS_CONTROL_TYPE_ACTIVATION ||
 			type =3D=3D SS_CONTROL_TYPE_REGISTRATION))
-		goto bad_format;
+		return EINVAL;
 =

 	if (strlen(sib) > 0) {
 		long service_code;
@@ -442,12 +432,12 @@ static gboolean cb_ss_control(int type, const char *s=
c,
 		service_code =3D strtoul(sib, &end, 10);
 =

 		if (end =3D=3D sib || *end !=3D '\0')
-			goto bad_format;
+			return EINVAL;
 =

 		cls =3D mmi_service_code_to_bearer_class(service_code);
 =

 		if (cls =3D=3D 0)
-			goto bad_format;
+			return EINVAL;
 	}
 =

 	cb->ss_req_cls =3D cls;
@@ -472,12 +462,7 @@ static gboolean cb_ss_control(int type, const char *sc,
 		break;
 	}
 =

-	return TRUE;
-
-bad_format:
-	reply =3D __ofono_error_invalid_format(msg);
-	g_dbus_send_message(conn, reply);
-	return TRUE;
+	return 0;
 }
 =

 static void cb_set_passwd_callback(const struct ofono_error *error, void *=
data)
@@ -495,21 +480,15 @@ static void cb_set_passwd_callback(const struct ofono=
_error *error, void *data)
 	__ofono_dbus_pending_reply(&cb->pending, reply);
 }
 =

-static gboolean cb_ss_passwd(const char *sc,
+static int cb_ss_passwd(const char *sc,
 				const char *old, const char *new,
 				DBusMessage *msg, void *data)
 {
 	struct ofono_call_barring *cb =3D data;
-	DBusConnection *conn =3D ofono_dbus_get_connection();
-	DBusMessage *reply;
 	const char *fac;
 =

-	if (__ofono_call_barring_is_busy(cb)) {
-		reply =3D __ofono_error_busy(msg);
-		g_dbus_send_message(conn, reply);
-
-		return TRUE;
-	}
+	if (__ofono_call_barring_is_busy(cb))
+		return EBUSY;
 =

 	DBG("Received call barring ss password change request");
 =

@@ -521,19 +500,15 @@ static gboolean cb_ss_passwd(const char *sc,
 		fac =3D cb_ss_service_to_fac(sc);
 =

 	if (!fac)
-		return FALSE;
+		return -ENOENT;
 =

 	if (!is_valid_pin(old, PIN_TYPE_NET) || !is_valid_pin(new, PIN_TYPE_NET))
-		goto bad_format;
+		return EINVAL;
 =

 	cb->pending =3D dbus_message_ref(msg);
 	cb->driver->set_passwd(cb, fac, old, new, cb_set_passwd_callback, cb);
 =

-	return TRUE;
-bad_format:
-	reply =3D __ofono_error_invalid_format(msg);
-	g_dbus_send_message(conn, reply);
-	return TRUE;
+	return 0;
 }
 =

 static void cb_register_ss_controls(struct ofono_call_barring *cb)
diff --git a/src/call-forwarding.c b/src/call-forwarding.c
index ea72913..4a0f1cd 100644
--- a/src/call-forwarding.c
+++ b/src/call-forwarding.c
@@ -880,30 +880,24 @@ static void cf_ss_control_callback(const struct ofono=
_error *error, void *data)
 	ss_set_query_next_cf_cond(cf);
 }
 =

-static gboolean cf_ss_control(int type, const char *sc,
+static int cf_ss_control(int type, const char *sc,
 				const char *sia, const char *sib,
 				const char *sic, const char *dn,
 				DBusMessage *msg, void *data)
 {
 	struct ofono_call_forwarding *cf =3D data;
-	DBusConnection *conn =3D ofono_dbus_get_connection();
 	int cls =3D BEARER_CLASS_SS_DEFAULT;
 	int timeout =3D DEFAULT_NO_REPLY_TIMEOUT;
 	int cf_type;
-	DBusMessage *reply;
 	struct ofono_phone_number ph;
 	void *operation =3D NULL;
 =

 	/* Before we do anything, make sure we're actually initialized */
 	if (!cf)
-		return FALSE;
+		return -ENOENT;
 =

-	if (__ofono_call_forwarding_is_busy(cf)) {
-		reply =3D __ofono_error_busy(msg);
-		g_dbus_send_message(conn, reply);
-
-		return TRUE;
-	}
+	if (__ofono_call_forwarding_is_busy(cf))
+		return EBUSY;
 =

 	DBG("Received call forwarding ss control request");
 =

@@ -923,13 +917,13 @@ static gboolean cf_ss_control(int type, const char *s=
c,
 	else if (!strcmp(sc, "004"))
 		cf_type =3D CALL_FORWARDING_TYPE_ALL_CONDITIONAL;
 	else
-		return FALSE;
+		return -ENOENT;
 =

 	if (strlen(sia) &&
-		(type =3D=3D SS_CONTROL_TYPE_QUERY ||
-		type =3D=3D SS_CONTROL_TYPE_ERASURE ||
-		type =3D=3D SS_CONTROL_TYPE_DEACTIVATION))
-		goto error;
+			(type =3D=3D SS_CONTROL_TYPE_QUERY ||
+			type =3D=3D SS_CONTROL_TYPE_ERASURE ||
+			type =3D=3D SS_CONTROL_TYPE_DEACTIVATION))
+		return EINVAL;
 =

 	/* Activation / Registration is figured context specific according to
 	 * 22.030 Section 6.5.2 "The UE shall determine from the context
@@ -940,8 +934,8 @@ static gboolean cf_ss_control(int type, const char *sc,
 		type =3D SS_CONTROL_TYPE_REGISTRATION;
 =

 	if (type =3D=3D SS_CONTROL_TYPE_REGISTRATION &&
-		!valid_phone_number_format(sia))
-		goto error;
+			!valid_phone_number_format(sia))
+		return EINVAL;
 =

 	if (strlen(sib) > 0) {
 		long service_code;
@@ -950,32 +944,32 @@ static gboolean cf_ss_control(int type, const char *s=
c,
 		service_code =3D strtoul(sib, &end, 10);
 =

 		if (end =3D=3D sib || *end !=3D '\0')
-			goto error;
+			return EINVAL;
 =

 		cls =3D mmi_service_code_to_bearer_class(service_code);
 =

 		if (cls =3D=3D 0)
-			goto error;
+			return EINVAL;
 	}
 =

 	if (strlen(sic) > 0) {
 		char *end;
 =

 		if  (type !=3D SS_CONTROL_TYPE_REGISTRATION)
-			goto error;
+			return EINVAL;
 =

 		if (cf_type !=3D CALL_FORWARDING_TYPE_ALL &&
 			cf_type !=3D CALL_FORWARDING_TYPE_ALL_CONDITIONAL &&
 			cf_type !=3D CALL_FORWARDING_TYPE_NO_REPLY)
-			goto error;
+			return EINVAL;
 =

 		timeout =3D strtoul(sic, &end, 10);
 =

 		if (end =3D=3D sic || *end !=3D '\0')
-			goto error;
+			return EINVAL;
 =

 		if (timeout < 1 || timeout > 30)
-			goto error;
+			return EINVAL;
 	}
 =

 	switch (type) {
@@ -996,21 +990,13 @@ static gboolean cf_ss_control(int type, const char *s=
c,
 		break;
 	}
 =

-	if (!operation) {
-		reply =3D __ofono_error_not_implemented(msg);
-		g_dbus_send_message(conn, reply);
-
-		return TRUE;
-	}
+	if (!operation)
+		return ENOSYS;
 =

 	cf->ss_req =3D g_try_new0(struct cf_ss_request, 1);
 =

-	if (!cf->ss_req) {
-		reply =3D __ofono_error_failed(msg);
-		g_dbus_send_message(conn, reply);
-
-		return TRUE;
-	}
+	if (!cf->ss_req)
+		return ENOMEM;
 =

 	cf->ss_req->ss_type =3D type;
 	cf->ss_req->cf_type =3D cf_type;
@@ -1065,12 +1051,7 @@ static gboolean cf_ss_control(int type, const char *=
sc,
 		break;
 	}
 =

-	return TRUE;
-
-error:
-	reply =3D __ofono_error_invalid_format(msg);
-	g_dbus_send_message(conn, reply);
-	return TRUE;
+	return 0;
 }
 =

 static void cf_register_ss_controls(struct ofono_call_forwarding *cf)
diff --git a/src/call-settings.c b/src/call-settings.c
index 16abc5e..dfa23d6 100644
--- a/src/call-settings.c
+++ b/src/call-settings.c
@@ -402,35 +402,29 @@ static void cw_ss_set_callback(const struct ofono_err=
or *error, void *data)
 				cw_ss_query_callback, cs);
 }
 =

-static gboolean cw_ss_control(int type,
+static int cw_ss_control(int type,
 				const char *sc, const char *sia,
 				const char *sib, const char *sic,
 				const char *dn, DBusMessage *msg, void *data)
 {
 	struct ofono_call_settings *cs =3D data;
-	DBusConnection *conn =3D ofono_dbus_get_connection();
 	int cls =3D BEARER_CLASS_SS_DEFAULT;
-	DBusMessage *reply;
 =

 	if (!cs)
-		return FALSE;
+		return -ENOENT;
 =

 	if (strcmp(sc, "43"))
-		return FALSE;
+		return -ENOENT;
 =

-	if (__ofono_call_settings_is_busy(cs)) {
-		reply =3D __ofono_error_busy(msg);
-		goto error;
-	}
+	if (__ofono_call_settings_is_busy(cs))
+		return EBUSY;
 =

 	if (strlen(sib) || strlen(sib) || strlen(dn))
-		goto bad_format;
+		return EINVAL;
 =

 	if ((type =3D=3D SS_CONTROL_TYPE_QUERY && !cs->driver->cw_query) ||
-		(type !=3D SS_CONTROL_TYPE_QUERY && !cs->driver->cw_set)) {
-		reply =3D __ofono_error_not_implemented(msg);
-		goto error;
-	}
+			(type !=3D SS_CONTROL_TYPE_QUERY && !cs->driver->cw_set))
+		return ENOSYS;
 =

 	if (strlen(sia) > 0) {
 		long service_code;
@@ -439,11 +433,11 @@ static gboolean cw_ss_control(int type,
 		service_code =3D strtoul(sia, &end, 10);
 =

 		if (end =3D=3D sia || *end !=3D '\0')
-			goto bad_format;
+			return EINVAL;
 =

 		cls =3D mmi_service_code_to_bearer_class(service_code);
 		if (cls =3D=3D 0)
-			goto bad_format;
+			return EINVAL;
 	}
 =

 	cs->ss_req_cls =3D cls;
@@ -477,13 +471,7 @@ static gboolean cw_ss_control(int type,
 		break;
 	}
 =

-	return TRUE;
-
-bad_format:
-	reply =3D __ofono_error_invalid_format(msg);
-error:
-	g_dbus_send_message(conn, reply);
-	return TRUE;
+	return 0;
 }
 =

 static void generate_ss_query_reply(struct ofono_call_settings *cs,
diff --git a/src/ussd.c b/src/ussd.c
index bbb9aed..6119573 100644
--- a/src/ussd.c
+++ b/src/ussd.c
@@ -205,32 +205,29 @@ static gboolean recognized_passwd_change_string(struc=
t ofono_ussd *ussd,
 		break;
 =

 	default:
-		return FALSE;
+		return -ENOENT;
 	}
 =

 	if (strcmp(sc, "03") || strlen(dn))
-		return FALSE;
+		return -ENOENT;
 =

 	/* If SIC & SID don't match, then we just bail out here */
-	if (strcmp(sic, sid)) {
-		DBusConnection *conn =3D ofono_dbus_get_connection();
-		DBusMessage *reply =3D __ofono_error_invalid_format(msg);
-		g_dbus_send_message(conn, reply);
-		return TRUE;
-	}
+	if (strcmp(sic, sid))
+		return EINVAL;
 =

 	while ((l =3D g_slist_find_custom(l, sia,
 			ssc_entry_find_by_service)) !=3D NULL) {
 		struct ssc_entry *entry =3D l->data;
 		ofono_ussd_passwd_cb_t cb =3D entry->cb;
+		int result =3D cb(sia, sib, sic, msg, entry->user);
 =

-		if (cb(sia, sib, sic, msg, entry->user))
-			return TRUE;
+		if (result >=3D 0)
+			return result;
 =

 		l =3D l->next;
 	}
 =

-	return FALSE;
+	return -ENOENT;
 }
 =

 static gboolean recognized_control_string(struct ofono_ussd *ussd,
@@ -240,7 +237,8 @@ static gboolean recognized_control_string(struct ofono_=
ussd *ussd,
 	char *str =3D g_strdup(ss_str);
 	char *sc, *sia, *sib, *sic, *sid, *dn;
 	int type;
-	gboolean ret =3D FALSE;
+	int ret =3D -ENOENT;
+	int result;
 =

 	DBG("parsing control string");
 =

@@ -254,9 +252,11 @@ static gboolean recognized_control_string(struct ofono=
_ussd *ussd,
 		/* A password change string needs to be treated separately
 		 * because it uses a fourth SI and is thus not a valid
 		 * control string.  */
-		if (recognized_passwd_change_string(ussd, type, sc,
-					sia, sib, sic, sid, dn, msg)) {
-			ret =3D TRUE;
+		result =3D recognized_passwd_change_string(ussd, type, sc,
+						sia, sib, sic, sid, dn, msg);
+
+		if (result >=3D 0) {
+			ret =3D result;
 			goto out;
 		}
 =

@@ -268,8 +268,11 @@ static gboolean recognized_control_string(struct ofono=
_ussd *ussd,
 			struct ssc_entry *entry =3D l->data;
 			ofono_ussd_ssc_cb_t cb =3D entry->cb;
 =

-			if (cb(type, sc, sia, sib, sic, dn, msg, entry->user)) {
-				ret =3D TRUE;
+			result =3D cb(type, sc, sia, sib, sic, dn, msg,
+								entry->user);
+
+			if (result >=3D 0) {
+				ret =3D result;
 				goto out;
 			}
 =

@@ -547,6 +550,7 @@ static DBusMessage *ussd_initiate(DBusConnection *conn,=
 DBusMessage *msg,
 	int dcs =3D 0x0f;
 	unsigned char buf[160];
 	long num_packed;
+	int result;
 =

 	if (__ofono_ussd_is_busy(ussd))
 		return __ofono_error_busy(msg);
@@ -559,8 +563,22 @@ static DBusMessage *ussd_initiate(DBusConnection *conn=
, DBusMessage *msg,
 		return __ofono_error_invalid_format(msg);
 =

 	DBG("checking if this is a recognized control string");
-	if (recognized_control_string(ussd, str, msg))
-		return NULL;
+
+	result =3D recognized_control_string(ussd, str, msg);
+	if (result >=3D 0) {
+		switch (result) {
+		case EBUSY:
+			return __ofono_error_busy(msg);
+		case EINVAL:
+			return __ofono_error_invalid_format(msg);
+		case ENOSYS:
+			return __ofono_error_not_implemented(msg);
+		case ENOMEM:
+			return __ofono_error_failed(msg);
+		default:
+			return NULL;
+		}
+	}
 =

 	DBG("No.., checking if this is a USSD string");
 	if (!valid_ussd_string(str))
-- =

1.7.2.3


--===============3558763278041943124==--

