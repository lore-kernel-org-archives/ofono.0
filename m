Content-Type: multipart/mixed; boundary="===============5236569314780536613=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH 2/7] extended support for LTE and NR. Some minor fixes. part 2
 of 7
Date: Wed, 19 Sep 2018 07:37:28 +0200
Message-ID: <1537335453-21498-2-git-send-email-gciofono@gmail.com>
In-Reply-To: <1537335453-21498-1-git-send-email-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5236569314780536613==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/gprs.c |  13 ++-
 src/lte.c  | 372 ++++++++++++++++++++++++++++++++++++++++++++++++++++++---=
----
 src/main.c |   5 -
 3 files changed, 341 insertions(+), 49 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index 377eced..40f43e3 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -261,6 +261,10 @@ static const char *gprs_auth_method_to_string(enum ofo=
no_gprs_auth_method auth)
 		return "chap";
 	case OFONO_GPRS_AUTH_METHOD_PAP:
 		return "pap";
+	case OFONO_GPRS_AUTH_METHOD_NONE:
+		return "none";
+	default:
+		return NULL;
 	};
 =

 	return NULL;
@@ -275,6 +279,9 @@ static gboolean gprs_auth_method_from_string(const char=
 *str,
 	} else if (g_str_equal(str, "pap")) {
 		*auth =3D OFONO_GPRS_AUTH_METHOD_PAP;
 		return TRUE;
+	} else if (g_str_equal(str, "none")) {
+		*auth =3D OFONO_GPRS_AUTH_METHOD_NONE;
+		return TRUE;
 	}
 =

 	return FALSE;
@@ -1008,7 +1015,7 @@ static void pri_read_settings_callback(const struct o=
fono_error *error,
 =

 	value =3D pri_ctx->active;
 =

-	gprs->flags &=3D !GPRS_FLAG_ATTACHING;
+	gprs->flags &=3D ~GPRS_FLAG_ATTACHING;
 =

 	gprs->driver_attached =3D TRUE;
 	gprs_set_attached_property(gprs, TRUE);
@@ -1635,6 +1642,9 @@ static void release_active_contexts(struct ofono_gprs=
 *gprs)
 =

 		if (gc->driver->detach_shutdown !=3D NULL)
 			gc->driver->detach_shutdown(gc, ctx->context.cid);
+
+		/* Make sure the context is properly cleared */
+		release_context(ctx);
 	}
 }
 =

@@ -2234,6 +2244,7 @@ static DBusMessage *gprs_remove_context(DBusConnectio=
n *conn,
 	}
 =

 	DBG("Unregistering context: %s", ctx->path);
+	release_context(ctx);
 	context_dbus_unregister(ctx);
 	gprs->contexts =3D g_slist_remove(gprs->contexts, ctx);
 =

diff --git a/src/lte.c b/src/lte.c
index a6d26b3..21b6a19 100644
--- a/src/lte.c
+++ b/src/lte.c
@@ -3,6 +3,7 @@
  *  oFono - Open Source Telephony
  *
  *  Copyright (C) 2016  Endocode AG. All rights reserved.
+ *  Copyright (C) 2018 Gemalto M2M
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2 as
@@ -39,7 +40,11 @@
 =

 #define SETTINGS_STORE "lte"
 #define SETTINGS_GROUP "Settings"
