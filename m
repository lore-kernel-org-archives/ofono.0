Content-Type: multipart/mixed; boundary="===============8330956573019704031=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC PATCH 1/2] Add basic Telit UC864-G support:
Date: Thu, 19 May 2011 10:48:22 -0700
Message-ID: <1305827302.15916.200.camel@aeonflux>
In-Reply-To: <1305801624-3410-1-git-send-email-Bernhard.Guillon@hale.at>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8330956573019704031==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bernhard,

> *add a basic plugin based on different ofono plugins
> *use Telit specific QSS for SIM-state
> *add verry basic GPS support (usable with gypsy)
> *add udev support and rules
> *update Makefile
> =

> Co-authored-by: Christopher Vogl <Christopher.Vogl@hale.at>
> Signed-off-by: Bernhard Guillon <Bernhard.Guillon@hale.at>

we are not using Signed-off-by for our commits.

> ---
>  Makefile.am              |    3 +
>  drivers/atmodem/vendor.h |    1 +
>  plugins/ofono.rules      |   16 ++-
>  plugins/telit.c          |  387 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  plugins/udev.c           |   40 +++++
>  5 files changed, 446 insertions(+), 1 deletions(-)
>  create mode 100644 plugins/telit.c

please split changes into three patches. One for drivers, one for udev
(including the rules) and one for the telit modem plugin.

> diff --git a/Makefile.am b/Makefile.am
> index a413a47..6197cf6 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -326,6 +326,9 @@ builtin_sources +=3D plugins/nokiacdma.c
>  builtin_modules +=3D linktop
>  builtin_sources +=3D plugins/linktop.c
>  =

> +builtin_modules +=3D telit
> +builtin_sources +=3D plugins/telit.c
> +
>  if BLUETOOTH
>  builtin_modules +=3D bluetooth
>  builtin_sources +=3D plugins/bluetooth.c plugins/bluetooth.h
> diff --git a/drivers/atmodem/vendor.h b/drivers/atmodem/vendor.h
> index 3898fa8..412bc76 100644
> --- a/drivers/atmodem/vendor.h
> +++ b/drivers/atmodem/vendor.h
> @@ -35,4 +35,5 @@ enum ofono_vendor {
>  	OFONO_VENDOR_WAVECOM,
>  	OFONO_VENDOR_NOKIA,
>  	OFONO_VENDOR_PHONESIM,
> +	OFONO_VENDOR_TELIT,
>  };
> diff --git a/plugins/ofono.rules b/plugins/ofono.rules
> index 5a36380..c0c4360 100644
> --- a/plugins/ofono.rules
> +++ b/plugins/ofono.rules
> @@ -306,7 +306,7 @@ ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1=
479", ENV{OFONO_IFACE_NUM}=3D=3D"00", E
>  ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1479", ENV{OFONO_IFA=
CE_NUM}=3D=3D"04", ENV{OFONO_HUAWEI_TYPE}=3D"Pcui"
>  =

>  ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"147a", ENV{OFONO_IFA=
CE_NUM}=3D=3D"00", ENV{OFONO_HUAWEI_TYPE}=3D"Modem"
> -ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"147a", ENV{OFONO_IFA=
CE_NUM}=3D=3D"04", ENV{OFONO_HUAWEI_TYPE}=3D"Pcui"
> +	ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"147a", ENV{OFONO_IF=
ACE_NUM}=3D=3D"04", ENV{OFONO_HUAWEI_TYPE}=3D"Pcui"

You are messing with already existing rules here. Please don't.
 =

>  ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"147b", ENV{OFONO_IFA=
CE_NUM}=3D=3D"00", ENV{OFONO_HUAWEI_TYPE}=3D"Modem"
>  ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"147b", ENV{OFONO_IFA=
CE_NUM}=3D=3D"04", ENV{OFONO_HUAWEI_TYPE}=3D"Pcui"
> @@ -346,6 +346,20 @@ ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"=
1486", ENV{OFONO_IFACE_NUM}=3D=3D"02", E
>  =

>  LABEL=3D"ofono_tty_end"
>  =

> +#Telit
> +#This modem is not in SUBSYSTEM tty but in KERNEL ttyUSB. Therefore it i=
s intended to be
> +#after the ofono_tty_end line

Why is that. What kernel driver is claiming this modem?

