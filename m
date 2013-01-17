Content-Type: multipart/mixed; boundary="===============8540026383033067102=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v0 1/8] hfp_hf: Add NewConnection arguments parsing
Date: Thu, 17 Jan 2013 11:10:32 -0600
Message-ID: <50F83088.2080502@gmail.com>
In-Reply-To: <1358435591-14757-2-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8540026383033067102==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Claudio,

On 01/17/2013 09:13 AM, Claudio Takahasi wrote:
> This patch adds NewConnection message arguments parsing: features,
> version and Media Endpoints included in the fd_properties dictionary.
> ---
>   Makefile.am             |   3 +-
>   plugins/bluez5.c        |  81 +++++++++++++++++++++++++++
>   plugins/bluez5.h        |   3 +
>   plugins/hfp_hf_bluez5.c | 144 +++++++++++++++++++++++++++++++++++++++++=
++++++-
>   plugins/media.c         |  63 +++++++++++++++++++++
>   plugins/media.h         |  29 ++++++++++

Please separate this into three patches, one for bluez5.[ch] changes, =

one for media.[ch] changes and one for the hfp_hf_bluez5.c changes. =

Also, is there a compelling reason to not roll media.[ch] into =

bluez5.[ch]?  It is being put into plugins directory and it is not =

really a plugin.  We made a couple exceptions (e.g. for mbpi.c) but I do =

not really want to make this into a habit.

>   6 files changed, 319 insertions(+), 4 deletions(-)
>   create mode 100644 plugins/media.c
>   create mode 100644 plugins/media.h
>
> diff --git a/Makefile.am b/Makefile.am
> index f24cac7..f1d241f 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -438,7 +438,8 @@ builtin_modules +=3D bluez5
>   builtin_sources +=3D plugins/bluez5.c plugins/bluez5.h
>
>   builtin_modules +=3D hfp_bluez5
> -builtin_sources +=3D plugins/hfp_hf_bluez5.c plugins/bluez5.h
> +builtin_sources +=3D plugins/bluez5.h plugins/media.h \
> +			plugins/media.c plugins/hfp_hf_bluez5.c
>   endif
>   endif
>   endif
> diff --git a/plugins/bluez5.c b/plugins/bluez5.c
> index 84ba47d..6ba5ea1 100644
> --- a/plugins/bluez5.c
> +++ b/plugins/bluez5.c
> @@ -36,6 +36,87 @@
>
>   #define BLUEZ_PROFILE_MGMT_INTERFACE   BLUEZ_SERVICE ".ProfileManager1"
>
> +typedef void (*PropertyHandler)(DBusMessageIter *iter, gpointer user_dat=
a);

In general we prefer not to use CamelCase outside of GLib-like code.

> +
> +struct property_handler {
> +	const char *property;
> +	PropertyHandler callback;
> +	gpointer user_data;
> +};
> +
> +static gint property_handler_compare(gconstpointer a, gconstpointer b)
> +{
> +	const struct property_handler *handler =3D a;
> +	const char *property =3D b;
> +
> +	return g_strcmp0(handler->property, property);
> +}
> +
> +void bluetooth_iter_parse_properties(DBusMessageIter *array,
> +						const char *property, ...)
> +{
> +	va_list args;
> +	GSList *prop_handlers =3D NULL;
> +	DBusMessageIter dict;
> +
> +	if (dbus_message_iter_get_arg_type(array) !=3D DBUS_TYPE_ARRAY)
> +		goto done;
> +
> +	va_start(args, property);
> +
> +	while (property !=3D NULL) {
> +		struct property_handler *handler =3D
> +					g_new0(struct property_handler, 1);
> +
> +		handler->property =3D property;
> +		handler->callback =3D va_arg(args, PropertyHandler);
> +		handler->user_data =3D va_arg(args, gpointer);
> +
> +		property =3D va_arg(args, const char *);
> +
> +		prop_handlers =3D g_slist_prepend(prop_handlers, handler);
> +	}
> +
> +	va_end(args);
> +
> +	dbus_message_iter_recurse(array,&dict);
> +
> +	while (dbus_message_iter_get_arg_type(&dict) =3D=3D DBUS_TYPE_DICT_ENTR=
Y) {
> +		DBusMessageIter entry, value;
> +		const char *key;
> +		GSList *l;
> +
> +		dbus_message_iter_recurse(&dict,&entry);
> +
> +		if (dbus_message_iter_get_arg_type(&entry) !=3D DBUS_TYPE_STRING)
> +			goto done;
> +
> +		dbus_message_iter_get_basic(&entry,&key);
> +
> +		dbus_message_iter_next(&entry);
> +
> +		if (dbus_message_iter_get_arg_type(&entry) !=3D DBUS_TYPE_VARIANT)
> +			goto done;
> +
> +		dbus_message_iter_recurse(&entry,&value);
> +
> +		l =3D g_slist_find_custom(prop_handlers, key,
> +					property_handler_compare);
> +
> +		if (l) {
> +			struct property_handler *handler =3D l->data;
> +
> +			handler->callback(&value, handler->user_data);
> +		}
> +
> +		dbus_message_iter_next(&dict);
> +	}
> +
> +done:
> +	g_slist_foreach(prop_handlers, (GFunc) g_free, NULL);
> +	g_slist_free(prop_handlers);
> +}
> +