-#define DEFAULT_APN_KEY "DefaultAccessPointName"
+#define LTE_APN "AccessPointName"
+#define LTE_PROTO "Protocol"
+#define LTE_USERNAME "Username"
+#define LTE_PASSWORD "Password"
+#define LTE_AUTH_METHOD "AuthenticationMethod"
 =

 struct ofono_lte {
 	const struct ofono_lte_driver *driver;
@@ -50,13 +55,82 @@ struct ofono_lte {
 	DBusMessage *pending;
 	struct ofono_lte_default_attach_info pending_info;
 	struct ofono_lte_default_attach_info info;
+	const char *prop_changed;
 };
 =

 static GSList *g_drivers =3D NULL;
 =

+static const char *gprs_proto_to_string(enum ofono_gprs_proto proto)
+{
+	switch (proto) {
+	case OFONO_GPRS_PROTO_IP:
+		return "ip";
+	case OFONO_GPRS_PROTO_IPV6:
+		return "ipv6";
+	case OFONO_GPRS_PROTO_IPV4V6:
+		return "dual";
+	};
+
+	return NULL;
+}
+
+static gboolean gprs_proto_from_string(const char *str,
+					enum ofono_gprs_proto *proto)
+{
+	if (g_str_equal(str, "ip")) {
+		*proto =3D OFONO_GPRS_PROTO_IP;
+		return TRUE;
+	} else if (g_str_equal(str, "ipv6")) {
+		*proto =3D OFONO_GPRS_PROTO_IPV6;
+		return TRUE;
+	} else if (g_str_equal(str, "dual")) {
+		*proto =3D OFONO_GPRS_PROTO_IPV4V6;
+		return TRUE;
+	}
+
+	return FALSE;
+}
+
+static const char *gprs_auth_method_to_string(enum ofono_gprs_auth_method =
auth)
+{
+	switch (auth) {
+	case OFONO_GPRS_AUTH_METHOD_CHAP:
+		return "chap";
+	case OFONO_GPRS_AUTH_METHOD_PAP:
+		return "pap";
+	case OFONO_GPRS_AUTH_METHOD_NONE:
+		return "none";
+	default:
+		return NULL;
+	};
+
+	return NULL;
+}
+
+static gboolean gprs_auth_method_from_string(const char *str,
+					enum ofono_gprs_auth_method *auth)
+{
+	if (g_str_equal(str, "chap")) {
+		*auth =3D OFONO_GPRS_AUTH_METHOD_CHAP;
+		return TRUE;
+	} else if (g_str_equal(str, "pap")) {
+		*auth =3D OFONO_GPRS_AUTH_METHOD_PAP;
+		return TRUE;
+	} else if (g_str_equal(str, "none")) {
+		*auth =3D OFONO_GPRS_AUTH_METHOD_NONE;
+		return TRUE;
+	}
+
+	return FALSE;
+}
+
 static void lte_load_settings(struct ofono_lte *lte)
 {
+	char *proto_str;
 	char *apn;
+	char *auth_method_str;
+	char *username;
+	char *password;
 =

 	if (lte->imsi =3D=3D NULL)
 		return;
@@ -69,114 +143,276 @@ static void lte_load_settings(struct ofono_lte *lte)
 		return;
 	}
 =

-	apn =3D g_key_file_get_string(lte->settings, SETTINGS_GROUP ,
-					DEFAULT_APN_KEY, NULL);
-	if (apn) {
+	proto_str =3D g_key_file_get_string(lte->settings, SETTINGS_GROUP,
+				LTE_PROTO, NULL);
+	apn =3D g_key_file_get_string(lte->settings, SETTINGS_GROUP,
+				LTE_APN, NULL);
+	auth_method_str =3D g_key_file_get_string(lte->settings, SETTINGS_GROUP,
+				LTE_AUTH_METHOD, NULL);
+	username =3D g_key_file_get_string(lte->settings, SETTINGS_GROUP,
+				LTE_USERNAME, NULL);
+	password =3D g_key_file_get_string(lte->settings, SETTINGS_GROUP,
+				LTE_PASSWORD, NULL);
+	if (proto_str =3D=3D NULL)
+		proto_str =3D g_strdup("ip");
+
+	/* this must have a valid default */
+	if (!gprs_proto_from_string(proto_str, &lte->info.proto))
+		lte->info.proto =3D OFONO_GPRS_PROTO_IP;
+
+	if (apn)
 		strcpy(lte->info.apn, apn);
-		g_free(apn);
-	}
+
+	if (auth_method_str =3D=3D NULL)
+		auth_method_str =3D g_strdup("none");
+
+	/* this must have a valid default */
+	if (!gprs_auth_method_from_string(auth_method_str,
+							&lte->info.auth_method))
+		lte->info.auth_method =3D OFONO_GPRS_AUTH_METHOD_NONE;
+
+	if (username)
+		strcpy(lte->info.username, username);
+
+	if (password)
+		strcpy(lte->info.password, password);
+
+	g_free(proto_str);
+	g_free(apn);
+	g_free(auth_method_str);
+	g_free(username);
+	g_free(password);
 }
 =

 static DBusMessage *lte_get_properties(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
 	struct ofono_lte *lte =3D data;
+	const char *proto =3D gprs_proto_to_string(lte->info.proto);
 	const char *apn =3D lte->info.apn;
+	const char* auth_method =3D
+			gprs_auth_method_to_string(lte->info.auth_method);
+	const char *username =3D lte->info.username;
+	const char *password =3D lte->info.password;
 	DBusMessage *reply;
 	DBusMessageIter iter;
 	DBusMessageIter dict;
 =

 	reply =3D dbus_message_new_method_return(msg);
+
 	if (reply =3D=3D NULL)
 		return NULL;
 =

 	dbus_message_iter_init_append(reply, &iter);
-
 	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
 					OFONO_PROPERTIES_ARRAY_SIGNATURE,
 					&dict);
