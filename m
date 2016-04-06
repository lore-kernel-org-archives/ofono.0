Content-Type: multipart/mixed; boundary="===============1843541221359923495=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] wavecom: Re-work modem handling to improve stability
Date: Wed, 06 Apr 2016 13:37:45 -0500
Message-ID: <57055779.7050200@gmail.com>
In-Reply-To: <1459884308-66518-1-git-send-email-holger@freyther.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1843541221359923495==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Holger,

On 04/05/2016 02:25 PM, Holger Hans Peter Freyther wrote:
> From: Holger Hans Peter Freyther <holger@moiji-mobile.com>
>
> This is the result of heavily looking at other plugins to
> decide when and which objects to create.
>
> * Use +WIND to get to know when the modem is ready
> * Enable AT+CFUN=3D1/AT+CFUN=3D4 for online/offline handling
> * Deal with GAtChat surviving a disable/enable cycle
> ---
>   plugins/wavecom.c | 248 +++++++++++++++++++++++++++++++++++++++++++++--=
-------
>   1 file changed, 209 insertions(+), 39 deletions(-)
>
> diff --git a/plugins/wavecom.c b/plugins/wavecom.c
> index 7f24eae..c3b0b52 100644
> --- a/plugins/wavecom.c
> +++ b/plugins/wavecom.c
> @@ -47,35 +47,145 @@
>   #include <ofono/sms.h>
>   #include <ofono/ussd.h>
>   #include <ofono/voicecall.h>
> +#include <ofono.h>
>
> +#include <drivers/atmodem/atutil.h>
>   #include <drivers/atmodem/vendor.h>
>
> +static const char *cfun_prefix[] =3D { "+CFUN:", NULL };
> +static const char *wind_prefix[] =3D { "+WIND:", NULL };
> +static const char *none_prefix[] =3D { NULL };
> +
> +struct wavecom_data {
> +	GAtChat *chat;
> +	int have_enabled;
> +	gboolean have_sim;
> +	gboolean have_sms;
> +};
> +
> +static enum ofono_vendor vendor(struct ofono_modem *modem)
> +{
> +	const char *model;
> +
> +	model =3D ofono_modem_get_string(modem, "Model");
> +	if (model && strcmp(model, "Q2XXX") =3D=3D 0)
> +		return OFONO_VENDOR_WAVECOM_Q2XXX;
> +	return 0;

Just a minor nitpick here, but doc/coding-style.txt, item M1

> +}
> +
> +static void wavecom_debug(const char *str, void *user_data)
> +{
> +	const char *prefix =3D user_data;
> +
> +	ofono_info("%s%s", prefix, str);
> +}
>
>   static int wavecom_probe(struct ofono_modem *modem)
>   {
> +	struct wavecom_data *data;
> +
> +	ofono_info("%p: %s", modem, __func__);

This one should use the DBG macro, not ofono_info

> +
> +	data =3D g_try_new0(struct wavecom_data, 1);
> +	if (data =3D=3D NULL)
> +		return -ENOMEM;
> +
> +	ofono_modem_set_data(modem, data);
> +
>   	return 0;
>   }
>
>   static void wavecom_remove(struct ofono_modem *modem)
>   {
> +	struct wavecom_data *data =3D ofono_modem_get_data(modem);
> +
> +	ofono_info("%p: %s", modem, __func__);

As above

> +
> +	ofono_modem_set_data(modem, NULL);
> +	g_at_chat_unref(data->chat);
> +	g_free(data);
>   }
>
> -static void wavecom_debug(const char *str, void *user_data)
> +static void rf_off_cb(gboolean ok, GAtResult *result, gpointer user_data)
>   {
> -	const char *prefix =3D user_data;
> +	struct ofono_modem *modem =3D user_data;
>
> -	ofono_info("%s%s", prefix, str);
> +	ofono_modem_set_powered(modem, TRUE);
> +}
> +
> +static void wind_notify(GAtResult *result, gpointer user_data)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	struct wavecom_data *data =3D ofono_modem_get_data(modem);
> +	struct ofono_sim *sim =3D __ofono_atom_find(OFONO_ATOM_TYPE_SIM, modem);
> +	GAtResultIter iter;
> +	int val;
> +
> +	ofono_info("%p: %s", modem, __func__);

DBG

> +
> +	g_at_result_iter_init(&iter, result);
> +
> +	if (!g_at_result_iter_next(&iter, "+WIND:"))
> +		return;
> +
> +	if (!g_at_result_iter_next_number(&iter, &val))
> +		return;
> +
> +	switch (val) {
> +	case 3: /* ready to process AT commands */
> +		if (!data->have_enabled) {
> +			data->have_enabled =3D TRUE;
> +			g_at_chat_send(data->chat, "AT+CFUN=3D4", none_prefix, rf_off_cb, mod=
em, NULL);

This line is over 80 characters, see doc/coding-style.txt

> +		}
> +		break;
> +	case 0: /* sim removed */
> +		data->have_sim =3D FALSE;
> +		if (sim)
> +			ofono_sim_inserted_notify(sim, FALSE);
> +		break;
> +	case 1: /* sim inserted */
> +		data->have_sim =3D TRUE;
> +		break;
> +	case 16: /* SMS and SMS-CB services initialized */
> +		if (sim)
> +			ofono_sim_inserted_notify(sim, TRUE);
> +		break;
> +	case 7: /* service available for emergency call */
> +		break;
> +	case 8: /* network is lost */
> +	case 10: /* reload status of SIM phonebook */
> +		break;
> +	case 11: /* checksum of SIM phoenbook */
> +	case 13: /* rack has been detected closed */
> +		break;
> +	}
> +}
> +
> +

