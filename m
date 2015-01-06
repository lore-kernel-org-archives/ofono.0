Content-Type: multipart/mixed; boundary="===============2002105442809908574=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] gprs: Setup route for mmsc if there's no mms proxy
Date: Tue, 06 Jan 2015 08:19:34 -0800
Message-ID: <E1FEF121-03BB-4ADB-91C6-88D98D77EA91@holtmann.org>
In-Reply-To: <1420546359-7977-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2002105442809908574==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Slava,

> And don't setup mms route at all if mmsc/proxy host name is not in
> dotted IPv4 format.
> ---
> src/gprs.c | 25 ++++++++++++++++++++-----
> 1 file changed, 20 insertions(+), 5 deletions(-)
> =

> diff --git a/src/gprs.c b/src/gprs.c
> index 05ab499..9c643b9 100644
> --- a/src/gprs.c
> +++ b/src/gprs.c
> @@ -585,13 +585,16 @@ static void pri_context_signal_settings(struct pri_=
context *ctx,
> 				context_settings_append_ipv6);
> }
> =

> -static void pri_parse_proxy(struct pri_context *ctx, const char *proxy)
> +static gboolean pri_parse_proxy(struct pri_context *ctx, const char *pro=
xy)
> {
> 	char *scheme, *host, *port, *path;
> =

> +	if (proxy[0] =3D=3D 0)
> +		return FALSE;
> +
> 	scheme =3D g_strdup(proxy);
> 	if (scheme =3D=3D NULL)
> -		return;
> +		return FALSE;
> =

> 	host =3D strstr(scheme, "://");
> 	if (host !=3D NULL) {
> @@ -604,7 +607,7 @@ static void pri_parse_proxy(struct pri_context *ctx, =
const char *proxy)
> 			ctx->proxy_port =3D 80;
> 		else {
> 			g_free(scheme);
> -			return;
> +			return FALSE;
> 		}
> 	} else {
> 		host =3D scheme;
> @@ -626,10 +629,16 @@ static void pri_parse_proxy(struct pri_context *ctx=
, const char *proxy)
> 		}
> 	}
> =

> +	if (host[0] =3D=3D 0) {
> +		g_free(scheme);
> +		return FALSE;
> +	}
> +
> 	g_free(ctx->proxy_host);
> 	ctx->proxy_host =3D g_strdup(host);
> =

> 	g_free(scheme);
> +	return TRUE;
> }

There is a single call instance for pri_parse_proxy. Why are we not checkin=
g right there if the ctx->message_proxy is something that is worth while pa=
rsing.

> static void pri_ifupdown(const char *interface, ofono_bool_t active)
> @@ -715,11 +724,16 @@ static void pri_setproxy(const char *interface, con=
st char *proxy)
> {
> 	struct rtentry rt;
> 	struct sockaddr_in addr;
> +	in_addr_t proxy_addr;
> 	int sk;
> =

> 	if (interface =3D=3D NULL)
> 		return;
> =

> +	proxy_addr =3D inet_addr(proxy);
> +	if (proxy_addr =3D=3D INADDR_NONE)
> +		return;
> +
> 	sk =3D socket(PF_INET, SOCK_DGRAM, 0);
> 	if (sk < 0)
> 		return;
> @@ -730,7 +744,7 @@ static void pri_setproxy(const char *interface, const=
 char *proxy)
> =

> 	memset(&addr, 0, sizeof(addr));
> 	addr.sin_family =3D AF_INET;
> -	addr.sin_addr.s_addr =3D inet_addr(proxy);
> +	addr.sin_addr.s_addr =3D proxy_addr;
> 	memcpy(&rt.rt_dst, &addr, sizeof(rt.rt_dst));
> =

> 	memset(&addr, 0, sizeof(addr));

This extra handling seems unneeded. We do not call pri_setproxy when ctx->p=
roxy_host =3D=3D NULL. So what should happen is to ensure that ctx->proxy_h=
ost is set to NULL. Then no change here is needed.

> @@ -792,7 +806,8 @@ static void pri_update_mms_context_settings(struct pr=
i_context *ctx)
> 	if (ctx->message_proxy)
> 		settings->ipv4->proxy =3D g_strdup(ctx->message_proxy);
> =

> -	pri_parse_proxy(ctx, ctx->message_proxy);
> +	if (!pri_parse_proxy(ctx, ctx->message_proxy))
> +		pri_parse_proxy(ctx, ctx->message_center);

What is this change doing? Parsing the message center into ctx->proxy_host =
makes no sense to me.

Regards

Marcel


--===============2002105442809908574==--

