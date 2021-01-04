Content-Type: multipart/mixed; boundary="===============1652387454104212109=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] quectel: add support of Quectel EC200 USB modem
Date: Mon, 04 Jan 2021 11:16:11 -0600
Message-ID: <26830081-b467-1be9-5a3b-8b1198e43d70@gmail.com>
In-Reply-To: <20210101211719.30013-1-s.e.golubtsov@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1652387454104212109==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sergei,

On 1/1/21 3:17 PM, s.e.golubtsov(a)gmail.com wrote:
> From: Sergei Golubtsov <s.e.golubtsov@gmail.com>
> =

> Support of Quectel EC200 USB modem series has been added. The model
> identification AT command has been added as the first step in the
> communication with a Quectel modem.
> ---
>   plugins/quectel.c | 49 +++++++++++++++++++++++++++++++++++++++++++----
>   plugins/udevng.c  |  6 ++++--
>   2 files changed, 49 insertions(+), 6 deletions(-)
> =

> diff --git a/plugins/quectel.c b/plugins/quectel.c
> index 82fc688d..d77fbe60 100644
> --- a/plugins/quectel.c
> +++ b/plugins/quectel.c
> @@ -64,7 +64,7 @@ static const char *cpin_prefix[] =3D { "+CPIN:", NULL };
>   static const char *cbc_prefix[] =3D { "+CBC:", NULL };
>   static const char *qinistat_prefix[] =3D { "+QINISTAT:", NULL };
>   static const char *cgmm_prefix[] =3D { "UC15", "Quectel_M95", "Quectel_=
MC60",
> -					"EC21", NULL };
> +					"EC21", "EC200", NULL };
>   static const char *none_prefix[] =3D { NULL };
>   =

