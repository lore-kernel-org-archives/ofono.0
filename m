Content-Type: multipart/mixed; boundary="===============3954734989704422852=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v3] Add basic Telit UC864-G support:
Date: Tue, 07 Jun 2011 18:47:24 +0200
Message-ID: <1307465245.2589.16.camel@aeonflux>
In-Reply-To: <1307456121-15053-1-git-send-email-Bernhard.Guillon@hale.at>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3954734989704422852==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bernhard,

> *add a basic plugin based on different ofono plugins
> *use Telit specific QSS for SIM-state
> *update Makefile
> ---
>  Makefile.am     |    3 +
>  plugins/telit.c |  385 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 388 insertions(+), 0 deletions(-)
>  create mode 100644 plugins/telit.c
> =

> diff --git a/Makefile.am b/Makefile.am
> index 0a7b6d5..dd4fb8f 100644
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
> diff --git a/plugins/telit.c b/plugins/telit.c
> new file mode 100644
> index 0000000..5dc3938
> --- /dev/null
> +++ b/plugins/telit.c
> @@ -0,0 +1,385 @@
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
> +#include <drivers/atmodem/atutil.h>
> +
> +static const char *none_prefix[] =3D { NULL };
> +static const char *qss_prefix[] =3D { "#QSS:", NULL };
> +
> +struct telit_data {
> +	GAtChat *chat;
> +	struct ofono_sim *sim;
> +};
> +
> +static void telit_debug(const char *str, void *user_data)
> +{
> +	const char *prefix =3D user_data;
> +
> +	ofono_info("%s%s", prefix, str);
> +}
> +
> +static int telit_probe(struct ofono_modem *modem)
> +{
> +	struct telit_data *data;
> +
> +	DBG("%p", modem);
> +
> +	data =3D g_try_new0(struct telit_data, 1);
> +	if (data =3D=3D NULL)
> +		return -ENOMEM;
> +
> +	ofono_modem_set_data(modem, data);
> +
> +	return 0;
> +}
> +
> +static void telit_remove(struct ofono_modem *modem)
> +{
> +	struct telit_data *data =3D ofono_modem_get_data(modem);
> +
> +	DBG("%p", modem);
> +
> +	ofono_modem_set_data(modem, NULL);
> +
> +	g_free(data);
> +}
> +
> +static gboolean sim_inserted_notify_with_timeout(gpointer user_data)
> +{

this function name is weird. Calling it sim_inserted_timeout_callback or
so would be a lot clearer.

> +	struct ofono_modem *modem =3D user_data;
> +	struct telit_data *data =3D ofono_modem_get_data(modem);
> +
> +	DBG("%p", modem);
> +
> +	ofono_sim_inserted_notify(data->sim, TRUE);
> +
> +	return FALSE;
> +}
> +
> +static void switch_sim_state_status(int status, gpointer user_data)
> +{

So I rather prefer (struct ofono_modem *modem, int status) here. Or even
better just do (struct telit_data *data, int status) since you are not
really dealing with ofono_modem here anyway.

If you wanna keep ofono_modem, because that is what you have as
user_data in the qss_notify, then that is fine with me.

> +	struct ofono_modem *modem =3D user_data;
> +	struct telit_data *data =3D ofono_modem_get_data(modem);
> +
> +	DBG("%p", modem);
> +
> +	switch (status) {
> +	case 0:
> +		DBG("SIM not inserted");
> +		ofono_sim_inserted_notify(data->sim, FALSE);
> +		break;
> +	case 1:
> +		DBG("SIM inserted");
> +		/* We need to sleep a bit */
> +		g_timeout_add_seconds(1, sim_inserted_notify_with_timeout,
> +								modem);
> +		break;
> +	case 2:
> +		DBG("SIM inserted and PIN unlocked");
> +		break;
> +	case 3:
> +		DBG("SIM inserted and ready");
> +		break;

Why are you not handling any of case 2 or 3. Are they not also mean that
SIM is inserted. Or do they always are followed by case 1.

> +	default:
> +		return;
> +	}

You can just leave the default statement out. Not really needed here
anyway.

> +}
> +
> +static void telit_qss_notify(GAtResult *result, gpointer user_data)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	int status;
> +	GAtResultIter iter;
> +
> +	DBG("%p", modem);
> +
> +	g_at_result_iter_init(&iter, result);
> +
> +	if (!g_at_result_iter_next(&iter, "#QSS:"))
> +		return;
> +
> +	g_at_result_iter_next_number(&iter, &status);
> +
> +	switch_sim_state_status(status, modem);
> +

Please remove this empty line.

> +}
> +
> +static void telit_qss_cb(gboolean ok, GAtResult *result, gpointer user_d=
ata)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	int mode;
> +	int status;
> +	GAtResultIter iter;
> +	g_at_result_iter_init(&iter, result);
> +
> +	DBG("%p", modem);
> +
> +	if (!g_at_result_iter_next(&iter, "#QSS:"))
> +		return;
> +
> +	g_at_result_iter_next_number(&iter, &mode);
> +	g_at_result_iter_next_number(&iter, &status);
> +
> +	switch_sim_state_status(status,modem);

You forgot the extra space between status, modem.

