Content-Type: multipart/mixed; boundary="===============0596036179132817278=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 04/12] src: add gnss atom and agent implementation
Date: Thu, 17 Mar 2011 23:39:50 -0500
Message-ID: <4D82E216.2030501@gmail.com>
In-Reply-To: <1299846189-15132-5-git-send-email-jarko.poutiainen@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0596036179132817278==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jarko,

On 03/11/2011 06:23 AM, Jarko Poutiainen wrote:
> ---
>  Makefile.am     |    3 +-
>  src/gnss.c      |  357 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  src/gnssagent.c |  152 +++++++++++++++++++++++
>  src/gnssagent.h |   40 ++++++
>  4 files changed, 551 insertions(+), 1 deletions(-)
>  create mode 100644 src/gnss.c
>  create mode 100644 src/gnssagent.c
>  create mode 100644 src/gnssagent.h
> =

> diff --git a/Makefile.am b/Makefile.am
> index 7d6acce..24742bb 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -383,7 +383,8 @@ src_ofonod_SOURCES =3D $(gdbus_sources) $(builtin_sou=
rces) src/ofono.ver \
>  			src/smsagent.c src/smsagent.h src/ctm.c \
>  			src/cdma-voicecall.c src/sim-auth.c \
>  			src/message.h src/message.c src/gprs-provision.c \
> -			src/emulator.c src/location-reporting.c
> +			src/emulator.c src/location-reporting.c \
> +			src/gnss.c src/gnssagent.c src/gnssagent.h
>  =

>  src_ofonod_LDADD =3D $(builtin_libadd) @GLIB_LIBS@ @DBUS_LIBS@ @CAPNG_LI=
BS@ -ldl
>  =

