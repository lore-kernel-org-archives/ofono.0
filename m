Content-Type: multipart/mixed; boundary="===============3309849911291734223=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH -v5 04/13] sap: enable SAP modem, when BlueZ replies
Date: Thu, 29 Sep 2011 10:54:16 -0500
Message-ID: <4E8494A8.2010805@gmail.com>
In-Reply-To: <1317245061-6312-4-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3309849911291734223==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Gustavo,

On 09/28/2011 04:24 PM, Gustavo F. Padovan wrote:
> From: "Gustavo F. Padovan" <padovan@profusion.mobi>
> =

> ---
>  plugins/sap.c |   22 ++++++++++++++++++----
>  1 files changed, 18 insertions(+), 4 deletions(-)
> =


Patch has been applied, one thing:

> diff --git a/plugins/sap.c b/plugins/sap.c
> index 28b07e7..850ed2f 100644
> --- a/plugins/sap.c
> +++ b/plugins/sap.c
> @@ -127,6 +127,7 @@ static void sap_connect_reply(DBusPendingCall *call, =
gpointer user_data)
>  	struct sap_data *data =3D ofono_modem_get_data(modem);
>  	DBusError derr;
>  	DBusMessage *reply;
> +	int fd, err;
>  =

>  	DBG("");
>  =

> @@ -138,16 +139,29 @@ static void sap_connect_reply(DBusPendingCall *call=
, gpointer user_data)
>  		goto done;
>  =

>  	dbus_error_init(&derr);
> -	if (!dbus_set_error_from_message(&derr, reply))
> +	if (dbus_set_error_from_message(&derr, reply)) {
> +
> +		DBG("Connect reply: %s", derr.message);
> +
> +		dbus_error_free(&derr);
>  		goto done;
> +	}
>  =

> -	DBG("Connect reply: %s", derr.message);
> +	if (!dbus_message_get_args(reply, NULL, DBUS_TYPE_UNIX_FD, &fd,
> +				DBUS_TYPE_INVALID))
> +		goto done;
>  =

> -	ofono_modem_set_powered(modem, FALSE);
> +	data->hw_modem =3D sap_hw_modem;
> +	data->sap_driver =3D sap_hw_driver;
>  =

> -	dbus_error_free(&derr);
> +	err =3D data->sap_driver->enable(data->hw_modem, modem, fd);
> +	if (err =3D=3D -EINPROGRESS) {
> +		dbus_message_unref(reply);
> +		return;
> +	}

If enable fails, what should be done to the fd we got from bluetoothd?

>  =

>  done:
> +	ofono_modem_set_powered(modem, FALSE);
>  	dbus_message_unref(reply);
>  }
>  =


Regards,
-Denis

--===============3309849911291734223==--