-	ofono_dbus_dict_append(&dict, DEFAULT_APN_KEY, DBUS_TYPE_STRING, &apn);
+	ofono_dbus_dict_append(&dict, LTE_PROTO, DBUS_TYPE_STRING, &proto);
+	ofono_dbus_dict_append(&dict, LTE_APN, DBUS_TYPE_STRING, &apn);
+	ofono_dbus_dict_append(&dict, LTE_AUTH_METHOD, DBUS_TYPE_STRING,
+					&auth_method);
+	ofono_dbus_dict_append(&dict, LTE_USERNAME, DBUS_TYPE_STRING,
+					&username);
+	ofono_dbus_dict_append(&dict, LTE_PASSWORD, DBUS_TYPE_STRING,
+					&password);
 	dbus_message_iter_close_container(&iter, &dict);
-
 	return reply;
 }
 =

 static void lte_set_default_attach_info_cb(const struct ofono_error *error,
-						void *data)
+								void *data)
 {
 	struct ofono_lte *lte =3D data;
 	const char *path =3D __ofono_atom_get_path(lte->atom);
 	DBusConnection *conn =3D ofono_dbus_get_connection();
 	DBusMessage *reply;
-	const char *apn =3D lte->info.apn;
+	const char *propstr;
 =

-	DBG("%s error %d", path, error->type);
+	if (error !=3D NULL) {
+		DBG("%s error %d", path, error->type);
 =

-	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
-		__ofono_dbus_pending_reply(&lte->pending,
-				__ofono_error_failed(lte->pending));
-		return;
+		if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+			__ofono_dbus_pending_reply(&lte->pending,
+					__ofono_error_failed(lte->pending));
+			return;
+		}
 	}
 =

-	g_strlcpy(lte->info.apn, lte->pending_info.apn,
-			OFONO_GPRS_MAX_APN_LENGTH + 1);
+	if (g_str_equal(lte->prop_changed, LTE_PROTO)) {
+		lte->info.proto =3D lte->pending_info.proto;
+		propstr =3D gprs_proto_to_string(lte->info.proto);
 =

-	if (lte->settings) {
-		if (strlen(lte->info.apn) =3D=3D 0)
-			/* Clear entry on empty APN. */
-			g_key_file_remove_key(lte->settings, SETTINGS_GROUP,
-						DEFAULT_APN_KEY, NULL);
-		else
+		if (lte->settings)
 			g_key_file_set_string(lte->settings, SETTINGS_GROUP,
-						DEFAULT_APN_KEY, lte->info.apn);
+							LTE_PROTO, propstr);
 =

-		storage_sync(lte->imsi, SETTINGS_STORE, lte->settings);
+	} else if (g_str_equal(lte->prop_changed, LTE_APN)) {
+		g_strlcpy(lte->info.apn, lte->pending_info.apn,
+						OFONO_GPRS_MAX_APN_LENGTH + 1);
+		propstr =3D lte->info.apn;
+
+		if (lte->settings) {
+
+			if (!*lte->info.apn)
+				/* Clear entry on empty APN. */
+				g_key_file_remove_key(lte->settings,
+					SETTINGS_GROUP, LTE_APN, NULL);
+			else
+				g_key_file_set_string(lte->settings,
+					SETTINGS_GROUP, LTE_APN, lte->info.apn);
+		}
+
+	} else if (g_str_equal(lte->prop_changed, LTE_AUTH_METHOD)) {
+		lte->info.auth_method =3D lte->pending_info.auth_method;
+		propstr =3D gprs_auth_method_to_string(lte->info.auth_method);
+
+		if (lte->settings)
+			g_key_file_set_string(lte->settings, SETTINGS_GROUP,
+						LTE_AUTH_METHOD, propstr);
+
+	} else if (g_str_equal(lte->prop_changed, LTE_USERNAME)) {
+		g_strlcpy(lte->info.username, lte->pending_info.username,
+			OFONO_GPRS_MAX_USERNAME_LENGTH + 1);
+		propstr =3D lte->info.username;
+
+		if (lte->settings) {
+
+			if (!*lte->info.username)
+				/* Clear entry on empty Username. */
+				g_key_file_remove_key(lte->settings,
+					SETTINGS_GROUP, LTE_USERNAME, NULL);
+			else
+				g_key_file_set_string(lte->settings,
+					SETTINGS_GROUP,
+					LTE_USERNAME, lte->info.username);
+		}
+
+	} else if (g_str_equal(lte->prop_changed, LTE_PASSWORD)) {
+		g_strlcpy(lte->info.password, lte->pending_info.password,
+			OFONO_GPRS_MAX_PASSWORD_LENGTH + 1);
+		propstr =3D lte->info.password;
+
+		if (lte->settings) {
+
+			if (strlen(lte->info.password) =3D=3D 0)
+				/* Clear entry on empty Password. */
+				g_key_file_remove_key(lte->settings,
+					SETTINGS_GROUP, LTE_PASSWORD, NULL);
+			else
+				g_key_file_set_string(lte->settings,
+					SETTINGS_GROUP,
+					LTE_PASSWORD, lte->info.password);
+		}
+
+	} else {
+		return;
 	}
 =

