Content-Type: multipart/mixed; boundary="===============8096385396610291827=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: Re: [RFC] m95: Add driver for Quectel M95 modem
Date: Mon, 27 Aug 2018 10:37:59 +0200
Message-ID: <a984f37e-696e-6e23-d33a-fc0b4d66c48b@geanix.com>
In-Reply-To: <55487586-6887-336c-87be-af108f5d51b6@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8096385396610291827==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

Thanks for the review. I am working on doing a proper patch with your =

comments addressed. I do have some feedback below, though.

// Martin

On 24/08/2018 18.59, Denis Kenzior wrote:
> Hi Martin,
> =

> On 08/24/2018 06:34 AM, Martin Hundeb=C3=B8ll wrote:
>> So far the driver is only tested with GPRS.
>>
>> The modem uses GSM 07.10 multiplexing, which breaks when changing
>> functional modes (i.e. going from CFUN=3D4 to CFUN=3D1), the driver does=
n't
>> implement online/offline states. It does support disabling the device to
>> save power though, but users must go through the full setup procedure to
>> enable the device again.
> =

> So just a general nitpick.=C2=A0 oFono uses a customized version of the L=
inux =

> Kernel coding style.=C2=A0 The main house rules are outlined in =

> doc/coding-style.txt.=C2=A0 Another difference is that we don't mix tabs =
& =

> spaces for indentation.
> =

