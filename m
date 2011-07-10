Content-Type: multipart/mixed; boundary="===============6752372687099430112=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH_v8] connman: add plugin in oFono to request/release
 private network
Date: Sun, 10 Jul 2011 16:09:05 -0500
Message-ID: <4E1A14F1.9090505@gmail.com>
In-Reply-To: <1309786878-29671-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6752372687099430112==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

On 07/04/2011 08:41 AM, Guillaume Zajac wrote:
> Change log from v7:
> 	- Fix some style issues.
> 	- While requesting private network, we store the object path returned
> 	  by ConnMan, to use it later on.
> 	- While releasing private network we pass stored object path in
> 	  argument.
> 	- We don't check anymore in release function if call get completed, we
> 	  only check if pending call is not null. It might happens that pending
> 	  call is not null and creates a crash while testing call completion.
> 	  Now we force pending call to be set to NULL when request_reply is
> 	  invoked.
> =


Please make sure you use the right fields in git-send-email for this
information, it does not belong in the commit message.

> ---
>  Makefile.am       |    3 +
>  plugins/connman.c |  286 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 289 insertions(+), 0 deletions(-)
>  create mode 100644 plugins/connman.c
> =

> diff --git a/Makefile.am b/Makefile.am
> index ef6196b..6bbf47a 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -343,6 +343,9 @@ builtin_sources +=3D plugins/hfp_ag.c plugins/bluetoo=
th.h
>  builtin_modules +=3D dun_gw
>  builtin_sources +=3D plugins/dun_gw.c plugins/bluetooth.h
>  =

