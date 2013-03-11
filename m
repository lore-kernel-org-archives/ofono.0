Content-Type: multipart/mixed; boundary="===============8263004186775588705=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: Re: [PATCH 07/13] dundee: Listen to devices property changes
Date: Mon, 11 Mar 2013 18:17:52 +0100
Message-ID: <513E11C0.40304@monom.org>
In-Reply-To: <1362425590-26075-8-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8263004186775588705==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paulo,

On 03/04/2013 08:33 PM, Paulo Borges wrote:
> When a bluetooth device property change and this property is Alias
> or UUIDs, we need to refresh our representation of this device.
> ---
>   dundee/bluez5.c |   26 +++++++++++++++++++++++++-
>   1 file changed, 25 insertions(+), 1 deletion(-)
>
> diff --git a/dundee/bluez5.c b/dundee/bluez5.c
> index 8d8e656..623201f 100644
> --- a/dundee/bluez5.c
> +++ b/dundee/bluez5.c
> @@ -169,11 +169,35 @@ static void property_changed(GDBusProxy *proxy, con=
st char *name,
>   {
>   	const char *path =3D g_dbus_proxy_get_path(proxy);
>   	const char *interface =3D g_dbus_proxy_get_interface(proxy);
> +	const char *alias;
> +	struct bluetooth_device *bt_device;
> +	gboolean uuid;
>
>   	if (g_str_equal(BLUEZ_DEVICE_INTERFACE, interface) =3D=3D FALSE)
>   		return;
>
> -	DBG("%s %s.%s", path, interface, name);
> +	bt_device =3D g_hash_table_lookup(registered_devices, path);
> +
> +	if (g_str_equal(name, "Alias") =3D=3D TRUE) {
> +		if (bt_device =3D=3D NULL)
> +			return;
> +
> +		dbus_message_iter_get_basic(iter, &alias);
> +
> +		DBG("%s alias changed: %s", path, alias);
> +
> +		bt_device->name =3D g_strdup(alias);
> +	} else if (g_str_equal(name, "UUIDs") =3D=3D TRUE) {
> +		DBG("%s uuids changed", path);
> +
> +		uuid =3D has_dun_uuid(iter);
> +
> +		if (bt_device !=3D NULL && uuid =3D=3D FALSE)
> +			bluetooth_device_unregister(path);
> +
> +		else if (bt_device =3D=3D NULL && uuid =3D=3D TRUE)
> +			bluetooth_device_register(proxy);
> +	}

I find this a bit hard to read. What about

	if (uuid)
		if (bt_device !=3D NULL)
			bluetooth_device_unregister(path);
	else
		if (bt_device =3D=3D NULL)
			bluetooth_device_regster(path);

? I am not sure if Denis or Marcel approves this :)

cheers,
daniel


--===============8263004186775588705==--

