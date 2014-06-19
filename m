Content-Type: multipart/mixed; boundary="===============6642376290751821027=="
MIME-Version: 1.0
From: Philip Paeps <philip@paeps.cx>
Subject: [PATCH 4/5] gprs: make PPP authentication method configurable
Date: Thu, 19 Jun 2014 12:07:08 +0200
Message-ID: <1403172429-26289-5-git-send-email-philip@paeps.cx>
In-Reply-To: <1403172429-26289-1-git-send-email-philip@paeps.cx>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6642376290751821027==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add a new "AuthenticationMethod" property to select between "pap"
and "chap" PPP authentication, defaulting to "chap" (i.e.: previous
behaviour).
---
 src/gprs.c |   84 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 84 insertions(+)

diff --git a/src/gprs.c b/src/gprs.c
index e379f7b..71280f2 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -264,6 +264,32 @@ static gboolean gprs_proto_from_string(const char *str,
 	return FALSE;
 }
 =

+static const char *gprs_auth_method_to_string(enum ofono_gprs_auth_method =
auth)
+{
+	switch (auth) {
+	case OFONO_GPRS_AUTH_METHOD_CHAP:
+		return "chap";
+	case OFONO_GPRS_AUTH_METHOD_PAP:
+		return "pap";
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
+	}
+
+	return FALSE;
+}
+
 static unsigned int gprs_cid_alloc(struct ofono_gprs *gprs)
 {
 	return idmap_alloc(gprs->cid_map);
@@ -807,6 +833,10 @@ static void append_context_properties(struct pri_conte=
xt *ctx,
 	ofono_dbus_dict_append(dict, "Password", DBUS_TYPE_STRING,
 				&strvalue);
 =

+	strvalue =3D gprs_auth_method_to_string(ctx->context.auth_method);
+	ofono_dbus_dict_append(dict, "AuthenticationMethod", DBUS_TYPE_STRING,
+				&strvalue);
+
 	if (ctx->type =3D=3D OFONO_GPRS_CONTEXT_TYPE_MMS) {
 		strvalue =3D ctx->message_proxy;
 		ofono_dbus_dict_append(dict, "MessageProxy",
@@ -1149,6 +1179,37 @@ static DBusMessage *pri_set_message_center(struct pr=
i_context *ctx,
 	return NULL;
 }
 =

+static DBusMessage *pri_set_auth_method(struct pri_context *ctx,
+					DBusConnection *conn,
+					DBusMessage *msg, const char *str)
+{
+	GKeyFile *settings =3D ctx->gprs->settings;
+	enum ofono_gprs_auth_method auth;
+
+	if (gprs_auth_method_from_string(str, &auth) =3D=3D FALSE)
+		return __ofono_error_invalid_format(msg);
+
+	if (ctx->context.auth_method =3D=3D auth)
+		return dbus_message_new_method_return(msg);
+
+	ctx->context.auth_method =3D auth;
+
+	if (settings) {
+		g_key_file_set_string(settings, ctx->key,
+					"AuthenticationMethod", str);
+		storage_sync(ctx->gprs->imsi, SETTINGS_STORE, settings);
+	}
+
+	g_dbus_send_reply(conn, msg, DBUS_TYPE_INVALID);
+
+	ofono_dbus_signal_property_changed(conn, ctx->path,
+					OFONO_CONNECTION_CONTEXT_INTERFACE,
+					"AuthenticationMethod",
+					DBUS_TYPE_STRING, &str);
+
+	return NULL;
+}
+
 static DBusMessage *pri_set_property(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
@@ -1259,6 +1320,13 @@ static DBusMessage *pri_set_property(DBusConnection =
*conn,
 		dbus_message_iter_get_basic(&var, &str);
 =

 		return pri_set_name(ctx, conn, msg, str);
+	} else if (!strcmp(property, "AuthenticationMethod")) {
+		if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_STRING)
+			return __ofono_error_invalid_args(msg);
+
+		dbus_message_iter_get_basic(&var, &str);
+
+		return pri_set_auth_method(ctx, conn, msg, str);
 	}
 =

 	if (ctx->type !=3D OFONO_GPRS_CONTEXT_TYPE_MMS)
@@ -1752,6 +1820,10 @@ static void write_context_settings(struct ofono_gprs=
 *gprs,
 				"Username", context->context.username);
 	g_key_file_set_string(gprs->settings, context->key,
 				"Password", context->context.password);
+	g_key_file_set_string(gprs->settings, context->key,
+				"AuthenticationMethod",
+				gprs_auth_method_to_string(
+				context->context.auth_method));
 	g_key_file_set_string(gprs->settings, context->key, "Type",
 				gprs_context_type_to_string(context->type));
 	g_key_file_set_string(gprs->settings, context->key, "Protocol",
@@ -2698,11 +2770,13 @@ static gboolean load_context(struct ofono_gprs *gpr=
s, const char *group)
 	char *apn =3D NULL;
 	char *msgproxy =3D NULL;
 	char *msgcenter =3D NULL;
+	char *authstr =3D NULL;
 	gboolean ret =3D FALSE;
 	gboolean legacy =3D FALSE;
 	struct pri_context *context;
 	enum ofono_gprs_context_type type;
 	enum ofono_gprs_proto proto;
+	enum ofono_gprs_auth_method auth;
 	unsigned int id;
 =

 	if (sscanf(group, "context%d", &id) !=3D 1) {
@@ -2747,6 +2821,14 @@ static gboolean load_context(struct ofono_gprs *gprs=
, const char *group)
 	if (password =3D=3D NULL)
 		goto error;
 =

+	authstr =3D g_key_file_get_string(gprs->settings, group,
+						"AuthenticationMethod", NULL);
+	if (authstr =3D=3D NULL)
+		authstr =3D g_strdup("chap");
+
+	if (gprs_auth_method_from_string(authstr, &auth) =3D=3D FALSE)
+		goto error;
+
 	if (strlen(password) > OFONO_GPRS_MAX_PASSWORD_LENGTH)
 		goto error;
 =

@@ -2783,6 +2865,7 @@ static gboolean load_context(struct ofono_gprs *gprs,=
 const char *group)
 	strcpy(context->context.password, password);
 	strcpy(context->context.apn, apn);
 	context->context.proto =3D proto;
+	context->context.auth_method =3D auth;
 =

 	if (msgproxy !=3D NULL)
 		strcpy(context->message_proxy, msgproxy);
@@ -2812,6 +2895,7 @@ error:
 	g_free(apn);
 	g_free(msgproxy);
 	g_free(msgcenter);
+	g_free(authstr);
 =

 	return ret;
 }
-- =

1.7.10.4


--===============6642376290751821027==--

