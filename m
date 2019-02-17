Content-Type: multipart/mixed; boundary="===============4800253631891239539=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: Re: [PATCH 1/8] ublox-serial: add new plugin for u-blox
Date: Sun, 17 Feb 2019 16:08:07 +0100
Message-ID: <c0c3b966-7aba-75a7-1e24-bb14dfae0edf@norrbonn.se>
In-Reply-To: <20190215121142.28163-2-philippedeswert@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4800253631891239539==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

My overriding comment here is to try to combine this with the existing =

ublox plugin.  That said, there are some comments below.

/Jonas

On 15/02/2019 13:11, philippedeswert(a)gmail.com wrote:
> From: Philippe De Swert <philippe.deswert@digitalistgroup.com>
> =

> Add support for ublox modems that are used over the serial port.
> (tested on SARA-R410M and R412M)
> ---
>   plugins/ublox-serial.c | 393 +++++++++++++++++++++++++++++++++++++++++
>   plugins/udevng.c       |   1 +
>   2 files changed, 394 insertions(+)
>   create mode 100644 plugins/ublox-serial.c
> =

> diff --git a/plugins/ublox-serial.c b/plugins/ublox-serial.c
> new file mode 100644
> index 00000000..4f0cf5f3
> --- /dev/null
> +++ b/plugins/ublox-serial.c
> @@ -0,0 +1,393 @@
> +/*
> + *
> + *  oFono - Open Source Telephony
> + *
> + *  Copyright (C) 2014  Philip Paeps. All rights reserved.
> + *  Copyright (C) 2018-2019 Treon oy. All rights reserved.
> + *
> + *  Inspired on the Ublox driver by Philip Paeps
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
> +#include <string.h>
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
> +#include <ofono/gprs.h>
> +#include <ofono/gprs-context.h>
> +#include <ofono/netmon.h>
> +#include <ofono/lte.h>
> +
> +#include <drivers/atmodem/atutil.h>
> +#include <drivers/atmodem/vendor.h>
> +
> +static const char *none_prefix[] =3D { NULL };
> +
> +struct ublox_data {
> +	GIOChannel *device;
> +	GAtChat *modem;
> +	GAtChat *dlc;
> +	int model_id;
> +	enum ofono_vendor vendor_family;
> +	guint frame_size;
> +};
> +
> +static void ublox_debug(const char *str, void *user_data)
> +{
> +	const char *prefix =3D user_data;
> +
> +	ofono_info("%s%s", prefix, str);
> +}
> +
> +static int ublox_probe(struct ofono_modem *modem)
> +{
> +	struct ublox_data *data;
> +
> +	DBG("%p", modem);
> +
> +	data =3D g_try_new0(struct ublox_data, 1);
> +	if (data =3D=3D NULL)
> +		return -ENOMEM;
> +
> +	ofono_modem_set_data(modem, data);
> +
> +	return 0;
> +}
> +
> +static void ublox_remove(struct ofono_modem *modem)
> +{
> +	struct ublox_data *data =3D ofono_modem_get_data(modem);
> +
> +	DBG("%p", modem);
> +
> +	ofono_modem_set_data(modem, NULL);
> +	g_at_chat_unref(data->modem);
> +	g_free(data);
> +}
> +

Your implementation of open_device is the same as the implementation in =

ublox.c with the addition of communication settings.  You could easily =

add this as open_serial_device in the ublox.c and call it for serial modems.

> +static GAtChat *open_device(struct ofono_modem *modem,
> +				const char *key, char *debug)
> +{
> +	struct ublox_data *data =3D ofono_modem_get_data(modem);
> +	const char *device;
> +	GAtSyntax *syntax;
> +	GIOChannel *channel;
> +	GAtChat *chat;
> +	GHashTable *options;
> +
> +	device =3D ofono_modem_get_string(modem, key);
> +	if (device =3D=3D NULL)
> +	{
> +		DBG("device =3D NULL");
> +		return NULL;
> +	}
> +	DBG("%s %s", key, device);
> +
> +        options =3D g_hash_table_new(g_str_hash, g_str_equal);
> +        if (options =3D=3D NULL)
> +		return NULL;
> +
> +        g_hash_table_insert(options, "Baud", "115200");
> +        g_hash_table_insert(options, "Parity", "none");
> +        g_hash_table_insert(options, "StopBits", "1");
> +        g_hash_table_insert(options, "DataBits", "8");
> +        g_hash_table_insert(options, "XonXoff", "on");
> +        g_hash_table_insert(options, "Local", "on");
> +        g_hash_table_insert(options, "RtsCts", "off");
> +        g_hash_table_insert(options, "Read", "on");
> +
> +	channel =3D g_at_tty_open(device, options);
> +        g_hash_table_destroy(options);
> +
> +	if (channel =3D=3D NULL)
> +		return NULL;
> +
> +	data->device =3D channel;
> +	syntax =3D g_at_syntax_new_gsm_permissive();
> +	chat =3D g_at_chat_new(channel, syntax);
> +	g_at_syntax_unref(syntax);
> +
> +	g_io_channel_unref(channel);
> +
> +	if (chat =3D=3D NULL)
> +		return NULL;
> +
> +	if (getenv("OFONO_AT_DEBUG"))
> +		g_at_chat_set_debug(chat, ublox_debug, debug);
> +
> +	return chat;
> +}
> +
> +#if 0

Here's a big block of commented out code.  This isn't from the ublox =

driver...

> +static GAtChat *create_chat(GIOChannel *channel, struct ofono_modem *mod=
em,
> +                                char *debug)
> +{
> +        GAtSyntax *syntax;
> +        GAtChat *chat;
> +
> +        if (channel =3D=3D NULL)
> +                return NULL;
> +
> +        syntax =3D g_at_syntax_new_gsmv1();
> +        chat =3D g_at_chat_new(channel, syntax);
> +        g_at_syntax_unref(syntax);
> +        g_io_channel_unref(channel);
> +
> +        if (chat =3D=3D NULL)
> +                return NULL;
> +
> +        if (getenv("OFONO_AT_DEBUG"))
> +                g_at_chat_set_debug(chat, ublox_debug, debug);
> +
> +        return chat;
> +}
> +
> +static void shutdown_device(struct ublox_data *data)
> +{
> +        DBG("");
> +
> +        g_at_chat_unref(data->dlc);
> +        data->dlc =3D NULL;
> +
> +        g_io_channel_unref(data->device);
> +        data->device =3D NULL;
> +}
> +#endif

... that ends here.  Drop all of this.

> +
> +static void cfun_enable(gboolean ok, GAtResult *result, gpointer user_da=
ta)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	struct ublox_data * data =3D ofono_modem_get_data(modem);
> +
> +	DBG("ok %d", ok);
> +
> +	if (!ok) {
> +		g_at_chat_unref(data->modem);
> +		data->modem =3D NULL;
> +		ofono_modem_set_powered(modem, FALSE);
> +		DBG("CFUN failed");
> +		return;
> +	}
> +        ofono_modem_set_powered(modem, TRUE);
> +	DBG("Powered on!");
> +}
> +
> +static int ublox_enable(struct ofono_modem *modem)
> +{
> +	struct ublox_data *data =3D ofono_modem_get_data(modem);
> +	const char *model_str =3D NULL;
> +
> +	DBG("%p", modem);
> +
> +	model_str =3D ofono_modem_get_string(modem, "Model");
> +	DBG("%p is model %s", modem, model_str);
> +	if (model_str =3D=3D NULL)
> +		model_str =3D strdup("SARA_R410");
> +		//return -EINVAL;
> +

As you are going via add_serial_device() in udevng.c, the Model string =

will not be set so you don't even need to check for this.  That said, =

you aren't using the model_str value for anything anyway, so just drop it.

> +	data->model_id =3D atoi(model_str);

atoi("SARA_R410") looks interesting... does this work?

> +
> +	switch (data->model_id) {

Drop the switch as you have no options here.

> +	default:
> +		DBG("unknown ublox model id %d", data->model_id);

Unknown?

> +		//return -EINVAL;
> +		data->vendor_family =3D OFONO_VENDOR_UBLOX;



> +		break;
> +	}
> +
> +	if (data->vendor_family =3D=3D OFONO_VENDOR_UBLOX) {

You've asked for this above... no need for the if() statement.


> +		data->dlc =3D open_device(modem, "Device", "Setup: ");

> +		if (data->dlc =3D=3D NULL) {
> +			g_at_chat_unref(data->dlc);

_unref(NULL) ... not necessary.

> +			data->dlc =3D NULL;

You already tested for this above.  This is a no-op.

> +			DBG("open_device failed!");
> +			return -EIO;

> +		}
> +

If you stuck to the name data->aux above and opened either "Device" or =

"Aux" depending on existence of the string or on device model then your =

diff against ublox.c is automatically 50% as big as now.


> +		g_at_chat_set_slave(data->modem, data->dlc);
> +
> +		g_at_chat_send(data->dlc, "AT+CFUN=3D0", none_prefix,
> +						NULL, NULL, NULL);
> +
> +		g_at_chat_send(data->dlc, "AT+UMNOPROF=3D1", NULL, NULL, NULL, NULL);
> +		//enable roaming in the modem
> +		g_at_chat_send(data->dlc, "AT+UDCONF=3D76,1,0", NULL, NULL, NULL, NULL=
);
> +	}
> +
> +	/* The modem can take a while to wake up if just powered on. */
> +	//g_at_chat_set_wakeup_command(data->dlcs[SETUP_DLC], "AT\r", 1000, 110=
00);

