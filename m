Content-Type: multipart/mixed; boundary="===============6541610586881173622=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: Re: [PATCH 1/3] sim800: add support for sim800 modem.
Date: Wed, 07 Nov 2018 14:47:19 +0100
Message-ID: <26fd849c-37ca-7706-431c-782ff0c8a015@norrbonn.se>
In-Reply-To: <1541585670-3551-1-git-send-email-vielclement@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6541610586881173622==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Clement,

On 07/11/2018 11:14, Clement Viel wrote:
> ---
>   plugins/sim900.c | 108 ++++++++++++++++++++++++++++++++++++++++++++++++=
+------
>   1 file changed, 98 insertions(+), 10 deletions(-)
> =

> diff --git a/plugins/sim900.c b/plugins/sim900.c
> index a7728cd..c12576d 100644
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
> @@ -60,13 +61,73 @@ static char *dlc_prefixes[NUM_DLC] =3D { "Voice: ", "=
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

type_t is not a great name... furthermore, I don't think ofono wants =

typedef'd enums.  Just use:  enum simcom_model {...} or similar.

>   struct sim900_data {
>   	GIOChannel *device;
>   	GAtMux *mux;
>   	GAtChat * dlcs[NUM_DLC];
>   	guint frame_size;
> +	type_t modem_type;
>   };
>   =

> +static void set_modem_type (const char *type, struct ofono_modem *modem)
> +{
> +	struct sim900_data *data =3D ofono_modem_get_data(modem);
> +
> +	if (strcmp(type, "sim800") =3D=3D 0)
> +		data->modem_type =3D SIM800;
> +	else if (strcmp(type, "sim900") =3D=3D 0)
> +		data->modem_type =3D SIM900;
> +	else
> +		data->modem_type =3D SIM_UNKNOWN;
> +	DBG("modem type is %d",data->modem_type);
> +}
> +

This function is unnecessary... see below.

> +static void mux_ready_notify(GAtResult *result, gpointer user_data)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	struct sim900_data *data =3D ofono_modem_get_data(modem);
> +	struct ofono_gprs *gprs =3D NULL;
> +	struct ofono_gprs_context *gc;
> +
> +	ofono_sms_create(modem, OFONO_VENDOR_SIMCOM, "atmodem",
> +				data->dlcs[SMS_DLC]);
> +
> +	gprs =3D ofono_gprs_create(modem, 0, "atmodem", data->dlcs[GPRS_DLC]);
> +	if (gprs =3D=3D NULL)
> +		return;
> +
> +	gc =3D ofono_gprs_context_create(modem, OFONO_VENDOR_SIMCOM,
> +					"atmodem", data->dlcs[GPRS_DLC]);
> +	if (gc)
> +		ofono_gprs_add_context(gprs, gc);
> +
> +}
> +
> +static void check_model(gboolean ok, GAtResult *result, gpointer user_da=
ta)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	GAtResultIter iter;
> +	char const *model;
> +
> +	g_at_result_iter_init(&iter, result);
> +
> +	while (g_at_result_iter_next(&iter, NULL)) {
> +		if (!g_at_result_iter_next_unquoted_string(&iter, &model))
> +			continue;
> +
> +		if (strstr(model, "SIM800"))
> +			set_modem_type("sim800", modem);
> +		else if (strstr(model, "SIM900"))
> +			set_modem_type("sim900", modem);

Just set the type directly here... no need to pass an arbitrary string =

through a secondary function to accomplish that.

Furthermore, the result is exactly "SIM800" or "SIM900", right?  No need =

for strstr, use strcmp.

> +	}
> +}
> +
>   static int sim900_probe(struct ofono_modem *modem)
>   {
>   	struct sim900_data *data;
> @@ -78,7 +139,6 @@ static int sim900_probe(struct ofono_modem *modem)
>   		return -ENOMEM;
>   =

>   	ofono_modem_set_data(modem, data);
> -
>   	return 0;
>   }
>   =

> @@ -111,6 +171,7 @@ static GAtChat *open_device(struct ofono_modem *modem,
>   	GHashTable *options;
>   =

>   	device =3D ofono_modem_get_string(modem, key);
> +
>   	if (device =3D=3D NULL)
>   		return NULL;
>   =

> @@ -232,6 +293,11 @@ static void setup_internal_mux(struct ofono_modem *m=
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
>   =

>   	ofono_modem_set_powered(modem, TRUE);
>   =

> @@ -294,6 +360,7 @@ static int sim900_enable(struct ofono_modem *modem)
>   		return -EINVAL;
>   =

>   	g_at_chat_send(data->dlcs[SETUP_DLC], "ATE0", NULL, NULL, NULL, NULL);
> +	g_at_chat_send(data->dlcs[SETUP_DLC], "AT+CGMM", NULL,check_model, mode=
m, NULL);
>   =

>   	/* For obtain correct sms service number */
>   	g_at_chat_send(data->dlcs[SETUP_DLC], "AT+CSCS=3D\"GSM\"", NULL,
> @@ -353,18 +420,20 @@ static void sim900_post_sim(struct ofono_modem *mod=
em)
>   =

>   	DBG("%p", modem);
>   =

> -	ofono_phonebook_create(modem, 0, "atmodem", data->dlcs[VOICE_DLC]);
> -	ofono_sms_create(modem, OFONO_VENDOR_SIMCOM, "atmodem",
> +	if (data->modem_type !=3D SIM800) {

How about "=3D=3D SIM900" because that's what this is for.

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
>   }
>   =

>   static void sim900_post_online(struct ofono_modem *modem)
> @@ -391,9 +460,28 @@ static struct ofono_modem_driver sim900_driver =3D {
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

This is identical to the sim900_driver.

Your driver is already taking into account the modem model and adjusting =

functionality accordingly.  You don't need to specify a new driver for =

the sim800 where the only thing that changes is the name.

> +
>   static int sim900_init(void)
>   {
> -	return ofono_modem_driver_register(&sim900_driver);
> +	int ret =3D 0;
> +	ret =3D ofono_modem_driver_register(&sim800_driver);
> +	if (!ret)
> +		return ret;
> +	ret =3D ofono_modem_driver_register(&sim900_driver);
> +	if (!ret)
> +		return ret;
> +	return ret;
>   }
>   =

>   static void sim900_exit(void)
> =


/Jonas

--===============6541610586881173622==--

