Content-Type: multipart/mixed; boundary="===============7164654141011814126=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 7/9] gprs: implement ofono_gprs_cid_activated
Date: Thu, 17 Mar 2016 12:48:21 -0500
Message-ID: <56EAEDE5.1010200@gmail.com>
In-Reply-To: <1458234140-7936-8-git-send-email-dragos@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7164654141011814126==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 03/17/2016 12:02 PM, Dragos Tatulea wrote:
> It works by looking for a context with the same APN and tries to use
> that. Otherwise it will create it's own.
>
> Then it assigns a gprs context driver and calls it's read_settings if
> it exists.
> ---
>   src/gprs.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++
>   1 file changed, 69 insertions(+)
>
> diff --git a/src/gprs.c b/src/gprs.c
> index e5e7abc..74e9104 100644
> --- a/src/gprs.c
> +++ b/src/gprs.c
> @@ -293,6 +293,11 @@ static void gprs_cid_release(struct ofono_gprs *gprs=
, unsigned int id)
>   	idmap_put(gprs->cid_map, id);
>   }
>
> +static gboolean gprs_cid_taken(struct ofono_gprs *gprs, unsigned int id)
> +{
> +	return idmap_find(gprs->cid_map, id) !=3D 0;
> +}
> +
>   static gboolean assign_context(struct pri_context *ctx, int use_cid)
>   {
>   	struct idmap *cidmap =3D ctx->gprs->cid_map;
> @@ -1842,6 +1847,25 @@ static void write_context_settings(struct ofono_gp=
rs *gprs,
>   	}
>   }
>
> +static struct pri_context *find_context_by_apn(struct ofono_gprs *gprs,
> +					const char *apn)
> +{
> +	GSList *l;
> +
> +	for (l =3D gprs->contexts; l; l =3D l->next) {
> +		struct pri_context *pri_ctx =3D l->data;
> +
> +		/* Looking only at prefix for the LTE case when a user APN is
> +		 * web.provider.com but it apepars as
> +		 * web.provider.com.mncX.mccY.gprs .
> +		 */
> +		if (g_str_has_prefix(apn, pri_ctx->context.apn))
> +			return pri_ctx;
> +	}
> +
> +	return NULL;
> +}
> +
>   static struct pri_context *add_context(struct ofono_gprs *gprs,
>   					const char *name,
>   					enum ofono_gprs_context_type type)
> @@ -1885,6 +1909,51 @@ static struct pri_context *add_context(struct ofon=
o_gprs *gprs,
>   	return context;
>   }
>
> +void ofono_gprs_cid_activated(struct ofono_gprs  *gprs, unsigned int cid,
> +				const char *apn)
> +{
> +	struct pri_context *pri_ctx;
> +	struct ofono_gprs_context *gc;
> +
> +	DBG("");
> +
> +	if (gprs_cid_taken(gprs, cid)) {
> +		DBG("cid %u already activated", cid);
> +		return;
> +	}
> +
> +	pri_ctx =3D find_context_by_apn(gprs, apn);

Also, check the special case of settings provisioning failed.  It is =

signified by an a list with exactly 1 context.  The APN of that context =

will be NULL.  This is done in a couple of places by doing the following:

if (gprs->contexts =3D=3D NULL) /* Automatic provisioning failed */
	add_context(gprs, NULL, OFONO_GPRS_CONTEXT_TYPE_INTERNET);

So lets high-jack that special context in this case.

> +
> +	if (!pri_ctx) {
> +		pri_ctx =3D add_context(gprs, "auto",
shouldn't 'auto' be the APN?
> +					OFONO_GPRS_CONTEXT_TYPE_INTERNET);
> +		if (!pri_ctx) {
> +			ofono_error("Can't find/create automatic context %d "
> +					"with APN %s.", cid, apn);
> +			return;
> +		}
> +	} else {
> +		DBusConnection *conn =3D ofono_dbus_get_connection();
> +		pri_set_apn(pri_ctx, conn, NULL, apn);
> +	}
> +
> +	if (assign_context(pri_ctx, cid) =3D=3D FALSE) {
> +		ofono_warn("Can't assign context to driver for APN.");
> +		release_context(pri_ctx);
> +		return;
> +	}
> +
> +	gc =3D pri_ctx->context_driver;
> +
> +	if (gc->driver->read_settings)
> +		gc->driver->read_settings(gc, &pri_ctx->context,
> +					     pri_activate_callback, pri_ctx);
> +	else
> +		ofono_warn("Context activated for driver that doesn't support "
> +				"automatic context activation.");

Lets check this part right away and not assign contexts or do anything =

if the read_settings method is not implemented

> +

And another spurious whitespace :)
> +}
> +
>   static void send_context_added_signal(struct ofono_gprs *gprs,
>   					struct pri_context *context,
>   					DBusConnection *conn)
>

Regards,
-Denis

--===============7164654141011814126==--

