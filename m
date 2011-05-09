Content-Type: multipart/mixed; boundary="===============4033688554489741272=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH_v4 5/5] connman: add plugin in oFono to request
 request/release private network
Date: Mon, 09 May 2011 00:30:13 -0500
Message-ID: <4DC77BE5.6050104@gmail.com>
In-Reply-To: <1304690513-3137-6-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4033688554489741272==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

On 05/06/2011 09:01 AM, Guillaume Zajac wrote:
> ---
>  Makefile.am       |    3 +
>  plugins/connman.c |  297 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 300 insertions(+), 0 deletions(-)
>  create mode 100644 plugins/connman.c
> =

> diff --git a/Makefile.am b/Makefile.am
> index e1eaf15..ffb85ae 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -339,6 +339,9 @@ builtin_sources +=3D plugins/hfp_ag.c plugins/bluetoo=
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
> index 0000000..cfc1721
> --- /dev/null
> +++ b/plugins/connman.c
> @@ -0,0 +1,297 @@
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
> +#include <ofono.h>
> +#include <private-network.h>
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
> +static GHashTable *requests;
> +static unsigned int id;
> +
> +struct pns_req {
> +	int uid;
> +	DBusPendingCall *pending;
> +	struct ofono_private_network_settings *pns;
> +	ofono_private_network_cb_t *cb;
> +	void *data;
> +};
> +
> +static void request_reply(DBusPendingCall *call, void *user_data)
> +{
> +	struct pns_req *req =3D user_data;
> +	struct ofono_private_network_settings *pns;
> +	DBusMessageIter array, dict, entry;
> +	DBusMessage *reply;
> +
> +	DBG("");
> +
> +	req->pending =3D NULL;
> +	reply =3D dbus_pending_call_steal_reply(call);
> +	if (!reply)
> +		goto error;
> +
> +	pns =3D g_try_new0(struct ofono_private_network_settings, 1);
> +	if (pns =3D=3D NULL)
> +		goto error;

I question the need to allocate this structure here.  Why can't you
create it on the stack?  Are you trying to keep this structure around so
that the caller can reference its members ?  If so, please don't, it
won't work out.  All pointers you extract from the message will be gone
(*poof*) when you call dbus_message_unref.  If the caller needs to save
the information it receives in the callback, then it should copy the
memory and manage it appropriately.  This is why most oFono callback
definitions use const structures, to avoid this temptation ;)

