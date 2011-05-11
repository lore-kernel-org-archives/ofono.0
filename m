Content-Type: multipart/mixed; boundary="===============7218784987382824601=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] fix miss dbus reply issue
Date: Wed, 11 May 2011 13:34:07 -0500
Message-ID: <4DCAD69F.5000502@gmail.com>
In-Reply-To: <1305023511-596-1-git-send-email-caiwen.zhang@windriver.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7218784987382824601==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Caiwen,

On 05/10/2011 05:31 AM, Caiwen Zhang wrote:
> When set modem offline or power off, if there is some other operation in =
progress,
> the dbus reply may lost. Always check the pending dbus message to make su=
re don't
> miss any reply.
> =

> This should be a common issue, this patch only fix the GPRS relatived.
> =

> ---
>  src/gprs.c |   17 ++++++++++++++++++-
>  1 files changed, 17 insertions(+), 0 deletions(-)
> =

> diff --git a/src/gprs.c b/src/gprs.c
> index e221741..535432e 100644
> --- a/src/gprs.c
> +++ b/src/gprs.c
> @@ -1363,6 +1363,10 @@ static gboolean context_dbus_unregister(struct pri=
_context *ctx)
>  	DBusConnection *conn =3D ofono_dbus_get_connection();
>  	char path[256];
>  =

> +	if (ctx->pending !=3D NULL)
> +		__ofono_dbus_pending_reply(&ctx->pending,
> +					__ofono_error_failed(ctx->pending));
> +

I don't really see the need for this change just yet, especially if the
gprs atom is moved to post_sim state.  Feel free to convince me otherwise ;)

>  	strcpy(path, ctx->path);
>  	idmap_put(ctx->gprs->pid_map, ctx->id);
>  =

> @@ -2133,6 +2137,8 @@ void ofono_gprs_set_cid_range(struct ofono_gprs *gp=
rs,
>  static void gprs_context_unregister(struct ofono_atom *atom)
>  {
>  	struct ofono_gprs_context *gc =3D __ofono_atom_get_data(atom);
> +	GSList *l;
> +	struct pri_context *ctx;
>  =

>  	if (gc->gprs =3D=3D NULL)
>  		return;
> @@ -2143,6 +2149,13 @@ static void gprs_context_unregister(struct ofono_a=
tom *atom)
>  		gc->settings =3D NULL;
>  	}
>  =

> +	for (l =3D gc->gprs->contexts; l; l =3D l->next) {
> +		ctx =3D l->data;
> +		if (ctx->context_driver =3D=3D gc && ctx->pending !=3D NULL)
> +			__ofono_dbus_pending_reply(&ctx->pending,
> +					__ofono_error_failed(ctx->pending));
> +	}
> +
>  	gc->gprs->context_drivers =3D g_slist_remove(gc->gprs->context_drivers,
>  							gc);
>  	gc->gprs =3D NULL;

I've fixed this part slightly differently in commit
4714d8199aacf0ba6be777a70e01b3016ba2aa5f.  Please have a look and let me
know if it solves your problems.

> @@ -2481,6 +2494,10 @@ static void gprs_unregister(struct ofono_atom *ato=
m)
>  		gprs->netreg =3D NULL;
>  	}
>  =

> +	if (gprs->pending !=3D NULL)
> +		__ofono_dbus_pending_reply(&gprs->pending,
> +					__ofono_error_failed(gprs->pending));
> +
>  	ofono_modem_remove_interface(modem,
>  					OFONO_CONNECTION_MANAGER_INTERFACE);
>  	g_dbus_unregister_interface(conn, path,

Again, replying to pending messages on atom removal is not something I
want to do yet.  The application can easily cancel pending calls when a
particular interface goes away..

Regards,
-Denis

--===============7218784987382824601==--

