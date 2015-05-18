Content-Type: multipart/mixed; boundary="===============2979153956532035856=="
MIME-Version: 1.0
From: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.com>
Subject: [PATCH 4/4] gprs: Refactor to remove forward declaration
Date: Mon, 18 May 2015 08:47:09 +0200
Message-ID: <1431931629-7771-4-git-send-email-alfonso.sanchez-beato@canonical.com>
In-Reply-To: <1431931629-7771-1-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2979153956532035856==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/gprs.c | 206 ++++++++++++++++++++++++++++++---------------------------=
----
 1 file changed, 102 insertions(+), 104 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index 64fa6f1..9c15abf 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -149,8 +149,6 @@ struct pri_context {
 =

 static void gprs_netreg_update(struct ofono_gprs *gprs);
 static void gprs_deactivate_next(struct ofono_gprs *gprs);
-static void provision_contexts(struct ofono_gprs *gprs, const char *mcc,
-				const char *mnc, const char *spn);
 =

 static GSList *g_drivers =3D NULL;
 static GSList *g_context_drivers =3D NULL;
@@ -2182,6 +2180,108 @@ static DBusMessage *gprs_get_contexts(DBusConnectio=
n *conn,
 	return reply;
 }
 =

+static void provision_context(const struct ofono_gprs_provision_data *ap,
+				struct ofono_gprs *gprs)
+{
+	unsigned int id;
+	struct pri_context *context =3D NULL;
+
+	/* Sanity check */
+	if (ap =3D=3D NULL)
+		return;
+
+	if (ap->name && strlen(ap->name) > MAX_CONTEXT_NAME_LENGTH)
+		return;
+
+	if (ap->apn =3D=3D NULL || strlen(ap->apn) > OFONO_GPRS_MAX_APN_LENGTH)
+		return;
+
+	if (is_valid_apn(ap->apn) =3D=3D FALSE)
+		return;
+
+	if (ap->username &&
+			strlen(ap->username) > OFONO_GPRS_MAX_USERNAME_LENGTH)
+		return;
+
+	if (ap->password &&
+			strlen(ap->password) > OFONO_GPRS_MAX_PASSWORD_LENGTH)
+		return;
+
+	if (ap->message_proxy &&
+			strlen(ap->message_proxy) > MAX_MESSAGE_PROXY_LENGTH)
+		return;
+
+	if (ap->message_center &&
+			strlen(ap->message_center) > MAX_MESSAGE_CENTER_LENGTH)
+		return;
+
+	if (gprs->last_context_id)
+		id =3D idmap_alloc_next(gprs->pid_map, gprs->last_context_id);
+	else
+		id =3D idmap_alloc(gprs->pid_map);
+
+	if (id > idmap_get_max(gprs->pid_map))
+		return;
+
+	context =3D pri_context_create(gprs, ap->name, ap->type);
+	if (context =3D=3D NULL) {
+		idmap_put(gprs->pid_map, id);
+		return;
+	}
+
+	context->id =3D id;
+
+	if (ap->username !=3D NULL)
+		strcpy(context->context.username, ap->username);
+
+	if (ap->password !=3D NULL)
+		strcpy(context->context.password, ap->password);
+
+	context->context.auth_method =3D ap->auth_method;
+
+	strcpy(context->context.apn, ap->apn);
+	context->context.proto =3D ap->proto;
+
+	if (ap->type =3D=3D OFONO_GPRS_CONTEXT_TYPE_MMS) {
+		if (ap->message_proxy !=3D NULL)
+			strcpy(context->message_proxy, ap->message_proxy);
+
+		if (ap->message_center !=3D NULL)
+			strcpy(context->message_center, ap->message_center);
+	}
+
+	if (context_dbus_register(context) =3D=3D FALSE)
+		return;
+
+	gprs->last_context_id =3D id;
+
+	if (gprs->settings) {
+		write_context_settings(gprs, context);
+		storage_sync(gprs->imsi, SETTINGS_STORE, gprs->settings);
+	}
+
+	gprs->contexts =3D g_slist_append(gprs->contexts, context);
+}
+
+static void provision_contexts(struct ofono_gprs *gprs, const char *mcc,
+				const char *mnc, const char *spn)
+{
+	struct ofono_gprs_provision_data *settings;
+	int count;
+	int i;
+
+	if (__ofono_gprs_provision_get_settings(mcc, mnc, spn,
+						&settings, &count) =3D=3D FALSE) {
+		ofono_warn("Provisioning failed");
+		return;
+	}
+
+	for (i =3D 0; i < count; i++)
+		provision_context(&settings[i], gprs);
+
+	__ofono_gprs_provision_free_settings(settings, count);
+}
+
 static void remove_non_active_context(struct ofono_gprs *gprs,
 				struct pri_context *ctx, DBusConnection *conn)
 {
@@ -3067,108 +3167,6 @@ remove:
 		storage_sync(imsi, SETTINGS_STORE, gprs->settings);
 }
 =

-static void provision_context(const struct ofono_gprs_provision_data *ap,
-				struct ofono_gprs *gprs)
-{
-	unsigned int id;
-	struct pri_context *context =3D NULL;
-
-	/* Sanity check */
-	if (ap =3D=3D NULL)
-		return;
-
-	if (ap->name && strlen(ap->name) > MAX_CONTEXT_NAME_LENGTH)
-		return;
-
-	if (ap->apn =3D=3D NULL || strlen(ap->apn) > OFONO_GPRS_MAX_APN_LENGTH)
-		return;
-
-	if (is_valid_apn(ap->apn) =3D=3D FALSE)
-		return;
-
-	if (ap->username &&
-			strlen(ap->username) > OFONO_GPRS_MAX_USERNAME_LENGTH)
-		return;
-
-	if (ap->password &&
-			strlen(ap->password) > OFONO_GPRS_MAX_PASSWORD_LENGTH)
-		return;
-
-	if (ap->message_proxy &&
-			strlen(ap->message_proxy) > MAX_MESSAGE_PROXY_LENGTH)
-		return;
-
-	if (ap->message_center &&
-			strlen(ap->message_center) > MAX_MESSAGE_CENTER_LENGTH)
-		return;
-
-	if (gprs->last_context_id)
-		id =3D idmap_alloc_next(gprs->pid_map, gprs->last_context_id);
-	else
-		id =3D idmap_alloc(gprs->pid_map);
-
-	if (id > idmap_get_max(gprs->pid_map))
-		return;
-
-	context =3D pri_context_create(gprs, ap->name, ap->type);
-	if (context =3D=3D NULL) {
-		idmap_put(gprs->pid_map, id);
-		return;
-	}
-
-	context->id =3D id;
-
-	if (ap->username !=3D NULL)
-		strcpy(context->context.username, ap->username);
-
-	if (ap->password !=3D NULL)
-		strcpy(context->context.password, ap->password);
-
-	context->context.auth_method =3D ap->auth_method;
-
-	strcpy(context->context.apn, ap->apn);
-	context->context.proto =3D ap->proto;
-
-	if (ap->type =3D=3D OFONO_GPRS_CONTEXT_TYPE_MMS) {
-		if (ap->message_proxy !=3D NULL)
-			strcpy(context->message_proxy, ap->message_proxy);
-
-		if (ap->message_center !=3D NULL)
-			strcpy(context->message_center, ap->message_center);
-	}
-
-	if (context_dbus_register(context) =3D=3D FALSE)
-		return;
-
-	gprs->last_context_id =3D id;
-
-	if (gprs->settings) {
-		write_context_settings(gprs, context);
-		storage_sync(gprs->imsi, SETTINGS_STORE, gprs->settings);
-	}
-
-	gprs->contexts =3D g_slist_append(gprs->contexts, context);
-}
-
-static void provision_contexts(struct ofono_gprs *gprs, const char *mcc,
-				const char *mnc, const char *spn)
-{
-	struct ofono_gprs_provision_data *settings;
-	int count;
-	int i;
-
-	if (__ofono_gprs_provision_get_settings(mcc, mnc, spn,
-						&settings, &count) =3D=3D FALSE) {
-		ofono_warn("Provisioning failed");
-		return;
-	}
-
-	for (i =3D 0; i < count; i++)
-		provision_context(&settings[i], gprs);
-
-	__ofono_gprs_provision_free_settings(settings, count);
-}
-
 static void ofono_gprs_finish_register(struct ofono_gprs *gprs)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
-- =

2.1.4


--===============2979153956532035856==--

