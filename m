Content-Type: multipart/mixed; boundary="===============2747736158282062299=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/6] Add SIMCOM support.
Date: Mon, 22 Jul 2013 15:45:31 -0500
Message-ID: <51ED99EB.3000400@gmail.com>
In-Reply-To: <1374240940-30892-1-git-send-email-viallard@syscom-instruments.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2747736158282062299==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Anthony,

On 07/19/2013 08:35 AM, Anthony Viallard wrote:
> Implemented using the SIM5216E module:
>
>    Manufacturer: SIMCOM INCORPORATED
>    Model: SIMCOM_SIM5216E
>    Revision: 1575B11SIM5216E
>              SIM5216E_1575_111104_V1.21
>
> Also tested with SIM5216A (which is the america version of SIM5216) and i=
t works too.

I guess you mean 'American' version.  Might want to be more specific =

here, e.g. 'North American'.  Anyway, just being picky :)

> It should work with SIM5215 but I didn't have this module for testing.
>
>   - based on SIM5215_SIM5216_ATC_V1.18.pdf documentation ;
>   - SMS and GPRS work (in the same time) ;
>   - SIM card presence check ;
>   - use GSM charset ;
>   - use 115200bps, 8 bit data, no parity, 1 bit stop, no data stream cont=
rol
>     for tty configuration ;
>   - flight mode support ;
>   - no voice part (because I could't test it).
> ---
>   Makefile.am      |   3 +
>   plugins/simcom.c | 369 ++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++
>   2 files changed, 372 insertions(+)
>   create mode 100644 plugins/simcom.c
>
> diff --git a/Makefile.am b/Makefile.am
> index cc763b8..12c5b1c 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -408,6 +408,9 @@ builtin_sources +=3D plugins/samsung.c
>   builtin_modules +=3D sim900
>   builtin_sources +=3D plugins/sim900.c
>
> +builtin_modules +=3D simcom
> +builtin_sources +=3D plugins/simcom.c
> +
>   if BLUETOOTH
>   if BLUEZ4
>   builtin_modules +=3D bluez4
> diff --git a/plugins/simcom.c b/plugins/simcom.c
> new file mode 100644
> index 0000000..9cd984d
> --- /dev/null
> +++ b/plugins/simcom.c
> @@ -0,0 +1,369 @@
> +/*
> + *
> + *  oFono - Open Source Telephony
> + *
> + *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2 as
> + *  published by the Free Software Foundation.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-130=
1  USA
> + *
> + */
> +
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
> +#include <errno.h>
> +#include <stdlib.h>
> +#include <stdio.h>
> +
> +#include <glib.h>
> +#include <gatchat.h>
> +#include <gattty.h>
> +
> +#define OFONO_API_SUBJECT_TO_CHANGE
> +#include <ofono/plugin.h>
> +#include <ofono/modem.h>
> +#include <ofono/devinfo.h>
> +#include <ofono/netreg.h>
> +#include <ofono/sim.h>
> +#include <ofono/cbs.h>
> +#include <ofono/sms.h>
> +#include <ofono/ussd.h>
> +#include <ofono/gprs.h>
> +#include <ofono/gprs-context.h>
> +#include <ofono/radio-settings.h>
> +#include <ofono/phonebook.h>
> +#include <ofono/log.h>
> +
> +#include <drivers/atmodem/atutil.h>
> +#include <drivers/atmodem/vendor.h>
> +
> +static const char *none_prefix[] =3D { NULL };
> +
> +struct simcom_data {
> +	GAtChat *modem;
> +	GAtChat *chat;
> +	ofono_bool_t have_sim;
> +	struct at_util_sim_state_query *sim_state_query;
> +};
> +
> +/* Callback and helpers functions */
> +static void simcom_debug(const char *str, void *user_data)
> +{
> +	const char *prefix =3D user_data;
> +
> +	ofono_info("%s%s", prefix, str);
> +}
> +
> +static void sim_state_cb(gboolean present, gpointer user_data)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	struct simcom_data *data =3D ofono_modem_get_data(modem);
> +
> +	at_util_sim_state_query_free(data->sim_state_query);
> +	data->sim_state_query =3D NULL;
> +
> +	data->have_sim =3D present;
> +
> +	/* DCD (Data Carrier Detect) always enabled */
> +	g_at_chat_send(data->modem, "AT&C0", NULL, NULL, NULL, NULL);
> +	g_at_chat_send(data->chat, "AT&C0", NULL, NULL, NULL, NULL);
> +
> +	ofono_modem_set_powered(modem, TRUE);
> +}
> +
> +static void cfun_enable(gboolean ok, GAtResult *result, gpointer user_da=
ta)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	struct simcom_data *data =3D ofono_modem_get_data(modem);
> +
> +	DBG("");
> +
> +	if (!ok) {
> +		g_at_chat_unref(data->modem);
> +		data->modem =3D NULL;
> +
> +		g_at_chat_unref(data->chat);
> +		data->chat =3D NULL;
> +

So here you unref both channels...

> +		ofono_modem_set_powered(modem, FALSE);
> +		return;
> +	}
> +
> +	data->sim_state_query =3D at_util_sim_state_query_new(data->chat,
> +						2, 20, sim_state_cb, modem,
> +						NULL);
> +}
> +
> +static void cfun_disable(gboolean ok, GAtResult *result, gpointer user_d=
ata)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	struct simcom_data *data =3D ofono_modem_get_data(modem);
> +
> +	DBG("");
> +
> +	g_at_chat_unref(data->chat);
> +	data->chat =3D NULL;

