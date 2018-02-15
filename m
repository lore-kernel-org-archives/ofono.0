Content-Type: multipart/mixed; boundary="===============4337967745357662299=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] add syspath property to modem properties
Date: Thu, 15 Feb 2018 09:59:03 -0600
Message-ID: <1b604a58-6406-fa45-44f9-97260c4e8853@gmail.com>
In-Reply-To: <1518684623-11944-1-git-send-email-c.ronco@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4337967745357662299==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christophe,

On 02/15/2018 02:50 AM, Christophe Ronco wrote:
> ---
>   plugins/udevng.c |  2 ++
>   src/modem.c      | 74 ++++++++++++++++++++++++++++++++-----------------=
-------
>   2 files changed, 45 insertions(+), 31 deletions(-)
> =

> diff --git a/plugins/udevng.c b/plugins/udevng.c
> index 2279bbe9..d5139586 100644
> --- a/plugins/udevng.c
> +++ b/plugins/udevng.c
> @@ -1330,6 +1330,8 @@ static gboolean create_modem(gpointer key, gpointer=
 value, gpointer user_data)
>   			continue;
>   =

>   		if (driver_list[i].setup(modem) =3D=3D TRUE) {
> +			ofono_modem_set_string(modem->modem, "Syspath",

Use camel case, so "SysPath" or "SystemPath"

> +								syspath);
>   			ofono_modem_register(modem->modem);
>   			return FALSE;
>   		}
> diff --git a/src/modem.c b/src/modem.c
> index b1e8d3e2..7759b567 100644
> --- a/src/modem.c
> +++ b/src/modem.c
> @@ -773,6 +773,41 @@ ofono_bool_t ofono_modem_get_online(struct ofono_mod=
em *modem)
>   	return modem->online;
>   }
>   =

> +static gboolean get_modem_property(struct ofono_modem *modem, const char=
 *name,
> +					enum property_type type,
> +					void *value)
> +{
> +	struct modem_property *property;
> +
> +	DBG("modem %p property %s", modem, name);
> +
> +	property =3D g_hash_table_lookup(modem->properties, name);
> +
> +	if (property =3D=3D NULL) {
> +		DBG("property %s does not exist", name);
> +		return FALSE;
> +	}
> +
> +	if (property->type !=3D type) {
> +		DBG("property %s wrong type", name);
> +		return FALSE;
> +	}
> +
> +	switch (property->type) {
> +	case PROPERTY_TYPE_STRING:
> +		*((const char **) value) =3D property->value;
> +		return TRUE;
> +	case PROPERTY_TYPE_INTEGER:
> +		memcpy(value, property->value, sizeof(int));
> +		return TRUE;
> +	case PROPERTY_TYPE_BOOLEAN:
> +		memcpy(value, property->value, sizeof(ofono_bool_t));
> +		return TRUE;
> +	default:
> +		return FALSE;
> +	}
> +}
> +
>   void __ofono_modem_append_properties(struct ofono_modem *modem,
>   						DBusMessageIter *dict)
>   {
> @@ -783,6 +818,7 @@ void __ofono_modem_append_properties(struct ofono_mod=
em *modem,
>   	struct ofono_devinfo *info;
>   	dbus_bool_t emergency =3D ofono_modem_get_emergency_mode(modem);
>   	const char *strtype;
> +	char *value;
>   =

>   	ofono_dbus_dict_append(dict, "Online", DBUS_TYPE_BOOLEAN,
>   				&modem->online);
> @@ -823,6 +859,13 @@ void __ofono_modem_append_properties(struct ofono_mo=
dem *modem,
>   						&info->svn);
>   	}
>   =

> +	if (get_modem_property(modem, "Syspath", PROPERTY_TYPE_STRING,
> +							&value) =3D=3D TRUE) {
> +		ofono_dbus_dict_append(dict, "ModemSyspath",
> +						DBUS_TYPE_STRING,
> +						&value);
> +	}
> +

There's no need for {}.  And why don't you make things much easier on =

yourself and simply use ofono_modem_get_string()

>   	interfaces =3D g_new0(char *, g_slist_length(modem->interface_list) + =
1);
>   	for (i =3D 0, l =3D modem->interface_list; l; l =3D l->next, i++)
>   		interfaces[i] =3D l->data;
> @@ -1731,37 +1774,6 @@ static int set_modem_property(struct ofono_modem *=
modem, const char *name,
>   	return 0;
>   }
>   =

> -static gboolean get_modem_property(struct ofono_modem *modem, const char=
 *name,
> -					enum property_type type,
> -					void *value)
> -{
> -	struct modem_property *property;
> -
> -	DBG("modem %p property %s", modem, name);
> -
> -	property =3D g_hash_table_lookup(modem->properties, name);
> -
> -	if (property =3D=3D NULL)
> -		return FALSE;
> -
> -	if (property->type !=3D type)
> -		return FALSE;
> -
> -	switch (property->type) {
> -	case PROPERTY_TYPE_STRING:
> -		*((const char **) value) =3D property->value;
> -		return TRUE;
> -	case PROPERTY_TYPE_INTEGER:
> -		memcpy(value, property->value, sizeof(int));
> -		return TRUE;
> -	case PROPERTY_TYPE_BOOLEAN:
> -		memcpy(value, property->value, sizeof(ofono_bool_t));
> -		return TRUE;
> -	default:
> -		return FALSE;
> -	}
> -}
> -
>   int ofono_modem_set_string(struct ofono_modem *modem,
>   				const char *key, const char *value)
>   {
> =


Regards,
-Denis

--===============4337967745357662299==--

