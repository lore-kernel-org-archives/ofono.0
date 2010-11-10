Content-Type: multipart/mixed; boundary="===============6776899540703276898=="
MIME-Version: 1.0
From: Bastian, Waldo <waldo.bastian@intel.com>
Subject: RE: [RFC v2 3/3] ifxmodem: adding modem API to support agps
Date: Wed, 10 Nov 2010 12:34:40 -0800
Message-ID: <97D5E1BB8FC13D4EA3B34BAE8E6898C9014BEE2D64@orsmsx508.amr.corp.intel.com>
In-Reply-To: <1289418194-2905-5-git-send-email-robertino.benis@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6776899540703276898==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The error handling in ifx_agps_inject_time_cb needs to have a call to CALLB=
ACK_WITH_FAILURE.

Calling g_at_chat_register(agd->chat, "%%XFTI:", ...) from ifx_agps_inject_=
time_cb seems wrong:
- It gets called multiple times
- Are you sure that %XFTI can't come before the OK response?
- agd->chat should be data->chat

#define BUF_LEN should be removed as it isn't used

In ifx_agps_send_lcs_frame the raw_frame isn't hex encoded before it gets i=
nserted into the AT command.

Cheers,
Waldo

-----Original Message-----
From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On Behal=
f Of Robertino Benis
Sent: Wednesday, November 10, 2010 11:43 AM
To: ofono(a)ofono.org
Cc: Ahmed, Suhail
Subject: [RFC v2 3/3] ifxmodem: adding modem API to support agps

---
 drivers/ifxmodem/agps.c |  413 +++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 413 insertions(+), 0 deletions(-)
 create mode 100644 drivers/ifxmodem/agps.c

