Content-Type: multipart/mixed; boundary="===============7999065147604972066=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/9] lte: add implementation for LTE atom
Date: Fri, 11 Nov 2016 10:46:02 -0600
Message-ID: <5825F5CA.7050506@gmail.com>
In-Reply-To: <1478796956-22500-4-git-send-email-dragos@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7999065147604972066==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Dragos,

On 11/10/2016 10:55 AM, Dragos Tatulea wrote:
> This implementation can only get/set the default APN setting. But
> anything expected for this atom is there:
> * D-Bus interface
> * sync-ing settings to/from file
> * interaction with driver
> ---
>   src/lte.c | 369 +++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++
>   1 file changed, 369 insertions(+)
>   create mode 100644 src/lte.c
>
> diff --git a/src/lte.c b/src/lte.c
> new file mode 100644
> index 0000000..ba22dc2
> --- /dev/null
> +++ b/src/lte.c
> @@ -0,0 +1,369 @@
> +/*
> + *
> + *  oFono - Open Source Telephony
> + *
> + *  Copyright (C) 2016  Endocode AG. All rights reserved.
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2 as
> + *  published by the Free Software Foundation.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-130=
1  USA
> + *
> + */
> +
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
> +#include <string.h>
> +#include <errno.h>
> +
> +#include <glib.h>
> +#include <gdbus.h>
> +
> +#include "ofono.h"
> +
> +#include "common.h"


> +#include "log.h"
> +#include "gprs-context.h"

The above two are already included as part of ofono.h.  No need for it here.

> +#include "storage.h"
> +
> +#include "lte.h"

This should be put into ofono.h.  Rule of thumb is that all "public =

plugin" includes (e.g. in include/ofono/*) should be in ofono.h.

The only includes you should be utilizing are the various utility =

headers in src/

> +
> +#define SETTINGS_STORE "lte"
> +#define SETTINGS_GROUP "Settings"
> +#define DEFAULT_APN_KEY "DefaultAccessPointName"
> +
> +struct ofono_lte {
> +	const struct ofono_lte_driver *driver;
> +	void *driver_data;
> +	struct ofono_atom *atom;
> +	char *imsi;
> +	GKeyFile *settings;
> +	DBusMessage *pending;
> +	char old_apn[OFONO_GPRS_MAX_APN_LENGTH+1];

doc/coding-style.txt item M3.  Generally we do it one of two ways:

1. by using pending_foo variable.
2. By re-parsing the pending message

I'd just use approach #2

> +	struct ofono_lte_default_attach_info info;
> +};
> +
> +static GSList *g_drivers =3D NULL;
> +
> +static void lte_load_settings(struct ofono_lte *lte)
> +{
> +	char *apn;
> +
> +	if (lte->imsi =3D=3D NULL)
> +		return;
> +
> +	lte->settings =3D storage_open(lte->imsi, SETTINGS_STORE);
> +
> +	if (lte->settings =3D=3D NULL) {
> +		ofono_error("LTE: Can't open settings file, "
> +				"changes won't be persistent");
> +		return;
> +	}
> +
> +	apn =3D g_key_file_get_string(lte->settings, SETTINGS_GROUP ,
> +					DEFAULT_APN_KEY, NULL);
> +	if (apn)
> +		strcpy(lte->info.apn, apn);
> +}
> +
> +static DBusMessage *lte_get_properties(DBusConnection *conn,
> +					DBusMessage *msg, void *data)
> +{
> +	struct ofono_lte *lte =3D data;
> +	const char *apn =3D lte->info.apn;
> +	DBusMessage *reply;
> +	DBusMessageIter iter;
> +	DBusMessageIter dict;
> +
> +	reply =3D dbus_message_new_method_return(msg);
> +	if (reply =3D=3D NULL)
> +		return NULL;
> +
> +	dbus_message_iter_init_append(reply, &iter);
> +
> +	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
> +					OFONO_PROPERTIES_ARRAY_SIGNATURE,
> +					&dict);
> +	ofono_dbus_dict_append(&dict, DEFAULT_APN_KEY, DBUS_TYPE_STRING, &apn);
> +	dbus_message_iter_close_container(&iter, &dict);
> +
> +	return reply;
> +}
> +
> +static void lte_set_default_attach_info_cb(const struct ofono_error *err=
or,
> +						void *data)
> +{
> +	struct ofono_lte *lte =3D data;
> +	const char *path =3D __ofono_atom_get_path(lte->atom);
> +	DBusConnection *conn =3D ofono_dbus_get_connection();
> +	DBusMessage *reply;
> +	const char *apn =3D lte->info.apn;
> +
> +	DBG("%s error %d", path, error->type);
> +
> +	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
> +		g_strlcpy(lte->info.apn, lte->old_apn,
> +				OFONO_GPRS_MAX_APN_LENGTH+1);
> +
> +		__ofono_dbus_pending_reply(&lte->pending,
> +				__ofono_error_failed(lte->pending));
> +		return;
> +	}
> +
> +	if (lte->pending =3D=3D NULL)
> +		/* This can happen on first register: it's not a reply to
> +		 * anything.
> +		 */
> +		return;

