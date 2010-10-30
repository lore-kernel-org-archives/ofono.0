Content-Type: multipart/mixed; boundary="===============7227214147500625979=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Infineon modem API to support aGPS
Date: Sat, 30 Oct 2010 12:58:33 +0200
Message-ID: <1288436313.3322.69.camel@aeonflux>
In-Reply-To: <CB28AA307186A940B1253A743EA1F20AA58B8B16@orsmsx507.amr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7227214147500625979==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Robertino,

> This is the first attempt to add aGPS support for Infineon modem. Patch
> contains modem API per Waldo's RFC and suggestions.
> =

> DBUS API in ofono core are just place holders (not implemented), in this =
patch.

please send patches as patches and introduction email as a separate one.
You can use git format-patch and git send-email for that since they do a
proper job.

> From fab1feadc9c9cf384aa42404bfba307c86f598db Mon Sep 17 00:00:00 2001
> From: Robertino Benis <robertino.benis@intel.com>
> Date: Fri, 29 Oct 2010 20:10:06 -0700
> Subject: [CHANGE] Added aGPS Modem API implementation for Infineon modem

RFC patches should be marged as [RFC].

And in addition make sure they have a proper prefix:. For example
ifxmodem: etc. Check the git log for examples.

> ---
>  Makefile.am                 |    7 +-
>  drivers/ifxmodem/agps.c     |  418 +++++++++++++++++++++++++++++++++++++=
++++++
>  drivers/ifxmodem/ifxmodem.c |    2 +
>  drivers/ifxmodem/ifxmodem.h |    3 +
>  include/agps.h              |  159 ++++++++++++++++
>  include/dbus.h              |    1 +
>  plugins/ifx.c               |   12 +-
>  src/agps.c                  |  229 +++++++++++++++++++++++
>  src/ofono.h                 |    2 +
>  9 files changed, 827 insertions(+), 6 deletions(-)
>  create mode 100644 drivers/ifxmodem/agps.c
>  create mode 100644 include/agps.h
>  create mode 100644 src/agps.c

This needs to be split into proper set of patches. Please don't just
dump big patches touching everything on the mailing list. These are
impossible to review.

First patch of the series should a patch adding this task to the TODO
list. Since it is clearly not yet finished.

Then a patch that adds the documentation. Never forgot to document you
interfaces. I do wanna see this all at once and don't have to go through
the archives to find some other email about that. Until things have
applied it is your job to keep them together.

Then the patch for adding the atom support needs to be separate from the
IFX specific atom implementation and from the IFX modem plugin enabling
support for it.

Use proper Subject fields to identify these patches.

> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
> +#define _GNU_SOURCE
> +#include <string.h>
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <errno.h>
> +
> +#include <glib.h>
> +#include <gisi/client.h>

I want includes that belong here and just random includes. If an include
is not needed, then it does not belong here.

I really have no idea how the gisi/client.h include ended up here, but
that is pretty much wrong.

> +#include <ofono/log.h>
> +#include <ofono/modem.h>
> +#include <ofono/agps.h>
> +
> +#include "util.h"
> +#include "ifxmodem.h"
> +
> +struct agps_data {
> +       GAtChat *chat;
> +       unsigned int vendor;
> +       enum ofono_access_technology rad_acc_tech;
> +};

What is this. And where is ofono_access_technology coming from. You
define another set RAT.

I see it never set and also this seems like something that is IFX
specific and should not be public. It is a modem driver detail.

And since this is IFX specific, you don't need this vendor handling.
There will no re-use except for IFX and we already know that we are an
IFX specific modem driver.

> +struct ofono_agps;

What is this declaration doing here? If that is needed, then something
is done wrongly.

