Content-Type: multipart/mixed; boundary="===============1352002164127518689=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/3] bluez5: Add bt_register_profile_full()
Date: Tue, 23 Apr 2013 03:46:52 -0500
Message-ID: <51764A7C.6050008@gmail.com>
In-Reply-To: <1366653252-19791-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1352002164127518689==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Vinicius,

On 04/22/2013 12:54 PM, Vinicius Costa Gomes wrote:
> This function makes it easy to set up optional information in the profile
> service record.
> ---
>   plugins/bluez5.c | 40 +++++++++++++++++++++++++++++++++-------
>   plugins/bluez5.h | 10 ++++++++++
>   2 files changed, 43 insertions(+), 7 deletions(-)
>
> diff --git a/plugins/bluez5.c b/plugins/bluez5.c
> index 0f997da..48d8bf2 100644
> --- a/plugins/bluez5.c
> +++ b/plugins/bluez5.c
> @@ -90,9 +90,10 @@ done:
>   	dbus_message_unref(reply);
>   }
>
> -int bt_register_profile_with_role(DBusConnection *conn, const char *uuid,
> -					uint16_t version, const char *name,
> -					const char *object, const char *role)
> +int bt_register_profile_full(DBusConnection *conn,
> +					const char *uuid, uint16_t version,
> +					const char *name, const char *object,
> +					struct bt_profile_info *optional)

We are now getting too many variations.  We currently have 4 callers of =

bt_register_profile (3 the simple function, 1 of _role).  Now we have 4 =

callers and 3 variations.  This is too much.  Lets just make =

bt_register_profile accept the full set of arguments and change everyone =

over.

Also, I don't like introducing a struct bt_profile_info for this.  Just =

add the extra arguments you need and accept NULL where needed.

>   {
>   	DBusMessageIter iter, dict;
>   	DBusPendingCall *c;
> @@ -111,9 +112,19 @@ int bt_register_profile_with_role(DBusConnection *co=
nn, const char *uuid,
>   	ofono_dbus_dict_append(&dict, "Name", DBUS_TYPE_STRING,&name);
>   	ofono_dbus_dict_append(&dict, "Version", DBUS_TYPE_UINT16,&version);
>
> -	if (role)
> -		ofono_dbus_dict_append(&dict, "Role", DBUS_TYPE_STRING,&role);
>
> +	if (optional =3D=3D NULL)
> +		goto done;
> +
> +	if (optional->role)
> +		ofono_dbus_dict_append(&dict, "Role", DBUS_TYPE_STRING,
> +							&optional->role);
> +
> +	if (optional->features)
> +		ofono_dbus_dict_append(&dict, "Features", DBUS_TYPE_UINT16,
> +							&optional->features);
> +
> +done:
>   	dbus_message_iter_close_container(&iter,&dict);
>
>   	if (!dbus_connection_send_with_reply(conn, msg,&c, -1)) {
> @@ -130,12 +141,27 @@ int bt_register_profile_with_role(DBusConnection *c=
onn, const char *uuid,
>   	return 0;
>   }
>
> +int bt_register_profile_with_role(DBusConnection *conn, const char *uuid,
> +					uint16_t version, const char *name,
> +					const char *object, const char *role)
> +{
> +	struct bt_profile_info optional;
> +
> +	memset(&optional, 0, sizeof(optional));
> +
> +	optional.role =3D role;
> +
> +	return bt_register_profile_full(conn, uuid, version, name,
> +							object,&optional);
> +}
> +
> +
>   int bt_register_profile(DBusConnection *conn, const char *uuid,
>   					uint16_t version, const char *name,
>   							const char *object)
>   {
> -	return bt_register_profile_with_role(conn, uuid, version, name, object,
> -									NULL);
> +	return bt_register_profile_full(conn, uuid, version, name,
> +							object, NULL);
>   }
>
>   void bt_unregister_profile(DBusConnection *conn, const char *object)
> diff --git a/plugins/bluez5.h b/plugins/bluez5.h
> index 5b8c1f5..8118f1f 100644
> --- a/plugins/bluez5.h
> +++ b/plugins/bluez5.h
> @@ -29,10 +29,20 @@
>   #define HFP_HS_UUID	"0000111e-0000-1000-8000-00805f9b34fb"
>   #define HFP_AG_UUID	"0000111f-0000-1000-8000-00805f9b34fb"
>
> +struct bt_profile_info {
> +	const char *role;
> +	uint16_t features;
> +};
> +
>   int bt_register_profile_with_role(DBusConnection *conn, const char *uui=
d,
>   					uint16_t version, const char *name,
>   					const char *object, const char *role);
>
> +int bt_register_profile_full(DBusConnection *conn,
> +					const char *uuid, uint16_t version,
> +					const char *name, const char *object,
> +					struct bt_profile_info *optional);
> +
>   int bt_register_profile(DBusConnection *conn, const char *uuid,
>   					uint16_t version, const char *name,
>   					const char *object);

Regards,
-Denis

--===============1352002164127518689==--

