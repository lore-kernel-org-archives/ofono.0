Content-Type: multipart/mixed; boundary="===============7613007726483440187=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Simcom support
Date: Tue, 12 Mar 2013 13:17:24 -0500
Message-ID: <513F7134.2010000@gmail.com>
In-Reply-To: <1361956929-659-1-git-send-email-viallard@syscom-instruments.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7613007726483440187==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Anthony,

On 02/27/2013 03:22 AM, Anthony Viallard wrote:
> Add SIMCOM support.
>
> I developped this with the SIM5216E chipset and ofono 1.12.
>
>   - SMS and GPRS work (in the same time) ;
>   - SIM card presence check ;
>   - No voice part because I can't test it ;
>   - Use default characters set instead GSM because it works like that
>     for what I'm doing (SMS+GPRS) (by default, the set is IRA for SIM5216=
E).
>     Also, the SIMCOM doc affraids me about problems when using GSM
>     (this setting causes easily software flow control (XON /XOFF) problem=
s.).
>
> Signed-off-by: Anthony Viallard<homer242@gmail.com>

We do not use Signed-off-by, so please configure your client not to send =

this.

> --- ofono-1.12.orig/Makefile.am	2012-04-20 21:06:29.000000000 +0200
> +++ ofono-1.12/Makefile.am	2013-01-21 17:17:48.089627277 +0100
> @@ -371,6 +371,9 @@ builtin_sources +=3D plugins/samsung.c
>   builtin_modules +=3D sim900
>   builtin_sources +=3D plugins/sim900.c
>
> +builtin_modules +=3D simcom
> +builtin_sources +=3D plugins/simcom.c
> +

This belongs in a separate patch (along with plugins/simcom.c changes)

