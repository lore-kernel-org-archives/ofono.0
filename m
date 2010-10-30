Content-Type: multipart/mixed; boundary="===============4338460350675608899=="
MIME-Version: 1.0
From: Benis, Robertino <robertino.benis@intel.com>
Subject: Infineon modem API to support aGPS
Date: Fri, 29 Oct 2010 20:43:05 -0700
Message-ID: <CB28AA307186A940B1253A743EA1F20AA58B8B16@orsmsx507.amr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4338460350675608899==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi

This is the first attempt to add aGPS support for Infineon modem. Patch
contains modem API per Waldo's RFC and suggestions.

DBUS API in ofono core are just place holders (not implemented), in this pa=
tch.

Thanks
-- r.

From fab1feadc9c9cf384aa42404bfba307c86f598db Mon Sep 17 00:00:00 2001
From: Robertino Benis <robertino.benis@intel.com>
Date: Fri, 29 Oct 2010 20:10:06 -0700
Subject: [CHANGE] Added aGPS Modem API implementation for Infineon modem
Organization: Intel
Cc: robertino.benis(a)intel.com

---
 Makefile.am                 |    7 +-
 drivers/ifxmodem/agps.c     |  418 +++++++++++++++++++++++++++++++++++++++=
++++
 drivers/ifxmodem/ifxmodem.c |    2 +
 drivers/ifxmodem/ifxmodem.h |    3 +
 include/agps.h              |  159 ++++++++++++++++
 include/dbus.h              |    1 +
 plugins/ifx.c               |   12 +-
 src/agps.c                  |  229 +++++++++++++++++++++++
 src/ofono.h                 |    2 +
 9 files changed, 827 insertions(+), 6 deletions(-)
 create mode 100644 drivers/ifxmodem/agps.c
 create mode 100644 include/agps.h
 create mode 100644 src/agps.c

diff --git a/Makefile.am b/Makefile.am
index 2562160..6ec4761 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -13,7 +13,7 @@ include_HEADERS =3D include/log.h include/plugin.h includ=
e/history.h \
                        include/cbs.h include/call-volume.h \
                        include/gprs.h include/gprs-context.h \
                        include/radio-settings.h include/stk.h \
-                       include/audio-settings.h include/nettime.h
+                       include/audio-settings.h include/nettime.h include/=
agps.h

 nodist_include_HEADERS =3D include/version.h

@@ -218,7 +218,8 @@ builtin_sources +=3D drivers/atmodem/atutil.h \
                        drivers/ifxmodem/audio-settings.c \
                        drivers/ifxmodem/radio-settings.c \
                        drivers/ifxmodem/gprs-context.c \
-                       drivers/ifxmodem/stk.c
+                       drivers/ifxmodem/stk.c \
+                       drivers/ifxmodem/agps.c

 builtin_modules +=3D stemodem
 builtin_sources +=3D drivers/atmodem/atutil.h \
@@ -315,7 +316,7 @@ src_ofonod_SOURCES =3D $(gdbus_sources) $(builtin_sourc=
es) src/ofono.ver \
                        src/gprs.c src/idmap.h src/idmap.c \
                        src/radio-settings.c src/stkutil.h src/stkutil.c \
                        src/nettime.c src/stkagent.c src/stkagent.h \
-                       src/simfs.c src/simfs.h src/audio-settings.c
+                       src/simfs.c src/simfs.h src/audio-settings.c src/ag=
ps.c

 src_ofonod_LDADD =3D $(builtin_libadd) @GLIB_LIBS@ @DBUS_LIBS@ @CAPNG_LIBS=
@ -ldl

diff --git a/drivers/ifxmodem/agps.c b/drivers/ifxmodem/agps.c
new file mode 100644
index 0000000..202795e
--- /dev/null
+++ b/drivers/ifxmodem/agps.c
@@ -0,0 +1,418 @@
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
+#include <gisi/client.h>
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
+       unsigned char frame[FRAME_LEN]; /* TODO - Length TBD */
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
+               ofono_error("Got POS request message more than maximum buff=
er size!");
+               return;
+       }
+
+       messageframe =3D g_at_result_pdu(result);
+
+       if (strlen(messageframe) > sizeof(frame) * 2) { /* Hex, 2 chars / b=
yte */
+               ofono_error("Message frame too long!");
+                return;
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
+       ofono_agps_set_data(agps, NULL);
+       g_at_chat_unref(agd->chat);
+       g_free(agd);
+}
+
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
+       GAtResultIter iter;
+       struct ofono_error error;
+       struct ofono_lcs_radio_fn rf;
+       struct cb_data *cbd =3D user_data;
+       struct agps_data *data =3D cbd->user;
+       ofono_agps_inject_time_cb_t cb =3D cbd->cb;
+
+       decode_at_error(&error, g_at_result_final_response(result));
+
+       if (!ok) {
+               cb(&error, NULL, cbd->data);
+               return;
+       }
+
+       if (!g_at_result_iter_next(&iter, "%%XFTI:"))
+               goto err;
+
+       if (RADIO_ACCESS_TECHNOLOGY_GSM =3D=3D data->rad_acc_tech) {
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
+       } else if (RADIO_ACCESS_TECHNOLOGY_UMTS =3D=3D data->rad_acc_tech) {
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
+               return;
+
+err:
+       CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
+}
+
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
+       if (RADIO_ACCESS_TECHNOLOGY_GSM =3D=3D radio_access_technology) {
+               data->rad_acc_tech =3D radio_access_technology;
+               buf =3D g_strdup_printf("AT%%XFTI=3D\"%s%d\"", "GSM",
+                                               pulse_length);
+
+       } else if (RADIO_ACCESS_TECHNOLOGY_UMTS =3D=3D radio_access_technol=
ogy) {
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
+       .name                                       =3D "ifxmodem",
+       .probe                                      =3D ifx_agps_probe,
+       .remove                                     =3D ifx_agps_remove,
+       .receive_lcs_frames                     =3D ifx_agps_receive_lcs_fr=
ames,
+       .send_lcs_frame                         =3D ifx_agps_send_lcs_frame,
+       .inject_time                            =3D ifx_agps_inject_time
+};
+
+void ifx_agps_init()
+{
+       ofono_agps_driver_register(&driver);
+       DBG("ifx_agps_init: ..");
+}
+
+void ifx_agps_exit()
+{
+       ofono_agps_driver_unregister(&driver);
+       DBG("ifx_agps_exit: ..");
+}
+
diff --git a/drivers/ifxmodem/ifxmodem.c b/drivers/ifxmodem/ifxmodem.c
index 8a9ac8f..2a2a273 100644
--- a/drivers/ifxmodem/ifxmodem.c
+++ b/drivers/ifxmodem/ifxmodem.c
@@ -39,12 +39,14 @@ static int ifxmodem_init(void)
        ifx_radio_settings_init();
        ifx_gprs_context_init();
        ifx_stk_init();
+       ifx_agps_init();

        return 0;
 }

 static void ifxmodem_exit(void)
 {
+       ifx_agps_exit();
        ifx_stk_exit();
        ifx_gprs_context_exit();
        ifx_radio_settings_exit();
diff --git a/drivers/ifxmodem/ifxmodem.h b/drivers/ifxmodem/ifxmodem.h
index 8ea52e5..e5accc2 100644
--- a/drivers/ifxmodem/ifxmodem.h
+++ b/drivers/ifxmodem/ifxmodem.h
@@ -35,3 +35,6 @@ extern void ifx_gprs_context_exit();

 extern void ifx_stk_init();
 extern void ifx_stk_exit();
+
+extern void ifx_agps_init();
+extern void ifx_agps_exit();
diff --git a/include/agps.h b/include/agps.h
new file mode 100644
index 0000000..7188eef
--- /dev/null
+++ b/include/agps.h
@@ -0,0 +1,159 @@
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
+#include <glib.h>
+#include <gdbus.h>
+#include <ofono/modem.h>
+
+#include "gatchat.h"
+#include "gatresult.h"
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
+       * AGPS related functions, including LCS frame forwarding and
+       * fine time injection
+       */
+struct ofono_agps_driver {
+       const char *name;
+       int (*probe)(struct ofono_agps *agps, unsigned int vendor,
+                       void *data);
+       void (*remove)(struct ofono_agps *agps);
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
diff --git a/include/dbus.h b/include/dbus.h
index 59b2aae..c40ce8a 100644
--- a/include/dbus.h
+++ b/include/dbus.h
@@ -53,6 +53,7 @@ extern "C" {
 #define OFONO_VOICECALL_MANAGER_INTERFACE "org.ofono.VoiceCallManager"
 #define OFONO_STK_INTERFACE OFONO_SERVICE ".SimToolkit"
 #define OFONO_SIM_APP_INTERFACE OFONO_SERVICE ".SimToolkitAgent"
+#define OFONO_AGPS_MANAGER_INTERFACE "org.ofono.AgpsManager"

 /* Essentially a{sv} */
 #define OFONO_PROPERTIES_ARRAY_SIGNATURE DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STR=
ING \
diff --git a/plugins/ifx.c b/plugins/ifx.c
index 037273a..3d26b4d 100644
--- a/plugins/ifx.c
+++ b/plugins/ifx.c
@@ -57,12 +57,13 @@
 #include <ofono/radio-settings.h>
 #include <ofono/audio-settings.h>
 #include <ofono/stk.h>
+#include <ofono/agps.h>
 #include <ofono/log.h>

 #include <drivers/atmodem/atutil.h>
 #include <drivers/atmodem/vendor.h>

-#define NUM_DLC  6
+#define NUM_DLC  7

 #define VOICE_DLC   0
 #define NETREG_DLC  1
@@ -70,13 +71,16 @@
 #define GPRS2_DLC   3
 #define GPRS3_DLC   4
 #define AUX_DLC     5
+#define AGPS_DLC    6

 static char *dlc_prefixes[NUM_DLC] =3D { "Voice: ", "Net: ", "GPRS1: ",
-                                       "GPRS2: ", "GPRS3: ", "Aux: " };
+                                       "GPRS2: ", "GPRS3: ",
+                                       "Aux: ",  "AGPS: " };

 static const char *dlc_nodes[NUM_DLC] =3D { "/dev/ttyGSM1", "/dev/ttyGSM2",
                                        "/dev/ttyGSM3", "/dev/ttyGSM4",
-                                       "/dev/ttyGSM5", "/dev/ttyGSM6" };
+                                       "/dev/ttyGSM5", "/dev/ttyGSM6",
+                                       "/dev/ttyGSM7"};

 static const char *none_prefix[] =3D { NULL };
 static const char *xdrv_prefix[] =3D { "+XDRV:", NULL };
@@ -754,6 +758,8 @@ static void ifx_post_online(struct ofono_modem *modem)
                                        "ifxmodem", data->dlcs[GPRS3_DLC]);
                if (gc)
                        ofono_gprs_add_context(gprs, gc);
+
+               ofono_agps_create(modem, 0, "ifxmodem", data->dlcs[AGPS_DLC=
]);
        }
 }

