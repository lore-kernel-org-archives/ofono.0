Content-Type: multipart/mixed; boundary="===============4244868589750575644=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/4] plugins/ublox: Enable serial connection for an ublox
 modem
Date: Fri, 31 May 2019 10:35:22 -0500
Message-ID: <45d85a10-63ba-8b78-56ee-3ebf29f3fb51@gmail.com>
In-Reply-To: <20190531114421.21092-3-philippe.deswert@digitalistgroup.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4244868589750575644==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On 05/31/2019 06:44 AM, Philippe De Swert wrote:
> Some ublox modems can be connected over a serial port. Add support
> for this connection method.
> ---
>   plugins/ublox.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 54 insertions(+), 1 deletion(-)
> =

> diff --git a/plugins/ublox.c b/plugins/ublox.c
> index 1ca0030a..a2ed8133 100644
> --- a/plugins/ublox.c
> +++ b/plugins/ublox.c
> @@ -129,6 +129,59 @@ static GAtChat *open_device(struct ofono_modem *mode=
m,
>   	return chat;
>   }
>   =

> +static GAtChat *open_serial_device(struct ofono_modem *modem,
> +                                const char *key, char *debug)
> +{
> +	DBG(" open_serial_device %p", modem);
> +
> +        const char *device;
> +        GAtSyntax *syntax;
> +        GIOChannel *channel;
> +        GAtChat *chat;
> +        GHashTable *options;
> +
> +        device =3D ofono_modem_get_string(modem, key);
> +        if (device =3D=3D NULL)
> +        {
> +                DBG("device =3D NULL");
> +                return NULL;
> +        }
> +        DBG("%s %s", key, device);
> +
> +        options =3D g_hash_table_new(g_str_hash, g_str_equal);
> +        if (options =3D=3D NULL)
> +                return NULL;
> +
> +        g_hash_table_insert(options, "Baud", "115200");
> +        g_hash_table_insert(options, "Parity", "none");
> +        g_hash_table_insert(options, "StopBits", "1");
> +        g_hash_table_insert(options, "DataBits", "8");
> +        g_hash_table_insert(options, "XonXoff", "on");
> +        g_hash_table_insert(options, "Local", "on");
> +        g_hash_table_insert(options, "RtsCts", "off");
> +        g_hash_table_insert(options, "Read", "on");
> +
> +        channel =3D g_at_tty_open(device, options);
> +        g_hash_table_destroy(options);
> +
> +        if (channel =3D=3D NULL)
> +                return NULL;
> +
> +        syntax =3D g_at_syntax_new_gsm_permissive();
> +        chat =3D g_at_chat_new(channel, syntax);
> +        g_at_syntax_unref(syntax);
> +
> +        g_io_channel_unref(channel);
> +
> +        if (chat =3D=3D NULL)
> +                return NULL;
> +
> +        if (getenv("OFONO_AT_DEBUG"))
> +                g_at_chat_set_debug(chat, ublox_debug, debug);
> +
> +        return chat;
> +}
> +

Your indentation and coding style is all wrong here.

>   static void cfun_enable(gboolean ok, GAtResult *result, gpointer user_d=
ata)
>   {
>   	struct ofono_modem *modem =3D user_data;
> @@ -261,7 +314,7 @@ static int ublox_enable(struct ofono_modem *modem)
>   	 * the 'Device' attribute instead...
>   	 */
>   	if (data->aux =3D=3D NULL) {
> -		data->aux =3D open_device(modem, "Device", "Aux: ");
> +		data->aux =3D open_serial_device(modem, "Device", "Aux: ");

Tell me how you're driving a serial device without setting up a multiplexer.

>   		if (data->aux =3D=3D NULL)
>   			return -EINVAL;
>   	}
> =


Regards,
-Denis

--===============4244868589750575644==--