+	if (lte->settings)
+		storage_sync(lte->imsi, SETTINGS_STORE, lte->settings);
+
 	reply =3D dbus_message_new_method_return(lte->pending);
 	__ofono_dbus_pending_reply(&lte->pending, reply);
-
 	ofono_dbus_signal_property_changed(conn, path,
 					OFONO_CONNECTION_CONTEXT_INTERFACE,
-					DEFAULT_APN_KEY,
-					DBUS_TYPE_STRING, &apn);
+					lte->prop_changed,
+					DBUS_TYPE_STRING, &propstr);
 }
 =

-static DBusMessage *lte_set_default_apn(struct ofono_lte *lte,
+static DBusMessage *lte_set_proto(struct ofono_lte *lte,
 				DBusConnection *conn, DBusMessage *msg,
-				const char *apn)
+				enum ofono_gprs_proto proto)
 {
-	if (lte->driver->set_default_attach_info =3D=3D NULL)
-		return __ofono_error_not_implemented(msg);
-
-	if (lte->pending)
-		return __ofono_error_busy(msg);
+	void *data =3D lte;
 =

-	if (g_str_equal(apn, lte->info.apn))
+	if (proto =3D=3D lte->info.proto)
 		return dbus_message_new_method_return(msg);
 =

+	lte->pending =3D dbus_message_ref(msg);
+	lte->pending_info.proto =3D proto;
+	lte_set_default_attach_info_cb(NULL, data);
+	return dbus_message_ref(msg);;
+}
+
+static DBusMessage *lte_set_default_apn(struct ofono_lte *lte,
+				DBusConnection *conn, DBusMessage *msg,
+				const char *apn)
+{
 	/* We do care about empty value: it can be used for reset. */
 	if (is_valid_apn(apn) =3D=3D FALSE && apn[0] !=3D '\0')
 		return __ofono_error_invalid_format(msg);
 =

 	lte->pending =3D dbus_message_ref(msg);
+	g_strlcpy(lte->info.apn, apn, OFONO_GPRS_MAX_APN_LENGTH + 1);
+	lte->driver->set_default_attach_info(lte, &lte->info,
+					lte_set_default_attach_info_cb, lte);
+	return dbus_message_ref(msg);;
+}
 =

