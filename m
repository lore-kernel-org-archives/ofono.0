Content-Type: multipart/mixed; boundary="===============5678302098747925286=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH] stk: Handle send ss proactive command
Date: Mon, 13 Sep 2010 16:35:45 +0800
Message-ID: <1284366945-18265-2-git-send-email-yang.gu@intel.com>
In-Reply-To: <1284366945-18265-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5678302098747925286==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/call-barring.c    |  168 ++++++++++++++++++++++---------------
 src/call-forwarding.c |  155 +++++++++++++++++++++-------------
 src/call-settings.c   |  220 +++++++++++++++++++++++++++------------------=
----
 src/ofono.h           |   15 +++-
 src/stk.c             |   98 ++++++++++++++++++++++
 src/stkutil.c         |    2 +
 src/stkutil.h         |   23 +++++
 src/ussd.c            |   78 ++++++++++++------
 8 files changed, 504 insertions(+), 255 deletions(-)

diff --git a/src/call-barring.c b/src/call-barring.c
index d235211..f504d07 100644
--- a/src/call-barring.c
+++ b/src/call-barring.c
@@ -48,6 +48,7 @@ static void set_query_next_lock(struct ofono_call_barring=
 *cb);
 struct ofono_call_barring {
 	int flags;
 	DBusMessage *pending;
+	ofono_bool_t stk_pending;
 	int cur_locks[NUM_OF_BARRINGS];
 	int new_locks[NUM_OF_BARRINGS];
 	int query_start;
@@ -58,10 +59,12 @@ struct ofono_call_barring {
 	int ss_req_lock;
 	struct ofono_ssn *ssn;
 	struct ofono_ussd *ussd;
+	struct ofono_stk *stk;
 	unsigned int incoming_bar_watch;
 	unsigned int outgoing_bar_watch;
 	unsigned int ssn_watch;
 	unsigned int ussd_watch;
+	unsigned int stk_watch;
 	const struct ofono_call_barring_driver *driver;
 	void *driver_data;
 	struct ofono_atom *atom;
@@ -95,6 +98,36 @@ static struct call_barring_lock cb_locks[] =3D {
 #define CB_ALL_OUTGOING 6
 #define CB_ALL_INCOMING 7
 =

+gboolean __ofono_call_barring_is_busy(struct ofono_call_barring *cb)
+{
+	if (!cb)
+		return FALSE;
+
+	if (cb->pending || cb->stk_pending)
+		return TRUE;
+
+	return FALSE;
+}
+
+static void reply_error(struct ofono_call_barring *cb,
+				const struct ofono_error *error)
+{
+	if (cb->pending)
+		__ofono_dbus_pending_reply(&cb->pending,
+				__ofono_error_failed(cb->pending));
+	else
+		__ofono_stk_send_ss_response(cb->stk, &cb->stk_pending,	error);
+}
+
+static void set_pending(struct ofono_call_barring *cb,
+				struct ofono_ss_req *osr)
+{
+	if (osr->msg)
+		cb->pending =3D dbus_message_ref(osr->msg);
+	else
+		cb->stk_pending =3D TRUE;
+}
+
 static inline void emit_barring_changed(struct ofono_call_barring *cb,
 					int start, int end,
 					const char *type, int cls)
@@ -293,9 +326,8 @@ static void cb_ss_query_next_lock_callback(const struct=
 ofono_error *error,
 					"successful, but query was not");
 =

 		cb->flags &=3D ~CALL_BARRING_FLAG_CACHED;
+		reply_error(cb, error);
 =

-		__ofono_dbus_pending_reply(&cb->pending,
-					__ofono_error_failed(cb->pending));
 		return;
 	}
 =

@@ -307,7 +339,11 @@ static void cb_ss_query_next_lock_callback(const struc=
t ofono_error *error,
 		return;
 	}
 =

-	generate_ss_query_reply(cb);
+	if (cb->pending)
+		generate_ss_query_reply(cb);
+	else
+		__ofono_stk_send_ss_response(cb->stk, &cb->stk_pending, error);
+
 	update_barrings(cb, BEARER_CLASS_VOICE);
 }
 =

@@ -328,8 +364,7 @@ static void cb_ss_set_lock_callback(const struct ofono_=
error *error,
 =

 	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
 		DBG("Enabling/disabling Call Barring via SS failed");
-		__ofono_dbus_pending_reply(&cb->pending,
-					__ofono_error_failed(cb->pending));
+		reply_error(cb, error);
 		return;
 	}
 =

@@ -359,25 +394,19 @@ static const char *cb_ss_service_to_fac(const char *s=
vc)
 	return NULL;
 }
 =

