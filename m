Content-Type: multipart/mixed; boundary="===============5274278591985854036=="
MIME-Version: 1.0
From: Benis, Robertino <robertino.benis@intel.com>
Subject: [RFC] [CHANGE 2/2] ifxmodem: adding modem API to support agps
Date: Tue, 02 Nov 2010 18:07:20 -0700
Message-ID: <CB28AA307186A940B1253A743EA1F20AA58B8B1C@orsmsx507.amr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5274278591985854036==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,

This patch is RFC for Infenion modem API to support agps implementation of =
ofono.

Thank you for your comments in advance.

Cheers,
-- r.

From 2544eed707725e813c4673aa0577c095a0a3c2a5 Mon Sep 17 00:00:00 2001
From: Robertino Benis <robertino.benis@intel.com>
Date: Tue, 2 Nov 2010 17:16:35 -0700
Subject: [CHANGE 2/2] [RFC] ifxmodem: adding modem API to support agps
Organization: Intel
Cc: robertino.benis(a)intel.com

---
 drivers/ifxmodem/agps.c |  438 +++++++++++++++++++++++++++++++++++++++++++=
++++
 include/agps.h          |  157 +++++++++++++++++
 2 files changed, 595 insertions(+), 0 deletions(-)
 create mode 100644 drivers/ifxmodem/agps.c
 create mode 100644 include/agps.h

