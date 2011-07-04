Content-Type: multipart/mixed; boundary="===============4761294301802960323=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH v2 01/11] gprs: Add private APIs to activate/deactivate a
 private context for STK
Date: Mon, 04 Jul 2011 18:06:32 +0200
Message-ID: <1309795602-26046-2-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1309795602-26046-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4761294301802960323==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/gprs.c  |  228 +++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/ofono.h |   18 +++++
 2 files changed, 246 insertions(+), 0 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index acbfa56..f6090ba 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -149,6 +149,19 @@ struct pri_context {
 	struct ofono_gprs *gprs;
 };
 =

+struct gprs_private_context {
+	unsigned int cid;
+	struct ofono_gprs_context *context_driver;
+	union {
+		__ofono_gprs_private_context_activate_cb_t act;
+		__ofono_gprs_private_context_deactivate_cb_t deact;
+	};
+	void *cb_data;
+};
+
+static struct gprs_private_context *stk_context =3D NULL;
+
+static void gprs_private_context_release(struct gprs_private_context *ctx);
 static void gprs_netreg_update(struct ofono_gprs *gprs);
 static void gprs_deactivate_next(struct ofono_gprs *gprs);
 =

@@ -346,6 +359,20 @@ static struct pri_context *gprs_context_by_path(struct=
 ofono_gprs *gprs,
 	return NULL;
 }
 =

+static struct pri_context *gprs_get_default_context(struct ofono_gprs *gpr=
s)
+{
+	GSList *l;
+
+	for (l =3D gprs->contexts; l; l =3D l->next) {
+		struct pri_context *ctx =3D l->data;
+
+		if (ctx->type =3D=3D OFONO_GPRS_CONTEXT_TYPE_INTERNET)
+			return ctx;
+	}
+
+	return NULL;
+}
+
 static void context_settings_free(struct context_settings *settings)
 {
 	if (settings->ipv4) {
@@ -872,6 +899,8 @@ static void pri_activate_callback(const struct ofono_er=
ror *error, void *data)
 				dbus_message_new_method_return(ctx->pending));
 =

 	if (gc->settings->interface !=3D NULL) {
+		DBG("Interface %s", gc->settings->interface);
+
 		pri_ifupdown(gc->settings->interface, TRUE);
 =

 		if (ctx->type =3D=3D OFONO_GPRS_CONTEXT_TYPE_MMS &&
@@ -1471,6 +1500,12 @@ static void gprs_attached_update(struct ofono_gprs *=
gprs)
 					"Active", DBUS_TYPE_BOOLEAN, &value);
 		}
 =

+		if (stk_context) {
+			gprs_private_context_release(stk_context);
+			g_free(stk_context);
+			stk_context =3D NULL;
+		}
+
 		gprs->bearer =3D -1;
 	}
 =

@@ -2173,6 +2208,12 @@ static void gprs_context_unregister(struct ofono_ato=
m *atom)
 					"Active", DBUS_TYPE_BOOLEAN, &value);
 	}
 =

+	if (stk_context && stk_context->context_driver =3D=3D gc) {
+		gprs_private_context_release(stk_context);
+		g_free(stk_context);
+		stk_context =3D NULL;
+	}
+
 	gc->gprs->context_drivers =3D g_slist_remove(gc->gprs->context_drivers,
 							gc);
 	gc->gprs =3D NULL;
@@ -2243,6 +2284,12 @@ void ofono_gprs_context_deactivated(struct ofono_gpr=
s_context *gc,
 					OFONO_CONNECTION_CONTEXT_INTERFACE,
 					"Active", DBUS_TYPE_BOOLEAN, &value);
 	}
+
+	if (stk_context && stk_context->context_driver =3D=3D gc) {
+		gprs_private_context_release(stk_context);
+		g_free(stk_context);
+		stk_context =3D NULL;
+	}
 }
 =

 int ofono_gprs_context_driver_register(const struct ofono_gprs_context_dri=
ver *d)
@@ -3012,3 +3059,184 @@ void *ofono_gprs_get_data(struct ofono_gprs *gprs)
 {
 	return gprs->driver_data;
 }