>> ---
>> =C2=A0 Makefile.am=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +
>> =C2=A0 plugins/m95.c=C2=A0=C2=A0=C2=A0 | 492 +++++++++++++++++++++++++++=
++++++++++++++++++++
>> =C2=A0 plugins/udevng.c |=C2=A0=C2=A0 1 +
>> =C2=A0 3 files changed, 496 insertions(+)
>> =C2=A0 create mode 100644 plugins/m95.c
>>
>> diff --git a/Makefile.am b/Makefile.am
>> index 6dee4ce3..6fe4258a 100644
>> --- a/Makefile.am
>> +++ b/Makefile.am
>> @@ -511,6 +511,9 @@ builtin_sources +=3D plugins/telit.c
>> =C2=A0 builtin_modules +=3D quectel
>> =C2=A0 builtin_sources +=3D plugins/quectel.c
>> +builtin_modules +=3D m95
>> +builtin_sources +=3D plugins/m95.c
>> +
>> =C2=A0 builtin_modules +=3D ublox
>> =C2=A0 builtin_sources +=3D plugins/ublox.c
>> diff --git a/plugins/m95.c b/plugins/m95.c
>> new file mode 100644
>> index 00000000..32746996
>> --- /dev/null
>> +++ b/plugins/m95.c
>> @@ -0,0 +1,492 @@
>> +/*
>> + *
>> + *=C2=A0 oFono - Open Source Telephony
>> + *
>> + *=C2=A0 Copyright (C) 2008-2018=C2=A0 Intel Corporation. All rights re=
served.
>> + *
>> + *=C2=A0 This program is free software; you can redistribute it and/or =
modify
>> + *=C2=A0 it under the terms of the GNU General Public License version 2=
 as
>> + *=C2=A0 published by the Free Software Foundation.
>> + *
>> + *=C2=A0 This program is distributed in the hope that it will be useful,
>> + *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See=
 the
>> + *=C2=A0 GNU General Public License for more details.
>> + *
>> + *=C2=A0 You should have received a copy of the GNU General Public Lice=
nse
>> + *=C2=A0 along with this program; if not, write to the Free Software
>> + *=C2=A0 Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  =

>> 02110-1301=C2=A0 USA
>> + *
>> + */
>> +
>> +#ifdef HAVE_CONFIG_H
>> +#include <config.h>
>> +#endif
>> +
>> +#include <errno.h>
>> +#include <stdlib.h>
>> +#include <unistd.h>
>> +#include <glib.h>
>> +#include <gatchat.h>
>> +#include <gattty.h>
>> +#include <gatmux.h>
>> +
>> +#define OFONO_API_SUBJECT_TO_CHANGE
>> +#include <ofono/plugin.h>
>> +#include <ofono/modem.h>
>> +#include <ofono/devinfo.h>
>> +#include <ofono/netreg.h>
>> +#include <ofono/sim.h>
>> +#include <ofono/sms.h>
>> +#include <ofono/ussd.h>
>> +#include <ofono/gprs.h>
>> +#include <ofono/gprs-context.h>
>> +#include <ofono/phonebook.h>
>> +#include <ofono/history.h>
>> +#include <ofono/log.h>
>> +#include <ofono/voicecall.h>
>> +#include <ofono/call-volume.h>
>> +#include <drivers/atmodem/vendor.h>
>> +
>> +#define NUM_DLC 5
>> +
>> +#define VOICE_DLC=C2=A0=C2=A0 0
>> +#define NETREG_DLC=C2=A0 1
>> +#define SMS_DLC=C2=A0=C2=A0=C2=A0=C2=A0 2
>> +#define GPRS_DLC=C2=A0=C2=A0=C2=A0 3
>> +#define SETUP_DLC=C2=A0=C2=A0 4
>> +
>> +static char *dlc_prefixes[NUM_DLC] =3D {"Voice: ", "Net: ", "SMS: ",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "GPRS: " , "Setup=
: "};
>> +
>> +static const char *reset_prefix[]=C2=A0=C2=A0 =3D {"+CFUN:", NULL};
>> +static const char *enable_prefix[]=C2=A0 =3D {"+CPIN:", NULL};
>> +
> =

> These names are a bit strange...=C2=A0 What does cpin have to do with ena=
ble?

This modem instantly responds with "OK" when issuing a reset, but isn't =

ready until it later prints "+CPIN:\r\nVoicecall Ready"

I'll add a comment to the variable decleration.

>> +struct m95_data {
>> +=C2=A0=C2=A0=C2=A0 GIOChannel *tty;
>> +=C2=A0=C2=A0=C2=A0 GAtMux *mux;
>> +=C2=A0=C2=A0=C2=A0 GAtChat *dlcs[NUM_DLC];
>> +=C2=A0=C2=A0=C2=A0 guint cfun_reset;
>> +=C2=A0=C2=A0=C2=A0 guint cfun_enable;
>> +=C2=A0=C2=A0=C2=A0 guint cfun_disable_timeout;
> =

> No enable timeout?
> =

>> +};
>> +
>> +static int m95_probe(struct ofono_modem *modem)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct m95_data *data;
>> +
>> +=C2=A0=C2=A0=C2=A0 DBG("%p", modem);
>> +
>> +=C2=A0=C2=A0=C2=A0 data =3D g_try_new0(struct m95_data, 1);
>> +=C2=A0=C2=A0=C2=A0 if (data =3D=3D NULL)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOMEM;
> =

> So these days we prefer not to use g_try_new0 for small allocations. =

> Just use g_new0 here.=C2=A0 On Linux it is almost impossible to run out =

> memory in these cases anyway.
> =

>> +
>> +=C2=A0=C2=A0=C2=A0 ofono_modem_set_data(modem, data);
>> +
>> +=C2=A0=C2=A0=C2=A0 return 0;
>> +}
>> +
>> +static void m95_remove(struct ofono_modem *modem)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct m95_data *data =3D ofono_modem_get_data(modem=
);
>> +
>> +=C2=A0=C2=A0=C2=A0 DBG("%p", modem);
>> +
>> +=C2=A0=C2=A0=C2=A0 ofono_modem_set_data(modem, NULL);
>> +
>> +=C2=A0=C2=A0=C2=A0 g_free(data);
>> +}
>> +
>> +static void m95_debug(const char *str, void *user_data)
>> +{
>> +=C2=A0=C2=A0=C2=A0 const char *prefix =3D user_data;
>> +
>> +=C2=A0=C2=A0=C2=A0 ofono_info("%s%s", prefix, str);
>> +}
>> +
>> +static GAtChat *open_device(struct ofono_modem *modem,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cons=
t char *key, char *debug)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct m95_data *data =3D ofono_modem_get_data(modem=
);
>> +=C2=A0=C2=A0=C2=A0 const char *device;
>> +=C2=A0=C2=A0=C2=A0 GAtSyntax *syntax;
>> +=C2=A0=C2=A0=C2=A0 GAtChat *chat;
>> +=C2=A0=C2=A0=C2=A0 GHashTable *options;
>> +
>> +=C2=A0=C2=A0=C2=A0 device =3D ofono_modem_get_string(modem, key);
>> +=C2=A0=C2=A0=C2=A0 if (device =3D=3D NULL)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>> +
>> +=C2=A0=C2=A0=C2=A0 DBG("%s %s", key, device);
>> +
>> +=C2=A0=C2=A0=C2=A0 options =3D g_hash_table_new(g_str_hash, g_str_equal=
);
>> +=C2=A0=C2=A0=C2=A0 if (options =3D=3D NULL)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>> +
>> +=C2=A0=C2=A0=C2=A0 g_hash_table_insert(options, "Baud", "115200");
>> +=C2=A0=C2=A0=C2=A0 g_hash_table_insert(options, "Parity", "none");
>> +=C2=A0=C2=A0=C2=A0 g_hash_table_insert(options, "StopBits", "1");
>> +=C2=A0=C2=A0=C2=A0 g_hash_table_insert(options, "DataBits", "8");
>> +=C2=A0=C2=A0=C2=A0 g_hash_table_insert(options, "XonXoff", "off");
>> +=C2=A0=C2=A0=C2=A0 g_hash_table_insert(options, "Local", "off");
>> +=C2=A0=C2=A0=C2=A0 g_hash_table_insert(options, "RtsCts", "off");
>> +=C2=A0=C2=A0=C2=A0 g_hash_table_insert(options, "Read", "on");
>> +
>> +=C2=A0=C2=A0=C2=A0 /* open serial device */
>> +=C2=A0=C2=A0=C2=A0 data->tty =3D g_at_tty_open(device, options);
>> +=C2=A0=C2=A0=C2=A0 g_hash_table_destroy(options);
>> +
>> +=C2=A0=C2=A0=C2=A0 if (data->tty =3D=3D NULL)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>> +
>> +=C2=A0=C2=A0=C2=A0 /* create AT chat instance */
>> +=C2=A0=C2=A0=C2=A0 syntax =3D g_at_syntax_new_gsm_permissive();
>> +=C2=A0=C2=A0=C2=A0 chat =3D g_at_chat_new(data->tty, syntax);
>> +=C2=A0=C2=A0=C2=A0 g_at_syntax_unref(syntax);
>> +
>> +=C2=A0=C2=A0=C2=A0 if (chat =3D=3D NULL) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_io_channel_unref(data->tty=
);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->tty =3D NULL;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 if (getenv("OFONO_AT_DEBUG"))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_at_chat_set_debug(chat, m9=
5_debug, debug);
>> +
>> +=C2=A0=C2=A0=C2=A0 return chat;
>> +}
>> +
>> +static GAtChat *create_chat(GIOChannel *channel, struct ofono_modem =

>> *modem,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 char *debug)
>> +{
>> +=C2=A0=C2=A0=C2=A0 GAtSyntax *syntax;
>> +=C2=A0=C2=A0=C2=A0 GAtChat *chat;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (channel =3D=3D NULL)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>> +
>> +=C2=A0=C2=A0=C2=A0 syntax =3D g_at_syntax_new_gsmv1();
>> +=C2=A0=C2=A0=C2=A0 chat =3D g_at_chat_new(channel, syntax);
>> +=C2=A0=C2=A0=C2=A0 g_at_syntax_unref(syntax);
>> +
>> +=C2=A0=C2=A0=C2=A0 if (chat =3D=3D NULL)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (getenv("OFONO_AT_DEBUG"))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_at_chat_set_debug(chat, m9=
5_debug, debug);
>> +
>> +=C2=A0=C2=A0=C2=A0 return chat;
>> +}
>> +
>> +static void shutdown_device(struct m95_data *data)
>> +{
>> +=C2=A0=C2=A0=C2=A0 int i;
>> +
> =

> Might consider just doing
> =

> if (!data->mux)
>  =C2=A0=C2=A0=C2=A0=C2=A0goto close_tty;
> =

>> +=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < NUM_DLC; i++) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (data->dlcs[i] =3D=3D NUL=
L)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cont=
inue;
>> +
> =

