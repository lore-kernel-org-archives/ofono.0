Content-Type: multipart/mixed; boundary="===============1008353076837393927=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 11/11] gprs: Add API to set a 'detach'notification callback
Date: Wed, 29 Jun 2011 17:46:54 -0500
Message-ID: <4E0BAB5E.7050103@gmail.com>
In-Reply-To: <1309281383-6605-12-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1008353076837393927==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On 06/28/2011 12:16 PM, Philippe Nunes wrote:
> ---
>  src/gprs.c  |   37 +++++++++++++++++++++++++++++++++++++
>  src/ofono.h |    6 ++++++
>  2 files changed, 43 insertions(+), 0 deletions(-)
> =

> diff --git a/src/gprs.c b/src/gprs.c
> index b3e6869..0166e70 100644
> --- a/src/gprs.c
> +++ b/src/gprs.c
> @@ -1495,6 +1495,28 @@ static void gprs_attached_update(struct ofono_gprs=
 *gprs)
>  					"Active", DBUS_TYPE_BOOLEAN, &value);
>  		}
>  =

> +		for (l =3D g_private_contexts; l; l =3D l->next) {
> +			struct gprs_private_context *ctx =3D l->data;
> +			struct context_settings *settings =3D
> +						ctx->context_driver->settings;
> +
> +			pri_set_ipv4_addr(settings->interface, NULL);
> +			pri_ifupdown(settings->interface, FALSE);
> +			context_settings_free(settings);
> +
> +			DBG("Release private context cid %d", ctx->cid);
> +
> +			gprs_cid_release(gprs, ctx->cid);
> +			ctx->context_driver->inuse =3D FALSE;
> +
> +			if (ctx->notify)
> +				((__ofono_gprs_deactivated_on_detach_cb_t)
> +						ctx->notify)(ctx->notify_data);
> +
> +			g_private_contexts =3D g_slist_remove(g_private_contexts,
> +								ctx);
> +		}
> +

Doing this only here might not quite be enough.  The context can also be
deactivated due to gprs_context atom destruction or network forced detach.

>  		gprs->bearer =3D -1;
>  	}
>  =

> @@ -3223,3 +3245,18 @@ int __ofono_gprs_deactivate_context(unsigned int i=
d,
>  				deactivate_request_callback, private_ctx);
>  	return 0;
>  }
> +
> +int __ofono_gprs_set_deactivated_on_detach_notify(unsigned int id,
> +				__ofono_gprs_deactivated_on_detach_cb_t cb,
> +				void *data)

I'd prefer ofono_gprs_private_context_set_detached_notify

> +{
> +	struct gprs_private_context *private_ctx;
> +
> +	private_ctx =3D gprs_private_context_by_id(id);
> +	if (private_ctx =3D=3D NULL)
> +		return -EINVAL;
> +
> +	private_ctx->notify =3D cb;
> +	private_ctx->notify_data =3D data;
> +	return 0;
> +}
> diff --git a/src/ofono.h b/src/ofono.h
> index 6b72816..a1215e8 100644
> --- a/src/ofono.h
> +++ b/src/ofono.h
> @@ -248,6 +248,8 @@ typedef void (*__ofono_gprs_activate_context_cb_t)(in=
t error,
>  =

>  typedef void (*__ofono_gprs_deactivate_context_cb_t)(int error, void *da=
ta);
>  =

> +typedef void (*__ofono_gprs_deactivated_on_detach_cb_t)(void *data);
> +
>  int __ofono_gprs_deactivate_context(unsigned int id,
>  					__ofono_gprs_deactivate_context_cb_t cb,
>  					void *data);
> @@ -257,6 +259,10 @@ int __ofono_gprs_activate_context(struct ofono_gprs =
*gprs,
>  				__ofono_gprs_activate_context_cb_t cb,
>  				void *data);
>  =

> +int __ofono_gprs_set_deactivated_on_detach_notify(unsigned int id,
> +				__ofono_gprs_deactivated_on_detach_cb_t cb,
> +				void *data);
> +
>  #include <ofono/radio-settings.h>
>  #include <ofono/audio-settings.h>
>  #include <ofono/ctm.h>

Do we have some way of testing at least the channel open / close parts?
 Can we add this to phonesim to enable some basic sanity testing?

Regards,
-Denis

--===============1008353076837393927==--