Double empty lines are not allowed

> +static void wind_set(gboolean ok, GAtResult *result, gpointer user_data)
> +{
> +	ofono_info("%s", __func__);
>   }
>
>   static int wavecom_enable(struct ofono_modem *modem)
>   {
> +	struct wavecom_data *data;
>   	GAtChat *chat;
>   	GIOChannel *channel;
>   	GAtSyntax *syntax;
>   	const char *device;
>   	GHashTable *options;
>
> -	DBG("%p", modem);
> +	ofono_info("%p: %s", modem, __func__);

DBG please

> +
> +	data =3D ofono_modem_get_data(modem);
> +
> +	if (data->chat) {
> +		g_at_chat_cancel_all(data->chat);
> +		g_at_chat_unregister_all(data->chat);
> +		g_at_chat_unref(data->chat);
> +		data->chat =3D NULL;
> +	}
>
>   	device =3D ofono_modem_get_string(modem, "Device");
>   	if (device =3D=3D NULL)
> @@ -111,75 +221,133 @@ static int wavecom_enable(struct ofono_modem *mode=
m)
>   	if (chat =3D=3D NULL)
>   		return -ENOMEM;
>
> +	g_at_chat_register(chat, "+WIND", wind_notify,
> +			   FALSE, modem, NULL);
> +
>   	g_at_chat_add_terminator(chat, "+CPIN:", 6, TRUE);
>
>   	if (getenv("OFONO_AT_DEBUG"))
>   		g_at_chat_set_debug(chat, wavecom_debug, "");
>
> -	ofono_modem_set_data(modem, chat);
> +	data->chat =3D chat;
>
> -	return 0;
> +	g_at_chat_send(chat, "AT+WIND=3D32767", wind_prefix,
> +			wind_set, modem, NULL);
> +
> +	/* restart and wait for the +WIND */
> +	data->have_enabled =3D FALSE;
> +	data->have_sim =3D FALSE;
> +	g_at_chat_send(chat, "AT+CFUN=3D1,1", none_prefix,
> +			NULL, modem, NULL);

Please always use tabs for indentation.  Our coding style does not allow =

mixed spaces / tabs.

> +	return -EINPROGRESS;
> +}
> +
> +static void cfun_disable(gboolean ok, GAtResult *result, gpointer user_d=
ata)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	struct wavecom_data *data =3D ofono_modem_get_data(modem);
> +
> +	ofono_info("%p: %s", modem, __func__);
> +

DBG