> And skip this part

I'll reorder the shutdown routine, but keep this check in place. The =

setup_internal_mux() function below might break in its for-loop due to a =

NULL-pointer returned from create_chat() and then call this function.

>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DBG("clean AT chat channel %=
i", i);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_at_chat_cancel_all(data->d=
lcs[i]);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_at_chat_unregister_all(dat=
a->dlcs[i]);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_at_chat_unref(data->dlcs[i=
]);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->dlcs[i] =3D NULL;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 if (data->mux) {
> =

> And this if might not be needed then either
> =

>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DBG("clean mux instance");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_at_mux_shutdown(data->mux);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_at_mux_unref(data->mux);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->mux =3D NULL;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
> =

> close_tty:
>> +=C2=A0=C2=A0=C2=A0 if (data->tty) {
> =

> Can this ever be non-NULL?=C2=A0 Even if it is, calling g_io_channel_unre=
f is =

> safe anyway.
> =

>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DBG("clean tty io instance");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_io_channel_unref(data->tty=
);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->tty =3D NULL;
>> +=C2=A0=C2=A0=C2=A0 }
>> +}
>> +
>> +static void setup_internal_mux(struct ofono_modem *modem)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct m95_data *data =3D ofono_modem_get_data(modem=
);
>> +=C2=A0=C2=A0=C2=A0 int i;
>> +
>> +=C2=A0=C2=A0=C2=A0 DBG("");
>> +
>> +=C2=A0=C2=A0=C2=A0 /* prepare the multiplexing instance */
>> +=C2=A0=C2=A0=C2=A0 data->mux =3D g_at_mux_new_gsm0710_basic(data->tty, =
127);
>> +=C2=A0=C2=A0=C2=A0 if (data->mux =3D=3D NULL)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto error;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (getenv("OFONO_MUX_DEBUG"))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_at_mux_set_debug(data->mux=
, m95_debug, "MUX: ");
>> +
>> +=C2=A0=C2=A0=C2=A0 if (!g_at_mux_start(data->mux)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_at_mux_shutdown(data->mux);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_at_mux_unref(data->mux);
> =

> data->mux =3D NULL?
> =

> Or alternatively, why not just goto error directly.
> =

>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto error;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 /* create multiplexing channels for gprs, net, voice=
, text, and
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * control */
>> +=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < NUM_DLC; i++) {
> =

> Note that you're not using SETUP_DLC for anything after the MUX is =

> created.=C2=A0 So not sure whether you want to treat is specially.

I'll replace the SETUP_DLC entry in .dlcs[] with a dedicated member instead.

>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GIOChannel *channel =3D g_at=
_mux_create_channel(data->mux);
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->dlcs[i] =3D create_cha=
t(channel, modem, dlc_prefixes[i]);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (data->dlcs[i] =3D=3D NUL=
L) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ofon=
o_error("Failed to create channel");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto=
 error;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_io_channel_unref(channel);
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 ofono_modem_set_powered(modem, TRUE);
>> +
>> +=C2=A0=C2=A0=C2=A0 return;
>> +
>> +error:
>> +=C2=A0=C2=A0=C2=A0 shutdown_device(data);
>> +=C2=A0=C2=A0=C2=A0 ofono_modem_set_powered(modem, FALSE);
>> +}
>> +
>> +static void mux_setup_cb(gboolean ok, GAtResult *result, gpointer =

>> user_data)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct ofono_modem *modem =3D user_data;
>> +=C2=A0=C2=A0=C2=A0 struct m95_data *data =3D ofono_modem_get_data(modem=
);
>> +
>> +=C2=A0=C2=A0=C2=A0 DBG("");
>> +
>> +=C2=A0=C2=A0=C2=A0 if (!ok)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto error;
>> +
>> +=C2=A0=C2=A0=C2=A0 /* free the initial setup channel, as it is going to=
 be created
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * using multiplexing */
>> +=C2=A0=C2=A0=C2=A0 g_at_chat_unref(data->dlcs[SETUP_DLC]);
>> +=C2=A0=C2=A0=C2=A0 data->dlcs[SETUP_DLC] =3D NULL;
> =