>   if BLUETOOTH
>   builtin_modules +=3D bluetooth
>   builtin_sources +=3D plugins/bluetooth.c plugins/bluetooth.h
> --- ofono-1.12.orig/drivers/atmodem/sms.c	2012-04-20 21:06:29.000000000 +=
0200
> +++ ofono-1.12/drivers/atmodem/sms.c	2013-01-21 16:48:44.460627485 +0100
> @@ -805,6 +807,7 @@ static gboolean build_cnmi_string(char *
>   	case OFONO_VENDOR_NOVATEL:
>   	case OFONO_VENDOR_HUAWEI:
>   	case OFONO_VENDOR_ZTE:
> +	case OFONO_VENDOR_SIMCOM:
>   		/* MSM devices advertise support for mode 2, but return an
>   		 * error if we attempt to actually use it. */
>   		mode =3D "1";

This belongs in a separate patch

> diff -pruN ofono-1.12.orig/drivers/atmodem/sim.c ofono-1.12/drivers/atmod=
em/sim.c
> --- ofono-1.12.orig/drivers/atmodem/sim.c	2013-01-23 11:38:22.959609087 +=
0100
> +++ ofono-1.12/drivers/atmodem/sim.c	2013-01-23 11:57:52.602608948 +0100
> @@ -1023,12 +1023,18 @@ static void at_pin_send_cb(gboolean ok,
>   							FALSE, cbd, g_free);
>   		return;
>   	case OFONO_VENDOR_ZTE:
>   	case OFONO_VENDOR_ALCATEL:
>   	case OFONO_VENDOR_HUAWEI:
> +	case OFONO_VENDOR_SIMCOM:
>   		/*
>   		 * On ZTE modems, after pin is entered, SIM state is checked
>   		 * by polling CPIN as their modem doesn't provide unsolicited
>   		 * notification of SIM readiness.
> +		 *
> +		 * On SIMCOM modems, SIM is busy after pin is entered (we've
> +		 * got an "+CME ERROR: 14" at "AT+CPIN?" request) and ofono
> +		 * don't catch the "+CPIN: READY" message sent by the modem
> +		 * when SIM is ready. So, use extra CPIN to check the state.
>   		 */
>   		sd->sim_state_query =3D at_util_sim_state_query_new(sd->chat,
>   						2, 20, sim_state_cb, cbd,

as above

> diff -purN ofono-1.12/drivers/atmodem/network-registration.c ofono-patche=
d/drivers/atmodem/network-registration.c
> --- ofono-1.12/drivers/atmodem/network-registration.c	2013-01-18 15:04:03=
.598659165 +0100
> +++ ofono-patched/drivers/atmodem/network-registration.c	2013-01-18 14:54=
:03.256659236 +0100
> @@ -1411,6 +1411,14 @@ static void at_creg_set_cb(gboolean ok,
>   	}
>
>   	switch (nd->vendor) {
> +	case OFONO_VENDOR_SIMCOM:
> +		/* Register for CSQ changes */
> +		g_at_chat_send(nd->chat, "AT+AUTOCSQ=3D1,1", none_prefix,
> +				NULL, NULL, NULL);
> +
> +		g_at_chat_register(nd->chat, "+CSQ:",
> + 				   csq_notify, FALSE, netreg, NULL);
> + 		break;
>   	case OFONO_VENDOR_PHONESIM:
>   		g_at_chat_register(nd->chat, "+CSQ:",
>   					csq_notify, FALSE, netreg, NULL);

as above

> @@ -1534,7 +1537,6 @@ static void at_creg_set_cb(gboolean ok,
>   		break;
>   	case OFONO_VENDOR_NOKIA:
>   	case OFONO_VENDOR_SAMSUNG:
> -	case OFONO_VENDOR_SIMCOM:
>   		/* Signal strength reporting via CIND is not supported */
>   		break;
>   	default:
>
> --- /dev/null	2013-01-28 10:34:59.843091650 +0100
> +++ ofono-1.12/plugins/simcom.c	2013-02-15 16:16:38.058552544 +0100
> @@ -0,0 +1,401 @@
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
> +	GAtChat *data;
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
> +				g_at_chat_send(data->data, "AT+CPIN?",
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
> +		g_at_chat_unref(data->data);
> +		data->data =3D NULL;
> +
> +		ofono_modem_set_powered(modem, FALSE);
> +		return;
> +	}
> +
> +	/* Get model and sim card status */
> +	data->at_ignition_pending =3D 0;
> +
> +	g_at_chat_send(data->data, "AT+CPIN?", none_prefix,
> +		       simcom_sim_status, modem, NULL);
> +	++data->at_ignition_pending;
> +
> +	data->ignition_pool =3D g_timeout_add_seconds(1,
> +						    simcom_ignition,
> +						    modem);
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
> +	g_at_chat_unref(data->data);
> +	data->data =3D NULL;
> +
> +	if (ok)
> +		ofono_modem_set_powered(modem, FALSE);
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
> +	/* GHashTable *options; */
> +
> +	device =3D ofono_modem_get_string(modem, key);
> +	if (device =3D=3D NULL)
> +	{
> +		ofono_error("Failed to get modem '%s'", key);
> +		return NULL;
> +	}
> +
> +	DBG("%s %s", key, device);
> +
> +	/* options =3D g_hash_table_new(g_str_hash, g_str_equal); */
> +	/* if (options =3D=3D NULL) */
> +	/* 	return NULL; */
> +
> +	/* g_hash_table_insert(options, "Baud", "115200"); */
> +	/* g_hash_table_insert(options, "Parity", "none"); */
> +	/* g_hash_table_insert(options, "StopBits", "1"); */
> +	/* g_hash_table_insert(options, "DataBits", "8"); */
> +	/* g_hash_table_insert(options, "XonXoff", "off"); */
> +	/* g_hash_table_insert(options, "RtsCts", "on"); */
> +	/* g_hash_table_insert(options, "Local", "on"); */
> +	/* g_hash_table_insert(options, "Read", "on"); */
> +
> +	channel =3D g_at_tty_open(device, NULL);
> +
> +	/* g_hash_table_destroy(options); */
> +
> +	if (channel =3D=3D NULL)
> +	{
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
> +	if (chat =3D=3D NULL)
> +	{
> +		ofono_error("Failed to get chat for '%s'", key);
> +		return NULL;
> +	}
> +
> +	//if (getenv("OFONO_AT_DEBUG"))
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
> +	g_at_chat_unref(data->data);
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
> +	data->data =3D open_device(modem, "Data", "Data: ");
> +	if (data->data =3D=3D NULL) {
> +		g_at_chat_unref(data->modem);
> +		data->modem =3D NULL;
> +		return -EIO;
> +	}
> +
> +	g_at_chat_set_slave(data->modem, data->data);
> +
> +	g_at_chat_blacklist_terminator(data->data,
> +					G_AT_CHAT_TERMINATOR_NO_CARRIER);
> +
> +	/* init modem */
> +	g_at_chat_send(data->modem, "ATE0 +CMEE=3D1", NULL, NULL, NULL, NULL);
> +	g_at_chat_send(data->data, "ATE0 +CMEE=3D1", NULL, NULL, NULL, NULL);
> +
> +	g_at_chat_send(data->data, "AT+CFUN=3D1", none_prefix,
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
> +	g_at_chat_cancel_all(data->data);
> +	g_at_chat_unregister_all(data->data);
> +
> +	g_at_chat_send(data->data, "AT+CFUN=3D4", none_prefix,
> +		       cfun_disable, modem, NULL);
> +
> +	return -EINPROGRESS;
> +}
> +
> +static void simcom_pre_sim(struct ofono_modem *modem)
> +{
> +	struct simcom_data *data =3D ofono_modem_get_data(modem);
> +	struct ofono_sim *sim;
> +
> +	DBG("%p", modem);
> +
> +	ofono_devinfo_create(modem, 0, "atmodem", data->data);
> +	sim =3D ofono_sim_create(modem, OFONO_VENDOR_SIMCOM, "atmodem",
> +				data->data);
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
> +	ofono_phonebook_create(modem, 0, "atmodem", data->data);
> +
> +	ofono_sms_create(modem, OFONO_VENDOR_SIMCOM, "atmodem",
> +				data->data);
> +
> +	/* gprs things */
> +	gprs =3D ofono_gprs_create(modem, 0, "atmodem", data->data);
> +	gc =3D ofono_gprs_context_create(modem, 0, "atmodem", data->modem);
> +
> +	if(gprs&&  gc)
> +	{
> +		ofono_gprs_add_context(gprs, gc);
> +	}
> +}
> +
> +static void simcom_post_online(struct ofono_modem *modem)
> +{
> +	struct simcom_data *data =3D ofono_modem_get_data(modem);
> +
> +	DBG("%p", modem);
> +
> +	ofono_netreg_create(modem, OFONO_VENDOR_SIMCOM, "atmodem", data->data);
> +	ofono_cbs_create(modem, 0, "atmodem", data->data);
> +	ofono_ussd_create(modem, 0, "atmodem", data->data);
> +}
> +
> +static struct ofono_modem_driver simcom_driver =3D {
> +	.name		=3D "simcom",
> +	.probe		=3D simcom_probe,
> +	.remove		=3D simcom_remove,
> +	.enable		=3D simcom_enable,
> +	.disable	=3D simcom_disable,
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

Please use git send-email to submit these patches as a series.

Regards,
-Denis


--===============7613007726483440187==--