-	g_strlcpy(lte->pending_info.apn, apn, OFONO_GPRS_MAX_APN_LENGTH + 1);
+static DBusMessage *lte_set_auth_method(struct ofono_lte *lte,
+				DBusConnection *conn, DBusMessage *msg,
+				enum ofono_gprs_auth_method auth_method)
+{
+	void *data =3D lte;
 =

-	lte->driver->set_default_attach_info(lte, &lte->pending_info,
-					lte_set_default_attach_info_cb, lte);
+	if (auth_method =3D=3D lte->info.auth_method)
+		return dbus_message_new_method_return(msg);
 =

-	return NULL;
+	lte->pending =3D dbus_message_ref(msg);
+	lte->pending_info.auth_method =3D auth_method;
+	lte_set_default_attach_info_cb(NULL, data);
+	return dbus_message_ref(msg);;
+}
+
+static DBusMessage *lte_set_username(struct ofono_lte *lte,
+				DBusConnection *conn, DBusMessage *msg,
+				const char *username)
+{
+	void *data =3D lte;
+
+	if (g_str_equal(username, lte->info.username))
+		return dbus_message_new_method_return(msg);
+
+	lte->pending =3D dbus_message_ref(msg);
+	g_strlcpy(lte->pending_info.username, username,
+					OFONO_GPRS_MAX_USERNAME_LENGTH + 1);
+	lte_set_default_attach_info_cb(NULL, data);
+	return dbus_message_ref(msg);;
+}
+
+static DBusMessage *lte_set_password(struct ofono_lte *lte,
+				DBusConnection *conn, DBusMessage *msg,
+				const char *password)
+{
+	void *data =3D lte;
+
+	if (g_str_equal(password, lte->info.password))
+		return dbus_message_new_method_return(msg);
+
+	lte->pending =3D dbus_message_ref(msg);
+	g_strlcpy(lte->pending_info.password, password,
+					OFONO_GPRS_MAX_PASSWORD_LENGTH + 1);
+	lte_set_default_attach_info_cb(NULL, data);
+
+	return dbus_message_ref(msg);;
 }
 =

 static DBusMessage *lte_set_property(DBusConnection *conn,
-					DBusMessage *msg, void *data)
+						DBusMessage *msg, void *data)
 {
 	struct ofono_lte *lte =3D data;
 	DBusMessageIter iter;
 	DBusMessageIter var;
 	const char *property;
 	const char *str;
+	enum ofono_gprs_auth_method auth_method;
+	enum ofono_gprs_proto proto;
+
+	if (lte->driver->set_default_attach_info =3D=3D NULL)
+		return __ofono_error_not_implemented(msg);
+
+	if (lte->pending)
+		return __ofono_error_busy(msg);
 =

 	if (!dbus_message_iter_init(msg, &iter))
 		return __ofono_error_invalid_args(msg);
@@ -192,13 +428,58 @@ static DBusMessage *lte_set_property(DBusConnection *=
conn,
 =

 	dbus_message_iter_recurse(&iter, &var);
 =

-	if (!strcmp(property, DEFAULT_APN_KEY)) {
+	lte->prop_changed=3Dproperty;
+
+	if (!strcmp(property, LTE_PROTO)) {
+
+		if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_STRING)
+			return __ofono_error_invalid_args(msg);
+
+		dbus_message_iter_get_basic(&var, &str);
+
+		if (gprs_proto_from_string(str, &proto))
+			return lte_set_proto(lte, conn, msg, proto);
+		else
+			return __ofono_error_invalid_format(msg);
+
+	} else if (!strcmp(property, LTE_APN)) {
+
 		if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_STRING)
 			return __ofono_error_invalid_args(msg);
 =

 		dbus_message_iter_get_basic(&var, &str);
 =

 		return lte_set_default_apn(lte, conn, msg, str);
+
+	} else if (!strcmp(property, LTE_AUTH_METHOD)) {
+
+		if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_STRING)
+			return __ofono_error_invalid_args(msg);
+
+		dbus_message_iter_get_basic(&var, &str);
+
+		if (gprs_auth_method_from_string(str, &auth_method))
+			return lte_set_auth_method(lte, conn, msg, auth_method);
+		else
+			return __ofono_error_invalid_format(msg);
+
+	} else  if (!strcmp(property, LTE_USERNAME)) {
+
+		if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_STRING)
+			return __ofono_error_invalid_args(msg);
+
+		dbus_message_iter_get_basic(&var, &str);
+
+		return lte_set_username(lte, conn, msg, str);
+
+	} else  if (!strcmp(property, LTE_PASSWORD)) {
+
+		if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_STRING)
+			return __ofono_error_invalid_args(msg);
+
+		dbus_message_iter_get_basic(&var, &str);
+
+		return lte_set_password(lte, conn, msg, str);
 	}
 =

 	return __ofono_error_invalid_args(msg);
@@ -373,3 +654,8 @@ void *ofono_lte_get_data(const struct ofono_lte *lte)
 {
 	return lte->driver_data;
 }
+
+struct ofono_modem *ofono_lte_get_modem(const struct ofono_lte *lte)
+{
+	return __ofono_atom_get_modem(lte->atom);
+}
\ No newline at end of file
diff --git a/src/main.c b/src/main.c
index 2d359dd..d8a06ba 100644
--- a/src/main.c
+++ b/src/main.c
@@ -211,11 +211,6 @@ int main(int argc, char **argv)
 	struct ell_event_source *source;
 #endif
 =

-#ifdef NEED_THREADS
-	if (g_thread_supported() =3D=3D FALSE)
-		g_thread_init(NULL);
-#endif
-
 	context =3D g_option_context_new(NULL);
 	g_option_context_add_main_entries(context, options, NULL);
 =

-- =

1.9.1


--===============5236569314780536613==--