> If you make the changes I suggested above, make sure to destroy this =

> chat regardless of the error condition above.
> =

>> +
>> +=C2=A0=C2=A0=C2=A0 /* setup multiplexing */
>> +=C2=A0=C2=A0=C2=A0 setup_internal_mux(modem);
>> +
>> +=C2=A0=C2=A0=C2=A0 return;
>> +
>> +error:
>> +=C2=A0=C2=A0=C2=A0 shutdown_device(data);
>> +=C2=A0=C2=A0=C2=A0 ofono_modem_set_powered(modem, FALSE);
>> +}
>> +
>> +static void cfun_enable(GAtResult *result, gpointer user_data)
> =

> This sets up the mux, so a better name might be send_cmux or something =

> to that effect.
> =

>> +{
>> +=C2=A0=C2=A0=C2=A0 struct ofono_modem *modem =3D user_data;
>> +=C2=A0=C2=A0=C2=A0 struct m95_data *data =3D ofono_modem_get_data(modem=
);
>> +=C2=A0=C2=A0=C2=A0 GAtResultIter iter;
>> +
>> +=C2=A0=C2=A0=C2=A0 DBG("%p", modem);
>> +
>> +=C2=A0=C2=A0=C2=A0 g_at_result_iter_init(&iter, result);
>> +=C2=A0=C2=A0=C2=A0 if (!g_at_result_iter_next(&iter, enable_prefix[0]))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> +
>> +=C2=A0=C2=A0=C2=A0 /* remove the enable-completed listener */
>> +=C2=A0=C2=A0=C2=A0 if (data->cfun_enable) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_at_chat_unregister(data->d=
lcs[SETUP_DLC], data->cfun_enable);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->cfun_enable =3D 0;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 /* setup multiplexing */
>> +=C2=A0=C2=A0=C2=A0 g_at_chat_send(data->dlcs[SETUP_DLC], =

>> "AT+CMUX=3D0,0,5,127,10,3,30,10,2",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 NULL, mux_setup_cb, modem, NULL);
>> +}
>> +
>> +static void cfun_enable_query(gboolean ok, GAtResult *result,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gpointer user_data)
>> +{
>> +=C2=A0=C2=A0=C2=A0 DBG("ok %d", ok);
>> +
>> +=C2=A0=C2=A0=C2=A0 if (ok)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cfun_enable(result, user_dat=
a);
>> +}
>> +
>> +static void cfun_reset(GAtResult *result, gpointer user_data)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct ofono_modem *modem =3D user_data;
>> +=C2=A0=C2=A0=C2=A0 struct m95_data *data =3D ofono_modem_get_data(modem=
);
>> +=C2=A0=C2=A0=C2=A0 GAtResultIter iter;
>> +
>> +=C2=A0=C2=A0=C2=A0 DBG("%p", modem);
>> +
>> +=C2=A0=C2=A0=C2=A0 g_at_result_iter_init(&iter, result);
>> +=C2=A0=C2=A0=C2=A0 if (!g_at_result_iter_next(&iter, reset_prefix[0]))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> +
>> +=C2=A0=C2=A0=C2=A0 /* remove the reset-completed listener */
>> +=C2=A0=C2=A0=C2=A0 g_at_chat_unregister(data->dlcs[SETUP_DLC], data->cf=
un_reset);
>> +=C2=A0=C2=A0=C2=A0 data->cfun_reset =3D 0;
>> +
>> +=C2=A0=C2=A0=C2=A0 /* prepare to enable the modem */
>> +=C2=A0=C2=A0=C2=A0 g_at_chat_send(data->dlcs[SETUP_DLC], "ATE0", NULL, =
NULL, NULL, =

>> NULL);
>> +=C2=A0=C2=A0=C2=A0 g_at_chat_send(data->dlcs[SETUP_DLC], "AT+IFC=3D2,2"=
, NULL, NULL, =

>> NULL,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 NULL);
>> +=C2=A0=C2=A0=C2=A0 g_at_chat_send(data->dlcs[SETUP_DLC], "AT+GMM", NULL=
, NULL, NULL, =

>> NULL);
>> +=C2=A0=C2=A0=C2=A0 g_at_chat_send(data->dlcs[SETUP_DLC], "AT", NULL, NU=
LL, NULL, NULL);
>> +=C2=A0=C2=A0=C2=A0 g_at_chat_send(data->dlcs[SETUP_DLC], "AT+IPR=3D1152=
00&w", NULL, NULL,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 NULL, NULL);
>> +
>> +=C2=A0=C2=A0=C2=A0 /* setup a listener to delay multiplex-setup until m=
odem is ready */
>> +=C2=A0=C2=A0=C2=A0 data->cfun_enable =3D g_at_chat_register(data->dlcs[=
SETUP_DLC],
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 "+CPIN:", cfun_enable, FALSE,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 modem, NULL);
>> +
>> +=C2=A0=C2=A0=C2=A0 /* enable the modem */
>> +=C2=A0=C2=A0=C2=A0 g_at_chat_send(data->dlcs[SETUP_DLC], "AT+CFUN=3D1",=
 enable_prefix,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 cfun_enable_query, modem, NULL);
> =

> This isn't a query :)=C2=A0 cfun_enable_cb?
> =

>> +}
>> +
>> +static void cfun_reset_query(gboolean ok, GAtResult *result, gpointer =

>> user_data)
>> +{
>> +=C2=A0=C2=A0=C2=A0 DBG("ok %d", ok);
>> +
>> +=C2=A0=C2=A0=C2=A0 if (ok)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cfun_reset(result, user_data=
);
>> +}
>> +
>> +static int m95_enable(struct ofono_modem *modem)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct m95_data *data =3D ofono_modem_get_data(modem=
);
>> +
>> +=C2=A0=C2=A0=C2=A0 DBG("%p", modem);
>> +
>> +=C2=A0=C2=A0=C2=A0 data->dlcs[SETUP_DLC] =3D open_device(modem, "Device=
", "Setup: ");
>> +=C2=A0=C2=A0=C2=A0 if (data->dlcs[SETUP_DLC] =3D=3D NULL)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>> +
>> +=C2=A0=C2=A0=C2=A0 /* when issuing the reset below, the modem is not re=
ady until it
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * responds with "+CFUN: 0", so set up a listen=
er for this */
>> +=C2=A0=C2=A0=C2=A0 data->cfun_reset =3D g_at_chat_register(data->dlcs[S=
ETUP_DLC], =

>> "+CFUN:",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 cfun_reset, FALSE, modem, NULL);
>> +
>> +=C2=A0=C2=A0=C2=A0 /* bring the modem into a known state by issuing a r=
eset */
>> +=C2=A0=C2=A0=C2=A0 g_at_chat_send(data->dlcs[SETUP_DLC], "AT+CFUN=3D4,1=
", reset_prefix,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 cfun_reset_query, modem, NULL);
> =

> This is not a query.=C2=A0 A query is something with a question mark in t=
he =

> AT command.=C2=A0 Might want to just name this cfun_reset_cb
> =

>> +
>> +=C2=A0=C2=A0=C2=A0 return -EINPROGRESS;
>> +}
>> +
>> +static void cfun_disable(gboolean ok, GAtResult *result, gpointer =

>> user_data)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct ofono_modem *modem =3D user_data;
>> +=C2=A0=C2=A0=C2=A0 struct m95_data *data =3D ofono_modem_get_data(modem=
);
>> +
>> +=C2=A0=C2=A0=C2=A0 /* device is now in non-functional mode, so shut dow=
n it down */
>> +=C2=A0=C2=A0=C2=A0 shutdown_device(data);
>> +=C2=A0=C2=A0=C2=A0 ofono_modem_set_powered(modem, FALSE);
>> +}
>> +
>> +static gboolean cfun_disable_timeout(gpointer user_data)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct ofono_modem *modem =3D user_data;
>> +=C2=A0=C2=A0=C2=A0 struct m95_data *data =3D ofono_modem_get_data(modem=
);
>> +
>> +=C2=A0=C2=A0=C2=A0 /* now put device in non-functional mode */
>> +=C2=A0=C2=A0=C2=A0 g_at_chat_send(data->dlcs[SETUP_DLC], "AT+CFUN=3D0,1=
", NULL, =

>> cfun_disable,
> =

> cfun_disable_cb
> =

>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 modem, NULL);
>> +
>> +=C2=A0=C2=A0=C2=A0 return FALSE;
>> +}
>> +
>> +static int m95_disable(struct ofono_modem *modem)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct m95_data *data =3D ofono_modem_get_data(modem=
);
>> +
>> +=C2=A0=C2=A0=C2=A0 DBG("%p", modem);
>> +
>> +=C2=A0=C2=A0=C2=A0 /* shut down the device to tear down the muxing chan=
nels */
>> +=C2=A0=C2=A0=C2=A0 shutdown_device(data);
>> +
>> +=C2=A0=C2=A0=C2=A0 /* reopen device to get a plain AT control channel */
>> +=C2=A0=C2=A0=C2=A0 data->dlcs[SETUP_DLC] =3D open_device(modem, "Device=
", "Disable: ");
>> +=C2=A0=C2=A0=C2=A0 if (data->dlcs[SETUP_DLC] =3D=3D NULL)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>> +
>> +=C2=A0=C2=A0=C2=A0 /* add a timer to wait for device to drop GSM 07.10 =
multiplexing */
>> +=C2=A0=C2=A0=C2=A0 data->cfun_disable_timeout =3D g_timeout_add(500, =

>> cfun_disable_timeout,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 modem);
> =

> Ah, mux_dropped_timeout then.=C2=A0 And cfun_disable_timeout to =

> send_cfun_disable or something.
> =

>> +
>> +=C2=A0=C2=A0=C2=A0 return -EINPROGRESS;
>> +}
>> +
>> +static void m95_pre_sim(struct ofono_modem *modem)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct m95_data *data =3D ofono_modem_get_data(modem=
);
>> +=C2=A0=C2=A0=C2=A0 struct ofono_sim *sim;
>> +
>> +=C2=A0=C2=A0=C2=A0 DBG("%p", modem);
>> +
>> +=C2=A0=C2=A0=C2=A0 ofono_devinfo_create(modem, 0, "atmodem", data->dlcs=
[VOICE_DLC]);
>> +=C2=A0=C2=A0=C2=A0 sim =3D ofono_sim_create(modem, OFONO_VENDOR_QUECTEL=
, "atmodem",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data-=
>dlcs[VOICE_DLC]);
>> +
>> +=C2=A0=C2=A0=C2=A0 if (sim)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ofono_sim_inserted_notify(si=
m, TRUE);
> =