diff --git a/drivers/ifxmodem/agps.c b/drivers/ifxmodem/agps.c
new file mode 100644
index 0000000..4e8d427
--- /dev/null
+++ b/drivers/ifxmodem/agps.c
@@ -0,0 +1,413 @@
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
+	GAtChat *chat;
+	unsigned int vendor;
+	enum ofono_access_technology rad_acc_tech;
+};
+
+struct ofono_agps;
+static const char *none_prefix[] =3D { NULL };
+
+static void pos_request_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_agps *agps =3D user_data;
+	int framelen;
+	int frametype;
+	GAtResultIter iter;
+	struct ofono_lcs_frame lcsframe;
+	const char *frame;
+
+	/* Assuming Pos Req format: %XPOSR: <frametype>,<framelen>,<frame> */
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "%%XPOSR:"))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &frametype))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &framelen))
+		return;
+
+	frame =3D g_at_result_pdu(result);
+
+	DBG("AGPS POS Info: Type =3D %d Length =3D %d data =3D %s",
+			frametype, framelen, frame);
+
+	lcsframe.lcs_frame_type =3D frametype;
+	lcsframe.frame_length =3D framelen;
+	lcsframe.raw_frame =3D (unsigned char *)frame;
+
+	ofono_agps_lcs_frame_notify(agps, lcsframe);
+}
+
+static void inj_time_notify(GAtResult *result, gpointer user_data)
+{
+
+	struct cb_data *cbd =3D user_data;
+	struct agps_data *data =3D cbd->user;
+	ofono_agps_inject_time_cb_t cb =3D cbd->cb;
+	struct ofono_lcs_radio_fn rf;
+	struct ofono_error error =3D { .type =3D OFONO_ERROR_TYPE_NO_ERROR };
+	GAtResultIter iter;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "%%XFTI:"))
+		return;
+
+	if (data->rad_acc_tech =3D=3D RADIO_ACCESS_TECHNOLOGY_GSM) {
+
+		int fn;		/* range 0 - 2715647 (2048*26*51) */
+		int ts;		/* range 0 - 7 */
+		int tsb;	/* range 0 - 156 */
+		int ta;		/* range 0 - 63 */
+		int ba;		/* range 0 - 1023 */
+		int bc;		/* range 0 - 64 */
+
+	/*	 %XFTI:<frameNum>,<TimeSlot>,<TimeSlotBit>,<TimeAdv>,
+	*	<ChannelNum>,<ChannelId>
+	*/
+		if (!g_at_result_iter_next_number(&iter, &fn))
+			goto err;
+
+		if (!g_at_result_iter_next_number(&iter, &ts))
+			goto err;
+
+		if (!g_at_result_iter_next_number(&iter, &tsb))
+			goto err;
+
+		if (!g_at_result_iter_next_number(&iter, &ta))
+			goto err;
+
+		if (!g_at_result_iter_next_number(&iter, &ba))
+			goto err;
+
+		if (!g_at_result_iter_next_number(&iter, &bc))
+			goto err;
+
+		DBG("GSM Inject Response: fn =3D %d ts =3D %d tsb =3D %d ta =3D %d"
+				"ba =3D %d bc =3D %d ", fn, ts, tsb, ta, ba, bc);
+
+		rf.gsm_frame_number.TDMA_frame_number =3D fn;
+		rf.gsm_frame_number.TDMA_timeslot =3D ts;
+		rf.gsm_frame_number.timeslot_bit =3D tsb;
+		rf.gsm_frame_number.timing_advance =3D ta;
+		rf.gsm_frame_number.bcch_arfcn =3D ba;
+		rf.gsm_frame_number.bsic =3D bc;
+		rf.radio_access_technology =3D RADIO_ACCESS_TECHNOLOGY_GSM;
+
+	} else if (data->rad_acc_tech =3D=3D RADIO_ACCESS_TECHNOLOGY_UMTS) {
+
+		int sfn;	/* range 0 - 4095 */
+		int rs;		/* enum ofono_rrc_state */
+		int rt;		/* range 0 - 32766 */
+
+		/* %XFTI:<frameNum>,<RadioState>,<TripTime> */
+		if (!g_at_result_iter_next_number(&iter, &sfn))
+			goto err;
+
+		if (!g_at_result_iter_next_number(&iter, &rs))
+			goto err;
+
+		if (!g_at_result_iter_next_number(&iter, &rt))
+			goto err;
+
+		DBG("UMTS Inject Response: sfn =3D %d rs =3D %d tt =3D %d",
+				sfn, rs, rt);
+
+		rf.utran_frame_number.sfn =3D sfn;
+		rf.utran_frame_number.rrc_state =3D rs;
+		rf.utran_frame_number.round_trip_time =3D rt;
+		rf.radio_access_technology =3D RADIO_ACCESS_TECHNOLOGY_UMTS;
+
+	} else
+		goto err;
+
+	cb(&error, &rf, cbd->data);
+	return;
+
+err:
+	CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
+}
+
+static int ifx_agps_probe(struct ofono_agps *agps,
+					unsigned int vendor, void *data)
+{
+	GAtChat *chat =3D data;
+	struct agps_data *agd =3D ofono_agps_get_data(agps);
+
+	agd =3D g_try_new0(struct agps_data, 1);
+	if (!agd)
+		return -ENOMEM;
+
+	agd->chat =3D g_at_chat_clone(chat);
+	agd->vendor =3D vendor;
+
+	ofono_agps_set_data(agps, agd);
+
+	g_at_chat_register(agd->chat, "%%XPOSR:", pos_request_notify, TRUE,
+				agps, NULL);
+
+	ofono_agps_register(agps);
+
+	return 0;
+}
+
+static void ifx_agps_remove(struct ofono_agps *agps)
+{
+	struct agps_data *agd =3D ofono_agps_get_data(agps);
+
+	ofono_agps_remove(agps);
+	ofono_agps_set_data(agps, NULL);
+	g_at_chat_unref(agd->chat);
+	g_free(agd);
+}
+
+
+static void ifx_agps_receive_lcs_frame_cb(gboolean ok, GAtResult *result,
+				gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_agps_receive_lcs_frame_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+	cb(&error, cbd->data);
+}
+
+   /*
+	* The GPS manager can enable or disable AGPS manager  to receive
+	* lcs_frames from the Mobile network. If disabled, all Assistance Data
+	* and Position Requests from Mobile Network are not signalled to ofono.
+	*/
+static void ifx_agps_receive_lcs_frames(struct ofono_agps *agps,
+			int enabled, ofono_agps_receive_lcs_frame_cb_t cb,
+			void *user_data)
+{
+	struct agps_data *data =3D ofono_agps_get_data(agps);
+	struct cb_data *cbd =3D cb_data_new(cb, user_data);
+	char *commbuf;
+	unsigned int id;
+
+	if (!cbd)
+		goto error;
+
+	cbd->user =3D data;
+
+	commbuf =3D g_strdup_printf("AT%%XPOS=3D\"%d\"", enabled);
+
+	id =3D g_at_chat_send(data->chat, commbuf, none_prefix,
+				ifx_agps_receive_lcs_frame_cb, cbd, g_free);
+
+	g_free(commbuf);
+
+	if (id > 0)
+		return;
+error:
+	if (cbd)
+		g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, user_data);
+}
+
+static void ifx_agps_send_lcs_frame_cb(gboolean ok, GAtResult *result,
+				gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_agps_send_lcs_frame_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+	cb(&error, cbd->data);
+}
+
+#define BUF_LEN 128
+
+	/* Assistance Data and Position Requests from the Mobile Network are
+	 * signalled via the ofono_agps_lcs_frame_notify function and the
+	 * oFono core to an external GPS manager. This GPS manager can reply
+	 * to Position Requests with one or more Position Responses which
+	 * are then send back to the modem via the send_lcs_frame function.
+	 */
+static void ifx_agps_send_lcs_frame(struct ofono_agps *agps,
+				struct ofono_lcs_frame *frame,
+				ofono_agps_send_lcs_frame_cb_t cb,
+				void *user_data)
+{
+	struct agps_data *data =3D ofono_agps_get_data(agps);
+	struct cb_data *cbd =3D cb_data_new(cb, user_data);
+	char *cmdbuf;
+	unsigned int id;
+
+	if (!cbd)
+		goto error;
+
+	cbd->user =3D data;
+
+	if (!frame->frame_length) {
+		ofono_error("ifx_agps_send_lcs_frame: Frame length Invalid");
+		goto error;
+	}
+
+	DBG("AGPS Frame Info: Type =3D %d Length =3D %d data =3D %s",
+			frame->lcs_frame_type,
+			frame->frame_length,
+			frame->raw_frame);
+
+	cmdbuf =3D g_strdup_printf("AT%%XPOSR=3D%d,%d,\"%s\"",
+				frame->lcs_frame_type,
+				frame->frame_length,
+				frame->raw_frame);
+
+	id =3D g_at_chat_send(data->chat, cmdbuf, none_prefix,
+				ifx_agps_send_lcs_frame_cb, cbd, g_free);
+
+	g_free(cmdbuf);
+
+	if (id > 0)
+		return;
+error:
+	if (cbd)
+		g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, user_data);
+}
+
+static void ifx_agps_inject_time_cb(gboolean ok, GAtResult *result,
+				gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	struct agps_data *data =3D cbd->user;
+	ofono_agps_inject_time_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (!ok)
+		goto err;
+
+	g_at_chat_register(agd->chat, "%%XFTI:",
+					inj_time_notify, FALSE,
+					data, g_free);
+	return;
+
+err:
+	cb(&error, NULL, cbd->data);
+	g_free(cbd);
+}
+
+	/* The GPS manager can ask the modem to generate a HW
+	 * stamp) with a defined length and the modem replies indicates when
+	 * it generates the pulse. But as the modem has no precise idae of
+	 * Universal Time, it indicates at which radio frame number itgc
+	 * generated the pulse. The GPS manager which knows the link between
+	 * Universal Time and the Radio Frame number knows very precisely at
+	 * what time the pulse was generated and its duration.
+	 *
+	 * Timing accuracy is typically a few microseconds.
+	 */
+static void ifx_agps_inject_time(struct ofono_agps *agps,
+			int radio_access_technology,/* enum access_technology */
+			int pulse_length,/* duration of pulse in radio slots */
+			ofono_agps_inject_time_cb_t cb, void *user_data)
+{
+	struct agps_data *data =3D ofono_agps_get_data(agps);
+	struct cb_data *cbd =3D cb_data_new(cb, user_data);
+	char *buf;
+	unsigned int id;
+
+	if (!cbd)
+		goto error;
+
+	if (radio_access_technology =3D=3D RADIO_ACCESS_TECHNOLOGY_GSM) {
+		data->rad_acc_tech =3D radio_access_technology;
+		buf =3D g_strdup_printf("AT%%XFTI=3D\"%s%d\"", "GSM",
+						pulse_length);
+
+	} else if (radio_access_technology =3D=3D RADIO_ACCESS_TECHNOLOGY_UMTS) {
+			data->rad_acc_tech =3D radio_access_technology;
+			buf =3D g_strdup_printf("AT%%XFTI=3D\"%s%d\"", "UMTS",
+						pulse_length);
+	} else
+		goto error;
+
+	cbd->user =3D data;
+
+	id =3D g_at_chat_send(data->chat, buf, none_prefix,
+		    ifx_agps_inject_time_cb, cbd, g_free);
+
+	g_free(buf);
+
+	if (id > 0)
+		return;
+
+error:
+	if (cbd)
+		g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, NULL, user_data);
+}
+
+static struct ofono_agps_driver driver =3D {
+	.name					=3D "ifxmodem",
+	.probe					=3D ifx_agps_probe,
+	.remove					=3D ifx_agps_remove,
+	.receive_lcs_frames		=3D ifx_agps_receive_lcs_frames,
+	.send_lcs_frame			=3D ifx_agps_send_lcs_frame,
+	.inject_time			=3D ifx_agps_inject_time
+};
+
+void ifx_agps_init()
+{
+	ofono_agps_driver_register(&driver);
+}
+
+void ifx_agps_exit()
+{
+	ofono_agps_driver_unregister(&driver);
+}
+
-- =

1.7.0.4

_______________________________________________
ofono mailing list
ofono(a)ofono.org
http://lists.ofono.org/listinfo/ofono

--===============6776899540703276898==--