> +}
> +
> +static void cfun_enable_cb(gboolean ok, GAtResult *result, gpointer user=
_data)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	struct telit_data *data =3D ofono_modem_get_data(modem);
> +
> +	DBG("%p", modem);
> +
> +	if (!ok) {
> +		g_at_chat_unref(data->chat);
> +		data->chat =3D NULL;
> +		return;

If I am not mistaken, then the set_powered(FALSE) call is missing here.
Did you test this code path?

> +	}
> +
> +	ofono_modem_set_powered(modem, TRUE);
> +
> +	/* Enable sim state notification */
> +	g_at_chat_send(data->chat, "AT#QSS=3D1", none_prefix, NULL, NULL, NULL);
> +
> +	/* Follow sim state */
> +	g_at_chat_register(data->chat, "#QSS:", telit_qss_notify,
> +				FALSE, modem, NULL);
> +
> +	/* Query current sim state */
> +	g_at_chat_send(data->chat, "AT#QSS?", qss_prefix,
> +				telit_qss_cb, modem, NULL);
> +}
> +
> +static void cfun_disable_cb(gboolean ok, GAtResult *result, gpointer use=
r_data)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	struct telit_data *data =3D ofono_modem_get_data(modem);
> +
> +	DBG("%p", modem);
> +
> +	g_at_chat_unref(data->chat);
> +	data->chat =3D NULL;
> +
> +	if (ok)
> +		ofono_modem_set_powered(modem, FALSE);
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
> +	syntax =3D g_at_syntax_new_gsmv1();
> +	chat =3D g_at_chat_new(channel, syntax);
> +	g_at_syntax_unref(syntax);
> +	g_io_channel_unref(channel);
> +
> +	if (chat =3D=3D NULL)
> +		return NULL;
> +
> +	if (getenv("OFONO_AT_DEBUG"))
> +		g_at_chat_set_debug(chat, telit_debug, debug);
> +
> +	return chat;
> +}
> +
> +static int telit_enable(struct ofono_modem *modem)
> +{
> +	struct telit_data *data =3D ofono_modem_get_data(modem);
> +
> +	DBG("%p", modem);
> +
> +	data->chat =3D open_device(modem, "Modem", "Modem: ");
> +	if (data->chat =3D=3D NULL)
> +		return -EINVAL;
> +
> +	/*
> +	 * Disable command echo and
> +	 * enable the Extended Error Result Codes
> +	 */
> +	g_at_chat_send(data->chat, "ATE0 +CMEE=3D1", none_prefix,
> +				NULL, NULL, NULL);
> +
> +	/* Set phone functionality */
> +	g_at_chat_send(data->chat, "AT+CFUN=3D4", none_prefix,
> +				cfun_enable_cb, modem, NULL);
> +
> +	return -EINPROGRESS;
> +}
> +
> +static int telit_disable(struct ofono_modem *modem)
> +{
> +	struct telit_data *data =3D ofono_modem_get_data(modem);
> +	DBG("%p", modem);
> +
> +	if (data->chat =3D=3D NULL)
> +		return 0;

I remember that I mentioned this before. This is not needed. The disable
callback will never be called if enabling never succeeded.

> +	g_at_chat_cancel_all(data->chat);
> +	g_at_chat_unregister_all(data->chat);
> +
> +	/* Power down modem */
> +	g_at_chat_send(data->chat, "AT+CFUN=3D0", none_prefix,
> +				cfun_disable_cb, modem, NULL);
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
> +	struct telit_data *data =3D ofono_modem_get_data(modem);
> +	struct cb_data *cbd =3D cb_data_new(cb, user_data);
> +	char const *command =3D online ? "AT+CFUN=3D1" : "AT+CFUN=3D4";
> +
> +	DBG("modem %p %s", modem, online ? "online" : "offline");
> +
> +	g_at_chat_send(data->chat, command, none_prefix,set_online_cb,
> +						cbd, g_free);
> +}
> +
> +static void telit_pre_sim(struct ofono_modem *modem)
> +{
> +	struct telit_data *data =3D ofono_modem_get_data(modem);
> +
> +	DBG("%p", modem);
> +
> +	ofono_devinfo_create(modem, 0, "atmodem", data->chat);
> +	data->sim =3D ofono_sim_create(modem, 0, "atmodem", data->chat);
> +	ofono_voicecall_create(modem, 0, "atmodem", data->chat);
> +}
> +
> +static void telit_post_sim(struct ofono_modem *modem)
> +{
> +	struct telit_data *data =3D ofono_modem_get_data(modem);
> +
> +	DBG("%p", modem);
> +
> +	ofono_sms_create(modem, 0, "atmodem", data->chat);
> +}
> +
> +static void telit_post_online(struct ofono_modem *modem)
> +{
> +	struct telit_data *data =3D ofono_modem_get_data(modem);
> +	struct ofono_message_waiting *mw;
> +	struct ofono_gprs *gprs;
> +	struct ofono_gprs_context *gc;
> +
> +	DBG("%p", modem);
> +
> +	ofono_netreg_create(modem, 0, "atmodem", data->chat);
> +	ofono_ussd_create(modem, 0, "atmodem", data->chat);
> +	ofono_call_forwarding_create(modem, 0, "atmodem", data->chat);
> +	ofono_call_settings_create(modem, 0, "atmodem", data->chat);
> +	ofono_call_meter_create(modem, 0, "atmodem", data->chat);
> +	ofono_call_barring_create(modem, 0, "atmodem", data->chat);
> +
> +	gprs =3D ofono_gprs_create(modem, 0, "atmodem", data->chat);
> +	gc =3D ofono_gprs_context_create(modem, 0, "atmodem", data->chat);
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

Rest looks fine.

Regards

Marcel



--===============3954734989704422852==--