> +static const char *none_prefix[] =3D { NULL };
> +
> +#define FRAME_LEN 128
> +
> +static void pos_request_notify(GAtResult *result, gpointer user_data)
> +{
> +       struct ofono_agps *agps =3D user_data;
> +       int framelen;
> +       int frametype;
> +       GAtResultIter iter;
> +       struct ofono_lcs_frame lcsframe;
> +       const char *messageframe;
> +       unsigned char frame[FRAME_LEN]; /* TODO - Length TBD */
> +       long hexframelen;
> +
> +       /* Assuming Pos Req format: %XPOSR: <frametype>,<framelen>,<frame=
> */
> +
> +       g_at_result_iter_init(&iter, result);
> +
> +       if (!g_at_result_iter_next(&iter, "%%XPOSR:"))
> +               return;
> +
> +       if (!g_at_result_iter_next_number(&iter, &frametype))
> +               return;
> +
> +       if (!g_at_result_iter_next_number(&iter, &framelen))
> +               return;
> +
> +       if (framelen > FRAME_LEN) {
> +               ofono_error("Got POS request message more than maximum bu=
ffer size!");
> +               return;
> +       }
> +
> +       messageframe =3D g_at_result_pdu(result);
> +
> +       if (strlen(messageframe) > sizeof(frame) * 2) { /* Hex, 2 chars /=
 byte */
> +               ofono_error("Message frame too long!");
> +                return;
> +       }

Make sure whitespace and tabs are proper in order.

> +       if (decode_hex_own_buf(messageframe, -1, &hexframelen, 0,
> +                               frame) =3D=3D NULL) {
> +               ofono_error("Unable to hex-decode the AGPS frame");
> +               return;
> +       }
> +
> +       DBG("Got POS request data: %s, %ld", frame, hexframelen);
> +
> +       if (hexframelen !=3D framelen) {
> +               ofono_error("hexframelen not equal to reported framelen");
> +               return;
> +       }
> +
> +       lcsframe.lcs_frame_type =3D frametype;
> +       lcsframe.frame_length =3D framelen;
> +       lcsframe.raw_frame =3D (unsigned char *)frame;
> +
> +       ofono_agps_lcs_frame_notify(agps, lcsframe);
> +}
> +
> +static int ifx_agps_probe(struct ofono_agps *agps,
> +                                       unsigned int vendor, void *data)
> +{
> +       GAtChat *chat =3D data;
> +       struct agps_data *agd =3D ofono_agps_get_data(agps);
> +
> +       agd =3D g_try_new0(struct agps_data, 1);
> +       if (!agd)
> +               return -ENOMEM;
> +
> +       agd->chat =3D g_at_chat_clone(chat);
> +       agd->vendor =3D vendor;
> +
> +       ofono_agps_set_data(agps, agd);
> +
> +       g_at_chat_register(agd->chat, "%%XPOSR:", pos_request_notify, TRU=
E,
> +                               agps, NULL);
> +
> +       ofono_agps_register(agps);
> +
> +       return 0;
> +}

Do we have a command for testing that aGPS support is present. If so,
then that command should be issued here as =3D?. And only when it returns
you should setup the watches and register the atom.

And remove the vendor stuff. As I said, it is IFX specific already.

> +static void ifx_agps_remove(struct ofono_agps *agps)
> +{
> +       struct agps_data *agd =3D ofono_agps_get_data(agps);
> +
> +       ofono_agps_set_data(agps, NULL);
> +       g_at_chat_unref(agd->chat);
> +       g_free(agd);
> +}
> +
> +
> +static void ifx_agps_receive_lcs_frame_cb(gboolean ok, GAtResult *result,
> +                               gpointer user_data)
> +{
> +       struct cb_data *cbd =3D user_data;
> +       ofono_agps_receive_lcs_frame_cb_t cb =3D cbd->cb;
> +       struct ofono_error error;
> +
> +       decode_at_error(&error, g_at_result_final_response(result));
> +       cb(&error, cbd->data);
> +}
> +
> +   /*
> +       * The GPS manager can enable or disable AGPS manager  to receive
> +       * lcs_frames from the Mobile network. If disabled, all Assistance=
 Data
> +       * and Position Requests from Mobile Network are not signalled to =
ofono.
> +       */
> +static void ifx_agps_receive_lcs_frames(struct ofono_agps *agps,
> +                       int enabled, ofono_agps_receive_lcs_frame_cb_t cb,
> +                       void *user_data)
> +{
> +       struct agps_data *data =3D ofono_agps_get_data(agps);
> +       struct cb_data *cbd =3D cb_data_new(cb, user_data);
> +       char *commbuf;
> +       unsigned int id;
> +
> +       if (!cbd)
> +               goto error;
> +
> +       commbuf =3D g_strdup_printf("AT%%XPOS=3D\"%d\"", enabled);
> +
> +       id =3D g_at_chat_send(data->chat, commbuf, none_prefix,
> +                               ifx_agps_receive_lcs_frame_cb, cbd, g_fre=
e);
> +
> +       g_free(commbuf);
> +
> +       if (id > 0)
> +               return;
> +error:
> +       if (cbd)
> +               g_free(cbd);
> +
> +       CALLBACK_WITH_FAILURE(cb, user_data);
> +}
> +
> +static void ifx_agps_send_lcs_frame_cb(gboolean ok, GAtResult *result,
> +                               gpointer user_data)
> +{
> +       struct cb_data *cbd =3D user_data;
> +       ofono_agps_send_lcs_frame_cb_t cb =3D cbd->cb;
> +       struct ofono_error error;
> +
> +       decode_at_error(&error, g_at_result_final_response(result));
> +       cb(&error, cbd->data);
> +}
> +
> +#define BUF_LEN 128
> +       /* Assistance Data and Position Requests from the Mobile Network =
are
> +        * signalled via the ofono_agps_lcs_frame_notify function and the
> +        * oFono core to an external GPS manager. This GPS manager can re=
ply
> +        * to Position Requests with one or more Position Responses which
> +        * are then send back to the modem via the send_lcs_frame functio=
n.
> +        */
> +static void ifx_agps_send_lcs_frame(struct ofono_agps *agps,
> +                               struct ofono_lcs_frame *frame,
> +                               ofono_agps_send_lcs_frame_cb_t cb,
> +                               void *user_data)
> +{
> +       struct agps_data *data =3D ofono_agps_get_data(agps);
> +       struct cb_data *cbd =3D cb_data_new(cb, user_data);
> +       char buf[BUF_LEN * 2 + 1];
> +       char *commbuf;
> +       unsigned int id;
> +       int buflen;
> +
> +       if (!cbd)
> +               goto error;
> +
> +       if (!frame->frame_length) {
> +               ofono_error("ifx_agps_send_lcs_frame: Frame length Invali=
d");
> +               goto error;
> +       }
> +
> +       if (frame->frame_length > BUF_LEN) {
> +               ofono_error("ifx_agps_send_lcs_frame: Frame length too lo=
ng!");
> +               goto error;
> +       }
> +
> +       encode_hex_own_buf(frame->raw_frame, frame->frame_length, 0, buf);
> +       buflen =3D strlen(buf);
> +       DBG("Encoded AGPS Frame =3D %s %d", buf, buflen);
> +
> +       commbuf =3D g_strdup_printf("AT%%XPOSR=3D%d,%d,\"%s\"",
> +                       frame->lcs_frame_type, buflen, buf);
> +
> +       id =3D g_at_chat_send(data->chat, commbuf, none_prefix,
> +                               ifx_agps_send_lcs_frame_cb, cbd, g_free);
> +
> +       g_free(commbuf);
> +
> +       if (id > 0)
> +               return;
> +error:
> +       if (cbd)
> +               g_free(cbd);
> +
> +       CALLBACK_WITH_FAILURE(cb, user_data);
> +}
> +
> +static void ifx_agps_inject_time_cb(gboolean ok, GAtResult *result,
> +                               gpointer user_data)
> +{
> +       GAtResultIter iter;
> +       struct ofono_error error;
> +       struct ofono_lcs_radio_fn rf;
> +       struct cb_data *cbd =3D user_data;
> +       struct agps_data *data =3D cbd->user;
> +       ofono_agps_inject_time_cb_t cb =3D cbd->cb;
> +
> +       decode_at_error(&error, g_at_result_final_response(result));
> +
> +       if (!ok) {
> +               cb(&error, NULL, cbd->data);
> +               return;
> +       }
> +
> +       if (!g_at_result_iter_next(&iter, "%%XFTI:"))
> +               goto err;
> +
> +       if (RADIO_ACCESS_TECHNOLOGY_GSM =3D=3D data->rad_acc_tech) {
> +
> +               int fn;         /* range 0 - 2715647 (2048*26*51) */
> +               int ts;         /* range 0 - 7 */
> +               int tsb;        /* range 0 - 156 */
> +               int ta;         /* range 0 - 63 */
> +               int ba;         /* range 0 - 1023 */
> +               int bc;         /* range 0 - 64 */
> +
> +       /*       %XFTI:<frameNum>,<TimeSlot>,<TimeSlotBit>,<TimeAdv>,
> +       *       <ChannelNum>,<ChannelId>
> +       */

Please get the coding style in place properly. This thing is so hard to
read if you use different indentations and comment styles.

> +               if (!g_at_result_iter_next_number(&iter, &fn))
> +                       goto err;
> +
> +               if (!g_at_result_iter_next_number(&iter, &ts))
> +                       goto err;
> +
> +               if (!g_at_result_iter_next_number(&iter, &tsb))
> +                       goto err;
> +
> +               if (!g_at_result_iter_next_number(&iter, &ta))
> +                       goto err;
> +
> +               if (!g_at_result_iter_next_number(&iter, &ba))
> +                       goto err;
> +
> +               if (!g_at_result_iter_next_number(&iter, &bc))
> +                       goto err;
> +
> +               DBG("GSM Inject Response: fn =3D %d ts =3D %d tsb =3D %d =
ta =3D %d"
> +                               "ba =3D %d bc =3D %d ", fn, ts, tsb, ta, =
ba, bc);
> +
> +               rf.gsm_frame_number.TDMA_frame_number =3D fn;
> +               rf.gsm_frame_number.TDMA_timeslot =3D ts;
> +               rf.gsm_frame_number.timeslot_bit =3D tsb;
> +               rf.gsm_frame_number.timing_advance =3D ta;
> +               rf.gsm_frame_number.bcch_arfcn =3D ba;
> +               rf.gsm_frame_number.bsic =3D bc;
> +               rf.radio_access_technology =3D RADIO_ACCESS_TECHNOLOGY_GS=
M;
> +
> +       } else if (RADIO_ACCESS_TECHNOLOGY_UMTS =3D=3D data->rad_acc_tech=
) {
> +
> +               int sfn;        /* range 0 - 4095 */
> +               int rs;         /* enum ofono_rrc_state */
> +               int rt;         /* range 0 - 32766 */
> +
> +               /* %XFTI:<frameNum>,<RadioState>,<TripTime> */
> +               if (!g_at_result_iter_next_number(&iter, &sfn))
> +                       goto err;
> +
> +               if (!g_at_result_iter_next_number(&iter, &rs))
> +                       goto err;
> +
> +               if (!g_at_result_iter_next_number(&iter, &rt))
> +                       goto err;
> +
> +               DBG("UMTS Inject Response: sfn =3D %d rs =3D %d tt =3D %d=
",
> +                               sfn, rs, rt);
> +
> +               rf.utran_frame_number.sfn =3D sfn;
> +               rf.utran_frame_number.rrc_state =3D rs;
> +               rf.utran_frame_number.round_trip_time =3D rt;
> +               rf.radio_access_technology =3D RADIO_ACCESS_TECHNOLOGY_UM=
TS;
> +
> +       } else
> +               goto err;
> +
> +       cb(&error, &rf, cbd->data);
> +               return;
> +
> +err:
> +       CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
> +}
> +
> +
> +       /* The GPS manager can ask the modem to generate a HW pulse (time
> +        * stamp) with a defined length and the modem replies indicates w=
hen
> +        * it generates the pulse. But as the modem has no precise idae of
> +        * Universal Time, it indicates at which radio frame number itgc
> +        * generated the pulse. The GPS manager which knows the link betw=
een
> +        * Universal Time and the Radio Frame number knows very precisely=
 at
> +        * what time the pulse was generated and its duration.
> +        *
> +        * Timing accuracy is typically a few microseconds.
> +        */
> +static void ifx_agps_inject_time(struct ofono_agps *agps,
> +                       int radio_access_technology,/* enum access_techno=
logy */
> +                       int pulse_length,/* duration of pulse in radio sl=
ots */
> +                       ofono_agps_inject_time_cb_t cb, void *user_data)
> +{
> +       struct agps_data *data =3D ofono_agps_get_data(agps);
> +       struct cb_data *cbd =3D cb_data_new(cb, user_data);
> +       char *buf;
> +       unsigned int id;
> +
> +       if (!cbd)
> +               goto error;
> +
> +       cbd->user =3D data;
> +
> +       if (RADIO_ACCESS_TECHNOLOGY_GSM =3D=3D radio_access_technology) {
> +               data->rad_acc_tech =3D radio_access_technology;
> +               buf =3D g_strdup_printf("AT%%XFTI=3D\"%s%d\"", "GSM",
> +                                               pulse_length);
> +
> +       } else if (RADIO_ACCESS_TECHNOLOGY_UMTS =3D=3D radio_access_techn=
ology) {
> +                       data->rad_acc_tech =3D radio_access_technology;
> +                       buf =3D g_strdup_printf("AT%%XFTI=3D\"%s%d\"", "U=
MTS",
> +                                               pulse_length);
> +       } else
> +               goto error;

We compare things with if (variable =3D=3D constant).

And the coding style is off here again.

> +
> +       id =3D g_at_chat_send(data->chat, buf, none_prefix,
> +                   ifx_agps_inject_time_cb, cbd, g_free);
> +
> +       g_free(buf);
> +
> +       if (id > 0)
> +               return;
> +
> +error:
> +       if (cbd)
> +               g_free(cbd);
> +
> +       CALLBACK_WITH_FAILURE(cb, NULL, user_data);
> +}
> +
> +static struct ofono_agps_driver driver =3D {
> +       .name                                       =3D "ifxmodem",
> +       .probe                                      =3D ifx_agps_probe,
> +       .remove                                     =3D ifx_agps_remove,
> +       .receive_lcs_frames                     =3D ifx_agps_receive_lcs_=
frames,
> +       .send_lcs_frame                         =3D ifx_agps_send_lcs_fra=
me,
> +       .inject_time                            =3D ifx_agps_inject_time
> +};

Fix the coding style please.
> +
> +void ifx_agps_init()
> +{
> +       ofono_agps_driver_register(&driver);
> +       DBG("ifx_agps_init: ..");
> +}
> +
> +void ifx_agps_exit()
> +{
> +       ofono_agps_driver_unregister(&driver);
> +       DBG("ifx_agps_exit: ..");
> +}

No useless DBG in init and exit functions.

> +
> diff --git a/drivers/ifxmodem/ifxmodem.c b/drivers/ifxmodem/ifxmodem.c
> index 8a9ac8f..2a2a273 100644
> --- a/drivers/ifxmodem/ifxmodem.c
> +++ b/drivers/ifxmodem/ifxmodem.c
> @@ -39,12 +39,14 @@ static int ifxmodem_init(void)
>         ifx_radio_settings_init();
>         ifx_gprs_context_init();
>         ifx_stk_init();
> +       ifx_agps_init();
> =

>         return 0;
>  }
> =

>  static void ifxmodem_exit(void)
>  {
> +       ifx_agps_exit();
>         ifx_stk_exit();
>         ifx_gprs_context_exit();
>         ifx_radio_settings_exit();
> diff --git a/drivers/ifxmodem/ifxmodem.h b/drivers/ifxmodem/ifxmodem.h
> index 8ea52e5..e5accc2 100644
> --- a/drivers/ifxmodem/ifxmodem.h
> +++ b/drivers/ifxmodem/ifxmodem.h
> @@ -35,3 +35,6 @@ extern void ifx_gprs_context_exit();
> =

>  extern void ifx_stk_init();
>  extern void ifx_stk_exit();
> +
> +extern void ifx_agps_init();
> +extern void ifx_agps_exit();
> diff --git a/include/agps.h b/include/agps.h
> new file mode 100644
> index 0000000..7188eef
> --- /dev/null
> +++ b/include/agps.h
> @@ -0,0 +1,159 @@
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
> +#ifndef __OFONO_AGPS_H_
> +#define __OFONO_AGPS_H_
> +
> +#ifdef __cplusplus
> +extern "C" {
> +#endif
> +
> +#include <ofono/types.h>
> +
> +#include <glib.h>
> +#include <gdbus.h>
> +#include <ofono/modem.h>
> +
> +#include "gatchat.h"
> +#include "gatresult.h"

What are these includes doing here? If you need more than
<ofono/types.h> then something is wrong.

> +
> +enum ofono_lcs_frame_type {
> +       RRLP_ASSISTANCE_DATA =3D 0,               /* from modem */
> +       /* Position request can include assistance data as well */
> +       RRLP_MEASURE_POSITION_REQUEST =3D 1,      /* from modem */
> +       RRLP_MEASURE_POSITION_RESPONSE =3D 2,     /* from GPS */
> +       RRC_ASSISTANCE_DATA_DELIVERY =3D 3,       /* from modem */
> +       /* Measurement control can include assistance data as well */
> +       RRC_MEASUREMENT_CONTROL =3D 4,            /* from modem */
> +       RRC_MEASUREMENT_REPORT =3D 5,             /* from GPS */
> +};
> +
> +enum ofono_access_technology {
> +       RADIO_ACCESS_TECHNOLOGY_GSM =3D 0,                /* GSM */
> +       RADIO_ACCESS_TECHNOLOGY_UMTS =3D 1,               /* UMTS */
> +};
> +
> +enum ofono_rrc_state {
> +       RRC_CELL_PCH =3D 0,
> +       RRC_CELL_FACH =3D 1,
> +       RRC_CELL_DCH =3D 2,
> +       RRC_URA_PCH =3D 3,
> +};
> +
> +struct ofono_lcs_frame {
> +       enum ofono_lcs_frame_type lcs_frame_type;
> +       int frame_length;       /* size of raw_frame in bytes */
> +       unsigned char  *raw_frame;
> +};
> +
> +struct ofono_lcs_gsm_fn {
> +       int TDMA_frame_number;  /* range 0 - 2715647 (2048*26*51) */
> +       int TDMA_timeslot;              /* range 0 - 7 */
> +       int timeslot_bit;               /* range 0 - 156 */
> +       int timing_advance;             /* range 0 - 63 */
> +       int bcch_arfcn;                 /* range 0 - 1023 */
> +       int bsic;                               /* range 0 - 64 */
> +};
> +
> +struct ofono_lcs_utran_fn {
> +       int sfn;                                /* range 0 - 4095 */
> +       int rrc_state;                  /* enum ofono_rrc_state */
> +       int round_trip_time;    /* range 0 - 32766 */
> +};
> +
> +struct ofono_lcs_radio_fn {
> +       int radio_access_technology; /* enum access_technology */
> +       union {
> +               struct ofono_lcs_gsm_fn         gsm_frame_number;
> +               struct ofono_lcs_utran_fn       utran_frame_number;
> +       };
> +};
> +
> +struct ofono_agps;
> +
> +typedef void (*ofono_agps_send_lcs_frame_cb_t)(const struct ofono_error =
*error,
> +                               void *data);
> +typedef void (*ofono_agps_receive_lcs_frame_cb_t)(
> +                               const struct ofono_error *error,
> +                               void *data);
> +typedef void (*ofono_agps_inject_time_cb_t)(const struct ofono_error *er=
ror,
> +                               struct ofono_lcs_radio_fn *radio_frame_nu=
mber,
> +                               void *data);
> +
> +       /*
> +       * AGPS related functions, including LCS frame forwarding and
> +       * fine time injection
> +       */
> +struct ofono_agps_driver {
> +       const char *name;
> +       int (*probe)(struct ofono_agps *agps, unsigned int vendor,
> +                       void *data);
> +       void (*remove)(struct ofono_agps *agps);
> +       void (*receive_lcs_frames)(struct ofono_agps *agps, int enabled,
> +                       ofono_agps_receive_lcs_frame_cb_t cb, void *data);
> +
> +       /* Assistance Data and Position Requests from the Mobile Network =
are
> +        * signalled via the ofono_agps_lcs_frame_notify function and the
> +        * oFono core to an external GPS manager. This GPS manager can re=
ply
> +        * to Position Requests with one or more Position Responses which
> +        * are then send back to the modem via the send_lcs_frame functio=
n.
> +        */
> +       void (*send_lcs_frame)(struct ofono_agps *agps,
> +                       struct ofono_lcs_frame *frame,
> +                       ofono_agps_send_lcs_frame_cb_t cb, void *data);
> +
> +       /* The GPS manager can ask the modem to generate a HW pulse (time
> +        * stamp) with a defined length and the modem replies indicates w=
hen
> +        * it generates the pulse. But as the modem has no precise idea of
> +        * Universal Time, it indicates at which radio frame number it
> +        * generated the pulse. The GPS manager which knows the link betw=
een
> +        * Universal Time and the Radio Frame number knows very precisely=
 at
> +        * what time the pulse was generated and its duration.
> +        *
> +        * Timing accuracy is typically a few microseconds.
> +        */
> +       void (*inject_time)(struct ofono_agps *agps,
> +       int radio_access_technology, /* enum access_technology */
> +       int pulse_length, /* duration of pulse in radio slots */
> +       ofono_agps_inject_time_cb_t cb, void *data);
> +};
> +
> +int ofono_agps_driver_register(const struct ofono_agps_driver *d);
> +void ofono_agps_driver_unregister(const struct ofono_agps_driver *d);
> +
> +struct ofono_agps *ofono_agps_create(struct ofono_modem *modem,
> +                                       unsigned int vendor, const char *=
driver,
> +                                       void *data);
> +
> +void ofono_agps_register(struct ofono_agps *agps);
> +void ofono_agps_remove(struct ofono_agps *agps);
> +
> +void ofono_agps_set_data(struct ofono_agps *agps, void *data);
> +void *ofono_agps_get_data(struct ofono_agps *agps);
> +
> +void ofono_agps_lcs_frame_notify(struct ofono_agps *agps,
> +                       struct ofono_lcs_frame frame);
> +
> +#ifdef __cplusplus
> +}
> +#endif
> +
> +#endif /* __OFONO_AGPS_H */
> diff --git a/include/dbus.h b/include/dbus.h
> index 59b2aae..c40ce8a 100644
> --- a/include/dbus.h
> +++ b/include/dbus.h
> @@ -53,6 +53,7 @@ extern "C" {
>  #define OFONO_VOICECALL_MANAGER_INTERFACE "org.ofono.VoiceCallManager"
>  #define OFONO_STK_INTERFACE OFONO_SERVICE ".SimToolkit"
>  #define OFONO_SIM_APP_INTERFACE OFONO_SERVICE ".SimToolkitAgent"
> +#define OFONO_AGPS_MANAGER_INTERFACE "org.ofono.AgpsManager"

As a side note here, we have to talk about the naming of this interface.
I don't like the name GPS or aGPS since there are clearly more position
systems outside than GPS. I want a more neutral naming.

But this is clearly a discussion based on the documentation patch that
you have not included in your patchset yet.

>  /* Essentially a{sv} */
>  #define OFONO_PROPERTIES_ARRAY_SIGNATURE DBUS_DICT_ENTRY_BEGIN_CHAR_AS_S=
TRING \
> diff --git a/plugins/ifx.c b/plugins/ifx.c
> index 037273a..3d26b4d 100644
> --- a/plugins/ifx.c
> +++ b/plugins/ifx.c
> @@ -57,12 +57,13 @@
>  #include <ofono/radio-settings.h>
>  #include <ofono/audio-settings.h>
>  #include <ofono/stk.h>
> +#include <ofono/agps.h>
>  #include <ofono/log.h>
> =

>  #include <drivers/atmodem/atutil.h>
>  #include <drivers/atmodem/vendor.h>
> =

> -#define NUM_DLC  6
> +#define NUM_DLC  7
> =

>  #define VOICE_DLC   0
>  #define NETREG_DLC  1
> @@ -70,13 +71,16 @@
>  #define GPRS2_DLC   3
>  #define GPRS3_DLC   4
>  #define AUX_DLC     5
> +#define AGPS_DLC    6
> =

>  static char *dlc_prefixes[NUM_DLC] =3D { "Voice: ", "Net: ", "GPRS1: ",
> -                                       "GPRS2: ", "GPRS3: ", "Aux: " };
> +                                       "GPRS2: ", "GPRS3: ",
> +                                       "Aux: ",  "AGPS: " };
> =

>  static const char *dlc_nodes[NUM_DLC] =3D { "/dev/ttyGSM1", "/dev/ttyGSM=
2",
>                                         "/dev/ttyGSM3", "/dev/ttyGSM4",
> -                                       "/dev/ttyGSM5", "/dev/ttyGSM6" };
> +                                       "/dev/ttyGSM5", "/dev/ttyGSM6",
> +                                       "/dev/ttyGSM7"};

Why do we want a separate DLC for this?

And if so, it can not be the last one. The AUX_DLC is used to properly
detect when the TTY device nodes have been created.

>  static const char *none_prefix[] =3D { NULL };
>  static const char *xdrv_prefix[] =3D { "+XDRV:", NULL };
> @@ -754,6 +758,8 @@ static void ifx_post_online(struct ofono_modem *modem)
>                                         "ifxmodem", data->dlcs[GPRS3_DLC]=
);
>                 if (gc)
>                         ofono_gprs_add_context(gprs, gc);
> +
> +               ofono_agps_create(modem, 0, "ifxmodem", data->dlcs[AGPS_D=
LC]);
>         }
>  }