->dlcs does not exist... you don't enable mux'ing anywhere in the =

driver.  Yes, I realize this is commented out, but there's half of a =

thought here that I'd like to reconcile since you've left the commented =

code in place.  Did you intend on using mux'ing later?  Either way, I =

think you pretty much just end up with MUX on channel 0, AUX on channel =

1, and MODEM on channel2 and if you set up the chats accordingly then =

everything becomes independent of underlying device... (or something =

like that, I think).

> +
> +	g_at_chat_send(data->dlc, "ATE0 +CMEE=3D1", none_prefix,
> +					NULL, NULL, NULL);
> +
> +	g_at_chat_send(data->dlc, "AT+CFUN=3D4", none_prefix,
> +					cfun_enable, modem, NULL);
> +
> +	DBG("Return in progress");
> +	return -EINPROGRESS;
> +}
> +
> +static void cfun_disable(gboolean ok, GAtResult *result, gpointer user_d=
ata)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	struct ublox_data *data =3D ofono_modem_get_data(modem);
> +
> +	DBG("");
> +
> +	g_at_chat_unref(data->dlc);
> +	data->dlc =3D NULL;
> +
> +	if (ok)
> +		ofono_modem_set_powered(modem, FALSE);
> +}
> +
> +static int ublox_disable(struct ofono_modem *modem)
> +{
> +	struct ublox_data *data =3D ofono_modem_get_data(modem);
> +
> +	DBG("%p", modem);
> +
> +	g_at_chat_cancel_all(data->dlc);
> +	g_at_chat_unregister_all(data->dlc);
> +
> +	g_at_chat_send(data->dlc, "AT+CFUN=3D4", none_prefix,
> +					cfun_disable, modem, NULL);
> +
> +	g_at_chat_unref(data->modem);
> +	data->modem =3D NULL;
> +
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
> +	DBG("online!?");
> +}
> +
> +static void ublox_set_online(struct ofono_modem *modem, ofono_bool_t onl=
ine,
> +				ofono_modem_online_cb_t cb, void *user_data)
> +{
> +	struct ublox_data *data =3D ofono_modem_get_data(modem);
> +	struct cb_data *cbd =3D cb_data_new(cb, user_data);
> +	char const *command =3D online ? "AT+CFUN=3D1" : "AT+CFUN=3D4";
> +
> +	DBG("modem %p %s", modem, online ? "online" : "offline");
> +
> +	if (g_at_chat_send(data->dlc, command, none_prefix, set_online_cb,
> +					cbd, g_free) > 0)
> +		return;
> +
> +	CALLBACK_WITH_FAILURE(cb, cbd->data);
> +
> +	g_free(cbd);
> +}
> +
> +static void ublox_pre_sim(struct ofono_modem *modem)
> +{
> +	struct ublox_data *data =3D ofono_modem_get_data(modem);
> +	struct ofono_sim *sim;
> +
> +	DBG("%p", modem);
> +
> +	ofono_devinfo_create(modem, 0, "atmodem", data->dlc);
> +	DBG("%p devinfo created", modem);
> +	sim =3D ofono_sim_create(modem, data->vendor_family, "atmodem",
> +					data->dlc);
> +
> +	DBG("%p sim created", modem);
> +
> +	if (sim)
> +	{
> +		DBG("%p sim notification", modem);
> +		ofono_sim_inserted_notify(sim, TRUE);
> +	}
> +}
> +
> +static void ublox_post_sim(struct ofono_modem *modem)
> +{
> +	struct ublox_data *data =3D ofono_modem_get_data(modem);
> +	struct ofono_gprs *gprs;
> +	struct ofono_gprs_context *gc;
> +	GAtChat *chat =3D data->dlc;
> +	const char *driver =3D "atmodem";
> +
> +	DBG("%p", modem);
> +
> +	gprs =3D ofono_gprs_create(modem, data->vendor_family, "atmodem",
> +					data->dlc);
> +
> +	gc =3D ofono_gprs_context_create(modem, data->vendor_family,
> +						driver, chat);
> +
> +	if (gprs && gc)
> +		ofono_gprs_add_context(gprs, gc);
> +
> +	ofono_lte_create(modem, 0, "atmodem", data->dlc);

The 'atmodem' variant of the lte atom uses CGAUTH for setting up the =

default bearer configuration.  This command isn't available on the =

SARA-R4, as far as I can see.

The current u-blox LTE driver uses CGDFLT, but that isn't available on =

your modem either (only on the TOBY L2).  You probably want UAUTHREQ here...

> +}
> +
> +static void ublox_post_online(struct ofono_modem *modem)
> +{
> +	struct ublox_data *data =3D ofono_modem_get_data(modem);
> +
> +	ofono_netreg_create(modem, data->vendor_family, "atmodem", data->dlc);
> +
> +	ofono_netmon_create(modem, data->vendor_family, "ubloxserial", data->mo=
dem);
> +}
> +
> +static struct ofono_modem_driver ublox_driver =3D {
> +	.name		=3D "ubloxserial",
> +	.probe		=3D ublox_probe,
> +	.remove		=3D ublox_remove,
> +	.enable		=3D ublox_enable,
> +	.disable	=3D ublox_disable,
> +	.set_online	=3D ublox_set_online,
> +	.pre_sim	=3D ublox_pre_sim,
> +	.post_sim	=3D ublox_post_sim,
> +	.post_online	=3D ublox_post_online,
> +};
> +
> +static int ublox_init(void)
> +{
> +	return ofono_modem_driver_register(&ublox_driver);
> +}
> +
> +static void ublox_exit(void)
> +{
> +	ofono_modem_driver_unregister(&ublox_driver);
> +}
> +
> +OFONO_PLUGIN_DEFINE(ubloxserial, "u-blox serial modem driver", VERSION,
> +		OFONO_PLUGIN_PRIORITY_DEFAULT, ublox_init, ublox_exit)
> diff --git a/plugins/udevng.c b/plugins/udevng.c
> index ce8cdee1..d95fc527 100644
> --- a/plugins/udevng.c
> +++ b/plugins/udevng.c
> @@ -1322,6 +1322,7 @@ static struct {
>   	{ "cinterion",	setup_serial_modem	},
>   	{ "nokiacdma",	setup_serial_modem	},
>   	{ "sim900",	setup_serial_modem	},
> +	{ "ubloxserial",setup_serial_modem	},
>   	{ "wavecom",	setup_wavecom		},
>   	{ "tc65",	setup_tc65		},
>   	{ "ehs6",	setup_ehs6		},
>=20

--===============4800253631891239539==--