> +
> +	if (dbus_message_iter_init(reply, &array) =3D=3D FALSE)
> +		goto error;
> +
> +	if (dbus_message_iter_get_arg_type(&array) !=3D DBUS_TYPE_UNIX_FD)
> +		goto error;
> +
> +	dbus_message_iter_get_basic(&array, &pns->fd);
> +	DBG("Fildescriptor =3D %d\n", pns->fd);
> +
> +	dbus_message_iter_next(&array);
> +
> +	if (dbus_message_iter_get_arg_type(&array) !=3D DBUS_TYPE_ARRAY)
> +		goto error;
> +
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
> +				&& type =3D=3D DBUS_TYPE_STRING) {
> +			dbus_message_iter_get_basic(&iter, &pns->server_ip);
> +
> +		} else if (g_str_equal(key, "PeerIPv4")
> +				&& type =3D=3D DBUS_TYPE_STRING) {
> +			dbus_message_iter_get_basic(&iter, &pns->peer_ip);
> +
> +		} else if (g_str_equal(key, "PrimaryDNS")
> +				&& type =3D=3D DBUS_TYPE_STRING) {
> +			dbus_message_iter_get_basic(&iter, &pns->primary_dns);
> +
> +		} else if (g_str_equal(key, "SecondaryDNS")
> +				&& type =3D=3D DBUS_TYPE_STRING) {
> +			dbus_message_iter_get_basic(&iter, &pns->secondary_dns);
> +		}
> +
> +		dbus_message_iter_next(&dict);
> +	}
> +
> +	req->pns =3D pns;
> +	if (pns->server_ip =3D=3D NULL || pns->peer_ip =3D=3D NULL ||
> +		pns->primary_dns =3D=3D NULL || pns->secondary_dns =3D=3D NULL ||
> +		pns->fd < 0) {

doc/coding-style.txt item M4

> +		ofono_error("Error while reading dictionnary...\n");
> +		goto error;
> +	}
> +
> +	req->cb(req->data, req->pns);
> +
> +	dbus_message_unref(reply);
> +	dbus_pending_call_unref(call);
> +
> +	return;
> +
> +error:
> +	req->cb(req->data, NULL);
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
> +	req =3D g_try_new0(struct pns_req, 1);
> +
> +	if (req =3D=3D NULL)
> +		return -ENOMEM;
> +
> +	message =3D dbus_message_new_method_call(CONNMAN_SERVICE,
> +				     CONNMAN_MANAGER_PATH,
> +				     CONNMAN_MANAGER_INTERFACE,
> +				     "RequestPrivateNetwork");
> +
> +	if (message =3D=3D NULL) {
> +		g_free(req);
> +		return -ENOMEM;
> +	}
> +
> +	if (dbus_connection_send_with_reply(connection,
> +				message, &call, 5000) =3D=3D FALSE) {
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
> +
> +	dbus_pending_call_set_notify(call, request_reply,
> +							req, NULL);
> +	g_hash_table_insert(requests, &req->uid, req);
> +	dbus_message_unref(message);
> +
> +	return req->uid;
> +}
> +
> +static void release_reply(DBusPendingCall *call, void *user_data)
> +{
> +	DBusMessage *reply;
> +	struct pns_req *req =3D user_data;
> +
> +	DBG("");
> +
> +	reply =3D dbus_pending_call_steal_reply(call);
> +	g_hash_table_remove(requests, &req->uid);
> +	if (req->pns)
> +		g_free(req->pns);
> +
> +	g_free(req);
> +	if (reply)
> +		dbus_message_unref(reply);
> +
> +	dbus_pending_call_unref(call);
> +}
> +
> +static void pns_release(int uid)
> +{
> +	DBusMessage *message =3D NULL;
> +	struct pns_req *req;
> +	DBusPendingCall *call;
> +
> +	DBG("");
> +
> +	req =3D g_hash_table_lookup(requests, &uid);
> +	if (!req)
> +		return;
> +
> +	if (req->pending) {
> +		if (dbus_pending_call_get_completed(req->pending) =3D=3D FALSE) {
> +			dbus_pending_call_cancel(req->pending);
> +			g_hash_table_remove(requests, &uid);
> +			g_free(req);
> +			return;
> +		}

Unfortunately things are not that easy.  If you have a pending request,
then you can't simply use pending_call_cancel on it.  This will require
some thinking, but imagine this situation:

oFono calls RequestPrivateNetwork, and cancels the request before the
reply is received, however, ConnMan has already allocated an IP address
and opened the TUN device, and the reply is in the mail so to speak.

In this situation, ConnMan won't be able to release the private network
resources until oFono exits.  Not good ;)

So unfortunately your life gets a bit tricky, since your plugin must
take care of this case, and keep the request alive (marked redundant)
until ConnMan responds, and then send the appropriate Release method.

> +	}
> +
> +	message =3D dbus_message_new_method_call(CONNMAN_SERVICE,
> +				     CONNMAN_MANAGER_PATH,
> +				     CONNMAN_MANAGER_INTERFACE,
> +				     "ReleasePrivateNetwork");
> +
> +	if (message =3D=3D NULL)
> +		goto error;
> +
> +	if (dbus_connection_send_with_reply(connection,
> +				message, &call, 5000) =3D=3D FALSE)
> +		goto error;

You can make things easier on yourself by sending this message with
NoReply flag set and just immediately removing the request.

> +
> +	dbus_pending_call_set_notify(call, release_reply,
> +							req, NULL);
> +	dbus_message_unref(message);
> +	=

> +	return;
> +
> +error:
> +	if (message)
> +		dbus_message_unref(message);
> +
> +	g_hash_table_remove(requests, &req->uid);
> +	if (req->pns)
> +		g_free(req->pns);
> +
> +	g_free(req);
> +}
> +
> +static struct ofono_private_network_driver pn_driver =3D {
> +	.name		=3D "ConnMan Private Network",
> +	.request	=3D pns_request,
> +	.release	=3D pns_release,
> +};
> +
> +static int connman_init(void)
> +{
> +	DBG("");
> +
> +	id =3D 0;
> +	connection =3D ofono_dbus_get_connection();
> +	requests =3D g_hash_table_new(g_int_hash, g_int_equal);

It is a bad idea to create a hash table with no destructor set.  How are
you going to clean up the entries ?

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

Regards,
-Denis

--===============4033688554489741272==--