-static gboolean cb_ss_control(int type, const char *sc,
+static int cb_ss_control(int type, const char *sc,
 				const char *sia, const char *sib,
 				const char *sic, const char *dn,
-				DBusMessage *msg, void *data)
+				struct ofono_ss_req *osr, void *data)
 {
 	struct ofono_call_barring *cb =3D data;
-	DBusConnection *conn =3D ofono_dbus_get_connection();
 	int cls =3D BEARER_CLASS_DEFAULT;
 	const char *fac;
-	DBusMessage *reply;
 	void *operation =3D NULL;
 	int i;
 =

-	if (cb->pending) {
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

@@ -386,7 +415,7 @@ static gboolean cb_ss_control(int type, const char *sc,
 =

 	fac =3D cb_ss_service_to_fac(sc);
 	if (!fac)
-		return FALSE;
+		return -ENOENT;
 =

 	cb_set_query_bounds(cb, fac, type =3D=3D SS_CONTROL_TYPE_QUERY);
 =

@@ -397,13 +426,13 @@ static gboolean cb_ss_control(int type, const char *s=
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
@@ -419,12 +448,8 @@ static gboolean cb_ss_control(int type, const char *sc,
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
@@ -433,7 +458,7 @@ static gboolean cb_ss_control(int type, const char *sc,
 	if ((!strcmp(fac, "AG") || !strcmp(fac, "AC") || !strcmp(fac, "AB")) &&
 		(type =3D=3D SS_CONTROL_TYPE_ACTIVATION ||
 			type =3D=3D SS_CONTROL_TYPE_REGISTRATION))
-		goto bad_format;
+		return EINVAL;
 =

 	if (strlen(sib) > 0) {
 		long service_code;
@@ -442,16 +467,16 @@ static gboolean cb_ss_control(int type, const char *s=
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
-	cb->pending =3D dbus_message_ref(msg);
+	set_pending(cb, osr);
 =

 	switch (type) {
 	case SS_CONTROL_TYPE_ACTIVATION:
@@ -472,44 +497,35 @@ static gboolean cb_ss_control(int type, const char *s=
c,
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
 {
 	struct ofono_call_barring *cb =3D data;
-	DBusMessage *reply;
 =

-	if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR)
-		reply =3D dbus_message_new_method_return(cb->pending);
-	else {
-		reply =3D __ofono_error_failed(cb->pending);
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
 		DBG("Changing Call Barring password via SS failed");
+		reply_error(cb, error);
+		return;
 	}
 =

-	__ofono_dbus_pending_reply(&cb->pending, reply);
+	if (cb->pending)
+		__ofono_dbus_pending_reply(&cb->pending,
+				dbus_message_new_method_return(cb->pending));
+	else
+		__ofono_stk_send_ss_response(cb->stk, &cb->stk_pending, error);
 }
 =

-static gboolean cb_ss_passwd(const char *sc,
+static int cb_ss_passwd(const char *sc,
 				const char *old, const char *new,
-				DBusMessage *msg, void *data)
+				struct ofono_ss_req *osr, void *data)
 {
 	struct ofono_call_barring *cb =3D data;
-	DBusConnection *conn =3D ofono_dbus_get_connection();
-	DBusMessage *reply;
 	const char *fac;
 =

-	if (cb->pending) {
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

@@ -521,19 +537,16 @@ static gboolean cb_ss_passwd(const char *sc,
 		fac =3D cb_ss_service_to_fac(sc);
 =

 	if (!fac)
-		return FALSE;
+		return -ENOENT;
 =

 	if (!is_valid_pin(old, PIN_TYPE_NET) || !is_valid_pin(new, PIN_TYPE_NET))
-		goto bad_format;
+		return EINVAL;
+
+	set_pending(cb, osr);
 =

-	cb->pending =3D dbus_message_ref(msg);
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
@@ -580,11 +593,6 @@ static void cb_unregister_ss_controls(struct ofono_cal=
l_barring *cb)
 	__ofono_ussd_passwd_unregister(cb->ussd, "353");
 }
 =

-gboolean __ofono_call_barring_is_busy(struct ofono_call_barring *cb)
-{
-	return cb->pending ? TRUE : FALSE;
-}
-
 static inline void cb_append_property(struct ofono_call_barring *cb,
 					DBusMessageIter *dict, int start,
 					int end, int cls, const char *property)
@@ -674,7 +682,7 @@ static DBusMessage *cb_get_properties(DBusConnection *c=
onn, DBusMessage *msg,
 {
 	struct ofono_call_barring *cb =3D data;
 =

-	if (cb->pending || __ofono_ussd_is_busy(cb->ussd))
+	if (__ofono_call_barring_is_busy(cb) || __ofono_ussd_is_busy(cb->ussd))
 		return __ofono_error_busy(msg);
 =

 	if (!cb->driver->query)
@@ -827,7 +835,7 @@ static DBusMessage *cb_set_property(DBusConnection *con=
n, DBusMessage *msg,
 	int cls;
 	int mode;
 =

-	if (cb->pending || __ofono_ussd_is_busy(cb->ussd))
+	if (__ofono_call_barring_is_busy(cb) || __ofono_ussd_is_busy(cb->ussd))
 		return __ofono_error_busy(msg);
 =

 	if (!dbus_message_iter_init(msg, &iter))
@@ -899,7 +907,7 @@ static DBusMessage *cb_disable_all(DBusConnection *conn=
, DBusMessage *msg,
 	if (!cb->driver->set)
 		return __ofono_error_not_implemented(msg);
 =

-	if (cb->pending || __ofono_ussd_is_busy(cb->ussd))
+	if (__ofono_call_barring_is_busy(cb) || __ofono_ussd_is_busy(cb->ussd))
 		return __ofono_error_busy(msg);
 =

 	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &passwd,
@@ -946,7 +954,7 @@ static DBusMessage *cb_set_passwd(DBusConnection *conn,=
 DBusMessage *msg,
 	if (!cb->driver->set_passwd)
 		return __ofono_error_not_implemented(msg);
 =

-	if (cb->pending || __ofono_ussd_is_busy(cb->ussd))
+	if (__ofono_call_barring_is_busy(cb) || __ofono_ussd_is_busy(cb->ussd))
 		return __ofono_error_busy(msg);
 =

 	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &old_passwd,
@@ -1150,6 +1158,19 @@ static void ussd_watch(struct ofono_atom *atom,
 	cb_register_ss_controls(cb);
 }
 =

+static void stk_watch(struct ofono_atom *atom,
+			enum ofono_atom_watch_condition cond, void *data)
+{
+	struct ofono_call_barring *cb =3D data;
+
+	if (cond =3D=3D OFONO_ATOM_WATCH_CONDITION_UNREGISTERED) {
+		cb->stk =3D NULL;
+		return;
+	}
+
+	cb->stk =3D __ofono_atom_get_data(atom);
+}
+
 void ofono_call_barring_register(struct ofono_call_barring *cb)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
@@ -1157,6 +1178,7 @@ void ofono_call_barring_register(struct ofono_call_ba=
rring *cb)
 	struct ofono_modem *modem =3D __ofono_atom_get_modem(cb->atom);
 	struct ofono_atom *ssn_atom;
 	struct ofono_atom *ussd_atom;
+	struct ofono_atom *stk_atom;
 =

 	if (!g_dbus_register_interface(conn, path,
 					OFONO_CALL_BARRING_INTERFACE,
@@ -1188,6 +1210,16 @@ void ofono_call_barring_register(struct ofono_call_b=
arring *cb)
 		ussd_watch(ussd_atom, OFONO_ATOM_WATCH_CONDITION_REGISTERED,
 				cb);
 =

+	cb->stk_watch =3D __ofono_modem_add_atom_watch(modem,
+					OFONO_ATOM_TYPE_STK,
+					stk_watch, cb, NULL);
+
+	stk_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_STK);
+
+	if (stk_atom && __ofono_atom_get_registered(stk_atom))
+		stk_watch(stk_atom, OFONO_ATOM_WATCH_CONDITION_REGISTERED,
+				cb);
+
 	__ofono_atom_register(cb->atom, call_barring_unregister);
 }
 =

diff --git a/src/call-forwarding.c b/src/call-forwarding.c
index 5eae6cf..9161121 100644
--- a/src/call-forwarding.c
+++ b/src/call-forwarding.c
@@ -55,11 +55,14 @@ struct ofono_call_forwarding {
 	GSList *cf_conditions[4];
 	int flags;
 	DBusMessage *pending;
+	ofono_bool_t stk_pending;
 	int query_next;
 	int query_end;
 	struct cf_ss_request *ss_req;
 	struct ofono_ussd *ussd;
+	struct ofono_stk *stk;
 	unsigned int ussd_watch;
+	unsigned int stk_watch;
 	const struct ofono_call_forwarding_driver *driver;
 	void *driver_data;
 	struct ofono_atom *atom;
@@ -77,6 +80,36 @@ struct cf_ss_request {
 	GSList *cf_list[4];
 };
 =

+gboolean __ofono_call_forwarding_is_busy(struct ofono_call_forwarding *cf)
+{
+	if (!cf)
+		return FALSE;
+
+	if (cf->pending || cf->stk_pending)
+		return TRUE;
+
+	return FALSE;
+}
+
+static void reply_error(struct ofono_call_forwarding *cf,
+				const struct ofono_error *error)
+{
+	if (cf->pending)
+		__ofono_dbus_pending_reply(&cf->pending,
+				__ofono_error_failed(cf->pending));
+	else
+		__ofono_stk_send_ss_response(cf->stk, &cf->stk_pending, error);
+}
+
+static void set_pending(struct ofono_call_forwarding *cf,
+				struct ofono_ss_req *osr)
+{
+	if (osr->msg)
+		cf->pending =3D dbus_message_ref(osr->msg);
+	else
+		cf->stk_pending =3D TRUE;
+}
+
 static gint cf_condition_compare(gconstpointer a, gconstpointer b)
 {
 	const struct ofono_call_forwarding_condition *ca =3D a;
@@ -430,7 +463,8 @@ static DBusMessage *cf_get_properties(DBusConnection *c=
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
@@ -586,7 +620,8 @@ static DBusMessage *cf_set_property(DBusConnection *con=
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
@@ -704,7 +739,8 @@ static DBusMessage *cf_disable_all(DBusConnection *conn=
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
@@ -823,13 +859,11 @@ static void ss_set_query_cf_callback(const struct ofo=
no_error *error, int total,
 {
 	struct ofono_call_forwarding *cf =3D data;
 	GSList *l;
-	DBusMessage *reply;
 =

 	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
 		ofono_error("Setting succeeded, but query failed");
 		cf->flags &=3D ~CALL_FORWARDING_FLAG_CACHED;
-		reply =3D __ofono_error_failed(cf->pending);
-		__ofono_dbus_pending_reply(&cf->pending, reply);
+		reply_error(cf, error);
 		return;
 	}
 =

@@ -840,8 +874,13 @@ static void ss_set_query_cf_callback(const struct ofon=
o_error *error, int total,
 	cf->ss_req->cf_list[cf->query_next] =3D l;
 =

 	if (cf->query_next =3D=3D cf->query_end) {
-		reply =3D cf_ss_control_reply(cf, cf->ss_req);
-		__ofono_dbus_pending_reply(&cf->pending, reply);
+		if (cf->pending)
+			__ofono_dbus_pending_reply(&cf->pending,
+					cf_ss_control_reply(cf, cf->ss_req));
+		else
+			__ofono_stk_send_ss_response(cf->stk, &cf->stk_pending,
+							error);
+
 		g_free(cf->ss_req);
 		cf->ss_req =3D NULL;
 	}
@@ -866,9 +905,7 @@ static void cf_ss_control_callback(const struct ofono_e=
rror *error, void *data)
 =

 	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
 		DBG("Error occurred during cf ss control set/erasure");
-
-		__ofono_dbus_pending_reply(&cf->pending,
-					__ofono_error_failed(cf->pending));
+		reply_error(cf, error);
 		g_free(cf->ss_req);
 		cf->ss_req =3D NULL;
 		return;
@@ -877,30 +914,24 @@ static void cf_ss_control_callback(const struct ofono=
_error *error, void *data)
 	ss_set_query_next_cf_cond(cf);
 }
 =

-static gboolean cf_ss_control(int type, const char *sc,
+static int cf_ss_control(int type, const char *sc,
 				const char *sia, const char *sib,
 				const char *sic, const char *dn,
-				DBusMessage *msg, void *data)
+				struct ofono_ss_req *osr, void *data)
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

-	if (cf->pending) {
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

@@ -920,13 +951,13 @@ static gboolean cf_ss_control(int type, const char *s=
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
@@ -937,8 +968,8 @@ static gboolean cf_ss_control(int type, const char *sc,
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
@@ -947,32 +978,32 @@ static gboolean cf_ss_control(int type, const char *s=
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
@@ -993,27 +1024,19 @@ static gboolean cf_ss_control(int type, const char *=
sc,
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
 	cf->ss_req->cls =3D cls;
 =

-	cf->pending =3D dbus_message_ref(msg);
+	set_pending(cf, osr);
 =

 	switch (cf->ss_req->cf_type) {
 	case CALL_FORWARDING_TYPE_ALL:
@@ -1062,12 +1085,7 @@ static gboolean cf_ss_control(int type, const char *=
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
@@ -1092,11 +1110,6 @@ static void cf_unregister_ss_controls(struct ofono_c=
all_forwarding *cf)
 	__ofono_ussd_ssc_unregister(cf->ussd, "004");
 }
 =

-gboolean __ofono_call_forwarding_is_busy(struct ofono_call_forwarding *cf)
-{
-	return cf->pending ? TRUE : FALSE;
-}
-
 int ofono_call_forwarding_driver_register(const struct ofono_call_forwardi=
ng_driver *d)
 {
 	DBG("driver: %p, name: %s", d, d->name);
@@ -1200,12 +1213,26 @@ static void ussd_watch(struct ofono_atom *atom,
 	cf_register_ss_controls(cf);
 }
 =

+static void stk_watch(struct ofono_atom *atom,
+			enum ofono_atom_watch_condition cond, void *data)
+{
+	struct ofono_call_forwarding *cf =3D data;
+
+	if (cond =3D=3D OFONO_ATOM_WATCH_CONDITION_UNREGISTERED) {
+		cf->stk =3D NULL;
+		return;
+	}
+
+	cf->stk =3D __ofono_atom_get_data(atom);
+}
+
 void ofono_call_forwarding_register(struct ofono_call_forwarding *cf)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
 	const char *path =3D __ofono_atom_get_path(cf->atom);
 	struct ofono_modem *modem =3D __ofono_atom_get_modem(cf->atom);
 	struct ofono_atom *ussd_atom;
+	struct ofono_atom *stk_atom;
 =

 	if (!g_dbus_register_interface(conn, path,
 					OFONO_CALL_FORWARDING_INTERFACE,
@@ -1229,6 +1256,16 @@ void ofono_call_forwarding_register(struct ofono_cal=
l_forwarding *cf)
 		ussd_watch(ussd_atom, OFONO_ATOM_WATCH_CONDITION_REGISTERED,
 				cf);
 =

+	cf->stk_watch =3D __ofono_modem_add_atom_watch(modem,
+					OFONO_ATOM_TYPE_STK,
+					stk_watch, cf, NULL);
+
+	stk_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_STK);
+
+	if (stk_atom && __ofono_atom_get_registered(stk_atom))
+		stk_watch(stk_atom, OFONO_ATOM_WATCH_CONDITION_REGISTERED,
+				cf);
+
 	__ofono_atom_register(cf->atom, call_forwarding_unregister);
 }
 =

diff --git a/src/call-settings.c b/src/call-settings.c
index 0c46a2a..4b8d71f 100644
--- a/src/call-settings.c
+++ b/src/call-settings.c
@@ -86,16 +86,49 @@ struct ofono_call_settings {
 	int cw;
 	int flags;
 	DBusMessage *pending;
+	ofono_bool_t stk_pending;
 	int ss_req_type;
 	int ss_req_cls;
 	enum call_setting_type ss_setting;
 	struct ofono_ussd *ussd;
+	struct ofono_stk *stk;
 	unsigned int ussd_watch;
+	unsigned int stk_watch;
 	const struct ofono_call_settings_driver *driver;
 	void *driver_data;
 	struct ofono_atom *atom;
 };
 =

+gboolean __ofono_call_settings_is_busy(struct ofono_call_settings *cs)
+{
+	if (!cs)
+		return FALSE;
+
+	if (cs->pending || cs->stk_pending)
+		return TRUE;
+
+	return FALSE;
+}
+
+static void reply_error(struct ofono_call_settings *cs,
+				const struct ofono_error *error)
+{
+	if (cs->pending)
+		__ofono_dbus_pending_reply(&cs->pending,
+				__ofono_error_failed(cs->pending));
+	else
+		__ofono_stk_send_ss_response(cs->stk, &cs->stk_pending,	error);
+}
+
+static void set_pending(struct ofono_call_settings *cs,
+				struct ofono_ss_req *osr)
+{
+	if (osr->msg)
+		cs->pending =3D dbus_message_ref(osr->msg);
+	else
+		cs->stk_pending =3D TRUE;
+}
+
 static const char *clip_status_to_string(int status)
 {
 	switch (status) {
@@ -375,15 +408,17 @@ static void cw_ss_query_callback(const struct ofono_e=
rror *error, int status,
 		DBG("setting CW via SS failed");
 =

 		cs->flags &=3D ~CALL_SETTINGS_FLAG_CACHED;
-		__ofono_dbus_pending_reply(&cs->pending,
-					__ofono_error_failed(cs->pending));
+		reply_error(cs, error);
 =

 		return;
 	}
 =

 	set_cw(cs, status, BEARER_CLASS_VOICE);
 =

-	generate_cw_ss_query_reply(cs);
+	if (cs->pending)
+		generate_cw_ss_query_reply(cs);
+	else
+		__ofono_stk_send_ss_response(cs->stk, &cs->stk_pending, error);
 }
 =

 static void cw_ss_set_callback(const struct ofono_error *error, void *data)
@@ -392,8 +427,7 @@ static void cw_ss_set_callback(const struct ofono_error=
 *error, void *data)
 =

 	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
 		DBG("setting CW via SS failed");
-		__ofono_dbus_pending_reply(&cs->pending,
-					__ofono_error_failed(cs->pending));
+		reply_error(cs, error);
 =

 		return;
 	}
@@ -402,35 +436,29 @@ static void cw_ss_set_callback(const struct ofono_err=
or *error, void *data)
 				cw_ss_query_callback, cs);
 }
 =

-static gboolean cw_ss_control(int type,
-				const char *sc, const char *sia,
+static int cw_ss_control(int type, const char *sc, const char *sia,
 				const char *sib, const char *sic,
-				const char *dn, DBusMessage *msg, void *data)
+				const char *dn, struct ofono_ss_req *osr,
+				void *data)
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

-	if (cs->pending) {
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
@@ -439,15 +467,15 @@ static gboolean cw_ss_control(int type,
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
-	cs->pending =3D dbus_message_ref(msg);
+	set_pending(cs, osr);
 =

 	/* For the default case use the more readily accepted value */
 	if (cls =3D=3D BEARER_CLASS_SS_DEFAULT)
@@ -477,13 +505,7 @@ static gboolean cw_ss_control(int type,
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
@@ -528,8 +550,7 @@ static void clip_colp_colr_ss_query_cb(const struct ofo=
no_error *error,
 =

 	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
 		DBG("Error occurred during ss control query");
-		__ofono_dbus_pending_reply(&cs->pending,
-					__ofono_error_failed(cs->pending));
+		reply_error(cs, error);
 =

 		return;
 	}
@@ -560,28 +581,26 @@ static void clip_colp_colr_ss_query_cb(const struct o=
fono_error *error,
 		return;
 	};
 =

-	generate_ss_query_reply(cs, context, value);
+	if (cs->pending)
+		generate_ss_query_reply(cs, context, value);
+	else
+		__ofono_stk_send_ss_response(cs->stk, &cs->stk_pending, error);
 }
 =

-static gboolean clip_colp_colr_ss(int type,
-				const char *sc, const char *sia,
+static int clip_colp_colr_ss(int type, const char *sc, const char *sia,
 				const char *sib, const char *sic,
-				const char *dn, DBusMessage *msg, void *data)
+				const char *dn, struct ofono_ss_req *osr,
+				void *data)
 {
 	struct ofono_call_settings *cs =3D data;
-	DBusConnection *conn =3D ofono_dbus_get_connection();
 	void (*query_op)(struct ofono_call_settings *cs,
 				ofono_call_settings_status_cb_t cb, void *data);
 =

 	if (!cs)
-		return FALSE;
+		return -ENOENT;
 =

-	if (cs->pending) {
-		DBusMessage *reply =3D __ofono_error_busy(msg);
-		g_dbus_send_message(conn, reply);
-
-		return TRUE;
-	}
+	if (__ofono_call_settings_is_busy(cs))
+		return EBUSY;
 =

 	if (!strcmp(sc, "30")) {
 		cs->ss_setting =3D CALL_SETTING_TYPE_CLIP;
@@ -593,31 +612,23 @@ static gboolean clip_colp_colr_ss(int type,
 		cs->ss_setting =3D CALL_SETTING_TYPE_COLR;
 		query_op =3D cs->driver->colr_query;
 	} else {
-		return FALSE;
+		return -ENOENT;
 	}
 =

 	if (type !=3D SS_CONTROL_TYPE_QUERY || strlen(sia) || strlen(sib) ||
-		strlen(sic) || strlen(dn)) {
-		DBusMessage *reply =3D __ofono_error_invalid_format(msg);
-		g_dbus_send_message(conn, reply);
-
-		return TRUE;
-	}
-
-	if (!query_op) {
-		DBusMessage *reply =3D __ofono_error_not_implemented(msg);
-		g_dbus_send_message(conn, reply);
+			strlen(sic) || strlen(dn))
+		return EINVAL;
 =

-		return TRUE;
-	}
+	if (!query_op)
+		return ENOSYS;
 =

 	DBG("Received CLIP/COLR/COLP query ss control");
 =

-	cs->pending =3D dbus_message_ref(msg);
+	set_pending(cs, osr);
 =

 	query_op(cs, clip_colp_colr_ss_query_cb, cs);
 =

-	return TRUE;
+	return 0;
 }
 =

 static void clir_ss_query_callback(const struct ofono_error *error,
@@ -628,8 +639,7 @@ static void clir_ss_query_callback(const struct ofono_e=
rror *error,
 =

 	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
 		DBG("setting clir via SS failed");
-		__ofono_dbus_pending_reply(&cs->pending,
-					__ofono_error_failed(cs->pending));
+		reply_error(cs, error);
 =

 		return;
 	}
@@ -664,7 +674,10 @@ static void clir_ss_query_callback(const struct ofono_=
error *error,
 		value =3D "unknown";
 	};
 =

-	generate_ss_query_reply(cs, "CallingLineRestriction", value);
+	if (cs->pending)
+		generate_ss_query_reply(cs, "CallingLineRestriction", value);
+	else
+		__ofono_stk_send_ss_response(cs->stk, &cs->stk_pending, error);
 =

 	set_clir_network(cs, network);
 	set_clir_override(cs, override);
@@ -676,8 +689,8 @@ static void clir_ss_set_callback(const struct ofono_err=
or *error, void *data)
 =

 	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
 		DBG("setting clir via SS failed");
-		__ofono_dbus_pending_reply(&cs->pending,
-					__ofono_error_failed(cs->pending));
+
+		reply_error(cs, error);
 =

 		return;
 	}
@@ -685,49 +698,37 @@ static void clir_ss_set_callback(const struct ofono_e=
rror *error, void *data)
 	cs->driver->clir_query(cs, clir_ss_query_callback, cs);
 }
 =

-static gboolean clir_ss_control(int type,
-				const char *sc, const char *sia,
+static int clir_ss_control(int type, const char *sc, const char *sia,
 				const char *sib, const char *sic,
-				const char *dn, DBusMessage *msg, void *data)
+				const char *dn, struct ofono_ss_req *osr,
+				void *data)
 {
 	struct ofono_call_settings *cs =3D data;
-	DBusConnection *conn =3D ofono_dbus_get_connection();
 =

 	if (!cs)
-		return FALSE;
+		return -ENOENT;
 =

 	if (strcmp(sc, "31"))
-		return FALSE;
-
-	if (cs->pending) {
-		DBusMessage *reply =3D __ofono_error_busy(msg);
-		g_dbus_send_message(conn, reply);
+		return -ENOENT;
 =

-		return TRUE;
-	}
+	if (__ofono_call_settings_is_busy(cs))
+		return EBUSY;
 =

 	/* This is the temporary form of CLIR, handled in voicecalls */
 	if (!strlen(sia) && !strlen(sib) & !strlen(sic) &&
-		strlen(dn) && type !=3D SS_CONTROL_TYPE_QUERY)
-		return FALSE;
-
-	if (strlen(sia) || strlen(sib) || strlen(sic) || strlen(dn)) {
-		DBusMessage *reply =3D __ofono_error_invalid_format(msg);
-		g_dbus_send_message(conn, reply);
+			strlen(dn) && type !=3D SS_CONTROL_TYPE_QUERY)
+		return -ENOENT;
 =

-		return TRUE;
-	}
+	if (strlen(sia) || strlen(sib) || strlen(sic) || strlen(dn))
+		return EINVAL;
 =

 	if ((type =3D=3D SS_CONTROL_TYPE_QUERY && !cs->driver->clir_query) ||
-		(type !=3D SS_CONTROL_TYPE_QUERY && !cs->driver->clir_set)) {
-		DBusMessage *reply =3D __ofono_error_not_implemented(msg);
-		g_dbus_send_message(conn, reply);
-
-		return TRUE;
-	}
+			(type !=3D SS_CONTROL_TYPE_QUERY &&
+					!cs->driver->clir_set))
+		return ENOSYS;
 =

 	cs->ss_setting =3D CALL_SETTING_TYPE_CLIR;
-	cs->pending =3D dbus_message_ref(msg);
+	set_pending(cs, osr);
 =

 	switch (type) {
 	case SS_CONTROL_TYPE_REGISTRATION:
@@ -750,7 +751,7 @@ static gboolean clir_ss_control(int type,
 		break;
 	};
 =

-	return TRUE;
+	return 0;
 }
 =

 static void cs_register_ss_controls(struct ofono_call_settings *cs)
@@ -778,11 +779,6 @@ static void cs_unregister_ss_controls(struct ofono_cal=
l_settings *cs)
 		__ofono_ussd_ssc_unregister(cs->ussd, "77");
 }
 =

-gboolean __ofono_call_settings_is_busy(struct ofono_call_settings *cs)
-{
-	return cs->pending ? TRUE : FALSE;
-}
-
 static DBusMessage *generate_get_properties_reply(struct ofono_call_settin=
gs *cs,
 							DBusMessage *msg)
 {
@@ -955,7 +951,7 @@ static DBusMessage *cs_get_properties(DBusConnection *c=
onn, DBusMessage *msg,
 {
 	struct ofono_call_settings *cs =3D data;
 =

-	if (cs->pending || __ofono_ussd_is_busy(cs->ussd))
+	if (__ofono_call_settings_is_busy(cs) || __ofono_ussd_is_busy(cs->ussd))
 		return __ofono_error_busy(msg);
 =

 	if (cs->flags & CALL_SETTINGS_FLAG_CACHED)
@@ -1132,7 +1128,7 @@ static DBusMessage *cs_set_property(DBusConnection *c=
onn, DBusMessage *msg,
 	const char *property;
 	int cls;
 =

-	if (cs->pending || __ofono_ussd_is_busy(cs->ussd))
+	if (__ofono_call_settings_is_busy(cs) || __ofono_ussd_is_busy(cs->ussd))
 		return __ofono_error_busy(msg);
 =

 	if (!dbus_message_iter_init(msg, &iter))
@@ -1290,12 +1286,26 @@ static void ussd_watch(struct ofono_atom *atom,
 	cs_register_ss_controls(cs);
 }
 =

+static void stk_watch(struct ofono_atom *atom,
+			enum ofono_atom_watch_condition cond, void *data)
+{
+	struct ofono_call_settings *cs =3D data;
+
+	if (cond =3D=3D OFONO_ATOM_WATCH_CONDITION_UNREGISTERED) {
+		cs->stk =3D NULL;
+		return;
+	}
+
+	cs->stk =3D __ofono_atom_get_data(atom);
+}
+
 void ofono_call_settings_register(struct ofono_call_settings *cs)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
 	const char *path =3D __ofono_atom_get_path(cs->atom);
 	struct ofono_modem *modem =3D __ofono_atom_get_modem(cs->atom);
 	struct ofono_atom *ussd_atom;
+	struct ofono_atom *stk_atom;
 =

 	if (!g_dbus_register_interface(conn, path,
 					OFONO_CALL_SETTINGS_INTERFACE,
@@ -1319,6 +1329,16 @@ void ofono_call_settings_register(struct ofono_call_=
settings *cs)
 		ussd_watch(ussd_atom, OFONO_ATOM_WATCH_CONDITION_REGISTERED,
 				cs);
 =

+	cs->stk_watch =3D __ofono_modem_add_atom_watch(modem,
+					OFONO_ATOM_TYPE_STK,
+					stk_watch, cs, NULL);
+
+	stk_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_STK);
+
+	if (stk_atom && __ofono_atom_get_registered(stk_atom))
+		stk_watch(stk_atom, OFONO_ATOM_WATCH_CONDITION_REGISTERED,
+				cs);
+
 	__ofono_atom_register(cs->atom, call_settings_unregister);
 }
 =

diff --git a/src/ofono.h b/src/ofono.h
index f1c0973..50d4f96 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -166,6 +166,12 @@ gboolean __ofono_modem_remove_atom_watch(struct ofono_=
modem *modem,
 =

 void __ofono_atom_free(struct ofono_atom *atom);
 =

+#include <gdbus.h>
+struct ofono_ss_req {
+	DBusMessage *msg;
+	gboolean stk;
+};
+
 #include <ofono/call-barring.h>
 =

 gboolean __ofono_call_barring_is_busy(struct ofono_call_barring *cb);
@@ -228,6 +234,8 @@ unsigned int __ofono_sms_txq_submit(struct ofono_sms *s=
ms, GSList *list,
 =

 struct cbs;
 void __ofono_cbs_sim_download(struct ofono_stk *stk, const struct cbs *msg=
);
+void __ofono_stk_send_ss_response(struct ofono_stk *stk, gboolean *stk_pen=
ding,
+					const struct ofono_error *error);
 =

 #include <ofono/ssn.h>
 =

@@ -252,11 +260,11 @@ typedef gboolean (*ofono_ussd_ssc_cb_t)(int type,
 					const char *sc,
 					const char *sia, const char *sib,
 					const char *sic, const char *dn,
-					DBusMessage *msg, void *data);
+					struct ofono_ss_req *osr, void *data);
 =

 typedef gboolean (*ofono_ussd_passwd_cb_t)(const char *sc,
 					const char *old, const char *new,
-					DBusMessage *msg, void *data);
+					struct ofono_ss_req *osr, void *data);
 =

 gboolean __ofono_ussd_ssc_register(struct ofono_ussd *ussd, const char *sc,
 					ofono_ussd_ssc_cb_t cb, void *data,
@@ -268,6 +276,9 @@ gboolean __ofono_ussd_passwd_register(struct ofono_ussd=
 *ussd, const char *sc,
 					ofono_destroy_func destroy);
 void __ofono_ussd_passwd_unregister(struct ofono_ussd *ussd, const char *s=
c);
 gboolean __ofono_ussd_is_busy(struct ofono_ussd *ussd);
+int __ofono_ussd_recognized_control_string(struct ofono_ussd *ussd,
+						const char *ss_str,
+						struct ofono_ss_req *osr);
 =

 #include <ofono/netreg.h>
 =

diff --git a/src/stk.c b/src/stk.c
index 04bfc65..e273914 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -648,6 +648,13 @@ static GDBusSignalTable stk_signals[] =3D {
 	{ }
 };
 =

+static gboolean set_result_type(struct stk_response *rsp,
+					enum stk_result_type type)
+{
+	rsp->result.type =3D type;
+	return TRUE;
+}
+
 static gboolean handle_command_more_time(const struct stk_command *cmd,
 						struct stk_response *rsp,
 						struct ofono_stk *stk)
@@ -731,6 +738,92 @@ static gboolean handle_command_send_sms(const struct s=
tk_command *cmd,
 	return FALSE;
 }
 =

+void __ofono_stk_send_ss_response(struct ofono_stk *stk, gboolean *stk_pen=
ding,
+					const struct ofono_error *error)
+{
+	static struct ofono_error oe =3D { .type =3D OFONO_ERROR_TYPE_FAILURE };
+	struct stk_response rsp;
+	unsigned char addnl[2];
+
+	*stk_pending =3D FALSE;
+
+	memset(&rsp, 0, sizeof(rsp));
+
+	switch (error->type) {
+	case OFONO_ERROR_TYPE_NO_ERROR:
+		rsp.result.type =3D STK_RESULT_TYPE_SUCCESS;
+		break;
+	default:
+		rsp.result.type =3D STK_RESULT_TYPE_SS_RETURN_ERROR;
+		addnl[0] =3D (unsigned char) error->error;
+		addnl[1] =3D STK_RESULT_ADDNL_SS_PB_NO_SPECIFIC_CAUSE;
+		rsp.result.additional =3D addnl;
+		rsp.result.additional_len =3D 2;
+		break;
+	}
+
+	if (stk->pending_cmd->send_ss.alpha_id &&
+			stk->pending_cmd->send_ss.alpha_id[0])
+		stk_alpha_id_unset(stk);
+
+	if (stk_respond(stk, &rsp, stk_command_cb))
+		stk_command_cb(&oe, stk);
+}
+
+static gboolean handle_command_send_ss(const struct stk_command *cmd,
+					struct stk_response *rsp,
+					struct ofono_stk *stk)
+{
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(stk->atom);
+	char *str =3D cmd->send_ss.ss.ss;
+	struct ofono_atom *ussd_atom;
+	struct ofono_ussd *ussd;
+	int result;
+	struct ofono_ss_req *osr;
+
+	ussd_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_USSD);
+
+	if (!ussd_atom || !__ofono_atom_get_registered(ussd_atom))
+		return set_result_type(rsp, STK_RESULT_TYPE_NOT_CAPABLE);
+
+	ussd =3D __ofono_atom_get_data(ussd_atom);
+
+	if (__ofono_ussd_is_busy(ussd))
+		return set_result_type(rsp, STK_RESULT_TYPE_TERMINAL_BUSY);
+
+	if (strlen(str) =3D=3D 0)
+		return set_result_type(rsp,
+					STK_RESULT_TYPE_COMMAND_NOT_UNDERSTOOD);
+
+	osr =3D g_try_new0(struct ofono_ss_req, 1);
+	if (!osr)
+		return set_result_type(rsp, STK_RESULT_TYPE_NOT_CAPABLE);
+
+	osr->stk =3D TRUE;
+
+	result =3D __ofono_ussd_recognized_control_string(ussd, str, osr);
+	g_free(osr);
+
+	switch (result) {
+	case EBUSY:
+		return set_result_type(rsp, STK_RESULT_TYPE_TERMINAL_BUSY);
+	case ENOSYS:
+	case ENOMEM:
+		return set_result_type(rsp, STK_RESULT_TYPE_NOT_CAPABLE);
+	case 0:
+		break;
+	case EINVAL:
+	default:
+		return set_result_type(rsp,
+					STK_RESULT_TYPE_COMMAND_NOT_UNDERSTOOD);
+	}
+
+	if (cmd->send_ss.alpha_id && cmd->send_ss.alpha_id[0])
+		stk_alpha_id_set(stk, cmd->send_ss.alpha_id);
+
+	return FALSE;
+}
+
 static gboolean handle_command_set_idle_text(const struct stk_command *cmd,
 						struct stk_response *rsp,
 						struct ofono_stk *stk)
@@ -1696,6 +1789,11 @@ void ofono_stk_proactive_command_notify(struct ofono=
_stk *stk,
 							&rsp, stk);
 		break;
 =

+	case STK_COMMAND_TYPE_SEND_SS:
+		respond =3D handle_command_send_ss(stk->pending_cmd,
+							&rsp, stk);
+		break;
+
 	case STK_COMMAND_TYPE_SETUP_IDLE_MODE_TEXT:
 		respond =3D handle_command_set_idle_text(stk->pending_cmd,
 							&rsp, stk);
diff --git a/src/stkutil.c b/src/stkutil.c
index 3cfe06a..e21698b 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -5441,6 +5441,8 @@ const unsigned char *stk_pdu_from_response(const stru=
ct stk_response *response,
 					&response->select_item.item_id,
 					NULL);
 		break;
+	case STK_COMMAND_TYPE_SEND_SS:
+		break;
 	case STK_COMMAND_TYPE_SETUP_CALL:
 		ok =3D build_setup_call(&builder, response);
 		break;
diff --git a/src/stkutil.h b/src/stkutil.h
index c432df8..2b8f53a 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -254,6 +254,8 @@ enum stk_result_type {
 	STK_RESULT_TYPE_COMMAND_NOT_UNDERSTOOD =3D	0x31,
 	STK_RESULT_TYPE_DATA_NOT_UNDERSTOOD =3D		0x32,
 	STK_RESULT_TYPE_COMMAND_ID_UNKNOWN =3D		0x33,
+	STK_RESULT_TYPE_SS_RETURN_ERROR =3D		0x34,
+	STK_RESULT_TYPE_SMS_RP_ERROR =3D			0x35,
 	STK_RESULT_TYPE_MINIMUM_NOT_MET =3D		0x36,
 	STK_RESULT_TYPE_USSD_RETURN_ERROR =3D		0x37,
 	STK_RESULT_TYPE_CALL_CONTROL_PERMANENT =3D	0x39,
@@ -263,6 +265,27 @@ enum stk_result_type {
 	STK_RESULT_TYPE_MMS_ERROR =3D			0x3D,
 };
 =

+enum stk_result_addnl_me_pb_fb {
+	STK_RESULT_ADDNL_ME_PB_NO_SPECIFIC_CAUSE =3D	0x00,
+	STK_RESULT_ADDNL_ME_PB_SCREEN_BUSY =3D		0x01,
+	STK_RESULT_ADDNL_ME_PB_BUSY_ON_CALL =3D		0x02,
+	STK_RESULT_ADDNL_ME_PB_NO_SERVICE =3D		0x04,
+	STK_RESULT_ADDNL_ME_PB_NO_ACCESS =3D		0x05,
+	STK_RESULT_ADDNL_ME_PB_NO_RADIO_RESOURCE =3D	0x06,
+	STK_RESULT_ADDNL_ME_PB_NOT_IN_SPEECH_CALL =3D	0x07,
+	STK_RESULT_ADDNL_ME_PB_BUSY_ON_SEND_DTMF =3D	0x09,
+	STK_RESULT_ADDNL_ME_PB_NO_NAA_ACTIVE =3D		0x0A
+};
+
+enum stk_result_addnl_me_pb_ob {
+	STK_RESULT_ADDNL_ME_PB_SS_BUSY =3D	0x03,
+	STK_RESULT_ADDNL_ME_PB_USSD_BUSY =3D	0x08
+};
+
+enum stk_result_addnl_ss_pb_ob {
+	STK_RESULT_ADDNL_SS_PB_NO_SPECIFIC_CAUSE =3D	0x00
+};
+
 enum stk_tone_type {
 	STK_TONE_TYPE_DIAL_TONE =3D	0x01,
 	STK_TONE_TYPE_BUSY_TONE =3D	0x02,
diff --git a/src/ussd.c b/src/ussd.c
index fbb07d2..7e8d1c8 100644
--- a/src/ussd.c
+++ b/src/ussd.c
@@ -182,11 +182,10 @@ void __ofono_ussd_passwd_unregister(struct ofono_ussd=
 *ussd, const char *sc)
 	ussd->ss_passwd_list =3D g_slist_remove(ussd->ss_passwd_list, l->data);
 }
 =

-static gboolean recognized_passwd_change_string(struct ofono_ussd *ussd,
-						int type, char *sc,
-						char *sia, char *sib,
-						char *sic, char *sid,
-						char *dn, DBusMessage *msg)
+static int recognized_passwd_change_string(struct ofono_ussd *ussd, int ty=
pe,
+						char *sc, char *sia, char *sib,
+						char *sic, char *sid, char *dn,
+						struct ofono_ss_req *osr)
 {
 	GSList *l =3D ussd->ss_passwd_list;
 =

@@ -196,42 +195,40 @@ static gboolean recognized_passwd_change_string(struc=
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
+		int result =3D cb(sia, sib, sic, osr, entry->user);
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

-static gboolean recognized_control_string(struct ofono_ussd *ussd,
+int __ofono_ussd_recognized_control_string(struct ofono_ussd *ussd,
 						const char *ss_str,
-						DBusMessage *msg)
+						struct ofono_ss_req *osr)
 {
 	char *str =3D g_strdup(ss_str);
 	char *sc, *sia, *sib, *sic, *sid, *dn;
 	int type;
-	gboolean ret =3D FALSE;
+	int ret =3D -ENOENT;
+	int result;
 =

 	DBG("parsing control string");
 =

@@ -245,9 +242,11 @@ static gboolean recognized_control_string(struct ofono=
_ussd *ussd,
 		/* A password change string needs to be treated separately
 		 * because it uses a fourth SI and is thus not a valid
 		 * control string.  */
-		if (recognized_passwd_change_string(ussd, type, sc,
-					sia, sib, sic, sid, dn, msg)) {
-			ret =3D TRUE;
+		result =3D recognized_passwd_change_string(ussd, type, sc,
+						sia, sib, sic, sid, dn, osr);
+
+		if (result >=3D 0) {
+			ret =3D result;
 			goto out;
 		}
 =

@@ -259,8 +258,11 @@ static gboolean recognized_control_string(struct ofono=
_ussd *ussd,
 			struct ssc_entry *entry =3D l->data;
 			ofono_ussd_ssc_cb_t cb =3D entry->cb;
 =

-			if (cb(type, sc, sia, sib, sic, dn, msg, entry->user)) {
-				ret =3D TRUE;
+			result =3D cb(type, sc, sia, sib, sic, dn, osr,
+								entry->user);
+
+			if (result >=3D 0) {
+				ret =3D result;
 				goto out;
 			}
 =

@@ -447,6 +449,8 @@ static DBusMessage *ussd_initiate(DBusConnection *conn,=
 DBusMessage *msg,
 {
 	struct ofono_ussd *ussd =3D data;
 	const char *str;
+	int result;
+	struct ofono_ss_req *osr;
 =

 	if (ussd->pending)
 		return __ofono_error_busy(msg);
@@ -462,8 +466,30 @@ static DBusMessage *ussd_initiate(DBusConnection *conn=
, DBusMessage *msg,
 		return __ofono_error_invalid_format(msg);
 =

 	DBG("checking if this is a recognized control string");
-	if (recognized_control_string(ussd, str, msg))
-		return NULL;
+
+	osr =3D g_try_new0(struct ofono_ss_req, 1);
+	if (!osr)
+		return __ofono_error_failed(msg);
+
+	osr->msg =3D msg;
+
+	result =3D __ofono_ussd_recognized_control_string(ussd, str, osr);
+	g_free(osr);
+
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

1.7.0.4


--===============5678302098747925286==--

