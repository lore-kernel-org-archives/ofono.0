Content-Type: multipart/mixed; boundary="===============4150301884107126347=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 01/11] gprs: Add private APIs to activate/deactivate private
 contexts
Date: Tue, 28 Jun 2011 19:16:13 +0200
Message-ID: <1309281383-6605-2-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1309281383-6605-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4150301884107126347==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/gprs.c  |  211 +++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/ofono.h |   17 +++++
 2 files changed, 228 insertions(+), 0 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index acbfa56..b3e6869 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -59,6 +59,7 @@
 =

 static GSList *g_drivers =3D NULL;
 static GSList *g_context_drivers =3D NULL;
+static GSList *g_private_contexts =3D NULL;
 =

 /* 27.007 Section 7.29 */
 enum packet_bearer {
@@ -149,6 +150,13 @@ struct pri_context {
 	struct ofono_gprs *gprs;
 };
 =

+struct gprs_private_context {
+	unsigned int cid;
+	struct ofono_gprs_context *context_driver;
+	void *notify;
+	void *notify_data;
+};
+
 static void gprs_netreg_update(struct ofono_gprs *gprs);
 static void gprs_deactivate_next(struct ofono_gprs *gprs);
 =

@@ -346,6 +354,20 @@ static struct pri_context *gprs_context_by_path(struct=
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
@@ -872,6 +894,8 @@ static void pri_activate_callback(const struct ofono_er=
ror *error, void *data)
 				dbus_message_new_method_return(ctx->pending));
 =

 	if (gc->settings->interface !=3D NULL) {
+		DBG("Interface %s", gc->settings->interface);
+
 		pri_ifupdown(gc->settings->interface, TRUE);
 =

 		if (ctx->type =3D=3D OFONO_GPRS_CONTEXT_TYPE_MMS &&
@@ -3012,3 +3036,190 @@ void *ofono_gprs_get_data(struct ofono_gprs *gprs)
 {
 	return gprs->driver_data;
 }
+
+static struct gprs_private_context *gprs_private_context_by_id(unsigned in=
t id)
+{
+	GSList *l;
+
+	for (l =3D g_private_contexts; l; l =3D l->next) {
+		struct gprs_private_context *ctx =3D l->data;
+
+		if (ctx->cid =3D=3D id)
+			return ctx;
+	}
+
+	return NULL;
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
+		context_settings_free(settings);
+		gprs_cid_release(ctx->context_driver->gprs, ctx->cid);
+		ctx->context_driver->inuse =3D FALSE;
+
+		if (ctx->notify)
+			((__ofono_gprs_activate_context_cb_t) ctx->notify)
+				(-ENOSYS, NULL, NULL, ctx->notify_data);
+
+		g_private_contexts =3D g_slist_remove(g_private_contexts, ctx);
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
+	if (ctx->notify && settings->ipv4)
+		((__ofono_gprs_activate_context_cb_t) ctx->notify)
+					(0, settings->interface,
+						settings->ipv4->ip,
+						ctx->notify_data);
+}
+
+int __ofono_gprs_activate_context(struct ofono_gprs *gprs,
+				struct ofono_gprs_primary_context *context,
+				__ofono_gprs_activate_context_cb_t cb,
+				void *data)
+{
+	struct gprs_private_context *private_ctx;
+	struct pri_context *default_ctx =3D NULL;
+	struct ofono_gprs_context *gc =3D NULL;
+	struct idmap *cidmap =3D gprs->cid_map;
+	GSList *l;
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
+		return EINVAL;
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
+	private_ctx =3D g_try_new0(struct gprs_private_context, 1);
+	if (private_ctx =3D=3D NULL)
+		return -ENOMEM;
+
+	private_ctx->cid =3D gprs_cid_alloc(gprs);
+	if (private_ctx->cid =3D=3D 0) {
+		g_free(private_ctx);
+		return -EBUSY;
+	}
+
+	context->cid =3D private_ctx->cid;
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
+		g_free(private_ctx);
+		return -EBUSY;
+	}
+
+	gc->inuse =3D TRUE;
+	gc->settings->ipv4 =3D g_new0(struct ipv4_settings, 1);
+	private_ctx->context_driver =3D gc;
+	private_ctx->notify =3D cb;
+	private_ctx->notify_data =3D data;
+
+	g_private_contexts =3D g_slist_append(g_private_contexts, private_ctx);
+
+	gc->driver->activate_primary(gc, context, activate_request_callback,
+					private_ctx);
+	return 0;
+}
+
+static void deactivate_request_callback(const struct ofono_error *error,
+					void *data)
+{
+	struct gprs_private_context *ctx =3D data;
+	struct context_settings *settings =3D ctx->context_driver->settings;
+	int err =3D 0;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		DBG("Deactivating context failed with error: %s",
+				telephony_error_to_str(error));
+		err =3D -ENOSYS;
+	}
+
+	pri_set_ipv4_addr(settings->interface, NULL);
+	pri_ifupdown(settings->interface, FALSE);
+	context_settings_free(settings);
+
+	DBG("Release Context cid %d", ctx->cid);
+
+	gprs_cid_release(ctx->context_driver->gprs, ctx->cid);
+	ctx->context_driver->inuse =3D FALSE;
+
+	if (ctx->notify)
+		((__ofono_gprs_deactivate_context_cb_t) ctx->notify)
+				(err, ctx->notify_data);
+
+	g_private_contexts =3D g_slist_remove(g_private_contexts, ctx);
+}
+
+int __ofono_gprs_deactivate_context(unsigned int id,
+					__ofono_gprs_deactivate_context_cb_t cb,
+					void *data)
+{
+	struct gprs_private_context *private_ctx;
+	struct ofono_gprs_context *gc;
+
+	DBG("Deactivate context with cid %d", id);
+
+	private_ctx =3D gprs_private_context_by_id(id);
+	if (private_ctx =3D=3D NULL)
+		return -EINVAL;
+
+	private_ctx->notify =3D cb;
+	private_ctx->notify_data =3D data;
+
+	gc =3D private_ctx->context_driver;
+	gc->driver->deactivate_primary(gc, private_ctx->cid,
+				deactivate_request_callback, private_ctx);
+	return 0;
+}
diff --git a/src/ofono.h b/src/ofono.h
index 6524806..6b72816 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -240,6 +240,23 @@ gboolean __ofono_call_settings_is_busy(struct ofono_ca=
ll_settings *cs);
 #include <ofono/phonebook.h>
 #include <ofono/gprs.h>
 #include <ofono/gprs-context.h>
+
+typedef void (*__ofono_gprs_activate_context_cb_t)(int error,
+						const char *interface,
+						const char *ip,
+						void *data);
+
+typedef void (*__ofono_gprs_deactivate_context_cb_t)(int error, void *data=
);
+
+int __ofono_gprs_deactivate_context(unsigned int id,
+					__ofono_gprs_deactivate_context_cb_t cb,
+					void *data);
+
+int __ofono_gprs_activate_context(struct ofono_gprs *gprs,
+				struct ofono_gprs_primary_context *context,
+				__ofono_gprs_activate_context_cb_t cb,
+				void *data);
+
 #include <ofono/radio-settings.h>
 #include <ofono/audio-settings.h>
 #include <ofono/ctm.h>
-- =

1.7.1


--===============4150301884107126347==--

