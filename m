Content-Type: multipart/mixed; boundary="===============9193423365142657526=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 5/6] dun_gw: Add DUN server plugin for oFono
Date: Mon, 13 Sep 2010 13:18:02 -0500
Message-ID: <4C8E6ADA.9030402@gmail.com>
In-Reply-To: <1284355314-16253-6-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9193423365142657526==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,

> +	if (g_str_equal(property, "Online") =3D=3D TRUE) {
> +		const char *path =3D dbus_message_get_path(msg);
> +		struct ofono_modem *modem;
> +		struct ofono_atom *gprs;
> +		gboolean online;
> +
> +		if (!dbus_message_iter_next(&iter))
> +			return FALSE;
> +
> +		if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_VARIANT)
> +			return FALSE;
> +
> +		dbus_message_iter_recurse(&iter, &var);
> +
> +		dbus_message_iter_get_basic(&var, &online);
> +
> +		if (online =3D=3D FALSE) {
> +			bluetooth_unregister_server(server);
> +			server =3D NULL;
> +			goto done;
> +		}
> +
> +		/* Create DUN server */
> +		modem =3D ofono_modem_get_modem_by_path(path);
> +		gprs =3D __ofono_modem_find_atom(modem,
> +						OFONO_ATOM_TYPE_GPRS);
> +		/* Make sure the modem has GPRS atom */
> +		if (!gprs)
> +			goto done;
> +
> +		server =3D bluetooth_register_server(DUN_GW,
> +				"Dial-Up Networking", DUN_GW_CHANNEL,
> +				dun_gw_connect_cb, modem);
> +	}
> +
> +done:
> +	return TRUE;
> +}

Please don't do it this way.  Instead add a new modem_state_watch
function to modem.c for accomplishing this.

Regards,
-Denis

--===============9193423365142657526==--

