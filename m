Content-Type: multipart/mixed; boundary="===============5663903137591081311=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] ste: Add support for multiple AT channels
Date: Wed, 02 Mar 2011 23:48:09 -0600
Message-ID: <4D6F2B99.7060203@gmail.com>
In-Reply-To: <1299058433-16980-1-git-send-email-lasse.kunnasluoto@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5663903137591081311==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lasse,

On 03/02/2011 03:33 AM, Lasse Kunnasluoto wrote:
> ---
>  plugins/ste.c |  138 ++++++++++++++++++++++++++++++++++++---------------=
------
>  1 files changed, 87 insertions(+), 51 deletions(-)
> =

> diff --git a/plugins/ste.c b/plugins/ste.c
> index b786571..9a1d3d3 100644
> --- a/plugins/ste.c
> +++ b/plugins/ste.c
> @@ -65,13 +65,19 @@
>  #include <drivers/stemodem/caif_socket.h>
>  #include <drivers/stemodem/if_caif.h>
>  =

> -#define NUM_CHAT	1
> +#define NUM_CHAT	5
> +#define AT_DEFAULT	0
> +#define AT_NET	1
> +#define AT_VOICE	2
> +#define AT_GPRS	3
> +#define AT_SIM	4

Can you cleanup the indentation of the channel numbers here to be more
consistent?  And I'd actually like to have an empty line between these
and the MAX_PDP_CONTEXTS define.

>  #define MAX_PDP_CONTEXTS	4
>  =

> -static char *chat_prefixes[NUM_CHAT] =3D { "Default: " };
> +static char *chat_prefixes[NUM_CHAT] =3D { "Default: ", "Net: ", "Voice:=
 ",
> +					"GPRS: ", "SIM: " };
>  =

>  struct ste_data {
> -	GAtChat *chat;
> +	GAtChat *chat[NUM_CHAT];
>  	gboolean have_sim;
>  	struct ofono_sim *sim;
>  };
> @@ -105,12 +111,14 @@ static int ste_probe(struct ofono_modem *modem)
>  static void ste_remove(struct ofono_modem *modem)
>  {
>  	struct ste_data *data =3D ofono_modem_get_data(modem);
> +	int i;
>  =

>  	DBG("%p", modem);
>  =

>  	ofono_modem_set_data(modem, NULL);
>  =

> -	g_at_chat_unref(data->chat);
> +	for (i =3D 0; i < NUM_CHAT; i++)
> +		g_at_chat_unref(data->chat[i]);
>  =

>  	g_free(data);
>  }
> @@ -185,7 +193,7 @@ static gboolean init_sim_reporting(gpointer user_data)
>  	struct ofono_modem *modem =3D user_data;
>  	struct ste_data *data =3D ofono_modem_get_data(modem);
>  =

