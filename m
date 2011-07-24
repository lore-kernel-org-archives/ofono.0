Content-Type: multipart/mixed; boundary="===============7486319111720970656=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] huaweicdma: open 2 ttys, to use a dedicated one for PPP.
Date: Sun, 24 Jul 2011 16:43:26 +0200
Message-ID: <1311518612.7970.5.camel@aeonflux>
In-Reply-To: <1311489023-10274-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7486319111720970656==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bertrand,

>  plugins/huaweicdma.c |  160 ++++++++++++++++++++++++++++++++++++++++++--=
-----
>  1 files changed, 137 insertions(+), 23 deletions(-)
> =

> diff --git a/plugins/huaweicdma.c b/plugins/huaweicdma.c
> index 4f45fec..be43bd7 100644
> --- a/plugins/huaweicdma.c
> +++ b/plugins/huaweicdma.c
> @@ -23,7 +23,6 @@
>  #include <config.h>
>  #endif
>  =

> -#include <stdio.h>
>  #include <errno.h>
>  #include <stdlib.h>
>  =

> @@ -38,10 +37,12 @@
>  #include <ofono/cdma-connman.h>
>  #include <ofono/log.h>
>  =

> -#include <drivers/atmodem/atutil.h>
> +static const char *none_prefix[] =3D { NULL };

please separate cleanup patches from code changes.
 =

>  struct huaweicdma_data {
> -	GAtChat *chat;
> +	GAtChat *modem;
> +	GAtChat *pcui;
> +	struct ofono_cdma_connman *cm;

What is this for? You should not need it.

>  };
>  =

>  static void huaweicdma_debug(const char *str, void *data)
> @@ -74,39 +75,140 @@ static void huaweicdma_remove(struct ofono_modem *mo=
dem)
>  =

>  	ofono_modem_set_data(modem, NULL);
>  =

> -	g_at_chat_unref(data->chat);
> -
>  	g_free(data);
>  }
>  =

> -static int huaweicdma_enable(struct ofono_modem *modem)
> +static void cfun_enable(gboolean ok, GAtResult *result, gpointer user_da=
ta)
>  {
> +	struct ofono_modem *modem =3D user_data;
>  	struct huaweicdma_data *data =3D ofono_modem_get_data(modem);
> +
> +	DBG("");
> +
> +	if (!ok) {
> +		g_at_chat_unref(data->modem);
> +		data->modem =3D NULL;
> +
> +
> +		g_at_chat_unref(data->pcui);
> +		data->pcui =3D NULL;
> +
> +		ofono_modem_set_powered(modem, FALSE);
> +		return;
> +	}
> +
> +	ofono_modem_set_powered(modem, TRUE);
> +}
> +
> +static GAtChat *create_port(const char *device)
> +{
>  	GAtSyntax *syntax;
>  	GIOChannel *channel;
> -	const char *device;
> -
> -	device =3D ofono_modem_get_string(modem, "Device");
> -	if (device =3D=3D NULL)
> -		return -EINVAL;
> +	GAtChat *chat;
>  =

>  	channel =3D g_at_tty_open(device, NULL);
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
>  =

>  	if (getenv("OFONO_AT_DEBUG"))
> -		g_at_chat_set_debug(data->chat, huaweicdma_debug, "Device: ");
> +		g_at_chat_set_debug(chat, huaweicdma_debug, debug);
>  =

> -	return 0;
> +	return chat;
> +}
> +
> +static void huaweicdma_disconnect(gpointer user_data)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	struct huaweicdma_data *data =3D ofono_modem_get_data(modem);
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
> +						huaweicdma_disconnect, modem);
> +
> +	data->cm =3D ofono_cdma_connman_create(modem, 0, "cdmamodem",
> +					data->modem);
> +}

When using AT&C0, then this should not be needed anymore. I tested this
will all my Huwei dongles that I had around and it just worked nicely.
No more stupid TTY hangup. You can nicely switch between AT command and
PPP mode.

> +static int huaweicdma_enable(struct ofono_modem *modem)
> +{
> +	struct huaweicdma_data *data =3D ofono_modem_get_data(modem);
> +
> +	DBG("");
> +
> +	data->modem =3D open_device(modem, "Modem", "Modem: ");
> +	if (data->modem =3D=3D NULL)
> +		return -EINVAL;
> +
> +	g_at_chat_set_disconnect_function(data->modem,
> +						huaweicdma_disconnect, modem);
> +
> +	data->pcui =3D open_device(modem, "Pcui", "PCUI: ");
> +	if (data->pcui =3D=3D NULL) {
> +		g_at_chat_unref(data->modem);
> +		data->modem =3D NULL;
> +		return -EIO;
> +	}
> +
> +	g_at_chat_send(data->pcui, "ATE0 +CMEE=3D1", none_prefix,
> +						NULL, NULL, NULL);
> +
> +	g_at_chat_send(data->pcui, "AT+CFUN=3D1", none_prefix,
> +					cfun_enable, modem, NULL);
> +
> +	return -EINPROGRESS;
> +}
> +
> +static void cfun_disable(gboolean ok, GAtResult *result, gpointer user_d=
ata)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	struct huaweicdma_data *data =3D ofono_modem_get_data(modem);
> +
> +	DBG("");
> +
> +	g_at_chat_unref(data->pcui);
> +	data->pcui =3D NULL;
> +
> +	if (ok)
> +		ofono_modem_set_powered(modem, FALSE);
>  }
>  =

>  static int huaweicdma_disable(struct ofono_modem *modem)
> @@ -115,10 +217,22 @@ static int huaweicdma_disable(struct ofono_modem *m=
odem)
>  =

>  	DBG("%p", modem);
>  =

> -	g_at_chat_unref(data->chat);
> -	data->chat =3D NULL;
> +	if (data->modem) {
> +		g_at_chat_cancel_all(data->modem);
> +		g_at_chat_unregister_all(data->modem);
> +		g_at_chat_unref(data->modem);
> +		data->modem =3D NULL;
> +	}
>  =

> -	return 0;
> +	if (data->pcui =3D=3D NULL)
> +		return 0;
> +
> +	g_at_chat_cancel_all(data->pcui);
> +	g_at_chat_unregister_all(data->pcui);
> +	g_at_chat_send(data->pcui, "AT+CFUN=3D0", none_prefix,
> +					cfun_disable, modem, NULL);
> +
> +	return -EINPROGRESS;
>  }
>  =

>  static void huaweicdma_pre_sim(struct ofono_modem *modem)
> @@ -127,7 +241,7 @@ static void huaweicdma_pre_sim(struct ofono_modem *mo=
dem)
>  =

>  	DBG("%p", modem);
>  =

> -	ofono_devinfo_create(modem, 0, "cdmamodem", data->chat);
> +	ofono_devinfo_create(modem, 0, "cdmamodem", data->pcui);
>  }
>  =

>  static void huaweicdma_post_sim(struct ofono_modem *modem)
> @@ -141,7 +255,7 @@ static void huaweicdma_post_online(struct ofono_modem=
 *modem)
>  =

>  	DBG("%p", modem);
>  =

> -	ofono_cdma_connman_create(modem, 0, "cdmamodem", data->chat);
> +	data->cm =3D ofono_cdma_connman_create(modem, 0, "cdmamodem", data->mod=
em);
>  }
>  =

>  static struct ofono_modem_driver huaweicdma_driver =3D {

Regards

Marcel



--===============7486319111720970656==--