> +#UC864-G
> +
> +ATTR{idVendor}=3D=3D"1bc7", ATTR{idProduct}=3D=3D"1004", ENV{OFONO_IFACE=
_NUM}=3D=3D"00", ENV{OFONO_TELIT_TYPE}=3D"modem"
> +ATTR{idVendor}=3D=3D"1bc7", ATTR{idProduct}=3D=3D"1004", ENV{OFONO_IFACE=
_NUM}=3D=3D"01", ENV{OFONO_TELIT_TYPE}=3D"aux"
> +ATTR{idVendor}=3D=3D"1bc7", ATTR{idProduct}=3D=3D"1004", ENV{OFONO_IFACE=
_NUM}=3D=3D"02", ENV{OFONO_TELIT_TYPE}=3D"gps"
> +ATTR{idVendor}=3D=3D"1bc7", ATTR{idProduct}=3D=3D"1004", ENV{OFONO_IFACE=
_NUM}=3D=3D"03", ENV{OFONO_TELIT_TYPE}=3D"uart"
> +
> +ATTR{idVendor}=3D=3D"1bc7", ENV{OFONO_DRIVER}=3D"telit"
> +ATTR{idVendor}=3D=3D"1bc7", ATTR{idProduct}=3D=3D"1004", ENV{OFONO_TELIT=
_MODEL}=3D"UC864-G"

Do you really need this model number?

> +
>  # ISI/Phonet drivers
>  SUBSYSTEM!=3D"net", GOTO=3D"ofono_isi_end"
>  ATTRS{type}!=3D"820", GOTO=3D"ofono_isi_end"
> diff --git a/plugins/telit.c b/plugins/telit.c
> new file mode 100644
> index 0000000..d157561
> --- /dev/null
> +++ b/plugins/telit.c
> @@ -0,0 +1,387 @@
> +/*
> + *
> + *  oFono - Open Source Telephony
> + *
> + *  Copyright (C) 2008-2010  Intel Corporation. All rights reserved.
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
> +#include <unistd.h>
> +
> +#include <glib.h>
> +#include <gatchat.h>
> +#include <gattty.h>
> +
> +#define OFONO_API_SUBJECT_TO_CHANGE
> +#include <ofono/plugin.h>
> +#include <ofono/log.h>
> +#include <ofono/modem.h>
> +#include <ofono/call-barring.h>
> +#include <ofono/call-forwarding.h>
> +#include <ofono/call-meter.h>
> +#include <ofono/call-settings.h>
> +#include <ofono/devinfo.h>
> +#include <ofono/message-waiting.h>
> +#include <ofono/netreg.h>
> +#include <ofono/phonebook.h>
> +#include <ofono/sim.h>
> +#include <ofono/gprs.h>
> +#include <ofono/gprs-context.h>
> +#include <ofono/sms.h>
> +#include <ofono/ussd.h>
> +#include <ofono/voicecall.h>
> +
> +#include <drivers/atmodem/vendor.h>
> +#include <drivers/atmodem/atutil.h>
> +
> +
> +static const char *none_prefix[] =3D { NULL };
> +
> +

No double empty lines please.

> +static int telit_probe(struct ofono_modem *modem)
> +{
> +	DBG("");
> +
> +	return 0;
> +}
> +
> +static void telit_remove(struct ofono_modem *modem)
> +{
> +	GAtChat *chat =3D ofono_modem_get_data(modem);
> +
> +	DBG("");
> +
> +	if (chat) {
> +		g_at_chat_unref(chat);
> +		ofono_modem_set_data(modem, NULL);
> +	}
> +}

Please create a struct telit_data and allocate it in probe. Similar to
what all other drivers do. It is better than just trying to stick the
GAtChat object in the user data.

> +static void cfun_enable_cb(gboolean ok, GAtResult *result, gpointer user=
_data)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +
> +	DBG("");
> +
> +	if (ok)
> +		ofono_modem_set_powered(modem, TRUE);
> +}
> +
> +static void cfun_disable_cb(gboolean ok, GAtResult *result, gpointer use=
r_data)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	GAtChat *chat =3D ofono_modem_get_data(modem);
> +
> +	DBG("");
> +
> +	g_at_chat_unref(chat);
> +	ofono_modem_set_data(modem, NULL);

The set_data should only be used on probe() and remove(). Please obey
the lifetime rules of a modem object. They are similar to kernel driver.

> +	if (ok)
> +		ofono_modem_set_powered(modem, FALSE);
> +}
> +
> +static void telit_debug(const char *str, void *user_data)
> +{
> +	const char *prefix =3D user_data;
> +
> +	ofono_info("%s%s", prefix, str);
> +}
> +
> +static int telit_enable(struct ofono_modem *modem)
> +{
> +	GAtChat *chat;
> +	GIOChannel *channel;
> +	GAtSyntax *syntax;
> +	const char *device;
> +	GHashTable *options;
> +
> +	DBG("%p", modem);
> +
> +	device =3D ofono_modem_get_string(modem, "Device");
> +	if (device =3D=3D NULL)
> +		return -EINVAL;
> +
> +	options =3D g_hash_table_new(g_str_hash, g_str_equal);
> +
> +	if (options =3D=3D NULL)
> +		return -ENOMEM;
> +
> +	g_hash_table_insert(options, "Baud", "115200");
> +	g_hash_table_insert(options, "Parity", "none");
> +	g_hash_table_insert(options, "StopBits", "1");
> +	g_hash_table_insert(options, "DataBits", "8");

Are these really needed. So far we only needed it for the Calypso modem
which is on a real TTY port. All the other ones were fake TTY ports over
USB or SPI and did not need any extras.

> +
> +	DBG("IN TELIT: %s", device);
> +
> +	channel =3D g_at_tty_open(device, options);
> +
> +	g_hash_table_destroy(options);
> +
> +	DBG("channel: %p", channel);
> +
> +	if (channel =3D=3D NULL)
> +		return -EIO;
> +
> +	/*
> +	 * Could not figure out whether it is fully compliant or not, use
> +	 * permissive for now
> +	 * */
> +	syntax =3D g_at_syntax_new_gsm_permissive();

