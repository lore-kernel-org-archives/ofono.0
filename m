Content-Type: multipart/mixed; boundary="===============8171742716433856193=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] Add CallBarring::ChangePassword for setting a new service
 password.
Date: Thu, 18 Jun 2009 06:04:34 +0200
Message-ID: <1245297874-15334-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8171742716433856193==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Depends on "[PATCH] Teach USSD to recognise password change strings."
---
 src/call-barring.c |  158 ++++++++++++++++++++++++++++++++++++++++++++++--=
----
 src/driver.h       |    3 +
 2 files changed, 144 insertions(+), 17 deletions(-)

diff --git a/src/call-barring.c b/src/call-barring.c
index 6cbbafb..bc56d32 100644
--- a/src/call-barring.c
+++ b/src/call-barring.c
@@ -341,6 +341,28 @@ static void cb_ss_set_lock_callback(const struct ofono=
_error *error,
 	cb_ss_query_next_lock(modem);
 }
 =

+static const char *cb_ss_service_to_fac(const char *svc)
+{
+	if (!strcmp(svc, "33"))
+		return "AO";
+	else if (!strcmp(svc, "331"))
+		return "OI";
+	else if (!strcmp(svc, "332"))
+		return "OX";
+	else if (!strcmp(svc, "35"))
+		return "AI";
+	else if (!strcmp(svc, "351"))
+		return "IR";
+	else if (!strcmp(svc, "330"))
+		return "AB";
+	else if (!strcmp(svc, "333"))
+		return "AG";
+	else if (!strcmp(svc, "353"))
+		return "AC";
+
+	return NULL;
+}
+
 static gboolean cb_ss_control(struct ofono_modem *modem,
 				enum ss_control_type type, const char *sc,
 				const char *sia, const char *sib,
@@ -367,23 +389,8 @@ static gboolean cb_ss_control(struct ofono_modem *mode=
m,
 	ofono_debug("type: %d, sc: %s, sia: %s, sib: %s, sic: %s, dn: %s",
 			type, sc, sia, sib, sic, dn);
 =

-	if (!strcmp(sc, "33"))
-		fac =3D "AO";
-	else if (!strcmp(sc, "331"))
-		fac =3D "OI";
-	else if (!strcmp(sc, "332"))
-		fac =3D "OX";
-	else if (!strcmp(sc, "35"))
-		fac =3D "AI";
-	else if (!strcmp(sc, "351"))
-		fac =3D "IR";
-	else if (!strcmp(sc, "330"))
-		fac =3D "AB";
-	else if (!strcmp(sc, "333"))
-		fac =3D "AG";
-	else if (!strcmp(sc, "353"))
-		fac =3D "AC";
-	else
+	fac =3D cb_ss_service_to_fac(sc);
+	if (!fac)
 		return FALSE;
 =

 	cb_set_query_bounds(cb, fac, type =3D=3D SS_CONTROL_TYPE_QUERY);
@@ -476,6 +483,63 @@ bad_format:
 	return TRUE;
 }
 =

+static void cb_set_passwd_callback(const struct ofono_error *error, void *=
data)
+{
+	struct ofono_modem *modem =3D data;
+	struct call_barring_data *cb =3D modem->call_barring;
+	DBusMessage *reply;
+
+	if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR)
+		reply =3D dbus_message_new_method_return(cb->pending);
+	else {
+		reply =3D dbus_gsm_failed(cb->pending);
+		ofono_debug("Changing Call Barring password via SS failed");
+	}
+
+	dbus_gsm_pending_reply(&cb->pending, reply);
+}
+
+static gboolean cb_ss_passwd(struct ofono_modem *modem, const char *sc,
+				const char *old, const char *new,
+				DBusMessage *msg)
+{
+	struct call_barring_data *cb =3D modem->call_barring;
+	DBusConnection *conn =3D dbus_gsm_connection();
+	DBusMessage *reply;
+	const char *fac;
+
+	if (cb->pending) {
+		reply =3D dbus_gsm_busy(msg);
+		g_dbus_send_message(conn, reply);
+
+		return TRUE;
+	}
+
+	ofono_debug("Received call barring ss password change request");
+
+	ofono_debug("sc: %s", sc);
+
+	if (!strcmp(sc, ""))
+		fac =3D "AB";
+	else
+		fac =3D cb_ss_service_to_fac(sc);
+	if (!fac)
+		return FALSE;
+
+	if (!is_valid_pin(old) || !is_valid_pin(new))
+		goto bad_format;
+
+	cb->pending =3D dbus_message_ref(msg);
+	cb->ops->set_passwd(modem, fac, old, new,
+			cb_set_passwd_callback, modem);
+
+	return TRUE;
+bad_format:
+	reply =3D dbus_gsm_invalid_format(msg);
+	g_dbus_send_message(conn, reply);
+	return TRUE;
+}
+
 static void cb_register_ss_controls(struct ofono_modem *modem)
 {
 	ss_control_register(modem, "33", cb_ss_control);
@@ -486,6 +550,15 @@ static void cb_register_ss_controls(struct ofono_modem=
 *modem)
 	ss_control_register(modem, "330", cb_ss_control);
 	ss_control_register(modem, "333", cb_ss_control);
 	ss_control_register(modem, "353", cb_ss_control);
+	ss_passwd_register(modem, "", cb_ss_passwd);
+	ss_passwd_register(modem, "33", cb_ss_passwd);
+	ss_passwd_register(modem, "331", cb_ss_passwd);
+	ss_passwd_register(modem, "332", cb_ss_passwd);
+	ss_passwd_register(modem, "35", cb_ss_passwd);
+	ss_passwd_register(modem, "351", cb_ss_passwd);
+	ss_passwd_register(modem, "330", cb_ss_passwd);
+	ss_passwd_register(modem, "333", cb_ss_passwd);
+	ss_passwd_register(modem, "353", cb_ss_passwd);
 }
 =

 static void cb_unregister_ss_controls(struct ofono_modem *modem)
