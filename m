Content-Type: multipart/mixed; boundary="===============5316035151008123633=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCHv2 1/3] Add a plugin for Cinterion TC65 modem
Date: Wed, 22 Dec 2010 14:14:33 -0600
Message-ID: <4D125C29.8080302@gmail.com>
In-Reply-To: <1293016382-4607-2-git-send-email-oskari.timperi@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5316035151008123633==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Oskari,

On 12/22/2010 05:13 AM, Oskari Timperi wrote:
> ---
>  plugins/tc65.c |  263 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 files changed, 263 insertions(+), 0 deletions(-)
>  create mode 100644 plugins/tc65.c
> =

> diff --git a/plugins/tc65.c b/plugins/tc65.c
> new file mode 100644
> index 0000000..4d1386b
> --- /dev/null
> +++ b/plugins/tc65.c
> @@ -0,0 +1,263 @@
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
> +#include <ofono/sms.h>
> +#include <ofono/ssn.h>
> +#include <ofono/ussd.h>
> +#include <ofono/voicecall.h>
> +
> +#include <drivers/atmodem/atutil.h>
> +
> +#include <ofono/gprs.h>
> +#include <ofono/gprs-context.h>
> +
> +static int tc65_probe(struct ofono_modem *modem)
> +{
> +       return 0;
> +}
> +

Please note that oFono uses tabs for indentation, not spaces.  So place
fixup this patch accordingly.