Use the v1 parser for now. And we see if it is not compliant later.

> +	chat =3D g_at_chat_new(channel, syntax);
> +	g_io_channel_unref(channel);
> +	g_at_syntax_unref(syntax);
> +
> +	if (chat =3D=3D NULL)
> +		return -ENOMEM;
> +
> +	if (getenv("OFONO_AT_DEBUG"))
> +		g_at_chat_set_debug(chat, telit_debug, "");
> +
> +	ofono_modem_set_data(modem, chat);

See above comment about struct telit_data and set_data usage.

> +	/* ATE0: disables command echo.
> +	 * +CMEE=3D1: Enable the Extended Error Result Codes. */
> +	g_at_chat_send(chat, "ATE0+CMEE=3D1", none_prefix, NULL, NULL, NULL);

Use "ATE0 +CMEE=3D1" to be a bit more in sync with the other plugins.

> +	/* Set phone functionality:
> +	 * +CFUN=3D1: mobile full functionality with power saving disabled (fac=
tory default).
> +	 * +CFUN=3D5: mobile full functionality with power saving enabled.
> +	 */
> +	g_at_chat_send(chat, "AT+CFUN=3D1", none_prefix, cfun_enable_cb, modem,=
 NULL);

If you are supporting online mode, then this is wrong. You need to start
in offline mode. So most likely CFUN=3D4.

