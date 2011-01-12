Content-Type: multipart/mixed; boundary="===============5119648273601475932=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC PATCH 1/4] Added GPRS context provisioning driver API sources
Date: Tue, 11 Jan 2011 22:43:58 -0800
Message-ID: <1294814638.3873.69.camel@aeonflux>
In-Reply-To: <1294665072-13630-2-git-send-email-jukka.saunamaki@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5119648273601475932==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jukka,

> +#ifndef __OFONO_GPRS_PROVISION_H
> +#define __OFONO_GPRS_PROVISION_H
> +
> +#ifdef __cplusplus
> +extern "C" {
> +#endif
> +
> +#include "gprs-context.h"
> +
> +struct ofono_gprs_provisioning_data {
> +	enum ofono_gprs_context_type type;
> +	enum ofono_gprs_proto proto;
> +	gchar *name;
> +	gchar *apn;
> +	gchar *username;
> +	gchar *password;
> +	gchar *message_proxy;
> +	gchar *message_center;
> +};

don't bother with gchar *. Just use char * here. The gchar is
essentially bad idea. We only use it a few rare occasions or when it got
missed in a review.

> +
> +/*
> + * Callback from provisioning plugin.
> + * settings: list of struct ofono_gprs_provisioning_data
> + *
> + * It is responsibility of callback function to free settings-list
> + * settings-list elements must be freed with ofono_gprs_provisioning_dat=
a_free()
> + */
> +typedef void (*ofono_gprs_provision_cb_t)(GSList *settings, void *userda=
ta);
> +
> +struct ofono_gprs_provision_driver {
> +	const char *name;
> +	int priority;
> +	void (*get_settings) (struct ofono_modem *modem,
> +				ofono_gprs_provision_cb_t cb,
> +				void *userdata);
> +};

So here is something we need to talk about. The nettime plugin
infrastructure using a "pseudo" atom. So do we wanna do the same here or
do we wanna change the nettime atom to something simple like this.

I like to have consistency here. Aki, Denis, thoughts?

> +struct gprs_provisioning_request {
> +	GSList *current_driver;
> +	struct ofono_modem *modem;
> +	ofono_gprs_provision_cb_t cb;
> +	void *userdata;

The sort of general style is to call this user_data.

> +};
> +
> +static GSList *gprs_provision_drivers =3D NULL;
> +
> +

We also normally don't do double empty lines.

> +void ofono_gprs_provisioning_data_free(struct ofono_gprs_provisioning_da=
ta *data)
> +{
> +	if (data =3D=3D NULL)
> +		return;
> +
> +	g_free(data->name);
> +	g_free(data->apn);
> +	g_free(data->username);
> +	g_free(data->password);
> +	g_free(data->message_proxy);
> +	g_free(data->message_center);
> +	g_free(data);
> +}
> +
> +
> +static void settings_cb(GSList *settings, void *userdata)
> +{

Same here, please use user_data.

> +	GSList *d;
> +	struct gprs_provisioning_request *req =3D userdata;

And as another general rule, the variable that have an assignment like
the user_data come first.

> +
> +	if (settings !=3D NULL)
> +		DBG("Provisioning plugin returned settings for %d contexts",
> +			g_slist_length(settings));
> +	else
> +		DBG("Provisioning plugin returned no settings");
> +
> +	d =3D req->current_driver->next;
> +	if (settings =3D=3D NULL && d !=3D NULL) {
> +		/* No success from this driver, try next */
> +		const struct ofono_gprs_provision_driver *driver =3D d->data;
> +		req->current_driver =3D d;
> +		DBG("Calling provisioning plugin '%s'", driver->name);
> +		driver->get_settings(req->modem, settings_cb, req);
> +		return;
> +	}
> +
> +	req->cb(settings, req->userdata);
> +	g_free(req);
> +}
> +
> +

Same here for the double empty lines. Please fix them all.

> +void ofono_gprs_provision_get_settings(struct ofono_modem *modem,
> +					ofono_gprs_provision_cb_t cb,
> +					void *userdata)
> +{
> +	struct gprs_provisioning_request *req;
> +	const struct ofono_gprs_provision_driver *driver;
> +
> +	if (gprs_provision_drivers =3D=3D 0)

This needs to be a =3D=3D NULL.

> +		goto error;
> +
> +	req =3D g_try_new0(struct gprs_provisioning_request, 1);
> +	if (req =3D=3D NULL)
> +		goto error;
> +
> +	req->modem =3D modem;
> +	req->cb =3D cb;
> +	req->userdata =3D userdata;
> +	req->current_driver =3D gprs_provision_drivers;
> +
> +	driver =3D gprs_provision_drivers->data;
> +	DBG("Calling provisioning plugin '%s'", driver->name);

Normally we put empty lines on top and below the DBG statement. Just to
make the stand out a bit.

Also in this case we might can remove some of the debug statements once
the code has been tested.

> +	driver->get_settings(modem, settings_cb, req);
> +	return;
> +
> +error:
> +	cb(NULL, userdata);
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
> +int ofono_gprs_provision_driver_register(const struct ofono_gprs_provisi=
on_driver *driver)
> +{
> +	DBG("driver: %p name: %s", driver, driver->name);
> +
> +	gprs_provision_drivers =3D g_slist_insert_sorted(gprs_provision_drivers,
> +							(void *) driver,
> +							compare_priority);
> +	return 0;
> +}
> +
> +void ofono_gprs_provision_driver_unregister(const struct ofono_gprs_prov=
ision_driver *driver)
> +{
> +	DBG("driver: %p name: %s", driver, driver->name);
> +
> +	gprs_provision_drivers =3D g_slist_remove(gprs_provision_drivers, drive=
r);
> +}

Regards

Marcel



--===============5119648273601475932==--

