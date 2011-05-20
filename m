Content-Type: multipart/mixed; boundary="===============8083888543128904692=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH v4 6/8] gprs: Add a host route for STK context type
Date: Fri, 20 May 2011 18:26:19 +0200
Message-ID: <1305908781-8322-6-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1305908781-8322-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8083888543128904692==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/gprs.c |   45 ++++++++++++++++++++++++++-------------------
 1 files changed, 26 insertions(+), 19 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index 86d95bc..a867ea1 100644
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
@@ -616,16 +616,16 @@ static void pri_parse_proxy(struct pri_context *ctx, =
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
@@ -639,12 +639,12 @@ static void pri_parse_proxy(struct pri_context *ctx, =
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
@@ -728,7 +728,7 @@ done:
 	close(sk);
 }
 =

-static void pri_setproxy(const char *interface, const char *proxy)
+static void pri_add_host_route(const char *interface, const char *host)
 {
 	struct rtentry rt;
 	struct sockaddr_in addr;
@@ -747,7 +747,7 @@ static void pri_setproxy(const char *interface, const c=
har *proxy)
 =

 	memset(&addr, 0, sizeof(addr));
 	addr.sin_family =3D AF_INET;
-	addr.sin_addr.s_addr =3D inet_addr(proxy);
+	addr.sin_addr.s_addr =3D inet_addr(host);
 	memcpy(&rt.rt_dst, &addr, sizeof(rt.rt_dst));
 =

 	memset(&addr, 0, sizeof(addr));
@@ -761,7 +761,7 @@ static void pri_setproxy(const char *interface, const c=
har *proxy)
 	memcpy(&rt.rt_genmask, &addr, sizeof(rt.rt_genmask));
 =

 	if (ioctl(sk, SIOCADDRT, &rt) < 0)
-		ofono_error("Failed to add proxy host route");
+		ofono_error("Failed to add host route");
 =

 	close(sk);
 }
@@ -788,12 +788,13 @@ static void pri_reset_context_settings(struct pri_con=
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
@@ -811,12 +812,12 @@ static void pri_update_mms_context_settings(struct pr=
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
@@ -1366,7 +1367,7 @@ static void pri_context_destroy(gpointer userdata)
 {
 	struct pri_context *ctx =3D userdata;
 =

-	g_free(ctx->proxy_host);
+	g_free(ctx->host);
 	g_free(ctx->path);
 	g_free(ctx);
 }
@@ -3086,6 +3087,9 @@ unsigned int __ofono_gprs_add_pdp_context(struct ofon=
o_gprs *gprs,
 =

 	context->context.proto =3D proto;
 =

+	if (host)
+		context->host =3D g_strdup(host);
+
 	gprs->last_context_id =3D id;
 	gprs->contexts =3D g_slist_append(gprs->contexts, context);
 =

@@ -3121,6 +3125,9 @@ static void activate_request_callback(const struct of=
ono_error *error,
 						gc->settings->ipv4) {
 			pri_set_ipv4_addr(gc->settings->interface,
 							gc->settings->ipv4->ip);
+			if (ctx->host)
+				pri_add_host_route(gc->settings->interface,
+								ctx->host);
 		}
 	}
 =

-- =

1.7.1


--===============8083888543128904692==--