@@ -498,6 +571,15 @@ static void cb_unregister_ss_controls(struct ofono_mod=
em *modem)
 	ss_control_unregister(modem, "330", cb_ss_control);
 	ss_control_unregister(modem, "333", cb_ss_control);
 	ss_control_unregister(modem, "353", cb_ss_control);
+	ss_passwd_unregister(modem, "", cb_ss_passwd);
+	ss_passwd_unregister(modem, "33", cb_ss_passwd);
+	ss_passwd_unregister(modem, "331", cb_ss_passwd);
+	ss_passwd_unregister(modem, "332", cb_ss_passwd);
+	ss_passwd_unregister(modem, "35", cb_ss_passwd);
+	ss_passwd_unregister(modem, "351", cb_ss_passwd);
+	ss_passwd_unregister(modem, "330", cb_ss_passwd);
+	ss_passwd_unregister(modem, "333", cb_ss_passwd);
+	ss_passwd_unregister(modem, "353", cb_ss_passwd);
 }
 =

 static struct call_barring_data *call_barring_create(void)
@@ -896,6 +978,46 @@ static DBusMessage *cb_disable_ag(DBusConnection *conn=
, DBusMessage *msg,
 	return cb_disable_all(conn, msg, data, "AG");
 }
 =

+static DBusMessage *cb_set_passwd(DBusConnection *conn, DBusMessage *msg,
+					void *data)
+{
+	struct ofono_modem *modem =3D data;
+	struct call_barring_data *cb =3D modem->call_barring;
+	DBusMessageIter iter;
+	const char *old_passwd, *new_passwd;
+
+	if (cb->pending)
+		return dbus_gsm_busy(msg);
+
+	if (!dbus_message_iter_init(msg, &iter))
+		return dbus_gsm_invalid_args(msg);
+
+	if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_STRING)
+		return dbus_gsm_invalid_args(msg);
+
+	dbus_message_iter_get_basic(&iter, &old_passwd);
+	if (!is_valid_pin(old_passwd))
+		return dbus_gsm_invalid_format(msg);
+
+	dbus_message_iter_next(&iter);
+
+	if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_STRING)
+		return dbus_gsm_invalid_args(msg);
+
+	dbus_message_iter_get_basic(&iter, &new_passwd);
+	if (!is_valid_pin(new_passwd))
+		return dbus_gsm_invalid_format(msg);
+
+	if (!cb->ops->set_passwd)
+		return dbus_gsm_not_implemented(msg);
+
+	cb->pending =3D dbus_message_ref(msg);
+	cb->ops->set_passwd(modem, "AB", old_passwd, new_passwd,
+			cb_set_passwd_callback, modem);
+
+	return NULL;
+}
+
 static GDBusMethodTable cb_methods[] =3D {
 	{ "GetProperties",	"",	"a{sv}",	cb_get_properties,
 							G_DBUS_METHOD_FLAG_ASYNC },
@@ -907,6 +1029,8 @@ static GDBusMethodTable cb_methods[] =3D {
 							G_DBUS_METHOD_FLAG_ASYNC },
 	{ "DisableAllOutgoing",	"s",	"",		cb_disable_ag,
 							G_DBUS_METHOD_FLAG_ASYNC },
+	{ "ChangePassword",	"ss",	"",		cb_set_passwd,
+							G_DBUS_METHOD_FLAG_ASYNC },
 	{ }
 };
 =

diff --git a/src/driver.h b/src/driver.h
index 0172a52..f18ece2 100644
--- a/src/driver.h
+++ b/src/driver.h
@@ -391,6 +391,9 @@ struct ofono_call_barring_ops {
 			ofono_generic_cb_t cb, void *data);
 	void (*query)(struct ofono_modem *modem, const char *lock, int cls,
 			ofono_call_barring_cb_t cb, void *data);
+	void (*set_passwd)(struct ofono_modem *modem, const char *lock,
+			const char *old_passwd, const char *new_passwd,
+			ofono_generic_cb_t cb, void *data);
 };
 =

 int ofono_call_barring_register(struct ofono_modem *modem,
-- =

1.6.0


--===============8171742716433856193==--