> +builtin_modules +=3D connman
> +builtin_sources +=3D plugins/connman.c
> +
>  builtin_sources +=3D $(btio_sources)
>  builtin_cflags +=3D @BLUEZ_CFLAGS@
>  builtin_libadd +=3D @BLUEZ_LIBS@
> diff --git a/plugins/connman.c b/plugins/connman.c
> new file mode 100644
> index 0000000..6af3fcb
> --- /dev/null
> +++ b/plugins/connman.c
> @@ -0,0 +1,286 @@
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
> +#include <config.h>
> +#endif
> +
> +#include <errno.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +
> +#include <gdbus.h>
> +#include <string.h>
> +
> +#define OFONO_API_SUBJECT_TO_CHANGE
> +#include <ofono/log.h>
> +#include <ofono/dbus.h>
> +#include <ofono/plugin.h>
> +#include <ofono/private-network.h>
> +
> +#define CONNMAN_SERVICE			"net.connman"
> +#define CONNMAN_PATH			"/net/connman"
> +
> +#define CONNMAN_MANAGER_INTERFACE	CONNMAN_SERVICE ".Manager"
> +#define CONNMAN_MANAGER_PATH		"/"
> +
> +static DBusConnection *connection;
> +static GHashTable *requests;
> +static unsigned int id;
> +
> +struct pns_req {
> +	int uid;
> +	DBusPendingCall *pending;
> +	ofono_private_network_cb_t cb;
> +	void *data;
> +	gboolean redundant;
> +	char *path;
> +};
> +
> +static void pns_release(int uid)
> +{
> +	DBusMessage *message =3D NULL;
> +	struct pns_req *req;
> +
> +	DBG("");
> +
> +	req =3D g_hash_table_lookup(requests, &uid);
> +	if (!req)
> +		return;
> +
> +	if (req->pending) {
> +		/*
> +		* We want to cancel the request but we have to wait
> +		* the response of ConnMan. So we mark request as
> +		* redundant until we get the response, then we remove
> +		* it from hash table.
> +		*/
> +		req->redundant =3D TRUE;
> +		return;
> +	}
> +
> +	message =3D dbus_message_new_method_call(CONNMAN_SERVICE,
> +						CONNMAN_MANAGER_PATH,
> +						CONNMAN_MANAGER_INTERFACE,
> +						"ReleasePrivateNetwork");
> +
> +	if (message =3D=3D NULL)
> +		goto error;
> +
> +	dbus_message_append_args(message, DBUS_TYPE_OBJECT_PATH, &req->path,
> +							DBUS_TYPE_INVALID);
> +	dbus_message_set_no_reply(message, TRUE);
> +	dbus_connection_send(connection, message, NULL);
> +	dbus_message_unref(message);
> +
> +error:
> +	g_hash_table_remove(requests, &req->uid);
> +}
> +
> +static void request_reply(DBusPendingCall *call, void *user_data)
> +{
> +	struct pns_req *req =3D user_data;
> +	struct ofono_private_network_settings pns;
> +	DBusMessageIter array, dict, entry;
> +	DBusMessage *reply;
> +	const char *path;
> +
> +	DBG("");
> +
> +	pns.fd =3D -1;
> +	pns.server_ip =3D NULL;
> +	pns.peer_ip =3D NULL;
> +	pns.primary_dns =3D NULL;
> +	pns.secondary_dns =3D NULL;
> +
> +	req->pending =3D NULL;
> +
> +	reply =3D dbus_pending_call_steal_reply(call);
> +	if (!reply)
> +		goto error;
> +
> +	if (dbus_message_get_type(reply) =3D=3D DBUS_MESSAGE_TYPE_ERROR)
> +		goto error;
> +
> +	if (dbus_message_iter_init(reply, &array) =3D=3D FALSE)
> +		goto error;
> +
> +	if (dbus_message_iter_get_arg_type(&array) !=3D DBUS_TYPE_OBJECT_PATH)
> +		goto error;
> +
> +	dbus_message_iter_get_basic(&array, &path);
> +	req->path =3D g_strdup(path);
> +	DBG("Object path =3D %s\n", req->path);
> +
> +	dbus_message_iter_next(&array);
> +	if (dbus_message_iter_get_arg_type(&array) !=3D DBUS_TYPE_ARRAY)
> +		goto error;
> +
> +	if (req->redundant =3D=3D TRUE)
> +		goto release;
> +

So this part is not quite right.  If the request is redundant, then we
can't call the callback for any reason since the client does not expect
it anymore.  Here you're creating a case where a crash is potentially
possible.  I suggest you check for redundant requests right away.

Also, please get into the habit of making sure you're not performing
redundant operations whenever possible.  The above g_strdup is really
unnecessary if the request has been canceled.

> +	dbus_message_iter_recurse(&array, &dict);
> +
> +	while (dbus_message_iter_get_arg_type(&dict) =3D=3D DBUS_TYPE_DICT_ENTR=
Y) {
> +		DBusMessageIter iter;
> +		const char *key;
> +		int type;
> +
> +		dbus_message_iter_recurse(&dict, &entry);
> +
> +		dbus_message_iter_get_basic(&entry, &key);
> +
> +		dbus_message_iter_next(&entry);
> +		dbus_message_iter_recurse(&entry, &iter);
> +
> +		type =3D dbus_message_iter_get_arg_type(&iter);
> +		if (type !=3D DBUS_TYPE_STRING)
> +			break;
> +
> +		if (g_str_equal(key, "ServerIPv4")
> +				&& type =3D=3D DBUS_TYPE_STRING)
> +			dbus_message_iter_get_basic(&iter, &pns.server_ip);
> +		else if (g_str_equal(key, "PeerIPv4")
> +				&& type =3D=3D DBUS_TYPE_STRING)
> +			dbus_message_iter_get_basic(&iter, &pns.peer_ip);
> +		else if (g_str_equal(key, "PrimaryDNS")
> +				&& type =3D=3D DBUS_TYPE_STRING)
> +			dbus_message_iter_get_basic(&iter, &pns.primary_dns);
> +		else if (g_str_equal(key, "SecondaryDNS")
> +				&& type =3D=3D DBUS_TYPE_STRING)
> +			dbus_message_iter_get_basic(&iter, &pns.secondary_dns);

The preference is to have the && on the previous line.  So e.g.
else if (g_str_equal(...) &&
		type =3D=3D ...)

> +
> +		dbus_message_iter_next(&dict);
> +	}
> +
> +	dbus_message_iter_next(&array);
> +	if (dbus_message_iter_get_arg_type(&array) !=3D DBUS_TYPE_UNIX_FD)
> +		goto error;
> +
> +	dbus_message_iter_get_basic(&array, &pns.fd);
> +	DBG("Fildescriptor =3D %d\n", pns.fd);
> +
> +

Why the double empty line?

> +	if (pns.server_ip =3D=3D NULL || pns.peer_ip =3D=3D NULL ||
> +			pns.primary_dns =3D=3D NULL || pns.secondary_dns =3D=3D NULL ||
> +			pns.fd < 0) {
> +		ofono_error("Error while reading dictionnary...\n");
> +		goto release;
> +	}
> +
> +	req->cb(&pns, req->data);
> +
> +	dbus_message_unref(reply);
> +	dbus_pending_call_unref(call);
> +
> +	return;
> +
> +release:
> +	pns_release(req->uid);
> +error:
> +	if (pns.fd >=3D 0)
> +		close(pns.fd);
> +
> +	req->cb(NULL, req->data);
> +
> +	if (reply)
> +		dbus_message_unref(reply);
> +
> +	dbus_pending_call_unref(call);
> +}
> +
> +static int pns_request(ofono_private_network_cb_t cb, void *data)
> +{
> +	DBusMessage *message;
> +	DBusPendingCall *call;
> +	struct pns_req *req;
> +
> +	DBG("");
> +
> +	req =3D g_try_new(struct pns_req, 1);
> +
> +	if (req =3D=3D NULL)
> +		return -ENOMEM;
> +
> +	message =3D dbus_message_new_method_call(CONNMAN_SERVICE,
> +						CONNMAN_MANAGER_PATH,
> +						CONNMAN_MANAGER_INTERFACE,
> +						"RequestPrivateNetwork");
> +
> +	if (message =3D=3D NULL) {
> +		g_free(req);
> +		return -ENOMEM;
> +	}
> +
> +	if (dbus_connection_send_with_reply(connection, message,
> +						&call, 5000) =3D=3D FALSE) {
> +		g_free(req);
> +		dbus_message_unref(message);
> +		return -EIO;
> +	}
> +
> +	id++;
> +	req->pending =3D call;
> +	req->cb =3D cb;
> +	req->data =3D data;
> +	req->uid =3D id;
> +	req->redundant =3D FALSE;
> +
> +	dbus_pending_call_set_notify(call, request_reply, req, NULL);
> +	g_hash_table_insert(requests, &req->uid, req);
> +	dbus_message_unref(message);
> +
> +	return req->uid;
> +}
> +
> +static struct ofono_private_network_driver pn_driver =3D {
> +	.name		=3D "ConnMan Private Network",
> +	.request	=3D pns_request,
> +	.release	=3D pns_release,
> +};
> +
> +static void remove_requests(gpointer user_data)
> +{
> +	struct pns_req *req =3D user_data;
> +
> +	g_free(req->path);
> +	g_free(req);
> +}
> +
> +static int connman_init(void)
> +{
> +	DBG("");
> +
> +	connection =3D ofono_dbus_get_connection();
> +	requests =3D g_hash_table_new_full(g_int_hash, g_int_equal, NULL,
> +						remove_requests);
> +
> +	return ofono_private_network_driver_register(&pn_driver);
> +}
> +
> +static void connman_exit(void)
> +{
> +	g_hash_table_destroy(requests);
> +	ofono_private_network_driver_unregister(&pn_driver);
> +}
> +
> +OFONO_PLUGIN_DEFINE(connman, "ConnMan plugin", VERSION,
> +		OFONO_PLUGIN_PRIORITY_DEFAULT, connman_init, connman_exit)

The rest looks good to me.

Regards,
-Denis

--===============6752372687099430112==--

