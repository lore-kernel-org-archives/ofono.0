Content-Type: multipart/mixed; boundary="===============2746832746966098179=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: Re: [PATCH] bluetooth: Add reference count for bluetooth utils
Date: Tue, 18 Jan 2011 14:45:21 -0200
Message-ID: <20110118164521.GA25610@joana>
In-Reply-To: <1295368199-8563-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2746832746966098179==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

* Fr=C3=A9d=C3=A9ric Danis <frederic.danis@linux.intel.com> [2011-01-18 1=
7:29:59 +0100]:

> Add bluetooth_ref()/bluetooth_unref() to support reference count in
> bluetooth utils.
> ---
>  plugins/bluetooth.c |   62 +++++++++++++++++++++++++++++++++++++--------=
-----
>  1 files changed, 46 insertions(+), 16 deletions(-)
> =

> diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
> index 602c6da..a82cc64 100644
> --- a/plugins/bluetooth.c
> +++ b/plugins/bluetooth.c
> @@ -40,6 +40,7 @@
>  static DBusConnection *connection;
>  static GHashTable *uuid_hash =3D NULL;
>  static GHashTable *adapter_address_hash =3D NULL;
> +static gint ref_count;
>  =

>  void bluetooth_create_path(const char *dev_addr, const char *adapter_add=
r,
>  				char *buf, int size)
> @@ -504,12 +505,14 @@ static guint adapter_added_watch;
>  static guint adapter_removed_watch;
>  static guint property_watch;
>  =

> -int bluetooth_register_uuid(const char *uuid, struct bluetooth_profile *=
profile)
> +static int bluetooth_ref(void)
>  {
>  	int err;
>  =

> -	if (uuid_hash)
> -		goto done;
> +	g_atomic_int_inc(&ref_count);
> +
> +	if (ref_count > 1)
> +		return 0;

As I said in the other e-mail, only increment in the end of the function.

>  =

>  	connection =3D ofono_dbus_get_connection();
>  =

> @@ -543,13 +546,6 @@ int bluetooth_register_uuid(const char *uuid, struct=
 bluetooth_profile *profile)
>  	adapter_address_hash =3D g_hash_table_new_full(g_str_hash, g_str_equal,
>  						g_free, g_free);
>  =

> -done:
> -	g_hash_table_insert(uuid_hash, g_strdup(uuid), profile);
> -
> -	bluetooth_send_with_reply("/", BLUEZ_MANAGER_INTERFACE, "GetProperties",
> -				manager_properties_cb, NULL, NULL, -1,
> -				DBUS_TYPE_INVALID);
> -
>  	return 0;
>  =

>  remove:
> @@ -557,14 +553,17 @@ remove:
>  	g_dbus_remove_watch(connection, adapter_added_watch);
>  	g_dbus_remove_watch(connection, adapter_removed_watch);
>  	g_dbus_remove_watch(connection, property_watch);
> +
>  	return err;
>  }
>  =

> -void bluetooth_unregister_uuid(const char *uuid)
> +static void bluetooth_unref(void)
>  {
> -	g_hash_table_remove(uuid_hash, uuid);
> +	gboolean is_zero;
>  =

> -	if (g_hash_table_size(uuid_hash))
> +	is_zero =3D g_atomic_int_dec_and_test(&ref_count);
> +
> +	if (is_zero =3D=3D FALSE)
>  		return;
>  =

>  	g_dbus_remove_watch(connection, bluetooth_watch);
> @@ -572,9 +571,40 @@ void bluetooth_unregister_uuid(const char *uuid)
>  	g_dbus_remove_watch(connection, adapter_removed_watch);
>  	g_dbus_remove_watch(connection, property_watch);
>  =

> -	g_hash_table_destroy(uuid_hash);
> -	g_hash_table_destroy(adapter_address_hash);
> -	uuid_hash =3D NULL;
> +	if (uuid_hash) {
> +		g_hash_table_destroy(uuid_hash);
> +		uuid_hash =3D NULL;
> +	}
> +
> +	if (adapter_address_hash) {
> +		g_hash_table_destroy(adapter_address_hash);
> +		adapter_address_hash =3D NULL;
> +	}
> +}
> +
> +int bluetooth_register_uuid(const char *uuid, struct bluetooth_profile *=
profile)
> +{
> +	int err;
> +
> +	err =3D bluetooth_ref();

Same here.

> +
> +	if (err !=3D 0)
> +		return err;
> +
> +	g_hash_table_insert(uuid_hash, g_strdup(uuid), profile);
> +
> +	bluetooth_send_with_reply("/", BLUEZ_MANAGER_INTERFACE, "GetProperties",
> +				manager_properties_cb, NULL, NULL, -1,
> +				DBUS_TYPE_INVALID);
> +
> +	return 0;
> +}
> +
> +void bluetooth_unregister_uuid(const char *uuid)
> +{
> +	g_hash_table_remove(uuid_hash, uuid);
> +
> +	bluetooth_unref();
>  }
>  =

>  OFONO_PLUGIN_DEFINE(bluetooth, "Bluetooth Utils Plugins", VERSION,
> -- =

> 1.7.1
> =

> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono

-- =

Gustavo F. Padovan
http://profusion.mobi

--===============2746832746966098179==--

