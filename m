Content-Type: multipart/mixed; boundary="===============6244584684672069924=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v4 1/3] huawei: detect possible secondary device
Date: Wed, 19 May 2010 19:34:10 -0500
Message-ID: <201005191934.10749.denkenz@gmail.com>
In-Reply-To: <20100520080408.17288.52965.stgit@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6244584684672069924==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kalle,

>  struct huawei_data {
> -	GAtChat *chat;
> +	GAtChat *chat, *event;
>  };
> =


Minor nitpick, but we prefer:
GAtChat *chat;
GAtChat *event;

in structures.

> @@ -80,6 +81,11 @@ static void huawei_debug(const char *str, void
>  *user_data) ofono_info("%s", str);
>  }
> =

> +static void huawei_event_debug(const char *str, void *user_data)
> +{
> +	ofono_info("* %s", str);
> +}
> +

There is no need for a separate function here.  user_data can be used for =

this:

const char *prefix =3D user_data;
ofono_info("%s: %s", prefix, str);

> +	modem_device =3D ofono_modem_get_string(modem, "Device");
> +	event_device =3D ofono_modem_get_string(modem, "SecondaryDevice");
> +
> +	if (modem_device =3D=3D NULL || event_device =3D=3D NULL)
> +		return -EINVAL;
> +
> +	data->chat =3D create_port(modem_device);
> +
> +	if (data->chat =3D=3D NULL)
>  		return -EIO;
> =

>  	g_at_chat_add_terminator(data->chat, "COMMAND NOT SUPPORT", -1, FALSE);
> @@ -120,6 +140,20 @@ static int huawei_enable(struct ofono_modem *modem)
>  	if (getenv("OFONO_AT_DEBUG"))
>  		g_at_chat_set_debug(data->chat, huawei_debug, NULL);
> =

> +	data->event =3D create_port(modem_device);
> +

Event port using the modem device again?

> +	if (data->event) {
> +		g_at_chat_cancel_all(data->event);
> +		g_at_chat_unregister_all(data->event);
> +	}
> +

You might want to unref event here instead of cfun_disable

Regards,
-Denis

--===============6244584684672069924==--

