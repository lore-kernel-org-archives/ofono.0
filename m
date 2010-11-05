Content-Type: multipart/mixed; boundary="===============0403361257343002742=="
MIME-Version: 1.0
From: Robertino Benis <robertino.benis@intel.com>
Subject: [RFC 2/3] agps: adding agps related functions
Date: Fri, 05 Nov 2010 10:55:26 -0700
Message-ID: <1288979728-3369-3-git-send-email-robertino.benis@intel.com>
In-Reply-To: <1288979728-3369-1-git-send-email-robertino.benis@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0403361257343002742==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/agps.h |  157 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 157 insertions(+), 0 deletions(-)
 create mode 100644 include/agps.h

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
+	RRLP_ASSISTANCE_DATA =3D 0,		/* from modem */
+	/* Position request can include assistance data as well */
+	RRLP_MEASURE_POSITION_REQUEST =3D 1,	/* from modem */
+	RRLP_MEASURE_POSITION_RESPONSE =3D 2,	/* from GPS */
+	RRC_ASSISTANCE_DATA_DELIVERY =3D 3,	/* from modem */
+	/* Measurement control can include assistance data as well */
+	RRC_MEASUREMENT_CONTROL =3D 4,		/* from modem */
+	RRC_MEASUREMENT_REPORT =3D 5,		/* from GPS */
+};
+
+enum ofono_access_technology {
+	RADIO_ACCESS_TECHNOLOGY_GSM =3D 0,		/* GSM */
+	RADIO_ACCESS_TECHNOLOGY_UMTS =3D 1,		/* UMTS */
+};
+
+enum ofono_rrc_state {
+	RRC_CELL_PCH =3D 0,
+	RRC_CELL_FACH =3D 1,
+	RRC_CELL_DCH =3D 2,
+	RRC_URA_PCH =3D 3,
+};
+
+struct ofono_lcs_frame {
+	enum ofono_lcs_frame_type lcs_frame_type;
+	int frame_length;	/* size of raw_frame in bytes */
+	unsigned char  *raw_frame;
+};
+
+struct ofono_lcs_gsm_fn {
+	int TDMA_frame_number;	/* range 0 - 2715647 (2048*26*51) */
+	int TDMA_timeslot;		/* range 0 - 7 */
+	int timeslot_bit;		/* range 0 - 156 */
+	int timing_advance;		/* range 0 - 63 */
+	int bcch_arfcn;			/* range 0 - 1023 */
+	int bsic;				/* range 0 - 64 */
+};
+
+struct ofono_lcs_utran_fn {
+	int sfn;				/* range 0 - 4095 */
+	int rrc_state;			/* enum ofono_rrc_state */
+	int round_trip_time;	/* range 0 - 32766 */
+};
+
+struct ofono_lcs_radio_fn {
+	int radio_access_technology; /* enum access_technology */
+	union {
+		struct ofono_lcs_gsm_fn		gsm_frame_number;
+		struct ofono_lcs_utran_fn	utran_frame_number;
+	};
+};
+
+struct ofono_agps;
+
+typedef void (*ofono_agps_send_lcs_frame_cb_t)(const struct ofono_error *e=
rror,
+				void *data);
+typedef void (*ofono_agps_receive_lcs_frame_cb_t)(
+				const struct ofono_error *error,
+				void *data);
+typedef void (*ofono_agps_inject_time_cb_t)(const struct ofono_error *erro=
r,
+				struct ofono_lcs_radio_fn *radio_frame_number,
+				void *data);
+
+	/*
+	 * AGPS related functions, including LCS frame forwarding and
+	 * fine time injection
+	 */
+struct ofono_agps_driver {
+	const char *name;
+	int (*probe)(struct ofono_agps *agps, unsigned int vendor,
+			void *data);
+	void (*remove)(struct ofono_agps *agps);
+
+	/* The GPS manager can configure the modem to notify Assistance Data and
+	 * Position Requests from the Mobile Network by setting the LcsEnabled
+	 * status to true. If false, no notifications are sent from modem.
+	 */
+	void (*receive_lcs_frames)(struct ofono_agps *agps, int enabled,
+			ofono_agps_receive_lcs_frame_cb_t cb, void *data);
+
+	/* Assistance Data and Position Requests from the Mobile Network are
+	 * signalled via the ofono_agps_lcs_frame_notify function and the
+	 * oFono core to an external GPS manager. This GPS manager can reply
+	 * to Position Requests with one or more Position Responses which
+	 * are then send back to the modem via the send_lcs_frame function.
+	 */
+	void (*send_lcs_frame)(struct ofono_agps *agps,
+			struct ofono_lcs_frame *frame,
+			ofono_agps_send_lcs_frame_cb_t cb, void *data);
+
+	/* The GPS manager can ask the modem to generate a HW pulse (time
+	 * stamp) with a defined length and the modem replies indicates when
+	 * it generates the pulse. But as the modem has no precise idea of
+	 * Universal Time, it indicates at which radio frame number it
+	 * generated the pulse. The GPS manager which knows the link between
+	 * Universal Time and the Radio Frame number knows very precisely at
+	 * what time the pulse was generated and its duration.
+	 *
+	 * Timing accuracy is typically a few microseconds.
+	 */
+	void (*inject_time)(struct ofono_agps *agps,
+	int radio_access_technology, /* enum access_technology */
+	int pulse_length, /* duration of pulse in radio slots */
+	ofono_agps_inject_time_cb_t cb, void *data);
+};
+
+int ofono_agps_driver_register(const struct ofono_agps_driver *d);
+void ofono_agps_driver_unregister(const struct ofono_agps_driver *d);
+
+struct ofono_agps *ofono_agps_create(struct ofono_modem *modem,
+					unsigned int vendor, const char *driver,
+					void *data);
+
+void ofono_agps_register(struct ofono_agps *agps);
+void ofono_agps_remove(struct ofono_agps *agps);
+
+void ofono_agps_set_data(struct ofono_agps *agps, void *data);
+void *ofono_agps_get_data(struct ofono_agps *agps);
+
+void ofono_agps_lcs_frame_notify(struct ofono_agps *agps,
+			struct ofono_lcs_frame frame);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __OFONO_AGPS_H */
-- =

1.7.0.4


--===============0403361257343002742==--

