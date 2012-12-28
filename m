Content-Type: multipart/mixed; boundary="===============3235817868127128005=="
MIME-Version: 1.0
From: Forest Bond <forest@alittletooquiet.net>
Subject: [PATCH 4/8] sierramodem: Report network registration status
Date: Fri, 28 Dec 2012 14:35:20 -0500
Message-ID: <20121228193520.GJ18339@alittletooquiet.net>
In-Reply-To: <20121228193141.GF18339@alittletooquiet.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3235817868127128005==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Forest Bond <forest.bond@rapidrollout.com>

The modem is polled every 5 seconds (unless inhibited by PPP)
using AT!STATUS.
---
 drivers/sierramodem/cdma-netreg.c |  300 +++++++++++++++++++++++++++++++++=
++++
 1 files changed, 300 insertions(+), 0 deletions(-)

diff --git a/drivers/sierramodem/cdma-netreg.c b/drivers/sierramodem/cdma-n=
etreg.c
index 109b245..4cca769 100644
--- a/drivers/sierramodem/cdma-netreg.c
+++ b/drivers/sierramodem/cdma-netreg.c
@@ -3,6 +3,9 @@
  *  oFono - Open Source Telephony
  *
  *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2008-2009  Novell, Inc.
+ *  Copyright (C) 2009-2012  Red Hat, Inc.
+ *  Copyright (C) 2012  Lanedo GmbH.
  *  Copyright (C) 2012  Outpost Embedded, LLC. All rights reserved.
  *
  *  This program is free software; you can redistribute it and/or modify
@@ -27,6 +30,8 @@
 #define _GNU_SOURCE
 #include <glib.h>
 #include <errno.h>
+#include <ctype.h>
+#include <string.h>
 =

 #include <ofono/log.h>
 #include <ofono/modem.h>
@@ -35,11 +40,300 @@
 #include "gatchat.h"
 =

 #include "sierramodem.h"
+#include "eri.h"
 =

 struct sierra_netreg_data {
 	GAtChat *chat;
+	guint status_id;
+	guint status_source;
 };
 =

