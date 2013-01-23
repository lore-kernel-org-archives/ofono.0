Content-Type: multipart/mixed; boundary="===============8837647608865915940=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 01/10] hfp_hf_bluez5: Initial GDBusClient for BlueZ
Date: Tue, 22 Jan 2013 22:30:21 -0600
Message-ID: <50FF675D.5060005@gmail.com>
In-Reply-To: <1358891005-24688-2-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8837647608865915940==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Vinicius,

On 01/22/2013 03:43 PM, Vinicius Costa Gomes wrote:
> This patch adds the initial callbacks to track when BlueZ connects or
> disconnects from the system bus. And tracks the interfaces added or
> removed.
> ---
>   plugins/bluez5.h        |  3 ++-
>   plugins/hfp_hf_bluez5.c | 72 ++++++++++++++++++++++++++++++++++++++++++=
-------
>   2 files changed, 65 insertions(+), 10 deletions(-)
>
> diff --git a/plugins/bluez5.h b/plugins/bluez5.h
> index 01ecfe8..893072f 100644
> --- a/plugins/bluez5.h
> +++ b/plugins/bluez5.h
> @@ -19,7 +19,8 @@
>    *
>    */
>
> -#define	BLUEZ_SERVICE "org.bluez"
> +#define BLUEZ_SERVICE			"org.bluez"
> +#define BLUEZ_MANAGER_PATH		"/"
>   #define BLUEZ_PROFILE_INTERFACE		BLUEZ_SERVICE ".Profile1"
>   #define BLUEZ_ERROR_INTERFACE		BLUEZ_SERVICE ".Error"
>
> diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
> index e024838..c5c5cd7 100644
> --- a/plugins/hfp_hf_bluez5.c
> +++ b/plugins/hfp_hf_bluez5.c
> @@ -42,6 +42,8 @@
>
>   #define HFP_EXT_PROFILE_PATH   "/bluetooth/profile/hfp_hf"
>
> +static GDBusClient *bluez =3D NULL;
> +
>   static int hfp_probe(struct ofono_modem *modem)
>   {
>   	DBG("modem: %p", modem);
> @@ -143,6 +145,60 @@ static const GDBusMethodTable profile_methods[] =3D {
>   	{ }
>   };
>
> +static void connect_handler(DBusConnection *conn, void *user_data)
> +{
> +	DBG("Registering External Profile handler ...");
> +
> +	if (!g_dbus_register_interface(conn, HFP_EXT_PROFILE_PATH,
> +					BLUEZ_PROFILE_INTERFACE,
> +					profile_methods, NULL,
> +					NULL, NULL, NULL)) {

We just performed this operation in hfp_init, why are we doing it again =

here?

> +		ofono_error("Register Profile interface failed: %s",
> +						HFP_EXT_PROFILE_PATH);
> +	}
> +
> +	bluetooth_register_profile(conn, HFP_HS_UUID, "hfp_hf",
> +						   HFP_EXT_PROFILE_PATH);

You have a whitespace violation here, mixing tabs & spaces.

> +}
> +
> +static void disconnect_handler(DBusConnection *conn, void *user_data)
> +{
> +
> +	DBG("Unregistering External Profile handler ...");
> +
> +	g_dbus_unregister_interface(conn, HFP_EXT_PROFILE_PATH,
> +						BLUEZ_PROFILE_INTERFACE);

Why do we bother?  Should we not leave this always registered?

> +}
> +
> +static void proxy_added(GDBusProxy *proxy, void *user_data)
> +{
> +	const char *path;
> +
> +	path =3D g_dbus_proxy_get_path(proxy);
> +
> +	DBG("Device proxy: %s(%p)", path, proxy);
> +}
> +
> +static void proxy_removed(GDBusProxy *proxy, void *user_data)
> +{
> +	const char *path;
> +
> +	path =3D g_dbus_proxy_get_path(proxy);
> +
> +	DBG("Device proxy: %s(%p)", path, proxy);
> +}
> +
> +static void property_changed(GDBusProxy *proxy, const char *name,
> +					DBusMessageIter *iter, void *user_data)
> +{
> +	const char *interface, *path;
> +
> +	interface =3D g_dbus_proxy_get_interface(proxy);
> +	path =3D g_dbus_proxy_get_path(proxy);
> +
> +	DBG("path: %s interface: %s", path, interface);
> +}
> +
>   static int hfp_init(void)
>   {
>   	DBusConnection *conn =3D ofono_dbus_get_connection();
> @@ -161,19 +217,16 @@ static int hfp_init(void)
>   		return -EIO;
>   	}
>
> -	err =3D ofono_modem_driver_register(&hfp_driver);
> -	if (err<  0) {
> -		g_dbus_unregister_interface(conn, HFP_EXT_PROFILE_PATH,
> -						BLUEZ_PROFILE_INTERFACE);
> -		return err;
> -	}
> +	bluez =3D g_dbus_client_new(conn, BLUEZ_SERVICE, BLUEZ_MANAGER_PATH);
> +	g_dbus_client_set_connect_watch(bluez, connect_handler, NULL);
> +	g_dbus_client_set_disconnect_watch(bluez, disconnect_handler, NULL);
> +	g_dbus_client_set_proxy_handlers(bluez, proxy_added, proxy_removed,
> +						property_changed, NULL);

Error handling here is all messed up.  ofono_modem_driver_register =

operation might still fail below and you never destroy the 'bluez' =

object in that case.

>
> -	err =3D bluetooth_register_profile(conn, HFP_HS_UUID, "hfp_hf",
> -						HFP_EXT_PROFILE_PATH);
> +	err =3D ofono_modem_driver_register(&hfp_driver);
>   	if (err<  0) {
>   		g_dbus_unregister_interface(conn, HFP_EXT_PROFILE_PATH,
>   						BLUEZ_PROFILE_INTERFACE);
> -		ofono_modem_driver_unregister(&hfp_driver);
>   		return err;
>   	}
>
> @@ -188,6 +241,7 @@ static void hfp_exit(void)
>   	g_dbus_unregister_interface(conn, HFP_EXT_PROFILE_PATH,
>   						BLUEZ_PROFILE_INTERFACE);
>   	ofono_modem_driver_unregister(&hfp_driver);
> +	g_dbus_client_unref(bluez);
>   }
>
>   OFONO_PLUGIN_DEFINE(hfp_bluez5, "External Hands-Free Profile Plugin", V=
ERSION,

Regards,
-Denis

--===============8837647608865915940==--