> -	g_at_chat_send(data->chat, "AT*ESIMSR=3D1;*ESIMSR?", NULL,
> +	g_at_chat_send(data->chat[AT_SIM], "AT*ESIMSR=3D1;*ESIMSR?", NULL,
>  			handle_sim_state,
>  			modem, NULL);
>  =

> @@ -195,11 +203,21 @@ static gboolean init_sim_reporting(gpointer user_da=
ta)
>  static void cfun_enable(gboolean ok, GAtResult *result, gpointer user_da=
ta)
>  {
>  	struct ofono_modem *modem =3D user_data;
> +	struct ste_data *data =3D ofono_modem_get_data(modem);
> +	int i;
>  =

>  	DBG("");
>  =

>  	if (!ok) {
>  		ofono_modem_set_powered(modem, FALSE);
> +
> +		for (i =3D 0; i < NUM_CHAT; i++) {
> +			g_at_chat_cancel_all(data->chat[i]);
> +			g_at_chat_unregister_all(data->chat[i]);
> +			g_at_chat_unref(data->chat[i]);
> +			data->chat[i] =3D NULL;
> +		}
> +
>  		return;
>  	}
>  =

> @@ -295,35 +313,47 @@ static void esimsr_notify(GAtResult *result, gpoint=
er user_data)
>  static int ste_enable(struct ofono_modem *modem)
>  {
>  	struct ste_data *data =3D ofono_modem_get_data(modem);
> -	GIOChannel *channel;
>  	GAtSyntax *syntax;
> +	int i;
>  =

>  	syntax =3D g_at_syntax_new_gsm_permissive();
>  =


Sharing a syntax between all channels isn't really going to work out how
you think ;)  Each syntax has its own state, so you have to create a
syntax for every channel separately.

> -	channel =3D ste_create_channel(modem);
> -	if (!channel)
> -		return -EIO;
> +	for (i =3D 0; i < NUM_CHAT; i++) {
> +		GIOChannel *channel =3D ste_create_channel(modem);
>  =

> -	data->chat =3D g_at_chat_new_blocking(channel, syntax);
> -	g_at_chat_send(data->chat, "AT&F E0 V1 X4 &C1 +CMEE=3D1",
> -			NULL, NULL, NULL, NULL);
> +		data->chat[i] =3D g_at_chat_new_blocking(channel, syntax);
> +		if (data->chat[i] =3D=3D NULL)
> +			return -EIO;

You might want to handle these errors properly.  If creation of one chat
fails, then you should unref all of them.

>  =

> -	/* All STE modems support UTF-8 */
> -	g_at_chat_send(data->chat, "AT+CSCS=3D\"UTF-8\"",
> -			NULL, NULL, NULL, NULL);
> +		g_at_chat_send(data->chat[i], "AT&F E0 V1 X4 &C1 +CMEE=3D1",
> +				NULL, NULL, NULL, NULL);
>  =

> -	g_io_channel_unref(channel);
> -	g_at_syntax_unref(syntax);
> +		/* All STE modems support UTF-8 */
> +		g_at_chat_send(data->chat[i], "AT+CSCS=3D\"UTF-8\"",
> +				NULL, NULL, NULL, NULL);
>  =

> -	if (data->chat =3D=3D NULL)
> -		return -ENOMEM;
> +		g_io_channel_unref(channel);
> +	}
>  =

> -	if (getenv("OFONO_AT_DEBUG"))
> -		g_at_chat_set_debug(data->chat, ste_debug, chat_prefixes[0]);
> +	g_at_syntax_unref(syntax);
>  =

> -	g_at_chat_send(data->chat, "AT+CFUN=3D4", NULL, cfun_enable, modem, NUL=
L);
> +	if (getenv("OFONO_AT_DEBUG")) {
> +		g_at_chat_set_debug(data->chat[AT_DEFAULT], ste_debug,
> +					chat_prefixes[0]);
> +		g_at_chat_set_debug(data->chat[AT_NET], ste_debug,
> +					chat_prefixes[1]);
> +		g_at_chat_set_debug(data->chat[AT_VOICE], ste_debug,
> +					chat_prefixes[2]);
> +		g_at_chat_set_debug(data->chat[AT_GPRS], ste_debug,
> +					chat_prefixes[3]);
> +		g_at_chat_set_debug(data->chat[AT_SIM], ste_debug,
> +					chat_prefixes[4]);
> +	}

Why is this being done here and not in a loop above?

>  =

> -	g_at_chat_register(data->chat, "*ESIMSR:", esimsr_notify,
> +	g_at_chat_send(data->chat[AT_DEFAULT], "AT+CFUN=3D4", NULL, cfun_enable,
> +				modem, NULL);
> +
> +	g_at_chat_register(data->chat[AT_SIM], "*ESIMSR:", esimsr_notify,
>  				FALSE, modem, NULL);
>  =

>  	return -EINPROGRESS;
> @@ -333,11 +363,14 @@ static void cfun_disable(gboolean ok, GAtResult *re=
sult, gpointer user_data)
>  {
>  	struct ofono_modem *modem =3D user_data;
>  	struct ste_data *data =3D ofono_modem_get_data(modem);
> +	int i;
>  =

>  	DBG("");
>  =

> -	g_at_chat_unref(data->chat);
> -	data->chat =3D NULL;
> +	for (i =3D 0; i < NUM_CHAT; i++) {
> +		g_at_chat_unref(data->chat[i]);
> +		data->chat[i] =3D NULL;
> +	}
>  =

>  	if (ok)
>  		ofono_modem_set_powered(modem, FALSE);
> @@ -346,15 +379,15 @@ static void cfun_disable(gboolean ok, GAtResult *re=
sult, gpointer user_data)
>  static int ste_disable(struct ofono_modem *modem)
>  {
>  	struct ste_data *data =3D ofono_modem_get_data(modem);
> +	int i;
>  =

>  	DBG("%p", modem);
>  =

> -	if (data->chat =3D=3D NULL)
> -		return 0;
> -
> -	g_at_chat_cancel_all(data->chat);
> -	g_at_chat_unregister_all(data->chat);
> -	g_at_chat_send(data->chat, "AT+CFUN=3D4", NULL,
> +	for (i =3D 0; i < NUM_CHAT; i++) {
> +		g_at_chat_cancel_all(data->chat[i]);
> +		g_at_chat_unregister_all(data->chat[i]);
> +	}

Coding style M1

> +	g_at_chat_send(data->chat[AT_DEFAULT], "AT+CFUN=3D4", NULL,
>  					cfun_disable, modem, NULL);
>  =

>  	return -EINPROGRESS;
> @@ -375,7 +408,7 @@ static void ste_set_online(struct ofono_modem *modem,=
 ofono_bool_t online,
>  				ofono_modem_online_cb_t cb, void *user_data)
>  {
>  	struct ste_data *data =3D ofono_modem_get_data(modem);
> -	GAtChat *chat =3D data->chat;
> +	GAtChat *chat =3D data->chat[AT_DEFAULT];
>  	struct cb_data *cbd =3D cb_data_new(cb, user_data);
>  	char const *command =3D online ? "AT+CFUN=3D1" : "AT+CFUN=3D4";
>  =

> @@ -395,10 +428,10 @@ static void ste_pre_sim(struct ofono_modem *modem)
>  =

>  	DBG("%p", modem);
>  =

> -	ofono_devinfo_create(modem, 0, "atmodem", data->chat);
> +	ofono_devinfo_create(modem, 0, "atmodem", data->chat[AT_DEFAULT]);
>  	data->sim =3D ofono_sim_create(modem, OFONO_VENDOR_MBM, "atmodem",
> -					data->chat);
> -	ofono_voicecall_create(modem, 0, "stemodem", data->chat);
> +					data->chat[AT_SIM]);
> +	ofono_voicecall_create(modem, 0, "stemodem", data->chat[AT_VOICE]);
>  }
>  =

>  static void ste_post_sim(struct ofono_modem *modem)
> @@ -407,11 +440,11 @@ static void ste_post_sim(struct ofono_modem *modem)
>  =

>  	DBG("%p", modem);
>  =

> -	ofono_stk_create(modem, 0, "mbmmodem", data->chat);
> -	ofono_phonebook_create(modem, 0, "atmodem", data->chat);
> -	ofono_radio_settings_create(modem, 0, "stemodem", data->chat);
> +	ofono_stk_create(modem, 0, "mbmmodem", data->chat[AT_SIM]);
> +	ofono_phonebook_create(modem, 0, "atmodem", data->chat[AT_SIM]);
> +	ofono_radio_settings_create(modem, 0, "stemodem", data->chat[AT_NET]);
>  =

> -	ofono_sms_create(modem, 0, "atmodem", data->chat);
> +	ofono_sms_create(modem, 0, "atmodem", data->chat[AT_DEFAULT]);
>  }
>  =

>  static void ste_post_online(struct ofono_modem *modem)
> @@ -424,22 +457,25 @@ static void ste_post_online(struct ofono_modem *mod=
em)
>  =

>  	DBG("%p", modem);
>  =

> -	ofono_ussd_create(modem, 0, "atmodem", data->chat);
> -	ofono_call_forwarding_create(modem, 0, "atmodem", data->chat);
> -	ofono_call_settings_create(modem, 0, "atmodem", data->chat);
> -	ofono_netreg_create(modem, OFONO_VENDOR_MBM, "atmodem", data->chat);
> -	ofono_call_meter_create(modem, 0, "atmodem", data->chat);
> -	ofono_call_barring_create(modem, 0, "atmodem", data->chat);
> -	ofono_ssn_create(modem, 0, "atmodem", data->chat);
> -	ofono_call_volume_create(modem, 0, "atmodem", data->chat);
> -	ofono_cbs_create(modem, 0, "atmodem", data->chat);
> +	ofono_ussd_create(modem, 0, "atmodem", data->chat[AT_DEFAULT]);
> +	ofono_call_forwarding_create(modem, 0,
> +					"atmodem", data->chat[AT_DEFAULT]);
> +	ofono_call_settings_create(modem, 0, "atmodem", data->chat[AT_DEFAULT]);
> +	ofono_netreg_create(modem, OFONO_VENDOR_MBM,
> +					"atmodem", data->chat[AT_NET]);
> +	ofono_call_meter_create(modem, 0, "atmodem", data->chat[AT_DEFAULT]);
> +	ofono_call_barring_create(modem, 0, "atmodem", data->chat[AT_DEFAULT]);
> +	ofono_ssn_create(modem, 0, "atmodem", data->chat[AT_DEFAULT]);
> +	ofono_call_volume_create(modem, 0, "atmodem", data->chat[AT_DEFAULT]);
> +	ofono_cbs_create(modem, 0, "atmodem", data->chat[AT_DEFAULT]);
>  =

>  	gprs =3D ofono_gprs_create(modem, OFONO_VENDOR_MBM,
> -					"atmodem", data->chat);
> +					"atmodem", data->chat[AT_GPRS]);
> +
>  	if (gprs) {
>  		for (i =3D 0; i < MAX_PDP_CONTEXTS; i++) {
> -			gc =3D ofono_gprs_context_create(
> -					modem, 0, "stemodem", data->chat);
> +			gc =3D ofono_gprs_context_create(modem, 0, "stemodem",
> +					 data->chat[AT_GPRS]);

You have a whitespace violation here, mixing tabs and spaces.

>  			if (gc =3D=3D NULL)
>  				break;
>  =


Regards,
-Denis

--===============5663903137591081311==--

