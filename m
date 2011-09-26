Content-Type: multipart/mixed; boundary="===============6348989428716823753=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH -v3 04/23] sap: add support to connect the RFCOMM link
Date: Mon, 26 Sep 2011 13:57:04 -0500
Message-ID: <4E80CB00.9030103@gmail.com>
In-Reply-To: <1317058036-32641-4-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6348989428716823753==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 09/26/2011 12:26 PM, Gustavo F. Padovan wrote:
> From: "Gustavo F. Padovan" <padovan@profusion.mobi>
> =

> ---
>  plugins/sap.c |   45 ++++++++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 44 insertions(+), 1 deletions(-)
> =


Patch applied, but...

>  /* power up hardware */
>  static int sap_enable(struct ofono_modem *modem)
>  {
>  	struct sap_data *data =3D ofono_modem_get_data(modem);
> +	int status;
> +	const char *str =3D "sap";
> +
> +	DBG("%p", modem);
> +
> +	status =3D bluetooth_send_with_reply(data->server_path,
> +					BLUEZ_SERIAL_INTERFACE, "ConnectFD",
> +					sap_connect_reply, modem, NULL,
> +					DBUS_TIMEOUT, DBUS_TYPE_STRING,
> +					&str, DBUS_TYPE_INVALID);

I had to amend this part for it to compile

Regards,
-Denis

--===============6348989428716823753==--