> +
> +	return 0;
> +}
> +
> +static int telit_disable(struct ofono_modem *modem)
> +{
> +	GAtChat *chat =3D ofono_modem_get_data(modem);
> +
> +	DBG("%p", modem);
> +
> +	if (chat =3D=3D NULL)
> +		return 0;
> +
> +	/* power down modem */
> +	g_at_chat_cancel_all(chat);
> +	g_at_chat_unregister_all(chat);
> +
> +	g_at_chat_send(chat, "AT+CFUN=3D0", NULL, cfun_disable_cb, modem, NULL);
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
> +}
> +
> +static void telit_set_online(struct ofono_modem *modem, ofono_bool_t onl=
ine,
> +				ofono_modem_online_cb_t cb, void *user_data)
> +{
> +	GAtChat *chat =3D ofono_modem_get_data(modem);
> +	struct cb_data *cbd =3D cb_data_new(cb, user_data);
> +
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
> +
> +
> +static void telit_qss_notify(GAtResult *result, gpointer _sim)
> +{
> +	int status =3D 0;
> +	GAtResultIter iter;
> +	struct ofono_sim *sim =3D _sim;
> +	g_at_result_iter_init(&iter, result);
> +
> +	if (!g_at_result_iter_next(&iter, "#QSS:"))
> +		return;
> +
> +	g_at_result_iter_next_number(&iter, &status);
> +	switch(status)
> +	{
> +		case 0:
> +			DBG("SIM not inserted");
> +			ofono_sim_inserted_notify(sim,FALSE);
> +			break;

Please follow the coding style for switch statements here.

> +		case 1:
> +			DBG("SIM inserted");
> +			/* we need to sleep a bit */
> +			sleep(1);
> +			ofono_sim_inserted_notify(sim,TRUE);
> +			break;
> +		case 2:
> +			DBG("SIM inserted and PIN unlocked");
> +			break;
> +		case 3:
> +			DBG("SIM inserted and ready");
> +			break;
> +		default:
> +			return;
> +	}
> +	return;
> +}
> +
> +static void telit_qss_cb(gboolean ok, GAtResult *result, gpointer _sim)
> +{
> +	int mode =3D 0;
> +	int status =3D 0;
> +	GAtResultIter iter;
> +	struct ofono_sim *sim =3D _sim;
> +	g_at_result_iter_init(&iter, result);
> +	=

> +	if (!g_at_result_iter_next(&iter, "#QSS:"))
> +		goto error;
> +	g_at_result_iter_next_number(&iter, &mode);
> +	g_at_result_iter_next_number(&iter, &status);
> +	switch(status)
> +	{
> +		case 0:
> +			DBG("SIM not inserted");
> +			break;
> +		case 1:
> +			DBG("SIM inserted");
> +			ofono_sim_inserted_notify(sim,TRUE);
> +			break;
> +		case 2:
> +			DBG("SIM inserted and PIN unlocked");
> +			break;
> +		case 3:
> +			DBG("SIM inserted and ready");
> +			break;
> +		default:
> +			goto error;
> +	} =

> +error:
> +	return;
> +}
> +
> +static void telit_pre_sim(struct ofono_modem *modem)
> +{
> +	GAtChat *chat =3D ofono_modem_get_data(modem);
> +	struct ofono_sim *sim;
> +
> +	DBG("%p", modem);
> +	DBG("CAHT %p", chat);
> +
> +	ofono_devinfo_create(modem, 0, "atmodem", chat);
> +	sim =3D ofono_sim_create(modem, OFONO_VENDOR_TELIT, "atmodem", chat);

Why are you using a quirk here?

> +	ofono_voicecall_create(modem, 0, "atmodem", chat);
> +
> +	if(sim) {
> +		/* enable sim state notification */
> +		g_at_chat_send(chat, "AT#QSS=3D1", NULL, NULL, NULL, NULL);
> +		g_at_chat_register(chat, "#QSS:", telit_qss_notify, FALSE, sim, NULL);
> +		/* query current sim state */
> +		g_at_chat_send(chat, "AT#QSS?", NULL, telit_qss_cb, sim, NULL);

Using NULL for prefix is most likely wrong here. Can you show us some
examples logs with OFONO_AT_DEBUG=3D1 for this?

> +	}
> +}
> +
> +static void telit_post_sim(struct ofono_modem *modem)
> +{
> +	GAtChat *chat =3D ofono_modem_get_data(modem);
> +
> +	DBG("%p", modem);
> +
> +	ofono_phonebook_create(modem, 0, "atmodem", chat);
> +}
> +
> +static void telit_post_online(struct ofono_modem *modem)
> +{
> +	GAtChat *chat =3D ofono_modem_get_data(modem);
> +	struct ofono_message_waiting *mw;
> +	struct ofono_gprs *gprs;
> +	struct ofono_gprs_context *gc;
> +	int gps;
> +
> +	DBG("%p", modem);
> +
> +	gps =3D ofono_modem_get_integer(modem, "GPS");
> +
> +	if (gps)
> +		g_at_chat_send(chat, "AT$GPSP=3D1", NULL, NULL, NULL, NULL);

So in general the post_online, pre_sim and post_sim states should only
be used to add atoms and not to send commands.

If you wanna support GPS, then please create a proper atom driver
specific for the Telit modem.

> +
> +	ofono_ussd_create(modem, 0, "atmodem", chat);				// +CUSD - Unstructure=
d Supplementary Service Data

Leave out the comments here.

> +	ofono_call_forwarding_create(modem, 0, "atmodem", chat);
> +	ofono_call_settings_create(modem, 0, "atmodem", chat);
> +	ofono_netreg_create(modem, OFONO_VENDOR_TELIT, "atmodem", chat);
> +	ofono_call_meter_create(modem, 0, "atmodem", chat);
> +	ofono_call_barring_create(modem, 0, "atmodem", chat);
> +	//ofono_cbs_create(modem, 0, "atmodem", chat);				//Cell Broadcast Serv=
ice

If not used, then leave it out for now.

> +	ofono_sms_create(modem, 0, "atmodem", chat);
> +
> +	gprs =3D ofono_gprs_create(modem, 0, "atmodem", chat);
> +	gc =3D ofono_gprs_context_create(modem, 0, "atmodem", chat);
> +
> +	if (gprs && gc)
> +		ofono_gprs_add_context(gprs, gc);
> +
> +	mw =3D ofono_message_waiting_create(modem);
> +	if (mw)
> +		ofono_message_waiting_register(mw);
> +}
> +
> +static struct ofono_modem_driver telit_driver =3D {
> +	.name			=3D "telit",
> +	.probe			=3D telit_probe,
> +	.remove			=3D telit_remove,
> +	.enable			=3D telit_enable,
> +	.disable		=3D telit_disable,
> +	.set_online		=3D telit_set_online,
> +	.pre_sim		=3D telit_pre_sim,
> +	.post_sim		=3D telit_post_sim,
> +	.post_online	=3D telit_post_online,
> +};
> +
> +static int telit_init(void)
> +{
> +	return ofono_modem_driver_register(&telit_driver);
> +}
> +
> +static void telit_exit(void)
> +{
> +	ofono_modem_driver_unregister(&telit_driver);
> +}
> +
> +OFONO_PLUGIN_DEFINE(telit, "telit driver", VERSION,
> +		OFONO_PLUGIN_PRIORITY_DEFAULT, telit_init, telit_exit)
> diff --git a/plugins/udev.c b/plugins/udev.c
> index cbb596d..2913b5b 100644
> --- a/plugins/udev.c
> +++ b/plugins/udev.c
> @@ -588,6 +588,44 @@ static void add_linktop(struct ofono_modem *modem,
>  	}
>  }
>  =

