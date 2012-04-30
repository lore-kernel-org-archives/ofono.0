Content-Type: multipart/mixed; boundary="===============1840422057836743995=="
MIME-Version: 1.0
From: Pablo Neira Ayuso <pablo@gnumonks.org>
Subject: Re: [PATCH] wavecom: add support for Wavecom Q2403/Q2686 modems
Date: Mon, 30 Apr 2012 18:37:47 +0200
Message-ID: <20120430163747.GA8993@1984>
In-Reply-To: <4F9DE77C.2010606@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1840422057836743995==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

First off, thanks for your quick review.

On Sun, Apr 29, 2012 at 08:14:36PM -0500, Denis Kenzior wrote:
> Hi Pablo,
> =

> On 04/30/2012 09:45 AM, pablo(a)gnumonks.org wrote:
> > From: Pablo Neira Ayuso <pablo@gnumonks.org>
> > =

> > This patch adds support for voice calls and SMS for Wavecom
> > Q2403/Q2686.
> > =

> > The existing Wavecom driver in tree slightly differs from these
> > modems. Thus, it doesn't work work with them. We (the osmocom
> > team) are use these Wavecom Q2403/Q2686 modems in our testbed.
> > ---
> >  Makefile.am              |    3 +
> >  drivers/atmodem/sim.c    |    8 ++
> >  drivers/atmodem/sms.c    |   31 ++++++--
> >  drivers/atmodem/vendor.h |    1 +
> >  gatchat/gatchat.c        |    3 +-
> >  plugins/udev.c           |    2 +
> >  plugins/wavecom_q.c      |  192 ++++++++++++++++++++++++++++++++++++++=
++++++++
> =

> Can you please break this patch up, we prefer one patch for every
> directory.  See HACKING document for patch submission guidelines.

OK, I'll do it like that if you prefer it.

I think it breaks a bit of the logic of "one patch one new feature" and
it leaves the repository in intermediate state between patches, but
this is your project, you rule here :-).

> >  7 files changed, 234 insertions(+), 6 deletions(-)
> >  create mode 100644 plugins/wavecom_q.c
> > =

> > diff --git a/Makefile.am b/Makefile.am
> > index 9cb490d..0bcbb8a 100644
> > --- a/Makefile.am
> > +++ b/Makefile.am
> > @@ -371,6 +371,9 @@ builtin_sources +=3D plugins/samsung.c
> >  builtin_modules +=3D sim900
> >  builtin_sources +=3D plugins/sim900.c
> >  =

> > +builtin_modules +=3D wavecom_q
> > +builtin_sources +=3D plugins/wavecom_q.c
> > +
> >  if BLUETOOTH
> >  builtin_modules +=3D bluetooth
> >  builtin_sources +=3D plugins/bluetooth.c plugins/bluetooth.h
> > diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
> > index dd86980..64f38a8 100644
> > --- a/drivers/atmodem/sim.c
> > +++ b/drivers/atmodem/sim.c
> > @@ -146,6 +146,14 @@ static void at_sim_read_info(struct ofono_sim *sim=
, int fileid,
> >  			return;
> >  		}
> >  	}
> > +	/* AT+CRSM not supported by Q2403. */
> > +	if (sd->vendor =3D=3D OFONO_VENDOR_WAVECOM_Q) {
> > +		unsigned char access[3] =3D { 0x00, 0x00, 0x00 };
> > +
> > +		CALLBACK_WITH_SUCCESS(cb, 4, 0, 0, access,
> > +					EF_STATUS_VALID, data);
> =

> Why don't you simply return an error here?

Without it, the modem initialization does not complete.

> > +		return;
> > +	}
> >  =

> >  	cbd =3D cb_data_new(cb, data);
> >  =

> > diff --git a/drivers/atmodem/sms.c b/drivers/atmodem/sms.c
> > index 27dc2c0..af53880 100644
> > --- a/drivers/atmodem/sms.c
> > +++ b/drivers/atmodem/sms.c
> > @@ -984,8 +984,12 @@ static gboolean set_cpms(gpointer user_data)
> >  	const char *incoming =3D storages[data->incoming];
> >  	char buf[128];
> >  =

> > -	snprintf(buf, sizeof(buf), "AT+CPMS=3D\"%s\",\"%s\",\"%s\"",
> > -			store, store, incoming);
> > +	if (data->vendor !=3D OFONO_VENDOR_WAVECOM_Q) {
> > +		snprintf(buf, sizeof(buf), "AT+CPMS=3D\"%s\",\"%s\",\"%s\"",
> > +				store, store, incoming);
> > +	} else {
> > +		snprintf(buf, sizeof(buf), "AT+CPMS=3D\"%s\"", store);
> > +	}
> =

