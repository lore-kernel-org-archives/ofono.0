Content-Type: multipart/mixed; boundary="===============6915632860057922148=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: Re: [PATCH 1/3] sim800: add sim800 support.
Date: Tue, 13 Nov 2018 16:11:07 +0100
Message-ID: <45b680e9-d855-1f0c-7e8c-a33c3803b488@norrbonn.se>
In-Reply-To: <1542101383-3220-1-git-send-email-vielclement@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6915632860057922148==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Clement,

I already provided review for this patch.  This submission addresses =

none of my earlier comments...

On 13/11/2018 10:29, Clement Viel wrote:
> ---
>   plugins/sim900.c | 91 +++++++++++++++++++++++++++++++++++++++++++++++++=
+------
>   1 file changed, 82 insertions(+), 9 deletions(-)
> =

> diff --git a/plugins/sim900.c b/plugins/sim900.c
> index a7728cd..bf7b9ec 100644
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
> @@ -60,13 +61,77 @@ static char *dlc_prefixes[NUM_DLC] =3D { "Voice: ", "=
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

There's no need to typedef an enumeration; type_t is not a great name, =

anyway...  How about:  enum simcom_model?  Furthermore, it makes sense =

to have the 'unknown' model be value 0.


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

See my previous review of this patch.  This function is pointless.

> +static void mux_ready_notify(GAtResult *result, gpointer user_data)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	struct sim900_data *data =3D ofono_modem_get_data(modem);
> +	struct ofono_gprs *gprs =3D NULL;
> +	struct ofono_gprs_context *gc;
> +
> +	ofono_sms_create(modem, OFONO_VENDOR_SIMCOM, "atmodem",
> +					data->dlcs[SMS_DLC]);
> +
> +	gprs =3D ofono_gprs_create(modem, 0, "atmodem", data->dlcs[GPRS_DLC]);
> +	if (gprs =3D=3D NULL)
> +		return;
> +
> +	gc =3D ofono_gprs_context_create(modem, OFONO_VENDOR_SIMCOM,
> +									"atmodem", data->dlcs[GPRS_DLC]);
> +	if (gc)
> +		ofono_gprs_add_context(gprs, gc);
> +	=

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
> +	DBG("");
> +
> +	g_at_result_iter_init(&iter, result);
> +
> +	while (g_at_result_iter_next(&iter, NULL)) {
> +		if (!g_at_result_iter_next_unquoted_string(&iter, &model))
> +			continue;
> +
> +		DBG("setting type %s", model);
> +		if (strstr(model, "SIM800"))

strstr?  The response begins with exactly this, as far as I can see.

> +			set_modem_type("sim800", modem);

So you go from "SIM800" to "sim800" to an enumerated type... just short =

out the call to set_modem_type().

> +		else if (strstr(model, "SIM900"))
> +			set_modem_type("sim900", modem);
> +	}
> +}
> +




>   static int sim900_probe(struct ofono_modem *modem)
>   {
>   	struct sim900_data *data;
> @@ -78,7 +143,6 @@ static int sim900_probe(struct ofono_modem *modem)
>   		return -ENOMEM;
>   =

>   	ofono_modem_set_data(modem, data);
> -

Random white space change

>   	return 0;
>   }
>   =

> @@ -111,6 +175,7 @@ static GAtChat *open_device(struct ofono_modem *modem,
>   	GHashTable *options;
>   =

>   	device =3D ofono_modem_get_string(modem, key);
> +

Random white space change.

>   	if (device =3D=3D NULL)
>   		return NULL;
>   =

> @@ -232,6 +297,11 @@ static void setup_internal_mux(struct ofono_modem *m=
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

> @@ -294,6 +364,7 @@ static int sim900_enable(struct ofono_modem *modem)
>   		return -EINVAL;
>   =

>   	g_at_chat_send(data->dlcs[SETUP_DLC], "ATE0", NULL, NULL, NULL, NULL);
> +	g_at_chat_send(data->dlcs[SETUP_DLC], "AT+CGMM", NULL,check_model, mode=
m, NULL);
>   =

>   	/* For obtain correct sms service number */
>   	g_at_chat_send(data->dlcs[SETUP_DLC], "AT+CSCS=3D\"GSM\"", NULL,
> @@ -353,18 +424,20 @@ static void sim900_post_sim(struct ofono_modem *mod=
em)
>   =

>   	DBG("%p", modem);
>   =

> -	ofono_phonebook_create(modem, 0, "atmodem", data->dlcs[VOICE_DLC]);
> -	ofono_sms_create(modem, OFONO_VENDOR_SIMCOM, "atmodem",
> +	if (data->modem_type !=3D SIM800) {

Again, this is SIM900, specifically.  Make the check for that.  Or:

if (data->modem_type =3D=3D SIM800)
	return;

I think that's what you're doing here, effecively.

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
> =


/Jonas

--===============6915632860057922148==--