> +static void add_telit(struct ofono_modem *modem,
> +					struct udev_device *udev_device)
> +{
> +	struct udev_list_entry *entry;
> +	const char *devnode;
> +	gboolean found =3D FALSE;
> +	gboolean gps =3D FALSE;
> +
> +	DBG("modem %p", modem);
> +
> +	entry =3D udev_device_get_properties_list_entry(udev_device);
> +	while (entry) {
> +		const char *name =3D udev_list_entry_get_name(entry);
> +		const char *value =3D udev_list_entry_get_value(entry);
> +
> +		if (g_str_equal(name, "OFONO_TELIT_TYPE") =3D=3D TRUE &&
> +					g_str_equal(value, "modem") =3D=3D TRUE) {
> +			found =3D TRUE;
> +		}
> +		if (g_str_equal(name, "OFONO_TELIT_MODEL") =3D=3D TRUE &&
> +					g_str_equal(value, "UC864-G") =3D=3D TRUE) {
> +			gps =3D TRUE;
> +		}
> +		entry =3D udev_list_entry_get_next(entry);
> +	}
> +
> +	if (found =3D=3D FALSE)
> +		return;
> +
> +	devnode =3D udev_device_get_devnode(udev_device);
> +	ofono_modem_set_string(modem, "Device", devnode);
> +
> +	if(gps)
> +		ofono_modem_set_integer(modem, "GPS", 1);
> +
> +	ofono_modem_register(modem);
> +}
> +

Do you happen to have the output of /proc/bus/usb/devices for this
device?

>  static void add_modem(struct udev_device *udev_device)
>  {
>  	struct ofono_modem *modem;
> @@ -682,6 +720,8 @@ done:
>  		add_calypso(modem, udev_device);
>  	else if (g_strcmp0(driver, "tc65") =3D=3D 0)
>  		add_tc65(modem, udev_device);
> +	else if (g_strcmp0(driver, "telit") =3D=3D 0)
> +		add_telit(modem, udev_device);
>  	else if (g_strcmp0(driver, "nokiacdma") =3D=3D 0)
>  		add_nokiacdma(modem, udev_device);
>          else if (g_strcmp0(driver, "linktop") =3D=3D 0)

Regards

Marcel



--===============8330956573019704031==--