> There is no need for any curly braces.

You mean for both snprintf, right?

> >  	g_at_chat_send(data->chat, buf, cpms_prefix,
> >  			at_cpms_set_cb, sms, NULL);
> > @@ -1037,7 +1041,7 @@ static void at_cpms_query_cb(gboolean ok, GAtResu=
lt *result,
> >  	gboolean supported =3D FALSE;
> >  =

> >  	if (ok) {
> > -		int mem =3D 0;
> > +		int mem =3D 0, mem_max;
> >  		GAtResultIter iter;
> >  		const char *store;
> >  		gboolean me_supported[3];
> > @@ -1053,7 +1057,23 @@ static void at_cpms_query_cb(gboolean ok, GAtRes=
ult *result,
> >  		if (!g_at_result_iter_next(&iter, "+CPMS:"))
> >  			goto out;
> >  =

> > -		for (mem =3D 0; mem < 3; mem++) {
> > +		/* Wavecom Q replies something like this:
> > +		 *
> > +		 * +CPMS: (("SM","BM","SR"),("SM"))
> > +		 *
> > +		 * It does not provide the way income messages are stored.
> > +		 * 3GPP TS 07.05 allows mem2 and mem3 to be optional.
> > +		 */
> =

> Just how old is this modem and what version of 07.05 are you using?
> =

> For reference, 07.05 version 7.0.1 from July 1999:
> "
> +CPMS=3D?
> +CPMS: (list of supported <mem1>s),(list of supported <mem2>s),
> (list of supported <mem3>s)
> "
> =

> So the comment should probably be changed to indicate that this modem is
> just broken.
> =


From: "3.2.2 Preferred Message Storage +CPMS" (TS 07.05 July 1999):

+CPMS=3D<mem1>[, <mem2>[,<mem3>]]

The brackets around <mem3> sound like it is optional thing.

Unless I'm missing anything I think the comment is fine.

> > +		if (data->vendor =3D=3D OFONO_VENDOR_WAVECOM_Q) {
> > +			/* skip initial `(' */
> > +			if (!g_at_result_iter_open_list(&iter))
> > +				goto out;
> > +
> > +			mem_max =3D 2;
> > +		} else
> > +			mem_max =3D 3;
> > +
> > +		for (mem =3D 0; mem < mem_max; mem++) {
> >  			if (!g_at_result_iter_open_list(&iter))
> >  				goto out;
> >  =

> > @@ -1070,7 +1090,8 @@ static void at_cpms_query_cb(gboolean ok, GAtResu=
lt *result,
> >  				goto out;
> >  		}
> >  =

> > -		if (!sm_supported[2] && !me_supported[2] && !mt_supported[2])
> > +		if (data->vendor !=3D OFONO_VENDOR_WAVECOM_Q &&
> > +		    !sm_supported[2] && !me_supported[2] && !mt_supported[2])
> =

> Please don't use spaces for indentation, always tabs

OK, so you prefer this, right?

        if (data->vendor !=3D OFONO_VENDOR_WAVECOM_Q &&
                !sm_supported[2] && !me_supported[2] && !mt_supported[2])

> >  			goto out;
> >  =

> >  		if (sm_supported[0] && sm_supported[1]) {
> > diff --git a/drivers/atmodem/vendor.h b/drivers/atmodem/vendor.h
> > index 44b037f..1b296a0 100644
> > --- a/drivers/atmodem/vendor.h
> > +++ b/drivers/atmodem/vendor.h
> > @@ -39,4 +39,5 @@ enum ofono_vendor {
> >  	OFONO_VENDOR_SPEEDUP,
> >  	OFONO_VENDOR_SAMSUNG,
> >  	OFONO_VENDOR_SIMCOM,
> > +	OFONO_VENDOR_WAVECOM_Q,
> >  };
> > diff --git a/gatchat/gatchat.c b/gatchat/gatchat.c
> > index 7a0ef35..eb5d83a 100644
> > --- a/gatchat/gatchat.c
> > +++ b/gatchat/gatchat.c
> > @@ -478,7 +478,8 @@ static struct terminator_info terminator_table[] =
=3D {
> >  	{ "NO ANSWER", -1, FALSE },
> >  	{ "+CMS ERROR:", 11, FALSE },
> >  	{ "+CME ERROR:", 11, FALSE },
> > -	{ "+EXT ERROR:", 11, FALSE }
> > +	{ "+EXT ERROR:", 11, FALSE },
> > +	{ "+CPIN: READY", -1, TRUE },
> =

> Are you sure you can't reuse the same behavior as OFONO_VENDOR_WAVECOM
> quirk inside drivers/atmodem/sim.c?

Yes, I remember to have tried that. That quirk didn't work for me
though.

> e.g. in at_sim_probe():
>         switch (sd->vendor) {
>         case OFONO_VENDOR_WAVECOM:
>                 g_at_chat_add_terminator(sd->chat, "+CPIN:", 6, TRUE);
>                 break;
> =

> >  };
> >  =

> >  static void at_chat_add_terminator(struct at_chat *chat, char *termina=
tor,
> > diff --git a/plugins/udev.c b/plugins/udev.c
> > index 8cb87a5..e599296 100644
> > --- a/plugins/udev.c
> > +++ b/plugins/udev.c
> > @@ -286,6 +286,8 @@ done:
> >  		add_nokiacdma(modem, udev_device);
> >  	else if (g_strcmp0(driver, "sim900") =3D=3D 0)
> >  		add_sim900(modem, udev_device);
> > +	else if (g_strcmp0(driver, "wavecom_q") =3D=3D 0)
> > +		add_calypso(modem, udev_device);
> =

> This is probably wrong, I suspect we need to add a generic function to
> register (real) serial tty based modems.

I should have added some add_wavecom function instead.

I used that because I noticed that:

add_sim900
add_nokiacdma
add_tc65
...
and so on.

look the same. So I guess that it is indeed a good idea to remove
redundant code and provide some generic one.

> =

> >  }
> >  =

> >  static gboolean devpath_remove(gpointer key, gpointer value, gpointer =
user_data)
> > diff --git a/plugins/wavecom_q.c b/plugins/wavecom_q.c
> > new file mode 100644
> > index 0000000..73e478a
> > --- /dev/null
> > +++ b/plugins/wavecom_q.c
> > @@ -0,0 +1,192 @@
> > +/*
> > + *
> > + *  oFono - Open Source Telephony
> > + *
> > + *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
> > + *
> > + *  This program is free software; you can redistribute it and/or modi=
fy
> > + *  it under the terms of the GNU General Public License version 2 as
> > + *  published by the Free Software Foundation.
> > + *
> > + *  This program is distributed in the hope that it will be useful,
> > + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + *  GNU General Public License for more details.
> > + *
> > + *  You should have received a copy of the GNU General Public License
> > + *  along with this program; if not, write to the Free Software
> > + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1=
301  USA
> > + *
> > + */
> > +
> > +#ifdef HAVE_CONFIG_H
> > +#include <config.h>
> > +#endif
> > +
> > +#include <errno.h>
> > +#include <stdlib.h>
> > +
> > +#include <glib.h>
> > +#include <gatchat.h>
> > +#include <gattty.h>
> > +
> > +#define OFONO_API_SUBJECT_TO_CHANGE
> > +#include <ofono/plugin.h>
> > +#include <ofono/log.h>
> > +#include <ofono/modem.h>
> > +#include <ofono/call-barring.h>
> > +#include <ofono/call-forwarding.h>
> > +#include <ofono/call-meter.h>
> > +#include <ofono/call-settings.h>
> > +#include <ofono/devinfo.h>
> > +#include <ofono/message-waiting.h>
> > +#include <ofono/netreg.h>
> > +#include <ofono/phonebook.h>
> > +#include <ofono/sim.h>
> > +#include <ofono/sms.h>
> > +#include <ofono/ussd.h>
> > +#include <ofono/voicecall.h>
> > +
> > +#include <drivers/atmodem/vendor.h>
> > +
> > +
> > +static int wavecom_q_probe(struct ofono_modem *modem)
> > +{
> > +	return 0;
> > +}
> > +
> > +static void wavecom_q_remove(struct ofono_modem *modem)
> > +{
> > +}
> > +
> > +static void wavecom_q_debug(const char *str, void *user_data)
> > +{
> > +	const char *prefix =3D user_data;
> > +
> > +	ofono_info("%s%s", prefix, str);
> > +}
> > +
> > +static int wavecom_q_enable(struct ofono_modem *modem)
> > +{
> > +	GAtChat *chat;
> > +	GIOChannel *channel;
> > +	GAtSyntax *syntax;
> > +	const char *device;
> > +	GHashTable *options;
> > +
> > +	DBG("%p", modem);
> > +
> > +	device =3D ofono_modem_get_string(modem, "Device");
> > +	if (device =3D=3D NULL)
> > +		return -EINVAL;
> > +
> > +	options =3D g_hash_table_new(g_str_hash, g_str_equal);
> > +
> > +	if (options =3D=3D NULL)
> > +		return -ENOMEM;
> > +
> > +	g_hash_table_insert(options, "Baud", "115200");
> > +	g_hash_table_insert(options, "Parity", "none");
> > +	g_hash_table_insert(options, "StopBits", "1");
> > +	g_hash_table_insert(options, "DataBits", "8");
> > +
> > +	channel =3D g_at_tty_open(device, options);
> > +
> > +	g_hash_table_destroy(options);
> > +
> > +	if (channel =3D=3D NULL)
> > +		return -EIO;
> > +
> > +	/*
> > +	 * Could not figure out whether it is fully compliant or not, use
> > +	 * permissive for now
> > +	 * */
> > +	syntax =3D g_at_syntax_new_gsm_permissive();
> > +
> > +	chat =3D g_at_chat_new(channel, syntax);
> > +	g_at_syntax_unref(syntax);
> > +	g_io_channel_unref(channel);
> > +
> > +	if (chat =3D=3D NULL)
> > +		return -ENOMEM;
> > +
> > +	if (getenv("OFONO_AT_DEBUG"))
> > +		g_at_chat_set_debug(chat, wavecom_q_debug, "");
> > +
> > +	ofono_modem_set_data(modem, chat);
> > +
> > +	return 0;
> > +}
> > +
> > +static int wavecom_q_disable(struct ofono_modem *modem)
> > +{
> > +	GAtChat *chat =3D ofono_modem_get_data(modem);
> > +
> > +	DBG("%p", modem);
> > +
> > +	ofono_modem_set_data(modem, NULL);
> > +
> > +	g_at_chat_unref(chat);
> > +
> > +	return 0;
> > +}
> > +
> > +static void wavecom_q_pre_sim(struct ofono_modem *modem)
> > +{
> > +	GAtChat *chat =3D ofono_modem_get_data(modem);
> > +	struct ofono_sim *sim;
> > +
> > +	DBG("%p", modem);
> > +
> > +	ofono_devinfo_create(modem, 0, "atmodem", chat);
> > +	sim =3D ofono_sim_create(modem, OFONO_VENDOR_WAVECOM, "atmodem", chat=
);
> > +	ofono_voicecall_create(modem, 0, "atmodem", chat);
> > +
> > +	if (sim)
> > +		ofono_sim_inserted_notify(sim, TRUE);
> > +}
> > +
> > +static void wavecom_q_post_sim(struct ofono_modem *modem)
> > +{
> > +	GAtChat *chat =3D ofono_modem_get_data(modem);
> > +	struct ofono_message_waiting *mw;
> > +
> > +	DBG("%p", modem);
> > +
> > +	ofono_ussd_create(modem, 0, "atmodem", chat);
> > +	ofono_call_forwarding_create(modem, 0, "atmodem", chat);
> > +	ofono_call_settings_create(modem, 0, "atmodem", chat);
> > +	ofono_netreg_create(modem, 0, "atmodem", chat);
> > +	ofono_call_meter_create(modem, 0, "atmodem", chat);
> > +	ofono_call_barring_create(modem, 0, "atmodem", chat);
> > +	/* We need to specify the vendor to support AT+CPMS=3D? reply. */
> > +	ofono_sms_create(modem, OFONO_VENDOR_WAVECOM_Q, "atmodem", chat);
> > +	ofono_phonebook_create(modem, 0, "atmodem", chat);
> > +
> > +	mw =3D ofono_message_waiting_create(modem);
> > +	if (mw)
> > +		ofono_message_waiting_register(mw);
> > +}
> > +
> > +static struct ofono_modem_driver wavecom_q_driver =3D {
> > +	.name		=3D "wavecom_q",
> > +	.probe		=3D wavecom_q_probe,
> > +	.remove		=3D wavecom_q_remove,
> > +	.enable		=3D wavecom_q_enable,
> > +	.disable	=3D wavecom_q_disable,
> > +	.pre_sim	=3D wavecom_q_pre_sim,
> > +	.post_sim	=3D wavecom_q_post_sim,
> > +};
> > +
> > +static int wavecom_q_init(void)
> > +{
> > +	return ofono_modem_driver_register(&wavecom_q_driver);
> > +}
> > +
> > +static void wavecom_q_exit(void)
> > +{
> > +	ofono_modem_driver_unregister(&wavecom_q_driver);
> > +}
> > +
> > +OFONO_PLUGIN_DEFINE(wavecom_q, "Wavecom-Q driver", VERSION,
> > +		OFONO_PLUGIN_PRIORITY_DEFAULT, wavecom_q_init, wavecom_q_exit)
> =

> Is there a way to just re-use the wavecom driver instead of creating a
> brand new one?

I didn't find any cleaner solution I could like, but if you propose any
other solution, I'll make it.

--===============1840422057836743995==--