>   static const uint8_t gsm0710_terminate[] =3D {
> @@ -84,6 +84,7 @@ enum quectel_model {
>   	QUECTEL_M95,
>   	QUECTEL_MC60,
>   	QUECTEL_EC21,
> +	QUECTEL_EC200,
>   };
>   =

>   struct quectel_data {
> @@ -127,6 +128,15 @@ enum quectel_power_event {
>   =

>   static const char dbus_hw_interface[] =3D OFONO_SERVICE ".quectel.Hardw=
are";
>   =

> +static void cgmm_cb(int ok, GAtResult *result, void *user_data);

Please see doc/coding-style.txt item M17

> +
> +static ofono_bool_t has_serial_connection(struct ofono_modem *modem)
> +{
> +	if (ofono_modem_get_string(modem, "Device"))
> +		return TRUE;
> +	return FALSE;

doc/coding-style.txt item M1

> +}
> +
>   static void quectel_debug(const char *str, void *user_data)
>   {
>   	const char *prefix =3D user_data;
> @@ -543,6 +553,7 @@ static void dbus_hw_enable(struct ofono_modem *modem)
>   	switch (data->model) {
>   	case QUECTEL_UC15:
>   	case QUECTEL_EC21:
> +	case QUECTEL_EC200:
>   		g_at_chat_register(data->aux, "+QIND",  qind_notify, FALSE, hw,
>   					NULL);
>   		break;
> @@ -591,6 +602,13 @@ static void qinistat_cb(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
>   		/* UC15 uses a bitmap of 1 + 2 + 4 =3D 7 */
>   		ready =3D 7;
>   		break;
> +	case QUECTEL_EC200:
> +		/*
> +		 * EC200T doesn't indicate that the Phonebook initialization
> +		 * is completed (=3D=3D4) when AT+CFUN=3D4, that's why 1 + 2 =3D 3
> +		 */
> +		ready =3D 3;
> +		break;
>   	case QUECTEL_M95:
>   	case QUECTEL_MC60:
>   		/* M95 and MC60 uses a counter to 3 */
> @@ -794,6 +812,18 @@ static void cfun_query(gboolean ok, GAtResult *resul=
t, gpointer user_data)
>   		cfun_enable(TRUE, NULL, modem);
>   }
>   =

> +static void identify_model(struct ofono_modem *modem)
> +{
> +	struct quectel_data *data =3D ofono_modem_get_data(modem);
> +
> +	DBG("%p", modem);
> +
> +	g_at_chat_set_slave(data->modem, data->aux);

Why do you need this here?  This really belongs in open_ttys as opposed to =

setup_aux or here.
> +
> +	g_at_chat_send(data->aux, "AT+CGMM", cgmm_prefix, cgmm_cb, modem,
> +			NULL);
> +}
> +
>   static void setup_aux(struct ofono_modem *modem)
>   {
>   	struct quectel_data *data =3D ofono_modem_get_data(modem);
> @@ -807,6 +837,9 @@ static void setup_aux(struct ofono_modem *modem)
>   				NULL, NULL, NULL);
>   		g_at_chat_send(data->aux, "AT+QURCCFG=3D\"urcport\",\"uart1\"", none_=
prefix,
>   				NULL, NULL, NULL);
> +	} else if (data->model =3D=3D QUECTEL_EC200) {
> +		g_at_chat_send(data->aux, "ATE0; &C0; +CMEE=3D1", none_prefix,
> +				NULL, NULL, NULL);
>   	} else
>   		g_at_chat_send(data->aux, "ATE0; &C0; +CMEE=3D1; +QIURC=3D0",
>   				none_prefix, NULL, NULL, NULL);
> @@ -834,7 +867,7 @@ static int open_ttys(struct ofono_modem *modem)
>   		return -EIO;
>   	}
>   =

> -	setup_aux(modem);
> +	identify_model(modem);

This results in Serial versions of Quectel modems issuing CGMM twice.  The =
logic =

also becomes very hard to follow.

Perhaps CGMM needs to be issued once after open_ttys (like you're doing for=
 USB =

variants) for both Serial and USB versions.

>   =

>   	return -EINPROGRESS;
>   }
> @@ -1061,14 +1094,22 @@ static void cgmm_cb(int ok, GAtResult *result, vo=
id *user_data)
>   		DBG("%p model EC21", modem);
>   		data->vendor =3D OFONO_VENDOR_QUECTEL_EC2X;
>   		data->model =3D QUECTEL_EC21;
> +	} else if (strstr(model, "EC200")) {
> +		DBG("%p model %s", modem, model);
> +		data->vendor =3D OFONO_VENDOR_QUECTEL_EC2X;
> +		data->model =3D QUECTEL_EC200;
>   	} else {
>   		ofono_warn("%p unknown model: '%s'", modem, model);
>   		data->vendor =3D OFONO_VENDOR_QUECTEL;
>   		data->model =3D QUECTEL_UNKNOWN;
>   	}
>   =

> -	g_at_chat_send(data->uart, "AT+CMUX=3D0,0,5,127,10,3,30,10,2", NULL,
> +	if (has_serial_connection(modem)) {
> +		g_at_chat_send(data->uart, "AT+CMUX=3D0,0,5,127,10,3,30,10,2", NULL,
>   			cmux_cb, modem, NULL);
> +	} else {
> +		setup_aux(modem);
> +	}
>   }
>   =

>   static void ate_cb(int ok, GAtResult *result, void *user_data)
> @@ -1315,7 +1356,7 @@ static void quectel_post_sim(struct ofono_modem *mo=
dem)
>   	ofono_phonebook_create(modem, data->vendor, "atmodem", data->aux);
>   	ofono_call_volume_create(modem, data->vendor, "atmodem", data->aux);
>   =

> -	if (data->model =3D=3D QUECTEL_EC21) {
> +	if (data->model =3D=3D QUECTEL_EC21 || data->model =3D=3D QUECTEL_EC200=
) {
>   		ofono_ussd_create(modem, data->vendor, "atmodem", data->aux);
>   		ofono_lte_create(modem, data->vendor, "atmodem", data->aux);
>   	}
> diff --git a/plugins/udevng.c b/plugins/udevng.c
> index 3458fe89..34ac1cc0 100644
> --- a/plugins/udevng.c
> +++ b/plugins/udevng.c
> @@ -941,10 +941,12 @@ static gboolean setup_quectel_serial(struct modem_i=
nfo *modem)
>   =

>   static gboolean setup_quectel(struct modem_info *modem)
>   {
> -	if (modem->serial)
> +	if (modem->type =3D=3D MODEM_TYPE_SERIAL)
>   		return setup_quectel_serial(modem);
> -	else
> +	else if (modem->type =3D=3D MODEM_TYPE_USB)
>   		return setup_quectel_usb(modem);
> +	else
> +		return FALSE;
>   }
>   =

>   static gboolean setup_quectelqmi(struct modem_info *modem)
> =


Regards,
-Denis
--===============1652387454104212109==--

