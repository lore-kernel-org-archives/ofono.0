Content-Type: multipart/mixed; boundary="===============5068853761124373453=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/4] src: Implement RAT list property
Date: Sun, 07 Dec 2014 22:46:56 -0600
Message-ID: <54852D40.2080104@gmail.com>
In-Reply-To: <1417797991-19700-4-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5068853761124373453==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alfonso,

On 12/05/2014 10:46 AM, Alfonso Sanchez-Beato wrote:
> ---
>   src/radio-settings.c | 61 +++++++++++++++++++++++++++++++++++++++++++++=
++++++-
>   1 file changed, 60 insertions(+), 1 deletion(-)
>
> diff --git a/src/radio-settings.c b/src/radio-settings.c
> index d1b1cc1..4967994 100644
> --- a/src/radio-settings.c
> +++ b/src/radio-settings.c
> @@ -48,6 +48,8 @@ struct ofono_radio_settings {
>   	enum ofono_radio_band_gsm pending_band_gsm;
>   	enum ofono_radio_band_umts pending_band_umts;
>   	ofono_bool_t fast_dormancy_pending;
> +	ofono_bool_t modem_rats[OFONO_RADIO_ACCESS_MODE_LAST];
> +	ofono_bool_t modem_rats_filled;

In general we use uint32_t flags and set the appropriate flag.  See e.g. =

src/voicecall.c for an example.

I think if you take my suggestions from patch 2, then a simple uint32_t =

available_rats variable should be sufficient.  If it is set to zero, =

then the AvailableTechnologies property should be hidden.

>   	const struct ofono_radio_settings_driver *driver;
>   	void *driver_data;
>   	struct ofono_atom *atom;
> @@ -222,6 +224,21 @@ static DBusMessage *radio_get_properties_reply(DBusM=
essage *msg,
>   					DBUS_TYPE_BOOLEAN, &value);
>   	}
>
> +	if (rs->driver->query_modem_rats) {
> +		const char *rats_strs[OFONO_RADIO_ACCESS_MODE_LAST + 1];
> +		const char *(*strs)[] =3D &rats_strs;

I'm seriously lost what you're trying to do here.  &rats_strs is a no-op.

I suspect that const char **strs =3D rats_strs; would be a bit easier to =

understand.

> +		int i, str_i;
> +
> +		for (i =3D 0, str_i =3D 0; i < OFONO_RADIO_ACCESS_MODE_LAST; ++i)
> +			if (rs->modem_rats[i])
> +				rats_strs[str_i++] =3D
> +						radio_access_mode_to_string(i);
> +		rats_strs[str_i] =3D NULL;
> +
> +		ofono_dbus_dict_append_array(&dict, "ModemTechnologies",
> +						DBUS_TYPE_STRING, &strs);

Please make this into AvailableTechnologies

> +	}
> +
>   	dbus_message_iter_close_container(&iter, &dict);
>
>   	return reply;
> @@ -374,6 +391,43 @@ static void radio_send_properties_reply(struct ofono=
_radio_settings *rs)
>   	__ofono_dbus_pending_reply(&rs->pending, reply);
>   }
>
> +static void radio_set_modem_rats(struct ofono_radio_settings *rs,
> +					const ofono_bool_t rats[])
> +{
> +	memcpy(rs->modem_rats, rats, sizeof(rs->modem_rats));
> +	rs->modem_rats_filled =3D TRUE;

A two line function that is called from only one place is not a good idea.

> +}
> +
> +static void radio_modem_rats_query_callback(const struct ofono_error *er=
ror,
> +						const ofono_bool_t rats[],
> +						void *data)
> +{
> +	struct ofono_radio_settings *rs =3D data;
> +	DBusMessage *reply;
> +
> +	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
> +		DBG("Error during modem rats query");
> +
> +		reply =3D __ofono_error_failed(rs->pending);
> +		__ofono_dbus_pending_reply(&rs->pending, reply);
> +
> +		return;

If possible the GetProperties call should not return an error.  In this =

particular case, if the query fails, simply omit AvailableTechnologies =

from the properties dictionary.  Hopefully the query succeeds next time.

> +	}
> +
> +	radio_set_modem_rats(rs, rats);
> +	radio_send_properties_reply(rs);
> +}
> +
> +static void radio_query_modem_rats(struct ofono_radio_settings *rs)
> +{
> +	if (rs->driver->query_modem_rats =3D=3D NULL) {
> +		radio_send_properties_reply(rs);
> +		return;
> +	}
> +
> +	rs->driver->query_modem_rats(rs, radio_modem_rats_query_callback, rs);
> +}
> +
>   static void radio_fast_dormancy_query_callback(const struct ofono_error=
 *error,
>   						ofono_bool_t enable, void *data)
>   {
> @@ -390,7 +444,12 @@ static void radio_fast_dormancy_query_callback(const=
 struct ofono_error *error,
>   	}
>
>   	radio_set_fast_dormancy(rs, enable);
> -	radio_send_properties_reply(rs);
> +
> +	/* Modem technology is not supposed to change, so one query is enough */
> +	if (rs->modem_rats_filled)
> +		radio_send_properties_reply(rs);
> +	else
> +		radio_query_modem_rats(rs);
>   }
>
>   static void radio_query_fast_dormancy(struct ofono_radio_settings *rs)
>

Regards,
-Denis

--===============5068853761124373453==--

