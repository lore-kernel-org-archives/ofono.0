Content-Type: multipart/mixed; boundary="===============7745906469375245491=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCHv5 1/4] sim-auth: implementation of core sim-auth atom
Date: Thu, 12 Oct 2017 15:43:47 -0500
Message-ID: <e8246e03-2e67-51bd-b4ca-88d5a1cadeb8@gmail.com>
In-Reply-To: <1507825691-21128-1-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7745906469375245491==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 10/12/2017 11:28 AM, James Prestwood wrote:
> The sim-auth module atom can now be used for SIM application discovery
> and authentication. The atom will automatically discover SIM
> applications available on the SIM and register a new DBus object under
> the modem, whos name is the AID string e.g.
> =

> /modem1/A0000000871004FFFFFFFF8906190000
> =

> A list of discovered AID object paths and types can be retrieved by
> calling GetApplications() under the modems (new)
> org.ofono.SimAuthentication interface which returns "a{oa{sv}}" where
> =

> o =3D path (e.g. above)
> =

> and the dictionary contains the following properties:
> =

> Type: "Umts" or "Ims"
> Name: "USim" or "ISim"
> =

> The Type signifies which interfaces the AID object will have:
> =

> Umts =3D org.ofono.USimApplication
> Ims =3D org.ofono.ISimApplication
> =

> These interfaces will contain the supported USIM/ISIM authentication
> algorithms. Where:
> =

> org.ofono.USimApplication has:
>      GetProperties()
>      GsmAuthenticate()
>      UmtsAuthenticate()
> =

> org.ofono.ISimApplication has:
>      GetProperties()
>      ImsAuthenticate()
> ---
>   src/sim-auth.c | 628 ++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++
>   1 file changed, 628 insertions(+)
> =


I went ahead and applied all 4 patches.  Can you please send me a fix on =

top for:

<snip>

> +static DBusMessage *usim_gsm_authenticate(DBusConnection *conn,
> +		DBusMessage *msg, void *data)
> +{
> +	struct ofono_sim_auth *sim =3D data;
> +	DBusMessageIter iter;
> +	DBusMessageIter array;
> +	int i;
> +	struct sim_app_record *app;
> +
> +	if (sim->pending)
> +		return __ofono_error_busy(msg);
> +
> +	dbus_message_iter_init(msg, &iter);
> +
> +	if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_ARRAY)
> +		return __ofono_error_invalid_format(msg);
> +
> +	sim->pending =3D malloc(sizeof(struct auth_request));
> +	sim->pending->msg =3D dbus_message_ref(msg);
> +	sim->pending->umts =3D 0;
> +	sim->pending->cb_count =3D 0;
> +	sim->pending->num_rands =3D dbus_message_iter_get_element_count(&iter);

Sanity checking of num_rands isn't present, so...

> +
> +	dbus_message_iter_recurse(&iter, &array);
> +
> +	for (i =3D 0; i < sim->pending->num_rands; i++) {
> +		int nelement;
> +		DBusMessageIter in;
> +
> +		dbus_message_iter_recurse(&array, &in);
> +
> +		dbus_message_iter_get_fixed_array(&in, &sim->pending->rands[i],
> +				&nelement);

... you can overflow pending->rands memory space.

Also, none of the dbus_message_iter* calls are being sanity checked, so =

you could in theory send an array of strings here, etc...

> +
> +		if (nelement !=3D 16) {
> +			g_free(sim->pending);
> +			sim->pending =3D NULL;
> +			return __ofono_error_invalid_format(msg);
> +		}
> +
> +		dbus_message_iter_next(&array);
> +	}
> +
> +	app =3D find_aid_by_path(sim->aid_list, dbus_message_get_path(msg));
> +
> +	sim->driver->open_channel(sim, app->aid, open_channel_cb, sim);
> +
> +	return NULL;
> +}

Regards,
-Denis

--===============7745906469375245491==--

