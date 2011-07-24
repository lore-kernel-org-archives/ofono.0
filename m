Content-Type: multipart/mixed; boundary="===============0385383407790929763=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] speedupcdma: open 2 ttys, to use a dedicated one for PPP.
Date: Sun, 24 Jul 2011 16:49:38 +0200
Message-ID: <1311518980.7970.9.camel@aeonflux>
In-Reply-To: <1311489112-10550-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0385383407790929763==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bertrand,

>  plugins/speedupcdma.c |  135 ++++++++++++++++++++++++++++++++++++++-----=
------
>  1 files changed, 105 insertions(+), 30 deletions(-)
> =

> diff --git a/plugins/speedupcdma.c b/plugins/speedupcdma.c
> index b7e54a1..88f68f5 100644
> --- a/plugins/speedupcdma.c
> +++ b/plugins/speedupcdma.c
> @@ -23,7 +23,6 @@
>  #include <config.h>
>  #endif
>  =

> -#include <stdio.h>
>  #include <errno.h>
>  #include <stdlib.h>
>  =

> @@ -38,12 +37,12 @@
>  #include <ofono/cdma-connman.h>
>  #include <ofono/log.h>
>  =

> -#include <drivers/atmodem/atutil.h>
> -
>  static const char *none_prefix[] =3D { NULL };
>  =

>  struct speedupcdma_data {
> -	GAtChat *chat;
> +	GAtChat *modem;
> +	GAtChat *aux;
> +	struct ofono_cdma_connman *cm;

leave this magic disconnect handling out for now. It does not work
anyway, so why bother. This would also make the patch more readable.

>  };
>  =

>  static void speedupcdma_debug(const char *str, void *data)
> @@ -87,8 +86,12 @@ static void cfun_enable(gboolean ok, GAtResult *result=
, gpointer user_data)
>  	DBG("");
>  =

