Content-Type: multipart/mixed; boundary="===============4671939137726301211=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Create a SpeedUp plugin, using standard AT Modem,
 and add corresponding udev rules
Date: Wed, 06 Jul 2011 00:53:29 -0500
Message-ID: <4E13F859.4070104@gmail.com>
In-Reply-To: <1309955657-14565-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4671939137726301211==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bertrand,

On 07/06/2011 07:34 AM, Bertrand Aygon wrote:
> ---
>  Makefile.am         |    3 +
>  plugins/ofono.rules |    9 ++
>  plugins/speedup.c   |  334 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  plugins/udev.c      |   54 ++++++++
>  4 files changed, 400 insertions(+), 0 deletions(-)
>  create mode 100644 plugins/speedup.c
> =


Can you split this up into two patches, one adding the speedup plugin +
Makefile.am changes and one for udev/ofono.rules

> diff --git a/Makefile.am b/Makefile.am
> index dd4fb8f..ffe2e98 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -329,6 +329,9 @@ builtin_sources +=3D plugins/linktop.c
>  builtin_modules +=3D telit
>  builtin_sources +=3D plugins/telit.c
>  =

> +builtin_modules +=3D speedup
> +builtin_sources +=3D plugins/speedup.c
> +
>  if BLUETOOTH
>  builtin_modules +=3D bluetooth
>  builtin_sources +=3D plugins/bluetooth.c plugins/bluetooth.h
> diff --git a/plugins/ofono.rules b/plugins/ofono.rules
> index 268b327..3d66723 100644
> --- a/plugins/ofono.rules
> +++ b/plugins/ofono.rules
> @@ -344,6 +344,10 @@ ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"=
1485", ENV{OFONO_IFACE_NUM}=3D=3D"02", E
>  ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1486", ENV{OFONO_IFA=
CE_NUM}=3D=3D"00", ENV{OFONO_HUAWEI_TYPE}=3D"Modem"
>  ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1486", ENV{OFONO_IFA=
CE_NUM}=3D=3D"02", ENV{OFONO_HUAWEI_TYPE}=3D"Pcui"
>  =

> +# SpeedUp 9800
> +ATTRS{idVendor}=3D=3D"1c9e", ATTRS{idProduct}=3D=3D"9800", ENV{OFONO_IFA=
CE_NUM}=3D=3D"01", ENV{OFONO_SPEEDUP_TYPE}=3D"modem"
> +ATTRS{idVendor}=3D=3D"1c9e", ATTRS{idProduct}=3D=3D"9800", ENV{OFONO_IFA=
CE_NUM}=3D=3D"02", ENV{OFONO_SPEEDUP_TYPE}=3D"aux"
> +
>  LABEL=3D"ofono_tty_end"
>  =

>  # ISI/Phonet drivers
> @@ -384,6 +388,11 @@ ATTRS{idVendor}=3D=3D"19d2", ENV{OFONO_DRIVER}=3D"zt=
e"
>  =

>  ATTRS{idVendor}=3D=3D"19d2", ATTRS{serial}=3D=3D"1234567890ABCDEF", ENV{=
ID_SERIAL_SHORT}=3D""
>  =