> +	g_at_chat_unref(data->chat);
> +	data->chat =3D NULL;
> +
> +	if (ok)
> +		ofono_modem_set_powered(modem, FALSE);
> +	else
> +		ofono_error("%p power down has failed!", modem);
>   }
>
>   static int wavecom_disable(struct ofono_modem *modem)
>   {
> -	GAtChat *chat =3D ofono_modem_get_data(modem);
> +	struct wavecom_data *data =3D ofono_modem_get_data(modem);
>
> -	DBG("%p", modem);
> +	ofono_info("%p: %s", modem, __func__);

DBG

>
> -	ofono_modem_set_data(modem, NULL);
> +	g_at_chat_cancel_all(data->chat);
> +	g_at_chat_unregister_all(data->chat);
>
> -	g_at_chat_unref(chat);
> +	g_at_chat_send(data->chat, "AT+CFUN=3D0", cfun_prefix,
> +					cfun_disable, modem, NULL);
>
> -	return 0;
> +	return -EINPROGRESS;
> +}
> +
> +static void set_online_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
> +{
> +	struct cb_data *cbd =3D user_data;
> +	ofono_modem_online_cb_t cb =3D cbd->cb;
> +	struct ofono_error error;
> +
> +	decode_at_error(&error, g_at_result_final_response(result));
> +	cb(&error, cbd->data);
> +}
> +
> +static void wavecom_set_online(struct ofono_modem *modem, ofono_bool_t o=
nline,
> +				ofono_modem_online_cb_t cb, void *user_data)
> +{
> +	struct wavecom_data *data =3D ofono_modem_get_data(modem);
> +	struct cb_data *cbd =3D cb_data_new(cb, user_data);
> +	char const *command =3D online ? "AT+CFUN=3D1,0" : "AT+CFUN=3D4";
> +
> +	ofono_info("%p: %s %d", modem, __func__, online);
> +
> +	if (g_at_chat_send(data->chat, command, cfun_prefix, set_online_cb,
> +					cbd, g_free) > 0)
> +		return;
> +
> +	CALLBACK_WITH_FAILURE(cb, cbd->data);
> +
> +	g_free(cbd);
>   }
>
>   static void wavecom_pre_sim(struct ofono_modem *modem)
>   {
> -	GAtChat *chat =3D ofono_modem_get_data(modem);
> -	const char *model;
> -	enum ofono_vendor vendor =3D 0;
> +	struct wavecom_data *data =3D ofono_modem_get_data(modem);
>   	struct ofono_sim *sim;
>
> -	DBG("%p", modem);
> -
> -	model =3D ofono_modem_get_string(modem, "Model");
> -	if (model && strcmp(model, "Q2XXX") =3D=3D 0)
> -		vendor =3D OFONO_VENDOR_WAVECOM_Q2XXX;
> +	ofono_info("%p: %s", modem, __func__);
>
> -	ofono_devinfo_create(modem, 0, "atmodem", chat);
> -	sim =3D ofono_sim_create(modem, vendor, "atmodem", chat);
> -	ofono_voicecall_create(modem, 0, "atmodem", chat);
> +	ofono_devinfo_create(modem, 0, "atmodem", data->chat);
> +	sim =3D ofono_sim_create(modem, vendor(modem), "atmodem", data->chat);
> +	ofono_voicecall_create(modem, 0, "atmodem", data->chat);
>
> -	if (vendor =3D=3D OFONO_VENDOR_WAVECOM_Q2XXX)
> +	if (sim && data->have_sim =3D=3D TRUE) {
> +		data->have_sim =3D FALSE;
>   		ofono_sim_inserted_notify(sim, TRUE);
> +	}
>   }
>
>   static void wavecom_post_sim(struct ofono_modem *modem)
>   {
> -	GAtChat *chat =3D ofono_modem_get_data(modem);
> -	struct ofono_message_waiting *mw;
> -	const char *model;
> -	enum ofono_vendor vendor =3D 0;
> +	ofono_info("%p: %s", modem, __func__);
>
> -	DBG("%p", modem);
> +	/* TODO: Initialize GPRS support if we have an aux line */
> +	/*
> +	 * FIXME: This only seems to be called when no immediate
> +	 * enabled -> online change is called
> +	 */

??

> +}
>
> -	model =3D ofono_modem_get_string(modem, "Model");
> -	if (model && strcmp(model, "Q2XXX") =3D=3D 0)
> -		vendor =3D OFONO_VENDOR_WAVECOM_Q2XXX;
> +static void wavecom_post_online(struct ofono_modem *modem)
> +{
> +	struct ofono_message_waiting *mw;
> +	struct wavecom_data *data =3D ofono_modem_get_data(modem);
>
> -	ofono_ussd_create(modem, 0, "atmodem", chat);
> -	ofono_call_forwarding_create(modem, 0, "atmodem", chat);
> -	ofono_call_settings_create(modem, 0, "atmodem", chat);
> -	ofono_netreg_create(modem, 0, "atmodem", chat);
> -	ofono_call_meter_create(modem, 0, "atmodem", chat);
> -	ofono_call_barring_create(modem, 0, "atmodem", chat);
> -	ofono_sms_create(modem, vendor, "atmodem", chat);
> -	ofono_phonebook_create(modem, 0, "atmodem", chat);
> +	ofono_info("%p: %s", modem, __func__);
> +	ofono_ussd_create(modem, 0, "atmodem", data->chat);
> +	ofono_call_forwarding_create(modem, 0, "atmodem", data->chat);
> +	ofono_call_settings_create(modem, 0, "atmodem", data->chat);
> +	ofono_netreg_create(modem, 0, "atmodem", data->chat);
> +	ofono_call_meter_create(modem, 0, "atmodem", data->chat);
> +	ofono_call_barring_create(modem, 0, "atmodem", data->chat);
>
>   	mw =3D ofono_message_waiting_create(modem);
>   	if (mw)
>   		ofono_message_waiting_register(mw);
> +
> +	ofono_phonebook_create(modem, 0, "atmodem", data->chat);
> +	ofono_sms_create(modem, vendor(modem), "atmodem", data->chat);
>   }
>
>   static struct ofono_modem_driver wavecom_driver =3D {
> @@ -188,8 +356,10 @@ static struct ofono_modem_driver wavecom_driver =3D {
>   	.remove		=3D wavecom_remove,
>   	.enable		=3D wavecom_enable,
>   	.disable	=3D wavecom_disable,
> +	.set_online	=3D wavecom_set_online,
>   	.pre_sim	=3D wavecom_pre_sim,
>   	.post_sim	=3D wavecom_post_sim,
> +	.post_online	=3D wavecom_post_online,
>   };
>
>   static int wavecom_init(void)
>

Please note that you can debug the wavecom plugin specifically by =

starting ofonod with -d '*wavecom*'

Regards,
-Denis

--===============1843541221359923495==--

