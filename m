Content-Type: multipart/mixed; boundary="===============1555684574859139769=="
MIME-Version: 1.0
From: Philip Paeps <philip@paeps.cx>
Subject: [PATCH 2/3] gprs: make PPP authentication method configurable
Date: Tue, 17 Jun 2014 23:57:58 +0200
Message-ID: <1403042279-20598-3-git-send-email-philip@paeps.cx>
In-Reply-To: <1403042279-20598-1-git-send-email-philip@paeps.cx>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1555684574859139769==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add a new "AuthMethod" property to select between "pap" and "chap" PPP
authentication, defaulting to "chap" (i.e.: previous behaviour).

Signed-off-by: Philip Paeps <philip@paeps.cx>
---
 doc/connman-api.txt            |    4 ++
 drivers/atmodem/gprs-context.c |   14 +++++++
 include/gprs-context.h         |    6 +++
 src/gprs.c                     |   81 ++++++++++++++++++++++++++++++++++++=
++++
 4 files changed, 105 insertions(+)

diff --git a/doc/connman-api.txt b/doc/connman-api.txt
index 2227ab8..6347a8c 100644
--- a/doc/connman-api.txt
+++ b/doc/connman-api.txt
@@ -180,6 +180,10 @@ Properties	boolean Active [readwrite]
 				"wap" - Used by WAP related services
 				"ims" - Used by IMS related services
 =

+		string AuthMethod [readwrite]
+			Holds the PPP authentication method to use.  Valid
+			values are "pap" and "chap".  Defaults to "chap".
+
 		string Username [readwrite]
 =

 			Holds the username to be used for authentication