Is this a copy-paste job out of bluez4.c?

>   static void profile_register_cb(DBusPendingCall *call, gpointer user_da=
ta)
>   {
>   	DBusMessage *reply;
> diff --git a/plugins/bluez5.h b/plugins/bluez5.h
> index 01ecfe8..7eae8c4 100644
> --- a/plugins/bluez5.h
> +++ b/plugins/bluez5.h
> @@ -29,3 +29,6 @@ int bluetooth_register_profile(DBusConnection *conn, co=
nst char *uuid,
>   					const char *name, const char *object);
>
>   void bluetooth_unregister_profile(DBusConnection *conn, const char *obj=
ect);
> +
> +void bluetooth_iter_parse_properties(DBusMessageIter *array,
> +						const char *property, ...);
> diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
> index e024838..636b1b3 100644
> --- a/plugins/hfp_hf_bluez5.c
> +++ b/plugins/hfp_hf_bluez5.c
> @@ -35,6 +35,7 @@
>   #include<ofono/log.h>
>
>   #include "bluez5.h"
> +#include "media.h"
>
>   #ifndef DBUS_TYPE_UNIX_FD
>   #define DBUS_TYPE_UNIX_FD -1
> @@ -42,6 +43,106 @@
>
>   #define HFP_EXT_PROFILE_PATH   "/bluetooth/profile/hfp_hf"
>
> +static void parse_guint16(DBusMessageIter *iter, gpointer user_data)
> +{
> +	guint16 *value =3D user_data;
> +
> +	if (dbus_message_iter_get_arg_type(iter) !=3D  DBUS_TYPE_UINT16)
> +		return;
> +
> +	dbus_message_iter_get_basic(iter, value);
> +}
> +
> +static void parse_string(DBusMessageIter *iter, gpointer user_data)
> +{
> +	char **str =3D user_data;
> +	int arg_type =3D dbus_message_iter_get_arg_type(iter);
> +
> +	if (arg_type !=3D DBUS_TYPE_OBJECT_PATH&&  arg_type !=3D DBUS_TYPE_STRI=
NG)
> +		return;
> +
> +	dbus_message_iter_get_basic(iter, str);
> +}
> +
> +static void parse_byte(DBusMessageIter *iter, gpointer user_data)
> +{
> +	guint8 *value =3D user_data;
> +
> +	if (dbus_message_iter_get_arg_type(iter) !=3D  DBUS_TYPE_BYTE)
> +		return;
> +
> +	dbus_message_iter_get_basic(iter, value);
> +}
> +
> +static void parse_byte_array(DBusMessageIter *iter, gpointer user_data)
> +{
> +	DBusMessageIter array;
> +	GArray **garray =3D user_data;
> +	guint8 *data =3D NULL;
> +	int n =3D 0;
> +
> +	if (dbus_message_iter_get_arg_type(iter) !=3D  DBUS_TYPE_ARRAY)
> +		return;
> +
> +	dbus_message_iter_recurse(iter,&array);
> +	dbus_message_iter_get_fixed_array(&array,&data,&n);
> +	if (n =3D=3D 0)
> +		return;
> +
> +	*garray =3D g_array_sized_new(TRUE, TRUE, sizeof(guint8), n);
> +	*garray =3D g_array_append_vals(*garray, (gconstpointer) data, n);

Please just use g_memdup instead and stay away from GArray.  oFono does =

not use GArray anywhere else and I do not really want to start.  The =

long-term plan is to get rid of GLib.  So whenever you can use basic types.

> +}
> +
> +static void parse_media_endpoints(DBusMessageIter *array, gpointer user_=
data)
> +{
> +	const char *path, *owner;
> +	GSList **endpoints =3D user_data;
> +	GArray *capabilities =3D NULL;
> +	struct media_endpoint *endpoint;
> +	guint8 codec;
> +	DBusMessageIter dict, variant, entry;
> +
> +	if (dbus_message_iter_get_arg_type(array) !=3D DBUS_TYPE_ARRAY)
> +		return;
> +
> +	dbus_message_iter_recurse(array,&dict);
> +
> +	while (dbus_message_iter_get_arg_type(&dict) =3D=3D DBUS_TYPE_DICT_ENTR=
Y) {
> +		path =3D NULL;
> +		codec =3D 0x00;
> +		capabilities =3D NULL;
> +
> +		dbus_message_iter_recurse(&dict,&entry);
> +		if (dbus_message_iter_get_arg_type(&entry) !=3D DBUS_TYPE_STRING)
> +			return;
> +
> +		dbus_message_iter_get_basic(&entry,&owner);
> +
> +		dbus_message_iter_next(&entry);
> +
> +		if (dbus_message_iter_get_arg_type(&entry) !=3D DBUS_TYPE_VARIANT)
> +			return;
> +
> +		dbus_message_iter_recurse(&entry,&variant);
> +
> +		bluetooth_iter_parse_properties(&variant,
> +				"Path", parse_string,&path,
> +				"Codec", parse_byte,&codec,
> +				"Capabilities", parse_byte_array,&capabilities,
> +				NULL);

Sounds like you should be passing in the endpoint structure here instead

> +
> +		dbus_message_iter_next(&dict);
> +
> +		endpoint =3D media_endpoint_new(owner, path, codec, capabilities);
> +		if (capabilities)
> +			g_array_unref(capabilities);
> +
> +		*endpoints =3D g_slist_append(*endpoints, endpoint);
> +
> +		DBG("Media Endpoint %s %s codec: 0x%02X", owner, path, codec);
> +	}
> +}
> +
>   static int hfp_probe(struct ofono_modem *modem)
>   {
>   	DBG("modem: %p", modem);
> @@ -93,11 +194,48 @@ static struct ofono_modem_driver hfp_driver =3D {
>   static DBusMessage *profile_new_connection(DBusConnection *conn,
>   					DBusMessage *msg, void *user_data)
>   {
> +	DBusMessageIter entry;
> +	const char *device;
> +	GSList *endpoints =3D NULL;
> +	guint16 version, features;
> +	int fd;
> +
>   	DBG("Profile handler NewConnection");
>
> -	return g_dbus_create_error(msg, BLUEZ_ERROR_INTERFACE
> -					".NotImplemented",
> -					"Implementation not provided");
> +	if (dbus_message_iter_init(msg,&entry) =3D=3D FALSE)
> +		goto error;
> +
> +	if (dbus_message_iter_get_arg_type(&entry) !=3D DBUS_TYPE_OBJECT_PATH)
> +		goto error;
> +
> +	dbus_message_iter_get_basic(&entry,&device);
> +	dbus_message_iter_next(&entry);
> +	if (dbus_message_iter_get_arg_type(&entry) !=3D DBUS_TYPE_UNIX_FD)
> +		goto error;
> +
> +	dbus_message_iter_get_basic(&entry,&fd);
> +	if (fd<  0)
> +		goto error;
> +
> +	dbus_message_iter_next(&entry);
> +
> +	bluetooth_iter_parse_properties(&entry,
> +			"Version", parse_guint16,&version,
> +			"Features", parse_guint16,&features,
> +			"MediaEndpoints", parse_media_endpoints,&endpoints,
> +			NULL);
> +
> +	DBG("%s version: 0x%04x features: 0x%04x", device, version, features);
> +
> +	if (endpoints =3D=3D NULL) {
> +		ofono_error("Media Endpoint missing");
> +		goto error;
> +	}
> +	return NULL;
> +
> +error:
> +	return g_dbus_create_error(msg, BLUEZ_ERROR_INTERFACE ".Rejected",
> +					"Invalid arguments in method call");
>   }
>
>   static DBusMessage *profile_release(DBusConnection *conn,
> diff --git a/plugins/media.c b/plugins/media.c
> new file mode 100644
> index 0000000..b4f0650
> --- /dev/null
> +++ b/plugins/media.c
> @@ -0,0 +1,63 @@
> +/*
> + *
> + *  oFono - Open Source Telephony
> + *
> + *  Copyright (C) 2013  Intel Corporation. All rights reserved.
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
> +#include<config.h>
> +#endif
> +
> +#include<glib.h>
> +
> +#include "media.h"
> +
> +struct media_endpoint {
> +	char *owner;
> +	char *path;
> +	guint8 codec;
> +	GArray *capabilities;
> +};
> +
> +struct media_endpoint *media_endpoint_new(const char *owner,
> +					const char *path,
> +					guint8 codec,
> +					GArray *capabilities)
> +{
> +	struct media_endpoint *endpoint;
> +
> +	endpoint =3D g_new0(struct media_endpoint, 1);
> +	endpoint->owner =3D g_strdup(owner);
> +	endpoint->path =3D g_strdup(path);
> +	endpoint->codec =3D codec;
> +	if (capabilities)
> +		endpoint->capabilities =3D g_array_ref(capabilities);
> +
> +	return endpoint;
> +}
> +
> +void media_endpoint_free(gpointer data)
> +{
> +	struct media_endpoint *endpoint =3D data;
> +
> +	g_free(endpoint->owner);
> +	g_free(endpoint->path);
> +	if (endpoint->capabilities)
> +		g_array_unref(endpoint->capabilities);
> +	g_free(endpoint);
> +}
> diff --git a/plugins/media.h b/plugins/media.h
> new file mode 100644
> index 0000000..0df107f
> --- /dev/null
> +++ b/plugins/media.h
> @@ -0,0 +1,29 @@
> +/*
> + *
> + *  oFono - Open Source Telephony
> + *
> + *  Copyright (C) 2013  Intel Corporation. All rights reserved.
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
> +struct media_endpoint;
> +
> +struct media_endpoint *media_endpoint_new(const char *owner,
> +					const char *path,
> +					guint8 codec,
> +					GArray *capabilities);
> +
> +void media_endpoint_free(gpointer data);

Regards,
-Denis


--===============8540026383033067102==--

