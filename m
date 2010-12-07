Content-Type: multipart/mixed; boundary="===============5534630634412313203=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH -v3 5/5] modem: add support to restore state when
 resetting the modem
Date: Mon, 06 Dec 2010 21:48:48 -0600
Message-ID: <4CFDAEA0.6000408@gmail.com>
In-Reply-To: <1291402377-9211-5-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5534630634412313203==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Gustavo,

> @@ -488,16 +465,22 @@ static void online_cb(const struct ofono_error *err=
or, void *data)
>  	DBusMessage *reply;
>  =

>  	if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR &&
> -			modem->modem_state =3D=3D MODEM_STATE_OFFLINE)
> +			modem->modem_state =3D=3D MODEM_STATE_OFFLINE) {
> +		modem_change_state(modem, MODEM_STATE_ONLINE);

This actually breaks the (yet unwritten) rule to try to return from the
method call before signaling the property changed.

Can you leave this be and add something like:

if (modem->pending =3D=3D NULL)
	goto out;

or something prior to this if condition?

> +
> +		if (!modem->pending)
> +			return;
> +

Then you can omit this

>  		reply =3D dbus_message_new_method_return(modem->pending);
> -	else
> +	} else {
> +
> +		if (!modem->pending)
> +			return;
> +

And this

>  		reply =3D __ofono_error_failed(modem->pending);
> +	}
>  =

>  	__ofono_dbus_pending_reply(&modem->pending, reply);

And just add a label here...

> -
> -	if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR &&
> -			modem->modem_state =3D=3D MODEM_STATE_OFFLINE)
> -		modem_change_state(modem, MODEM_STATE_ONLINE);
>  }
>  =

>  static void offline_cb(const struct ofono_error *error, void *data)

Regards,
-Denis

--===============5534630634412313203==--

