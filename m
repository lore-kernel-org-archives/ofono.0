Content-Type: multipart/mixed; boundary="===============0826557735018585650=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/4] SIMCOM plugin driver
Date: Mon, 01 Apr 2013 21:33:56 -0500
Message-ID: <515A4394.2060508@gmail.com>
In-Reply-To: <1363948578-24128-1-git-send-email-viallard@syscom-instruments.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0826557735018585650==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Anthony,

On 03/22/2013 05:36 AM, Anthony Viallard wrote:
> Add SIMCOM support.
>
> Implemented using SIM5216E module and ofono 1.12.
>
>   - based on SIM5215_SIM5216_ATC_V1.18.pdf documentation ;
>   - SMS and GPRS work (in the same time) ;
>   - SIM card presence check ;
>   - use GSM charset ;
>   - use 115200bps, 8 bit data, no parity, 1 bit stop, no data stream cont=
rol
>     for tty configuration ;
>   - flight mode support ;
>   - No voice part (because I can't test it).
>
> --- ofono-1.12.orig/Makefile.am	2012-04-20 21:06:29.000000000 +0200
> +++ ofono-1.12/Makefile.am	2013-01-21 17:17:48.089627277 +0100

Please send this using git send-email.  I cannot apply these patches:

Applying: SIMCOM plugin driver
fatal: sha1 information is lacking or useless (Makefile.am).
Repository lacks necessary blobs to fall back on 3-way merge.
Cannot fall back to three-way merge.
Patch failed at 0001 SIMCOM plugin driver
When you have resolved this problem run "git am --resolved".
If you would prefer to skip this patch, instead run "git am --skip".
To restore the original branch and stop patching run "git am --abort".

> @@ -371,6 +371,9 @@ builtin_sources +=3D plugins/samsung.c
>   builtin_modules +=3D sim900
>   builtin_sources +=3D plugins/sim900.c
>
> +builtin_modules +=3D simcom
> +builtin_sources +=3D plugins/simcom.c
> +
>   if BLUETOOTH
>   builtin_modules +=3D bluetooth
>   builtin_sources +=3D plugins/bluetooth.c plugins/bluetooth.h
> --- /dev/null	2013-01-28 10:34:59.843091650 +0100
> +++ ofono-1.12/plugins/simcom.c	2013-02-15 16:16:38.058552544 +0100
> @@ -0,0 +1,434 @@
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
> +#include<config.h>
> +#endif
> +
> +#include<errno.h>
> +#include<stdlib.h>
> +#include<stdio.h>
> +
> +#include<glib.h>
> +#include<gatchat.h>
> +#include<gattty.h>
> +
> +#define OFONO_API_SUBJECT_TO_CHANGE
> +#include<ofono/plugin.h>
> +#include<ofono/modem.h>
> +#include<ofono/devinfo.h>
> +#include<ofono/netreg.h>
> +#include<ofono/sim.h>
> +#include<ofono/cbs.h>
> +#include<ofono/sms.h>
> +#include<ofono/ussd.h>
> +#include<ofono/gprs.h>
> +#include<ofono/gprs-context.h>
> +#include<ofono/radio-settings.h>
> +#include<ofono/phonebook.h>
> +#include<ofono/log.h>
> +
> +#include<drivers/atmodem/atutil.h>
> +#include<drivers/atmodem/vendor.h>
> +
> +#define MAX_IGNITION_POOL_CALL    7
> +
> +#define CMEERR_SIMBUSY           14
> +
> +static const char *none_prefix[] =3D { NULL };
> +
> +struct simcom_data {
> +	GAtChat *modem;
> +	GAtChat *chat;
> +	guint ignition_pool;
> +	unsigned int ignition_pool_call;
> +	unsigned int at_ignition_pending;
> +	ofono_bool_t have_sim;
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
> +static gboolean simcom_ignition(gpointer user_data)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	struct simcom_data *data =3D ofono_modem_get_data(modem);
> +
> +	++data->ignition_pool_call;
> +
> +	if(data->at_ignition_pending>  0)
> +	{
> +		if(data->ignition_pool_call>  MAX_IGNITION_POOL_CALL)
> +		{
> +			ofono_error("Ignition timeout");
> +			return FALSE;
> +		}
> +
> +		/* Waiting reply of AT commands */
> +		DBG("Waiting AT reply...");
> +		return TRUE;
> +	}
> +
> +	ofono_modem_set_powered(modem, TRUE);
> +
> +	return FALSE;
> +}
> +
> +static void simcom_sim_status(gboolean ok, GAtResult *result, gpointer u=
ser_data)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	struct ofono_error error;
> +	struct simcom_data *data =3D ofono_modem_get_data(modem);
> +
> +	--data->at_ignition_pending;
> +
> +	if(!ok)
> +	{
> +		decode_at_error(&error, g_at_result_final_response(result));
> +		if(error.type =3D=3D OFONO_ERROR_TYPE_CME)
> +		{
> +			if(error.error =3D=3D CMEERR_SIMBUSY)
> +			{
> +				DBG("System is busy. Retry...");
> +				g_at_chat_send(data->chat, "AT+CPIN?",
> +					       none_prefix,
> +					       simcom_sim_status, modem,
> +					       NULL);
> +				++data->at_ignition_pending;
> +				return;
> +			}
> +		}
> +
> +		data->have_sim =3D FALSE;
> +		return;
> +	}
> +
> +	/* If doesn't have an "fatal" error on AT+CPIN request,
> +	 * we can guess there a SIM card ...
> +	 */
> +	data->have_sim =3D TRUE;
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
> +		ofono_modem_set_powered(modem, FALSE);
> +		return;
> +	}
> +
> +	/* Get model and sim card status */
> +	data->at_ignition_pending =3D 0;
> +
> +	g_at_chat_send(data->chat, "AT+CPIN?", none_prefix,
> +		       simcom_sim_status, modem, NULL);
> +	++data->at_ignition_pending;
> +
> +	data->ignition_pool =3D g_timeout_add_seconds(1,
> +						    simcom_ignition,
> +						    modem);