> I assume this modem doesn't support hotswap?

Hmm.. The modem does support dual-sim, but my test piece has only one slot.

The AT command reference specifies that the modem must be disabled to =

switch slot. So I guess it doesn't support hot-swap.

The SIM slot isn't accessible in my mockup, so I cannot really test it.

>> +}
>> +
>> +static void m95_post_sim(struct ofono_modem *modem)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct m95_data *data =3D ofono_modem_get_data(modem=
);
>> +=C2=A0=C2=A0=C2=A0 struct ofono_gprs *gprs;
>> +=C2=A0=C2=A0=C2=A0 struct ofono_gprs_context *gc;
>> +
>> +=C2=A0=C2=A0=C2=A0 DBG("%p", modem);
>> +
>> +=C2=A0=C2=A0=C2=A0 ofono_phonebook_create(modem, 0, "atmodem", data->dl=
cs[VOICE_DLC]);
>> +=C2=A0=C2=A0=C2=A0 ofono_sms_create(modem, OFONO_VENDOR_QUECTEL, "atmod=
em",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 data->dlcs[SMS_DLC]);
>> +
>> +=C2=A0=C2=A0=C2=A0 gprs =3D ofono_gprs_create(modem, 0, "atmodem", data=
->dlcs[GPRS_DLC]);
>> +=C2=A0=C2=A0=C2=A0 if (gprs =3D=3D NULL)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> +
>> +=C2=A0=C2=A0=C2=A0 gc =3D ofono_gprs_context_create(modem, OFONO_VENDOR=
_QUECTEL, =

>> "atmodem",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->dlcs[=
GPRS_DLC]);
>> +=C2=A0=C2=A0=C2=A0 if (gc)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ofono_gprs_add_context(gprs,=
 gc);
>> +}
>> +
>> +static void m95_post_online(struct ofono_modem *modem)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct m95_data *data =3D ofono_modem_get_data(modem=
);
>> +
>> +=C2=A0=C2=A0=C2=A0 DBG("%p", modem);
>> +
>> +=C2=A0=C2=A0=C2=A0 ofono_netreg_create(modem, OFONO_VENDOR_QUECTEL, "at=
modem",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 data->dlcs[NETREG_DLC]);
>> +=C2=A0=C2=A0=C2=A0 ofono_ussd_create(modem, 0, "atmodem", data->dlcs[VO=
ICE_DLC]);
>> +=C2=A0=C2=A0=C2=A0 ofono_voicecall_create(modem, 0, "atmodem", data->dl=
cs[VOICE_DLC]);
> =

> Generally voicecalls are created in pre_sim state for emergency calls...

OK, I'll move the call to m95_pre_sim(), and test with voice calls/text =

messages.

>> +=C2=A0=C2=A0=C2=A0 ofono_call_volume_create(modem, 0, "atmodem", =

>> data->dlcs[VOICE_DLC]);
>> +}
>> +
>> +static struct ofono_modem_driver m95_driver =3D {
>> +=C2=A0=C2=A0=C2=A0 .name=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D =
"m95",
>> +=C2=A0=C2=A0=C2=A0 .probe=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D=
 m95_probe,
>> +=C2=A0=C2=A0=C2=A0 .remove=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
=3D m95_remove,
>> +=C2=A0=C2=A0=C2=A0 .enable=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
=3D m95_enable,
>> +=C2=A0=C2=A0=C2=A0 .disable=C2=A0=C2=A0=C2=A0 =3D m95_disable,
>> +=C2=A0=C2=A0=C2=A0 .pre_sim=C2=A0=C2=A0=C2=A0 =3D m95_pre_sim,
>> +=C2=A0=C2=A0=C2=A0 .post_sim=C2=A0=C2=A0=C2=A0 =3D m95_post_sim,
>> +=C2=A0=C2=A0=C2=A0 .post_online=C2=A0=C2=A0=C2=A0 =3D m95_post_online,
>> +};
>> +
>> +static int m95_init(void)
>> +{
>> +=C2=A0=C2=A0=C2=A0 return ofono_modem_driver_register(&m95_driver);
>> +}
>> +
>> +static void m95_exit(void)
>> +{
>> +=C2=A0=C2=A0=C2=A0 ofono_modem_driver_unregister(&m95_driver);
>> +}
>> +
>> +OFONO_PLUGIN_DEFINE(m95, "Quectel M95 modem driver", VERSION,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 OFON=
O_PLUGIN_PRIORITY_DEFAULT, m95_init, m95_exit)
>> diff --git a/plugins/udevng.c b/plugins/udevng.c
>> index 71a70f0b..e58051d4 100644
>> --- a/plugins/udevng.c
>> +++ b/plugins/udevng.c
>> @@ -1303,6 +1303,7 @@ static struct {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { "wavecom",=C2=A0=C2=A0=C2=A0 setup_wave=
com=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { "tc65",=C2=A0=C2=A0=C2=A0 setup_tc65=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { "ehs6",=C2=A0=C2=A0=C2=A0 setup_ehs6=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
>> +=C2=A0=C2=A0=C2=A0 { "m95",=C2=A0=C2=A0=C2=A0 setup_serial_modem },
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { }
>> =C2=A0 };
>>
> =

> Regards,
> -Denis

--===============8096385396610291827==--