+/* NOTE: STATUS parsing functions originated in ModemManager. */
+
+typedef enum {
+	SYS_MODE_UNKNOWN,
+	SYS_MODE_NO_SERVICE,
+	SYS_MODE_CDMA_1X,
+	SYS_MODE_EVDO_REV0,
+	SYS_MODE_EVDO_REVA
+} SysMode;
+
+#define MODEM_REG_TAG "Modem has registered"
+#define GENERIC_ROAM_TAG "Roaming:"
+#define ROAM_1X_TAG "1xRoam:"
+#define ROAM_EVDO_TAG "HDRRoam:"
+#define SYS_MODE_TAG "Sys Mode:"
+#define SYS_MODE_NO_SERVICE_TAG "NO SRV"
+#define SYS_MODE_EVDO_TAG "HDR"
+#define SYS_MODE_1X_TAG "1x"
+#define SYS_MODE_CDMA_TAG "CDMA"
+#define EVDO_REV_TAG "HDR Revision:"
+#define SID_TAG "SID:"
+
+static ofono_bool_t get_roam_value(const gchar *reply, const gchar *tag,
+			ofono_bool_t is_eri, ofono_bool_t *out_roaming)
+{
+	gchar *p;
+	ofono_bool_t success;
+	guint32 ind =3D 0;
+
+	p =3D strstr(reply, tag);
+	if (!p)
+		return FALSE;
+
+	p +=3D strlen(tag);
+	while (*p && isspace(*p))
+		p++;
+
+	/* Use generic ERI parsing if it's an ERI */
+	if (is_eri) {
+		success =3D sierramodem_parse_eri(p, out_roaming, &ind, NULL);
+		if (success) {
+			/* Sierra redefines ERI 0, 1, and 2 */
+			if (ind =3D=3D 0)
+				*out_roaming =3D FALSE;  /* home */
+			else if (ind =3D=3D 1 || ind =3D=3D 2)
+				*out_roaming =3D TRUE;   /* roaming */
+		}
+		return success;
+	}
+
+	/* If it's not an ERI, roaming is just true/false */
+	if (*p =3D=3D '1') {
+		*out_roaming =3D TRUE;
+		return TRUE;
+	} else if (*p =3D=3D '0') {
+		*out_roaming =3D FALSE;
+		return TRUE;
+	}
+
+	return FALSE;
+}
+
+static ofono_bool_t sys_mode_has_service(SysMode mode)
+{
+	return (mode =3D=3D SYS_MODE_CDMA_1X || mode =3D=3D SYS_MODE_EVDO_REV0 ||
+						mode =3D=3D SYS_MODE_EVDO_REVA);
+}
+
+static ofono_bool_t sys_mode_is_evdo(SysMode mode)
+{
+	return (mode =3D=3D SYS_MODE_EVDO_REV0 || mode =3D=3D SYS_MODE_EVDO_REVA);
+}
+
+static ofono_bool_t sys_mode_is_cdma(SysMode mode)
+{
+	return (mode =3D=3D SYS_MODE_CDMA_1X);
+}
+
+static ofono_bool_t parse_status(GAtResult *result, gint *status)
+{
+	GAtResultIter iter;
+	const char *line;
+	ofono_bool_t registered =3D FALSE;
+	ofono_bool_t have_sid =3D FALSE;
+	SysMode evdo_mode =3D SYS_MODE_UNKNOWN;
+	SysMode sys_mode =3D SYS_MODE_UNKNOWN;
+	ofono_bool_t evdo_roam =3D FALSE, cdma1x_roam =3D FALSE;
+	int i;
+
+	/*
+	 * Sierra CDMA parts have two general formats depending on whether they
+	 * support EVDO or not.  EVDO parts report both 1x and EVDO roaming
+	 * status while of course 1x parts only report 1x status.  Some modems
+	 * also do not report the Roaming information (MP 555 GPS).
+	 *
+	 * AT!STATUS responses:
+	 *
+	 * Unregistered MC5725:
+	 * -----------------------
+	 * Current band: PCS CDMA
+	 * Current channel: 350
+	 * SID: 0  NID: 0  1xRoam: 0 HDRRoam: 0
+	 * Temp: 33  State: 100  Sys Mode: NO SRV
+	 * Pilot NOT acquired
+	 * Modem has NOT registered
+	 *
+	 * Registered MC5725:
+	 * -----------------------
+	 * Current band: Cellular Sleep
+	 * Current channel: 775
+	 * SID: 30  NID: 2  1xRoam: 0 HDRRoam: 0
+	 * Temp: 29  State: 200  Sys Mode: HDR
+	 * Pilot acquired
+	 * Modem has registered
+	 * HDR Revision: A
+	 *
+	 * Unregistered AC580:
+	 * -----------------------
+	 * Current band: PCS CDMA
+	 * Current channel: 350
+	 * SID: 0 NID: 0  Roaming: 0
+	 * Temp: 39  State: 100  Scan Mode: 0
+	 * Pilot NOT acquired
+	 * Modem has NOT registered
+	 *
+	 * Registered AC580:
+	 * -----------------------
+	 * Current band: Cellular Sleep
+	 * Current channel: 548
+	 * SID: 26  NID: 1  Roaming: 1
+	 * Temp: 39  State: 200  Scan Mode: 0
+	 * Pilot Acquired
+	 * Modem has registered
+	 */
+
+	/*
+	 * We have to handle the two formats slightly differently; for newer
+	 * formats with "Sys Mode", we consider the modem registered if the Sys
+	 * Mode is not "NO SRV".  The explicit registration status is just
+	 * icing on the cake.  For older formats (no "Sys Mode") we treat the
+	 * modem as registered if the SID is non-zero.
+	 */
+
+	g_at_result_iter_init(&iter, result);
+
+	for (i =3D 0; i < g_at_result_num_response_lines(result); i++) {
+		ofono_bool_t bool_val =3D FALSE;
+		char *p;
+
+		g_at_result_iter_next(&iter, NULL);
+
+		line =3D g_at_result_iter_raw_line(&iter);
+
+		if (!strncmp(line, MODEM_REG_TAG, strlen(MODEM_REG_TAG))) {
+			registered =3D TRUE;
+			continue;
+		}
+
+		/* Roaming */
+		get_roam_value(line, ROAM_1X_TAG, TRUE, &cdma1x_roam);
+		get_roam_value(line, ROAM_EVDO_TAG, TRUE, &evdo_roam);
+		if (get_roam_value(line, GENERIC_ROAM_TAG, FALSE, &bool_val))
+			cdma1x_roam =3D evdo_roam =3D bool_val;
+
+		/* Current system mode */
+		p =3D strstr(line, SYS_MODE_TAG);
+		if (p) {
+			p +=3D strlen(SYS_MODE_TAG);
+			while (*p && isspace(*p))
+				p++;
+			if (!strncmp(p, SYS_MODE_NO_SERVICE_TAG,
+					strlen(SYS_MODE_NO_SERVICE_TAG)))
+				sys_mode =3D SYS_MODE_NO_SERVICE;
+			else if (!strncmp(p, SYS_MODE_EVDO_TAG,
+						strlen(SYS_MODE_EVDO_TAG)))
+				sys_mode =3D SYS_MODE_EVDO_REV0;
+			else if (!strncmp(p, SYS_MODE_1X_TAG,
+						strlen(SYS_MODE_1X_TAG)) ||
+				 !strncmp(p, SYS_MODE_CDMA_TAG,
+						strlen(SYS_MODE_CDMA_TAG)))
+				sys_mode =3D SYS_MODE_CDMA_1X;
+		}
+
+		/* Current EVDO revision if system mode is EVDO */
+		p =3D strstr(line, EVDO_REV_TAG);
+		if (p) {
+			p +=3D strlen(EVDO_REV_TAG);
+			while (*p && isspace(*p))
+				p++;
+			if (*p =3D=3D 'A')
+				evdo_mode =3D SYS_MODE_EVDO_REVA;
+			else if (*p =3D=3D '0')
+				evdo_mode =3D SYS_MODE_EVDO_REV0;
+		}
+
+		/* SID */
+		p =3D strstr(line, SID_TAG);
+		if (p) {
+			p +=3D strlen(SID_TAG);
+			while (*p && isspace(*p))
+				p++;
+			if (isdigit(*p) && (*p !=3D '0'))
+				have_sid =3D TRUE;
+		}
+	}
+
+	/* Update current system mode */
+	if (sys_mode_is_evdo(sys_mode)) {
+		/* Prefer the explicit EVDO mode from EVDO_REV_TAG */
+		if (evdo_mode !=3D SYS_MODE_UNKNOWN)
+			sys_mode =3D evdo_mode;
+	}
+
+	/*
+	 * If the modem didn't report explicit registration with "Modem has
+	 * registered" then get registration status by looking@either system
+	 * mode or (for older devices that don't report that) just the SID.
+	 */
+	if (!registered) {
+		if (sys_mode !=3D SYS_MODE_UNKNOWN)
+			registered =3D sys_mode_has_service(sys_mode);
+		else
+			registered =3D have_sid;
+	}
+
+	if (registered) {
+		ofono_bool_t roaming =3D FALSE;
+
+		if (sys_mode_is_evdo(sys_mode))
+			roaming =3D evdo_roam;
+		else if (sys_mode_is_cdma(sys_mode))
+			roaming =3D cdma1x_roam;
+
+		if (roaming)
+			*status =3D CDMA_NETWORK_REGISTRATION_STATUS_ROAMING;
+		else
+			*status =3D CDMA_NETWORK_REGISTRATION_STATUS_REGISTERED;
+	} else {
+		*status =3D CDMA_NETWORK_REGISTRATION_STATUS_NOT_REGISTERED;
+	}
+
+	return TRUE;
+}
+
+static void status_cb(ofono_bool_t ok, GAtResult *result, gpointer user_da=
ta)
+{
+	struct ofono_cdma_netreg *netreg =3D user_data;
+	int status;
+
+	if (!ok)
+		return;
+
+	if (parse_status(result, &status) =3D=3D FALSE) {
+		ofono_error("Invalid STATUS values");
+		return;
+	}
+
+	ofono_cdma_netreg_status_notify(netreg, status);
+}
+
+static void read_status(struct ofono_cdma_netreg *netreg, GAtChat *chat)
+{
+	struct sierra_netreg_data *data =3D ofono_cdma_netreg_get_data(netreg);
+
+	/*
+	 * Cancel our last request, which shouldn't have taken this long to
+	 * complete anyway.  If it did, PPP is probably running and AT chat
+	 * is suspended.  In any case, we only care about the latest info.
+	 */
+	if (data->status_id > 0)
+		g_at_chat_cancel(chat, data->status_id);
+
+	data->status_id =3D g_at_chat_send(chat, "AT!STATUS", NULL, status_cb,
+								netreg, NULL);
+}
+
+static ofono_bool_t read_status_cb(gpointer user_data)
+{
+	struct ofono_cdma_netreg *netreg =3D user_data;
+	struct sierra_netreg_data *data =3D ofono_cdma_netreg_get_data(netreg);
+
+	read_status(netreg, data->chat);
+
+	return TRUE;
+}
+
 static int sierra_cdma_netreg_probe(struct ofono_cdma_netreg *netreg,
 				unsigned int vendor, void *chat)
 {
@@ -52,6 +346,9 @@ static int sierra_cdma_netreg_probe(struct ofono_cdma_ne=
treg *netreg,
 	ofono_cdma_netreg_set_data(netreg, data);
 =

 	data->chat =3D g_at_chat_clone(chat);
+	data->status_source =3D g_timeout_add_seconds(5, read_status_cb, netreg);
+
+	read_status(netreg, data->chat);
 =

 	ofono_cdma_netreg_register(netreg);
 =

@@ -66,6 +363,9 @@ static void sierra_cdma_netreg_remove(struct ofono_cdma_=
netreg *netreg)
 =

 	g_at_chat_unref(data->chat);
 	data->chat =3D NULL;
+
+	g_source_remove(data->status_source);
+	data->status_source =3D 0;
 }
 =

 static struct ofono_cdma_netreg_driver driver =3D {
-- =

1.7.0.4

--===============3235817868127128005==--

