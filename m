Content-Type: multipart/mixed; boundary="===============0280190795324916593=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 8/8] Fix gprs_netreg_update behaviour if PPP connection
 active
Date: Sun, 17 Feb 2019 22:00:28 -0600
Message-ID: <d8ef35d1-2ffa-29f9-35a2-ad01e1fc3938@gmail.com>
In-Reply-To: <20190215121142.28163-9-philippedeswert@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0280190795324916593==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tommi,

On 02/15/2019 06:11 AM, philippedeswert(a)gmail.com wrote:
> From: Tommi Rekosuo <tommi.rekosuo@treon.fi>
> =

> If a PPP connection is active, the modem can't detach before
> the PPP connection has been disabled. This can happen if

I don't believe this is true for every modem.  What exactly is your =

modem doing here?  A log might be a good start.

> RoamingAllowed is changed when connection is active.

Note that on LTE, oFono shouldn't really issue a detach when =

RoamingAllowed is toggled.  Roaming on LTE cannot work in the same way =

as on 3G.

27.007 still sort of mandates that a +CGATT on LTE should trigger a =

detach from PS, and that would obviously trigger a full disconnect and =

reconnect.  So oFono core should be fixed not to do that if you want to =

support roaming on LTE properly.

This was discussed earlier here (and maybe in a few other threads)

https://lists.ofono.org/pipermail/ofono/2018-September/018514.html
https://lists.ofono.org/pipermail/ofono/2018-September/018535.html

> This leaves connman in undefined state as the context
> 'Active' state is not propagated properly and connman
> still thinks we are connected. > ---
>   src/gprs.c | 24 ++++++++++++++++++++++--
>   1 file changed, 22 insertions(+), 2 deletions(-)
> =

> diff --git a/src/gprs.c b/src/gprs.c
> index f1146d06..9df273b1 100644
> --- a/src/gprs.c
> +++ b/src/gprs.c
> @@ -1547,18 +1547,26 @@ static void release_active_contexts(struct ofono_=
gprs *gprs)
>   {
>   	GSList *l;
>   	struct pri_context *ctx;
> +	DBusConnection *conn;
> +	dbus_bool_t value;
>   =

>   	for (l =3D gprs->contexts; l; l =3D l->next) {
>   		struct ofono_gprs_context *gc;
>   =

>   		ctx =3D l->data;
>   =

> -		if (ctx->active =3D=3D FALSE)
> +		DBG("Context id: %d", ctx->context.cid);
> +
> +		if (ctx->active =3D=3D FALSE) {
> +			DBG("Context not active");
>   			continue;
> +		}

This seems to be debug code and is extraneous.  If you really want this =

for some reason, then use a separate commit

>   =

>   		/* This context is already being messed with */
> -		if (ctx->pending)
> +		if (ctx->pending) {
> +			DBG("Context in pending state");
>   			continue;
> +		}

as above

>   =

>   		gc =3D ctx->context_driver;
>   =

> @@ -1567,6 +1575,11 @@ static void release_active_contexts(struct ofono_g=
prs *gprs)
>   =

>   		/* Make sure the context is properly cleared */
>   		release_context(ctx);
> +		value =3D ctx->active;
> +		conn =3D ofono_dbus_get_connection();
> +		ofono_dbus_signal_property_changed(conn, ctx->path,
> +					OFONO_CONNECTION_CONTEXT_INTERFACE,
> +					"Active", DBUS_TYPE_BOOLEAN, &value);

release_active_contexts isn't really meant to send any signals.  It is =

meant to clean up and syncronize state between gprs and gprs_context =

drivers.

I suspect you need to give a bit more information about what is actually =

going on.  As mentioned earlier, RoamingAllowed on LTE is a bit of a mess.

>   	}
>   }
>   =

> @@ -1688,6 +1701,13 @@ static void gprs_netreg_update(struct ofono_gprs *=
gprs)
>   		return;
>   	}
>   =

> +	/* If PPP session if active it needs to be disconnected
> +	 * before the driver can send at commands */
> +	if (!attach) {
> +		DBG("Release active contexts");
> +		release_active_contexts(gprs);
> +	}
> +
>   	gprs->flags |=3D GPRS_FLAG_ATTACHING;
>   =

>   	gprs->driver_attached =3D attach;
> =


Regards,
-Denis

--===============0280190795324916593==--