For the initial set case, lets just have a whole new callback.

So the easy way to get the new APN we just set is to parse the arguments =

from pending one more time.  Since it was already sanity checked prior, =

you can keep it real simple here.

> +
> +	if (lte->settings) {
> +		if (strlen(lte->info.apn) =3D=3D 0)
> +			/* Clear entry on empty APN. */
> +			g_key_file_remove_key(lte->settings, SETTINGS_GROUP,
> +						DEFAULT_APN_KEY, NULL);
> +		else
> +			g_key_file_set_string(lte->settings, SETTINGS_GROUP,
> +						DEFAULT_APN_KEY, lte->info.apn);
> +
> +		storage_sync(lte->imsi, SETTINGS_STORE, lte->settings);
> +	}
> +
> +	reply =3D dbus_message_new_method_return(lte->pending);
> +	__ofono_dbus_pending_reply(&lte->pending, reply);
> +	lte->pending =3D NULL;
> +
> +	ofono_dbus_signal_property_changed(conn, path,
> +					OFONO_CONNECTION_CONTEXT_INTERFACE,
> +					DEFAULT_APN_KEY,
> +					DBUS_TYPE_STRING, &apn);
> +}
> +
> +static DBusMessage *lte_set_default_apn(struct ofono_lte *lte,
> +				DBusConnection *conn, DBusMessage *msg,
> +				const char *apn)
> +{
> +	if (strlen(apn) > OFONO_GPRS_MAX_APN_LENGTH)
> +		return __ofono_error_invalid_format(msg);
> +
> +	if (g_str_equal(apn, lte->info.apn))
> +		return dbus_message_new_method_return(msg);
> +
> +	/* We do care about empty value: it can be used for reset. */
> +	if (is_valid_apn(apn) =3D=3D FALSE && apn[0] !=3D '\0')
> +		return __ofono_error_invalid_format(msg);
> +
> +	if (lte->pending) {
> +		/* Can happen on fast succession of calls. */
> +		dbus_message_unref(lte->pending);
> +		lte->pending =3D NULL;

??  Generally we simply return a busy error.

> +	}
> +
> +	lte->pending =3D dbus_message_ref(msg);
> +
> +	g_strlcpy(lte->old_apn, lte->info.apn, OFONO_GPRS_MAX_APN_LENGTH+1);
> +	g_strlcpy(lte->info.apn, apn, OFONO_GPRS_MAX_APN_LENGTH+1);

doc/coding-style.txt item M3.

Also, lets not do it this way.  Since GetProperties() in between calling =

SetProperty() and it returning might potentially give erroneous results.

> +
> +	lte->driver->set_default_attach_info(lte, &lte->info,
> +				lte_set_default_attach_info_cb, lte);
> +
> +	return NULL;
> +}
> +
> +static DBusMessage *lte_set_property(DBusConnection *conn,
> +					DBusMessage *msg, void *data)
> +{
> +	struct ofono_lte *lte =3D data;
> +	DBusMessageIter iter;
> +	DBusMessageIter var;
> +	const char *property;
> +	const char *str;
> +
> +	if (!dbus_message_iter_init(msg, &iter))
> +		return __ofono_error_invalid_args(msg);
> +
> +	if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_STRING)
> +		return __ofono_error_invalid_args(msg);
> +
> +	dbus_message_iter_get_basic(&iter, &property);
> +	dbus_message_iter_next(&iter);
> +
> +	if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_VARIANT)
> +		return __ofono_error_invalid_args(msg);
> +
> +	dbus_message_iter_recurse(&iter, &var);
> +
> +

Double empty line

