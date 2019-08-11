Content-Type: multipart/mixed; boundary="===============8771157722054539844=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] gprs: Ignore activated contexts during init,
 list them later
Date: Sun, 11 Aug 2019 10:10:01 -0500
Message-ID: <1ddfad22-c661-0faf-11e3-d4f107fdfc37@gmail.com>
In-Reply-To: <20190811164631.16804-1-richard.rojfors@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8771157722054539844==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Richard,

On 8/11/19 11:46 AM, richard.rojfors(a)gmail.com wrote:
> From: Richard R=C3=B6jfors <richard@puffinpack.se>
> =

> There is an issue if an context gets auto activated early,
> then provisioning might not have run yet for instance,
> so a "new" context is created, which might be duplicated
> by a provisioning context later.
> So ignore the activated contexts until gprs is ready,
> then it calls the driver to list active contexts.
> ---
>   include/gprs.h |  7 +++++++
>   src/gprs.c     | 24 ++++++++++++++++++++++++
>   2 files changed, 31 insertions(+)
> =

> diff --git a/include/gprs.h b/include/gprs.h
> index 988d6102..38e3c508 100644
> --- a/include/gprs.h
> +++ b/include/gprs.h
> @@ -36,6 +36,10 @@ typedef void (*ofono_gprs_status_cb_t)(const struct of=
ono_error *error,
>   =

>   typedef void (*ofono_gprs_cb_t)(const struct ofono_error *error, void *=
data);
>   =

> +typedef void (*ofono_gprs_active_context_cb_t)(const struct ofono_error =
*error,
> +						int cid, const char *apn,
> +						void *data);

This assumes just one is active?  That doesn't have to be the case...

> +
>   struct ofono_gprs_driver {
>   	const char *name;
>   	int (*probe)(struct ofono_gprs *gprs, unsigned int vendor,
> @@ -45,6 +49,9 @@ struct ofono_gprs_driver {
>   				ofono_gprs_cb_t cb, void *data);
>   	void (*attached_status)(struct ofono_gprs *gprs,
>   					ofono_gprs_status_cb_t cb, void *data);
> +	void (*get_active_auto_context)(struct ofono_gprs *gprs,
> +					ofono_gprs_active_context_cb_t cb,
> +					void *data);

list_active_contexts?  Also, since there can in theory be multiple ones =

of these, I'd do something like:

typedef void (*ofono_gprs_active_context_cb_t)(int cid, const char *apn,
						void *data);

void (*list_active_contexts)(struct ofono_gprs *gprs,
			ofono_gprs_active_context_cb_t active_cb,
			ofono_gprs_cb_t finished_cb);

>   };
>   =


The include/ portion should be a separate commit.

>   enum gprs_suspend_cause {
> diff --git a/src/gprs.c b/src/gprs.c
> index 9cb69d14..05b413c5 100644
> --- a/src/gprs.c
> +++ b/src/gprs.c
> @@ -1959,6 +1959,11 @@ void ofono_gprs_cid_activated(struct ofono_gprs  *=
gprs, unsigned int cid,
>   =

>   	DBG("");
>   =

> +	if (!__ofono_atom_get_registered(gprs->atom)) {
> +		DBG("cid %u activated before atom registered", cid);
> +		return;
> +	}
> +
>   	if (l_uintset_contains(gprs->used_cids, cid)) {
>   		DBG("cid %u already activated", cid);
>   		return;
> @@ -3338,11 +3343,24 @@ remove:
>   		storage_sync(imsi, SETTINGS_STORE, gprs->settings);
>   }
>   =

> +static void gprs_get_active_context_callback(const struct ofono_error *e=
rror,
> +						int cid, const char *apn,
> +						void *data)
> +{
> +	struct ofono_gprs *gprs =3D data;
> +
> +	DBG("error =3D %d", error->type);
> +
> +	if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR && apn !=3D NULL && ci=
d > 0)
> +		ofono_gprs_cid_activated(gprs, cid, apn);
> +}
> +
>   static void ofono_gprs_finish_register(struct ofono_gprs *gprs)
>   {
>   	DBusConnection *conn =3D ofono_dbus_get_connection();
>   	struct ofono_modem *modem =3D __ofono_atom_get_modem(gprs->atom);
>   	const char *path =3D __ofono_atom_get_path(gprs->atom);
> +	const struct ofono_gprs_driver *drv =3D gprs->driver;
>   =

>   	if (gprs->contexts =3D=3D NULL) /* Automatic provisioning failed */
>   		add_context(gprs, NULL, OFONO_GPRS_CONTEXT_TYPE_INTERNET);
> @@ -3366,6 +3384,12 @@ static void ofono_gprs_finish_register(struct ofon=
o_gprs *gprs)
>   					netreg_watch, gprs, NULL);
>   =

>   	__ofono_atom_register(gprs->atom, gprs_unregister);
> +
> +	/* Find any context activated during init */
> +	if (drv->get_active_auto_context)
> +		drv->get_active_auto_context(gprs,
> +					      gprs_get_active_context_callback,
> +					      gprs);
>   }
>   =

>   static void spn_read_cb(const char *spn, const char *dc, void *data)
> =


Regards,
-Denis

--===============8771157722054539844==--