> +# SpeedUp
> +ATTRS{idVendor}=3D=3D"1c9e", ENV{OFONO_DRIVER}=3D"speedup"
> +
> +ATTRS{idVendor}=3D=3D"1c9e", ATTRS{serial}=3D=3D"1234567890ABCDEF", ENV{=
ID_SERIAL_SHORT}=3D""
> +
>  # Option Globetrotter
>  ATTRS{idVendor}=3D=3D"0af0", ATTRS{idProduct}=3D=3D"6911", ENV{OFONO_DRI=
VER}=3D"hso"
>  ATTRS{idVendor}=3D=3D"0af0", ATTRS{idProduct}=3D=3D"6971", ENV{OFONO_DRI=
VER}=3D"hso"
> diff --git a/plugins/speedup.c b/plugins/speedup.c
> new file mode 100644
> index 0000000..23813a5
> --- /dev/null
> +++ b/plugins/speedup.c
> @@ -0,0 +1,334 @@
> +/*
> + *
> + *  oFono - Open Source Telephony
> + *
> + *  Copyright (C) 2008-2010  Intel Corporation. All rights reserved.

Copyright year should be updated accordingly

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
> +#include <stdio.h>
> +#include <errno.h>
> +#include <stdlib.h>
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
> +#include <ofono/phonebook.h>
> +#include <ofono/log.h>
> +
> +#include <drivers/atmodem/atutil.h>
> +#include <drivers/atmodem/vendor.h>
> +
> +static const char *none_prefix[] =3D { NULL };
> +
> +struct speedup_data {
> +	GAtChat *modem;
> +	GAtChat *aux;
> +	struct ofono_gprs *gprs;
> +	struct ofono_gprs_context *gc;
> +};
> +
> +static int speedup_probe(struct ofono_modem *modem)
> +{
> +	struct speedup_data *data;
> +
> +	DBG("%p", modem);
> +
> +	data =3D g_try_new0(struct speedup_data, 1);
> +	if (data =3D=3D NULL)
> +		return -ENOMEM;
> +
> +	ofono_modem_set_data(modem, data);
> +
> +	return 0;
> +}
> +
> +static void speedup_remove(struct ofono_modem *modem)
> +{
> +	struct speedup_data *data =3D ofono_modem_get_data(modem);
> +
> +	DBG("%p", modem);
> +
> +	ofono_modem_set_data(modem, NULL);
> +
> +	g_at_chat_unref(data->modem);
> +	g_at_chat_unref(data->aux);
> +
> +	g_free(data);
> +}
> +
> +static void speedup_debug(const char *str, void *user_data)
> +{
> +        const char *prefix =3D user_data;
> +
> +        ofono_info("%s%s", prefix, str);
> +}
> +
> +static GAtChat *open_device(struct ofono_modem *modem,
> +				const char *key, char *debug)
> +{
> +	const char *device;
> +	GAtSyntax *syntax;
> +	GIOChannel *channel;
> +	GAtChat *chat;
> +
> +	device =3D ofono_modem_get_string(modem, key);
> +	if (device =3D=3D NULL)
> +		return NULL;
> +
> +	DBG("%s %s", key, device);
> +
> +	channel =3D g_at_tty_open(device, NULL);
> +	if (channel =3D=3D NULL)
> +		return NULL;
> +
> +	syntax =3D g_at_syntax_new_gsm_permissive();
> +	chat =3D g_at_chat_new(channel, syntax);
> +	g_at_syntax_unref(syntax);
> +	g_io_channel_unref(channel);
> +
> +	if (chat =3D=3D NULL)
> +		return NULL;
> +
> +	if (getenv("OFONO_AT_DEBUG"))
> +		g_at_chat_set_debug(chat, speedup_debug, debug);
> +
> +	return chat;
> +}
> +
> +static void speedup_disconnect(gpointer user_data)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	struct speedup_data *data =3D ofono_modem_get_data(modem);
> +
> +	DBG("");
> +
> +	ofono_gprs_context_remove(data->gc);
> +
> +	g_at_chat_unref(data->modem);
> +	data->modem =3D NULL;
> +
> +	data->modem =3D open_device(modem, "Modem", "Modem: ");
> +	if (data->modem =3D=3D NULL)
> +		return;
> +
> +	g_at_chat_set_disconnect_function(data->modem,
> +						speedup_disconnect, modem);
> +
> +	ofono_info("Reopened GPRS context channel");
> +
> +	data->gc =3D ofono_gprs_context_create(modem, 0, "atmodem", data->modem=
);
> +
> +	if (data->gprs && data->gc)
> +		ofono_gprs_add_context(data->gprs, data->gc);
> +}
> +
> +static void cfun_enable(gboolean ok, GAtResult *result, gpointer user_da=
ta)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +
> +	DBG("");
> +
> +	ofono_modem_set_powered(modem, ok);
> +}
> +
> +static int speedup_enable(struct ofono_modem *modem)
> +{
> +	struct speedup_data *data =3D ofono_modem_get_data(modem);
> +
> +	DBG("%p", modem);
> +
> +	data->modem =3D open_device(modem, "Modem", "Modem: ");
> +	if (data->modem =3D=3D NULL)
> +		return -EINVAL;
> +
> +	g_at_chat_set_disconnect_function(data->modem,
> +						speedup_disconnect, modem);
> +
> +	data->aux =3D open_device(modem, "Aux", "Aux: ");
> +	if (data->aux =3D=3D NULL) {
> +		g_at_chat_unref(data->modem);
> +		data->modem =3D NULL;
> +		return -EIO;
> +	}
> +
> +	g_at_chat_send(data->aux, "ATE0 +CMEE=3D1", none_prefix,
> +						NULL, NULL, NULL);
> +
> +	g_at_chat_send(data->aux, "AT+CFUN=3D1", none_prefix,
> +					cfun_enable, modem, NULL);
> +
> +	return -EINPROGRESS;
> +}
> +
> +static void cfun_disable(gboolean ok, GAtResult *result, gpointer user_d=
ata)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	struct speedup_data *data =3D ofono_modem_get_data(modem);
> +
> +	DBG("");
> +
> +	g_at_chat_unref(data->aux);
> +	data->aux =3D NULL;
> +
> +	if (ok)
> +		ofono_modem_set_powered(modem, FALSE);
> +}
> +
> +static int speedup_disable(struct ofono_modem *modem)
> +{
> +	struct speedup_data *data =3D ofono_modem_get_data(modem);
> +
> +	DBG("%p", modem);
> +
> +	if (data->modem) {
> +		g_at_chat_cancel_all(data->modem);
> +		g_at_chat_unregister_all(data->modem);
> +		g_at_chat_unref(data->modem);
> +		data->modem =3D NULL;
> +	}
> +
> +	if (data->aux =3D=3D NULL)
> +		return 0;
> +
> +	g_at_chat_cancel_all(data->aux);
> +	g_at_chat_unregister_all(data->aux);
> +	g_at_chat_send(data->aux, "AT+CFUN=3D0", none_prefix,
> +					cfun_disable, modem, NULL);
> +
> +	return -EINPROGRESS;
> +}
> +
> +static void set_online_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
> +{
> +	struct cb_data *cbd =3D user_data;
> +	ofono_modem_online_cb_t cb =3D cbd->cb;
> +
> +	if (ok)
> +		CALLBACK_WITH_SUCCESS(cb, cbd->data);
> +	else
> +		CALLBACK_WITH_FAILURE(cb, cbd->data);

Please avoid this construct when possible, it is better to use
at_util_decode_error here

> +}
> +
> +static void speedup_set_online(struct ofono_modem *modem, ofono_bool_t o=
nline,
> +				ofono_modem_online_cb_t cb, void *user_data)
> +{
> +	struct speedup_data *data =3D ofono_modem_get_data(modem);
> +	GAtChat *chat =3D data->aux;
> +	struct cb_data *cbd =3D cb_data_new(cb, user_data);
> +	char const *command =3D online ? "AT+CFUN=3D1" : "AT+CFUN=3D4";
> +
> +	DBG("modem %p %s", modem, online ? "online" : "offline");
> +
> +	if (chat =3D=3D NULL)
> +		goto error;
> +
> +	if (g_at_chat_send(chat, command, NULL, set_online_cb, cbd, g_free))
> +		return;
> +
> +error:
> +	g_free(cbd);
> +
> +	CALLBACK_WITH_FAILURE(cb, cbd->data);
> +}
> +
> +static void speedup_pre_sim(struct ofono_modem *modem)
> +{
> +	struct speedup_data *data =3D ofono_modem_get_data(modem);
> +	struct ofono_sim *sim;
> +
> +	DBG("%p", modem);
> +
> +	ofono_devinfo_create(modem, 0, "atmodem", data->aux);
> +	sim =3D ofono_sim_create(modem, OFONO_VENDOR_QUALCOMM_MSM,
> +				"atmodem", data->aux);
> +
> +	if (sim)
> +		ofono_sim_inserted_notify(sim, TRUE);
> +}
> +
> +static void speedup_post_sim(struct ofono_modem *modem)
> +{
> +	struct speedup_data *data =3D ofono_modem_get_data(modem);
> +
> +	DBG("%p", modem);
> +
> +	ofono_phonebook_create(modem, 0, "atmodem", data->aux);
> +
> +	ofono_sms_create(modem, OFONO_VENDOR_QUALCOMM_MSM,
> +					"atmodem", data->aux);
> +}
> +
> +static void speedup_post_online(struct ofono_modem *modem)
> +{
> +	struct speedup_data *data =3D ofono_modem_get_data(modem);
> +
> +	DBG("%p", modem);
> +
> +	ofono_netreg_create(modem, OFONO_VENDOR_ZTE, "atmodem", data->aux);
> +
> +	ofono_cbs_create(modem, OFONO_VENDOR_QUALCOMM_MSM,
> +					"atmodem", data->aux);
> +	ofono_ussd_create(modem, OFONO_VENDOR_QUALCOMM_MSM,
> +					"atmodem", data->aux);
> +	data->gprs =3D ofono_gprs_create(modem, 0, "atmodem", data->aux);
> +
> +	data->gc =3D ofono_gprs_context_create(modem, 0, "atmodem", data->modem=
);
> +
> +	if (data->gprs && data->gc)
> +		ofono_gprs_add_context(data->gprs, data->gc);

Please create gprs and gc in post_sim, not post_online.  Doing so in
post_online will lead to quite a bit of problems.

> +}
> +
> +static struct ofono_modem_driver speedup_driver =3D {
> +	.name		=3D "speedup",
> +	.probe		=3D speedup_probe,
> +	.remove		=3D speedup_remove,
> +	.enable		=3D speedup_enable,
> +	.disable	=3D speedup_disable,
> +	.set_online     =3D speedup_set_online,
> +	.pre_sim	=3D speedup_pre_sim,
> +	.post_sim	=3D speedup_post_sim,
> +	.post_online    =3D speedup_post_online,
> +};
> +
> +static int speedup_init(void)
> +{
> +	return ofono_modem_driver_register(&speedup_driver);
> +}
> +
> +static void speedup_exit(void)
> +{
> +	ofono_modem_driver_unregister(&speedup_driver);
> +}
> +
> +OFONO_PLUGIN_DEFINE(speedup, "SpeedUp modem driver", VERSION,
> +		OFONO_PLUGIN_PRIORITY_DEFAULT, speedup_init, speedup_exit)
> diff --git a/plugins/udev.c b/plugins/udev.c
> index 0234fc0..27f27bc 100644
> --- a/plugins/udev.c
> +++ b/plugins/udev.c
> @@ -587,6 +587,58 @@ static void add_linktop(struct ofono_modem *modem,
>  	}
>  }
>  =

> +static void add_speedup(struct ofono_modem *modem,
> +					struct udev_device *udev_device)
> +{
> +	struct udev_list_entry *entry;
> +	const char *devnode, *type;
> +
> +	int ppp, aux;
> +
> +	DBG("modem %p", modem);
> +
> +	ppp =3D ofono_modem_get_integer(modem, "ModemRegistered");
> +	aux =3D ofono_modem_get_integer(modem, "AuxRegistered");
> +
> +	if (ppp && aux)
> +		return;
> +
> +	entry =3D udev_device_get_properties_list_entry(udev_device);
> +	while (entry) {
> +		const char *name =3D udev_list_entry_get_name(entry);
> +		type =3D udev_list_entry_get_value(entry);
> +
> +		if (g_str_equal(name, "OFONO_SPEEDUP_TYPE") !=3D TRUE) {
> +			entry =3D udev_list_entry_get_next(entry);
> +			continue;
> +		}
> +
> +		if (g_str_equal(type, "modem") =3D=3D TRUE) {
> +			if (ppp !=3D 0)
> +				return;
> +
> +			devnode =3D udev_device_get_devnode(udev_device);
> +			ofono_modem_set_string(modem, "Modem", devnode);
> +			ppp =3D 1;
> +			ofono_modem_set_integer(modem, "ModemRegistered", ppp);
> +		} else if (g_str_equal(type, "aux") =3D=3D TRUE) {
> +			if (aux !=3D 0)
> +				return;
> +
> +			devnode =3D udev_device_get_devnode(udev_device);
> +			ofono_modem_set_string(modem, "Aux", devnode);
> +
> +			aux =3D 1;
> +			ofono_modem_set_integer(modem, "AuxRegistered", aux);
> +		}
> +
> +		break;
> +	}
> +
> +	if (ppp && aux)
> +		ofono_modem_register(modem);
> +}
> +
>  static void add_modem(struct udev_device *udev_device)
>  {
>  	struct ofono_modem *modem;
> @@ -685,6 +737,8 @@ done:
>  		add_nokiacdma(modem, udev_device);
>          else if (g_strcmp0(driver, "linktop") =3D=3D 0)
>  		add_linktop(modem, udev_device);
> +        else if (g_strcmp0(driver, "speedup") =3D=3D 0)
> +		add_speedup(modem, udev_device);
>  }
>  =

>  static gboolean devpath_remove(gpointer key, gpointer value, gpointer us=
er_data)

Regards,
-Denis

--===============4671939137726301211==--