Here you unref just the chat.  You might want to be consistent.

> +
> +	if (ok)
> +		ofono_modem_set_powered(modem, FALSE);
> +}
> +
> +static void flightmode_cb(gboolean ok, GAtResult *result, gpointer user_=
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
> +static GAtChat *open_device(struct ofono_modem *modem,
> +			    const char *key,
> +			    char *debug)
> +{
> +	const char *device;
> +	GIOChannel *channel;
> +	GAtSyntax *syntax;
> +	GAtChat *chat;
> +	GHashTable *options;
> +
> +	device =3D ofono_modem_get_string(modem, key);
> +	if (device =3D=3D NULL) {
> +		ofono_error("Failed to get modem '%s'", key);
> +		return NULL;
> +	}
> +
> +	DBG("%s %s", key, device);
> +
> +	options =3D g_hash_table_new(g_str_hash, g_str_equal);
> +	if (options =3D=3D NULL)
> +		return NULL;
> +
> +	g_hash_table_insert(options, "Baud", "115200");
> +	g_hash_table_insert(options, "Parity", "none");
> +	g_hash_table_insert(options, "StopBits", "1");
> +	g_hash_table_insert(options, "DataBits", "8");
> +	g_hash_table_insert(options, "XonXoff", "off");
> +
> +	channel =3D g_at_tty_open(device, options);
> +
> +	g_hash_table_destroy(options);
> +
> +	if (channel =3D=3D NULL) {
> +		ofono_error("Failed to get tty for '%s'", key);
> +		return NULL;
> +	}
> +
> +	syntax =3D g_at_syntax_new_gsm_permissive();
> +	chat =3D g_at_chat_new(channel, syntax);
> +	g_at_syntax_unref(syntax);
> +
> +	g_io_channel_unref(channel);
> +
> +	if (chat =3D=3D NULL) {
> +		ofono_error("Failed to get chat for '%s'", key);
> +		return NULL;
> +	}
> +
> +	if (getenv("OFONO_AT_DEBUG"))
> +		g_at_chat_set_debug(chat, simcom_debug, debug);
> +
> +	return chat;
> +}
> +
> +/* Modem interface function */

This comment is useless

> +static int simcom_probe(struct ofono_modem *modem)
> +{
> +	struct simcom_data *data;
> +
> +	DBG("%p", modem);
> +
> +	data =3D g_try_new0(struct simcom_data, 1);
> +	if (data =3D=3D NULL)
> +		return -ENOMEM;
> +
> +	ofono_modem_set_data(modem, data);
> +
> +	return 0;
> +}
> +
> +static void simcom_remove(struct ofono_modem *modem)
> +{
> +	struct simcom_data *data =3D ofono_modem_get_data(modem);
> +
> +	DBG("%p", modem);
> +
> +	ofono_modem_set_data(modem, NULL);
> +
> +	/* Cleanup potential SIM state polling */

As is this comment

> +	at_util_sim_state_query_free(data->sim_state_query);
> +
> +	/* Cleanup after hot-unplug */

And this comment

> +	g_at_chat_unref(data->chat);

Why do we not clean up the modem chat here?

> +
> +	g_free(data);
> +}
> +
> +static int simcom_enable(struct ofono_modem *modem)
> +{
> +	struct simcom_data *data =3D ofono_modem_get_data(modem);
> +
> +	DBG("%p", modem);
> +
> +	data->modem =3D open_device(modem, "Modem", "Modem: ");
> +	if (data->modem =3D=3D NULL)
> +		return -EINVAL;
> +
> +	data->chat =3D open_device(modem, "Data", "Chat: ");
> +	if (data->chat =3D=3D NULL) {
> +		g_at_chat_unref(data->modem);
> +		data->modem =3D NULL;
> +		return -EIO;
> +	}
> +
> +	g_at_chat_set_slave(data->modem, data->chat);
> +

Just FYI, g_at_chat_set_slave just refs the passed in argument, so it is =

not taking ownership of the other chat object.

> +	/* Configure AT commands behavior */
> +	g_at_chat_send(data->modem, "ATZ E0 +CMEE=3D1", NULL, NULL, NULL, NULL);
> +	g_at_chat_send(data->chat, "ATE0 +CMEE=3D1", NULL, NULL, NULL, NULL);
> +
> +	/* Ensure that the modem is using GSM character set and not IRA */
> +	g_at_chat_send(data->modem, "AT+CSCS=3D\"GSM\"", none_prefix,
> +			NULL, NULL, NULL);
> +	g_at_chat_send(data->chat, "AT+CSCS=3D\"GSM\"", none_prefix,
> +			NULL, NULL, NULL);
> +
> +	/* Make it up */

Might want to change that to 'Power it up'

> +	g_at_chat_send(data->chat, "AT+CFUN=3D1", none_prefix,
> +		       cfun_enable, modem, NULL);
> +
> +	return -EINPROGRESS;
> +}
> +
> +static int simcom_disable(struct ofono_modem *modem)
> +{
> +	struct simcom_data *data =3D ofono_modem_get_data(modem);
> +
> +	DBG("%p", modem);
> +
> +	g_at_chat_cancel_all(data->modem);
> +	g_at_chat_unregister_all(data->modem);
> +
> +	g_at_chat_unref(data->modem);
> +	data->modem =3D NULL;
> +
> +	g_at_chat_cancel_all(data->chat);
> +	g_at_chat_unregister_all(data->chat);
> +
> +	g_at_chat_send(data->chat, "AT+CFUN=3D4", none_prefix,
> +		       cfun_disable, modem, NULL);
> +
> +	return -EINPROGRESS;
> +}
> +
> +static void simcom_set_online(struct ofono_modem *modem, ofono_bool_t on=
line,
> +			      ofono_modem_online_cb_t cb, void *user_data)
> +{
> +	struct simcom_data *data =3D ofono_modem_get_data(modem);
> +	struct cb_data *cbd =3D cb_data_new(cb, user_data);
> +	char const *command =3D online ? "AT+CFUN=3D1" : "AT+CFUN=3D4";
> +
> +	DBG("modem %p %s", modem, online ? "online" : "offline");
> +
> +	if (g_at_chat_send(data->chat, command, none_prefix,
> +			   flightmode_cb, cbd, g_free) > 0)
> +		return;
> +
> +	CALLBACK_WITH_FAILURE(cb, cbd->data);
> +
> +	g_free(cbd);
> +}
> +
> +static void simcom_pre_sim(struct ofono_modem *modem)
> +{
> +	struct simcom_data *data =3D ofono_modem_get_data(modem);
> +	struct ofono_sim *sim;
> +
> +	DBG("%p", modem);
> +
> +	ofono_devinfo_create(modem, 0, "atmodem", data->chat);
> +	sim =3D ofono_sim_create(modem, OFONO_VENDOR_SIMCOM, "atmodem",
> +				data->chat);
> +
> +	if (sim)
> +		ofono_sim_inserted_notify(sim, data->have_sim);
> +}
> +
> +static void simcom_post_sim(struct ofono_modem *modem)
> +{
> +	struct simcom_data *data =3D ofono_modem_get_data(modem);
> +	struct ofono_gprs *gprs;
> +	struct ofono_gprs_context *gc;
> +
> +	DBG("%p", modem);
> +
> +	ofono_phonebook_create(modem, 0, "atmodem", data->chat);
> +
> +	ofono_sms_create(modem, OFONO_VENDOR_SIMCOM, "atmodem",
> +				data->chat);
> +
> +	gprs =3D ofono_gprs_create(modem, 0, "atmodem", data->chat);
> +	gc =3D ofono_gprs_context_create(modem, 0, "atmodem", data->modem);
> +
> +	if (gprs && gc)
> +		ofono_gprs_add_context(gprs, gc);
> +}
> +
> +static void simcom_post_online(struct ofono_modem *modem)
> +{
> +	struct simcom_data *data =3D ofono_modem_get_data(modem);
> +
> +	DBG("%p", modem);
> +
> +	ofono_netreg_create(modem, OFONO_VENDOR_SIMCOM, "atmodem", data->chat);
> +	/* disable CBS module because it causes a deadlock issue */
> +	/* ofono_cbs_create(modem, OFONO_VENDOR_SIMCOM, "atmodem", */
> +	/*		    data->chat); */

Please don't submit commented out code upstream.  You can always add it =

later.  That is what git is good for.

> +	g_at_chat_send(data->chat, "AT+CSCB=3D0", none_prefix,
> +		       NULL, NULL, NULL);

This is Cell Broadcast related, why is this here?

> +	ofono_ussd_create(modem, 0, "atmodem", data->chat);
> +}
> +
> +static struct ofono_modem_driver simcom_driver =3D {
> +	.name		=3D "simcom",
> +	.probe		=3D simcom_probe,
> +	.remove		=3D simcom_remove,
> +	.enable		=3D simcom_enable,
> +	.disable	=3D simcom_disable,
> +	.set_online     =3D simcom_set_online,
> +	.pre_sim	=3D simcom_pre_sim,
> +	.post_sim	=3D simcom_post_sim,
> +	.post_online	=3D simcom_post_online,
> +};
> +
> +static int simcom_init(void)
> +{
> +	return ofono_modem_driver_register(&simcom_driver);
> +}
> +
> +static void simcom_exit(void)
> +{
> +	ofono_modem_driver_unregister(&simcom_driver);
> +}
> +
> +OFONO_PLUGIN_DEFINE(simcom, "SIMCOM modem driver", VERSION,
> +		    OFONO_PLUGIN_PRIORITY_DEFAULT,
> +		    simcom_init, simcom_exit)
>

Regards,
-Denis

--===============2747736158282062299==--

