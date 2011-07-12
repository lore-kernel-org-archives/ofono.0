Content-Type: multipart/mixed; boundary="===============2375905377768815462=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH_v9] connman: add plugin in oFono to request/release
 private network
Date: Tue, 12 Jul 2011 11:23:12 -0500
Message-ID: <4E1C74F0.9050503@gmail.com>
In-Reply-To: <1310463078-15378-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2375905377768815462==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

<snip>

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
> +
> +	dbus_message_iter_next(&array);
> +	if (dbus_message_iter_get_arg_type(&array) !=3D DBUS_TYPE_ARRAY)
> +		goto error;
> +
> +	if (req->redundant =3D=3D TRUE)
> +		goto release;
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
> +		if (g_str_equal(key, "ServerIPv4") &&
> +				type =3D=3D DBUS_TYPE_STRING)
> +			dbus_message_iter_get_basic(&iter, &pns.server_ip);
> +		else if (g_str_equal(key, "PeerIPv4") &&
> +				type =3D=3D DBUS_TYPE_STRING)
> +			dbus_message_iter_get_basic(&iter, &pns.peer_ip);
> +		else if (g_str_equal(key, "PrimaryDNS") &&
> +				type =3D=3D DBUS_TYPE_STRING)
> +			dbus_message_iter_get_basic(&iter, &pns.primary_dns);
> +		else if (g_str_equal(key, "SecondaryDNS") &&
> +				type =3D=3D DBUS_TYPE_STRING)
> +			dbus_message_iter_get_basic(&iter, &pns.secondary_dns);
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
> +	req->path =3D g_strdup(path);
> +	DBG("Object path =3D %s\n", req->path);
> +
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
> +	if (req->redundant =3D=3D FALSE)
> +		req->cb(NULL, req->data);

And how do you think you will be using req->redundant when you just
freed req in pns_release above?

> +
> +	if (reply)
> +		dbus_message_unref(reply);
> +
> +	dbus_pending_call_unref(call);
> +}
> +

Anyhow, I applied this patch and refactored it very heavily afterward.
Please test my changes, particularly the error conditions with an older
version of ConnMan.

If things are working nicely please send a patch marking the DUN
emulator task as done.

Regards,
-Denis

--===============2375905377768815462==--

