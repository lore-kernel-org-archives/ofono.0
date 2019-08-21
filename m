Content-Type: multipart/mixed; boundary="===============1143260101006061293=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: Re: [PATCH v2 3/3] Revert "gprs: _cid_activated is an 'attaching'
 state"
Date: Wed, 21 Aug 2019 08:01:12 +0200
Message-ID: <4a96c48e-91aa-0948-0dbc-d0fe8a7d3310@norrbonn.se>
In-Reply-To: <20190820155652.8598-3-richard.rojfors@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1143260101006061293==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Richard,

On 20/08/2019 17:56, richard.rojfors(a)gmail.com wrote:
> From: Richard R=C3=B6jfors <richard@puffinpack.se>
> =

> This reverts commit 1fd419e5b4b3a87673f8e0219edb0f3ed9fca774.

This patch is fine and certainly necessary in the context of this =

series.  Posting it as a 'revert', however, is a bit unsavoury.

A reverted patch implies that it was somehow wrong or inappropriate. =

That's not the case here.  This code has become superfluous in the face =

of other changes that have been made in the tree.

Just squash these two revert patches into one "forward looking" patch. =

The fact that the change effectively constitutes a 'revert' is moot.

/Jonas

> =

> Since gprs_attached_update now guarantees that we
> will not get attached without having a context activated
> in LTE, this is not needed anymore. It also potentially
> interferes in case the driver was actually attaching.
> ---
>   src/gprs.c | 18 +-----------------
>   1 file changed, 1 insertion(+), 17 deletions(-)
> =

> diff --git a/src/gprs.c b/src/gprs.c
> index bd9b3680..de172979 100644
> --- a/src/gprs.c
> +++ b/src/gprs.c
> @@ -913,7 +913,6 @@ static void pri_read_settings_callback(const struct o=
fono_error *error,
>   {
>   	struct pri_context *pri_ctx =3D data;
>   	struct ofono_gprs_context *gc =3D pri_ctx->context_driver;
> -	struct ofono_gprs *gprs =3D pri_ctx->gprs;
>   	DBusConnection *conn =3D ofono_dbus_get_connection();
>   	dbus_bool_t value;
>   =

> @@ -938,18 +937,11 @@ static void pri_read_settings_callback(const struct=
 ofono_error *error,
>   =

>   	value =3D pri_ctx->active;
>   =

> -	gprs->flags &=3D ~GPRS_FLAG_ATTACHING;
> -
> -	gprs_set_attached_property(gprs, TRUE);
> +	gprs_set_attached_property(pri_ctx->gprs, TRUE);
>   =

>   	ofono_dbus_signal_property_changed(conn, pri_ctx->path,
>   					OFONO_CONNECTION_CONTEXT_INTERFACE,
>   					"Active", DBUS_TYPE_BOOLEAN, &value);
> -
> -	if (gprs->flags & GPRS_FLAG_RECHECK) {
> -		gprs->flags &=3D ~GPRS_FLAG_RECHECK;
> -		gprs_netreg_update(gprs);
> -	}
>   }
>   =

>   static DBusMessage *pri_set_apn(struct pri_context *ctx, DBusConnection=
 *conn,
> @@ -2038,14 +2030,6 @@ void ofono_gprs_cid_activated(struct ofono_gprs  *=
gprs, unsigned int cid,
>   					DBUS_TYPE_STRING, &apn);
>   	}
>   =

> -	/* Prevent ofono_gprs_status_notify from changing the 'attached'
> -	 * state until after the context has been set to 'active' in
> -	 * the pri_read_settings_callback; this prevents a race where
> -	 * the connection manager sees the modem as attached before there
> -	 * is an active context.
> -	 */
> -	gprs->flags |=3D GPRS_FLAG_ATTACHING;
> -
>   	gc->driver->read_settings(gc, cid, pri_read_settings_callback, pri_ctx=
);
>   }
>   =

>=20

--===============1143260101006061293==--