diff --git a/drivers/ifxmodem/agps.c b/drivers/ifxmodem/agps.c
new file mode 100644
index 0000000..9b68b7e
--- /dev/null
+++ b/drivers/ifxmodem/agps.c
@@ -0,0 +1,438 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2010  Intel Corporation. All rights reserved.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+#include <string.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <errno.h>
+
+#include <glib.h>
+
+#include "gatchat.h"
+#include "gatresult.h"
+
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/agps.h>
+
+#include "util.h"
+#include "ifxmodem.h"
+
+struct agps_data {
+       GAtChat *chat;
+       unsigned int vendor;
+       enum ofono_access_technology rad_acc_tech;
+};
+
+struct ofono_agps;
+static enum ofono_access_technology rad_acc_tech;
+static const char *none_prefix[] =3D { NULL };
+
+#define FRAME_LEN 128
+
+static void pos_request_notify(GAtResult *result, gpointer user_data)
+{
+       struct ofono_agps *agps =3D user_data;
+       int framelen;
+       int frametype;
+       GAtResultIter iter;
+       struct ofono_lcs_frame lcsframe;
+       const char *messageframe;
+       unsigned char frame[FRAME_LEN];
+       long hexframelen;
+
+       /* Assuming Pos Req format: %XPOSR: <frametype>,<framelen>,<frame> =
*/
+
+       g_at_result_iter_init(&iter, result);
+
+       if (!g_at_result_iter_next(&iter, "%%XPOSR:"))
+               return;
+
+       if (!g_at_result_iter_next_number(&iter, &frametype))
+               return;
+
+       if (!g_at_result_iter_next_number(&iter, &framelen))
+               return;
+
+       if (framelen > FRAME_LEN) {
+               ofono_error("Got POS request msg more than max buffer size!=
");
+               return;
+       }
+
+       messageframe =3D g_at_result_pdu(result);
+
+       if (strlen(messageframe) > sizeof(frame) * 2) { /*Hex, 2 chars/byte=
*/
+               ofono_error("Message frame too long!");
+               return;
+       }
+
+       if (decode_hex_own_buf(messageframe, -1, &hexframelen, 0,
+                               frame) =3D=3D NULL) {
+               ofono_error("Unable to hex-decode the AGPS frame");
+               return;
+       }
+
+       DBG("Got POS request data: %s, %ld", frame, hexframelen);
+
+       if (hexframelen !=3D framelen) {
+               ofono_error("hexframelen not equal to reported framelen");
+               return;
+       }
+
+       lcsframe.lcs_frame_type =3D frametype;
+       lcsframe.frame_length =3D framelen;
+       lcsframe.raw_frame =3D (unsigned char *)frame;
+
+       ofono_agps_lcs_frame_notify(agps, lcsframe);
+}
+
+static void inj_time_notify(GAtResult *result, gpointer user_data)
+{
+
+       struct cb_data *cbd =3D user_data;
+       struct agps_data *agd =3D cbd->user;
+       ofono_agps_inject_time_cb_t cb =3D cbd->cb;
+       struct ofono_lcs_radio_fn rf;
+       struct ofono_error error =3D { .type =3D OFONO_ERROR_TYPE_NO_ERROR =
};
+       GAtResultIter iter;
+
+       g_at_result_iter_init(&iter, result);
+
+       if (!g_at_result_iter_next(&iter, "%%XFTI:"))
+               return;
+
+       if (RADIO_ACCESS_TECHNOLOGY_GSM =3D=3D rad_acc_tech) {
+
+               int fn;         /* range 0 - 2715647 (2048*26*51) */
+               int ts;         /* range 0 - 7 */
+               int tsb;        /* range 0 - 156 */
+               int ta;         /* range 0 - 63 */
+               int ba;         /* range 0 - 1023 */
+               int bc;         /* range 0 - 64 */
+
+       /*       %XFTI:<frameNum>,<TimeSlot>,<TimeSlotBit>,<TimeAdv>,
+       *       <ChannelNum>,<ChannelId>
+       */
+               if (!g_at_result_iter_next_number(&iter, &fn))
+                       goto err;
+
+               if (!g_at_result_iter_next_number(&iter, &ts))
+                       goto err;
+
+               if (!g_at_result_iter_next_number(&iter, &tsb))
+                       goto err;
+
+               if (!g_at_result_iter_next_number(&iter, &ta))
+                       goto err;
+
+               if (!g_at_result_iter_next_number(&iter, &ba))
+                       goto err;
+
+               if (!g_at_result_iter_next_number(&iter, &bc))
+                       goto err;
+
+               DBG("GSM Inject Response: fn =3D %d ts =3D %d tsb =3D %d ta=
 =3D %d"
+                               "ba =3D %d bc =3D %d ", fn, ts, tsb, ta, ba=
, bc);
+
+               rf.gsm_frame_number.TDMA_frame_number =3D fn;
+               rf.gsm_frame_number.TDMA_timeslot =3D ts;
+               rf.gsm_frame_number.timeslot_bit =3D tsb;
+               rf.gsm_frame_number.timing_advance =3D ta;
+               rf.gsm_frame_number.bcch_arfcn =3D ba;
+               rf.gsm_frame_number.bsic =3D bc;
+               rf.radio_access_technology =3D RADIO_ACCESS_TECHNOLOGY_GSM;
+
+       } else if (RADIO_ACCESS_TECHNOLOGY_UMTS =3D=3D rad_acc_tech) {
+
+               int sfn;        /* range 0 - 4095 */
+               int rs;         /* enum ofono_rrc_state */
+               int rt;         /* range 0 - 32766 */
+
+               /* %XFTI:<frameNum>,<RadioState>,<TripTime> */
+               if (!g_at_result_iter_next_number(&iter, &sfn))
+                       goto err;
+
+               if (!g_at_result_iter_next_number(&iter, &rs))
+                       goto err;
+
+               if (!g_at_result_iter_next_number(&iter, &rt))
+                       goto err;
+
+               DBG("UMTS Inject Response: sfn =3D %d rs =3D %d tt =3D %d",
+                               sfn, rs, rt);
+
+               rf.utran_frame_number.sfn =3D sfn;
+               rf.utran_frame_number.rrc_state =3D rs;
+               rf.utran_frame_number.round_trip_time =3D rt;
+               rf.radio_access_technology =3D RADIO_ACCESS_TECHNOLOGY_UMTS;
+
+       } else
+               goto err;
+
+       cb(&error, &rf, cbd->data);
+       return;
+
+err:
+       CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
+}
+
+static int ifx_agps_probe(struct ofono_agps *agps,
+                                       unsigned int vendor, void *data)
+{
+       GAtChat *chat =3D data;
+       struct agps_data *agd =3D ofono_agps_get_data(agps);
+
+       agd =3D g_try_new0(struct agps_data, 1);
+       if (!agd)
+               return -ENOMEM;
+
+       agd->chat =3D g_at_chat_clone(chat);
+       agd->vendor =3D vendor;
+
+       ofono_agps_set_data(agps, agd);
+
+       g_at_chat_register(agd->chat, "%%XPOSR:", pos_request_notify, TRUE,
+                               agps, NULL);
+
+       ofono_agps_register(agps);
+
+       return 0;
+}
+
+static void ifx_agps_remove(struct ofono_agps *agps)
+{
+       struct agps_data *agd =3D ofono_agps_get_data(agps);
+
+       ofono_agps_remove(agps);
+       ofono_agps_set_data(agps, NULL);
+       g_at_chat_unref(agd->chat);
+       g_free(agd);
+}
+
+static void ifx_agps_receive_lcs_frame_cb(gboolean ok, GAtResult *result,
+                               gpointer user_data)
+{
+       struct cb_data *cbd =3D user_data;
+       ofono_agps_receive_lcs_frame_cb_t cb =3D cbd->cb;
+       struct ofono_error error;
+
+       decode_at_error(&error, g_at_result_final_response(result));
+       cb(&error, cbd->data);
+}
+
+   /*
+       * The GPS manager can enable or disable AGPS manager  to receive
+       * lcs_frames from the Mobile network. If disabled, all Assistance D=
ata
+       * and Position Requests from Mobile Network are not signalled to of=
ono.
+       */
+static void ifx_agps_receive_lcs_frames(struct ofono_agps *agps,
+                       int enabled, ofono_agps_receive_lcs_frame_cb_t cb,
+                       void *user_data)
+{
+       struct agps_data *data =3D ofono_agps_get_data(agps);
+       struct cb_data *cbd =3D cb_data_new(cb, user_data);
+       char *commbuf;
+       unsigned int id;
+
+       if (!cbd)
+               goto error;
+
+       commbuf =3D g_strdup_printf("AT%%XPOS=3D\"%d\"", enabled);
+
+       id =3D g_at_chat_send(data->chat, commbuf, none_prefix,
+                               ifx_agps_receive_lcs_frame_cb, cbd, g_free);
+
+       g_free(commbuf);
+
+       if (id > 0)
+               return;
+error:
+       if (cbd)
+               g_free(cbd);
+
+       CALLBACK_WITH_FAILURE(cb, user_data);
+}
+
+static void ifx_agps_send_lcs_frame_cb(gboolean ok, GAtResult *result,
+                               gpointer user_data)
+{
+       struct cb_data *cbd =3D user_data;
+       ofono_agps_send_lcs_frame_cb_t cb =3D cbd->cb;
+       struct ofono_error error;
+
+       decode_at_error(&error, g_at_result_final_response(result));
+       cb(&error, cbd->data);
+}
+
+#define BUF_LEN 128
+
+       /* Assistance Data and Position Requests from the Mobile Network are
+        * signalled via the ofono_agps_lcs_frame_notify function and the
+        * oFono core to an external GPS manager. This GPS manager can reply
+        * to Position Requests with one or more Position Responses which
+        * are then send back to the modem via the send_lcs_frame function.
+        */
+static void ifx_agps_send_lcs_frame(struct ofono_agps *agps,
+                               struct ofono_lcs_frame *frame,
+                               ofono_agps_send_lcs_frame_cb_t cb,
+                               void *user_data)
+{
+       struct agps_data *data =3D ofono_agps_get_data(agps);
+       struct cb_data *cbd =3D cb_data_new(cb, user_data);
+       char buf[BUF_LEN * 2 + 1];
+       char *commbuf;
+       unsigned int id;
+       int buflen;
+
+       if (!cbd)
+               goto error;
+
+       if (!frame->frame_length) {
+               ofono_error("ifx_agps_send_lcs_frame: Frame length Invalid"=
);
+               goto error;
+       }
+
+       if (frame->frame_length > BUF_LEN) {
+               ofono_error("ifx_agps_send_lcs_frame: Frame length too long=
!");
+               goto error;
+       }
+
+       encode_hex_own_buf(frame->raw_frame, frame->frame_length, 0, buf);
+       buflen =3D strlen(buf);
+       DBG("Encoded AGPS Frame =3D %s %d", buf, buflen);
+
+       commbuf =3D g_strdup_printf("AT%%XPOSR=3D%d,%d,\"%s\"",
+                       frame->lcs_frame_type, buflen, buf);
+
+       id =3D g_at_chat_send(data->chat, commbuf, none_prefix,
+                               ifx_agps_send_lcs_frame_cb, cbd, g_free);
+
+       g_free(commbuf);
+
+       if (id > 0)
+               return;
+error:
+       if (cbd)
+               g_free(cbd);
+
+       CALLBACK_WITH_FAILURE(cb, user_data);
+}
+
+static void ifx_agps_inject_time_cb(gboolean ok, GAtResult *result,
+                               gpointer user_data)
+{
+       struct cb_data *cbd =3D user_data;
+       struct agps_data *data =3D cbd->user;
+       ofono_agps_inject_time_cb_t cb =3D cbd->cb;
+       struct ofono_error error;
+
+       decode_at_error(&error, g_at_result_final_response(result));
+
+       if (!ok)
+               goto err;
+
+       g_at_chat_register(agd->chat, "%%XFTI:",
+                                       inj_time_notify, FALSE,
+                                       data, g_free);
+       return;
+
+err:
+       cb(&error, NULL, cbd->data);
+       g_free(cbd);
+}
+
+       /* The GPS manager can ask the modem to generate a HW pulse (time
+        * stamp) with a defined length and the modem replies indicates when
+        * it generates the pulse. But as the modem has no precise idae of
+        * Universal Time, it indicates at which radio frame number itgc
+        * generated the pulse. The GPS manager which knows the link between
+        * Universal Time and the Radio Frame number knows very precisely at
+        * what time the pulse was generated and its duration.
+        *
+        * Timing accuracy is typically a few microseconds.
+        */
+static void ifx_agps_inject_time(struct ofono_agps *agps,
+                       int radio_access_technology,/* enum access_technolo=
gy */
+                       int pulse_length,/* duration of pulse in radio slot=
s */
+                       ofono_agps_inject_time_cb_t cb, void *user_data)
+{
+       struct agps_data *data =3D ofono_agps_get_data(agps);
+       struct cb_data *cbd =3D cb_data_new(cb, user_data);
+       char *buf;
+       unsigned int id;
+
+       if (!cbd)
+               goto error;
+
+       cbd->user =3D data;
+
+       if (radio_access_technology =3D=3D RADIO_ACCESS_TECHNOLOGY_GSM) {
+               data->rad_acc_tech =3D radio_access_technology;
+               buf =3D g_strdup_printf("AT%%XFTI=3D\"%s%d\"", "GSM",
+                                               pulse_length);
+
+       } else if (radio_access_technology =3D=3D RADIO_ACCESS_TECHNOLOGY_U=
MTS) {
+                       data->rad_acc_tech =3D radio_access_technology;
+                       buf =3D g_strdup_printf("AT%%XFTI=3D\"%s%d\"", "UMT=
S",
+                                               pulse_length);
+       } else
+               goto error;
+
+       id =3D g_at_chat_send(data->chat, buf, none_prefix,
+                   ifx_agps_inject_time_cb, cbd, g_free);
+
+       g_free(buf);
+
+       if (id > 0)
+               return;
+
+error:
+       if (cbd)
+               g_free(cbd);
+
+       CALLBACK_WITH_FAILURE(cb, NULL, user_data);
+}
+
+static struct ofono_agps_driver driver =3D {
+       .name                           =3D "ifxmodem",
+       .probe                          =3D ifx_agps_probe,
+       .remove                         =3D ifx_agps_remove,
+       .receive_lcs_frames             =3D ifx_agps_receive_lcs_frames,
+       .send_lcs_frame                 =3D ifx_agps_send_lcs_frame,
+       .inject_time                    =3D ifx_agps_inject_time
+};
+
+void ifx_agps_init()
+{
+       ofono_agps_driver_register(&driver);
+}
+
+void ifx_agps_exit()
+{
+       ofono_agps_driver_unregister(&driver);
+}
+
diff --git a/include/agps.h b/include/agps.h
new file mode 100644
index 0000000..54f9b53
--- /dev/null
+++ b/include/agps.h
@@ -0,0 +1,157 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2010  Intel Corporation. All rights reserved.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
+ *
+ */
+
+#ifndef __OFONO_AGPS_H_
+#define __OFONO_AGPS_H_
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <ofono/types.h>
+
+enum ofono_lcs_frame_type {
+       RRLP_ASSISTANCE_DATA =3D 0,               /* from modem */
+       /* Position request can include assistance data as well */
+       RRLP_MEASURE_POSITION_REQUEST =3D 1,      /* from modem */
+       RRLP_MEASURE_POSITION_RESPONSE =3D 2,     /* from GPS */
+       RRC_ASSISTANCE_DATA_DELIVERY =3D 3,       /* from modem */
+       /* Measurement control can include assistance data as well */
+       RRC_MEASUREMENT_CONTROL =3D 4,            /* from modem */
+       RRC_MEASUREMENT_REPORT =3D 5,             /* from GPS */
+};
+
+enum ofono_access_technology {
+       RADIO_ACCESS_TECHNOLOGY_GSM =3D 0,                /* GSM */
+       RADIO_ACCESS_TECHNOLOGY_UMTS =3D 1,               /* UMTS */
+};
+
+enum ofono_rrc_state {
+       RRC_CELL_PCH =3D 0,
+       RRC_CELL_FACH =3D 1,
+       RRC_CELL_DCH =3D 2,
+       RRC_URA_PCH =3D 3,
+};
+
+struct ofono_lcs_frame {
+       enum ofono_lcs_frame_type lcs_frame_type;
+       int frame_length;       /* size of raw_frame in bytes */
+       unsigned char  *raw_frame;
+};
+
+struct ofono_lcs_gsm_fn {
+       int TDMA_frame_number;  /* range 0 - 2715647 (2048*26*51) */
+       int TDMA_timeslot;              /* range 0 - 7 */
+       int timeslot_bit;               /* range 0 - 156 */
+       int timing_advance;             /* range 0 - 63 */
+       int bcch_arfcn;                 /* range 0 - 1023 */
+       int bsic;                               /* range 0 - 64 */
+};
+
+struct ofono_lcs_utran_fn {
+       int sfn;                                /* range 0 - 4095 */
+       int rrc_state;                  /* enum ofono_rrc_state */
+       int round_trip_time;    /* range 0 - 32766 */
+};
+
+struct ofono_lcs_radio_fn {
+       int radio_access_technology; /* enum access_technology */
+       union {
+               struct ofono_lcs_gsm_fn         gsm_frame_number;
+               struct ofono_lcs_utran_fn       utran_frame_number;
+       };
+};
+
+struct ofono_agps;
+
+typedef void (*ofono_agps_send_lcs_frame_cb_t)(const struct ofono_error *e=
rror,
+                               void *data);
+typedef void (*ofono_agps_receive_lcs_frame_cb_t)(
+                               const struct ofono_error *error,
+                               void *data);
+typedef void (*ofono_agps_inject_time_cb_t)(const struct ofono_error *erro=
r,
+                               struct ofono_lcs_radio_fn *radio_frame_numb=
er,
+                               void *data);
+
+       /*
+        * AGPS related functions, including LCS frame forwarding and
+        * fine time injection
+        */
+struct ofono_agps_driver {
+       const char *name;
+       int (*probe)(struct ofono_agps *agps, unsigned int vendor,
+                       void *data);
+       void (*remove)(struct ofono_agps *agps);
+
+       /* The GPS manager can configure the modem to notify Assistance Dat=
a and
+        * Position Requests from the Mobile Network by setting the LcsEnab=
led
+        * status to true. If false, no notifications are sent from modem.
+        */
+       void (*receive_lcs_frames)(struct ofono_agps *agps, int enabled,
+                       ofono_agps_receive_lcs_frame_cb_t cb, void *data);
+
+       /* Assistance Data and Position Requests from the Mobile Network are
+        * signalled via the ofono_agps_lcs_frame_notify function and the
+        * oFono core to an external GPS manager. This GPS manager can reply
+        * to Position Requests with one or more Position Responses which
+        * are then send back to the modem via the send_lcs_frame function.
+        */
+       void (*send_lcs_frame)(struct ofono_agps *agps,
+                       struct ofono_lcs_frame *frame,
+                       ofono_agps_send_lcs_frame_cb_t cb, void *data);
+
+       /* The GPS manager can ask the modem to generate a HW pulse (time
+        * stamp) with a defined length and the modem replies indicates when
+        * it generates the pulse. But as the modem has no precise idea of
+        * Universal Time, it indicates at which radio frame number it
+        * generated the pulse. The GPS manager which knows the link between
+        * Universal Time and the Radio Frame number knows very precisely at
+        * what time the pulse was generated and its duration.
+        *
+        * Timing accuracy is typically a few microseconds.
+        */
+       void (*inject_time)(struct ofono_agps *agps,
+       int radio_access_technology, /* enum access_technology */
+       int pulse_length, /* duration of pulse in radio slots */
+       ofono_agps_inject_time_cb_t cb, void *data);
+};
+
+int ofono_agps_driver_register(const struct ofono_agps_driver *d);
+void ofono_agps_driver_unregister(const struct ofono_agps_driver *d);
+
+struct ofono_agps *ofono_agps_create(struct ofono_modem *modem,
+                                       unsigned int vendor, const char *dr=
iver,
+                                       void *data);
+
+void ofono_agps_register(struct ofono_agps *agps);
+void ofono_agps_remove(struct ofono_agps *agps);
+
+void ofono_agps_set_data(struct ofono_agps *agps, void *data);
+void *ofono_agps_get_data(struct ofono_agps *agps);
+
+void ofono_agps_lcs_frame_notify(struct ofono_agps *agps,
+                       struct ofono_lcs_frame frame);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __OFONO_AGPS_H */
--
1.7.0.4

--===============5274278591985854036==
Content-Type: text/plain
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0002-RFC-ifxmodem-adding-modem-API-to-support-agps.txt"

RnJvbSAyNTQ0ZWVkNzA3NzI1ZTgxM2M0NjczYWEwNTc3YzA5NWEwYTNjMmE1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSb2JlcnRpbm8gQmVuaXMgPHJvYmVydGluby5iZW5pc0BpbnRl
bC5jb20+CkRhdGU6IFR1ZSwgMiBOb3YgMjAxMCAxNzoxNjozNSAtMDcwMApTdWJqZWN0OiBbQ0hB
TkdFIDIvMl0gW1JGQ10gaWZ4bW9kZW06IGFkZGluZyBtb2RlbSBBUEkgdG8gc3VwcG9ydCBhZ3Bz
Ck9yZ2FuaXphdGlvbjogSW50ZWwgCkNjOiByb2JlcnRpbm8uYmVuaXNAaW50ZWwuY29tCgotLS0K
IGRyaXZlcnMvaWZ4bW9kZW0vYWdwcy5jIHwgIDQzOCArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKwogaW5jbHVkZS9hZ3BzLmggICAgICAgICAgfCAgMTU3ICsr
KysrKysrKysrKysrKysrCiAyIGZpbGVzIGNoYW5nZWQsIDU5NSBpbnNlcnRpb25zKCspLCAwIGRl
bGV0aW9ucygtKQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvaWZ4bW9kZW0vYWdwcy5jCiBj
cmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9hZ3BzLmgKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2lm
eG1vZGVtL2FncHMuYyBiL2RyaXZlcnMvaWZ4bW9kZW0vYWdwcy5jCm5ldyBmaWxlIG1vZGUgMTAw
NjQ0CmluZGV4IDAwMDAwMDAuLjliNjhiN2UKLS0tIC9kZXYvbnVsbAorKysgYi9kcml2ZXJzL2lm
eG1vZGVtL2FncHMuYwpAQCAtMCwwICsxLDQzOCBAQAorLyoKKyAqCisgKiAgb0Zvbm8gLSBPcGVu
IFNvdXJjZSBUZWxlcGhvbnkKKyAqCisgKiAgQ29weXJpZ2h0IChDKSAyMDA4LTIwMTAgIEludGVs
IENvcnBvcmF0aW9uLiBBbGwgcmlnaHRzIHJlc2VydmVkLgorICoKKyAqICBUaGlzIHByb2dyYW0g
aXMgZnJlZSBzb2Z0d2FyZTsgeW91IGNhbiByZWRpc3RyaWJ1dGUgaXQgYW5kL29yIG1vZGlmeQor
ICogIGl0IHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2Ug
dmVyc2lvbiAyIGFzCisgKiAgcHVibGlzaGVkIGJ5IHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRp
b24uCisgKgorICogIFRoaXMgcHJvZ3JhbSBpcyBkaXN0cmlidXRlZCBpbiB0aGUgaG9wZSB0aGF0
IGl0IHdpbGwgYmUgdXNlZnVsLAorICogIGJ1dCBXSVRIT1VUIEFOWSBXQVJSQU5UWTsgd2l0aG91
dCBldmVuIHRoZSBpbXBsaWVkIHdhcnJhbnR5IG9mCisgKiAgTUVSQ0hBTlRBQklMSVRZIG9yIEZJ
VE5FU1MgRk9SIEEgUEFSVElDVUxBUiBQVVJQT1NFLiAgU2VlIHRoZQorICogIEdOVSBHZW5lcmFs
IFB1YmxpYyBMaWNlbnNlIGZvciBtb3JlIGRldGFpbHMuCisgKgorICogIFlvdSBzaG91bGQgaGF2
ZSByZWNlaXZlZCBhIGNvcHkgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlCisgKiAg
YWxvbmcgd2l0aCB0aGlzIHByb2dyYW07IGlmIG5vdCwgd3JpdGUgdG8gdGhlIEZyZWUgU29mdHdh
cmUKKyAqICBGb3VuZGF0aW9uLCBJbmMuLCA1MSBGcmFua2xpbiBTdCwgRmlmdGggRmxvb3IsIEJv
c3RvbiwgTUEgIDAyMTEwLTEzMDEgIFVTQQorICoKKyAqLworCisjaWZkZWYgSEFWRV9DT05GSUdf
SAorI2luY2x1ZGUgPGNvbmZpZy5oPgorI2VuZGlmCisKKyNkZWZpbmUgX0dOVV9TT1VSQ0UKKyNp
bmNsdWRlIDxzdHJpbmcuaD4KKyNpbmNsdWRlIDxzdGRsaWIuaD4KKyNpbmNsdWRlIDxzdGRpby5o
PgorI2luY2x1ZGUgPGVycm5vLmg+CisKKyNpbmNsdWRlIDxnbGliLmg+CisKKyNpbmNsdWRlICJn
YXRjaGF0LmgiCisjaW5jbHVkZSAiZ2F0cmVzdWx0LmgiCisKKyNpbmNsdWRlIDxvZm9uby9sb2cu
aD4KKyNpbmNsdWRlIDxvZm9uby9tb2RlbS5oPgorI2luY2x1ZGUgPG9mb25vL2FncHMuaD4KKwor
I2luY2x1ZGUgInV0aWwuaCIKKyNpbmNsdWRlICJpZnhtb2RlbS5oIgorCitzdHJ1Y3QgYWdwc19k
YXRhIHsKKwlHQXRDaGF0ICpjaGF0OworCXVuc2lnbmVkIGludCB2ZW5kb3I7CisJZW51bSBvZm9u
b19hY2Nlc3NfdGVjaG5vbG9neSByYWRfYWNjX3RlY2g7Cit9OworCitzdHJ1Y3Qgb2Zvbm9fYWdw
czsKK3N0YXRpYyBlbnVtIG9mb25vX2FjY2Vzc190ZWNobm9sb2d5IHJhZF9hY2NfdGVjaDsKK3N0
YXRpYyBjb25zdCBjaGFyICpub25lX3ByZWZpeFtdID0geyBOVUxMIH07CisKKyNkZWZpbmUgRlJB
TUVfTEVOIDEyOAorCitzdGF0aWMgdm9pZCBwb3NfcmVxdWVzdF9ub3RpZnkoR0F0UmVzdWx0ICpy
ZXN1bHQsIGdwb2ludGVyIHVzZXJfZGF0YSkKK3sKKwlzdHJ1Y3Qgb2Zvbm9fYWdwcyAqYWdwcyA9
IHVzZXJfZGF0YTsKKwlpbnQgZnJhbWVsZW47CisJaW50IGZyYW1ldHlwZTsKKwlHQXRSZXN1bHRJ
dGVyIGl0ZXI7CisJc3RydWN0IG9mb25vX2xjc19mcmFtZSBsY3NmcmFtZTsKKwljb25zdCBjaGFy
ICptZXNzYWdlZnJhbWU7CisJdW5zaWduZWQgY2hhciBmcmFtZVtGUkFNRV9MRU5dOworCWxvbmcg
aGV4ZnJhbWVsZW47CisKKwkvKiBBc3N1bWluZyBQb3MgUmVxIGZvcm1hdDogJVhQT1NSOiA8ZnJh
bWV0eXBlPiw8ZnJhbWVsZW4+LDxmcmFtZT4gKi8KKworCWdfYXRfcmVzdWx0X2l0ZXJfaW5pdCgm
aXRlciwgcmVzdWx0KTsKKworCWlmICghZ19hdF9yZXN1bHRfaXRlcl9uZXh0KCZpdGVyLCAiJSVY
UE9TUjoiKSkKKwkJcmV0dXJuOworCisJaWYgKCFnX2F0X3Jlc3VsdF9pdGVyX25leHRfbnVtYmVy
KCZpdGVyLCAmZnJhbWV0eXBlKSkKKwkJcmV0dXJuOworCisJaWYgKCFnX2F0X3Jlc3VsdF9pdGVy
X25leHRfbnVtYmVyKCZpdGVyLCAmZnJhbWVsZW4pKQorCQlyZXR1cm47CisKKwlpZiAoZnJhbWVs
ZW4gPiBGUkFNRV9MRU4pIHsKKwkJb2Zvbm9fZXJyb3IoIkdvdCBQT1MgcmVxdWVzdCBtc2cgbW9y
ZSB0aGFuIG1heCBidWZmZXIgc2l6ZSEiKTsKKwkJcmV0dXJuOworCX0KKworCW1lc3NhZ2VmcmFt
ZSA9IGdfYXRfcmVzdWx0X3BkdShyZXN1bHQpOworCisJaWYgKHN0cmxlbihtZXNzYWdlZnJhbWUp
ID4gc2l6ZW9mKGZyYW1lKSAqIDIpIHsgLypIZXgsIDIgY2hhcnMvYnl0ZSovCisJCW9mb25vX2Vy
cm9yKCJNZXNzYWdlIGZyYW1lIHRvbyBsb25nISIpOworCQlyZXR1cm47CisJfQorCisJaWYgKGRl
Y29kZV9oZXhfb3duX2J1ZihtZXNzYWdlZnJhbWUsIC0xLCAmaGV4ZnJhbWVsZW4sIDAsCisJCQkJ
ZnJhbWUpID09IE5VTEwpIHsKKwkJb2Zvbm9fZXJyb3IoIlVuYWJsZSB0byBoZXgtZGVjb2RlIHRo
ZSBBR1BTIGZyYW1lIik7CisJCXJldHVybjsKKwl9CisKKwlEQkcoIkdvdCBQT1MgcmVxdWVzdCBk
YXRhOiAlcywgJWxkIiwgZnJhbWUsIGhleGZyYW1lbGVuKTsKKworCWlmIChoZXhmcmFtZWxlbiAh
PSBmcmFtZWxlbikgeworCQlvZm9ub19lcnJvcigiaGV4ZnJhbWVsZW4gbm90IGVxdWFsIHRvIHJl
cG9ydGVkIGZyYW1lbGVuIik7CisJCXJldHVybjsKKwl9CisKKwlsY3NmcmFtZS5sY3NfZnJhbWVf
dHlwZSA9IGZyYW1ldHlwZTsKKwlsY3NmcmFtZS5mcmFtZV9sZW5ndGggPSBmcmFtZWxlbjsKKwls
Y3NmcmFtZS5yYXdfZnJhbWUgPSAodW5zaWduZWQgY2hhciAqKWZyYW1lOworCisJb2Zvbm9fYWdw
c19sY3NfZnJhbWVfbm90aWZ5KGFncHMsIGxjc2ZyYW1lKTsKK30KKworc3RhdGljIHZvaWQgaW5q
X3RpbWVfbm90aWZ5KEdBdFJlc3VsdCAqcmVzdWx0LCBncG9pbnRlciB1c2VyX2RhdGEpCit7CisK
KwlzdHJ1Y3QgY2JfZGF0YSAqY2JkID0gdXNlcl9kYXRhOworCXN0cnVjdCBhZ3BzX2RhdGEgKmFn
ZCA9IGNiZC0+dXNlcjsKKwlvZm9ub19hZ3BzX2luamVjdF90aW1lX2NiX3QgY2IgPSBjYmQtPmNi
OworCXN0cnVjdCBvZm9ub19sY3NfcmFkaW9fZm4gcmY7CisJc3RydWN0IG9mb25vX2Vycm9yIGVy
cm9yID0geyAudHlwZSA9IE9GT05PX0VSUk9SX1RZUEVfTk9fRVJST1IgfTsKKwlHQXRSZXN1bHRJ
dGVyIGl0ZXI7CisKKwlnX2F0X3Jlc3VsdF9pdGVyX2luaXQoJml0ZXIsIHJlc3VsdCk7CisKKwlp
ZiAoIWdfYXRfcmVzdWx0X2l0ZXJfbmV4dCgmaXRlciwgIiUlWEZUSToiKSkKKwkJcmV0dXJuOwor
CisJaWYgKFJBRElPX0FDQ0VTU19URUNITk9MT0dZX0dTTSA9PSByYWRfYWNjX3RlY2gpIHsKKwor
CQlpbnQgZm47CQkvKiByYW5nZSAwIC0gMjcxNTY0NyAoMjA0OCoyNio1MSkgKi8KKwkJaW50IHRz
OwkJLyogcmFuZ2UgMCAtIDcgKi8KKwkJaW50IHRzYjsJLyogcmFuZ2UgMCAtIDE1NiAqLworCQlp
bnQgdGE7CQkvKiByYW5nZSAwIC0gNjMgKi8KKwkJaW50IGJhOwkJLyogcmFuZ2UgMCAtIDEwMjMg
Ki8KKwkJaW50IGJjOwkJLyogcmFuZ2UgMCAtIDY0ICovCisKKwkvKgkgJVhGVEk6PGZyYW1lTnVt
Piw8VGltZVNsb3Q+LDxUaW1lU2xvdEJpdD4sPFRpbWVBZHY+LAorCSoJPENoYW5uZWxOdW0+LDxD
aGFubmVsSWQ+CisJKi8KKwkJaWYgKCFnX2F0X3Jlc3VsdF9pdGVyX25leHRfbnVtYmVyKCZpdGVy
LCAmZm4pKQorCQkJZ290byBlcnI7CisKKwkJaWYgKCFnX2F0X3Jlc3VsdF9pdGVyX25leHRfbnVt
YmVyKCZpdGVyLCAmdHMpKQorCQkJZ290byBlcnI7CisKKwkJaWYgKCFnX2F0X3Jlc3VsdF9pdGVy
X25leHRfbnVtYmVyKCZpdGVyLCAmdHNiKSkKKwkJCWdvdG8gZXJyOworCisJCWlmICghZ19hdF9y
ZXN1bHRfaXRlcl9uZXh0X251bWJlcigmaXRlciwgJnRhKSkKKwkJCWdvdG8gZXJyOworCisJCWlm
ICghZ19hdF9yZXN1bHRfaXRlcl9uZXh0X251bWJlcigmaXRlciwgJmJhKSkKKwkJCWdvdG8gZXJy
OworCisJCWlmICghZ19hdF9yZXN1bHRfaXRlcl9uZXh0X251bWJlcigmaXRlciwgJmJjKSkKKwkJ
CWdvdG8gZXJyOworCisJCURCRygiR1NNIEluamVjdCBSZXNwb25zZTogZm4gPSAlZCB0cyA9ICVk
IHRzYiA9ICVkIHRhID0gJWQiCisJCQkJImJhID0gJWQgYmMgPSAlZCAiLCBmbiwgdHMsIHRzYiwg
dGEsIGJhLCBiYyk7CisKKwkJcmYuZ3NtX2ZyYW1lX251bWJlci5URE1BX2ZyYW1lX251bWJlciA9
IGZuOworCQlyZi5nc21fZnJhbWVfbnVtYmVyLlRETUFfdGltZXNsb3QgPSB0czsKKwkJcmYuZ3Nt
X2ZyYW1lX251bWJlci50aW1lc2xvdF9iaXQgPSB0c2I7CisJCXJmLmdzbV9mcmFtZV9udW1iZXIu
dGltaW5nX2FkdmFuY2UgPSB0YTsKKwkJcmYuZ3NtX2ZyYW1lX251bWJlci5iY2NoX2FyZmNuID0g
YmE7CisJCXJmLmdzbV9mcmFtZV9udW1iZXIuYnNpYyA9IGJjOworCQlyZi5yYWRpb19hY2Nlc3Nf
dGVjaG5vbG9neSA9IFJBRElPX0FDQ0VTU19URUNITk9MT0dZX0dTTTsKKworCX0gZWxzZSBpZiAo
UkFESU9fQUNDRVNTX1RFQ0hOT0xPR1lfVU1UUyA9PSByYWRfYWNjX3RlY2gpIHsKKworCQlpbnQg
c2ZuOwkvKiByYW5nZSAwIC0gNDA5NSAqLworCQlpbnQgcnM7CQkvKiBlbnVtIG9mb25vX3JyY19z
dGF0ZSAqLworCQlpbnQgcnQ7CQkvKiByYW5nZSAwIC0gMzI3NjYgKi8KKworCQkvKiAlWEZUSTo8
ZnJhbWVOdW0+LDxSYWRpb1N0YXRlPiw8VHJpcFRpbWU+ICovCisJCWlmICghZ19hdF9yZXN1bHRf
aXRlcl9uZXh0X251bWJlcigmaXRlciwgJnNmbikpCisJCQlnb3RvIGVycjsKKworCQlpZiAoIWdf
YXRfcmVzdWx0X2l0ZXJfbmV4dF9udW1iZXIoJml0ZXIsICZycykpCisJCQlnb3RvIGVycjsKKwor
CQlpZiAoIWdfYXRfcmVzdWx0X2l0ZXJfbmV4dF9udW1iZXIoJml0ZXIsICZydCkpCisJCQlnb3Rv
IGVycjsKKworCQlEQkcoIlVNVFMgSW5qZWN0IFJlc3BvbnNlOiBzZm4gPSAlZCBycyA9ICVkIHR0
ID0gJWQiLAorCQkJCXNmbiwgcnMsIHJ0KTsKKworCQlyZi51dHJhbl9mcmFtZV9udW1iZXIuc2Zu
ID0gc2ZuOworCQlyZi51dHJhbl9mcmFtZV9udW1iZXIucnJjX3N0YXRlID0gcnM7CisJCXJmLnV0
cmFuX2ZyYW1lX251bWJlci5yb3VuZF90cmlwX3RpbWUgPSBydDsKKwkJcmYucmFkaW9fYWNjZXNz
X3RlY2hub2xvZ3kgPSBSQURJT19BQ0NFU1NfVEVDSE5PTE9HWV9VTVRTOworCisJfSBlbHNlCisJ
CWdvdG8gZXJyOworCisJY2IoJmVycm9yLCAmcmYsIGNiZC0+ZGF0YSk7CisJcmV0dXJuOworCitl
cnI6CisJQ0FMTEJBQ0tfV0lUSF9GQUlMVVJFKGNiLCBOVUxMLCBjYmQtPmRhdGEpOworfQorCitz
dGF0aWMgaW50IGlmeF9hZ3BzX3Byb2JlKHN0cnVjdCBvZm9ub19hZ3BzICphZ3BzLAorCQkJCQl1
bnNpZ25lZCBpbnQgdmVuZG9yLCB2b2lkICpkYXRhKQoreworCUdBdENoYXQgKmNoYXQgPSBkYXRh
OworCXN0cnVjdCBhZ3BzX2RhdGEgKmFnZCA9IG9mb25vX2FncHNfZ2V0X2RhdGEoYWdwcyk7CisK
KwlhZ2QgPSBnX3RyeV9uZXcwKHN0cnVjdCBhZ3BzX2RhdGEsIDEpOworCWlmICghYWdkKQorCQly
ZXR1cm4gLUVOT01FTTsKKworCWFnZC0+Y2hhdCA9IGdfYXRfY2hhdF9jbG9uZShjaGF0KTsKKwlh
Z2QtPnZlbmRvciA9IHZlbmRvcjsKKworCW9mb25vX2FncHNfc2V0X2RhdGEoYWdwcywgYWdkKTsK
KworCWdfYXRfY2hhdF9yZWdpc3RlcihhZ2QtPmNoYXQsICIlJVhQT1NSOiIsIHBvc19yZXF1ZXN0
X25vdGlmeSwgVFJVRSwKKwkJCQlhZ3BzLCBOVUxMKTsKKworCW9mb25vX2FncHNfcmVnaXN0ZXIo
YWdwcyk7CisKKwlyZXR1cm4gMDsKK30KKworc3RhdGljIHZvaWQgaWZ4X2FncHNfcmVtb3ZlKHN0
cnVjdCBvZm9ub19hZ3BzICphZ3BzKQoreworCXN0cnVjdCBhZ3BzX2RhdGEgKmFnZCA9IG9mb25v
X2FncHNfZ2V0X2RhdGEoYWdwcyk7CisKKwlvZm9ub19hZ3BzX3JlbW92ZShhZ3BzKTsKKwlvZm9u
b19hZ3BzX3NldF9kYXRhKGFncHMsIE5VTEwpOworCWdfYXRfY2hhdF91bnJlZihhZ2QtPmNoYXQp
OworCWdfZnJlZShhZ2QpOworfQorCitzdGF0aWMgdm9pZCBpZnhfYWdwc19yZWNlaXZlX2xjc19m
cmFtZV9jYihnYm9vbGVhbiBvaywgR0F0UmVzdWx0ICpyZXN1bHQsCisJCQkJZ3BvaW50ZXIgdXNl
cl9kYXRhKQoreworCXN0cnVjdCBjYl9kYXRhICpjYmQgPSB1c2VyX2RhdGE7CisJb2Zvbm9fYWdw
c19yZWNlaXZlX2xjc19mcmFtZV9jYl90IGNiID0gY2JkLT5jYjsKKwlzdHJ1Y3Qgb2Zvbm9fZXJy
b3IgZXJyb3I7CisKKwlkZWNvZGVfYXRfZXJyb3IoJmVycm9yLCBnX2F0X3Jlc3VsdF9maW5hbF9y
ZXNwb25zZShyZXN1bHQpKTsKKwljYigmZXJyb3IsIGNiZC0+ZGF0YSk7Cit9CisKKyAgIC8qCisJ
KiBUaGUgR1BTIG1hbmFnZXIgY2FuIGVuYWJsZSBvciBkaXNhYmxlIEFHUFMgbWFuYWdlciAgdG8g
cmVjZWl2ZQorCSogbGNzX2ZyYW1lcyBmcm9tIHRoZSBNb2JpbGUgbmV0d29yay4gSWYgZGlzYWJs
ZWQsIGFsbCBBc3Npc3RhbmNlIERhdGEKKwkqIGFuZCBQb3NpdGlvbiBSZXF1ZXN0cyBmcm9tIE1v
YmlsZSBOZXR3b3JrIGFyZSBub3Qgc2lnbmFsbGVkIHRvIG9mb25vLgorCSovCitzdGF0aWMgdm9p
ZCBpZnhfYWdwc19yZWNlaXZlX2xjc19mcmFtZXMoc3RydWN0IG9mb25vX2FncHMgKmFncHMsCisJ
CQlpbnQgZW5hYmxlZCwgb2Zvbm9fYWdwc19yZWNlaXZlX2xjc19mcmFtZV9jYl90IGNiLAorCQkJ
dm9pZCAqdXNlcl9kYXRhKQoreworCXN0cnVjdCBhZ3BzX2RhdGEgKmRhdGEgPSBvZm9ub19hZ3Bz
X2dldF9kYXRhKGFncHMpOworCXN0cnVjdCBjYl9kYXRhICpjYmQgPSBjYl9kYXRhX25ldyhjYiwg
dXNlcl9kYXRhKTsKKwljaGFyICpjb21tYnVmOworCXVuc2lnbmVkIGludCBpZDsKKworCWlmICgh
Y2JkKQorCQlnb3RvIGVycm9yOworCisJY29tbWJ1ZiA9IGdfc3RyZHVwX3ByaW50ZigiQVQlJVhQ
T1M9XCIlZFwiIiwgZW5hYmxlZCk7CisKKwlpZCA9IGdfYXRfY2hhdF9zZW5kKGRhdGEtPmNoYXQs
IGNvbW1idWYsIG5vbmVfcHJlZml4LAorCQkJCWlmeF9hZ3BzX3JlY2VpdmVfbGNzX2ZyYW1lX2Ni
LCBjYmQsIGdfZnJlZSk7CisKKwlnX2ZyZWUoY29tbWJ1Zik7CisKKwlpZiAoaWQgPiAwKQorCQly
ZXR1cm47CitlcnJvcjoKKwlpZiAoY2JkKQorCQlnX2ZyZWUoY2JkKTsKKworCUNBTExCQUNLX1dJ
VEhfRkFJTFVSRShjYiwgdXNlcl9kYXRhKTsKK30KKworc3RhdGljIHZvaWQgaWZ4X2FncHNfc2Vu
ZF9sY3NfZnJhbWVfY2IoZ2Jvb2xlYW4gb2ssIEdBdFJlc3VsdCAqcmVzdWx0LAorCQkJCWdwb2lu
dGVyIHVzZXJfZGF0YSkKK3sKKwlzdHJ1Y3QgY2JfZGF0YSAqY2JkID0gdXNlcl9kYXRhOworCW9m
b25vX2FncHNfc2VuZF9sY3NfZnJhbWVfY2JfdCBjYiA9IGNiZC0+Y2I7CisJc3RydWN0IG9mb25v
X2Vycm9yIGVycm9yOworCisJZGVjb2RlX2F0X2Vycm9yKCZlcnJvciwgZ19hdF9yZXN1bHRfZmlu
YWxfcmVzcG9uc2UocmVzdWx0KSk7CisJY2IoJmVycm9yLCBjYmQtPmRhdGEpOworfQorCisjZGVm
aW5lIEJVRl9MRU4gMTI4CisKKwkvKiBBc3Npc3RhbmNlIERhdGEgYW5kIFBvc2l0aW9uIFJlcXVl
c3RzIGZyb20gdGhlIE1vYmlsZSBOZXR3b3JrIGFyZQorCSAqIHNpZ25hbGxlZCB2aWEgdGhlIG9m
b25vX2FncHNfbGNzX2ZyYW1lX25vdGlmeSBmdW5jdGlvbiBhbmQgdGhlCisJICogb0Zvbm8gY29y
ZSB0byBhbiBleHRlcm5hbCBHUFMgbWFuYWdlci4gVGhpcyBHUFMgbWFuYWdlciBjYW4gcmVwbHkK
KwkgKiB0byBQb3NpdGlvbiBSZXF1ZXN0cyB3aXRoIG9uZSBvciBtb3JlIFBvc2l0aW9uIFJlc3Bv
bnNlcyB3aGljaAorCSAqIGFyZSB0aGVuIHNlbmQgYmFjayB0byB0aGUgbW9kZW0gdmlhIHRoZSBz
ZW5kX2xjc19mcmFtZSBmdW5jdGlvbi4KKwkgKi8KK3N0YXRpYyB2b2lkIGlmeF9hZ3BzX3NlbmRf
bGNzX2ZyYW1lKHN0cnVjdCBvZm9ub19hZ3BzICphZ3BzLAorCQkJCXN0cnVjdCBvZm9ub19sY3Nf
ZnJhbWUgKmZyYW1lLAorCQkJCW9mb25vX2FncHNfc2VuZF9sY3NfZnJhbWVfY2JfdCBjYiwKKwkJ
CQl2b2lkICp1c2VyX2RhdGEpCit7CisJc3RydWN0IGFncHNfZGF0YSAqZGF0YSA9IG9mb25vX2Fn
cHNfZ2V0X2RhdGEoYWdwcyk7CisJc3RydWN0IGNiX2RhdGEgKmNiZCA9IGNiX2RhdGFfbmV3KGNi
LCB1c2VyX2RhdGEpOworCWNoYXIgYnVmW0JVRl9MRU4gKiAyICsgMV07CisJY2hhciAqY29tbWJ1
ZjsKKwl1bnNpZ25lZCBpbnQgaWQ7CisJaW50IGJ1ZmxlbjsKKworCWlmICghY2JkKQorCQlnb3Rv
IGVycm9yOworCisJaWYgKCFmcmFtZS0+ZnJhbWVfbGVuZ3RoKSB7CisJCW9mb25vX2Vycm9yKCJp
ZnhfYWdwc19zZW5kX2xjc19mcmFtZTogRnJhbWUgbGVuZ3RoIEludmFsaWQiKTsKKwkJZ290byBl
cnJvcjsKKwl9CisKKwlpZiAoZnJhbWUtPmZyYW1lX2xlbmd0aCA+IEJVRl9MRU4pIHsKKwkJb2Zv
bm9fZXJyb3IoImlmeF9hZ3BzX3NlbmRfbGNzX2ZyYW1lOiBGcmFtZSBsZW5ndGggdG9vIGxvbmch
Iik7CisJCWdvdG8gZXJyb3I7CisJfQorCisJZW5jb2RlX2hleF9vd25fYnVmKGZyYW1lLT5yYXdf
ZnJhbWUsIGZyYW1lLT5mcmFtZV9sZW5ndGgsIDAsIGJ1Zik7CisJYnVmbGVuID0gc3RybGVuKGJ1
Zik7CisJREJHKCJFbmNvZGVkIEFHUFMgRnJhbWUgPSAlcyAlZCIsIGJ1ZiwgYnVmbGVuKTsKKwor
CWNvbW1idWYgPSBnX3N0cmR1cF9wcmludGYoIkFUJSVYUE9TUj0lZCwlZCxcIiVzXCIiLAorCQkJ
ZnJhbWUtPmxjc19mcmFtZV90eXBlLCBidWZsZW4sIGJ1Zik7CisKKwlpZCA9IGdfYXRfY2hhdF9z
ZW5kKGRhdGEtPmNoYXQsIGNvbW1idWYsIG5vbmVfcHJlZml4LAorCQkJCWlmeF9hZ3BzX3NlbmRf
bGNzX2ZyYW1lX2NiLCBjYmQsIGdfZnJlZSk7CisKKwlnX2ZyZWUoY29tbWJ1Zik7CisKKwlpZiAo
aWQgPiAwKQorCQlyZXR1cm47CitlcnJvcjoKKwlpZiAoY2JkKQorCQlnX2ZyZWUoY2JkKTsKKwor
CUNBTExCQUNLX1dJVEhfRkFJTFVSRShjYiwgdXNlcl9kYXRhKTsKK30KKworc3RhdGljIHZvaWQg
aWZ4X2FncHNfaW5qZWN0X3RpbWVfY2IoZ2Jvb2xlYW4gb2ssIEdBdFJlc3VsdCAqcmVzdWx0LAor
CQkJCWdwb2ludGVyIHVzZXJfZGF0YSkKK3sKKwlzdHJ1Y3QgY2JfZGF0YSAqY2JkID0gdXNlcl9k
YXRhOworCXN0cnVjdCBhZ3BzX2RhdGEgKmRhdGEgPSBjYmQtPnVzZXI7CisJb2Zvbm9fYWdwc19p
bmplY3RfdGltZV9jYl90IGNiID0gY2JkLT5jYjsKKwlzdHJ1Y3Qgb2Zvbm9fZXJyb3IgZXJyb3I7
CisKKwlkZWNvZGVfYXRfZXJyb3IoJmVycm9yLCBnX2F0X3Jlc3VsdF9maW5hbF9yZXNwb25zZShy
ZXN1bHQpKTsKKworCWlmICghb2spCisJCWdvdG8gZXJyOworCisJZ19hdF9jaGF0X3JlZ2lzdGVy
KGFnZC0+Y2hhdCwgIiUlWEZUSToiLAorCQkJCQlpbmpfdGltZV9ub3RpZnksIEZBTFNFLAorCQkJ
CQlkYXRhLCBnX2ZyZWUpOworCXJldHVybjsKKworZXJyOgorCWNiKCZlcnJvciwgTlVMTCwgY2Jk
LT5kYXRhKTsKKwlnX2ZyZWUoY2JkKTsKK30KKworCS8qIFRoZSBHUFMgbWFuYWdlciBjYW4gYXNr
IHRoZSBtb2RlbSB0byBnZW5lcmF0ZSBhIEhXIHB1bHNlICh0aW1lCisJICogc3RhbXApIHdpdGgg
YSBkZWZpbmVkIGxlbmd0aCBhbmQgdGhlIG1vZGVtIHJlcGxpZXMgaW5kaWNhdGVzIHdoZW4KKwkg
KiBpdCBnZW5lcmF0ZXMgdGhlIHB1bHNlLiBCdXQgYXMgdGhlIG1vZGVtIGhhcyBubyBwcmVjaXNl
IGlkYWUgb2YKKwkgKiBVbml2ZXJzYWwgVGltZSwgaXQgaW5kaWNhdGVzIGF0IHdoaWNoIHJhZGlv
IGZyYW1lIG51bWJlciBpdGdjCisJICogZ2VuZXJhdGVkIHRoZSBwdWxzZS4gVGhlIEdQUyBtYW5h
Z2VyIHdoaWNoIGtub3dzIHRoZSBsaW5rIGJldHdlZW4KKwkgKiBVbml2ZXJzYWwgVGltZSBhbmQg
dGhlIFJhZGlvIEZyYW1lIG51bWJlciBrbm93cyB2ZXJ5IHByZWNpc2VseSBhdAorCSAqIHdoYXQg
dGltZSB0aGUgcHVsc2Ugd2FzIGdlbmVyYXRlZCBhbmQgaXRzIGR1cmF0aW9uLgorCSAqCisJICog
VGltaW5nIGFjY3VyYWN5IGlzIHR5cGljYWxseSBhIGZldyBtaWNyb3NlY29uZHMuCisJICovCitz
dGF0aWMgdm9pZCBpZnhfYWdwc19pbmplY3RfdGltZShzdHJ1Y3Qgb2Zvbm9fYWdwcyAqYWdwcywK
KwkJCWludCByYWRpb19hY2Nlc3NfdGVjaG5vbG9neSwvKiBlbnVtIGFjY2Vzc190ZWNobm9sb2d5
ICovCisJCQlpbnQgcHVsc2VfbGVuZ3RoLC8qIGR1cmF0aW9uIG9mIHB1bHNlIGluIHJhZGlvIHNs
b3RzICovCisJCQlvZm9ub19hZ3BzX2luamVjdF90aW1lX2NiX3QgY2IsIHZvaWQgKnVzZXJfZGF0
YSkKK3sKKwlzdHJ1Y3QgYWdwc19kYXRhICpkYXRhID0gb2Zvbm9fYWdwc19nZXRfZGF0YShhZ3Bz
KTsKKwlzdHJ1Y3QgY2JfZGF0YSAqY2JkID0gY2JfZGF0YV9uZXcoY2IsIHVzZXJfZGF0YSk7CisJ
Y2hhciAqYnVmOworCXVuc2lnbmVkIGludCBpZDsKKworCWlmICghY2JkKQorCQlnb3RvIGVycm9y
OworCisJY2JkLT51c2VyID0gZGF0YTsKKworCWlmIChyYWRpb19hY2Nlc3NfdGVjaG5vbG9neSA9
PSBSQURJT19BQ0NFU1NfVEVDSE5PTE9HWV9HU00pIHsKKwkJZGF0YS0+cmFkX2FjY190ZWNoID0g
cmFkaW9fYWNjZXNzX3RlY2hub2xvZ3k7CisJCWJ1ZiA9IGdfc3RyZHVwX3ByaW50ZigiQVQlJVhG
VEk9XCIlcyVkXCIiLCAiR1NNIiwKKwkJCQkJCXB1bHNlX2xlbmd0aCk7CisKKwl9IGVsc2UgaWYg
KHJhZGlvX2FjY2Vzc190ZWNobm9sb2d5ID09IFJBRElPX0FDQ0VTU19URUNITk9MT0dZX1VNVFMp
IHsKKwkJCWRhdGEtPnJhZF9hY2NfdGVjaCA9IHJhZGlvX2FjY2Vzc190ZWNobm9sb2d5OworCQkJ
YnVmID0gZ19zdHJkdXBfcHJpbnRmKCJBVCUlWEZUST1cIiVzJWRcIiIsICJVTVRTIiwKKwkJCQkJ
CXB1bHNlX2xlbmd0aCk7CisJfSBlbHNlCisJCWdvdG8gZXJyb3I7CisKKwlpZCA9IGdfYXRfY2hh
dF9zZW5kKGRhdGEtPmNoYXQsIGJ1Ziwgbm9uZV9wcmVmaXgsCisJCSAgICBpZnhfYWdwc19pbmpl
Y3RfdGltZV9jYiwgY2JkLCBnX2ZyZWUpOworCisJZ19mcmVlKGJ1Zik7CisKKwlpZiAoaWQgPiAw
KQorCQlyZXR1cm47CisKK2Vycm9yOgorCWlmIChjYmQpCisJCWdfZnJlZShjYmQpOworCisJQ0FM
TEJBQ0tfV0lUSF9GQUlMVVJFKGNiLCBOVUxMLCB1c2VyX2RhdGEpOworfQorCitzdGF0aWMgc3Ry
dWN0IG9mb25vX2FncHNfZHJpdmVyIGRyaXZlciA9IHsKKwkubmFtZQkJCQk9ICJpZnhtb2RlbSIs
CisJLnByb2JlCQkJCT0gaWZ4X2FncHNfcHJvYmUsCisJLnJlbW92ZQkJCQk9IGlmeF9hZ3BzX3Jl
bW92ZSwKKwkucmVjZWl2ZV9sY3NfZnJhbWVzCQk9IGlmeF9hZ3BzX3JlY2VpdmVfbGNzX2ZyYW1l
cywKKwkuc2VuZF9sY3NfZnJhbWUJCQk9IGlmeF9hZ3BzX3NlbmRfbGNzX2ZyYW1lLAorCS5pbmpl
Y3RfdGltZQkJCT0gaWZ4X2FncHNfaW5qZWN0X3RpbWUKK307CisKK3ZvaWQgaWZ4X2FncHNfaW5p
dCgpCit7CisJb2Zvbm9fYWdwc19kcml2ZXJfcmVnaXN0ZXIoJmRyaXZlcik7Cit9CisKK3ZvaWQg
aWZ4X2FncHNfZXhpdCgpCit7CisJb2Zvbm9fYWdwc19kcml2ZXJfdW5yZWdpc3RlcigmZHJpdmVy
KTsKK30KKwpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9hZ3BzLmggYi9pbmNsdWRlL2FncHMuaApuZXcg
ZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwLi41NGY5YjUzCi0tLSAvZGV2L251bGwKKysr
IGIvaW5jbHVkZS9hZ3BzLmgKQEAgLTAsMCArMSwxNTcgQEAKKy8qCisgKgorICogIG9Gb25vIC0g
T3BlbiBTb3VyY2UgVGVsZXBob255CisgKgorICogIENvcHlyaWdodCAoQykgMjAwOC0yMDEwICBJ
bnRlbCBDb3Jwb3JhdGlvbi4gQWxsIHJpZ2h0cyByZXNlcnZlZC4KKyAqCisgKiAgVGhpcyBwcm9n
cmFtIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2Rp
ZnkKKyAqICBpdCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNl
bnNlIHZlcnNpb24gMiBhcworICogIHB1Ymxpc2hlZCBieSB0aGUgRnJlZSBTb2Z0d2FyZSBGb3Vu
ZGF0aW9uLgorICoKKyAqICBUaGlzIHByb2dyYW0gaXMgZGlzdHJpYnV0ZWQgaW4gdGhlIGhvcGUg
dGhhdCBpdCB3aWxsIGJlIHVzZWZ1bCwKKyAqICBidXQgV0lUSE9VVCBBTlkgV0FSUkFOVFk7IHdp
dGhvdXQgZXZlbiB0aGUgaW1wbGllZCB3YXJyYW50eSBvZgorICogIE1FUkNIQU5UQUJJTElUWSBv
ciBGSVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9TRS4gIFNlZSB0aGUKKyAqICBHTlUgR2Vu
ZXJhbCBQdWJsaWMgTGljZW5zZSBmb3IgbW9yZSBkZXRhaWxzLgorICoKKyAqICBZb3Ugc2hvdWxk
IGhhdmUgcmVjZWl2ZWQgYSBjb3B5IG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZQor
ICogIGFsb25nIHdpdGggdGhpcyBwcm9ncmFtOyBpZiBub3QsIHdyaXRlIHRvIHRoZSBGcmVlIFNv
ZnR3YXJlCisgKiAgRm91bmRhdGlvbiwgSW5jLiwgNTEgRnJhbmtsaW4gU3QsIEZpZnRoIEZsb29y
LCBCb3N0b24sIE1BICAwMjExMC0xMzAxICBVU0EKKyAqCisgKi8KKworI2lmbmRlZiBfX09GT05P
X0FHUFNfSF8KKyNkZWZpbmUgX19PRk9OT19BR1BTX0hfCisKKyNpZmRlZiBfX2NwbHVzcGx1cwor
ZXh0ZXJuICJDIiB7CisjZW5kaWYKKworI2luY2x1ZGUgPG9mb25vL3R5cGVzLmg+CisKK2VudW0g
b2Zvbm9fbGNzX2ZyYW1lX3R5cGUgeworCVJSTFBfQVNTSVNUQU5DRV9EQVRBID0gMCwJCS8qIGZy
b20gbW9kZW0gKi8KKwkvKiBQb3NpdGlvbiByZXF1ZXN0IGNhbiBpbmNsdWRlIGFzc2lzdGFuY2Ug
ZGF0YSBhcyB3ZWxsICovCisJUlJMUF9NRUFTVVJFX1BPU0lUSU9OX1JFUVVFU1QgPSAxLAkvKiBm
cm9tIG1vZGVtICovCisJUlJMUF9NRUFTVVJFX1BPU0lUSU9OX1JFU1BPTlNFID0gMiwJLyogZnJv
bSBHUFMgKi8KKwlSUkNfQVNTSVNUQU5DRV9EQVRBX0RFTElWRVJZID0gMywJLyogZnJvbSBtb2Rl
bSAqLworCS8qIE1lYXN1cmVtZW50IGNvbnRyb2wgY2FuIGluY2x1ZGUgYXNzaXN0YW5jZSBkYXRh
IGFzIHdlbGwgKi8KKwlSUkNfTUVBU1VSRU1FTlRfQ09OVFJPTCA9IDQsCQkvKiBmcm9tIG1vZGVt
ICovCisJUlJDX01FQVNVUkVNRU5UX1JFUE9SVCA9IDUsCQkvKiBmcm9tIEdQUyAqLworfTsKKwor
ZW51bSBvZm9ub19hY2Nlc3NfdGVjaG5vbG9neSB7CisJUkFESU9fQUNDRVNTX1RFQ0hOT0xPR1lf
R1NNID0gMCwJCS8qIEdTTSAqLworCVJBRElPX0FDQ0VTU19URUNITk9MT0dZX1VNVFMgPSAxLAkJ
LyogVU1UUyAqLworfTsKKworZW51bSBvZm9ub19ycmNfc3RhdGUgeworCVJSQ19DRUxMX1BDSCA9
IDAsCisJUlJDX0NFTExfRkFDSCA9IDEsCisJUlJDX0NFTExfRENIID0gMiwKKwlSUkNfVVJBX1BD
SCA9IDMsCit9OworCitzdHJ1Y3Qgb2Zvbm9fbGNzX2ZyYW1lIHsKKwllbnVtIG9mb25vX2xjc19m
cmFtZV90eXBlIGxjc19mcmFtZV90eXBlOworCWludCBmcmFtZV9sZW5ndGg7CS8qIHNpemUgb2Yg
cmF3X2ZyYW1lIGluIGJ5dGVzICovCisJdW5zaWduZWQgY2hhciAgKnJhd19mcmFtZTsKK307CisK
K3N0cnVjdCBvZm9ub19sY3NfZ3NtX2ZuIHsKKwlpbnQgVERNQV9mcmFtZV9udW1iZXI7CS8qIHJh
bmdlIDAgLSAyNzE1NjQ3ICgyMDQ4KjI2KjUxKSAqLworCWludCBURE1BX3RpbWVzbG90OwkJLyog
cmFuZ2UgMCAtIDcgKi8KKwlpbnQgdGltZXNsb3RfYml0OwkJLyogcmFuZ2UgMCAtIDE1NiAqLwor
CWludCB0aW1pbmdfYWR2YW5jZTsJCS8qIHJhbmdlIDAgLSA2MyAqLworCWludCBiY2NoX2FyZmNu
OwkJCS8qIHJhbmdlIDAgLSAxMDIzICovCisJaW50IGJzaWM7CQkJCS8qIHJhbmdlIDAgLSA2NCAq
LworfTsKKworc3RydWN0IG9mb25vX2xjc191dHJhbl9mbiB7CisJaW50IHNmbjsJCQkJLyogcmFu
Z2UgMCAtIDQwOTUgKi8KKwlpbnQgcnJjX3N0YXRlOwkJCS8qIGVudW0gb2Zvbm9fcnJjX3N0YXRl
ICovCisJaW50IHJvdW5kX3RyaXBfdGltZTsJLyogcmFuZ2UgMCAtIDMyNzY2ICovCit9OworCitz
dHJ1Y3Qgb2Zvbm9fbGNzX3JhZGlvX2ZuIHsKKwlpbnQgcmFkaW9fYWNjZXNzX3RlY2hub2xvZ3k7
IC8qIGVudW0gYWNjZXNzX3RlY2hub2xvZ3kgKi8KKwl1bmlvbiB7CisJCXN0cnVjdCBvZm9ub19s
Y3NfZ3NtX2ZuCQlnc21fZnJhbWVfbnVtYmVyOworCQlzdHJ1Y3Qgb2Zvbm9fbGNzX3V0cmFuX2Zu
CXV0cmFuX2ZyYW1lX251bWJlcjsKKwl9OworfTsKKworc3RydWN0IG9mb25vX2FncHM7CisKK3R5
cGVkZWYgdm9pZCAoKm9mb25vX2FncHNfc2VuZF9sY3NfZnJhbWVfY2JfdCkoY29uc3Qgc3RydWN0
IG9mb25vX2Vycm9yICplcnJvciwKKwkJCQl2b2lkICpkYXRhKTsKK3R5cGVkZWYgdm9pZCAoKm9m
b25vX2FncHNfcmVjZWl2ZV9sY3NfZnJhbWVfY2JfdCkoCisJCQkJY29uc3Qgc3RydWN0IG9mb25v
X2Vycm9yICplcnJvciwKKwkJCQl2b2lkICpkYXRhKTsKK3R5cGVkZWYgdm9pZCAoKm9mb25vX2Fn
cHNfaW5qZWN0X3RpbWVfY2JfdCkoY29uc3Qgc3RydWN0IG9mb25vX2Vycm9yICplcnJvciwKKwkJ
CQlzdHJ1Y3Qgb2Zvbm9fbGNzX3JhZGlvX2ZuICpyYWRpb19mcmFtZV9udW1iZXIsCisJCQkJdm9p
ZCAqZGF0YSk7CisKKwkvKgorCSAqIEFHUFMgcmVsYXRlZCBmdW5jdGlvbnMsIGluY2x1ZGluZyBM
Q1MgZnJhbWUgZm9yd2FyZGluZyBhbmQKKwkgKiBmaW5lIHRpbWUgaW5qZWN0aW9uCisJICovCitz
dHJ1Y3Qgb2Zvbm9fYWdwc19kcml2ZXIgeworCWNvbnN0IGNoYXIgKm5hbWU7CisJaW50ICgqcHJv
YmUpKHN0cnVjdCBvZm9ub19hZ3BzICphZ3BzLCB1bnNpZ25lZCBpbnQgdmVuZG9yLAorCQkJdm9p
ZCAqZGF0YSk7CisJdm9pZCAoKnJlbW92ZSkoc3RydWN0IG9mb25vX2FncHMgKmFncHMpOworCisJ
LyogVGhlIEdQUyBtYW5hZ2VyIGNhbiBjb25maWd1cmUgdGhlIG1vZGVtIHRvIG5vdGlmeSBBc3Np
c3RhbmNlIERhdGEgYW5kCisJICogUG9zaXRpb24gUmVxdWVzdHMgZnJvbSB0aGUgTW9iaWxlIE5l
dHdvcmsgYnkgc2V0dGluZyB0aGUgTGNzRW5hYmxlZAorCSAqIHN0YXR1cyB0byB0cnVlLiBJZiBm
YWxzZSwgbm8gbm90aWZpY2F0aW9ucyBhcmUgc2VudCBmcm9tIG1vZGVtLgorCSAqLworCXZvaWQg
KCpyZWNlaXZlX2xjc19mcmFtZXMpKHN0cnVjdCBvZm9ub19hZ3BzICphZ3BzLCBpbnQgZW5hYmxl
ZCwKKwkJCW9mb25vX2FncHNfcmVjZWl2ZV9sY3NfZnJhbWVfY2JfdCBjYiwgdm9pZCAqZGF0YSk7
CisKKwkvKiBBc3Npc3RhbmNlIERhdGEgYW5kIFBvc2l0aW9uIFJlcXVlc3RzIGZyb20gdGhlIE1v
YmlsZSBOZXR3b3JrIGFyZQorCSAqIHNpZ25hbGxlZCB2aWEgdGhlIG9mb25vX2FncHNfbGNzX2Zy
YW1lX25vdGlmeSBmdW5jdGlvbiBhbmQgdGhlCisJICogb0Zvbm8gY29yZSB0byBhbiBleHRlcm5h
bCBHUFMgbWFuYWdlci4gVGhpcyBHUFMgbWFuYWdlciBjYW4gcmVwbHkKKwkgKiB0byBQb3NpdGlv
biBSZXF1ZXN0cyB3aXRoIG9uZSBvciBtb3JlIFBvc2l0aW9uIFJlc3BvbnNlcyB3aGljaAorCSAq
IGFyZSB0aGVuIHNlbmQgYmFjayB0byB0aGUgbW9kZW0gdmlhIHRoZSBzZW5kX2xjc19mcmFtZSBm
dW5jdGlvbi4KKwkgKi8KKwl2b2lkICgqc2VuZF9sY3NfZnJhbWUpKHN0cnVjdCBvZm9ub19hZ3Bz
ICphZ3BzLAorCQkJc3RydWN0IG9mb25vX2xjc19mcmFtZSAqZnJhbWUsCisJCQlvZm9ub19hZ3Bz
X3NlbmRfbGNzX2ZyYW1lX2NiX3QgY2IsIHZvaWQgKmRhdGEpOworCisJLyogVGhlIEdQUyBtYW5h
Z2VyIGNhbiBhc2sgdGhlIG1vZGVtIHRvIGdlbmVyYXRlIGEgSFcgcHVsc2UgKHRpbWUKKwkgKiBz
dGFtcCkgd2l0aCBhIGRlZmluZWQgbGVuZ3RoIGFuZCB0aGUgbW9kZW0gcmVwbGllcyBpbmRpY2F0
ZXMgd2hlbgorCSAqIGl0IGdlbmVyYXRlcyB0aGUgcHVsc2UuIEJ1dCBhcyB0aGUgbW9kZW0gaGFz
IG5vIHByZWNpc2UgaWRlYSBvZgorCSAqIFVuaXZlcnNhbCBUaW1lLCBpdCBpbmRpY2F0ZXMgYXQg
d2hpY2ggcmFkaW8gZnJhbWUgbnVtYmVyIGl0CisJICogZ2VuZXJhdGVkIHRoZSBwdWxzZS4gVGhl
IEdQUyBtYW5hZ2VyIHdoaWNoIGtub3dzIHRoZSBsaW5rIGJldHdlZW4KKwkgKiBVbml2ZXJzYWwg
VGltZSBhbmQgdGhlIFJhZGlvIEZyYW1lIG51bWJlciBrbm93cyB2ZXJ5IHByZWNpc2VseSBhdAor
CSAqIHdoYXQgdGltZSB0aGUgcHVsc2Ugd2FzIGdlbmVyYXRlZCBhbmQgaXRzIGR1cmF0aW9uLgor
CSAqCisJICogVGltaW5nIGFjY3VyYWN5IGlzIHR5cGljYWxseSBhIGZldyBtaWNyb3NlY29uZHMu
CisJICovCisJdm9pZCAoKmluamVjdF90aW1lKShzdHJ1Y3Qgb2Zvbm9fYWdwcyAqYWdwcywKKwlp
bnQgcmFkaW9fYWNjZXNzX3RlY2hub2xvZ3ksIC8qIGVudW0gYWNjZXNzX3RlY2hub2xvZ3kgKi8K
KwlpbnQgcHVsc2VfbGVuZ3RoLCAvKiBkdXJhdGlvbiBvZiBwdWxzZSBpbiByYWRpbyBzbG90cyAq
LworCW9mb25vX2FncHNfaW5qZWN0X3RpbWVfY2JfdCBjYiwgdm9pZCAqZGF0YSk7Cit9OworCitp
bnQgb2Zvbm9fYWdwc19kcml2ZXJfcmVnaXN0ZXIoY29uc3Qgc3RydWN0IG9mb25vX2FncHNfZHJp
dmVyICpkKTsKK3ZvaWQgb2Zvbm9fYWdwc19kcml2ZXJfdW5yZWdpc3Rlcihjb25zdCBzdHJ1Y3Qg
b2Zvbm9fYWdwc19kcml2ZXIgKmQpOworCitzdHJ1Y3Qgb2Zvbm9fYWdwcyAqb2Zvbm9fYWdwc19j
cmVhdGUoc3RydWN0IG9mb25vX21vZGVtICptb2RlbSwKKwkJCQkJdW5zaWduZWQgaW50IHZlbmRv
ciwgY29uc3QgY2hhciAqZHJpdmVyLAorCQkJCQl2b2lkICpkYXRhKTsKKwordm9pZCBvZm9ub19h
Z3BzX3JlZ2lzdGVyKHN0cnVjdCBvZm9ub19hZ3BzICphZ3BzKTsKK3ZvaWQgb2Zvbm9fYWdwc19y
ZW1vdmUoc3RydWN0IG9mb25vX2FncHMgKmFncHMpOworCit2b2lkIG9mb25vX2FncHNfc2V0X2Rh
dGEoc3RydWN0IG9mb25vX2FncHMgKmFncHMsIHZvaWQgKmRhdGEpOwordm9pZCAqb2Zvbm9fYWdw
c19nZXRfZGF0YShzdHJ1Y3Qgb2Zvbm9fYWdwcyAqYWdwcyk7CisKK3ZvaWQgb2Zvbm9fYWdwc19s
Y3NfZnJhbWVfbm90aWZ5KHN0cnVjdCBvZm9ub19hZ3BzICphZ3BzLAorCQkJc3RydWN0IG9mb25v
X2xjc19mcmFtZSBmcmFtZSk7CisKKyNpZmRlZiBfX2NwbHVzcGx1cworfQorI2VuZGlmCisKKyNl
bmRpZiAvKiBfX09GT05PX0FHUFNfSCAqLwotLSAKMS43LjAuNAoK

--===============5274278591985854036==--

