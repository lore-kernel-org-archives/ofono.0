Content-Type: multipart/mixed; boundary="===============2467129352875108545=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/3] sim800: add support for sim800 modem.
Date: Thu, 01 Nov 2018 09:53:58 -0500
Message-ID: <412dac97-dea0-efa5-eda2-e79aa569b99e@gmail.com>
In-Reply-To: <1539624449-12221-1-git-send-email-vielclement@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2467129352875108545==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Clement,

On 10/15/2018 12:27 PM, Clement Viel wrote:
> ---
>   plugins/sim900.c | 89 +++++++++++++++++++++++++++++++++++++++++++++++++=
+------
>   1 file changed, 80 insertions(+), 9 deletions(-)
> =

> diff --git a/plugins/sim900.c b/plugins/sim900.c
> index a7728cd..9f3f334 100644
> --- a/plugins/sim900.c
> +++ b/plugins/sim900.c
> @@ -24,6 +24,7 @@
>   #endif
>   =

>   #include <errno.h>
> +#include <string.h>
>   #include <stdlib.h>
>   #include <glib.h>
>   #include <gatchat.h>
> @@ -60,13 +61,59 @@ static char *dlc_prefixes[NUM_DLC] =3D { "Voice: ", "=
Net: ", "SMS: ",
>   =

>   static const char *none_prefix[] =3D { NULL };
>   =

> +typedef enum type {
> +	SIM800,
> +	SIM900,
> +	SIM_UNKNOWN,
> +} type_t;
> +
>   struct sim900_data {
>   	GIOChannel *device;
>   	GAtMux *mux;
>   	GAtChat * dlcs[NUM_DLC];
>   	guint frame_size;
> +	type_t modem_type;
>   };
>   =

> +static void set_modem_type (struct ofono_modem *modem)
> +{
> +	struct sim900_data *data =3D ofono_modem_get_data(modem);
> +	const char *path =3D ofono_modem_get_path(modem);
> +
> +	if (strstr(path, "sim800"))
> +		data->modem_type =3D SIM800;
> +	else if (strstr(path, "sim900"))
> +		data->modem_type =3D SIM900;
> +	else
> +		data->modem_type =3D SIM_UNKNOWN;
> +

You can't really rely on the modem path for this.  Either query the =

model directly or set the type based on the driver selected.

And no empty lines at the end of the function please

> +}
> +
> +static void mux_ready_notify(GAtResult *result, gpointer user_data)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	struct sim900_data *data =3D ofono_modem_get_data(modem);
> +	struct ofono_gprs *gprs =3D NULL;
> +	struct ofono_gprs_context *gc;
> +	static int notified =3D 0;
> +
> +	if (!notified) {
> +	ofono_sms_create(modem, OFONO_VENDOR_SIMCOM, "atmodem",
> +						data->dlcs[SMS_DLC]);
> +
> +
> +	gprs =3D ofono_gprs_create(modem, 0, "atmodem", data->dlcs[GPRS_DLC]);
> +	if (gprs =3D=3D NULL)
> +		return;
> +
> +	gc =3D ofono_gprs_context_create(modem, OFONO_VENDOR_SIMCOM,
> +					"atmodem", data->dlcs[GPRS_DLC]);
> +	if (gc)
> +		ofono_gprs_add_context(gprs, gc);
> +	}
> +

The indentation and stule is all wrong here.

> +}
> +
>   static int sim900_probe(struct ofono_modem *modem)
>   {
>   	struct sim900_data *data;
> @@ -79,6 +126,7 @@ static int sim900_probe(struct ofono_modem *modem)
>   =

>   	ofono_modem_set_data(modem, data);
>   =

> +	set_modem_type(modem);
>   	return 0;
>   }
>   =

> @@ -111,6 +159,7 @@ static GAtChat *open_device(struct ofono_modem *modem,
>   	GHashTable *options;
>   =

>   	device =3D ofono_modem_get_string(modem, key);
> +

This change is spurious and should not be part of this commit

>   	if (device =3D=3D NULL)
>   		return NULL;
>   =

> @@ -232,6 +281,11 @@ static void setup_internal_mux(struct ofono_modem *m=
odem)
>   			goto error;
>   		}
>   	}
> +	if (data->modem_type =3D=3D SIM800) {
> +		for (i =3D 0; i<NUM_DLC; i++) {
> +			g_at_chat_register(data->dlcs[i], "SMS Ready", mux_ready_notify, FALS=
E, modem, NULL);
> +		}
> +	}

Why do you want this notification on all ports?  Isn't one enough?

>   =

>   	ofono_modem_set_powered(modem, TRUE);
>   =

> @@ -353,18 +407,20 @@ static void sim900_post_sim(struct ofono_modem *mod=
em)
>   =

>   	DBG("%p", modem);
>   =

> -	ofono_phonebook_create(modem, 0, "atmodem", data->dlcs[VOICE_DLC]);
> -	ofono_sms_create(modem, OFONO_VENDOR_SIMCOM, "atmodem",
> +	if (data->modem_type !=3D SIM800) {
> +		ofono_phonebook_create(modem, 0, "atmodem", data->dlcs[VOICE_DLC]);
> +		ofono_sms_create(modem, OFONO_VENDOR_SIMCOM, "atmodem",
>   						data->dlcs[SMS_DLC]);
>   =

> -	gprs =3D ofono_gprs_create(modem, 0, "atmodem", data->dlcs[GPRS_DLC]);
> -	if (gprs =3D=3D NULL)
> -		return;
> +		gprs =3D ofono_gprs_create(modem, 0, "atmodem", data->dlcs[GPRS_DLC]);
> +		if (gprs =3D=3D NULL)
> +			return;
>   =

> -	gc =3D ofono_gprs_context_create(modem, OFONO_VENDOR_SIMCOM_SIM900,
> +		gc =3D ofono_gprs_context_create(modem, OFONO_VENDOR_SIMCOM_SIM900,
>   					"atmodem", data->dlcs[GPRS_DLC]);
> -	if (gc)
> -		ofono_gprs_add_context(gprs, gc);
> +		if (gc)
> +			ofono_gprs_add_context(gprs, gc);
> +	}

Som SIM800 doesn't get any of these atoms?

>   }
>   =

>   static void sim900_post_online(struct ofono_modem *modem)
> @@ -391,9 +447,24 @@ static struct ofono_modem_driver sim900_driver =3D {
>   	.post_online	=3D sim900_post_online,
>   };
>   =

> +
> +static struct ofono_modem_driver sim800_driver =3D {
> +	.name		=3D "sim800",
> +	.probe		=3D sim900_probe,
> +	.remove		=3D sim900_remove,
> +	.enable		=3D sim900_enable,
> +	.disable	=3D sim900_disable,
> +	.pre_sim	=3D sim900_pre_sim,
> +	.post_sim	=3D sim900_post_sim,
> +	.post_online	=3D sim900_post_online,
> +};
> +
>   static int sim900_init(void)
>   {
> -	return ofono_modem_driver_register(&sim900_driver);
> +	int ret =3D 0;
> +	ret =3D ofono_modem_driver_register(&sim800_driver);
> +	ret +=3D ofono_modem_driver_register(&sim900_driver);
> +	return ret;

This doesn't really work this way.  The init function should either =

register all drivers successfully or fail.

>   }
>   =

>   static void sim900_exit(void)
> =


Regards,
-Denis

--===============2467129352875108545==--