> diff --git a/src/gnss.c b/src/gnss.c
> new file mode 100644
> index 0000000..02f9057
> --- /dev/null
> +++ b/src/gnss.c
> @@ -0,0 +1,357 @@
> +/*
> + *
> + *  oFono - Open Source Telephony
> + *
> + *  Copyright (C) 2008-2010  Intel Corporation. All rights reserved.
> + *  Copyright (C) 2011 ST-Ericsson AB.
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
> +#define _GNU_SOURCE
> +#include <string.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <stdint.h>
> +
> +#include <glib.h>
> +#include <gdbus.h>
> +#include <errno.h>
> +
> +#include "ofono.h"
> +
> +#include "common.h"
> +#include "gnssagent.h"
> +
> +static GSList *g_drivers =3D NULL;
> +
> +struct ofono_gnss {
> +	const struct ofono_gnss_driver *driver;
> +	void *driver_data;
> +	struct ofono_atom *atom;
> +	DBusMessage *pending;
> +	struct gnss_agent *default_agent;

Why is this called default_agent? posr_agent might be a better name

> +};
> +
> +static void gnss_register_agent_cb(const struct ofono_error *error,
> +					void *data)
> +{
> +	DBusMessage *reply;
> +	struct ofono_gnss *gnss =3D data;
> +
> +	DBG("");
> +
> +	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
> +		ofono_error("Enabling Location Reporting Failed");
> +		reply =3D __ofono_error_failed(gnss->pending);
> +		gnss_agent_free(gnss->default_agent);
> +		__ofono_dbus_pending_reply(&gnss->pending, reply);
> +		return;
> +	}
> +
> +	reply =3D dbus_message_new_method_return(gnss->pending);
> +	__ofono_dbus_pending_reply(&gnss->pending, reply);
> +}
> +
> +static void default_agent_notify(gpointer user_data)

Why is this called default_agent_notify?  Can you have multiple agents?
If not, then agent_notify is sufficient.

> +{
> +	struct ofono_gnss *gnss =3D user_data;
> +
> +	gnss->default_agent =3D NULL;

Since you're enabling CPOSR when an agent is registered, you have to
also guard against the case of the application exiting.  Note that the
agent can even exit while your CPOSR enable is in progress.  Have a peek
at location-reporting.c for ideas on how Lucas solved this.

> +}
> +
> +static DBusMessage *gnss_register_agent(DBusConnection *conn,
> +					DBusMessage *msg, void *data)
> +{
> +	struct ofono_gnss *gnss =3D data;
> +	const char *agent_path;
> +
> +	if (gnss->pending)
> +		return __ofono_error_busy(msg);
> +
> +	if (gnss->default_agent)
> +		return __ofono_error_busy(msg);
> +
> +	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH,
> +				  &agent_path, DBUS_TYPE_INVALID) =3D=3D FALSE)

Please don't mix spaces and tabs for indentation, always use tabs

> +		return __ofono_error_invalid_args(msg);
> +
> +	if (!__ofono_dbus_valid_object_path(agent_path))
> +		return __ofono_error_invalid_format(msg);
> +
> +	gnss->driver->position_reporting(gnss, 1, gnss_register_agent_cb, gnss);

Please use TRUE instead of 1 here

> +
> +	gnss->default_agent =3D gnss_agent_new(agent_path,
> +					dbus_message_get_sender(msg),
> +					FALSE);
> +
> +	if (gnss->default_agent =3D=3D NULL)
> +		return __ofono_error_failed(msg);
> +
> +	gnss_agent_set_removed_notify(gnss->default_agent,
> +					default_agent_notify, gnss);
> +
> +	gnss->pending =3D dbus_message_ref(msg);
> +
> +	return NULL;
> +}
> +
> +static void gnss_unregister_agent_cb(const struct ofono_error *error,
> +					void *data)
> +{
> +	DBusMessage *reply;
> +	struct ofono_gnss *gnss =3D data;
> +
> +	DBG("");
> +
> +	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
> +		ofono_error("Disabling Location Reporting Failed");
> +		reply =3D __ofono_error_failed(gnss->pending);
> +		goto out;
> +	}
> +
> +	gnss_agent_free(gnss->default_agent);
> +
> +	if (gnss->default_agent) {
> +		ofono_error("Releasing agent failed");
> +		reply =3D __ofono_error_failed(gnss->pending);
> +		goto out;
> +	}
> +
> +	reply =3D dbus_message_new_method_return(gnss->pending);
> +
> +out:
> +	__ofono_dbus_pending_reply(&gnss->pending, reply);
> +}
> +
> +static DBusMessage *gnss_unregister_agent(DBusConnection *conn,
> +						DBusMessage *msg, void *data)
> +{
> +	struct ofono_gnss *gnss =3D data;
> +	const char *agent_path;
> +	const char *agent_bus =3D dbus_message_get_sender(msg);
> +
> +	if (gnss->pending)
> +		return __ofono_error_busy(msg);
> +
> +	if (dbus_message_get_args(msg, NULL,
> +					DBUS_TYPE_OBJECT_PATH, &agent_path,
> +					DBUS_TYPE_INVALID) =3D=3D FALSE)
> +		return __ofono_error_invalid_args(msg);
> +
> +	if (gnss->default_agent =3D=3D NULL)
> +		return __ofono_error_failed(msg);
> +
> +	if (!gnss_agent_matches(gnss->default_agent, agent_path, agent_bus))
> +		return __ofono_error_failed(msg);
> +
> +	gnss->pending =3D dbus_message_ref(msg);
> +
> +	gnss->driver->position_reporting(gnss, 0, gnss_unregister_agent_cb,

Please use FALSE here

> +						gnss);
> +
> +	return NULL;
> +}
> +
> +static void gnss_send_element_cb(const struct ofono_error *error,
> +				void *data)
> +{
> +	DBusMessage *reply;
> +	struct ofono_gnss *gnss =3D data;
> +
> +	DBG("");
> +
> +	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
> +		ofono_error("Sending Positioning Element failed");
> +
> +		reply =3D __ofono_error_failed(gnss->pending);
> +
> +		goto out;
> +	}
> +
> +	reply =3D dbus_message_new_method_return(gnss->pending);
> +
> +out:
> +	__ofono_dbus_pending_reply(&gnss->pending, reply);
> +}
> +
> +static DBusMessage *gnss_send_element(DBusConnection *conn,
> +					DBusMessage *msg, void *data)
> +{
> +	struct ofono_gnss *gnss =3D data;
> +	const char *xml;
> +
> +	DBG("");
> +
> +	if (gnss->pending)
> +		return __ofono_error_busy(msg);
> +
> +	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &xml,
> +					DBUS_TYPE_INVALID))
> +		return __ofono_error_invalid_args(msg);
> +
> +	gnss->pending =3D dbus_message_ref(msg);
> +

Please make sure that only the application which has registered the
agent can use this method and return AccessDenied otherwise.

> +	gnss->driver->send_element(gnss, xml, gnss_send_element_cb, gnss);
> +
> +	return NULL;
> +}
> +
> +static GDBusMethodTable gnss_methods[] =3D {
> +	{ "SendPositioningElement",		"s",	"",
> +				gnss_send_element, G_DBUS_METHOD_FLAG_ASYNC },
> +	{ "RegisterPositioningRequestAgent",	"o",	"",
> +				gnss_register_agent,
> +				G_DBUS_METHOD_FLAG_ASYNC },
> +	{ "UnregisterPositioningRequestAgent",	"o",	"",
> +				gnss_unregister_agent,
> +				G_DBUS_METHOD_FLAG_ASYNC },
> +	{ }
> +};
> +
> +static void gnss_unregister(struct ofono_atom *atom)
> +{
> +	struct ofono_gnss *gnss =3D __ofono_atom_get_data(atom);
> +	DBusConnection *conn =3D ofono_dbus_get_connection();
> +	struct ofono_modem *modem =3D __ofono_atom_get_modem(atom);
> +	const char *path =3D __ofono_atom_get_path(atom);
> +
> +	if (gnss->default_agent)
> +		gnss_agent_free(gnss->default_agent);
> +
> +	ofono_modem_remove_interface(modem, OFONO_AS_NAVIGATION_INTERFACE);
> +	g_dbus_unregister_interface(conn, path, OFONO_AS_NAVIGATION_INTERFACE);
> +}
> +
> +static void gnss_remove(struct ofono_atom *atom)
> +{
> +	struct ofono_gnss *gnss =3D __ofono_atom_get_data(atom);
> +
> +	DBG("atom: %p", atom);
> +
> +	if (gnss =3D=3D NULL)
> +		return;
> +
> +	if (gnss->driver && gnss->driver->remove)
> +		gnss->driver->remove(gnss);
> +
> +	g_free(gnss);
> +}
> +
> +void ofono_gnss_register(struct ofono_gnss *gnss)
> +{
> +	DBusConnection *conn =3D ofono_dbus_get_connection();
> +	struct ofono_modem *modem =3D __ofono_atom_get_modem(gnss->atom);
> +	const char *path =3D __ofono_atom_get_path(gnss->atom);
> +
> +	if (!g_dbus_register_interface(conn, path,
> +					OFONO_AS_NAVIGATION_INTERFACE,
> +					gnss_methods, NULL, NULL,
> +					gnss, NULL)) {
> +		ofono_error("Could not create %s interface",
> +				OFONO_AS_NAVIGATION_INTERFACE);
> +
> +		return;
> +	}
> +
> +	ofono_modem_add_interface(modem, OFONO_AS_NAVIGATION_INTERFACE);
> +
> +	__ofono_atom_register(gnss->atom, gnss_unregister);
> +}
> +
> +int ofono_gnss_driver_register(const struct ofono_gnss_driver *d)
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
> +void ofono_gnss_driver_unregister(const struct ofono_gnss_driver *d)
> +{
> +	DBG("driver: %p, name: %s", d, d->name);
> +
> +	g_drivers =3D g_slist_remove(g_drivers, (void *) d);
> +}
> +
> +struct ofono_gnss *ofono_gnss_create(struct ofono_modem *modem,
> +					unsigned int vendor,
> +					const char *driver,
> +					void *data)
> +{
> +	struct ofono_gnss *gnss;
> +	GSList *l;
> +
> +	if (driver =3D=3D NULL)
> +		return NULL;
> +
> +	gnss =3D g_try_new0(struct ofono_gnss, 1);
> +
> +	if (gnss =3D=3D NULL)
> +		return NULL;
> +
> +	gnss->atom =3D __ofono_modem_add_atom(modem, OFONO_ATOM_TYPE_GNSS,
> +						gnss_remove, gnss);
> +
> +	for (l =3D g_drivers; l; l =3D l->next) {
> +		const struct ofono_gnss_driver *drv =3D l->data;
> +
> +		if (g_strcmp0(drv->name, driver))
> +			continue;
> +
> +		if (drv->probe(gnss, vendor, data) < 0)
> +			continue;
> +
> +		gnss->driver =3D drv;
> +		break;
> +	}
> +
> +	return gnss;
> +}
> +
> +void ofono_gnss_receive_request(struct ofono_gnss *gnss, const char *xml)
> +{
> +	if (gnss->default_agent)
> +		gnss_agent_receive_request(gnss->default_agent, xml);
> +}
> +
> +void ofono_gnss_receive_reset(struct ofono_gnss *gnss)
> +{
> +	if (gnss->default_agent)
> +		gnss_agent_receive_reset(gnss->default_agent);
> +}
> +
> +void ofono_gnss_remove(struct ofono_gnss *gnss)
> +{
> +	__ofono_atom_free(gnss->atom);
> +}
> +
> +void ofono_gnss_set_data(struct ofono_gnss *gnss, void *data)
> +{
> +	gnss->driver_data =3D data;
> +}
> +
> +void *ofono_gnss_get_data(struct ofono_gnss *gnss)
> +{
> +	return gnss->driver_data;
> +}

<snip>

Regards,
-Denis

--===============0596036179132817278==--

