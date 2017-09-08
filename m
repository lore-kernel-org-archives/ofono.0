Content-Type: multipart/mixed; boundary="===============9087927797108979688=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 7/7] gobi: add location-reporting atom
Date: Fri, 08 Sep 2017 14:05:03 -0500
Message-ID: <953521bf-0de6-2cfe-50b9-fb8c2ef70331@gmail.com>
In-Reply-To: <20170908024040.31418-7-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9087927797108979688==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 09/07/2017 09:40 PM, Jonas Bonn wrote:
> This patch is submitted as a request for advice:  where should these
> changes go???
> =

> The patch is required for Quectel QMI modems to get location-reporting
> working:  the 'aux' AT interface needs to be set up and passed to the
> location-reporting atom.  But this is very Quectel specific and has nothi=
ng
> to do with Gobi at all.
> =

> So what's the best approach here...?

How do the other QMI vendors do this? E.g. Huawei, Sierra and Telit?

One idea might be to have udevng set the required properties and then =

have gobi.c enable location reporting.  e.g. something like:

aux =3D ofono_modem_get_string(modem, "Aux");
gps =3D ofono_modem_get_string(modem, "GPS");
gps_driver =3D ofono_modem_get_string(modem, "GpsDriver");

if (aux && gps && gps_driver) {
	/* open aux port */
	ofono_location_reporting_create(modem, 0, gps_driver, aux_chat);
}

> ---
>   plugins/gobi.c | 33 +++++++++++++++++++++++++++++++++
>   1 file changed, 33 insertions(+)
> =

> diff --git a/plugins/gobi.c b/plugins/gobi.c
> index bc2b068..962c947 100644
> --- a/plugins/gobi.c
> +++ b/plugins/gobi.c
> @@ -29,6 +29,10 @@
>   #include <unistd.h>
>   #include <stdlib.h>
>   =

> +#include <glib.h>
> +#include <gatchat.h>
> +#include <gattty.h>
> +

We need to be careful here because GOBI would in effect require ATMODEM =

to be enabled in the build...

>   #define OFONO_API_SUBJECT_TO_CHANGE
>   #include <ofono/plugin.h>
>   #include <ofono/modem.h>
> @@ -319,10 +323,18 @@ static void discover_cb(uint8_t count, const struct=
 qmi_version *list,
>   						create_dms_cb, modem, NULL);
>   }
>   =

> +static void q_debug(const char* str, void *user_data)
> +{
> +	const char* prefix =3D user_data;
> +
> +	ofono_info("%s%s", prefix, str);
> +}
> +
>   static int gobi_enable(struct ofono_modem *modem)
>   {
>   	struct gobi_data *data =3D ofono_modem_get_data(modem);
>   	const char *device;
> +	const char *gps, *aux;
>   	int fd;
>   =

>   	DBG("%p", modem);
> @@ -348,6 +360,27 @@ static int gobi_enable(struct ofono_modem *modem)
>   =

>   	qmi_device_discover(data->device, discover_cb, modem, NULL);
>   =

> +	aux =3D ofono_modem_get_string(modem, "Aux");
> +	gps =3D ofono_modem_get_string(modem, "GPS");
> +	DBG("aux =3D %s, gps =3D %s", aux, gps);
> +	if (aux && gps) {
> +		GAtChat *chat;
> +		GAtSyntax *syntax;
> +		GHashTable *options;
> +		GIOChannel *channel;
> +		DBG("Setting up location service");
> +		options =3D g_hash_table_new(g_str_hash, g_str_equal);
> +		g_hash_table_insert(options, "Baud", "115200");
> +		channel =3D g_at_tty_open(aux, options);
> +		syntax =3D g_at_syntax_new_gsm_permissive();
> +		chat =3D g_at_chat_new(channel, syntax);
> +		g_at_syntax_unref(syntax);
> +		g_io_channel_unref(channel);
> +		if (getenv("OFONO_AT_DEBUG"))
> +			g_at_chat_set_debug(chat, q_debug, "Aux: ");
> +		ofono_location_reporting_create(modem, 0, "quectelmodem", chat);

This should be done in pre_sim, not here...

> +	}
> +
>   	return -EINPROGRESS;
>   }
>   =

> =


Regards,
-Denis

--===============9087927797108979688==--

