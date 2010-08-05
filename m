Content-Type: multipart/mixed; boundary="===============4193208421586234754=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/5] Add dun_disable() to power down the modem
Date: Thu, 05 Aug 2010 10:43:50 -0500
Message-ID: <4C5ADC36.8010208@gmail.com>
In-Reply-To: <1280917334-4519-4-git-send-email-gustavo@padovan.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4193208421586234754==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Gustavo,

On 08/04/2010 05:22 AM, Gustavo F. Padovan wrote:
> When setting Powered to 0 the link rfcomm is disconnected.
> ---
>  plugins/dun.c |   42 ++++++++++++++++++++++++++++++++++++++++--
>  1 files changed, 40 insertions(+), 2 deletions(-)
> =

> diff --git a/plugins/dun.c b/plugins/dun.c
> index 60d0271..3d1e5c4 100644
> --- a/plugins/dun.c
> +++ b/plugins/dun.c
> @@ -203,10 +203,48 @@ static int dun_enable(struct ofono_modem *modem)
>  	return -EINPROGRESS;
>  }
>  =

> +static void dun_power_down(DBusPendingCall *call, gpointer user_data)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	struct dun_data *data =3D ofono_modem_get_data(modem);
> +	DBusMessage *reply;
> +	DBusError derr;
> +
> +	reply =3D dbus_pending_call_steal_reply(call);
> +
> +	dbus_error_init(&derr);
> +	if (dbus_set_error_from_message(&derr, reply)) {
> +		DBG("Disconnect reply: %s", derr.message);
> +		dbus_error_free(&derr);
> +		goto done;
> +	}
> +
> +	ofono_modem_set_powered(modem, FALSE);
> +
> +done:
> +	g_free(data->rfcomm);
> +
> +	dbus_message_unref(reply);
> +}
> +
>  static int dun_disable(struct ofono_modem *modem)
>  {
> -	DBG("%p", modem);
> -	return 0;
> +	struct dun_data *data =3D ofono_modem_get_data(modem);
> +	int status;
> +
> +	if (!ofono_modem_get_powered(modem))
> +		return 0;

Again, please don't do this part.  If the core messes up, I want to know
early.

> +
> +	status =3D bluetooth_send_with_reply(data->dun_path,
> +				BLUEZ_SERIAL_INTERFACE, "Disconnect",
> +				dun_power_down, modem, NULL, DBUS_TIMEOUT,
> +				DBUS_TYPE_STRING, &data->rfcomm,
> +				DBUS_TYPE_INVALID);
> +
> +	if (status < 0)
> +		return -EINVAL;
> +
> +	return -EINPROGRESS;
>  }
>  =

>  static struct ofono_modem_driver dun_driver =3D {

Regards,
-Denis

--===============4193208421586234754==--