Are you polling CPIN for signs of life? In that case, there's a =

convenience function for this.  Grep for at_util_sim_state_query_new, it =

takes care of all the magic for you.

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
> +	if (device =3D=3D NULL)
> +	{
> +		ofono_error("Failed to get modem '%s'", key);
> +		return NULL;
> +	}

Wrong coding style

> +
> +	DBG("%s %s", key, device);
> +
> +	options =3D g_hash_table_new(g_str_hash, g_str_equal);
> +	if (options =3D=3D NULL)
> +	 	return NULL;
> +
> +	g_hash_table_insert(options, "Baud", "115200");
> +	g_hash_table_insert(options, "Parity", "none");
> +	g_hash_table_insert(options, "StopBits", "1");
> +	g_hash_table_insert(options, "DataBits", "8");
> +	g_hash_table_insert(options, "XonXoff", "off");
> +
> +	channel =3D g_at_tty_open(device, options);
> +
> +	/* g_hash_table_destroy(options); */

Why is this commented out?

> +
> +	if (channel =3D=3D NULL)
> +	{
> +		ofono_error("Failed to get tty for '%s'", key);
> +		return NULL;
> +	}

Coding style is wrong, please see below.

> +
> +	syntax =3D g_at_syntax_new_gsm_permissive();
> +	chat =3D g_at_chat_new(channel, syntax);
> +	g_at_syntax_unref(syntax);
> +
> +	g_io_channel_unref(channel);
> +
> +	if (chat =3D=3D NULL)
> +	{
> +		ofono_error("Failed to get chat for '%s'", key);
> +		return NULL;
> +	}

Again, coding style is wrong.  Please see below.

> +
> +	if (getenv("OFONO_AT_DEBUG"))
> +		g_at_chat_set_debug(chat, simcom_debug, debug);
> +
> +	return chat;
> +}
> +
> +/* Modem interface function */
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
> +	if(data->ignition_pool>  0)
> +	{
> +		g_source_remove(data->ignition_pool);
> +		data->ignition_pool =3D 0;
> +	}
> +
> +	ofono_modem_set_data(modem, NULL);
> +
> +	/* Cleanup after hot-unplug */
> +	g_at_chat_unref(data->chat);
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
> +	data->chat =3D open_device(modem, "Data", "Data: ");
> +	if (data->chat =3D=3D NULL) {
> +		g_at_chat_unref(data->modem);
> +		data->modem =3D NULL;
> +		return -EIO;
> +	}
> +
> +	g_at_chat_set_slave(data->modem, data->chat);
> +
> +	g_at_chat_blacklist_terminator(data->chat,
> +					G_AT_CHAT_TERMINATOR_NO_CARRIER);
> +
> +	/* Configure AT commands behavior */
> +	g_at_chat_send(data->modem, "ATE0 +CMEE=3D1", NULL, NULL, NULL, NULL);
> +	g_at_chat_send(data->chat, "ATE0 +CMEE=3D1", NULL, NULL, NULL, NULL);
> +
> +	/* Ensure that the modem is using GSM character set and not IRA */
> +	g_at_chat_send(data->modem, "AT+CSCS=3D\"GSM\"", none_prefix,
> +			NULL, NULL, NULL);
> +	g_at_chat_send(data->chat, "AT+CSCS=3D\"GSM\"", none_prefix,
> +			NULL, NULL, NULL);
> +
> +	/* Make it up */
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
> +                              ofono_modem_online_cb_t cb, void *user_dat=
a)
> +{
> +	struct simcom_data *data =3D ofono_modem_get_data(modem);
> +	struct cb_data *cbd =3D cb_data_new(cb, user_data);
> +	char const *command =3D online ? "AT+CFUN=3D1" : "AT+CFUN=3D4";
> +
> +	DBG("modem %p %s", modem, online ? "online" : "offline");
> +
> +	if (g_at_chat_send(data->chat, command, none_prefix,
> +			   flightmode_cb, cbd, g_free)>  0)
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
> +	struct ofono_message_waiting *mw;
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
> +	/* gprs things */

This comment is rather useless ;)

> +	gprs =3D ofono_gprs_create(modem, 0, "atmodem", data->chat);
> +	gc =3D ofono_gprs_context_create(modem, 0, "atmodem", data->modem);
> +
> +	if(gprs&&  gc)
> +	{
> +		ofono_gprs_add_context(gprs, gc);
> +	}

This is not according to the coding style.  Please refer to =

doc/coding-style.txt for details.  In particular, there should not be =

any parentheses around the if.  And we use the Linux kernel style, so it =

would look like:

if (gprs && gc) {
	foo;
	bar;
}

> +}
> +
> +static void simcom_post_online(struct ofono_modem *modem)
> +{
> +	struct simcom_data *data =3D ofono_modem_get_data(modem);
> +
> +	DBG("%p", modem);
> +
> +	ofono_netreg_create(modem, OFONO_VENDOR_SIMCOM, "atmodem", data->chat);
> +	ofono_cbs_create(modem, 0, "atmodem", data->chat);
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

There is whitespace corruption here, do not use spaces for indentation.

> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono

Regards,
-Denis

--===============0826557735018585650==--

