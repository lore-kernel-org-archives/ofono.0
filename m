Content-Type: multipart/mixed; boundary="===============0360573273044026419=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] src/gprs.c: make sure that the context is properly
 released
Date: Thu, 20 Sep 2018 10:38:22 -0500
Message-ID: <d2732812-21f1-d5b1-cfc5-4189c26f7b6e@gmail.com>
In-Reply-To: <1537418579-18547-1-git-send-email-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0360573273044026419==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

On 09/19/2018 11:42 PM, Giacinto Cifelli wrote:
> ---
>   src/gprs.c | 4 ++++
>   1 file changed, 4 insertions(+)
> =

> diff --git a/src/gprs.c b/src/gprs.c
> index 8f5d195..40f43e3 100644
> --- a/src/gprs.c
> +++ b/src/gprs.c
> @@ -1642,6 +1642,9 @@ static void release_active_contexts(struct ofono_gp=
rs *gprs)
>   =

>   		if (gc->driver->detach_shutdown !=3D NULL)
>   			gc->driver->detach_shutdown(gc, ctx->context.cid);
> +
> +		/* Make sure the context is properly cleared */
> +		release_context(ctx);
>   	}
>   }
>   =

> @@ -2241,6 +2244,7 @@ static DBusMessage *gprs_remove_context(DBusConnect=
ion *conn,
>   	}
>   =

>   	DBG("Unregistering context: %s", ctx->path);
> +	release_context(ctx);

If we get here then the context isn't active and doesn't need to be =

released.  Active context release happens in gprs_deactivate_for_remove. =

  So I don't think this is needed?

>   	context_dbus_unregister(ctx);
>   	gprs->contexts =3D g_slist_remove(gprs->contexts, ctx);
>   =

> =


Regards,
-Denis

--===============0360573273044026419==--

