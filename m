Content-Type: multipart/mixed; boundary="===============1085073931399047515=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Dalleau <frederic.dalleau@linux.intel.com>
Subject: Re: [PATCH 3/4] connman: add plugin in oFono to request
 request/release private network
Date: Fri, 22 Apr 2011 13:02:08 +0200
Message-ID: <4DB16030.8050601@linux.intel.com>
In-Reply-To: <1303466563-3111-4-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1085073931399047515==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

2 remarques =C3=A0 vue de nez

On 04/22/2011 12:02 PM, Guillaume Zajac wrote:
> ---
>   plugins/connman.c |  239 ++++++++++++++++++++++++++++++++++++++++++++++=
+++++++
>   1 files changed, 239 insertions(+), 0 deletions(-)
>   create mode 100644 plugins/connman.c
>
> diff --git a/plugins/connman.c b/plugins/connman.c
> new file mode 100644
> index 0000000..eec0940
> --- /dev/null
> +++ b/plugins/connman.c
> @@ -0,0 +1,239 @@
> +/*
> + *
> + *  oFono - Open Source Telephony
> + *
> + *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
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
> +#include<errno.h>
> +#include<stdlib.h>
> +
> +#include<gdbus.h>
> +#include<string.h>
> +
> +#include<ofono.h>
> +#include<emulator.h>
> +
> +#define CONNMAN_SERVICE			"net.connman"
> +#define CONNMAN_PATH			"/net/connman"
> +
> +#define CONNMAN_DEBUG_INTERFACE		CONNMAN_SERVICE ".Debug"
> +#define CONNMAN_ERROR_INTERFACE		CONNMAN_SERVICE ".Error"
> +#define CONNMAN_AGENT_INTERFACE		CONNMAN_SERVICE ".Agent"
> +#define CONNMAN_COUNTER_INTERFACE	CONNMAN_SERVICE ".Counter"
> +
> +#define CONNMAN_MANAGER_INTERFACE	CONNMAN_SERVICE ".Manager"
> +#define CONNMAN_MANAGER_PATH		"/"
> +
> +#define CONNMAN_TASK_INTERFACE		CONNMAN_SERVICE ".Task"
> +#define CONNMAN_PROFILE_INTERFACE	CONNMAN_SERVICE ".Profile"
> +#define CONNMAN_SERVICE_INTERFACE	CONNMAN_SERVICE ".Service"
> +#define CONNMAN_PROVIDER_INTERFACE	CONNMAN_SERVICE ".Provider"
> +#define CONNMAN_TECHNOLOGY_INTERFACE	CONNMAN_SERVICE ".Technology"
> +#define CONNMAN_SESSION_INTERFACE	CONNMAN_SERVICE ".Session"
> +#define CONNMAN_NOTIFICATION_INTERFACE	CONNMAN_SERVICE ".Notification"
> +
> +static DBusConnection *connection;
> +static guint modemwatch_id;
> +static GList *modems;
> +
> +static void request_pn(struct ofono_error *error, int *out_fd,
> +					const char **out_server_ip,
> +					const char **out_peer_ip,
> +					const char **out_primary_dns,
> +					const char **out_secondary_dns)
> +{
> +	DBusMessageIter array, dict, entry;
> +	DBusMessage *message, *reply;
> +	DBusError dbus_error;
> +
> +	DBG("");
> +
> +	error->type =3D OFONO_ERROR_TYPE_NO_ERROR;
> +
> +	message =3D dbus_message_new_method_call(CONNMAN_SERVICE,
> +				     CONNMAN_MANAGER_PATH,
> +				     CONNMAN_MANAGER_INTERFACE,
> +				     "RequestPrivateNetwork");
> +
> +	if (message =3D=3D NULL)
> +		goto error;
> +
> +	dbus_error_init(&dbus_error);
> +
> +	reply =3D dbus_connection_send_with_reply_and_block(connection, message,
> +								-1,&dbus_error);
> +
> +	dbus_message_unref(message);
> +
> +	if (!reply) {
> +		if (dbus_error_is_set(&dbus_error)) {
> +			g_print("1. %s\n", dbus_error.message);
> +			dbus_error_free(&dbus_error);
> +		} else {
> +			g_print("Request() failed");
> +		}
> +
> +		goto error;
> +	}
> +
> +	if (dbus_message_iter_init(reply,&array) =3D=3D FALSE)
> +		goto error;
> +
> +	if (dbus_message_iter_get_arg_type(&array) !=3D DBUS_TYPE_UNIX_FD)
> +		goto error;
> +
> +	dbus_message_iter_get_basic(&array, out_fd);
> +	g_print("Fildescriptor =3D %d\n", *out_fd);
> +
> +	dbus_message_iter_next(&array);
> +
> +	if (dbus_message_iter_get_arg_type(&array) !=3D DBUS_TYPE_ARRAY)
> +		goto error;
> +
> +	dbus_message_iter_recurse(&array,&dict);
> +
> +	while (dbus_message_iter_get_arg_type(&dict) =3D=3D DBUS_TYPE_DICT_ENTR=
Y) {
> +		DBusMessageIter iter;
> +		const char *key;
> +		int type;
> +
> +		dbus_message_iter_recurse(&dict,&entry);
> +
> +		dbus_message_iter_get_basic(&entry,&key);
> +
> +		g_print("key %s", key);
> +
> +		dbus_message_iter_next(&entry);
> +		dbus_message_iter_recurse(&entry,&iter);
> +
> +		type =3D dbus_message_iter_get_arg_type(&iter);
> +		if (type !=3D DBUS_TYPE_STRING)
> +			break;
> +
> +		if (g_str_equal(key, "ServerIPv4")
> +				&&  type =3D=3D DBUS_TYPE_STRING) {
> +			dbus_message_iter_get_basic(&iter, out_server_ip);
> +			g_print(" =3D %s\n", *out_server_ip);
> +
> +		} else if (g_str_equal(key, "PeerIPv4")
> +				&&  type =3D=3D DBUS_TYPE_STRING) {
> +			dbus_message_iter_get_basic(&iter, out_peer_ip);
> +			g_print(" =3D %s\n", *out_peer_ip);
> +
> +		} else if (g_str_equal(key, "PrimaryDNS")
> +				&&  type =3D=3D DBUS_TYPE_STRING) {
> +			dbus_message_iter_get_basic(&iter, out_primary_dns);
> +			g_print(" =3D %s\n", *out_primary_dns);
> +
> +		} else if (g_str_equal(key, "SecondaryDNS")
> +				&&  type =3D=3D DBUS_TYPE_STRING) {
> +			dbus_message_iter_get_basic(&iter, out_secondary_dns);
> +			g_print(" =3D %s\n", *out_secondary_dns);
> +		}
> +
> +		dbus_message_iter_next(&dict);
> +	}
> +
> +	return;
> +error:
> +	error->type =3D OFONO_ERROR_TYPE_FAILURE;
> +	return;
> +}
> +
> +static void release_pn(void)
> +{
> +	DBusMessage *message;
> +
> +	DBG("");
> +
> +	message =3D dbus_message_new_method_call(CONNMAN_SERVICE,
> +				     CONNMAN_MANAGER_PATH,
> +				     CONNMAN_MANAGER_INTERFACE,
> +				     "ReleasePrivateNetwork");
> +
> +	if (message =3D=3D NULL)
> +		return;
> +
> +	dbus_connection_send(connection, message, NULL);
> +
> +	dbus_message_unref(message);
> +}
> +
> +static void dun_emulator_watch(struct ofono_atom *atom,
> +				enum ofono_atom_watch_condition cond,
> +				void *data)
> +{
> +	struct ofono_modem *modem =3D data;
> +	struct ofono_emulator *em =3D __ofono_atom_get_data(atom);
> +
> +	if (cond =3D=3D OFONO_ATOM_WATCH_CONDITION_REGISTERED) {
> +		modems =3D g_list_append(modems, modem);
> +
> +		if (modems->next =3D=3D NULL)
> +			ofono_emulator_add_network_request_cb(em, request_pn);
> +			ofono_emulator_add_network_release_cb(em, release_pn);
il te manquerait pas des accolades?
> +	} else {
> +		modems =3D g_list_remove(modems, modem);
> +	}
> +}
> +
> +static void modem_watch(struct ofono_modem *modem, gboolean added, void =
*user)
> +{
> +	DBG("modem: %p, added: %d", modem, added);
> +
> +	if (added =3D=3D FALSE)
> +		return;
> +
> +	__ofono_modem_add_atom_watch(modem, OFONO_ATOM_TYPE_EMULATOR_DUN,
> +					dun_emulator_watch, modem, NULL);
> +}
> +
> +static void call_modemwatch(struct ofono_modem *modem, void *user)
> +{
> +	modem_watch(modem, TRUE, user);
> +}
> +
> +static int connman_init(void)
> +{
> +	int err;
> +	=

> +	DBG("");
> +
> +	connection =3D ofono_dbus_get_connection();
> +
> +	modemwatch_id =3D __ofono_modemwatch_add(modem_watch, NULL, NULL);
> +
> +	__ofono_modem_foreach(call_modemwatch, NULL);
> +
> +	return 0;
> +		return err;

petit souci l=C3=A0
> +
> +	return 0;
> +}
> +
> +static void connman_exit(void)
> +{
> +	__ofono_modemwatch_remove(modemwatch_id);
> +}
> +
> +OFONO_PLUGIN_DEFINE(connman, "ConnMan plugin", VERSION,
> +		OFONO_PLUGIN_PRIORITY_DEFAULT, connman_init, connman_exit)


--===============1085073931399047515==--

