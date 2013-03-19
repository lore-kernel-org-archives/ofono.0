Content-Type: multipart/mixed; boundary="===============2913920528134002737=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: Re: [PATCH v2 07/13] dundee: Listen to devices property changes
Date: Tue, 19 Mar 2013 22:10:48 +0100
Message-ID: <5148D458.5030403@monom.org>
In-Reply-To: <1363267974-13518-8-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2913920528134002737==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paulo,

I talked to Denis and he pointed out that this property_changed() =

function looks suspicious.

On 03/14/2013 02:32 PM, Paulo Borges wrote:
> When a bluetooth device property change and this property is Alias
> or UUIDs, we need to refresh our representation of this device.
> ---
>   dundee/bluez5.c |   28 +++++++++++++++++++++++++++-
>   1 file changed, 27 insertions(+), 1 deletion(-)
>
> diff --git a/dundee/bluez5.c b/dundee/bluez5.c
> index ca44656..d48aadf 100644
> --- a/dundee/bluez5.c
> +++ b/dundee/bluez5.c
> @@ -169,11 +169,37 @@ static void property_changed(GDBusProxy *proxy, con=
st char *name,
>   {
>   	const char *path =3D g_dbus_proxy_get_path(proxy);
>   	const char *interface =3D g_dbus_proxy_get_interface(proxy);
> +	const char *alias;
> +	struct bluetooth_device *bt_device;
> +	gboolean uuid;
>
>   	if (!g_str_equal(BLUEZ_DEVICE_INTERFACE, interface))
>   		return;
>
> -	DBG("%s %s.%s", path, interface, name);
> +	bt_device =3D g_hash_table_lookup(registered_devices, path);
> +
> +	if (g_str_equal(name, "Alias")) {
> +		if (bt_device =3D=3D NULL)
> +			return;
> +
> +		dbus_message_iter_get_basic(iter, &alias);
> +
> +		DBG("%s alias changed: %s", path, alias);
> +
> +		bt_device->name =3D g_strdup(alias);
> +	} else if (g_str_equal(name, "UUIDs")) {
> +		DBG("%s uuids changed", path);
> +
> +		uuid =3D has_dun_uuid(iter);
> +
> +		if (uuid) {
> +			if (bt_device =3D=3D NULL)
> +				bluetooth_device_register(proxy);
> +		} else {
> +			if (bt_device !=3D NULL)
> +				bluetooth_device_unregister(path);
> +		}
> +	}

So first thing, the nesting is should be avoided. Sorry, that's my bad.

	if (uuid && bt_device =3D=3D NULL) register

	if (!uuid && bt_device) unregister

is what is an the ofono style.

>   }
>
>   static void connect_handler(DBusConnection *conn, void *user_data)
>

The next thing is why don't you use g_dbus_proxy_set_property_watch() =

for the property change. Then it might also be worth to split out the
the property handling into individual function. So one for Alias change
and one for UUID change.

See how Alias is handled in plugins/hfp_hf_bluez5.c

And there is the question came up, why it is necessary to handle UUID =

changes. Is this because a phone can enable/disable tethering?

cheers,
daniel


--===============2913920528134002737==--

