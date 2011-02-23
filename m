Content-Type: multipart/mixed; boundary="===============2686338150488140220=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [PATCH v2 03/18] plugins: add plugin for u8500
Date: Wed, 23 Feb 2011 15:26:59 +0200
Message-ID: <AANLkTi=6AbYpLRd5qEB_UuCayvgTo_73=vj6pVVPgdZM@mail.gmail.com>
In-Reply-To: <6791487b6a0b10532aaa9f0bae8215471c989c87.1298460572.git.andreas.westin@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2686338150488140220==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andreas,

2011/2/23 Andreas Westin <andreas.westin@stericsson.com>:
> From: Jessica Nilsson <jessica.j.nilsson@stericsson.com>
>
> ---
> =C2=A0Makefile.am =C2=A0 =C2=A0 | =C2=A0 =C2=A03 +
> =C2=A0plugins/u8500.c | =C2=A0708 +++++++++++++++++++++++++++++++++++++++=
++++++++++++++++
> =C2=A02 files changed, 711 insertions(+), 0 deletions(-)
> =C2=A0create mode 100644 plugins/u8500.c

I pushed this patch, but split it into two, and fixed the plugin
description afterwards.

Cheers,
Aki

> diff --git a/Makefile.am b/Makefile.am
> index 7bd7f4f..aa4f3f9 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -144,6 +144,9 @@ builtin_sources +=3D plugins/isiusb.c
>
> =C2=A0builtin_modules +=3D n900
> =C2=A0builtin_sources +=3D plugins/n900.c plugins/nokia-gpio.h plugins/no=
kia-gpio.c
> +
> +builtin_modules +=3D u8500
> +builtin_sources +=3D plugins/u8500.c
> =C2=A0endif
>
> =C2=A0if ATMODEM
> diff --git a/plugins/u8500.c b/plugins/u8500.c
> new file mode 100644
> index 0000000..78e1a97
> --- /dev/null
> +++ b/plugins/u8500.c
> @@ -0,0 +1,708 @@
> +/*
> + *
> + * =C2=A0oFono - Open Source Telephony
> + *
> + * =C2=A0Copyright (C) 2010 =C2=A0Nokia Corporation and/or its subsidiar=
y(-ies).
> + * =C2=A0Copyright (C) ST-Ericsson SA 2011.
> + *
> + * =C2=A0This program is free software; you can redistribute it and/or m=
odify
> + * =C2=A0it under the terms of the GNU General Public License version 2 =
as
> + * =C2=A0published by the Free Software Foundation.
> + *
> + * =C2=A0This program is distributed in the hope that it will be useful,
> + * =C2=A0but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * =C2=A0MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =C2=A0See =
the
> + * =C2=A0GNU General Public License for more details.
> + *
> + * =C2=A0You should have received a copy of the GNU General Public Licen=
se
> + * =C2=A0along with this program; if not, write to the Free Software
> + * =C2=A0Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA =C2=
=A002110-1301 =C2=A0USA
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
> +#include <string.h>
> +#include <glib.h>
> +
> +#include <gisi/netlink.h>
> +#include <gisi/modem.h>
> +#include <gisi/client.h>
> +#include <gisi/message.h>
> +#include <gisi/iter.h>
> +
> +#define OFONO_API_SUBJECT_TO_CHANGE
> +#include <ofono/plugin.h>
> +#include <ofono/log.h>
> +#include <ofono/modem.h>
> +#include <ofono/devinfo.h>
> +#include <ofono/phonebook.h>
> +#include <ofono/netreg.h>
> +#include <ofono/voicecall.h>
> +#include <ofono/sms.h>
> +#include <ofono/cbs.h>
> +#include <ofono/sim.h>
> +#include <ofono/ussd.h>
> +#include <ofono/ssn.h>
> +#include <ofono/call-forwarding.h>
> +#include <ofono/call-settings.h>
> +#include <ofono/call-barring.h>
> +#include <ofono/call-meter.h>
> +#include <ofono/radio-settings.h>
> +#include <ofono/gprs.h>
> +#include <ofono/gprs-context.h>
> +
> +#include "drivers/isimodem/isimodem.h"
> +#include "drivers/isimodem/isiutil.h"
> +#include "drivers/isimodem/mtc.h"
> +#include "drivers/isimodem/debug.h"
> +
> +struct isi_data {
> + =C2=A0 =C2=A0 =C2=A0 char const *ifname;
> + =C2=A0 =C2=A0 =C2=A0 GIsiModem *modem;
> + =C2=A0 =C2=A0 =C2=A0 GIsiClient *client;
> + =C2=A0 =C2=A0 =C2=A0 GIsiPhonetNetlink *link;
> + =C2=A0 =C2=A0 =C2=A0 enum GIsiPhonetLinkState linkstate;
> + =C2=A0 =C2=A0 =C2=A0 unsigned interval;
> + =C2=A0 =C2=A0 =C2=A0 int reported;
> + =C2=A0 =C2=A0 =C2=A0 ofono_bool_t online;
> + =C2=A0 =C2=A0 =C2=A0 struct isi_cb_data *online_cbd;
> +};
> +
> +struct devinfo_data {
> + =C2=A0 =C2=A0 =C2=A0 GIsiClient *client;
> +};
> +
> +static gboolean check_response_status(const GIsiMessage *msg, uint8_t ms=
gid)
> +{
> + =C2=A0 =C2=A0 =C2=A0 if (g_isi_msg_error(msg) < 0) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DBG("Error: %s", strer=
ror(-g_isi_msg_error(msg)));
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return FALSE;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 if (g_isi_msg_id(msg) !=3D msgid) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DBG("Unexpected msg: %=
s",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 mce_message_id_name(g_isi_msg_id(msg)));
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return FALSE;
> + =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 return TRUE;
> +}
> +
> +static void report_powered(struct ofono_modem *modem, struct isi_data *i=
si,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ofono_bool_t powered)
> +{
> + =C2=A0 =C2=A0 =C2=A0 if (powered =3D=3D isi->reported)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> +
> + =C2=A0 =C2=A0 =C2=A0 isi->reported =3D powered;
> + =C2=A0 =C2=A0 =C2=A0 ofono_modem_set_powered(modem, powered);
> +}
> +
> +static void report_online(struct isi_data *isi, ofono_bool_t online)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct isi_cb_data *cbd =3D isi->online_cbd;
> + =C2=A0 =C2=A0 =C2=A0 ofono_modem_online_cb_t cb =3D cbd->cb;
> +
> + =C2=A0 =C2=A0 =C2=A0 isi->online_cbd =3D NULL;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (isi->online =3D=3D online)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CALLBACK_WITH_SUCCESS(=
cb, cbd->data);
> + =C2=A0 =C2=A0 =C2=A0 else
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CALLBACK_WITH_FAILURE(=
cb, cbd->data);
> +
> + =C2=A0 =C2=A0 =C2=A0 g_free(cbd);
> +}
> +
> +static void set_power_by_mce_state(struct ofono_modem *modem,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct isi_d=
ata *isi, int mce_state)
> +{
> + =C2=A0 =C2=A0 =C2=A0 switch (mce_state) {
> + =C2=A0 =C2=A0 =C2=A0 case MCE_POWER_OFF:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 report_powered(modem, =
isi, FALSE);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> + =C2=A0 =C2=A0 =C2=A0 case MCE_NORMAL:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (isi->online_cbd)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 report_online(isi, mce_state =3D=3D MCE_NORMAL);
> + =C2=A0 =C2=A0 =C2=A0 default:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 report_powered(modem, =
isi, TRUE);
> + =C2=A0 =C2=A0 =C2=A0 }
> +}
> +
> +static void mce_state_ind_cb(const GIsiMessage *msg, void *data)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct ofono_modem *modem =3D data;
> + =C2=A0 =C2=A0 =C2=A0 struct isi_data *isi =3D ofono_modem_get_data(mode=
m);
> + =C2=A0 =C2=A0 =C2=A0 uint8_t state;
> + =C2=A0 =C2=A0 =C2=A0 uint8_t action;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (isi =3D=3D NULL || g_isi_msg_id(msg) !=3D MCE_=
MODEM_STATE_IND)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (!g_isi_msg_data_get_byte(msg, 0, &state) ||
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 !g_isi_msg_data_get_byte(msg, 1, &action))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> +
> + =C2=A0 =C2=A0 =C2=A0 switch (action) {
> + =C2=A0 =C2=A0 =C2=A0 case MCE_START:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DBG("target modem stat=
e: %s (0x%02X)",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 mce_modem_state_name(state), state);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> +
> + =C2=A0 =C2=A0 =C2=A0 case MCE_READY:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DBG("current modem sta=
te: %s (0x%02X)",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 mce_modem_state_name(state), state);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set_power_by_mce_state=
(modem, isi, state);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> + =C2=A0 =C2=A0 =C2=A0 default:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> + =C2=A0 =C2=A0 =C2=A0 }
> +}
> +
> +static void mce_rf_state_ind_cb(const GIsiMessage *msg, void *data)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct ofono_modem *modem =3D data;
> + =C2=A0 =C2=A0 =C2=A0 struct isi_data *isi =3D ofono_modem_get_data(mode=
m);
> + =C2=A0 =C2=A0 =C2=A0 uint8_t state;
> + =C2=A0 =C2=A0 =C2=A0 uint8_t action;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (isi =3D=3D NULL || g_isi_msg_id(msg) !=3D MCE_=
RF_STATE_IND)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (!g_isi_msg_data_get_byte(msg, 0, &state) ||
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 !g_isi_msg_data_get_byte(msg, 1, &action))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> +
> + =C2=A0 =C2=A0 =C2=A0 switch (action) {
> + =C2=A0 =C2=A0 =C2=A0 case MCE_READY:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DBG("current rf state:=
 %s (0x%02X)",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 mce_rf_state_name(state), state);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (isi->online_cbd)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 report_online(isi, state);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> + =C2=A0 =C2=A0 =C2=A0 case MCE_START:
> + =C2=A0 =C2=A0 =C2=A0 default:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> + =C2=A0 =C2=A0 =C2=A0 }
> +}
> +
> +static void mce_query_cb(const GIsiMessage *msg, void *data)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct ofono_modem *modem =3D data;
> + =C2=A0 =C2=A0 =C2=A0 struct isi_data *isi =3D ofono_modem_get_data(mode=
m);
> + =C2=A0 =C2=A0 =C2=A0 uint8_t current;
> + =C2=A0 =C2=A0 =C2=A0 uint8_t target;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (!check_response_status(msg, MCE_MODEM_STATE_QU=
ERY_RESP))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (!g_isi_msg_data_get_byte(msg, 0, &current) ||
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 !g_isi_msg_data_get_byte(msg, 1, &target))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> +
> + =C2=A0 =C2=A0 =C2=A0 DBG("Modem state: current=3D%s (0x%02X) target=3D%=
s (0x%02X)",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mce_modem_state_name(c=
urrent), current,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mce_modem_state_name(t=
arget), target);
> +
> + =C2=A0 =C2=A0 =C2=A0 if (current =3D=3D target)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set_power_by_mce_state=
(modem, isi, current);
> +}
> +
> +static gboolean bootstrap_current_state(gpointer user)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct ofono_modem *om =3D user;
> + =C2=A0 =C2=A0 =C2=A0 struct isi_data *isi =3D ofono_modem_get_data(om);
> +
> + =C2=A0 =C2=A0 =C2=A0 const uint8_t req[] =3D {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MCE_MODEM_STATE_QUERY_=
REQ,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00, 0x00 /* Filler */
> + =C2=A0 =C2=A0 =C2=A0 };
> + =C2=A0 =C2=A0 =C2=A0 size_t len =3D sizeof(req);
> +
> + =C2=A0 =C2=A0 =C2=A0 g_isi_client_send(isi->client, req, len, mce_query=
_cb, om, NULL);
> +
> + =C2=A0 =C2=A0 =C2=A0 return FALSE;
> +}
> +
> +static void reachable_cb(const GIsiMessage *msg, void *data)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct ofono_modem *om =3D data;
> + =C2=A0 =C2=A0 =C2=A0 struct isi_data *isi =3D ofono_modem_get_data(om);
> +
> + =C2=A0 =C2=A0 =C2=A0 if (!g_isi_msg_error(msg) < 0)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> +
> + =C2=A0 =C2=A0 =C2=A0 ISI_VERSION_DBG(msg);
> +
> + =C2=A0 =C2=A0 =C2=A0 g_isi_client_ind_subscribe(isi->client, MCE_MODEM_=
STATE_IND,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mce_state_in=
d_cb, om);
> +
> + =C2=A0 =C2=A0 =C2=A0 g_isi_client_ind_subscribe(isi->client, MCE_RF_STA=
TE_IND,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mce_rf_state=
_ind_cb, om);
> +
> + =C2=A0 =C2=A0 =C2=A0 /*
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* FIXME: There is a theoretical race conditi=
on here:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* g_isi_client_ind_subscribe() adds the actu=
al message
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* sending for committing changes to subscrip=
tions in idle
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* loop, which may or may not preserve orderi=
ng. =C2=A0Thus, we
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* might miss a state indication if the boots=
trap request ends
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* up being sent first.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> + =C2=A0 =C2=A0 =C2=A0 g_idle_add(bootstrap_current_state, om);
> +}
> +
> +static void phonet_status_cb(GIsiModem *modem, enum GIsiPhonetLinkState =
st,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char const *ifname, void *data)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct ofono_modem *om =3D data;
> + =C2=A0 =C2=A0 =C2=A0 struct isi_data *isi =3D ofono_modem_get_data(om);
> +
> + =C2=A0 =C2=A0 =C2=A0 DBG("Link %s (%u) is %s", isi->ifname, g_isi_modem=
_index(isi->modem),
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 st =3D=3D PN_LINK_REMO=
VED ? "removed" :
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 st =3D=3D PN_LINK_DOWN=
 ? "down" : "up");
> +
> + =C2=A0 =C2=A0 =C2=A0 isi->linkstate =3D st;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (st =3D=3D PN_LINK_UP)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_isi_client_verify(is=
i->client, reachable_cb, om, NULL);
> + =C2=A0 =C2=A0 =C2=A0 else if (st =3D=3D PN_LINK_DOWN)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set_power_by_mce_state=
(om, isi, MCE_POWER_OFF);
> +}
> +
> +static int u8500_probe(struct ofono_modem *modem)
> +{
> + =C2=A0 =C2=A0 =C2=A0 const char *ifname =3D ofono_modem_get_string(mode=
m, "Interface");
> + =C2=A0 =C2=A0 =C2=A0 unsigned address =3D ofono_modem_get_integer(modem=
, "Address");
> + =C2=A0 =C2=A0 =C2=A0 GIsiModem *isimodem;
> + =C2=A0 =C2=A0 =C2=A0 GIsiClient *client =3D NULL;
> + =C2=A0 =C2=A0 =C2=A0 GIsiPhonetNetlink *link =3D NULL;
> + =C2=A0 =C2=A0 =C2=A0 struct isi_data *isi =3D NULL;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (ifname =3D=3D NULL)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;
> +
> + =C2=A0 =C2=A0 =C2=A0 DBG("(%p) with %s", modem, ifname);
> +
> + =C2=A0 =C2=A0 =C2=A0 isimodem =3D g_isi_modem_create_by_name(ifname);
> + =C2=A0 =C2=A0 =C2=A0 if (isimodem =3D=3D NULL) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DBG("Interface=3D%s: %=
s", ifname, strerror(errno));
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -errno;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 g_isi_modem_set_userdata(isimodem, modem);
> +
> + =C2=A0 =C2=A0 =C2=A0 if (getenv("OFONO_ISI_DEBUG"))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_isi_modem_set_debug(=
isimodem, ofono_debug);
> +
> + =C2=A0 =C2=A0 =C2=A0 if (getenv("OFONO_ISI_TRACE"))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_isi_modem_set_trace(=
isimodem, isi_trace);
> +
> + =C2=A0 =C2=A0 =C2=A0 if (g_isi_pn_netlink_by_modem(isimodem)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DBG("%s: %s", ifname, =
strerror(EBUSY));
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 errno =3D EBUSY;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 link =3D g_isi_pn_netlink_start(isimodem, phonet_s=
tatus_cb, modem);
> + =C2=A0 =C2=A0 =C2=A0 if (link =3D=3D NULL) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DBG("%s: %s", ifname, =
strerror(errno));
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 if (address) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int error =3D g_isi_pn=
_netlink_set_address(isimodem, address);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (error && error !=
=3D -EEXIST) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 DBG("g_isi_pn_netlink_set_address(): %s\n",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strerror(-error));
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 errno =3D -error;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 goto error;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 isi =3D g_try_new0(struct isi_data, 1);
> + =C2=A0 =C2=A0 =C2=A0 if (isi =3D=3D NULL) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 errno =3D ENOMEM;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 client =3D g_isi_client_create(isimodem, PN_MODEM_=
MCE);
> + =C2=A0 =C2=A0 =C2=A0 if (!client)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;
> +
> + =C2=A0 =C2=A0 =C2=A0 g_isi_modem_set_device(isimodem, PN_DEV_MODEM);
> +
> + =C2=A0 =C2=A0 =C2=A0 isi->modem =3D isimodem;
> + =C2=A0 =C2=A0 =C2=A0 isi->ifname =3D ifname;
> + =C2=A0 =C2=A0 =C2=A0 isi->link =3D link;
> + =C2=A0 =C2=A0 =C2=A0 isi->reported =3D -1;
> + =C2=A0 =C2=A0 =C2=A0 isi->client =3D client;
> +
> + =C2=A0 =C2=A0 =C2=A0 ofono_modem_set_data(modem, isi);
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +
> +error:
> + =C2=A0 =C2=A0 =C2=A0 g_isi_pn_netlink_stop(link);
> + =C2=A0 =C2=A0 =C2=A0 g_isi_client_destroy(client);
> + =C2=A0 =C2=A0 =C2=A0 g_isi_modem_destroy(isimodem);
> + =C2=A0 =C2=A0 =C2=A0 g_free(isi);
> +
> + =C2=A0 =C2=A0 =C2=A0 return -errno;
> +}
> +
> +static void u8500_remove(struct ofono_modem *modem)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct isi_data *isi =3D ofono_modem_get_data(mode=
m);
> +
> + =C2=A0 =C2=A0 =C2=A0 ofono_modem_set_data(modem, NULL);
> +
> + =C2=A0 =C2=A0 =C2=A0 if (isi =3D=3D NULL)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> +
> + =C2=A0 =C2=A0 =C2=A0 g_isi_pn_netlink_stop(isi->link);
> + =C2=A0 =C2=A0 =C2=A0 g_isi_client_destroy(isi->client);
> + =C2=A0 =C2=A0 =C2=A0 g_isi_modem_destroy(isi->modem);
> + =C2=A0 =C2=A0 =C2=A0 g_free(isi);
> +}
> +
> +static void mce_state_cb(const GIsiMessage *msg, void *data)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct isi_cb_data *cbd =3D data;
> + =C2=A0 =C2=A0 =C2=A0 struct ofono_modem *modem =3D cbd->user;
> + =C2=A0 =C2=A0 =C2=A0 ofono_modem_online_cb_t cb =3D cbd->cb;
> +
> + =C2=A0 =C2=A0 =C2=A0 struct isi_data *isi =3D ofono_modem_get_data(mode=
m);
> + =C2=A0 =C2=A0 =C2=A0 uint8_t cause;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (!check_response_status(msg, MCE_RF_STATE_RESP))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (!g_isi_msg_data_get_byte(msg, 0, &cause))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;
> +
> + =C2=A0 =C2=A0 =C2=A0 DBG("MCE cause: %s (0x%02X)", mce_status_info(caus=
e), cause);
> +
> + =C2=A0 =C2=A0 =C2=A0 if (cause =3D=3D MCE_OK) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 isi->online_cbd =3D cb=
d;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 if (cause =3D=3D MCE_ALREADY_ACTIVE) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CALLBACK_WITH_SUCCESS(=
cb, cbd->data);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(cbd);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> +error:
> + =C2=A0 =C2=A0 =C2=A0 CALLBACK_WITH_FAILURE(cb, cbd->data);
> + =C2=A0 =C2=A0 =C2=A0 g_free(cbd);
> +}
> +
> +static void u8500_online(struct ofono_modem *modem, ofono_bool_t online,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ofono_modem_online_cb_t cb, void *data)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct isi_data *isi =3D ofono_modem_get_data(mode=
m);
> + =C2=A0 =C2=A0 =C2=A0 struct isi_cb_data *cbd =3D isi_cb_data_new(modem,=
 cb, data);
> + =C2=A0 =C2=A0 =C2=A0 const uint8_t req[] =3D {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MCE_RF_STATE_REQ,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 online ? MCE_RF_ON : M=
CE_RF_OFF,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00
> + =C2=A0 =C2=A0 =C2=A0 };
> +
> + =C2=A0 =C2=A0 =C2=A0 DBG("(%p) with %s", modem, isi->ifname);
> +
> + =C2=A0 =C2=A0 =C2=A0 if (cbd =3D=3D NULL || isi =3D=3D NULL)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (g_isi_client_send_with_timeout(isi->client, re=
q, sizeof(req),
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MTC_STATE_REQ_TIMEOUT,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mce_state_cb, cbd, NULL)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 isi->online =3D online;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> +error:
> + =C2=A0 =C2=A0 =C2=A0 CALLBACK_WITH_FAILURE(cb, data);
> + =C2=A0 =C2=A0 =C2=A0 g_free(cbd);
> +}
> +
> +static void u8500_pre_sim(struct ofono_modem *modem)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct isi_data *isi =3D ofono_modem_get_data(mode=
m);
> +
> + =C2=A0 =C2=A0 =C2=A0 DBG("(%p) with %s", modem, isi->ifname);
> +
> + =C2=A0 =C2=A0 =C2=A0 ofono_sim_create(modem, 0, "isimodem", isi->modem);
> + =C2=A0 =C2=A0 =C2=A0 ofono_devinfo_create(modem, 0, "u8500", isi->modem=
);
> + =C2=A0 =C2=A0 =C2=A0 ofono_voicecall_create(modem, 0, "isimodem", isi->=
modem);
> +}
> +
> +static void u8500_post_sim(struct ofono_modem *modem)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct isi_data *isi =3D ofono_modem_get_data(mode=
m);
> +
> + =C2=A0 =C2=A0 =C2=A0 DBG("(%p) with %s", modem, isi->ifname);
> +
> + =C2=A0 =C2=A0 =C2=A0 ofono_phonebook_create(modem, 0, "isimodem", isi->=
modem);
> + =C2=A0 =C2=A0 =C2=A0 ofono_call_forwarding_create(modem, 0, "isimodem",=
 isi->modem);
> + =C2=A0 =C2=A0 =C2=A0 ofono_radio_settings_create(modem, 0, "isimodem", =
isi->modem);
> +}
> +
> +static void u8500_post_online(struct ofono_modem *modem)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct isi_data *isi =3D ofono_modem_get_data(mode=
m);
> +
> + =C2=A0 =C2=A0 =C2=A0 DBG("(%p) with %s", modem, isi->ifname);
> +
> + =C2=A0 =C2=A0 =C2=A0 ofono_netreg_create(modem, 0, "wgmodem2.5", isi->m=
odem);
> + =C2=A0 =C2=A0 =C2=A0 ofono_sms_create(modem, 0, "isimodem", isi->modem);
> + =C2=A0 =C2=A0 =C2=A0 ofono_cbs_create(modem, 0, "isimodem", isi->modem);
> + =C2=A0 =C2=A0 =C2=A0 ofono_ssn_create(modem, 0, "isimodem", isi->modem);
> + =C2=A0 =C2=A0 =C2=A0 ofono_ussd_create(modem, 0, "isimodem", isi->modem=
);
> + =C2=A0 =C2=A0 =C2=A0 ofono_call_settings_create(modem, 0, "isimodem", i=
si->modem);
> + =C2=A0 =C2=A0 =C2=A0 ofono_call_barring_create(modem, 0, "isimodem", is=
i->modem);
> + =C2=A0 =C2=A0 =C2=A0 ofono_call_meter_create(modem, 0, "isimodem", isi-=
>modem);
> + =C2=A0 =C2=A0 =C2=A0 ofono_gprs_create(modem, 0, "isimodem", isi->modem=
);
> +}
> +
> +static int u8500_enable(struct ofono_modem *modem)
> +{
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +}
> +
> +static int u8500_disable(struct ofono_modem *modem)
> +{
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +}
> +
> +static void u8500_info_resp_cb(const GIsiMessage *msg, void *data)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct isi_cb_data *cbd =3D data;
> + =C2=A0 =C2=A0 =C2=A0 ofono_devinfo_query_cb_t cb =3D cbd->cb;
> + =C2=A0 =C2=A0 =C2=A0 GIsiSubBlockIter iter;
> + =C2=A0 =C2=A0 =C2=A0 uint8_t msgid;
> + =C2=A0 =C2=A0 =C2=A0 uint8_t status;
> +
> + =C2=A0 =C2=A0 =C2=A0 msgid =3D g_isi_msg_id(msg);
> + =C2=A0 =C2=A0 =C2=A0 if (msgid !=3D INFO_SERIAL_NUMBER_READ_RESP)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (g_isi_msg_error(msg) < 0)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (!g_isi_msg_data_get_byte(msg, 0, &status))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (status !=3D INFO_OK)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;
> +
> + =C2=A0 =C2=A0 =C2=A0 for (g_isi_sb_iter_init(&iter, msg, 2);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 g_isi_sb_iter_is_valid(&iter);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 g_isi_sb_iter_next(&iter)) {
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t id =3D g_isi_s=
b_iter_get_id(&iter);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t chars;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char *info =3D NULL;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (id !=3D INFO_SB_PR=
ODUCT_INFO_MANUFACTURER &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 id !=3D INFO_SB_PRODUCT_INFO_NAME &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 id !=3D INFO_SB_MCUSW_VERSION &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 id !=3D INFO_SB_SN_IMEI_PLAIN &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 id !=3D INFO_SB_MODEMSW_VERSION)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 continue;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (g_isi_sb_iter_get_=
len(&iter) < 5)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 goto error;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!g_isi_sb_iter_get=
_byte(&iter, &chars, 3))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 goto error;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!g_isi_sb_iter_get=
_latin_tag(&iter, &info, chars, 4))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 goto error;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CALLBACK_WITH_SUCCESS(=
cb, info, cbd->data);
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(info);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> +error:
> + =C2=A0 =C2=A0 =C2=A0 CALLBACK_WITH_FAILURE(cb, "", cbd->data);
> +}
> +
> +static void u8500_devinfo_reachable_cb(const GIsiMessage *msg, void *dat=
a)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct ofono_devinfo *info =3D data;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (g_isi_msg_error(msg) < 0)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> +
> + =C2=A0 =C2=A0 =C2=A0 ISI_VERSION_DBG(msg);
> +
> + =C2=A0 =C2=A0 =C2=A0 ofono_devinfo_register(info);
> +}
> +
> +static void u8500_query_manufacturer(struct ofono_devinfo *info,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ofono_devinf=
o_query_cb_t cb,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void *data)
> +{
> + =C2=A0 =C2=A0 =C2=A0 CALLBACK_WITH_FAILURE(cb, "", data);
> +}
> +
> +static void u8500_query_model(struct ofono_devinfo *info,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ofono_devinfo_query_cb_t cb,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void *data)
> +{
> + =C2=A0 =C2=A0 =C2=A0 CALLBACK_WITH_FAILURE(cb, "", data);
> +}
> +
> +static void u8500_query_revision(struct ofono_devinfo *info,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ofono_devinfo_query_cb_t cb,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void *data)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct devinfo_data *dev =3D ofono_devinfo_get_dat=
a(info);
> + =C2=A0 =C2=A0 =C2=A0 struct isi_cb_data *cbd =3D isi_cb_data_new(dev, c=
b, data);
> + =C2=A0 =C2=A0 =C2=A0 const unsigned char msg[] =3D {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 INFO_SERIAL_NUMBER_REA=
D_REQ,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00, 0x00,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00, 0x00, 0x00, 0x01=
, /* M_INFO_MODEMSW */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00, 0x00
> + =C2=A0 =C2=A0 =C2=A0 };
> + =C2=A0 =C2=A0 =C2=A0 DBG("");
> +
> + =C2=A0 =C2=A0 =C2=A0 if (cbd =3D=3D NULL || dev =3D=3D NULL)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (g_isi_client_send(dev->client, msg, sizeof(msg=
),
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u8500_info_resp_cb, cbd, g_free))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> +
> +
> +error:
> + =C2=A0 =C2=A0 =C2=A0 CALLBACK_WITH_FAILURE(cb, "", data);
> + =C2=A0 =C2=A0 =C2=A0 g_free(cbd);
> +}
> +
> +static void u8500_query_serial(struct ofono_devinfo *info,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ofono_devinfo_query_cb_t cb,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void *data)
> +{
> + =C2=A0 =C2=A0 =C2=A0 char imei[16]; /* IMEI 15 digits + 1 null*/
> + =C2=A0 =C2=A0 =C2=A0 char numbers[] =3D "1234567890";
> + =C2=A0 =C2=A0 =C2=A0 FILE *fp =3D fopen("/etc/imei", "r");
> + =C2=A0 =C2=A0 =C2=A0 DBG("");
> +
> + =C2=A0 =C2=A0 =C2=A0 if (fp =3D=3D NULL) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DBG("failed to open /e=
tc/imei file");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 if (fgets(imei, 16, fp)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DBG(" IMEI =3D %s", im=
ei);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (15 =3D=3D strspn(i=
mei, numbers))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 CALLBACK_WITH_SUCCESS(cb, imei, data);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 CALLBACK_WITH_FAILURE(cb, "", data);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 fclose(fp);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 goto error;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 fclose(fp);
> + =C2=A0 =C2=A0 =C2=A0 return;
> +
> +error:
> + =C2=A0 =C2=A0 =C2=A0 CALLBACK_WITH_FAILURE(cb, "", data);
> +}
> +
> +static int u8500_devinfo_probe(struct ofono_devinfo *info, unsigned int =
vendor,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void *user)
> +{
> + =C2=A0 =C2=A0 =C2=A0 GIsiModem *idx =3D user;
> + =C2=A0 =C2=A0 =C2=A0 struct devinfo_data *data =3D g_try_new0(struct de=
vinfo_data, 1);
> +
> + =C2=A0 =C2=A0 =C2=A0 if (data =3D=3D NULL)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOMEM;
> +
> + =C2=A0 =C2=A0 =C2=A0 data->client =3D g_isi_client_create(idx, PN_MODEM=
_INFO);
> + =C2=A0 =C2=A0 =C2=A0 if (data->client =3D=3D NULL)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto nomem;
> +
> + =C2=A0 =C2=A0 =C2=A0 ofono_devinfo_set_data(info, data);
> +
> + =C2=A0 =C2=A0 =C2=A0 g_isi_client_set_timeout(data->client, INFO_TIMEOU=
T);
> + =C2=A0 =C2=A0 =C2=A0 g_isi_client_verify(data->client, u8500_devinfo_re=
achable_cb,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 info, NULL);
> +
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +
> +nomem:
> + =C2=A0 =C2=A0 =C2=A0 g_isi_client_destroy(data->client);
> +
> + =C2=A0 =C2=A0 =C2=A0 g_free(data);
> + =C2=A0 =C2=A0 =C2=A0 return -ENOMEM;
> +
> +}
> +
> +static void u8500_devinfo_remove(struct ofono_devinfo *info)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct devinfo_data *data =3D ofono_devinfo_get_da=
ta(info);
> +
> + =C2=A0 =C2=A0 =C2=A0 ofono_devinfo_set_data(info, NULL);
> +
> + =C2=A0 =C2=A0 =C2=A0 if (data =3D=3D NULL)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> +
> + =C2=A0 =C2=A0 =C2=A0 g_isi_client_destroy(data->client);
> + =C2=A0 =C2=A0 =C2=A0 g_free(data);
> +}
> +
> +static struct ofono_modem_driver driver =3D {
> + =C2=A0 =C2=A0 =C2=A0 .name =3D "u8500",
> + =C2=A0 =C2=A0 =C2=A0 .probe =3D u8500_probe,
> + =C2=A0 =C2=A0 =C2=A0 .remove =3D u8500_remove,
> + =C2=A0 =C2=A0 =C2=A0 .set_online =3D u8500_online,
> + =C2=A0 =C2=A0 =C2=A0 .pre_sim =3D u8500_pre_sim,
> + =C2=A0 =C2=A0 =C2=A0 .post_sim =3D u8500_post_sim,
> + =C2=A0 =C2=A0 =C2=A0 .post_online =3D u8500_post_online,
> + =C2=A0 =C2=A0 =C2=A0 .enable =3D u8500_enable,
> + =C2=A0 =C2=A0 =C2=A0 .disable =3D u8500_disable,
> +};
> +
> +static struct ofono_devinfo_driver devinfo_driver =3D {
> + =C2=A0 =C2=A0 =C2=A0 .name =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =3D "u8500",
> + =C2=A0 =C2=A0 =C2=A0 .probe =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0=3D u8500_devinfo_probe,
> + =C2=A0 =C2=A0 =C2=A0 .remove =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =3D u8500_devinfo_remove,
> + =C2=A0 =C2=A0 =C2=A0 .query_manufacturer =C2=A0 =C2=A0 =3D u8500_query_=
manufacturer,
> + =C2=A0 =C2=A0 =C2=A0 .query_model =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0=3D u8500_query_model,
> + =C2=A0 =C2=A0 =C2=A0 .query_revision =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D u8=
500_query_revision,
> + =C2=A0 =C2=A0 =C2=A0 .query_serial =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=3D u8500_query_serial
> +};
> +
> +static int u8500_init(void)
> +{
> + =C2=A0 =C2=A0 =C2=A0 int err;
> +
> + =C2=A0 =C2=A0 =C2=A0 err =3D ofono_modem_driver_register(&driver);
> +
> + =C2=A0 =C2=A0 =C2=A0 if (err < 0)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return err;
> +
> + =C2=A0 =C2=A0 =C2=A0 ofono_devinfo_driver_register(&devinfo_driver);
> +
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +}
> +
> +static void u8500_exit(void)
> +{
> + =C2=A0 =C2=A0 =C2=A0 ofono_devinfo_driver_unregister(&devinfo_driver);
> +
> + =C2=A0 =C2=A0 =C2=A0 ofono_modem_driver_unregister(&driver);
> +}
> +
> +OFONO_PLUGIN_DEFINE(u8500, "Generic modem driver for isi",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 VERSION, OFONO_PLUGIN_PRIORITY_DEFAULT,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 u8500_init, u8500_exit)
> --
> 1.7.3.5
>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono
>

--===============2686338150488140220==--