diff --git a/drivers/atmodem/gprs-context.c b/drivers/atmodem/gprs-context.c
index 2217097..be44443 100644
--- a/drivers/atmodem/gprs-context.c
+++ b/drivers/atmodem/gprs-context.c
@@ -59,6 +59,7 @@ enum state {
 struct gprs_context_data {
 	GAtChat *chat;
 	unsigned int active_context;
+	GAtPPPAuthMethod auth_method;
 	char username[OFONO_GPRS_MAX_USERNAME_LENGTH + 1];
 	char password[OFONO_GPRS_MAX_PASSWORD_LENGTH + 1];
 	GAtPPP *ppp;
@@ -154,6 +155,7 @@ static gboolean setup_ppp(struct ofono_gprs_context *gc)
 	if (getenv("OFONO_PPP_DEBUG"))
 		g_at_ppp_set_debug(gcd->ppp, ppp_debug, "PPP");
 =

+	g_at_ppp_set_auth_method(gcd->ppp, gcd->auth_method);
 	g_at_ppp_set_credentials(gcd->ppp, gcd->username, gcd->password);
 =

 	/* set connect and disconnect callbacks */
@@ -243,6 +245,18 @@ static void at_gprs_activate_primary(struct ofono_gprs=
_context *gc,
 	memcpy(gcd->username, ctx->username, sizeof(ctx->username));
 	memcpy(gcd->password, ctx->password, sizeof(ctx->password));
 =

+	/* We only support CHAP and PAP */
+	switch (ctx->auth_method) {
+	case OFONO_GPRS_AUTH_METHOD_CHAP:
+		gcd->auth_method =3D G_AT_PPP_AUTH_METHOD_CHAP;
+		break;
+	case OFONO_GPRS_AUTH_METHOD_PAP:
+		gcd->auth_method =3D G_AT_PPP_AUTH_METHOD_PAP;
+		break;
+	default:
+		goto error;
+	}
+
 	gcd->state =3D STATE_ENABLING;
 =

 	if (gcd->vendor =3D=3D OFONO_VENDOR_ZTE) {
diff --git a/include/gprs-context.h b/include/gprs-context.h
index 27d4b49..ed27e66 100644
--- a/include/gprs-context.h
+++ b/include/gprs-context.h
@@ -48,6 +48,11 @@ enum ofono_gprs_context_type {
 	OFONO_GPRS_CONTEXT_TYPE_IMS,
 };
 =

+enum ofono_gprs_auth_method {
+	OFONO_GPRS_AUTH_METHOD_CHAP =3D 0,
+	OFONO_GPRS_AUTH_METHOD_PAP,
+};
+
 struct ofono_gprs_primary_context {
 	unsigned int cid;
 	int direction;
@@ -55,6 +60,7 @@ struct ofono_gprs_primary_context {
 	char username[OFONO_GPRS_MAX_USERNAME_LENGTH + 1];
 	char password[OFONO_GPRS_MAX_PASSWORD_LENGTH + 1];
 	enum ofono_gprs_proto proto;
+	enum ofono_gprs_auth_method auth_method;
 };
 =

 typedef void (*ofono_gprs_context_cb_t)(const struct ofono_error *error,
diff --git a/src/gprs.c b/src/gprs.c
index e379f7b..3810267 100644
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
+	ofono_dbus_dict_append(dict, "AuthMethod", DBUS_TYPE_STRING,
+				&strvalue);
+
 	if (ctx->type =3D=3D OFONO_GPRS_CONTEXT_TYPE_MMS) {
 		strvalue =3D ctx->message_proxy;
 		ofono_dbus_dict_append(dict, "MessageProxy",
@@ -1149,6 +1179,35 @@ static DBusMessage *pri_set_message_center(struct pr=
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
+		g_key_file_set_string(settings, ctx->key, "AuthMethod", str);
+		storage_sync(ctx->gprs->imsi, SETTINGS_STORE, settings);
+	}
+
+	g_dbus_send_reply(conn, msg, DBUS_TYPE_INVALID);
+
+	ofono_dbus_signal_property_changed(conn, ctx->path,
+					OFONO_CONNECTION_CONTEXT_INTERFACE,
+					"AuthMethod", DBUS_TYPE_STRING, &str);
+
+	return NULL;
+}
+
 static DBusMessage *pri_set_property(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
@@ -1259,6 +1318,13 @@ static DBusMessage *pri_set_property(DBusConnection =
*conn,
 		dbus_message_iter_get_basic(&var, &str);
 =

 		return pri_set_name(ctx, conn, msg, str);
+	} else if (!strcmp(property, "AuthMethod")) {
+		if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_STRING)
+			return __ofono_error_invalid_args(msg);
+
+		dbus_message_iter_get_basic(&var, &str);
+
+		return pri_set_auth_method(ctx, conn, msg, str);
 	}
 =

 	if (ctx->type !=3D OFONO_GPRS_CONTEXT_TYPE_MMS)
@@ -1752,6 +1818,9 @@ static void write_context_settings(struct ofono_gprs =
*gprs,
 				"Username", context->context.username);
 	g_key_file_set_string(gprs->settings, context->key,
 				"Password", context->context.password);
+	g_key_file_set_string(gprs->settings, context->key, "AuthMethod",
+				gprs_auth_method_to_string(
+				context->context.auth_method));
 	g_key_file_set_string(gprs->settings, context->key, "Type",
 				gprs_context_type_to_string(context->type));
 	g_key_file_set_string(gprs->settings, context->key, "Protocol",
@@ -2698,11 +2767,13 @@ static gboolean load_context(struct ofono_gprs *gpr=
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
@@ -2747,6 +2818,14 @@ static gboolean load_context(struct ofono_gprs *gprs=
, const char *group)
 	if (password =3D=3D NULL)
 		goto error;
 =

+	authstr =3D g_key_file_get_string(gprs->settings, group,
+						"AuthMethod", NULL);
+	if (authstr =3D=3D NULL)
+		authstr =3D g_strdup("chap");
+
+	if (gprs_auth_method_from_string(authstr, &auth) =3D=3D FALSE)
+		goto error;
+
 	if (strlen(password) > OFONO_GPRS_MAX_PASSWORD_LENGTH)
 		goto error;
 =

@@ -2783,6 +2862,7 @@ static gboolean load_context(struct ofono_gprs *gprs,=
 const char *group)
 	strcpy(context->context.password, password);
 	strcpy(context->context.apn, apn);
 	context->context.proto =3D proto;
+	context->context.auth_method =3D auth;
 =

 	if (msgproxy !=3D NULL)
 		strcpy(context->message_proxy, msgproxy);
@@ -2812,6 +2892,7 @@ error:
 	g_free(apn);
 	g_free(msgproxy);
 	g_free(msgcenter);
+	g_free(authstr);
 =

 	return ret;
 }
-- =

1.7.10.4


--===============1555684574859139769==--