+
+static void gprs_private_context_release(struct gprs_private_context *ctx)
+{
+	struct context_settings *settings =3D ctx->context_driver->settings;
+
+	if (settings->interface !=3D NULL) {
+		pri_set_ipv4_addr(settings->interface, NULL);
+		pri_ifupdown(settings->interface, FALSE);
+	}
+
+	context_settings_free(settings);
+
+	DBG("Release private context cid %d", ctx->cid);
+
+	gprs_cid_release(ctx->context_driver->gprs, ctx->cid);
+	ctx->context_driver->inuse =3D FALSE;
+}
+
+static void activate_request_callback(const struct ofono_error *error,
+					void *data)
+{
+	struct gprs_private_context *ctx =3D data;
+	struct context_settings *settings =3D ctx->context_driver->settings;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		DBG("Activating context failed with error: %s",
+				telephony_error_to_str(error));
+		gprs_private_context_release(ctx);
+
+		if (ctx->act)
+			ctx->act(-ENOSYS, NULL, NULL, ctx->cb_data);
+
+		g_free(ctx);
+		stk_context =3D NULL;
+		return;
+	}
+
+	if (settings->interface !=3D NULL) {
+		pri_ifupdown(settings->interface, TRUE);
+
+		if (settings->ipv4)
+			pri_set_ipv4_addr(settings->interface,
+							settings->ipv4->ip);
+	}
+
+	if (ctx->act && settings->ipv4)
+		ctx->act(0, settings->interface, settings->ipv4->ip,
+				ctx->cb_data);
+}
+
+int __ofono_gprs_private_context_activate(struct ofono_gprs *gprs,
+				struct ofono_gprs_primary_context *context,
+				__ofono_gprs_private_context_activate_cb_t cb,
+				void *data)
+{
+	struct pri_context *default_ctx =3D NULL;
+	struct ofono_gprs_context *gc =3D NULL;
+	struct idmap *cidmap =3D gprs->cid_map;
+	GSList *l;
+
+	if (stk_context)
+		return -EBUSY;
+
+	if (context->apn[0] =3D=3D '\0' || (context->username[0] =3D=3D '\0' &&
+			context->password[0] =3D=3D '\0')) {
+		/* take the default primary internet context */
+		default_ctx =3D gprs_get_default_context(gprs);
+
+		if (default_ctx =3D=3D NULL && context->apn[0] =3D=3D '\0')
+			return -ENOENT;
+	}
+
+	if (context->apn[0] !=3D '\0' && is_valid_apn(context->apn) =3D=3D FALSE)
+		return -EINVAL;
+
+	if (context->proto !=3D OFONO_GPRS_PROTO_IPV4V6 &&
+			context->proto !=3D OFONO_GPRS_PROTO_IP)
+		return -ENOSYS;
+
+	if (cidmap =3D=3D NULL)
+		return -ENOSYS;
+
+	if (context->apn[0] =3D=3D '\0') {
+		strcpy(context->apn, default_ctx->context.apn);
+		strcpy(context->username, default_ctx->context.username);
+		strcpy(context->password, default_ctx->context.password);
+	}
+
+	stk_context =3D g_try_new0(struct gprs_private_context, 1);
+	if (stk_context =3D=3D NULL)
+		return -ENOMEM;
+
+	stk_context->cid =3D gprs_cid_alloc(gprs);
+	if (stk_context->cid =3D=3D 0) {
+		g_free(stk_context);
+		stk_context =3D NULL;
+		return -EBUSY;
+	}
+
+	context->cid =3D stk_context->cid;
+
+	for (l =3D gprs->context_drivers; l; l =3D l->next) {
+		gc =3D l->data;
+
+		if (gc->inuse =3D=3D TRUE)
+			continue;
+
+		if (gc->driver =3D=3D NULL)
+			continue;
+
+		if (gc->driver->activate_primary =3D=3D NULL ||
+				gc->driver->deactivate_primary =3D=3D NULL)
+			continue;
+
+		if (gc->type !=3D OFONO_GPRS_CONTEXT_TYPE_ANY &&
+				gc->type !=3D OFONO_GPRS_CONTEXT_TYPE_INTERNET)
+			continue;
+
+		break;
+	}
+
+	if (gc =3D=3D NULL) {
+		g_free(stk_context);
+		stk_context =3D NULL;
+		return -EBUSY;
+	}
+
+	gc->inuse =3D TRUE;
+	gc->settings->ipv4 =3D g_new0(struct ipv4_settings, 1);
+	stk_context->context_driver =3D gc;
+	stk_context->act =3D cb;
+	stk_context->cb_data =3D data;
+
+	gc->driver->activate_primary(gc, context, activate_request_callback,
+					stk_context);
+	return 0;
+}
+
+static void deactivate_request_callback(const struct ofono_error *error,
+					void *data)
+{
+	struct gprs_private_context *ctx =3D data;
+	int err =3D 0;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		DBG("Deactivating context failed with error: %s",
+				telephony_error_to_str(error));
+		err =3D -ENOSYS;
+	}
+
+	gprs_private_context_release(ctx);
+
+	if (ctx->deact)
+		ctx->deact(err, ctx->cb_data);
+
+	g_free(ctx);
+	stk_context =3D NULL;
+}
+
+int __ofono_gprs_private_context_deactivate(struct ofono_gprs *gprs,
+				__ofono_gprs_private_context_deactivate_cb_t cb,
+				void *data)
+{
+	struct ofono_gprs_context *gc;
+
+	if (stk_context =3D=3D NULL)
+		return -ENOENT;
+
+	if (stk_context->context_driver->gprs !=3D gprs)
+		return -EINVAL;
+
+	DBG("Deactivate context with cid %d", stk_context->cid);
+
+	stk_context->deact =3D cb;
+	stk_context->cb_data =3D data;
+
+	gc =3D stk_context->context_driver;
+	gc->driver->deactivate_primary(gc, stk_context->cid,
+				deactivate_request_callback, stk_context);
+	return 0;
+}
diff --git a/src/ofono.h b/src/ofono.h
index 6524806..274912d 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -240,6 +240,24 @@ gboolean __ofono_call_settings_is_busy(struct ofono_ca=
ll_settings *cs);
 #include <ofono/phonebook.h>
 #include <ofono/gprs.h>
 #include <ofono/gprs-context.h>
+
+typedef void (*__ofono_gprs_private_context_deactivate_cb_t)(int error,
+								void *data);
+
+typedef void (*__ofono_gprs_private_context_activate_cb_t)(int error,
+						const char *interface,
+						const char *ip,
+						void *data);
+
+int __ofono_gprs_private_context_deactivate(struct ofono_gprs *gprs,
+				__ofono_gprs_private_context_deactivate_cb_t cb,
+				void *data);
+
+int __ofono_gprs_private_context_activate(struct ofono_gprs *gprs,
+				struct ofono_gprs_primary_context *context,
+				__ofono_gprs_private_context_activate_cb_t cb,
+				void *data);
+
 #include <ofono/radio-settings.h>
 #include <ofono/audio-settings.h>
 #include <ofono/ctm.h>
-- =

1.7.1


--===============4761294301802960323==--

