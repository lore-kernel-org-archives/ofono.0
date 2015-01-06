Content-Type: multipart/mixed; boundary="===============6574917416370162926=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: [PATCH] gprs: Setup route for mmsc if there's no mms proxy
Date: Tue, 06 Jan 2015 15:12:39 +0300
Message-ID: <1420546359-7977-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6574917416370162926==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

And don't setup mms route at all if mmsc/proxy host name is not in
dotted IPv4 format.
---
 src/gprs.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index 05ab499..9c643b9 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -585,13 +585,16 @@ static void pri_context_signal_settings(struct pri_co=
ntext *ctx,
 				context_settings_append_ipv6);
 }
 =

-static void pri_parse_proxy(struct pri_context *ctx, const char *proxy)
+static gboolean pri_parse_proxy(struct pri_context *ctx, const char *proxy)
 {
 	char *scheme, *host, *port, *path;
 =

+	if (proxy[0] =3D=3D 0)
+		return FALSE;
+
 	scheme =3D g_strdup(proxy);
 	if (scheme =3D=3D NULL)
-		return;
+		return FALSE;
 =

 	host =3D strstr(scheme, "://");
 	if (host !=3D NULL) {
@@ -604,7 +607,7 @@ static void pri_parse_proxy(struct pri_context *ctx, co=
nst char *proxy)
 			ctx->proxy_port =3D 80;
 		else {
 			g_free(scheme);
-			return;
+			return FALSE;
 		}
 	} else {
 		host =3D scheme;
@@ -626,10 +629,16 @@ static void pri_parse_proxy(struct pri_context *ctx, =
const char *proxy)
 		}
 	}
 =

+	if (host[0] =3D=3D 0) {
+		g_free(scheme);
+		return FALSE;
+	}
+
 	g_free(ctx->proxy_host);
 	ctx->proxy_host =3D g_strdup(host);
 =

 	g_free(scheme);
+	return TRUE;
 }
 =

 static void pri_ifupdown(const char *interface, ofono_bool_t active)
@@ -715,11 +724,16 @@ static void pri_setproxy(const char *interface, const=
 char *proxy)
 {
 	struct rtentry rt;
 	struct sockaddr_in addr;
+	in_addr_t proxy_addr;
 	int sk;
 =

 	if (interface =3D=3D NULL)
 		return;
 =

+	proxy_addr =3D inet_addr(proxy);
+	if (proxy_addr =3D=3D INADDR_NONE)
+		return;
+
 	sk =3D socket(PF_INET, SOCK_DGRAM, 0);
 	if (sk < 0)
 		return;
@@ -730,7 +744,7 @@ static void pri_setproxy(const char *interface, const c=
har *proxy)
 =

 	memset(&addr, 0, sizeof(addr));
 	addr.sin_family =3D AF_INET;
-	addr.sin_addr.s_addr =3D inet_addr(proxy);
+	addr.sin_addr.s_addr =3D proxy_addr;
 	memcpy(&rt.rt_dst, &addr, sizeof(rt.rt_dst));
 =

 	memset(&addr, 0, sizeof(addr));
@@ -792,7 +806,8 @@ static void pri_update_mms_context_settings(struct pri_=
context *ctx)
 	if (ctx->message_proxy)
 		settings->ipv4->proxy =3D g_strdup(ctx->message_proxy);
 =

-	pri_parse_proxy(ctx, ctx->message_proxy);
+	if (!pri_parse_proxy(ctx, ctx->message_proxy))
+		pri_parse_proxy(ctx, ctx->message_center);
 =

 	DBG("proxy %s port %u", ctx->proxy_host, ctx->proxy_port);
 =

-- =

1.8.3.2


--===============6574917416370162926==--