diff --git a/src/agps.c b/src/agps.c
new file mode 100644
index 0000000..516dddc
--- /dev/null
+++ b/src/agps.c
@@ -0,0 +1,229 @@
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
+#include <string.h>
+#include <stdio.h>
+#include <time.h>
+#include <errno.h>
+
+#include <glib.h>
+#include <gdbus.h>
+
+#include <ofono/log.h>
+#include <ofono/dbus.h>
+#include <ofono/modem.h>
+
+#include "ofono.h"
+#include "common.h"
+#include "util.h"
+
+static GSList *g_drivers;
+
+struct ofono_agps {
+       const struct ofono_agps_driver *driver;
+       void *driver_data;
+       struct ofono_atom *atom;
+       gboolean lcs_enabled;
+       gboolean lcs_enabled_pending;
+       DBusMessage *pending;
+       enum ofono_access_technology access_tech;
+       /*TODO - Implement  code here  */
+};
+
+static DBusMessage *agps_get_properties(DBusConnection *conn,
+                                               DBusMessage *msg, void *dat=
a)
+{
+       /* TODO - Implement  code here  */
+       return msg;
+}
+
+static DBusMessage *agps_set_property(DBusConnection *conn, DBusMessage *m=
sg,
+                                       void *data)
+{
+       /* TODO - Implement  code here  */
+       return msg;
+}
+
+static DBusMessage *agps_send_lcs_frame(DBusConnection *conn, DBusMessage =
*msg,
+                                       void *data)
+{
+       /* TODO - Implement  code here  */
+       return msg;
+}
+
+static DBusMessage *agps_request_fine_time_injection(DBusConnection *conn,
+                                                       DBusMessage *msg,
+                                                       void *data)
+{
+       /* TODO - Implement  code here  */
+       return msg;
+}
+
+static GDBusMethodTable agps_methods[] =3D {
+       { "GetProperties", "",  "a{sv}", agps_get_properties },
+       { "SetProperty", "sv",  "", agps_set_property },
+       { "SendLCSFrame", "sv", "", agps_send_lcs_frame },
+       { "RequestFineTimeInjection", "sv",     "",
+               agps_request_fine_time_injection },
+       { }
+};
+
+static GDBusSignalTable agps_signals[] =3D {
+       { "PropertyChanged",                            "sv" },
+       { "IncomingLCSFrame",                           "sq" },
+       { "FineTimeInjectionNotification",      "sq" },
+
+       { }
+};
+
+static void agps_unregister(struct ofono_atom *atom)
+{
+       DBusConnection *conn =3D ofono_dbus_get_connection();
+       struct ofono_agps *agps =3D __ofono_atom_get_data(atom);
+       struct ofono_modem *modem =3D __ofono_atom_get_modem(atom);
+       const char *path =3D __ofono_atom_get_path(atom);
+
+       g_dbus_unregister_interface(conn, path, OFONO_AGPS_MANAGER_INTERFAC=
E);
+       ofono_modem_remove_interface(modem, OFONO_AGPS_MANAGER_INTERFACE);
+       agps->lcs_enabled =3D FALSE;
+}
+
+void ofono_agps_register(struct ofono_agps *agps)
+{
+       struct ofono_modem *modem =3D __ofono_atom_get_modem(agps->atom);
+       const char *path =3D __ofono_atom_get_path(agps->atom);
+       DBusConnection *conn =3D ofono_dbus_get_connection();
+
+       if (!g_dbus_register_interface(conn, path,
+                       OFONO_AGPS_MANAGER_INTERFACE,
+                       agps_methods,
+                       agps_signals,
+                       NULL, NULL, NULL)) {
+               ofono_error("agps_dbus_register:Could not register AGPS Man=
ager"
+               "Interface/Path");
+               return;
+       }
+
+       ofono_modem_add_interface(modem, OFONO_AGPS_MANAGER_INTERFACE);
+       __ofono_atom_register(agps->atom, agps_unregister);
+}
+
+void ofono_agps_remove(struct ofono_agps *agps)
+{
+       __ofono_atom_free(agps->atom);
+}
+
+static void agps_remove(struct ofono_atom *atom)
+{
+       struct ofono_agps *agps =3D __ofono_atom_get_data(atom);
+
+       DBG("atom: %p", atom);
+
+       if (agps =3D=3D NULL)
+               return;
+
+       g_free(agps);
+}
+
+void ofono_agps_set_data(struct ofono_agps *agps, void *data)
+{
+       agps->driver_data =3D data;
+}
+
+void *ofono_agps_get_data(struct ofono_agps *agps)
+{
+       return agps->driver_data;
+}
+
+struct ofono_agps *ofono_agps_create(struct ofono_modem *modem,
+                                       unsigned int vendor,
+                                       const char *driver,
+                                       void *data)
+{
+       struct ofono_agps *agps;
+       GSList *l;
+
+       if (driver =3D=3D NULL)
+               return NULL;
+
+       agps =3D g_try_new0(struct ofono_agps, 1);
+
+       if (agps =3D=3D NULL)
+               return NULL;
+
+       agps->atom =3D __ofono_modem_add_atom(modem, OFONO_ATOM_TYPE_AGPS,
+                                               agps_remove, agps);
+
+       for (l =3D g_drivers; l; l =3D l->next) {
+               const struct ofono_agps_driver *drv =3D l->data;
+
+               if (g_strcmp0(drv->name, driver))
+                       continue;
+
+               if (drv->probe(agps, vendor, data) < 0)
+                       continue;
+
+               agps->driver =3D drv;
+               break;
+       }
+       return agps;
+}
+
+int ofono_agps_driver_register(const struct ofono_agps_driver *d)
+{
+       DBG("driver: %p, name: %s", d, d->name);
+
+       if (d->probe =3D=3D NULL)
+               return -EINVAL;
+
+       g_drivers =3D g_slist_prepend(g_drivers, (void *)d);
+
+       return 0;
+}
+
+void ofono_agps_driver_unregister(const struct ofono_agps_driver *d)
+{
+       DBG("driver: %p, name: %s", d, d->name);
+
+       g_drivers =3D g_slist_remove(g_drivers, (void *)d);
+}
+
+void ofono_agps_lcs_frame_notify(struct ofono_agps *agps,
+                       struct ofono_lcs_frame frame)
+{
+
+       DBusConnection *conn =3D ofono_dbus_get_connection();
+       const char *path =3D __ofono_atom_get_path(agps->atom);
+
+       g_dbus_emit_signal(conn, path, OFONO_AGPS_MANAGER_INTERFACE,
+                               "PositionRequest",
+                               DBUS_TYPE_UINT16, &frame.lcs_frame_type,
+                               DBUS_TYPE_UINT16, &frame.frame_length,
+                               DBUS_TYPE_STRING, &frame.raw_frame,
+                               DBUS_TYPE_INVALID);
+}
+
+
+
diff --git a/src/ofono.h b/src/ofono.h
index bd7f33c..8048330 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -124,6 +124,7 @@ enum ofono_atom_type {
        OFONO_ATOM_TYPE_AUDIO_SETTINGS =3D 19,
        OFONO_ATOM_TYPE_STK =3D 20,
        OFONO_ATOM_TYPE_NETTIME =3D 21,
+       OFONO_ATOM_TYPE_AGPS =3D 22,
 };

 enum ofono_atom_watch_condition {
@@ -199,6 +200,7 @@ gboolean __ofono_call_settings_is_busy(struct ofono_cal=
l_settings *cs);
 #include <ofono/audio-settings.h>

 #include <ofono/voicecall.h>
+#include <ofono/agps.h>

 enum ofono_voicecall_interaction {
        OFONO_VOICECALL_INTERACTION_NONE        =3D 0,
--
1.7.0.4

--===============4338460350675608899==
Content-Type: text/plain
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-Added-aGPS-Modem-API-implementation-for-Infineon-modem.txt"

RnJvbSBmYWIxZmVhZGM5YzljZjM4NGFhNDI0MDRiZmJhMzA3Yzg2ZjU5OGRiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSb2JlcnRpbm8gQmVuaXMgPHJvYmVydGluby5iZW5pc0BpbnRl
bC5jb20+CkRhdGU6IEZyaSwgMjkgT2N0IDIwMTAgMjA6MTA6MDYgLTA3MDAKU3ViamVjdDogW0NI
QU5HRV0gQWRkZWQgYUdQUyBNb2RlbSBBUEkgaW1wbGVtZW50YXRpb24gZm9yIEluZmluZW9uIG1v
ZGVtCk9yZ2FuaXphdGlvbjogSW50ZWwgCkNjOiByb2JlcnRpbm8uYmVuaXNAaW50ZWwuY29tCgot
LS0KIE1ha2VmaWxlLmFtICAgICAgICAgICAgICAgICB8ICAgIDcgKy0KIGRyaXZlcnMvaWZ4bW9k
ZW0vYWdwcy5jICAgICB8ICA0MTggKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKwogZHJpdmVycy9pZnhtb2RlbS9pZnhtb2RlbS5jIHwgICAgMiArCiBkcml2ZXJzL2lm
eG1vZGVtL2lmeG1vZGVtLmggfCAgICAzICsKIGluY2x1ZGUvYWdwcy5oICAgICAgICAgICAgICB8
ICAxNTkgKysrKysrKysrKysrKysrKwogaW5jbHVkZS9kYnVzLmggICAgICAgICAgICAgIHwgICAg
MSArCiBwbHVnaW5zL2lmeC5jICAgICAgICAgICAgICAgfCAgIDEyICstCiBzcmMvYWdwcy5jICAg
ICAgICAgICAgICAgICAgfCAgMjI5ICsrKysrKysrKysrKysrKysrKysrKysrCiBzcmMvb2Zvbm8u
aCAgICAgICAgICAgICAgICAgfCAgICAyICsKIDkgZmlsZXMgY2hhbmdlZCwgODI3IGluc2VydGlv
bnMoKyksIDYgZGVsZXRpb25zKC0pCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9pZnhtb2Rl
bS9hZ3BzLmMKIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2FncHMuaAogY3JlYXRlIG1vZGUg
MTAwNjQ0IHNyYy9hZ3BzLmMKCmRpZmYgLS1naXQgYS9NYWtlZmlsZS5hbSBiL01ha2VmaWxlLmFt
CmluZGV4IDI1NjIxNjAuLjZlYzQ3NjEgMTAwNjQ0Ci0tLSBhL01ha2VmaWxlLmFtCisrKyBiL01h
a2VmaWxlLmFtCkBAIC0xMyw3ICsxMyw3IEBAIGluY2x1ZGVfSEVBREVSUyA9IGluY2x1ZGUvbG9n
LmggaW5jbHVkZS9wbHVnaW4uaCBpbmNsdWRlL2hpc3RvcnkuaCBcCiAJCQlpbmNsdWRlL2Nicy5o
IGluY2x1ZGUvY2FsbC12b2x1bWUuaCBcCiAJCQlpbmNsdWRlL2dwcnMuaCBpbmNsdWRlL2dwcnMt
Y29udGV4dC5oIFwKIAkJCWluY2x1ZGUvcmFkaW8tc2V0dGluZ3MuaCBpbmNsdWRlL3N0ay5oIFwK
LQkJCWluY2x1ZGUvYXVkaW8tc2V0dGluZ3MuaCBpbmNsdWRlL25ldHRpbWUuaAorCQkJaW5jbHVk
ZS9hdWRpby1zZXR0aW5ncy5oIGluY2x1ZGUvbmV0dGltZS5oIGluY2x1ZGUvYWdwcy5oCiAKIG5v
ZGlzdF9pbmNsdWRlX0hFQURFUlMgPSBpbmNsdWRlL3ZlcnNpb24uaAogCkBAIC0yMTgsNyArMjE4
LDggQEAgYnVpbHRpbl9zb3VyY2VzICs9IGRyaXZlcnMvYXRtb2RlbS9hdHV0aWwuaCBcCiAJCQlk
cml2ZXJzL2lmeG1vZGVtL2F1ZGlvLXNldHRpbmdzLmMgXAogCQkJZHJpdmVycy9pZnhtb2RlbS9y
YWRpby1zZXR0aW5ncy5jIFwKIAkJCWRyaXZlcnMvaWZ4bW9kZW0vZ3Bycy1jb250ZXh0LmMgXAot
CQkJZHJpdmVycy9pZnhtb2RlbS9zdGsuYworCQkJZHJpdmVycy9pZnhtb2RlbS9zdGsuYyBcCisJ
CQlkcml2ZXJzL2lmeG1vZGVtL2FncHMuYwogCiBidWlsdGluX21vZHVsZXMgKz0gc3RlbW9kZW0K
IGJ1aWx0aW5fc291cmNlcyArPSBkcml2ZXJzL2F0bW9kZW0vYXR1dGlsLmggXApAQCAtMzE1LDcg
KzMxNiw3IEBAIHNyY19vZm9ub2RfU09VUkNFUyA9ICQoZ2RidXNfc291cmNlcykgJChidWlsdGlu
X3NvdXJjZXMpIHNyYy9vZm9uby52ZXIgXAogCQkJc3JjL2dwcnMuYyBzcmMvaWRtYXAuaCBzcmMv
aWRtYXAuYyBcCiAJCQlzcmMvcmFkaW8tc2V0dGluZ3MuYyBzcmMvc3RrdXRpbC5oIHNyYy9zdGt1
dGlsLmMgXAogCQkJc3JjL25ldHRpbWUuYyBzcmMvc3RrYWdlbnQuYyBzcmMvc3RrYWdlbnQuaCBc
Ci0JCQlzcmMvc2ltZnMuYyBzcmMvc2ltZnMuaCBzcmMvYXVkaW8tc2V0dGluZ3MuYworCQkJc3Jj
L3NpbWZzLmMgc3JjL3NpbWZzLmggc3JjL2F1ZGlvLXNldHRpbmdzLmMgc3JjL2FncHMuYwogCiBz
cmNfb2Zvbm9kX0xEQUREID0gJChidWlsdGluX2xpYmFkZCkgQEdMSUJfTElCU0AgQERCVVNfTElC
U0AgQENBUE5HX0xJQlNAIC1sZGwKIApkaWZmIC0tZ2l0IGEvZHJpdmVycy9pZnhtb2RlbS9hZ3Bz
LmMgYi9kcml2ZXJzL2lmeG1vZGVtL2FncHMuYwpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAw
MDAwMDAwLi4yMDI3OTVlCi0tLSAvZGV2L251bGwKKysrIGIvZHJpdmVycy9pZnhtb2RlbS9hZ3Bz
LmMKQEAgLTAsMCArMSw0MTggQEAKKy8qCisgKgorICogIG9Gb25vIC0gT3BlbiBTb3VyY2UgVGVs
ZXBob255CisgKgorICogIENvcHlyaWdodCAoQykgMjAwOC0yMDEwICBJbnRlbCBDb3Jwb3JhdGlv
bi4gQWxsIHJpZ2h0cyByZXNlcnZlZC4KKyAqCisgKiAgVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29m
dHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkKKyAqICBpdCB1bmRl
ciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIHZlcnNpb24gMiBh
cworICogIHB1Ymxpc2hlZCBieSB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uLgorICoKKyAq
ICBUaGlzIHByb2dyYW0gaXMgZGlzdHJpYnV0ZWQgaW4gdGhlIGhvcGUgdGhhdCBpdCB3aWxsIGJl
IHVzZWZ1bCwKKyAqICBidXQgV0lUSE9VVCBBTlkgV0FSUkFOVFk7IHdpdGhvdXQgZXZlbiB0aGUg
aW1wbGllZCB3YXJyYW50eSBvZgorICogIE1FUkNIQU5UQUJJTElUWSBvciBGSVRORVNTIEZPUiBB
IFBBUlRJQ1VMQVIgUFVSUE9TRS4gIFNlZSB0aGUKKyAqICBHTlUgR2VuZXJhbCBQdWJsaWMgTGlj
ZW5zZSBmb3IgbW9yZSBkZXRhaWxzLgorICoKKyAqICBZb3Ugc2hvdWxkIGhhdmUgcmVjZWl2ZWQg
YSBjb3B5IG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZQorICogIGFsb25nIHdpdGgg
dGhpcyBwcm9ncmFtOyBpZiBub3QsIHdyaXRlIHRvIHRoZSBGcmVlIFNvZnR3YXJlCisgKiAgRm91
bmRhdGlvbiwgSW5jLiwgNTEgRnJhbmtsaW4gU3QsIEZpZnRoIEZsb29yLCBCb3N0b24sIE1BICAw
MjExMC0xMzAxICBVU0EKKyAqCisgKi8KKworI2lmZGVmIEhBVkVfQ09ORklHX0gKKyNpbmNsdWRl
IDxjb25maWcuaD4KKyNlbmRpZgorCisjZGVmaW5lIF9HTlVfU09VUkNFCisjaW5jbHVkZSA8c3Ry
aW5nLmg+CisjaW5jbHVkZSA8c3RkbGliLmg+CisjaW5jbHVkZSA8c3RkaW8uaD4KKyNpbmNsdWRl
IDxlcnJuby5oPgorCisjaW5jbHVkZSA8Z2xpYi5oPgorI2luY2x1ZGUgPGdpc2kvY2xpZW50Lmg+
CisKKyNpbmNsdWRlIDxvZm9uby9sb2cuaD4KKyNpbmNsdWRlIDxvZm9uby9tb2RlbS5oPgorI2lu
Y2x1ZGUgPG9mb25vL2FncHMuaD4KKworI2luY2x1ZGUgInV0aWwuaCIKKyNpbmNsdWRlICJpZnht
b2RlbS5oIgorCitzdHJ1Y3QgYWdwc19kYXRhIHsKKwlHQXRDaGF0ICpjaGF0OworCXVuc2lnbmVk
IGludCB2ZW5kb3I7CisJZW51bSBvZm9ub19hY2Nlc3NfdGVjaG5vbG9neSByYWRfYWNjX3RlY2g7
Cit9OworCitzdHJ1Y3Qgb2Zvbm9fYWdwczsKK3N0YXRpYyBjb25zdCBjaGFyICpub25lX3ByZWZp
eFtdID0geyBOVUxMIH07CisKKyNkZWZpbmUgRlJBTUVfTEVOIDEyOAorCitzdGF0aWMgdm9pZCBw
b3NfcmVxdWVzdF9ub3RpZnkoR0F0UmVzdWx0ICpyZXN1bHQsIGdwb2ludGVyIHVzZXJfZGF0YSkK
K3sKKwlzdHJ1Y3Qgb2Zvbm9fYWdwcyAqYWdwcyA9IHVzZXJfZGF0YTsKKwlpbnQgZnJhbWVsZW47
CisJaW50IGZyYW1ldHlwZTsKKwlHQXRSZXN1bHRJdGVyIGl0ZXI7CisJc3RydWN0IG9mb25vX2xj
c19mcmFtZSBsY3NmcmFtZTsKKwljb25zdCBjaGFyICptZXNzYWdlZnJhbWU7CisJdW5zaWduZWQg
Y2hhciBmcmFtZVtGUkFNRV9MRU5dOwkvKiBUT0RPIC0gTGVuZ3RoIFRCRCAqLworCWxvbmcgaGV4
ZnJhbWVsZW47CisKKwkvKiBBc3N1bWluZyBQb3MgUmVxIGZvcm1hdDogJVhQT1NSOiA8ZnJhbWV0
eXBlPiw8ZnJhbWVsZW4+LDxmcmFtZT4gKi8KKworCWdfYXRfcmVzdWx0X2l0ZXJfaW5pdCgmaXRl
ciwgcmVzdWx0KTsKKworCWlmICghZ19hdF9yZXN1bHRfaXRlcl9uZXh0KCZpdGVyLCAiJSVYUE9T
UjoiKSkKKwkJcmV0dXJuOworCisJaWYgKCFnX2F0X3Jlc3VsdF9pdGVyX25leHRfbnVtYmVyKCZp
dGVyLCAmZnJhbWV0eXBlKSkKKwkJcmV0dXJuOworCisJaWYgKCFnX2F0X3Jlc3VsdF9pdGVyX25l
eHRfbnVtYmVyKCZpdGVyLCAmZnJhbWVsZW4pKQorCQlyZXR1cm47CisKKwlpZiAoZnJhbWVsZW4g
PiBGUkFNRV9MRU4pIHsKKwkJb2Zvbm9fZXJyb3IoIkdvdCBQT1MgcmVxdWVzdCBtZXNzYWdlIG1v
cmUgdGhhbiBtYXhpbXVtIGJ1ZmZlciBzaXplISIpOworCQlyZXR1cm47CisJfQorCisJbWVzc2Fn
ZWZyYW1lID0gZ19hdF9yZXN1bHRfcGR1KHJlc3VsdCk7CisKKwlpZiAoc3RybGVuKG1lc3NhZ2Vm
cmFtZSkgPiBzaXplb2YoZnJhbWUpICogMikgeyAvKiBIZXgsIDIgY2hhcnMgLyBieXRlICovCisJ
CW9mb25vX2Vycm9yKCJNZXNzYWdlIGZyYW1lIHRvbyBsb25nISIpOworICAgICAgICAgICAgICAg
IHJldHVybjsKKwl9CisKKwlpZiAoZGVjb2RlX2hleF9vd25fYnVmKG1lc3NhZ2VmcmFtZSwgLTEs
ICZoZXhmcmFtZWxlbiwgMCwKKwkJCQlmcmFtZSkgPT0gTlVMTCkgeworCQlvZm9ub19lcnJvcigi
VW5hYmxlIHRvIGhleC1kZWNvZGUgdGhlIEFHUFMgZnJhbWUiKTsKKwkJcmV0dXJuOworCX0KKwor
CURCRygiR290IFBPUyByZXF1ZXN0IGRhdGE6ICVzLCAlbGQiLCBmcmFtZSwgaGV4ZnJhbWVsZW4p
OworCisJaWYgKGhleGZyYW1lbGVuICE9IGZyYW1lbGVuKSB7CisJCW9mb25vX2Vycm9yKCJoZXhm
cmFtZWxlbiBub3QgZXF1YWwgdG8gcmVwb3J0ZWQgZnJhbWVsZW4iKTsKKwkJcmV0dXJuOworCX0K
KworCWxjc2ZyYW1lLmxjc19mcmFtZV90eXBlID0gZnJhbWV0eXBlOworCWxjc2ZyYW1lLmZyYW1l
X2xlbmd0aCA9IGZyYW1lbGVuOworCWxjc2ZyYW1lLnJhd19mcmFtZSA9ICh1bnNpZ25lZCBjaGFy
ICopZnJhbWU7CisKKwlvZm9ub19hZ3BzX2xjc19mcmFtZV9ub3RpZnkoYWdwcywgbGNzZnJhbWUp
OworfQorCitzdGF0aWMgaW50IGlmeF9hZ3BzX3Byb2JlKHN0cnVjdCBvZm9ub19hZ3BzICphZ3Bz
LAorCQkJCQl1bnNpZ25lZCBpbnQgdmVuZG9yLCB2b2lkICpkYXRhKQoreworCUdBdENoYXQgKmNo
YXQgPSBkYXRhOworCXN0cnVjdCBhZ3BzX2RhdGEgKmFnZCA9IG9mb25vX2FncHNfZ2V0X2RhdGEo
YWdwcyk7CisKKwlhZ2QgPSBnX3RyeV9uZXcwKHN0cnVjdCBhZ3BzX2RhdGEsIDEpOworCWlmICgh
YWdkKQorCQlyZXR1cm4gLUVOT01FTTsKKworCWFnZC0+Y2hhdCA9IGdfYXRfY2hhdF9jbG9uZShj
aGF0KTsKKwlhZ2QtPnZlbmRvciA9IHZlbmRvcjsKKworCW9mb25vX2FncHNfc2V0X2RhdGEoYWdw
cywgYWdkKTsKKworCWdfYXRfY2hhdF9yZWdpc3RlcihhZ2QtPmNoYXQsICIlJVhQT1NSOiIsIHBv
c19yZXF1ZXN0X25vdGlmeSwgVFJVRSwKKwkJCQlhZ3BzLCBOVUxMKTsKKworCW9mb25vX2FncHNf
cmVnaXN0ZXIoYWdwcyk7CisKKwlyZXR1cm4gMDsKK30KKworc3RhdGljIHZvaWQgaWZ4X2FncHNf
cmVtb3ZlKHN0cnVjdCBvZm9ub19hZ3BzICphZ3BzKQoreworCXN0cnVjdCBhZ3BzX2RhdGEgKmFn
ZCA9IG9mb25vX2FncHNfZ2V0X2RhdGEoYWdwcyk7CisKKwlvZm9ub19hZ3BzX3NldF9kYXRhKGFn
cHMsIE5VTEwpOworCWdfYXRfY2hhdF91bnJlZihhZ2QtPmNoYXQpOworCWdfZnJlZShhZ2QpOwor
fQorCisKK3N0YXRpYyB2b2lkIGlmeF9hZ3BzX3JlY2VpdmVfbGNzX2ZyYW1lX2NiKGdib29sZWFu
IG9rLCBHQXRSZXN1bHQgKnJlc3VsdCwKKwkJCQlncG9pbnRlciB1c2VyX2RhdGEpCit7CisJc3Ry
dWN0IGNiX2RhdGEgKmNiZCA9IHVzZXJfZGF0YTsKKwlvZm9ub19hZ3BzX3JlY2VpdmVfbGNzX2Zy
YW1lX2NiX3QgY2IgPSBjYmQtPmNiOworCXN0cnVjdCBvZm9ub19lcnJvciBlcnJvcjsKKworCWRl
Y29kZV9hdF9lcnJvcigmZXJyb3IsIGdfYXRfcmVzdWx0X2ZpbmFsX3Jlc3BvbnNlKHJlc3VsdCkp
OworCWNiKCZlcnJvciwgY2JkLT5kYXRhKTsKK30KKworICAgLyoKKwkqIFRoZSBHUFMgbWFuYWdl
ciBjYW4gZW5hYmxlIG9yIGRpc2FibGUgQUdQUyBtYW5hZ2VyICB0byByZWNlaXZlCisJKiBsY3Nf
ZnJhbWVzIGZyb20gdGhlIE1vYmlsZSBuZXR3b3JrLiBJZiBkaXNhYmxlZCwgYWxsIEFzc2lzdGFu
Y2UgRGF0YQorCSogYW5kIFBvc2l0aW9uIFJlcXVlc3RzIGZyb20gTW9iaWxlIE5ldHdvcmsgYXJl
IG5vdCBzaWduYWxsZWQgdG8gb2Zvbm8uCisJKi8KK3N0YXRpYyB2b2lkIGlmeF9hZ3BzX3JlY2Vp
dmVfbGNzX2ZyYW1lcyhzdHJ1Y3Qgb2Zvbm9fYWdwcyAqYWdwcywKKwkJCWludCBlbmFibGVkLCBv
Zm9ub19hZ3BzX3JlY2VpdmVfbGNzX2ZyYW1lX2NiX3QgY2IsCisJCQl2b2lkICp1c2VyX2RhdGEp
Cit7CisJc3RydWN0IGFncHNfZGF0YSAqZGF0YSA9IG9mb25vX2FncHNfZ2V0X2RhdGEoYWdwcyk7
CisJc3RydWN0IGNiX2RhdGEgKmNiZCA9IGNiX2RhdGFfbmV3KGNiLCB1c2VyX2RhdGEpOworCWNo
YXIgKmNvbW1idWY7CisJdW5zaWduZWQgaW50IGlkOworCisJaWYgKCFjYmQpCisJCWdvdG8gZXJy
b3I7CisKKwljb21tYnVmID0gZ19zdHJkdXBfcHJpbnRmKCJBVCUlWFBPUz1cIiVkXCIiLCBlbmFi
bGVkKTsKKworCWlkID0gZ19hdF9jaGF0X3NlbmQoZGF0YS0+Y2hhdCwgY29tbWJ1Ziwgbm9uZV9w
cmVmaXgsCisJCQkJaWZ4X2FncHNfcmVjZWl2ZV9sY3NfZnJhbWVfY2IsIGNiZCwgZ19mcmVlKTsK
KworCWdfZnJlZShjb21tYnVmKTsKKworCWlmIChpZCA+IDApCisJCXJldHVybjsKK2Vycm9yOgor
CWlmIChjYmQpCisJCWdfZnJlZShjYmQpOworCisJQ0FMTEJBQ0tfV0lUSF9GQUlMVVJFKGNiLCB1
c2VyX2RhdGEpOworfQorCitzdGF0aWMgdm9pZCBpZnhfYWdwc19zZW5kX2xjc19mcmFtZV9jYihn
Ym9vbGVhbiBvaywgR0F0UmVzdWx0ICpyZXN1bHQsCisJCQkJZ3BvaW50ZXIgdXNlcl9kYXRhKQor
eworCXN0cnVjdCBjYl9kYXRhICpjYmQgPSB1c2VyX2RhdGE7CisJb2Zvbm9fYWdwc19zZW5kX2xj
c19mcmFtZV9jYl90IGNiID0gY2JkLT5jYjsKKwlzdHJ1Y3Qgb2Zvbm9fZXJyb3IgZXJyb3I7CisK
KwlkZWNvZGVfYXRfZXJyb3IoJmVycm9yLCBnX2F0X3Jlc3VsdF9maW5hbF9yZXNwb25zZShyZXN1
bHQpKTsKKwljYigmZXJyb3IsIGNiZC0+ZGF0YSk7Cit9CisKKyNkZWZpbmUgQlVGX0xFTiAxMjgK
KwkvKiBBc3Npc3RhbmNlIERhdGEgYW5kIFBvc2l0aW9uIFJlcXVlc3RzIGZyb20gdGhlIE1vYmls
ZSBOZXR3b3JrIGFyZQorCSAqIHNpZ25hbGxlZCB2aWEgdGhlIG9mb25vX2FncHNfbGNzX2ZyYW1l
X25vdGlmeSBmdW5jdGlvbiBhbmQgdGhlCisJICogb0Zvbm8gY29yZSB0byBhbiBleHRlcm5hbCBH
UFMgbWFuYWdlci4gVGhpcyBHUFMgbWFuYWdlciBjYW4gcmVwbHkKKwkgKiB0byBQb3NpdGlvbiBS
ZXF1ZXN0cyB3aXRoIG9uZSBvciBtb3JlIFBvc2l0aW9uIFJlc3BvbnNlcyB3aGljaAorCSAqIGFy
ZSB0aGVuIHNlbmQgYmFjayB0byB0aGUgbW9kZW0gdmlhIHRoZSBzZW5kX2xjc19mcmFtZSBmdW5j
dGlvbi4KKwkgKi8KK3N0YXRpYyB2b2lkIGlmeF9hZ3BzX3NlbmRfbGNzX2ZyYW1lKHN0cnVjdCBv
Zm9ub19hZ3BzICphZ3BzLAorCQkJCXN0cnVjdCBvZm9ub19sY3NfZnJhbWUgKmZyYW1lLAorCQkJ
CW9mb25vX2FncHNfc2VuZF9sY3NfZnJhbWVfY2JfdCBjYiwKKwkJCQl2b2lkICp1c2VyX2RhdGEp
Cit7CisJc3RydWN0IGFncHNfZGF0YSAqZGF0YSA9IG9mb25vX2FncHNfZ2V0X2RhdGEoYWdwcyk7
CisJc3RydWN0IGNiX2RhdGEgKmNiZCA9IGNiX2RhdGFfbmV3KGNiLCB1c2VyX2RhdGEpOworCWNo
YXIgYnVmW0JVRl9MRU4gKiAyICsgMV07CisJY2hhciAqY29tbWJ1ZjsKKwl1bnNpZ25lZCBpbnQg
aWQ7CisJaW50IGJ1ZmxlbjsKKworCWlmICghY2JkKQorCQlnb3RvIGVycm9yOworCisJaWYgKCFm
cmFtZS0+ZnJhbWVfbGVuZ3RoKSB7CisJCW9mb25vX2Vycm9yKCJpZnhfYWdwc19zZW5kX2xjc19m
cmFtZTogRnJhbWUgbGVuZ3RoIEludmFsaWQiKTsKKwkJZ290byBlcnJvcjsKKwl9CisKKwlpZiAo
ZnJhbWUtPmZyYW1lX2xlbmd0aCA+IEJVRl9MRU4pIHsKKwkJb2Zvbm9fZXJyb3IoImlmeF9hZ3Bz
X3NlbmRfbGNzX2ZyYW1lOiBGcmFtZSBsZW5ndGggdG9vIGxvbmchIik7CisJCWdvdG8gZXJyb3I7
CisJfQorCisJZW5jb2RlX2hleF9vd25fYnVmKGZyYW1lLT5yYXdfZnJhbWUsIGZyYW1lLT5mcmFt
ZV9sZW5ndGgsIDAsIGJ1Zik7CisJYnVmbGVuID0gc3RybGVuKGJ1Zik7CisJREJHKCJFbmNvZGVk
IEFHUFMgRnJhbWUgPSAlcyAlZCIsIGJ1ZiwgYnVmbGVuKTsKKworCWNvbW1idWYgPSBnX3N0cmR1
cF9wcmludGYoIkFUJSVYUE9TUj0lZCwlZCxcIiVzXCIiLAorCQkJZnJhbWUtPmxjc19mcmFtZV90
eXBlLCBidWZsZW4sIGJ1Zik7CisKKwlpZCA9IGdfYXRfY2hhdF9zZW5kKGRhdGEtPmNoYXQsIGNv
bW1idWYsIG5vbmVfcHJlZml4LAorCQkJCWlmeF9hZ3BzX3NlbmRfbGNzX2ZyYW1lX2NiLCBjYmQs
IGdfZnJlZSk7CisKKwlnX2ZyZWUoY29tbWJ1Zik7CisKKwlpZiAoaWQgPiAwKQorCQlyZXR1cm47
CitlcnJvcjoKKwlpZiAoY2JkKQorCQlnX2ZyZWUoY2JkKTsKKworCUNBTExCQUNLX1dJVEhfRkFJ
TFVSRShjYiwgdXNlcl9kYXRhKTsKK30KKworc3RhdGljIHZvaWQgaWZ4X2FncHNfaW5qZWN0X3Rp
bWVfY2IoZ2Jvb2xlYW4gb2ssIEdBdFJlc3VsdCAqcmVzdWx0LAorCQkJCWdwb2ludGVyIHVzZXJf
ZGF0YSkKK3sKKwlHQXRSZXN1bHRJdGVyIGl0ZXI7CisJc3RydWN0IG9mb25vX2Vycm9yIGVycm9y
OworCXN0cnVjdCBvZm9ub19sY3NfcmFkaW9fZm4gcmY7CisJc3RydWN0IGNiX2RhdGEgKmNiZCA9
IHVzZXJfZGF0YTsKKwlzdHJ1Y3QgYWdwc19kYXRhICpkYXRhID0gY2JkLT51c2VyOworCW9mb25v
X2FncHNfaW5qZWN0X3RpbWVfY2JfdCBjYiA9IGNiZC0+Y2I7CisKKwlkZWNvZGVfYXRfZXJyb3Io
JmVycm9yLCBnX2F0X3Jlc3VsdF9maW5hbF9yZXNwb25zZShyZXN1bHQpKTsKKworCWlmICghb2sp
IHsKKwkJY2IoJmVycm9yLCBOVUxMLCBjYmQtPmRhdGEpOworCQlyZXR1cm47CisJfQorCisJaWYg
KCFnX2F0X3Jlc3VsdF9pdGVyX25leHQoJml0ZXIsICIlJVhGVEk6IikpCisJCWdvdG8gZXJyOwor
CisJaWYgKFJBRElPX0FDQ0VTU19URUNITk9MT0dZX0dTTSA9PSBkYXRhLT5yYWRfYWNjX3RlY2gp
IHsKKworCQlpbnQgZm47CQkvKiByYW5nZSAwIC0gMjcxNTY0NyAoMjA0OCoyNio1MSkgKi8KKwkJ
aW50IHRzOwkJLyogcmFuZ2UgMCAtIDcgKi8KKwkJaW50IHRzYjsJLyogcmFuZ2UgMCAtIDE1NiAq
LworCQlpbnQgdGE7CQkvKiByYW5nZSAwIC0gNjMgKi8KKwkJaW50IGJhOwkJLyogcmFuZ2UgMCAt
IDEwMjMgKi8KKwkJaW50IGJjOwkJLyogcmFuZ2UgMCAtIDY0ICovCisKKwkvKgkgJVhGVEk6PGZy
YW1lTnVtPiw8VGltZVNsb3Q+LDxUaW1lU2xvdEJpdD4sPFRpbWVBZHY+LAorCSoJPENoYW5uZWxO
dW0+LDxDaGFubmVsSWQ+CisJKi8KKwkJaWYgKCFnX2F0X3Jlc3VsdF9pdGVyX25leHRfbnVtYmVy
KCZpdGVyLCAmZm4pKQorCQkJZ290byBlcnI7CisKKwkJaWYgKCFnX2F0X3Jlc3VsdF9pdGVyX25l
eHRfbnVtYmVyKCZpdGVyLCAmdHMpKQorCQkJZ290byBlcnI7CisKKwkJaWYgKCFnX2F0X3Jlc3Vs
dF9pdGVyX25leHRfbnVtYmVyKCZpdGVyLCAmdHNiKSkKKwkJCWdvdG8gZXJyOworCisJCWlmICgh
Z19hdF9yZXN1bHRfaXRlcl9uZXh0X251bWJlcigmaXRlciwgJnRhKSkKKwkJCWdvdG8gZXJyOwor
CisJCWlmICghZ19hdF9yZXN1bHRfaXRlcl9uZXh0X251bWJlcigmaXRlciwgJmJhKSkKKwkJCWdv
dG8gZXJyOworCisJCWlmICghZ19hdF9yZXN1bHRfaXRlcl9uZXh0X251bWJlcigmaXRlciwgJmJj
KSkKKwkJCWdvdG8gZXJyOworCisJCURCRygiR1NNIEluamVjdCBSZXNwb25zZTogZm4gPSAlZCB0
cyA9ICVkIHRzYiA9ICVkIHRhID0gJWQiCisJCQkJImJhID0gJWQgYmMgPSAlZCAiLCBmbiwgdHMs
IHRzYiwgdGEsIGJhLCBiYyk7CisKKwkJcmYuZ3NtX2ZyYW1lX251bWJlci5URE1BX2ZyYW1lX251
bWJlciA9IGZuOworCQlyZi5nc21fZnJhbWVfbnVtYmVyLlRETUFfdGltZXNsb3QgPSB0czsKKwkJ
cmYuZ3NtX2ZyYW1lX251bWJlci50aW1lc2xvdF9iaXQgPSB0c2I7CisJCXJmLmdzbV9mcmFtZV9u
dW1iZXIudGltaW5nX2FkdmFuY2UgPSB0YTsKKwkJcmYuZ3NtX2ZyYW1lX251bWJlci5iY2NoX2Fy
ZmNuID0gYmE7CisJCXJmLmdzbV9mcmFtZV9udW1iZXIuYnNpYyA9IGJjOworCQlyZi5yYWRpb19h
Y2Nlc3NfdGVjaG5vbG9neSA9IFJBRElPX0FDQ0VTU19URUNITk9MT0dZX0dTTTsKKworCX0gZWxz
ZSBpZiAoUkFESU9fQUNDRVNTX1RFQ0hOT0xPR1lfVU1UUyA9PSBkYXRhLT5yYWRfYWNjX3RlY2gp
IHsKKworCQlpbnQgc2ZuOwkvKiByYW5nZSAwIC0gNDA5NSAqLworCQlpbnQgcnM7CQkvKiBlbnVt
IG9mb25vX3JyY19zdGF0ZSAqLworCQlpbnQgcnQ7CQkvKiByYW5nZSAwIC0gMzI3NjYgKi8KKwor
CQkvKiAlWEZUSTo8ZnJhbWVOdW0+LDxSYWRpb1N0YXRlPiw8VHJpcFRpbWU+ICovCisJCWlmICgh
Z19hdF9yZXN1bHRfaXRlcl9uZXh0X251bWJlcigmaXRlciwgJnNmbikpCisJCQlnb3RvIGVycjsK
KworCQlpZiAoIWdfYXRfcmVzdWx0X2l0ZXJfbmV4dF9udW1iZXIoJml0ZXIsICZycykpCisJCQln
b3RvIGVycjsKKworCQlpZiAoIWdfYXRfcmVzdWx0X2l0ZXJfbmV4dF9udW1iZXIoJml0ZXIsICZy
dCkpCisJCQlnb3RvIGVycjsKKworCQlEQkcoIlVNVFMgSW5qZWN0IFJlc3BvbnNlOiBzZm4gPSAl
ZCBycyA9ICVkIHR0ID0gJWQiLAorCQkJCXNmbiwgcnMsIHJ0KTsKKworCQlyZi51dHJhbl9mcmFt
ZV9udW1iZXIuc2ZuID0gc2ZuOworCQlyZi51dHJhbl9mcmFtZV9udW1iZXIucnJjX3N0YXRlID0g
cnM7CisJCXJmLnV0cmFuX2ZyYW1lX251bWJlci5yb3VuZF90cmlwX3RpbWUgPSBydDsKKwkJcmYu
cmFkaW9fYWNjZXNzX3RlY2hub2xvZ3kgPSBSQURJT19BQ0NFU1NfVEVDSE5PTE9HWV9VTVRTOwor
CisJfSBlbHNlCisJCWdvdG8gZXJyOworCisJY2IoJmVycm9yLCAmcmYsIGNiZC0+ZGF0YSk7CisJ
CXJldHVybjsKKworZXJyOgorCUNBTExCQUNLX1dJVEhfRkFJTFVSRShjYiwgTlVMTCwgY2JkLT5k
YXRhKTsKK30KKworCisJLyogVGhlIEdQUyBtYW5hZ2VyIGNhbiBhc2sgdGhlIG1vZGVtIHRvIGdl
bmVyYXRlIGEgSFcgcHVsc2UgKHRpbWUKKwkgKiBzdGFtcCkgd2l0aCBhIGRlZmluZWQgbGVuZ3Ro
IGFuZCB0aGUgbW9kZW0gcmVwbGllcyBpbmRpY2F0ZXMgd2hlbgorCSAqIGl0IGdlbmVyYXRlcyB0
aGUgcHVsc2UuIEJ1dCBhcyB0aGUgbW9kZW0gaGFzIG5vIHByZWNpc2UgaWRhZSBvZgorCSAqIFVu
aXZlcnNhbCBUaW1lLCBpdCBpbmRpY2F0ZXMgYXQgd2hpY2ggcmFkaW8gZnJhbWUgbnVtYmVyIGl0
Z2MKKwkgKiBnZW5lcmF0ZWQgdGhlIHB1bHNlLiBUaGUgR1BTIG1hbmFnZXIgd2hpY2gga25vd3Mg
dGhlIGxpbmsgYmV0d2VlbgorCSAqIFVuaXZlcnNhbCBUaW1lIGFuZCB0aGUgUmFkaW8gRnJhbWUg
bnVtYmVyIGtub3dzIHZlcnkgcHJlY2lzZWx5IGF0CisJICogd2hhdCB0aW1lIHRoZSBwdWxzZSB3
YXMgZ2VuZXJhdGVkIGFuZCBpdHMgZHVyYXRpb24uCisJICoKKwkgKiBUaW1pbmcgYWNjdXJhY3kg
aXMgdHlwaWNhbGx5IGEgZmV3IG1pY3Jvc2Vjb25kcy4KKwkgKi8KK3N0YXRpYyB2b2lkIGlmeF9h
Z3BzX2luamVjdF90aW1lKHN0cnVjdCBvZm9ub19hZ3BzICphZ3BzLAorCQkJaW50IHJhZGlvX2Fj
Y2Vzc190ZWNobm9sb2d5LC8qIGVudW0gYWNjZXNzX3RlY2hub2xvZ3kgKi8KKwkJCWludCBwdWxz
ZV9sZW5ndGgsLyogZHVyYXRpb24gb2YgcHVsc2UgaW4gcmFkaW8gc2xvdHMgKi8KKwkJCW9mb25v
X2FncHNfaW5qZWN0X3RpbWVfY2JfdCBjYiwgdm9pZCAqdXNlcl9kYXRhKQoreworCXN0cnVjdCBh
Z3BzX2RhdGEgKmRhdGEgPSBvZm9ub19hZ3BzX2dldF9kYXRhKGFncHMpOworCXN0cnVjdCBjYl9k
YXRhICpjYmQgPSBjYl9kYXRhX25ldyhjYiwgdXNlcl9kYXRhKTsKKwljaGFyICpidWY7CisJdW5z
aWduZWQgaW50IGlkOworCisJaWYgKCFjYmQpCisJCWdvdG8gZXJyb3I7CisKKwljYmQtPnVzZXIg
PSBkYXRhOworCisJaWYgKFJBRElPX0FDQ0VTU19URUNITk9MT0dZX0dTTSA9PSByYWRpb19hY2Nl
c3NfdGVjaG5vbG9neSkgeworCQlkYXRhLT5yYWRfYWNjX3RlY2ggPSByYWRpb19hY2Nlc3NfdGVj
aG5vbG9neTsKKwkJYnVmID0gZ19zdHJkdXBfcHJpbnRmKCJBVCUlWEZUST1cIiVzJWRcIiIsICJH
U00iLAorCQkJCQkJcHVsc2VfbGVuZ3RoKTsKKworCX0gZWxzZSBpZiAoUkFESU9fQUNDRVNTX1RF
Q0hOT0xPR1lfVU1UUyA9PSByYWRpb19hY2Nlc3NfdGVjaG5vbG9neSkgeworCQkJZGF0YS0+cmFk
X2FjY190ZWNoID0gcmFkaW9fYWNjZXNzX3RlY2hub2xvZ3k7CisJCQlidWYgPSBnX3N0cmR1cF9w
cmludGYoIkFUJSVYRlRJPVwiJXMlZFwiIiwgIlVNVFMiLAorCQkJCQkJcHVsc2VfbGVuZ3RoKTsK
Kwl9IGVsc2UKKwkJZ290byBlcnJvcjsKKworCWlkID0gZ19hdF9jaGF0X3NlbmQoZGF0YS0+Y2hh
dCwgYnVmLCBub25lX3ByZWZpeCwKKwkJICAgIGlmeF9hZ3BzX2luamVjdF90aW1lX2NiLCBjYmQs
IGdfZnJlZSk7CisKKwlnX2ZyZWUoYnVmKTsKKworCWlmIChpZCA+IDApCisJCXJldHVybjsKKwor
ZXJyb3I6CisJaWYgKGNiZCkKKwkJZ19mcmVlKGNiZCk7CisKKwlDQUxMQkFDS19XSVRIX0ZBSUxV
UkUoY2IsIE5VTEwsIHVzZXJfZGF0YSk7Cit9CisKK3N0YXRpYyBzdHJ1Y3Qgb2Zvbm9fYWdwc19k
cml2ZXIgZHJpdmVyID0geworCS5uYW1lCQkJCQkgICAgPSAiaWZ4bW9kZW0iLAorCS5wcm9iZQkJ
CQkJICAgID0gaWZ4X2FncHNfcHJvYmUsCisJLnJlbW92ZQkJCQkJICAgID0gaWZ4X2FncHNfcmVt
b3ZlLAorCS5yZWNlaXZlX2xjc19mcmFtZXMJCQk9IGlmeF9hZ3BzX3JlY2VpdmVfbGNzX2ZyYW1l
cywKKwkuc2VuZF9sY3NfZnJhbWUJCQkJPSBpZnhfYWdwc19zZW5kX2xjc19mcmFtZSwKKwkuaW5q
ZWN0X3RpbWUJCQkJPSBpZnhfYWdwc19pbmplY3RfdGltZQorfTsKKwordm9pZCBpZnhfYWdwc19p
bml0KCkKK3sKKwlvZm9ub19hZ3BzX2RyaXZlcl9yZWdpc3RlcigmZHJpdmVyKTsKKwlEQkcoImlm
eF9hZ3BzX2luaXQ6IC4uIik7Cit9CisKK3ZvaWQgaWZ4X2FncHNfZXhpdCgpCit7CisJb2Zvbm9f
YWdwc19kcml2ZXJfdW5yZWdpc3RlcigmZHJpdmVyKTsKKwlEQkcoImlmeF9hZ3BzX2V4aXQ6IC4u
Iik7Cit9CisKZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWZ4bW9kZW0vaWZ4bW9kZW0uYyBiL2RyaXZl
cnMvaWZ4bW9kZW0vaWZ4bW9kZW0uYwppbmRleCA4YTlhYzhmLi4yYTJhMjczIDEwMDY0NAotLS0g
YS9kcml2ZXJzL2lmeG1vZGVtL2lmeG1vZGVtLmMKKysrIGIvZHJpdmVycy9pZnhtb2RlbS9pZnht
b2RlbS5jCkBAIC0zOSwxMiArMzksMTQgQEAgc3RhdGljIGludCBpZnhtb2RlbV9pbml0KHZvaWQp
CiAJaWZ4X3JhZGlvX3NldHRpbmdzX2luaXQoKTsKIAlpZnhfZ3Byc19jb250ZXh0X2luaXQoKTsK
IAlpZnhfc3RrX2luaXQoKTsKKwlpZnhfYWdwc19pbml0KCk7CiAKIAlyZXR1cm4gMDsKIH0KIAog
c3RhdGljIHZvaWQgaWZ4bW9kZW1fZXhpdCh2b2lkKQogeworCWlmeF9hZ3BzX2V4aXQoKTsKIAlp
Znhfc3RrX2V4aXQoKTsKIAlpZnhfZ3Byc19jb250ZXh0X2V4aXQoKTsKIAlpZnhfcmFkaW9fc2V0
dGluZ3NfZXhpdCgpOwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pZnhtb2RlbS9pZnhtb2RlbS5oIGIv
ZHJpdmVycy9pZnhtb2RlbS9pZnhtb2RlbS5oCmluZGV4IDhlYTUyZTUuLmU1YWNjYzIgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvaWZ4bW9kZW0vaWZ4bW9kZW0uaAorKysgYi9kcml2ZXJzL2lmeG1vZGVt
L2lmeG1vZGVtLmgKQEAgLTM1LDMgKzM1LDYgQEAgZXh0ZXJuIHZvaWQgaWZ4X2dwcnNfY29udGV4
dF9leGl0KCk7CiAKIGV4dGVybiB2b2lkIGlmeF9zdGtfaW5pdCgpOwogZXh0ZXJuIHZvaWQgaWZ4
X3N0a19leGl0KCk7CisKK2V4dGVybiB2b2lkIGlmeF9hZ3BzX2luaXQoKTsKK2V4dGVybiB2b2lk
IGlmeF9hZ3BzX2V4aXQoKTsKZGlmZiAtLWdpdCBhL2luY2x1ZGUvYWdwcy5oIGIvaW5jbHVkZS9h
Z3BzLmgKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMC4uNzE4OGVlZgotLS0gL2Rl
di9udWxsCisrKyBiL2luY2x1ZGUvYWdwcy5oCkBAIC0wLDAgKzEsMTU5IEBACisvKgorICoKKyAq
ICBvRm9ubyAtIE9wZW4gU291cmNlIFRlbGVwaG9ueQorICoKKyAqICBDb3B5cmlnaHQgKEMpIDIw
MDgtMjAxMCAgSW50ZWwgQ29ycG9yYXRpb24uIEFsbCByaWdodHMgcmVzZXJ2ZWQuCisgKgorICog
IFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBh
bmQvb3IgbW9kaWZ5CisgKiAgaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQ
dWJsaWMgTGljZW5zZSB2ZXJzaW9uIDIgYXMKKyAqICBwdWJsaXNoZWQgYnkgdGhlIEZyZWUgU29m
dHdhcmUgRm91bmRhdGlvbi4KKyAqCisgKiAgVGhpcyBwcm9ncmFtIGlzIGRpc3RyaWJ1dGVkIGlu
IHRoZSBob3BlIHRoYXQgaXQgd2lsbCBiZSB1c2VmdWwsCisgKiAgYnV0IFdJVEhPVVQgQU5ZIFdB
UlJBTlRZOyB3aXRob3V0IGV2ZW4gdGhlIGltcGxpZWQgd2FycmFudHkgb2YKKyAqICBNRVJDSEFO
VEFCSUxJVFkgb3IgRklUTkVTUyBGT1IgQSBQQVJUSUNVTEFSIFBVUlBPU0UuICBTZWUgdGhlCisg
KiAgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgZm9yIG1vcmUgZGV0YWlscy4KKyAqCisgKiAg
WW91IHNob3VsZCBoYXZlIHJlY2VpdmVkIGEgY29weSBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGlj
IExpY2Vuc2UKKyAqICBhbG9uZyB3aXRoIHRoaXMgcHJvZ3JhbTsgaWYgbm90LCB3cml0ZSB0byB0
aGUgRnJlZSBTb2Z0d2FyZQorICogIEZvdW5kYXRpb24sIEluYy4sIDUxIEZyYW5rbGluIFN0LCBG
aWZ0aCBGbG9vciwgQm9zdG9uLCBNQSAgMDIxMTAtMTMwMSAgVVNBCisgKgorICovCisKKyNpZm5k
ZWYgX19PRk9OT19BR1BTX0hfCisjZGVmaW5lIF9fT0ZPTk9fQUdQU19IXworCisjaWZkZWYgX19j
cGx1c3BsdXMKK2V4dGVybiAiQyIgeworI2VuZGlmCisKKyNpbmNsdWRlIDxvZm9uby90eXBlcy5o
PgorCisjaW5jbHVkZSA8Z2xpYi5oPgorI2luY2x1ZGUgPGdkYnVzLmg+CisjaW5jbHVkZSA8b2Zv
bm8vbW9kZW0uaD4KKworI2luY2x1ZGUgImdhdGNoYXQuaCIKKyNpbmNsdWRlICJnYXRyZXN1bHQu
aCIKKworZW51bSBvZm9ub19sY3NfZnJhbWVfdHlwZSB7CisJUlJMUF9BU1NJU1RBTkNFX0RBVEEg
PSAwLAkJLyogZnJvbSBtb2RlbSAqLworCS8qIFBvc2l0aW9uIHJlcXVlc3QgY2FuIGluY2x1ZGUg
YXNzaXN0YW5jZSBkYXRhIGFzIHdlbGwgKi8KKwlSUkxQX01FQVNVUkVfUE9TSVRJT05fUkVRVUVT
VCA9IDEsCS8qIGZyb20gbW9kZW0gKi8KKwlSUkxQX01FQVNVUkVfUE9TSVRJT05fUkVTUE9OU0Ug
PSAyLAkvKiBmcm9tIEdQUyAqLworCVJSQ19BU1NJU1RBTkNFX0RBVEFfREVMSVZFUlkgPSAzLAkv
KiBmcm9tIG1vZGVtICovCisJLyogTWVhc3VyZW1lbnQgY29udHJvbCBjYW4gaW5jbHVkZSBhc3Np
c3RhbmNlIGRhdGEgYXMgd2VsbCAqLworCVJSQ19NRUFTVVJFTUVOVF9DT05UUk9MID0gNCwJCS8q
IGZyb20gbW9kZW0gKi8KKwlSUkNfTUVBU1VSRU1FTlRfUkVQT1JUID0gNSwJCS8qIGZyb20gR1BT
ICovCit9OworCitlbnVtIG9mb25vX2FjY2Vzc190ZWNobm9sb2d5IHsKKwlSQURJT19BQ0NFU1Nf
VEVDSE5PTE9HWV9HU00gPSAwLAkJLyogR1NNICovCisJUkFESU9fQUNDRVNTX1RFQ0hOT0xPR1lf
VU1UUyA9IDEsCQkvKiBVTVRTICovCit9OworCitlbnVtIG9mb25vX3JyY19zdGF0ZSB7CisJUlJD
X0NFTExfUENIID0gMCwKKwlSUkNfQ0VMTF9GQUNIID0gMSwKKwlSUkNfQ0VMTF9EQ0ggPSAyLAor
CVJSQ19VUkFfUENIID0gMywKK307CisKK3N0cnVjdCBvZm9ub19sY3NfZnJhbWUgeworCWVudW0g
b2Zvbm9fbGNzX2ZyYW1lX3R5cGUgbGNzX2ZyYW1lX3R5cGU7CisJaW50IGZyYW1lX2xlbmd0aDsJ
Lyogc2l6ZSBvZiByYXdfZnJhbWUgaW4gYnl0ZXMgKi8KKwl1bnNpZ25lZCBjaGFyICAqcmF3X2Zy
YW1lOworfTsKKworc3RydWN0IG9mb25vX2xjc19nc21fZm4geworCWludCBURE1BX2ZyYW1lX251
bWJlcjsJLyogcmFuZ2UgMCAtIDI3MTU2NDcgKDIwNDgqMjYqNTEpICovCisJaW50IFRETUFfdGlt
ZXNsb3Q7CQkvKiByYW5nZSAwIC0gNyAqLworCWludCB0aW1lc2xvdF9iaXQ7CQkvKiByYW5nZSAw
IC0gMTU2ICovCisJaW50IHRpbWluZ19hZHZhbmNlOwkJLyogcmFuZ2UgMCAtIDYzICovCisJaW50
IGJjY2hfYXJmY247CQkJLyogcmFuZ2UgMCAtIDEwMjMgKi8KKwlpbnQgYnNpYzsJCQkJLyogcmFu
Z2UgMCAtIDY0ICovCit9OworCitzdHJ1Y3Qgb2Zvbm9fbGNzX3V0cmFuX2ZuIHsKKwlpbnQgc2Zu
OwkJCQkvKiByYW5nZSAwIC0gNDA5NSAqLworCWludCBycmNfc3RhdGU7CQkJLyogZW51bSBvZm9u
b19ycmNfc3RhdGUgKi8KKwlpbnQgcm91bmRfdHJpcF90aW1lOwkvKiByYW5nZSAwIC0gMzI3NjYg
Ki8KK307CisKK3N0cnVjdCBvZm9ub19sY3NfcmFkaW9fZm4geworCWludCByYWRpb19hY2Nlc3Nf
dGVjaG5vbG9neTsgLyogZW51bSBhY2Nlc3NfdGVjaG5vbG9neSAqLworCXVuaW9uIHsKKwkJc3Ry
dWN0IG9mb25vX2xjc19nc21fZm4JCWdzbV9mcmFtZV9udW1iZXI7CisJCXN0cnVjdCBvZm9ub19s
Y3NfdXRyYW5fZm4JdXRyYW5fZnJhbWVfbnVtYmVyOworCX07Cit9OworCitzdHJ1Y3Qgb2Zvbm9f
YWdwczsKKwordHlwZWRlZiB2b2lkICgqb2Zvbm9fYWdwc19zZW5kX2xjc19mcmFtZV9jYl90KShj
b25zdCBzdHJ1Y3Qgb2Zvbm9fZXJyb3IgKmVycm9yLAorCQkJCXZvaWQgKmRhdGEpOwordHlwZWRl
ZiB2b2lkICgqb2Zvbm9fYWdwc19yZWNlaXZlX2xjc19mcmFtZV9jYl90KSgKKwkJCQljb25zdCBz
dHJ1Y3Qgb2Zvbm9fZXJyb3IgKmVycm9yLAorCQkJCXZvaWQgKmRhdGEpOwordHlwZWRlZiB2b2lk
ICgqb2Zvbm9fYWdwc19pbmplY3RfdGltZV9jYl90KShjb25zdCBzdHJ1Y3Qgb2Zvbm9fZXJyb3Ig
KmVycm9yLAorCQkJCXN0cnVjdCBvZm9ub19sY3NfcmFkaW9fZm4gKnJhZGlvX2ZyYW1lX251bWJl
ciwKKwkJCQl2b2lkICpkYXRhKTsKKworCS8qCisJKiBBR1BTIHJlbGF0ZWQgZnVuY3Rpb25zLCBp
bmNsdWRpbmcgTENTIGZyYW1lIGZvcndhcmRpbmcgYW5kCisJKiBmaW5lIHRpbWUgaW5qZWN0aW9u
CisJKi8KK3N0cnVjdCBvZm9ub19hZ3BzX2RyaXZlciB7CisJY29uc3QgY2hhciAqbmFtZTsKKwlp
bnQgKCpwcm9iZSkoc3RydWN0IG9mb25vX2FncHMgKmFncHMsIHVuc2lnbmVkIGludCB2ZW5kb3Is
CisJCQl2b2lkICpkYXRhKTsKKwl2b2lkICgqcmVtb3ZlKShzdHJ1Y3Qgb2Zvbm9fYWdwcyAqYWdw
cyk7CisJdm9pZCAoKnJlY2VpdmVfbGNzX2ZyYW1lcykoc3RydWN0IG9mb25vX2FncHMgKmFncHMs
IGludCBlbmFibGVkLAorCQkJb2Zvbm9fYWdwc19yZWNlaXZlX2xjc19mcmFtZV9jYl90IGNiLCB2
b2lkICpkYXRhKTsKKworCS8qIEFzc2lzdGFuY2UgRGF0YSBhbmQgUG9zaXRpb24gUmVxdWVzdHMg
ZnJvbSB0aGUgTW9iaWxlIE5ldHdvcmsgYXJlCisJICogc2lnbmFsbGVkIHZpYSB0aGUgb2Zvbm9f
YWdwc19sY3NfZnJhbWVfbm90aWZ5IGZ1bmN0aW9uIGFuZCB0aGUKKwkgKiBvRm9ubyBjb3JlIHRv
IGFuIGV4dGVybmFsIEdQUyBtYW5hZ2VyLiBUaGlzIEdQUyBtYW5hZ2VyIGNhbiByZXBseQorCSAq
IHRvIFBvc2l0aW9uIFJlcXVlc3RzIHdpdGggb25lIG9yIG1vcmUgUG9zaXRpb24gUmVzcG9uc2Vz
IHdoaWNoCisJICogYXJlIHRoZW4gc2VuZCBiYWNrIHRvIHRoZSBtb2RlbSB2aWEgdGhlIHNlbmRf
bGNzX2ZyYW1lIGZ1bmN0aW9uLgorCSAqLworCXZvaWQgKCpzZW5kX2xjc19mcmFtZSkoc3RydWN0
IG9mb25vX2FncHMgKmFncHMsCisJCQlzdHJ1Y3Qgb2Zvbm9fbGNzX2ZyYW1lICpmcmFtZSwKKwkJ
CW9mb25vX2FncHNfc2VuZF9sY3NfZnJhbWVfY2JfdCBjYiwgdm9pZCAqZGF0YSk7CisKKwkvKiBU
aGUgR1BTIG1hbmFnZXIgY2FuIGFzayB0aGUgbW9kZW0gdG8gZ2VuZXJhdGUgYSBIVyBwdWxzZSAo
dGltZQorCSAqIHN0YW1wKSB3aXRoIGEgZGVmaW5lZCBsZW5ndGggYW5kIHRoZSBtb2RlbSByZXBs
aWVzIGluZGljYXRlcyB3aGVuCisJICogaXQgZ2VuZXJhdGVzIHRoZSBwdWxzZS4gQnV0IGFzIHRo
ZSBtb2RlbSBoYXMgbm8gcHJlY2lzZSBpZGVhIG9mCisJICogVW5pdmVyc2FsIFRpbWUsIGl0IGlu
ZGljYXRlcyBhdCB3aGljaCByYWRpbyBmcmFtZSBudW1iZXIgaXQKKwkgKiBnZW5lcmF0ZWQgdGhl
IHB1bHNlLiBUaGUgR1BTIG1hbmFnZXIgd2hpY2gga25vd3MgdGhlIGxpbmsgYmV0d2VlbgorCSAq
IFVuaXZlcnNhbCBUaW1lIGFuZCB0aGUgUmFkaW8gRnJhbWUgbnVtYmVyIGtub3dzIHZlcnkgcHJl
Y2lzZWx5IGF0CisJICogd2hhdCB0aW1lIHRoZSBwdWxzZSB3YXMgZ2VuZXJhdGVkIGFuZCBpdHMg
ZHVyYXRpb24uCisJICoKKwkgKiBUaW1pbmcgYWNjdXJhY3kgaXMgdHlwaWNhbGx5IGEgZmV3IG1p
Y3Jvc2Vjb25kcy4KKwkgKi8KKwl2b2lkICgqaW5qZWN0X3RpbWUpKHN0cnVjdCBvZm9ub19hZ3Bz
ICphZ3BzLAorCWludCByYWRpb19hY2Nlc3NfdGVjaG5vbG9neSwgLyogZW51bSBhY2Nlc3NfdGVj
aG5vbG9neSAqLworCWludCBwdWxzZV9sZW5ndGgsIC8qIGR1cmF0aW9uIG9mIHB1bHNlIGluIHJh
ZGlvIHNsb3RzICovCisJb2Zvbm9fYWdwc19pbmplY3RfdGltZV9jYl90IGNiLCB2b2lkICpkYXRh
KTsKK307CisKK2ludCBvZm9ub19hZ3BzX2RyaXZlcl9yZWdpc3Rlcihjb25zdCBzdHJ1Y3Qgb2Zv
bm9fYWdwc19kcml2ZXIgKmQpOwordm9pZCBvZm9ub19hZ3BzX2RyaXZlcl91bnJlZ2lzdGVyKGNv
bnN0IHN0cnVjdCBvZm9ub19hZ3BzX2RyaXZlciAqZCk7CisKK3N0cnVjdCBvZm9ub19hZ3BzICpv
Zm9ub19hZ3BzX2NyZWF0ZShzdHJ1Y3Qgb2Zvbm9fbW9kZW0gKm1vZGVtLAorCQkJCQl1bnNpZ25l
ZCBpbnQgdmVuZG9yLCBjb25zdCBjaGFyICpkcml2ZXIsCisJCQkJCXZvaWQgKmRhdGEpOworCit2
b2lkIG9mb25vX2FncHNfcmVnaXN0ZXIoc3RydWN0IG9mb25vX2FncHMgKmFncHMpOwordm9pZCBv
Zm9ub19hZ3BzX3JlbW92ZShzdHJ1Y3Qgb2Zvbm9fYWdwcyAqYWdwcyk7CisKK3ZvaWQgb2Zvbm9f
YWdwc19zZXRfZGF0YShzdHJ1Y3Qgb2Zvbm9fYWdwcyAqYWdwcywgdm9pZCAqZGF0YSk7Cit2b2lk
ICpvZm9ub19hZ3BzX2dldF9kYXRhKHN0cnVjdCBvZm9ub19hZ3BzICphZ3BzKTsKKwordm9pZCBv
Zm9ub19hZ3BzX2xjc19mcmFtZV9ub3RpZnkoc3RydWN0IG9mb25vX2FncHMgKmFncHMsCisJCQlz
dHJ1Y3Qgb2Zvbm9fbGNzX2ZyYW1lIGZyYW1lKTsKKworI2lmZGVmIF9fY3BsdXNwbHVzCit9Cisj
ZW5kaWYKKworI2VuZGlmIC8qIF9fT0ZPTk9fQUdQU19IICovCmRpZmYgLS1naXQgYS9pbmNsdWRl
L2RidXMuaCBiL2luY2x1ZGUvZGJ1cy5oCmluZGV4IDU5YjJhYWUuLmM0MGNlOGEgMTAwNjQ0Ci0t
LSBhL2luY2x1ZGUvZGJ1cy5oCisrKyBiL2luY2x1ZGUvZGJ1cy5oCkBAIC01Myw2ICs1Myw3IEBA
IGV4dGVybiAiQyIgewogI2RlZmluZSBPRk9OT19WT0lDRUNBTExfTUFOQUdFUl9JTlRFUkZBQ0Ug
Im9yZy5vZm9uby5Wb2ljZUNhbGxNYW5hZ2VyIgogI2RlZmluZSBPRk9OT19TVEtfSU5URVJGQUNF
IE9GT05PX1NFUlZJQ0UgIi5TaW1Ub29sa2l0IgogI2RlZmluZSBPRk9OT19TSU1fQVBQX0lOVEVS
RkFDRSBPRk9OT19TRVJWSUNFICIuU2ltVG9vbGtpdEFnZW50IgorI2RlZmluZSBPRk9OT19BR1BT
X01BTkFHRVJfSU5URVJGQUNFICJvcmcub2Zvbm8uQWdwc01hbmFnZXIiCiAKIC8qIEVzc2VudGlh
bGx5IGF7c3Z9ICovCiAjZGVmaW5lIE9GT05PX1BST1BFUlRJRVNfQVJSQVlfU0lHTkFUVVJFIERC
VVNfRElDVF9FTlRSWV9CRUdJTl9DSEFSX0FTX1NUUklORyBcCmRpZmYgLS1naXQgYS9wbHVnaW5z
L2lmeC5jIGIvcGx1Z2lucy9pZnguYwppbmRleCAwMzcyNzNhLi4zZDI2YjRkIDEwMDY0NAotLS0g
YS9wbHVnaW5zL2lmeC5jCisrKyBiL3BsdWdpbnMvaWZ4LmMKQEAgLTU3LDEyICs1NywxMyBAQAog
I2luY2x1ZGUgPG9mb25vL3JhZGlvLXNldHRpbmdzLmg+CiAjaW5jbHVkZSA8b2Zvbm8vYXVkaW8t
c2V0dGluZ3MuaD4KICNpbmNsdWRlIDxvZm9uby9zdGsuaD4KKyNpbmNsdWRlIDxvZm9uby9hZ3Bz
Lmg+CiAjaW5jbHVkZSA8b2Zvbm8vbG9nLmg+CiAKICNpbmNsdWRlIDxkcml2ZXJzL2F0bW9kZW0v
YXR1dGlsLmg+CiAjaW5jbHVkZSA8ZHJpdmVycy9hdG1vZGVtL3ZlbmRvci5oPgogCi0jZGVmaW5l
IE5VTV9ETEMgIDYKKyNkZWZpbmUgTlVNX0RMQyAgNwogCiAjZGVmaW5lIFZPSUNFX0RMQyAgIDAK
ICNkZWZpbmUgTkVUUkVHX0RMQyAgMQpAQCAtNzAsMTMgKzcxLDE2IEBACiAjZGVmaW5lIEdQUlMy
X0RMQyAgIDMKICNkZWZpbmUgR1BSUzNfRExDICAgNAogI2RlZmluZSBBVVhfRExDICAgICA1Cisj
ZGVmaW5lIEFHUFNfRExDICAgIDYKIAogc3RhdGljIGNoYXIgKmRsY19wcmVmaXhlc1tOVU1fRExD
XSA9IHsgIlZvaWNlOiAiLCAiTmV0OiAiLCAiR1BSUzE6ICIsCi0JCQkJCSJHUFJTMjogIiwgIkdQ
UlMzOiAiLCAiQXV4OiAiIH07CisJCQkJCSJHUFJTMjogIiwgIkdQUlMzOiAiLAorCQkJCQkiQXV4
OiAiLCAgIkFHUFM6ICIgfTsKIAogc3RhdGljIGNvbnN0IGNoYXIgKmRsY19ub2Rlc1tOVU1fRExD
XSA9IHsgIi9kZXYvdHR5R1NNMSIsICIvZGV2L3R0eUdTTTIiLAogCQkJCQkiL2Rldi90dHlHU00z
IiwgIi9kZXYvdHR5R1NNNCIsCi0JCQkJCSIvZGV2L3R0eUdTTTUiLCAiL2Rldi90dHlHU002IiB9
OworCQkJCQkiL2Rldi90dHlHU001IiwgIi9kZXYvdHR5R1NNNiIsCisJCQkJCSIvZGV2L3R0eUdT
TTcifTsKIAogc3RhdGljIGNvbnN0IGNoYXIgKm5vbmVfcHJlZml4W10gPSB7IE5VTEwgfTsKIHN0
YXRpYyBjb25zdCBjaGFyICp4ZHJ2X3ByZWZpeFtdID0geyAiK1hEUlY6IiwgTlVMTCB9OwpAQCAt
NzU0LDYgKzc1OCw4IEBAIHN0YXRpYyB2b2lkIGlmeF9wb3N0X29ubGluZShzdHJ1Y3Qgb2Zvbm9f
bW9kZW0gKm1vZGVtKQogCQkJCQkiaWZ4bW9kZW0iLCBkYXRhLT5kbGNzW0dQUlMzX0RMQ10pOwog
CQlpZiAoZ2MpCiAJCQlvZm9ub19ncHJzX2FkZF9jb250ZXh0KGdwcnMsIGdjKTsKKworCQlvZm9u
b19hZ3BzX2NyZWF0ZShtb2RlbSwgMCwgImlmeG1vZGVtIiwgZGF0YS0+ZGxjc1tBR1BTX0RMQ10p
OwogCX0KIH0KIApkaWZmIC0tZ2l0IGEvc3JjL2FncHMuYyBiL3NyYy9hZ3BzLmMKbmV3IGZpbGUg
bW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMC4uNTE2ZGRkYwotLS0gL2Rldi9udWxsCisrKyBiL3Ny
Yy9hZ3BzLmMKQEAgLTAsMCArMSwyMjkgQEAKKy8qCisgKgorICogIG9Gb25vIC0gT3BlbiBTb3Vy
Y2UgVGVsZXBob255CisgKgorICogIENvcHlyaWdodCAoQykgMjAwOC0yMDEwICBJbnRlbCBDb3Jw
b3JhdGlvbi4gQWxsIHJpZ2h0cyByZXNlcnZlZC4KKyAqCisgKiAgVGhpcyBwcm9ncmFtIGlzIGZy
ZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkKKyAqICBp
dCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIHZlcnNp
b24gMiBhcworICogIHB1Ymxpc2hlZCBieSB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uLgor
ICoKKyAqICBUaGlzIHByb2dyYW0gaXMgZGlzdHJpYnV0ZWQgaW4gdGhlIGhvcGUgdGhhdCBpdCB3
aWxsIGJlIHVzZWZ1bCwKKyAqICBidXQgV0lUSE9VVCBBTlkgV0FSUkFOVFk7IHdpdGhvdXQgZXZl
biB0aGUgaW1wbGllZCB3YXJyYW50eSBvZgorICogIE1FUkNIQU5UQUJJTElUWSBvciBGSVRORVNT
IEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9TRS4gIFNlZSB0aGUKKyAqICBHTlUgR2VuZXJhbCBQdWJs
aWMgTGljZW5zZSBmb3IgbW9yZSBkZXRhaWxzLgorICoKKyAqICBZb3Ugc2hvdWxkIGhhdmUgcmVj
ZWl2ZWQgYSBjb3B5IG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZQorICogIGFsb25n
IHdpdGggdGhpcyBwcm9ncmFtOyBpZiBub3QsIHdyaXRlIHRvIHRoZSBGcmVlIFNvZnR3YXJlCisg
KiAgRm91bmRhdGlvbiwgSW5jLiwgNTEgRnJhbmtsaW4gU3QsIEZpZnRoIEZsb29yLCBCb3N0b24s
IE1BICAwMjExMC0xMzAxICBVU0EKKyAqCisgKi8KKworI2lmZGVmIEhBVkVfQ09ORklHX0gKKyNp
bmNsdWRlIDxjb25maWcuaD4KKyNlbmRpZgorCisjaW5jbHVkZSA8c3RyaW5nLmg+CisjaW5jbHVk
ZSA8c3RkaW8uaD4KKyNpbmNsdWRlIDx0aW1lLmg+CisjaW5jbHVkZSA8ZXJybm8uaD4KKworI2lu
Y2x1ZGUgPGdsaWIuaD4KKyNpbmNsdWRlIDxnZGJ1cy5oPgorCisjaW5jbHVkZSA8b2Zvbm8vbG9n
Lmg+CisjaW5jbHVkZSA8b2Zvbm8vZGJ1cy5oPgorI2luY2x1ZGUgPG9mb25vL21vZGVtLmg+CisK
KyNpbmNsdWRlICJvZm9uby5oIgorI2luY2x1ZGUgImNvbW1vbi5oIgorI2luY2x1ZGUgInV0aWwu
aCIKKworc3RhdGljIEdTTGlzdCAqZ19kcml2ZXJzOworCitzdHJ1Y3Qgb2Zvbm9fYWdwcyB7CisJ
Y29uc3Qgc3RydWN0IG9mb25vX2FncHNfZHJpdmVyICpkcml2ZXI7CisJdm9pZCAqZHJpdmVyX2Rh
dGE7CisJc3RydWN0IG9mb25vX2F0b20gKmF0b207CisJZ2Jvb2xlYW4gbGNzX2VuYWJsZWQ7CisJ
Z2Jvb2xlYW4gbGNzX2VuYWJsZWRfcGVuZGluZzsKKwlEQnVzTWVzc2FnZSAqcGVuZGluZzsKKwll
bnVtIG9mb25vX2FjY2Vzc190ZWNobm9sb2d5IGFjY2Vzc190ZWNoOworCS8qVE9ETyAtIEltcGxl
bWVudCAgY29kZSBoZXJlICAqLworfTsKKworc3RhdGljIERCdXNNZXNzYWdlICphZ3BzX2dldF9w
cm9wZXJ0aWVzKERCdXNDb25uZWN0aW9uICpjb25uLAorCQkJCQkJREJ1c01lc3NhZ2UgKm1zZywg
dm9pZCAqZGF0YSkKK3sKKwkvKiBUT0RPIC0gSW1wbGVtZW50ICBjb2RlIGhlcmUgICovCisJcmV0
dXJuIG1zZzsKK30KKworc3RhdGljIERCdXNNZXNzYWdlICphZ3BzX3NldF9wcm9wZXJ0eShEQnVz
Q29ubmVjdGlvbiAqY29ubiwgREJ1c01lc3NhZ2UgKm1zZywKKwkJCQkJdm9pZCAqZGF0YSkKK3sK
KwkvKiBUT0RPIC0gSW1wbGVtZW50ICBjb2RlIGhlcmUgICovCisJcmV0dXJuIG1zZzsKK30KKwor
c3RhdGljIERCdXNNZXNzYWdlICphZ3BzX3NlbmRfbGNzX2ZyYW1lKERCdXNDb25uZWN0aW9uICpj
b25uLCBEQnVzTWVzc2FnZSAqbXNnLAorCQkJCQl2b2lkICpkYXRhKQoreworCS8qIFRPRE8gLSBJ
bXBsZW1lbnQgIGNvZGUgaGVyZSAgKi8KKwlyZXR1cm4gbXNnOworfQorCitzdGF0aWMgREJ1c01l
c3NhZ2UgKmFncHNfcmVxdWVzdF9maW5lX3RpbWVfaW5qZWN0aW9uKERCdXNDb25uZWN0aW9uICpj
b25uLAorCQkJCQkJCURCdXNNZXNzYWdlICptc2csCisJCQkJCQkJdm9pZCAqZGF0YSkKK3sKKwkv
KiBUT0RPIC0gSW1wbGVtZW50ICBjb2RlIGhlcmUgICovCisJcmV0dXJuIG1zZzsKK30KKworc3Rh
dGljIEdEQnVzTWV0aG9kVGFibGUgYWdwc19tZXRob2RzW10gPSB7CisJeyAiR2V0UHJvcGVydGll
cyIsICIiLAkiYXtzdn0iLCBhZ3BzX2dldF9wcm9wZXJ0aWVzIH0sCisJeyAiU2V0UHJvcGVydHki
LCAic3YiLAkiIiwgYWdwc19zZXRfcHJvcGVydHkgfSwKKwl7ICJTZW5kTENTRnJhbWUiLCAic3Yi
LAkiIiwgYWdwc19zZW5kX2xjc19mcmFtZSB9LAorCXsgIlJlcXVlc3RGaW5lVGltZUluamVjdGlv
biIsICJzdiIsCSIiLAorCQlhZ3BzX3JlcXVlc3RfZmluZV90aW1lX2luamVjdGlvbiB9LAorCXsg
fQorfTsKKworc3RhdGljIEdEQnVzU2lnbmFsVGFibGUgYWdwc19zaWduYWxzW10gPSB7CisJeyAi
UHJvcGVydHlDaGFuZ2VkIiwJCQkJInN2IiB9LAorCXsgIkluY29taW5nTENTRnJhbWUiLAkJCQki
c3EiIH0sCisJeyAiRmluZVRpbWVJbmplY3Rpb25Ob3RpZmljYXRpb24iLAkic3EiIH0sCisKKwl7
IH0KK307CisKK3N0YXRpYyB2b2lkIGFncHNfdW5yZWdpc3RlcihzdHJ1Y3Qgb2Zvbm9fYXRvbSAq
YXRvbSkKK3sKKwlEQnVzQ29ubmVjdGlvbiAqY29ubiA9IG9mb25vX2RidXNfZ2V0X2Nvbm5lY3Rp
b24oKTsKKwlzdHJ1Y3Qgb2Zvbm9fYWdwcyAqYWdwcyA9IF9fb2Zvbm9fYXRvbV9nZXRfZGF0YShh
dG9tKTsKKwlzdHJ1Y3Qgb2Zvbm9fbW9kZW0gKm1vZGVtID0gX19vZm9ub19hdG9tX2dldF9tb2Rl
bShhdG9tKTsKKwljb25zdCBjaGFyICpwYXRoID0gX19vZm9ub19hdG9tX2dldF9wYXRoKGF0b20p
OworCisJZ19kYnVzX3VucmVnaXN0ZXJfaW50ZXJmYWNlKGNvbm4sIHBhdGgsIE9GT05PX0FHUFNf
TUFOQUdFUl9JTlRFUkZBQ0UpOworCW9mb25vX21vZGVtX3JlbW92ZV9pbnRlcmZhY2UobW9kZW0s
IE9GT05PX0FHUFNfTUFOQUdFUl9JTlRFUkZBQ0UpOworCWFncHMtPmxjc19lbmFibGVkID0gRkFM
U0U7Cit9CisKK3ZvaWQgb2Zvbm9fYWdwc19yZWdpc3RlcihzdHJ1Y3Qgb2Zvbm9fYWdwcyAqYWdw
cykKK3sKKwlzdHJ1Y3Qgb2Zvbm9fbW9kZW0gKm1vZGVtID0gX19vZm9ub19hdG9tX2dldF9tb2Rl
bShhZ3BzLT5hdG9tKTsKKwljb25zdCBjaGFyICpwYXRoID0gX19vZm9ub19hdG9tX2dldF9wYXRo
KGFncHMtPmF0b20pOworCURCdXNDb25uZWN0aW9uICpjb25uID0gb2Zvbm9fZGJ1c19nZXRfY29u
bmVjdGlvbigpOworCisJaWYgKCFnX2RidXNfcmVnaXN0ZXJfaW50ZXJmYWNlKGNvbm4sIHBhdGgs
CisJCQlPRk9OT19BR1BTX01BTkFHRVJfSU5URVJGQUNFLAorCQkJYWdwc19tZXRob2RzLAorCQkJ
YWdwc19zaWduYWxzLAorCQkJTlVMTCwgTlVMTCwgTlVMTCkpIHsKKwkJb2Zvbm9fZXJyb3IoImFn
cHNfZGJ1c19yZWdpc3RlcjpDb3VsZCBub3QgcmVnaXN0ZXIgQUdQUyBNYW5hZ2VyIgorCQkiSW50
ZXJmYWNlL1BhdGgiKTsKKwkJcmV0dXJuOworCX0KKworCW9mb25vX21vZGVtX2FkZF9pbnRlcmZh
Y2UobW9kZW0sIE9GT05PX0FHUFNfTUFOQUdFUl9JTlRFUkZBQ0UpOworCV9fb2Zvbm9fYXRvbV9y
ZWdpc3RlcihhZ3BzLT5hdG9tLCBhZ3BzX3VucmVnaXN0ZXIpOworfQorCit2b2lkIG9mb25vX2Fn
cHNfcmVtb3ZlKHN0cnVjdCBvZm9ub19hZ3BzICphZ3BzKQoreworCV9fb2Zvbm9fYXRvbV9mcmVl
KGFncHMtPmF0b20pOworfQorCitzdGF0aWMgdm9pZCBhZ3BzX3JlbW92ZShzdHJ1Y3Qgb2Zvbm9f
YXRvbSAqYXRvbSkKK3sKKwlzdHJ1Y3Qgb2Zvbm9fYWdwcyAqYWdwcyA9IF9fb2Zvbm9fYXRvbV9n
ZXRfZGF0YShhdG9tKTsKKworCURCRygiYXRvbTogJXAiLCBhdG9tKTsKKworCWlmIChhZ3BzID09
IE5VTEwpCisJCXJldHVybjsKKworCWdfZnJlZShhZ3BzKTsKK30KKwordm9pZCBvZm9ub19hZ3Bz
X3NldF9kYXRhKHN0cnVjdCBvZm9ub19hZ3BzICphZ3BzLCB2b2lkICpkYXRhKQoreworCWFncHMt
PmRyaXZlcl9kYXRhID0gZGF0YTsKK30KKwordm9pZCAqb2Zvbm9fYWdwc19nZXRfZGF0YShzdHJ1
Y3Qgb2Zvbm9fYWdwcyAqYWdwcykKK3sKKwlyZXR1cm4gYWdwcy0+ZHJpdmVyX2RhdGE7Cit9CisK
K3N0cnVjdCBvZm9ub19hZ3BzICpvZm9ub19hZ3BzX2NyZWF0ZShzdHJ1Y3Qgb2Zvbm9fbW9kZW0g
Km1vZGVtLAorCQkJCQl1bnNpZ25lZCBpbnQgdmVuZG9yLAorCQkJCQljb25zdCBjaGFyICpkcml2
ZXIsCisJCQkJCXZvaWQgKmRhdGEpCit7CisJc3RydWN0IG9mb25vX2FncHMgKmFncHM7CisJR1NM
aXN0ICpsOworCisJaWYgKGRyaXZlciA9PSBOVUxMKQorCQlyZXR1cm4gTlVMTDsKKworCWFncHMg
PSBnX3RyeV9uZXcwKHN0cnVjdCBvZm9ub19hZ3BzLCAxKTsKKworCWlmIChhZ3BzID09IE5VTEwp
CisJCXJldHVybiBOVUxMOworCisJYWdwcy0+YXRvbSA9IF9fb2Zvbm9fbW9kZW1fYWRkX2F0b20o
bW9kZW0sIE9GT05PX0FUT01fVFlQRV9BR1BTLAorCQkJCQkJYWdwc19yZW1vdmUsIGFncHMpOwor
CisJZm9yIChsID0gZ19kcml2ZXJzOyBsOyBsID0gbC0+bmV4dCkgeworCQljb25zdCBzdHJ1Y3Qg
b2Zvbm9fYWdwc19kcml2ZXIgKmRydiA9IGwtPmRhdGE7CisKKwkJaWYgKGdfc3RyY21wMChkcnYt
Pm5hbWUsIGRyaXZlcikpCisJCQljb250aW51ZTsKKworCQlpZiAoZHJ2LT5wcm9iZShhZ3BzLCB2
ZW5kb3IsIGRhdGEpIDwgMCkKKwkJCWNvbnRpbnVlOworCisJCWFncHMtPmRyaXZlciA9IGRydjsK
KwkJYnJlYWs7CisJfQorCXJldHVybiBhZ3BzOworfQorCitpbnQgb2Zvbm9fYWdwc19kcml2ZXJf
cmVnaXN0ZXIoY29uc3Qgc3RydWN0IG9mb25vX2FncHNfZHJpdmVyICpkKQoreworCURCRygiZHJp
dmVyOiAlcCwgbmFtZTogJXMiLCBkLCBkLT5uYW1lKTsKKworCWlmIChkLT5wcm9iZSA9PSBOVUxM
KQorCQlyZXR1cm4gLUVJTlZBTDsKKworCWdfZHJpdmVycyA9IGdfc2xpc3RfcHJlcGVuZChnX2Ry
aXZlcnMsICh2b2lkICopZCk7CisKKwlyZXR1cm4gMDsKK30KKwordm9pZCBvZm9ub19hZ3BzX2Ry
aXZlcl91bnJlZ2lzdGVyKGNvbnN0IHN0cnVjdCBvZm9ub19hZ3BzX2RyaXZlciAqZCkKK3sKKwlE
QkcoImRyaXZlcjogJXAsIG5hbWU6ICVzIiwgZCwgZC0+bmFtZSk7CisKKwlnX2RyaXZlcnMgPSBn
X3NsaXN0X3JlbW92ZShnX2RyaXZlcnMsICh2b2lkICopZCk7Cit9CisKK3ZvaWQgb2Zvbm9fYWdw
c19sY3NfZnJhbWVfbm90aWZ5KHN0cnVjdCBvZm9ub19hZ3BzICphZ3BzLAorCQkJc3RydWN0IG9m
b25vX2xjc19mcmFtZSBmcmFtZSkKK3sKKworCURCdXNDb25uZWN0aW9uICpjb25uID0gb2Zvbm9f
ZGJ1c19nZXRfY29ubmVjdGlvbigpOworCWNvbnN0IGNoYXIgKnBhdGggPSBfX29mb25vX2F0b21f
Z2V0X3BhdGgoYWdwcy0+YXRvbSk7CisKKwlnX2RidXNfZW1pdF9zaWduYWwoY29ubiwgcGF0aCwg
T0ZPTk9fQUdQU19NQU5BR0VSX0lOVEVSRkFDRSwKKwkJCQkiUG9zaXRpb25SZXF1ZXN0IiwKKwkJ
CQlEQlVTX1RZUEVfVUlOVDE2LCAmZnJhbWUubGNzX2ZyYW1lX3R5cGUsCisJCQkJREJVU19UWVBF
X1VJTlQxNiwgJmZyYW1lLmZyYW1lX2xlbmd0aCwKKwkJCQlEQlVTX1RZUEVfU1RSSU5HLCAmZnJh
bWUucmF3X2ZyYW1lLAorCQkJCURCVVNfVFlQRV9JTlZBTElEKTsKK30KKworCisKZGlmZiAtLWdp
dCBhL3NyYy9vZm9uby5oIGIvc3JjL29mb25vLmgKaW5kZXggYmQ3ZjMzYy4uODA0ODMzMCAxMDA2
NDQKLS0tIGEvc3JjL29mb25vLmgKKysrIGIvc3JjL29mb25vLmgKQEAgLTEyNCw2ICsxMjQsNyBA
QCBlbnVtIG9mb25vX2F0b21fdHlwZSB7CiAJT0ZPTk9fQVRPTV9UWVBFX0FVRElPX1NFVFRJTkdT
ID0gMTksCiAJT0ZPTk9fQVRPTV9UWVBFX1NUSyA9IDIwLAogCU9GT05PX0FUT01fVFlQRV9ORVRU
SU1FID0gMjEsCisJT0ZPTk9fQVRPTV9UWVBFX0FHUFMgPSAyMiwKIH07CiAKIGVudW0gb2Zvbm9f
YXRvbV93YXRjaF9jb25kaXRpb24gewpAQCAtMTk5LDYgKzIwMCw3IEBAIGdib29sZWFuIF9fb2Zv
bm9fY2FsbF9zZXR0aW5nc19pc19idXN5KHN0cnVjdCBvZm9ub19jYWxsX3NldHRpbmdzICpjcyk7
CiAjaW5jbHVkZSA8b2Zvbm8vYXVkaW8tc2V0dGluZ3MuaD4KIAogI2luY2x1ZGUgPG9mb25vL3Zv
aWNlY2FsbC5oPgorI2luY2x1ZGUgPG9mb25vL2FncHMuaD4KIAogZW51bSBvZm9ub192b2ljZWNh
bGxfaW50ZXJhY3Rpb24gewogCU9GT05PX1ZPSUNFQ0FMTF9JTlRFUkFDVElPTl9OT05FCT0gMCwK
LS0gCjEuNy4wLjQKCg==

--===============4338460350675608899==--

