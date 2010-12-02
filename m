Content-Type: multipart/mixed; boundary="===============8230731347474567421=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/5] modem: add support to restore state when resetting
 the modem
Date: Thu, 02 Dec 2010 13:47:14 -0600
Message-ID: <4CF7F7C2.7000000@gmail.com>
In-Reply-To: <1290711740-27886-3-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8230731347474567421==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Gustavo,

> @@ -488,16 +465,18 @@ static void online_cb(const struct ofono_error *err=
or, void *data)
>  	DBusMessage *reply;
>  =

>  	if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR &&
> -			modem->modem_state =3D=3D MODEM_STATE_OFFLINE)
> +			modem->modem_state =3D=3D MODEM_STATE_OFFLINE) {
> +		modem_change_state(modem, MODEM_STATE_ONLINE);
> +
> +		if (!modem->pending)
> +			return;
> +

Fair enough...

>  		reply =3D dbus_message_new_method_return(modem->pending);
> -	else
> +	} else {
>  		reply =3D __ofono_error_failed(modem->pending);

But what about the error case?

> +	}
>  =

>  	__ofono_dbus_pending_reply(&modem->pending, reply);
> -
> -	if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR &&
> -			modem->modem_state =3D=3D MODEM_STATE_OFFLINE)
> -		modem_change_state(modem, MODEM_STATE_ONLINE);
>  }
>  =

>  static void offline_cb(const struct ofono_error *error, void *data)

Regards,
-Denis

--===============8230731347474567421==--