> +static void tc65_remove(struct ofono_modem *modem)
> +{
> +}
> +
> +static void tc65_debug(const char *str, void *user_data)
> +{
> +       const char *prefix =3D user_data;
> +
> +       ofono_info("%s%s", prefix, str);
> +}
> +
> +static int tc65_enable(struct ofono_modem *modem)
> +{
> +       GAtChat *chat;
> +       GIOChannel *channel;
> +       GAtSyntax *syntax;
> +       GHashTable *options;
> +       const char *device;
> +
> +       DBG("%p", modem);
> +
> +       options =3D g_hash_table_new_full(g_str_hash, g_str_equal,
> +                                       g_free, g_free);
> +       if (!options)

You might want to check doc/coding-style.txt item M13:

> +               return -ENOMEM;
> +
> +       device =3D ofono_modem_get_string(modem, "Device");
> +

Here you might want to check that device is non-null, and fail early if
it is.

> +       g_hash_table_insert(options, g_strdup("Baud"),
> +                               g_strdup("115200"));
> +       g_hash_table_insert(options, g_strdup("StopBits"),
> +                               g_strdup("1"));
> +       g_hash_table_insert(options, g_strdup("DataBits"),
> +                               g_strdup("8"));
> +       g_hash_table_insert(options, g_strdup("Parity"),
> +                               g_strdup("none"));
> +       g_hash_table_insert(options, g_strdup("XonXoff"),
> +                               g_strdup("off"));
> +       g_hash_table_insert(options, g_strdup("RtsCts"),
> +                               g_strdup("on"));
> +       g_hash_table_insert(options, g_strdup("Local"),
> +                               g_strdup("on"));
> +       g_hash_table_insert(options, g_strdup("Read"),
> +                               g_strdup("on"));
> +
> +       channel =3D g_at_tty_open(device, options);
> +
> +       g_hash_table_destroy(options);
> +
> +       if (!channel)
> +               return -EIO;
> +
> +       /*
> +        * TC65 works almost as the 27.007 says. But for example after
> +        * AT+CRSM the modem replies with the data in the queried EF and
> +        * writes three pairs of <CR><LF> after the data and before OK.
> +        */
> +       syntax =3D g_at_syntax_new_gsm_permissive();
> +
> +       chat =3D g_at_chat_new(channel, syntax);
> +       g_at_syntax_unref(syntax);
> +       g_io_channel_unref(channel);
> +
> +       if (!chat)
> +               return -ENOMEM;
> +
> +       if (getenv("OFONO_AT_DEBUG"))
> +               g_at_chat_set_debug(chat, tc65_debug, "");
> +
> +       ofono_modem_set_data(modem, chat);
> +
> +       return 0;
> +}
> +
> +static int tc65_disable(struct ofono_modem *modem)
> +{
> +       GAtChat *chat =3D ofono_modem_get_data(modem);
> +
> +       DBG("%p", modem);
> +
> +       ofono_modem_set_data(modem, NULL);
> +
> +       g_at_chat_send(chat, "AT+CFUN=3D7", NULL, NULL, NULL, NULL);
> +
> +       g_at_chat_unref(chat);
> +
> +       return 0;
> +}
> +
> +static void set_online_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
> +{
> +       struct cb_data *cbd =3D user_data;
> +       ofono_modem_online_cb_t cb =3D cbd->cb;
> +       struct ofono_error error;
> +
> +       decode_at_error(&error, g_at_result_final_response(result));
> +
> +       cb(&error, cbd->data);
> +}
> +
> +static void tc65_set_online(struct ofono_modem *modem, ofono_bool_t onli=
ne,
> +                               ofono_modem_online_cb_t cb, void *user_da=
ta)
> +{
> +       GAtChat *chat =3D ofono_modem_get_data(modem);
> +       struct cb_data *cbd =3D cb_data_new(cb, user_data);
> +       char const *command =3D online ? "AT+CFUN=3D1" : "AT+CFUN=3D7";
> +
> +       DBG("modem %p %s", modem, online ? "online" : "offline");
> +
> +       if (!cbd)
> +               goto error;
> +
> +       if (g_at_chat_send(chat, command, NULL, set_online_cb, cbd, g_fre=
e))
> +               return;
> +
> +error:
> +       g_free(cbd);
> +
> +       CALLBACK_WITH_FAILURE(cb, cbd->data);
> +}
> +
> +static void tc65_pre_sim(struct ofono_modem *modem)
> +{
> +       GAtChat *chat =3D ofono_modem_get_data(modem);
> +       struct ofono_sim *sim;
> +
> +       DBG("%p", modem);
> +
> +       ofono_devinfo_create(modem, 0, "atmodem", chat);
> +       sim =3D ofono_sim_create(modem, 0, "atmodem", chat);
> +       ofono_voicecall_create(modem, 0, "atmodem", chat);
> +
> +       if (sim)
> +               ofono_sim_inserted_notify(sim, TRUE);
> +}
> +
> +static void tc65_post_sim(struct ofono_modem *modem)
> +{
> +       GAtChat *chat =3D ofono_modem_get_data(modem);
> +
> +       DBG("%p", modem);
> +
> +       ofono_phonebook_create(modem, 0, "atmodem", chat);
> +}
> +
> +static void tc65_post_online(struct ofono_modem *modem)
> +{
> +       GAtChat *chat =3D ofono_modem_get_data(modem);
> +       struct ofono_message_waiting *mw;
> +       struct ofono_gprs *gprs;
> +       struct ofono_gprs_context *gc;
> +
> +       DBG("%p", modem);
> +
> +       ofono_ussd_create(modem, 0, "atmodem", chat);
> +       ofono_call_forwarding_create(modem, 0, "atmodem", chat);
> +       ofono_call_settings_create(modem, 0, "atmodem", chat);
> +       ofono_netreg_create(modem, 0, "atmodem", chat);
> +       ofono_call_meter_create(modem, 0, "atmodem", chat);
> +       ofono_call_barring_create(modem, 0, "atmodem", chat);
> +       ofono_ssn_create(modem, 0, "atmodem", chat);
> +       ofono_sms_create(modem, 0, "atmodem", chat);
> +       gprs =3D ofono_gprs_create(modem, 0, "atmodem", chat);
> +       gc =3D ofono_gprs_context_create(modem, 0, "atmodem", chat);
> +       if (gprs && gc)
> +               ofono_gprs_add_context(gprs, gc);
> +
> +       mw =3D ofono_message_waiting_create(modem);
> +       if (mw)
> +               ofono_message_waiting_register(mw);
> +}
> +
> +static struct ofono_modem_driver tc65_driver =3D {
> +       .name                   =3D "tc65",
> +       .probe                  =3D tc65_probe,
> +       .remove                 =3D tc65_remove,
> +       .enable                 =3D tc65_enable,
> +       .disable                =3D tc65_disable,
> +       .set_online             =3D tc65_set_online,
> +       .pre_sim                =3D tc65_pre_sim,
> +       .post_sim               =3D tc65_post_sim,
> +       .post_online    =3D tc65_post_online,
> +};
> +
> +static int tc65_init(void)
> +{
> +       int rc;
> +
> +       rc =3D ofono_modem_driver_register(&tc65_driver);
> +
> +       if (rc !=3D 0)
> +               return rc;
> +
> +       return 0;
> +}
> +
> +static void tc65_exit(void)
> +{
> +       ofono_modem_driver_unregister(&tc65_driver);
> +}
> +
> +OFONO_PLUGIN_DEFINE(tc65, "Cinterion TC65 driver plugin", VERSION,
> +               OFONO_PLUGIN_PRIORITY_DEFAULT, tc65_init, tc65_exit)
> --
> 1.6.3.3
> =

> -- See us at Mobile World Congress, 14-17 February 2011, in Barcelona, Sp=
ain. Visit the Ixonos booth Hall 1, # 1E19.
> =

> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono

Otherwise this looks good to me.

Regards,
-Denis

--===============5316035151008123633==--