So is aGPS support depending on GPRS? If not, then this atom creation is
in the wrong spot.

> diff --git a/src/agps.c b/src/agps.c
> new file mode 100644
> index 0000000..516dddc
> --- /dev/null
> +++ b/src/agps.c
> @@ -0,0 +1,229 @@
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
> +#include <string.h>
> +#include <stdio.h>
> +#include <time.h>
> +#include <errno.h>
> +
> +#include <glib.h>
> +#include <gdbus.h>
> +
> +#include <ofono/log.h>
> +#include <ofono/dbus.h>
> +#include <ofono/modem.h>
> +
> +#include "ofono.h"
> +#include "common.h"
> +#include "util.h"
> +
> +static GSList *g_drivers;
> +
> +struct ofono_agps {
> +       const struct ofono_agps_driver *driver;
> +       void *driver_data;
> +       struct ofono_atom *atom;
> +       gboolean lcs_enabled;
> +       gboolean lcs_enabled_pending;
> +       DBusMessage *pending;
> +       enum ofono_access_technology access_tech;
> +       /*TODO - Implement  code here  */
> +};
> +
> +static DBusMessage *agps_get_properties(DBusConnection *conn,
> +                                               DBusMessage *msg, void *d=
ata)
> +{
> +       /* TODO - Implement  code here  */
> +       return msg;
> +}
> +
> +static DBusMessage *agps_set_property(DBusConnection *conn, DBusMessage =
*msg,
> +                                       void *data)
> +{
> +       /* TODO - Implement  code here  */
> +       return msg;
> +}
> +
> +static DBusMessage *agps_send_lcs_frame(DBusConnection *conn, DBusMessag=
e *msg,
> +                                       void *data)
> +{
> +       /* TODO - Implement  code here  */
> +       return msg;
> +}
> +
> +static DBusMessage *agps_request_fine_time_injection(DBusConnection *con=
n,
> +                                                       DBusMessage *msg,
> +                                                       void *data)
> +{
> +       /* TODO - Implement  code here  */
> +       return msg;
> +}
> +
> +static GDBusMethodTable agps_methods[] =3D {
> +       { "GetProperties", "",  "a{sv}", agps_get_properties },
> +       { "SetProperty", "sv",  "", agps_set_property },
> +       { "SendLCSFrame", "sv", "", agps_send_lcs_frame },
> +       { "RequestFineTimeInjection", "sv",     "",
> +               agps_request_fine_time_injection },
> +       { }
> +};
> +
> +static GDBusSignalTable agps_signals[] =3D {
> +       { "PropertyChanged",                            "sv" },
> +       { "IncomingLCSFrame",                           "sq" },
> +       { "FineTimeInjectionNotification",      "sq" },
> +
> +       { }
> +};
> +
> +static void agps_unregister(struct ofono_atom *atom)
> +{
> +       DBusConnection *conn =3D ofono_dbus_get_connection();
> +       struct ofono_agps *agps =3D __ofono_atom_get_data(atom);
> +       struct ofono_modem *modem =3D __ofono_atom_get_modem(atom);
> +       const char *path =3D __ofono_atom_get_path(atom);
> +
> +       g_dbus_unregister_interface(conn, path, OFONO_AGPS_MANAGER_INTERF=
ACE);
> +       ofono_modem_remove_interface(modem, OFONO_AGPS_MANAGER_INTERFACE);
> +       agps->lcs_enabled =3D FALSE;
> +}
> +
> +void ofono_agps_register(struct ofono_agps *agps)
> +{
> +       struct ofono_modem *modem =3D __ofono_atom_get_modem(agps->atom);
> +       const char *path =3D __ofono_atom_get_path(agps->atom);
> +       DBusConnection *conn =3D ofono_dbus_get_connection();
> +
> +       if (!g_dbus_register_interface(conn, path,
> +                       OFONO_AGPS_MANAGER_INTERFACE,
> +                       agps_methods,
> +                       agps_signals,
> +                       NULL, NULL, NULL)) {
> +               ofono_error("agps_dbus_register:Could not register AGPS M=
anager"
> +               "Interface/Path");
> +               return;
> +       }
> +
> +       ofono_modem_add_interface(modem, OFONO_AGPS_MANAGER_INTERFACE);
> +       __ofono_atom_register(agps->atom, agps_unregister);
> +}
> +
> +void ofono_agps_remove(struct ofono_agps *agps)
> +{
> +       __ofono_atom_free(agps->atom);
> +}
> +
> +static void agps_remove(struct ofono_atom *atom)
> +{
> +       struct ofono_agps *agps =3D __ofono_atom_get_data(atom);
> +
> +       DBG("atom: %p", atom);
> +
> +       if (agps =3D=3D NULL)
> +               return;
> +
> +       g_free(agps);
> +}
> +
> +void ofono_agps_set_data(struct ofono_agps *agps, void *data)
> +{
> +       agps->driver_data =3D data;
> +}
> +
> +void *ofono_agps_get_data(struct ofono_agps *agps)
> +{
> +       return agps->driver_data;
> +}
> +
> +struct ofono_agps *ofono_agps_create(struct ofono_modem *modem,
> +                                       unsigned int vendor,
> +                                       const char *driver,
> +                                       void *data)
> +{
> +       struct ofono_agps *agps;
> +       GSList *l;
> +
> +       if (driver =3D=3D NULL)
> +               return NULL;
> +
> +       agps =3D g_try_new0(struct ofono_agps, 1);
> +
> +       if (agps =3D=3D NULL)
> +               return NULL;
> +
> +       agps->atom =3D __ofono_modem_add_atom(modem, OFONO_ATOM_TYPE_AGPS,
> +                                               agps_remove, agps);
> +
> +       for (l =3D g_drivers; l; l =3D l->next) {
> +               const struct ofono_agps_driver *drv =3D l->data;
> +
> +               if (g_strcmp0(drv->name, driver))
> +                       continue;
> +
> +               if (drv->probe(agps, vendor, data) < 0)
> +                       continue;
> +
> +               agps->driver =3D drv;
> +               break;
> +       }
> +       return agps;
> +}
> +
> +int ofono_agps_driver_register(const struct ofono_agps_driver *d)
> +{
> +       DBG("driver: %p, name: %s", d, d->name);
> +
> +       if (d->probe =3D=3D NULL)
> +               return -EINVAL;
> +
> +       g_drivers =3D g_slist_prepend(g_drivers, (void *)d);
> +
> +       return 0;
> +}
> +
> +void ofono_agps_driver_unregister(const struct ofono_agps_driver *d)
> +{
> +       DBG("driver: %p, name: %s", d, d->name);
> +
> +       g_drivers =3D g_slist_remove(g_drivers, (void *)d);
> +}
> +
> +void ofono_agps_lcs_frame_notify(struct ofono_agps *agps,
> +                       struct ofono_lcs_frame frame)
> +{
> +
> +       DBusConnection *conn =3D ofono_dbus_get_connection();
> +       const char *path =3D __ofono_atom_get_path(agps->atom);
> +
> +       g_dbus_emit_signal(conn, path, OFONO_AGPS_MANAGER_INTERFACE,
> +                               "PositionRequest",
> +                               DBUS_TYPE_UINT16, &frame.lcs_frame_type,
> +                               DBUS_TYPE_UINT16, &frame.frame_length,
> +                               DBUS_TYPE_STRING, &frame.raw_frame,
> +                               DBUS_TYPE_INVALID);
> +}
> +
> +
> +
> diff --git a/src/ofono.h b/src/ofono.h
> index bd7f33c..8048330 100644
> --- a/src/ofono.h
> +++ b/src/ofono.h
> @@ -124,6 +124,7 @@ enum ofono_atom_type {
>         OFONO_ATOM_TYPE_AUDIO_SETTINGS =3D 19,
>         OFONO_ATOM_TYPE_STK =3D 20,
>         OFONO_ATOM_TYPE_NETTIME =3D 21,
> +       OFONO_ATOM_TYPE_AGPS =3D 22,
>  };

This is just a blank skeleton, so nothing to comment about.

>  enum ofono_atom_watch_condition {
> @@ -199,6 +200,7 @@ gboolean __ofono_call_settings_is_busy(struct ofono_c=
all_settings *cs);
>  #include <ofono/audio-settings.h>
> =

>  #include <ofono/voicecall.h>
> +#include <ofono/agps.h>
> =

This is the wrong location of this include. You are getting in between
the include and its oFono core internal declarations. Find a better
spot.

>  enum ofono_voicecall_interaction {
>         OFONO_VOICECALL_INTERACTION_NONE        =3D 0,

Regards

Marcel



--===============7227214147500625979==--