>  	if (!ok) {
> -		g_at_chat_unref(data->chat);
> -		data->chat =3D NULL;
> +		g_at_chat_unref(data->modem);
> +		data->modem =3D NULL;
> +
> +

No need for double empty lines.

> +		g_at_chat_unref(data->aux);
> +		data->aux =3D NULL;
>  =

>  		ofono_modem_set_powered(modem, FALSE);
>  		return;
> @@ -97,39 +100,98 @@ static void cfun_enable(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
>  	ofono_modem_set_powered(modem, TRUE);
>  }
>  =

> -static int speedupcdma_enable(struct ofono_modem *modem)
> +static GAtChat *create_port(const char *device)
>  {
> -	struct speedupcdma_data *data =3D ofono_modem_get_data(modem);
>  	GAtSyntax *syntax;
>  	GIOChannel *channel;
> -	const char *modem_path;
> -
> -	modem_path =3D ofono_modem_get_string(modem, "Modem");
> -	if (modem_path =3D=3D NULL)
> -		return -EINVAL;
> -
> -	DBG("path is: %s", modem_path);
> +	GAtChat *chat;
>  =

> -	channel =3D g_at_tty_open(modem_path, NULL);
> +	channel =3D g_at_tty_open(device, NULL);
>  	if (channel =3D=3D NULL)
> -		return -EIO;
> +		return NULL;
>  =

>  	syntax =3D g_at_syntax_new_gsm_permissive();
> -	data->chat =3D g_at_chat_new(channel, syntax);
> +	chat =3D g_at_chat_new(channel, syntax);
>  	g_at_syntax_unref(syntax);
> -
>  	g_io_channel_unref(channel);
>  =

> -	if (data->chat =3D=3D NULL)
> -		return -ENOMEM;
> +	if (chat =3D=3D NULL)
> +		return NULL;
> +
> +	return chat;
> +}
> +
> +static GAtChat *open_device(struct ofono_modem *modem,
> +				const char *key, char *debug)
> +{
> +	const char *device;
> +	GAtChat *chat;
> +
> +	device =3D ofono_modem_get_string(modem, key);
> +	if (device =3D=3D NULL)
> +		return NULL;
> +
> +	DBG("%s %s", key, device);
> +
> +	chat =3D create_port(device);
> +	if (chat =3D=3D NULL)
> +		return NULL;
> +
> +	g_at_chat_add_terminator(chat, "COMMAND NOT SUPPORT", -1, FALSE);

This is normally Huawei specific. Have you also seen this with SpeedUp
dongles?
 =

>  	if (getenv("OFONO_AT_DEBUG"))
> -		g_at_chat_set_debug(data->chat, speedupcdma_debug, "Modem: ");
> +		g_at_chat_set_debug(chat, speedupcdma_debug, debug);
> +
> +	return chat;
> +}
> +
> +static void speedupcdma_disconnect(gpointer user_data)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	struct speedupcdma_data *data =3D ofono_modem_get_data(modem);
> +
> +	DBG("");
> +
> +	ofono_cdma_connman_remove(data->cm);
> +
> +	g_at_chat_unref(data->modem);
> +	data->modem =3D NULL;
> +
> +	data->modem =3D open_device(modem, "Modem", "Modem: ");
> +	if (data->modem =3D=3D NULL)
> +		return;
> +
> +	g_at_chat_set_disconnect_function(data->modem,
> +						speedupcdma_disconnect, modem);

As mentioned above, leave this out. We can patch this later if we need
it or if we get this working.

> +
> +	data->cm =3D ofono_cdma_connman_create(modem, 0, "cdmamodem",
> +					data->modem);
> +}
> +
> +static int speedupcdma_enable(struct ofono_modem *modem)
> +{
> +	struct speedupcdma_data *data =3D ofono_modem_get_data(modem);
> +
> +	DBG("");
> +
> +	data->modem =3D open_device(modem, "Modem", "Modem: ");
> +	if (data->modem =3D=3D NULL)
> +		return -EINVAL;
> +
> +	g_at_chat_set_disconnect_function(data->modem,
> +						speedupcdma_disconnect, modem);
>  =

> -	g_at_chat_send(data->chat, "ATE0 +CMEE=3D1", none_prefix,
> +	data->aux =3D open_device(modem, "Aux", "Aux: ");
> +	if (data->aux =3D=3D NULL) {
> +		g_at_chat_unref(data->modem);
> +		data->modem =3D NULL;
> +		return -EIO;
> +	}
> +
> +	g_at_chat_send(data->aux, "ATE0 +CMEE=3D1", none_prefix,
>  						NULL, NULL, NULL);
>  =

> -	g_at_chat_send(data->chat, "AT+CFUN=3D1", none_prefix,
> +	g_at_chat_send(data->aux, "AT+CFUN=3D1", none_prefix,
>  					cfun_enable, modem, NULL);
>  =

>  	return -EINPROGRESS;
> @@ -142,8 +204,8 @@ static void cfun_disable(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
>  =

>  	DBG("");
>  =

> -	g_at_chat_unref(data->chat);
> -	data->chat =3D NULL;
> +	g_at_chat_unref(data->aux);
> +	data->aux =3D NULL;
>  =

>  	if (ok)
>  		ofono_modem_set_powered(modem, FALSE);
> @@ -155,7 +217,19 @@ static int speedupcdma_disable(struct ofono_modem *m=
odem)
>  =

>  	DBG("%p", modem);
>  =

> -	g_at_chat_send(data->chat, "AT+CFUN=3D0", none_prefix,
> +	if (data->modem) {
> +		g_at_chat_cancel_all(data->modem);
> +		g_at_chat_unregister_all(data->modem);
> +		g_at_chat_unref(data->modem);
> +		data->modem =3D NULL;
> +	}
> +
> +	if (data->aux =3D=3D NULL)
> +		return 0;
> +
> +	g_at_chat_cancel_all(data->aux);
> +	g_at_chat_unregister_all(data->aux);
> +	g_at_chat_send(data->aux, "AT+CFUN=3D0", none_prefix,
>  					cfun_disable, modem, NULL);
>  =

>  	return -EINPROGRESS;
> @@ -167,7 +241,7 @@ static void speedupcdma_pre_sim(struct ofono_modem *m=
odem)
>  =

>  	DBG("%p", modem);
>  =

> -	ofono_devinfo_create(modem, 0, "cdmamodem", data->chat);
> +	ofono_devinfo_create(modem, 0, "cdmamodem", data->aux);
>  }
>  =

>  static void speedupcdma_post_sim(struct ofono_modem *modem)
> @@ -181,7 +255,8 @@ static void speedupcdma_post_online(struct ofono_mode=
m *modem)
>  =

>  	DBG("%p", modem);
>  =

> -	ofono_cdma_connman_create(modem, 0, "cdmamodem", data->chat);
> +	data->cm =3D ofono_cdma_connman_create(modem, 0, "cdmamodem",
> +					data->modem);
>  }
>  =

>  static struct ofono_modem_driver speedupcdma_driver =3D {
> @@ -207,4 +282,4 @@ static void speedupcdma_exit(void)
>  =

>  OFONO_PLUGIN_DEFINE(speedupcdma, "Speed Up CDMA modem driver", VERSION,
>  				OFONO_PLUGIN_PRIORITY_DEFAULT,
> -				speedupcdma_init, speedupcdma_exit)
> +				speedupcdma_init, speedupcdma_exit)
> \ No newline at end of file

No idea what is happening here???

Regards

Marcel



--===============0385383407790929763==--

