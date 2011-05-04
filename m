Content-Type: multipart/mixed; boundary="===============8362782596442719165=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 4/4] gprs: Add a host route for STK context type.
Date: Wed, 04 May 2011 19:26:42 +0200
Message-ID: <1304530002-13336-5-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1304530002-13336-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8362782596442719165==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/gprs.c |   51 ++++++++++++++++++++++++++++-----------------------
 1 files changed, 28 insertions(+), 23 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index 2b88324..9618d7a 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -141,8 +141,8 @@ struct pri_context {
 	unsigned int id;
 	char *path;
 	char *key;
-	char *proxy_host;
-	uint16_t proxy_port;
+	char *host;
+	uint16_t port;
 	DBusMessage *pending;
 	struct ofono_gprs_primary_context context;
 	struct ofono_gprs_context *context_driver;
@@ -613,16 +613,16 @@ static void pri_parse_proxy(struct pri_context *ctx, =
const char *proxy)
 		host +=3D 3;
 =

 		if (strcasecmp(scheme, "https") =3D=3D 0)
-			ctx->proxy_port =3D 443;
+			ctx->port =3D 443;
 		else if (strcasecmp(scheme, "http") =3D=3D 0)
-			ctx->proxy_port =3D 80;
+			ctx->port =3D 80;
 		else {
 			g_free(scheme);
 			return;
 		}
 	} else {
 		host =3D scheme;
-		ctx->proxy_port =3D 80;
+		ctx->port =3D 80;
 	}
 =

 	path =3D strchr(host, '/');
@@ -636,12 +636,12 @@ static void pri_parse_proxy(struct pri_context *ctx, =
const char *proxy)
 =

 		if (*end =3D=3D '\0') {
 			*port =3D '\0';
-			ctx->proxy_port =3D tmp;
+			ctx->port =3D tmp;
 		}
 	}
 =

-	g_free(ctx->proxy_host);
-	ctx->proxy_host =3D g_strdup(host);
+	g_free(ctx->host);
+	ctx->host =3D g_strdup(host);
 =

 	g_free(scheme);
 }
@@ -725,7 +725,7 @@ done:
 	close(sk);
 }
 =

-static void pri_setproxy(const char *interface, const char *proxy)
+static void pri_add_host_route(const char *interface, const char *host)
 {
 	struct rtentry rt;
 	struct sockaddr_in addr;
@@ -744,7 +744,7 @@ static void pri_setproxy(const char *interface, const c=
har *proxy)
 =

 	memset(&addr, 0, sizeof(addr));
 	addr.sin_family =3D AF_INET;
-	addr.sin_addr.s_addr =3D inet_addr(proxy);
+	addr.sin_addr.s_addr =3D inet_addr(host);
 	memcpy(&rt.rt_dst, &addr, sizeof(rt.rt_dst));
 =

 	memset(&addr, 0, sizeof(addr));
@@ -758,7 +758,7 @@ static void pri_setproxy(const char *interface, const c=
har *proxy)
 	memcpy(&rt.rt_genmask, &addr, sizeof(rt.rt_genmask));
 =

 	if (ioctl(sk, SIOCADDRT, &rt) < 0)
-		ofono_error("Failed to add proxy host route");
+		ofono_error("Failed to add host route");
 =

 	close(sk);
 }
@@ -785,12 +785,13 @@ static void pri_reset_context_settings(struct pri_con=
text *ctx)
 =

 	pri_context_signal_settings(ctx, signal_ipv4, signal_ipv6);
 =

-	if (ctx->type =3D=3D OFONO_GPRS_CONTEXT_TYPE_MMS) {
+	if (ctx->type =3D=3D OFONO_GPRS_CONTEXT_TYPE_MMS ||
+			ctx->type =3D=3D OFONO_GPRS_CONTEXT_TYPE_STK) {
 		pri_set_ipv4_addr(interface, NULL);
 =

-		g_free(ctx->proxy_host);
-		ctx->proxy_host =3D NULL;
-		ctx->proxy_port =3D 0;
+		g_free(ctx->host);
+		ctx->host =3D NULL;
+		ctx->port =3D 0;
 	}
 =

 	pri_ifupdown(interface, FALSE);
@@ -798,7 +799,7 @@ static void pri_reset_context_settings(struct pri_conte=
xt *ctx)
 	g_free(interface);
 }
 =

-static void pri_update_mms_context_settings(struct pri_context *ctx)
+static void pri_update_interface(struct pri_context *ctx)
 {
 	struct ofono_gprs_context *gc =3D ctx->context_driver;
 	struct context_settings *settings =3D gc->settings;
@@ -808,12 +809,12 @@ static void pri_update_mms_context_settings(struct pr=
i_context *ctx)
 =

 	pri_parse_proxy(ctx, ctx->message_proxy);
 =

-	DBG("proxy %s port %u", ctx->proxy_host, ctx->proxy_port);
+	DBG("host %s port %u", ctx->host, ctx->port);
 =

 	pri_set_ipv4_addr(settings->interface, settings->ipv4->ip);
 =

-	if (ctx->proxy_host)
-		pri_setproxy(settings->interface, ctx->proxy_host);
+	if (ctx->host)
+		pri_add_host_route(settings->interface, ctx->host);
 }
 =

 static void append_context_properties(struct pri_context *ctx,
@@ -921,9 +922,10 @@ static void pri_activate_callback(const struct ofono_e=
rror *error, void *data)
 	if (gc->settings->interface !=3D NULL) {
 		pri_ifupdown(gc->settings->interface, TRUE);
 =

-		if (ctx->type =3D=3D OFONO_GPRS_CONTEXT_TYPE_MMS &&
-				gc->settings->ipv4)
-			pri_update_mms_context_settings(ctx);
+		if ((ctx->type =3D=3D OFONO_GPRS_CONTEXT_TYPE_MMS &&
+				gc->settings->ipv4) ||
+				ctx->type =3D=3D OFONO_GPRS_CONTEXT_TYPE_STK)
+			pri_update_interface(ctx);
 =

 		pri_context_signal_settings(ctx, gc->settings->ipv4 !=3D NULL,
 						gc->settings->ipv6 !=3D NULL);
@@ -1383,7 +1385,7 @@ static void pri_context_destroy(gpointer userdata)
 {
 	struct pri_context *ctx =3D userdata;
 =

-	g_free(ctx->proxy_host);
+	g_free(ctx->host);
 	g_free(ctx->path);
 	g_free(ctx);
 }
@@ -3113,6 +3115,9 @@ unsigned int ofono_gprs_add_pdp_context(struct ofono_=
gprs *gprs,
 =

 	context->context.proto =3D proto;
 =

+	if (host)
+		context->host =3D g_strdup(host);
+
 	if (context_dbus_register(context) =3D=3D FALSE)
 		return 0;
 =

-- =

1.7.1


--===============8362782596442719165==--