> +	if (!strcmp(property, DEFAULT_APN_KEY)) {
> +		if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_STRING)
> +			return __ofono_error_invalid_args(msg);
> +
> +		dbus_message_iter_get_basic(&var, &str);
> +
> +		return lte_set_default_apn(lte, conn, msg, str);
> +	}
> +
> +	return __ofono_error_invalid_args(msg);
> +}
> +
> +static const GDBusMethodTable lte_methods[] =3D {
> +	{ GDBUS_METHOD("GetProperties",
> +			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
> +			lte_get_properties) },
> +	{ GDBUS_ASYNC_METHOD("SetProperty",
> +			GDBUS_ARGS({ "property", "s" }, { "value", "v" }),
> +			NULL, lte_set_property) },
> +	{ }
> +};
> +
> +static const GDBusSignalTable lte_signals[] =3D {
> +	{ GDBUS_SIGNAL("PropertyChanged",
> +			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
> +	{ }
> +};
> +
> +static void lte_atom_remove(struct ofono_atom *atom)
> +{
> +	struct ofono_lte *lte =3D __ofono_atom_get_data(atom);
> +
> +	DBG("atom: %p", atom);
> +
> +	if (lte =3D=3D NULL)
> +		return;
> +
> +	if (lte->settings) {
> +		storage_close(lte->imsi, SETTINGS_STORE, lte->settings, TRUE);
> +
> +		g_free(lte->imsi);
> +		lte->imsi =3D NULL;
> +		lte->settings =3D NULL;
> +	}
> +
> +	if (lte->driver && lte->driver->remove)
> +		lte->driver->remove(lte);
> +
> +	g_free(lte);
> +}
> +
> +

double empty line :)

> +struct ofono_lte *ofono_lte_create(struct ofono_modem *modem,
> +					const char *driver, void *data)
> +{
> +	struct ofono_lte *lte;
> +	GSList *l;
> +
> +	if (driver =3D=3D NULL)
> +		return NULL;
> +
> +	lte =3D g_try_new0(struct ofono_lte, 1);
> +
> +	if (lte =3D=3D NULL)
> +		return NULL;
> +
> +	lte->atom =3D __ofono_modem_add_atom(modem, OFONO_ATOM_TYPE_LTE,
> +						lte_atom_remove, lte);
> +
> +	for (l =3D g_drivers; l; l =3D l->next) {
> +		const struct ofono_lte_driver *drv =3D l->data;
> +
> +		if (g_strcmp0(drv->name, driver))
> +			continue;
> +
> +		if (drv->probe(lte, data) < 0)
> +			continue;
> +
> +		lte->driver =3D drv;
> +		break;
> +	}
> +
> +	DBG("LTE atom created");
> +
> +	return lte;
> +}
> +
> +int ofono_lte_driver_register(const struct ofono_lte_driver *d)
> +{
> +	DBG("driver: %p, name: %s", d, d->name);
> +
> +	if (d->probe =3D=3D NULL)
> +		return -EINVAL;
> +
> +	g_drivers =3D g_slist_prepend(g_drivers, (void *) d);
> +
> +	return 0;
> +}
> +
> +void ofono_lte_driver_unregister(const struct ofono_lte_driver *d)
> +{
> +	DBG("driver: %p, name: %s", d, d->name);
> +
> +	g_drivers =3D g_slist_remove(g_drivers, (void *) d);
> +}
> +
> +static void lte_atom_unregister(struct ofono_atom *atom)
> +{
> +	DBusConnection *conn =3D ofono_dbus_get_connection();
> +	struct ofono_modem *modem =3D __ofono_atom_get_modem(atom);
> +	const char *path =3D __ofono_atom_get_path(atom);
> +
> +	ofono_modem_remove_interface(modem, OFONO_LTE_INTERFACE);
> +	g_dbus_unregister_interface(conn, path, OFONO_LTE_INTERFACE);
> +}
> +
> +void ofono_lte_register(struct ofono_lte *lte)
> +{
> +	DBusConnection *conn =3D ofono_dbus_get_connection();
> +	struct ofono_modem *modem =3D __ofono_atom_get_modem(lte->atom);
> +	const char *path =3D __ofono_atom_get_path(lte->atom);
> +	struct ofono_sim *sim =3D __ofono_atom_find(OFONO_ATOM_TYPE_SIM, modem);
> +	const char *imsi =3D ofono_sim_get_imsi(sim);
> +
> +	if (imsi =3D=3D NULL) {
> +		ofono_error("No sim atom required for registering LTE atom.");	=

> +		return;
> +	}
> +
> +	lte->imsi =3D g_strdup(imsi);
> +
> +	lte_load_settings(lte);
> +
> +	if (!g_dbus_register_interface(conn, path,
> +				OFONO_LTE_INTERFACE,
> +				lte_methods, lte_signals, NULL,
> +				lte, NULL)) {
> +		ofono_error("Could not create %s interface",
> +				OFONO_LTE_INTERFACE);
> +		return;
> +	}
> +
> +	ofono_modem_add_interface(modem, OFONO_LTE_INTERFACE);
> +
> +	__ofono_atom_register(lte->atom, lte_atom_unregister);
> +
> +	lte->driver->set_default_attach_info(lte, &lte->info,
> +					lte_set_default_attach_info_cb, lte);

Generally we should register the interface after we have loaded the =

settings and bootstrapped them into the driver.  This will be especially =

true if we have to run provisioning first.  So i would perform the =

registration steps in a specific callback.  e.g. something like:

if (lte->driver->set_default_attach_info) {
	lte->driver->set_default_attach_info(lte, &lte->info, =

init_default_attach_info_cb, lte);
	return;
}

/* otherwise, register the interface, probably by calling a common helper */
ofono_lte_finish_register(...);

> +}
> +
> +void ofono_lte_remove(struct ofono_lte *lte)
> +{
> +	__ofono_atom_free(lte->atom);
> +}
> +
> +void ofono_lte_set_data(struct ofono_lte *lte, void *data)
> +{
> +	lte->driver_data =3D data;
> +}
> +
> +void *ofono_lte_get_data(const struct ofono_lte *lte)
> +{
> +	return lte->driver_data;
> +}
>

Regards,
-Denis

--===============7999065147604972066==--

