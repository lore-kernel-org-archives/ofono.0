Content-Type: multipart/mixed; boundary="===============9013620685437038269=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 3/8] gprs-provision: add driver API sources
Date: Tue, 18 Jan 2011 15:55:12 +0100
Message-ID: <1295362512.3873.196.camel@aeonflux>
In-Reply-To: <1295338172-12773-4-git-send-email-jukka.saunamaki@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9013620685437038269==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jukka,

I am just making some minor style comments right now.

<snip>

> +struct gprs_provision_request {
> +	GSList *drivers; /* Provisioning drivers to be called */
> +	struct ofono_modem *modem;
> +	ofono_gprs_provision_cb_t cb;
> +	void *user_data;
> +};
> +
> +static void settings_cb(GSList *settings, void *user_data);
> +
> +static struct ofono_gprs_provision_context *gprs_provision_context_creat=
e(
> +			struct ofono_modem *modem,
> +			struct ofono_gprs_provision_driver *driver)
> +{
> +	struct ofono_gprs_provision_context *context;
> +
> +	if (driver->probe =3D=3D NULL)
> +		return NULL;
> +
> +	context =3D g_try_new0(struct ofono_gprs_provision_context, 1);
> +

No empty line here please. Checking for a memory allocation result
should be done right away.

We might have some leftover cases from the earlier days. So bonus points
if you find them and fix them ;)

> +	if (context =3D=3D NULL)
> +		return NULL;
> +
> +	context->driver =3D driver;
> +	context->modem =3D modem;
> +
> +	if (driver->probe(context) < 0) {
> +		g_free(context);
> +		return NULL;
> +	}
> +
> +	return context;
> +}
> +
> +static void clean_active_requests(gpointer data, gpointer user_data)
> +{
> +	struct gprs_provision_request *req =3D data;
> +	struct ofono_gprs_provision_context *context =3D user_data;
> +
> +	req->drivers =3D g_slist_remove(req->drivers, context);
> +}
> +
> +static void context_remove(struct ofono_atom *atom)
> +{
> +	struct ofono_gprs_provision_context *context =3D
> +		__ofono_atom_get_data(atom);
> +
> +	g_slist_foreach(provision_requests, clean_active_requests, context);
> +
> +	if (context->driver->remove)
> +		context->driver->remove(context);
> +
> +	g_free(context);
> +}
> +
> +void __ofono_gprs_provision_probe_drivers(struct ofono_modem *modem)
> +{
> +	struct ofono_gprs_provision_driver *driver;
> +	struct ofono_gprs_provision_context *context;
> +	GSList *l;
> +
> +	for (l =3D g_drivers; l; l =3D l->next) {
> +		driver =3D l->data;
> +
> +		context =3D gprs_provision_context_create(modem, driver);
> +		if (context =3D=3D NULL)
> +			continue;
> +
> +		__ofono_modem_add_atom(modem, OFONO_ATOM_TYPE_GPRS_PROVISION,
> +						context_remove, context);
> +	}
> +}
> +
> +void ofono_gprs_provision_data_free(struct ofono_gprs_provision_data *da=
ta)
> +{
> +	if (data =3D=3D NULL)
> +		return;
> +
> +	free(data->name);
> +	free(data->apn);
> +	free(data->username);
> +	free(data->password);
> +	free(data->message_proxy);
> +	free(data->message_center);

Use g_free for all of them please.

> +	g_free(data);
> +}

As mentioned in the other reply. This sounds more like an internal API
detail to me.

> + * Calls next driver that has callable get_settings()
> + * Returns TRUE if a driver was called.
> + */
> +static gboolean call_driver_get_settings(struct gprs_provision_request *=
req,
> +						ofono_gprs_provision_cb_t cb)
> +{
> +	struct ofono_gprs_provision_context *context;
> +
> +	if (req->drivers =3D=3D NULL)
> +		return FALSE;

What is this check for? Wouldn't a =


	while (req->drivers !=3D NULL) {

	}

	return FALSE;

just work fine as well.

> +
> +	do {
> +		context =3D req->drivers->data;
> +		req->drivers =3D g_slist_delete_link(req->drivers, req->drivers);
> +
> +		if (context->driver->get_settings !=3D NULL) {
> +			DBG("Calling provisioning plugin '%s'",
> +				context->driver->name);
> +
> +			provision_requests =3D g_slist_append(provision_requests,
> +								req);
> +			context->driver->get_settings(context, cb, req);
> +			return TRUE;
> +		}
> +
> +	} while (req->drivers !=3D NULL);
> +
> +	return FALSE;
> +}
> +
> +static void settings_cb(GSList *settings, void *user_data)
> +{
> +	struct gprs_provision_request *req =3D user_data;
> +
> +	provision_requests =3D g_slist_remove(provision_requests, req);
> +	if (settings =3D=3D NULL) {
> +		DBG("Provisioning plugin returned no settings");

This sounds more like an ofono_warn message. Especially if you can also
print out the settings driver name.

> +		/* No success from this driver, try next */
> +		if (call_driver_get_settings(req, settings_cb) =3D=3D TRUE)
> +			return;
> +	} else
> +		DBG("Provisioning plugin returned settings for %d contexts",
> +			g_slist_length(settings));
> +
> +	req->cb(settings, req->user_data);
> +	g_slist_free(req->drivers);
> +	g_free(req);
> +}
> +
> +static void prepend_provision_driver(struct ofono_atom *atom, void *data)
> +{
> +	struct ofono_gprs_provision_context *context =3D
> +		__ofono_atom_get_data(atom);
> +	GSList **drivers =3D data;
> +
> +	*drivers =3D g_slist_prepend(*drivers, context);
> +}
> +
> +void __ofono_gprs_provision_get_settings(struct ofono_modem *modem,
> +						ofono_gprs_provision_cb_t cb,
> +						void *user_data)
> +{
> +	struct gprs_provision_request *req;
> +
> +	req =3D g_try_new0(struct gprs_provision_request, 1);
> +	if (req =3D=3D NULL)
> +		goto error;
> +
> +	req->modem =3D modem;
> +	req->cb =3D cb;
> +	req->user_data =3D user_data;
> +
> +	__ofono_modem_foreach_atom(modem, OFONO_ATOM_TYPE_GPRS_PROVISION,
> +					prepend_provision_driver,
> +					&req->drivers);
> +
> +	if (call_driver_get_settings(req, settings_cb) =3D=3D TRUE)
> +		return;
> +
> +	DBG("No callable GPRS provision drivers");
> +
> +	g_slist_free(req->drivers);
> +
> +error:
> +	g_free(req);
> +	cb(NULL, user_data);
> +}
> +
> +static gint compare_priority(gconstpointer a, gconstpointer b)
> +{
> +	const struct ofono_gprs_provision_driver *plugin1 =3D a;
> +	const struct ofono_gprs_provision_driver *plugin2 =3D b;
> +
> +	return plugin2->priority - plugin1->priority;
> +}
> +
> +int ofono_gprs_provision_driver_register(
> +			const struct ofono_gprs_provision_driver *driver)
> +{
> +	DBG("driver: %p name: %s", driver, driver->name);
> +
> +	g_drivers =3D g_slist_insert_sorted(g_drivers, (void *) driver,
> +						compare_priority);
> +	return 0;
> +}
> +
> +void ofono_gprs_provision_driver_unregister(
> +			const struct ofono_gprs_provision_driver *driver)
> +{
> +	DBG("driver: %p name: %s", driver, driver->name);
> +
> +	g_drivers =3D g_slist_remove(g_drivers, driver);
> +}

Regards

Marcel



--===============9013620685437038269==--

