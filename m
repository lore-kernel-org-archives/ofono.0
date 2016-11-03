Content-Type: multipart/mixed; boundary="===============8531674150794106095=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] gprs: Check GPRS_FLAG_ATTACHED_UPDATE in
 pri_deactivate_callback
Date: Thu, 03 Nov 2016 13:39:49 -0500
Message-ID: <581B8475.1040802@gmail.com>
In-Reply-To: <1478015597-22406-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8531674150794106095==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Slava,

On 11/01/2016 10:53 AM, Slava Monich wrote:
> This prevents attached state from getting stuck at 0 like this:
>
> 1. Context deactivation is initiated over D-Bus, ctx->pending is set
> 2. Attached becomes FALSE, context is still marked as active
> 3. Attached becomes TRUE, gprs_attached_update sets GPRS_FLAG_ATTACHED_UP=
DATE
> 4. Deactivation completes, attached is 0, driver_attached is 1
>
> Futher network status updates don't call gprs_attached_update because
> driver_attached is still 1, so attached is staying 0 until we lose the
> data registration again which may not happen for quite a long time.
> ---
>   src/gprs.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
>
> diff --git a/src/gprs.c b/src/gprs.c
> index 3a4a819..3d71398 100644
> --- a/src/gprs.c
> +++ b/src/gprs.c
> @@ -135,6 +135,7 @@ struct pri_context {
>   	struct ofono_gprs *gprs;
>   };
>
> +static void gprs_attached_update(struct ofono_gprs *gprs);
>   static void gprs_netreg_update(struct ofono_gprs *gprs);
>   static void gprs_deactivate_next(struct ofono_gprs *gprs);
>
> @@ -946,6 +947,16 @@ static void pri_deactivate_callback(const struct ofo=
no_error *error, void *data)
>   	ofono_dbus_signal_property_changed(conn, ctx->path,
>   					OFONO_CONNECTION_CONTEXT_INTERFACE,
>   					"Active", DBUS_TYPE_BOOLEAN, &value);
> +
> +	/*
> +	 * If "Attached" property was about to be signalled as TRUE but there
> +	 * were still active contexts, try again to signal "Attached" property
> +	 * to registered applications after active contexts have been released.
> +	 */
> +	if (ctx->gprs && (ctx->gprs->flags & GPRS_FLAG_ATTACHED_UPDATE)) {

Can we get rid of the ctx->gprs check.  ctx->gprs is set to NULL only if:

1. Context was never added, in which case you can't call SetProperty on =

it anyway.
2. context was unregistered, in which case the driver shouldn't even be =

able to call the callback, and even if it did, we'd be crashing earlier =

since pending was already replied to.
3. gprs atom itself was unregistered

> +		ctx->gprs->flags &=3D ~GPRS_FLAG_ATTACHED_UPDATE;
> +		gprs_attached_update(ctx->gprs);
> +	}
>   }
>
>   static void pri_read_settings_callback(const struct ofono_error *error,
>

Regards,
-Denis

--===============8531674150794106095==--

