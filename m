Content-Type: multipart/mixed; boundary="===============7968256373358350399=="
MIME-Version: 1.0
From: Jessica Nilsson <jessica.j.nilsson@stericsson.com>
Subject: [PATCH 3/4] isimodem2.5: Changes to add isimodem2.5
Date: Wed, 08 Dec 2010 09:34:54 +0100
Message-ID: <1291797294-20554-1-git-send-email-jessica.j.nilsson@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7968256373358350399==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Updates in Makefile.am - adding of isimodem2.5
Adding of drivers/isimodem2.5/ files to fully listed functionality.

Regards,
Jessica Nilsson

---
 Makefile.am                                |   36 +-
 drivers/isimodem2.5/call-barring.c         |  503 ++
 drivers/isimodem2.5/call-forwarding.c      |  613 +++
 drivers/isimodem2.5/call-settings.c        | 1093 +++++
 drivers/isimodem2.5/call.h                 |  237 +
 drivers/isimodem2.5/cbs.c                  |  433 ++
 drivers/isimodem2.5/checkpatch.pl          | 2789 ++++++++++++
 drivers/isimodem2.5/debug.c                |  694 +++
 drivers/isimodem2.5/debug.h                |   66 +
 drivers/isimodem2.5/devinfo.c              |  246 +
 drivers/isimodem2.5/gpds-context.c         |  788 ++++
 drivers/isimodem2.5/gpds.c                 |  395 ++
 drivers/isimodem2.5/gpds.h                 |  295 ++
 drivers/isimodem2.5/gss.h                  |   84 +
 drivers/isimodem2.5/info.h                 |   53 +
 drivers/isimodem2.5/isimodem.c             |  534 +++
 drivers/isimodem2.5/isimodem.h             |   69 +
 drivers/isimodem2.5/isiutil.h              |   64 +
 drivers/isimodem2.5/mce.h                  |   65 +
 drivers/isimodem2.5/network-registration.c | 1158 +++++
 drivers/isimodem2.5/network.h              |  257 ++
 drivers/isimodem2.5/phonebook.c            | 1320 ++++++
 drivers/isimodem2.5/radio-settings.c       |  313 ++
 drivers/isimodem2.5/simu_resps.h           | 6800 ++++++++++++++++++++++++=
++++
 drivers/isimodem2.5/sms.c                  |  869 ++++
 drivers/isimodem2.5/sms.h                  |  188 +
 drivers/isimodem2.5/ss.h                   |  174 +
 drivers/isimodem2.5/ssn.c                  |  456 ++
 drivers/isimodem2.5/timeout.h              |   33 +
 drivers/isimodem2.5/uicc.c                 | 3316 ++++++++++++++
 drivers/isimodem2.5/uicc.h                 |  253 ++
 drivers/isimodem2.5/uicc_interface.h       |   40 +
 drivers/isimodem2.5/ussd.c                 |  341 ++
 drivers/isimodem2.5/voicecall.c            | 1555 +++++++
 34 files changed, 26128 insertions(+), 2 deletions(-)
 create mode 100644 drivers/isimodem2.5/call-barring.c
 create mode 100644 drivers/isimodem2.5/call-forwarding.c
 create mode 100644 drivers/isimodem2.5/call-settings.c
 create mode 100644 drivers/isimodem2.5/call.h
 create mode 100644 drivers/isimodem2.5/cbs.c
 create mode 100755 drivers/isimodem2.5/checkpatch.pl
 create mode 100644 drivers/isimodem2.5/debug.c
 create mode 100644 drivers/isimodem2.5/debug.h
 create mode 100644 drivers/isimodem2.5/devinfo.c
 create mode 100644 drivers/isimodem2.5/gpds-context.c
 create mode 100644 drivers/isimodem2.5/gpds.c
 create mode 100644 drivers/isimodem2.5/gpds.h
 create mode 100644 drivers/isimodem2.5/gss.h
 create mode 100644 drivers/isimodem2.5/info.h
 create mode 100644 drivers/isimodem2.5/isimodem.c
 create mode 100644 drivers/isimodem2.5/isimodem.h
 create mode 100644 drivers/isimodem2.5/isiutil.h
 create mode 100644 drivers/isimodem2.5/mce.h
 create mode 100644 drivers/isimodem2.5/network-registration.c
 create mode 100644 drivers/isimodem2.5/network.h
 create mode 100644 drivers/isimodem2.5/phonebook.c
 create mode 100644 drivers/isimodem2.5/radio-settings.c
 create mode 100644 drivers/isimodem2.5/simu_resps.h
 create mode 100644 drivers/isimodem2.5/sms.c
 create mode 100644 drivers/isimodem2.5/sms.h
 create mode 100644 drivers/isimodem2.5/ss.h
 create mode 100644 drivers/isimodem2.5/ssn.c
 create mode 100644 drivers/isimodem2.5/timeout.h
 create mode 100644 drivers/isimodem2.5/uicc.c
 create mode 100644 drivers/isimodem2.5/uicc.h
 create mode 100644 drivers/isimodem2.5/uicc_interface.h
 create mode 100644 drivers/isimodem2.5/ussd.c
 create mode 100644 drivers/isimodem2.5/voicecall.c

diff --git a/Makefile.am b/Makefile.am
index caf3306..a5c89f2 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -289,9 +289,41 @@ builtin_sources +=3D plugins/caif.c
 endif
 =

 if ISIMODEM25
+builtin_modules +=3D isimodem25
 builtin_sources +=3D $(gisi_sources) \
 		gisi/pipe_wg25.h \
-		gisi/pipe_wg25.c
+		gisi/pipe_wg25.c \
+		drivers/isimodem2.5/debug.h \
+		drivers/isimodem2.5/debug.c \
+		drivers/isimodem2.5/isimodem.h \
+		drivers/isimodem2.5/isimodem.c \
+		drivers/isimodem2.5/mce.h \
+		drivers/isimodem2.5/timeout.h \
+		drivers/isimodem2.5/network-registration.c \
+		drivers/isimodem2.5/network.h \
+		drivers/isimodem2.5/call.h \
+		drivers/isimodem2.5/simu_resps.h \
+		drivers/isimodem2.5/voicecall.c \
+		drivers/isimodem2.5/gpds.h \
+		drivers/isimodem2.5/gpds.c \
+		drivers/isimodem2.5/gpds-context.c \
+		drivers/isimodem2.5/devinfo.c \
+		drivers/isimodem2.5/info.h \
+		drivers/isimodem2.5/uicc.h \
+		drivers/isimodem2.5/uicc_interface.h \
+		drivers/isimodem2.5/uicc.c \
+		drivers/isimodem2.5/sms.h \
+		drivers/isimodem2.5/sms.c \
+		drivers/isimodem2.5/call-barring.c \
+		drivers/isimodem2.5/call-settings.c \
+		drivers/isimodem2.5/call-forwarding.c \
+		drivers/isimodem2.5/ssn.c \
+		drivers/isimodem2.5/ss.h \
+		drivers/isimodem2.5/gss.h \
+		drivers/isimodem2.5/radio-settings.c \
+		drivers/isimodem2.5/ussd.c \
+		drivers/isimodem2.5/phonebook.c\
+		drivers/isimodem2.5/cbs.c
 endif
 =

 if MAINTAINER_MODE
@@ -484,7 +516,7 @@ unit_objects +=3D $(unit_test_mux_OBJECTS)
 =

 unit_test_caif_SOURCES =3D unit/test-caif.c $(gatchat_sources) \
 					drivers/stemodem/caif_socket.h \
-					drivers/stemodem/if_caif.h =

+					drivers/stemodem/if_caif.h
 unit_test_caif_LDADD =3D @GLIB_LIBS@
 unit_objects +=3D $(unit_test_caif_OBJECTS)
 =

diff --git a/drivers/isimodem2.5/call-barring.c b/drivers/isimodem2.5/call-=
barring.c
new file mode 100644
index 0000000..da1cd4b
--- /dev/null
+++ b/drivers/isimodem2.5/call-barring.c
@@ -0,0 +1,503 @@
+/*
+ * This file is part of oFono - Open Source Telephony
+ *
+ * Copyright (C) 2009 Nokia Corporation and/or its subsidiary(-ies).
+ * Copyright (C) ST-Ericsson SA 2010.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include <gisi/client.h>
+#include <gisi/iter.h>
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/call-barring.h>
+
+#include <glib.h>
+
+
+#include "common.h"
+#include "debug.h"
+#include "isimodem.h"
+#include "isiutil.h"
+#include "ss.h"
+#include "util.h"
+
+struct barr_data {
+	GIsiClient *client;
+};
+
+static int lock_code_to_mmi(char const *lock)
+{
+	if (strcmp(lock, "AO") =3D=3D 0)
+		return SS_GSM_BARR_ALL_OUT;
+	else if (strcmp(lock, "OI") =3D=3D 0)
+		return SS_GSM_BARR_OUT_INTER;
+	else if (strcmp(lock, "OX") =3D=3D 0)
+		return SS_GSM_BARR_OUT_INTER_EXC_HOME;
+	else if (strcmp(lock, "AI") =3D=3D 0)
+		return SS_GSM_BARR_ALL_IN;
+	else if (strcmp(lock, "IR") =3D=3D 0)
+		return SS_GSM_BARR_ALL_IN_ROAM;
+	else if (strcmp(lock, "AB") =3D=3D 0)
+		return SS_GSM_ALL_BARRINGS;
+	else if (strcmp(lock, "AG") =3D=3D 0)
+		return SS_GSM_OUTGOING_BARR_SERV;
+	else if (strcmp(lock, "AC") =3D=3D 0)
+		return SS_GSM_INCOMING_BARR_SERV;
+	else
+		return 0;
+}
+
+static void update_status_mask(guint32 *mask, int bsc)
+{
+	switch (bsc) {
+	case SS_GSM_TELEPHONY:
+		*mask |=3D 1;
+		break;
+	case SS_GSM_ALL_DATA_TELE:
+		*mask |=3D 1 << 1;
+		break;
+	case SS_GSM_FACSIMILE:
+		*mask |=3D 1 << 2;
+		break;
+	case SS_GSM_SMS:
+		*mask |=3D 1 << 3;
+		break;
+	case SS_GSM_ALL_DATA_CIRCUIT_SYNC:
+		*mask |=3D 1 << 4;
+		break;
+	case SS_GSM_ALL_DATA_CIRCUIT_ASYNC:
+		*mask |=3D 1 << 5;
+		break;
+	case SS_GSM_ALL_DATA_PACKET_SYNC:
+		*mask |=3D 1 << 6;
+		break;
+	case SS_GSM_ALL_PAD_ACCESS:
+		*mask |=3D 1 << 7;
+		break;
+	default:
+		DBG("Unknown BSC: 0x%04X\n", bsc);
+		break;
+	}
+}
+
+static gboolean decode_gsm_barring_info(const void *restrict data, size_t =
len,
+					guint32 *mask)
+{
+	GIsiSubBlockIter iter;
+
+	for (g_isi_sb_iter_init(&iter, data, len, 0);
+			g_isi_sb_iter_is_valid(&iter);
+			g_isi_sb_iter_next(&iter)) {
+		switch (g_isi_sb_iter_get_id(&iter)) {
+		case SS_GSM_BARRING_FEATURE: {
+			uint8_t status;
+			uint8_t bsc;
+
+			if (!g_isi_sb_iter_get_byte(&iter, &bsc, 2)
+				|| !g_isi_sb_iter_get_byte(&iter, &status, 3))
+				return FALSE;
+
+			if (status & SS_GSM_ACTIVE)
+				update_status_mask(mask, bsc);
+
+			break;
+		}
+		default:
+			DBG("Skipping sub-block: %s (%zd bytes)",
+				ss_subblock_name(g_isi_sb_iter_get_id(&iter)),
+				g_isi_sb_iter_get_len(&iter));
+			break;
+		}
+	}
+
+	return TRUE;
+}
+
+static gboolean bearer_class_to_bsc(enum bearer_class cls, guint8 *bsc)
+{
+	switch (cls) {
+	case BEARER_CLASS_VOICE:
+		*bsc =3D SS_GSM_VOICE_GROUP;
+		return TRUE;
+	case BEARER_CLASS_DATA:
+		*bsc =3D SS_GSM_ALL_DATA_TELE;
+		return TRUE;
+	case BEARER_CLASS_FAX:
+		*bsc =3D SS_GSM_FACSIMILE;
+		return TRUE;
+	case BEARER_CLASS_DEFAULT:
+		*bsc =3D SS_GSM_TELEPHONY;
+		return TRUE;
+	case BEARER_CLASS_SMS:
+		*bsc =3D SS_GSM_SMS;
+		return TRUE;
+	case BEARER_CLASS_DATA_SYNC:
+		*bsc =3D SS_GSM_ALL_DATA_CIRCUIT_SYNC;
+		return TRUE;
+	case BEARER_CLASS_DATA_ASYNC:
+		*bsc =3D SS_GSM_ALL_DATA_CIRCUIT_ASYNC;
+		return TRUE;
+	case BEARER_CLASS_SS_DEFAULT:
+		return FALSE;
+	case BEARER_CLASS_PACKET:
+		*bsc =3D SS_GSM_ALL_DATA_PACKET_SYNC;
+		return TRUE;
+	case BEARER_CLASS_PAD:
+		*bsc =3D SS_GSM_ALL_PAD_ACCESS;
+		return TRUE;
+	}
+
+	return FALSE;
+}
+
+static gboolean set_resp_cb(GIsiClient *client, const void *restrict data,
+				size_t len, uint16_t object, void *opaque)
+{
+	const unsigned char *msg =3D data;
+	struct isi_cb_data *cbd =3D opaque;
+	ofono_call_barring_set_cb_t cb =3D cbd->cb;
+
+	if (!msg) {
+		DBG("ISI client error: %d", g_isi_client_error(client));
+		goto error;
+	}
+
+	DBG("%s %s", ss_message_id_name(msg[0]), ss_operation_name(msg[1]));
+
+	if (len < 3 || msg[0] !=3D SS_SERVICE_COMPLETED_RESP)
+		goto error;
+
+	if (msg[1] !=3D SS_ACTIVATION && msg[1] !=3D SS_DEACTIVATION)
+		goto error;
+
+	CALLBACK_WITH_SUCCESS(cb, cbd->data);
+	goto out;
+error:
+	CALLBACK_WITH_FAILURE(cb, cbd->data);
+out:
+	g_free(cbd);
+	return TRUE;
+}
+
+
+static void isi_set(struct ofono_call_barring *barr, const char *lock,
+			int enable, const char *passwd, int cls,
+			ofono_call_barring_set_cb_t cb, void *data)
+{
+	struct barr_data *bd =3D ofono_call_barring_get_data(barr);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(barr, cb, data);
+	int ss_code =3D lock_code_to_mmi(lock);
+	unsigned char msg[] =3D {
+		SS_SERVICE_REQ,
+		enable ? SS_ACTIVATION : SS_DEACTIVATION,
+		SS_ALL_TELE_AND_BEARER,
+		ss_code >> 8, ss_code & 0xFF,	/* Service code */
+		SS_SEND_ADDITIONAL_INFO,
+		1,				/* Subblock count */
+		SS_GSM_PASSWORD,
+		28,				/* Subblock length */
+		0, passwd[0], 0, passwd[1],
+		0, passwd[2], 0, passwd[3],
+		0, 0, 0, 0, 0, 0, 0, 0,		/* Filler */
+		0, 0, 0, 0, 0, 0, 0, 0,		/* Filler */
+		0, 0				/* Filler */
+	};
+	DBG("lock code %s enable %d class %d password %s, service code %04x\n",
+	    lock, enable, cls, passwd, ss_code);
+
+	if (cbd && g_isi_request_make(bd->client, msg, sizeof(msg), SS_TIMEOUT,
+				      set_resp_cb, cbd))
+		return;
+
+	CALLBACK_WITH_FAILURE(cb, data);
+	g_free(cbd);
+}
+
+static gboolean query_resp_cb(GIsiClient *client, const void *restrict dat=
a,
+				size_t len, uint16_t object, void *opaque)
+{
+	GIsiSubBlockIter iter;
+	const unsigned char *msg =3D data;
+	struct isi_cb_data *cbd =3D opaque;
+	ofono_call_barring_query_cb_t cb =3D cbd->cb;
+	guint32 mask =3D 0;
+
+	if (!msg) {
+		DBG("ISI client error: %d", g_isi_client_error(client));
+		goto error;
+	}
+
+	DBG("%s %s", ss_message_id_name(msg[0]), ss_operation_name(msg[1]));
+
+	if (len < 7 || msg[0] !=3D SS_SERVICE_COMPLETED_RESP)
+		goto error;
+
+	if (msg[1] !=3D SS_INTERROGATION)
+		goto error;
+
+	for (g_isi_sb_iter_init(&iter, msg, len, 7);
+			g_isi_sb_iter_is_valid(&iter);
+			g_isi_sb_iter_next(&iter)) {
+		DBG("Sub-block %s",
+			ss_subblock_name(g_isi_sb_iter_get_id(&iter)));
+
+		switch (g_isi_sb_iter_get_id(&iter)) {
+		case SS_STATUS_RESULT: {
+			guint8 ss_status;
+
+			if (!g_isi_sb_iter_get_byte(&iter, &ss_status, 2))
+				goto error;
+
+			DBG("SS_STATUS_RESULT=3D%d", ss_status);
+
+			if (ss_status & SS_GSM_ACTIVE)
+				mask =3D 1;
+
+			break;
+		}
+		case SS_GSM_BARRING_INFO: {
+			void *info =3D NULL;
+			size_t infolen;
+
+			if (!g_isi_sb_iter_get_data(&iter, &info, 4))
+				goto error;
+
+			infolen =3D g_isi_sb_iter_get_len(&iter) - 4;
+
+			if (!decode_gsm_barring_info(info, infolen, &mask))
+				goto error;
+
+			break;
+		}
+		case SS_GSM_BSC_INFO: {
+			guint8 bsc;
+			guint8 count;
+			guint8 i;
+
+			if (!g_isi_sb_iter_get_byte(&iter, &count, 2))
+				goto error;
+
+			for (i =3D 0; i < count; i++) {
+				if (!g_isi_sb_iter_get_byte(&iter, &bsc, 3 + i))
+					goto error;
+
+				update_status_mask(&mask, bsc);
+			}
+
+			break;
+		}
+		case SS_GSM_ADDITIONAL_INFO:
+			break;
+		default:
+			DBG("Skipping sub-block: %d (%zd bytes)",
+				(g_isi_sb_iter_get_id(&iter)),
+				g_isi_sb_iter_get_len(&iter));
+			break;
+		}
+	}
+
+	DBG("mask=3D0x%04X\n", mask);
+	CALLBACK_WITH_SUCCESS(cb, mask, cbd->data);
+	goto out;
+error:
+	CALLBACK_WITH_FAILURE(cb, 0, cbd->data);
+out:
+	g_free(cbd);
+	return TRUE;
+}
+
+static void isi_query(struct ofono_call_barring *barr, const char *lock,
+			int cls, ofono_call_barring_query_cb_t cb, void *data)
+{
+	struct barr_data *bd =3D ofono_call_barring_get_data(barr);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(barr, cb, data);
+	int ss_code =3D lock_code_to_mmi(lock);
+	guint8 bsc;
+
+	unsigned char msg[] =3D {
+		SS_SERVICE_REQ,
+		SS_INTERROGATION,
+		SS_ALL_TELE_AND_BEARER,
+		ss_code >> 8, ss_code & 0xFF,	/* services code */
+		SS_SEND_ADDITIONAL_INFO,	/* Get BER-encoded result */
+		0				/* Subblock count */
+	};
+	(void) bearer_class_to_bsc(cls, &bsc);
+	DBG("barring class %d type %s\n", cls, lock);
+
+	if (cbd && g_isi_request_make(bd->client, msg, sizeof(msg), SS_TIMEOUT,
+					query_resp_cb, cbd))
+		return;
+}
+
+static gboolean set_passwd_resp_cb(GIsiClient *client,
+					const void *restrict data,
+					size_t len,
+					uint16_t object,
+					void *opaque)
+{
+	const unsigned char *msg =3D data;
+	struct isi_cb_data *cbd =3D opaque;
+	ofono_call_barring_set_cb_t cb =3D cbd->cb;
+
+	if (!msg) {
+		DBG("ISI client error: %d", g_isi_client_error(client));
+		goto error;
+	}
+
+	DBG("%s %s", ss_message_id_name(msg[0]), ss_operation_name(msg[1]));
+
+	if (len < 3 || msg[0] !=3D SS_SERVICE_COMPLETED_RESP)
+		goto error;
+
+	if (msg[1] !=3D SS_GSM_PASSWORD_REGISTRATION)
+		goto error;
+
+	CALLBACK_WITH_SUCCESS(cb, cbd->data);
+	goto out;
+error:
+	CALLBACK_WITH_FAILURE(cb, cbd->data);
+out:
+	g_free(cbd);
+	return TRUE;
+}
+
+static void isi_set_passwd(struct ofono_call_barring *barr, const char *lo=
ck,
+				const char *old_passwd, const char *new_passwd,
+				ofono_call_barring_set_cb_t cb, void *data)
+{
+	struct barr_data *bd =3D ofono_call_barring_get_data(barr);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(barr, cb, data);
+	int ss_code =3D lock_code_to_mmi(lock);
+	unsigned char msg[] =3D {
+		SS_SERVICE_REQ,
+		SS_GSM_PASSWORD_REGISTRATION,
+		SS_ALL_TELE_AND_BEARER,
+		ss_code >> 8, ss_code & 0xFF,	/* Service code */
+		SS_SEND_ADDITIONAL_INFO,
+		1,				/* Subblock count */
+		SS_GSM_PASSWORD,
+		28,				/* Subblock length */
+		0, old_passwd[0], 0, old_passwd[1],
+		0, old_passwd[2], 0, old_passwd[3],
+		0, new_passwd[0], 0, new_passwd[1],
+		0, new_passwd[2], 0, new_passwd[3],
+		0, new_passwd[0], 0, new_passwd[1],
+		0, new_passwd[2], 0, new_passwd[3],
+		0, 0				/* Filler */
+	};
+	DBG("lock code %s (%u) old password %s new password %s\n",
+		lock, ss_code, old_passwd, new_passwd);
+
+	if (cbd &&
+		g_isi_request_make(bd->client, msg, sizeof(msg), SS_TIMEOUT,
+				set_passwd_resp_cb, cbd))
+		return;
+
+	CALLBACK_WITH_FAILURE(cb, data);
+	g_free(cbd);
+}
+/*=3D=3D=3D=3D=3D=3D=3D=3DCOMMON starts=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D*/
+static gboolean isi_call_barring_register(gpointer user)
+{
+	struct ofono_call_barring *cb =3D user;
+	ofono_call_barring_register(cb);
+	return FALSE;
+}
+
+static void reachable_cb(GIsiClient *client, gboolean alive, uint16_t obje=
ct,
+				void *opaque)
+{
+	struct ofono_call_barring *barr =3D opaque;
+
+	if (!alive) {
+		DBG("Unable to bootstrap call barring driver");
+		return;
+	}
+
+	DBG("%s (v%03d.%03d) reachable",
+		pn_resource_name(g_isi_client_resource(client)),
+		g_isi_version_major(client),
+		g_isi_version_minor(client));
+	g_idle_add(isi_call_barring_register, barr);
+}
+
+
+static int isi_call_barring_probe(struct ofono_call_barring *barr,
+					unsigned int vendor, void *user)
+{
+	GIsiModem *idx =3D user;
+	struct barr_data *data =3D g_try_new0(struct barr_data, 1);
+
+	if (!data)
+		return -ENOMEM;
+
+	data->client =3D get_pn_ss_client(idx, PN_SS);
+
+	if (!data->client)
+		return -ENOMEM;
+
+	ofono_call_barring_set_data(barr, data);
+
+	if (!g_isi_verify(data->client, reachable_cb, barr))
+		DBG("Unable to verify reachability");
+
+	return 0;
+}
+
+static void isi_call_barring_remove(struct ofono_call_barring *barr)
+{
+	struct barr_data *data =3D ofono_call_barring_get_data(barr);
+
+	if (!data)
+		return;
+
+	ofono_call_barring_set_data(barr, NULL);
+	pn_ss_client_destroy(data->client);
+	g_free(data);
+}
+
+static struct ofono_call_barring_driver driver =3D {
+	.name			=3D "isimodem25",
+	.probe			=3D isi_call_barring_probe,
+	.remove			=3D isi_call_barring_remove,
+	.set			=3D isi_set,
+	.query			=3D isi_query,
+	.set_passwd		=3D isi_set_passwd
+};
+
+void isi_call_barring_init()
+{
+	ofono_call_barring_driver_register(&driver);
+}
+
+void isi_call_barring_exit()
+{
+	ofono_call_barring_driver_unregister(&driver);
+}
+/*=3D=3D=3D=3D=3D=3D=3D=3DCOMMON ends=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D*/
diff --git a/drivers/isimodem2.5/call-forwarding.c b/drivers/isimodem2.5/ca=
ll-forwarding.c
new file mode 100644
index 0000000..f712488
--- /dev/null
+++ b/drivers/isimodem2.5/call-forwarding.c
@@ -0,0 +1,613 @@
+/*
+ * This file is part of oFono - Open Source Telephony
+ *
+ * Copyright (C) 2009 Nokia Corporation and/or its subsidiary(-ies).
+ * Copyright (C) ST-Ericsson SA 2010.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include <gisi/client.h>
+#include <gisi/iter.h>
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/call-forwarding.h>
+
+#include <glib.h>
+
+#include "debug.h"
+#include "isimodem.h"
+#include "isiutil.h"
+#include "ss.h"
+
+struct forw_data {
+	GIsiClient *client;
+};
+
+static int forw_type_to_isi_code(int type)
+{
+	int ss_code;
+
+	switch (type) {
+	case 0:
+		ss_code =3D SS_GSM_FORW_UNCONDITIONAL;
+		break;
+	case 1:
+		ss_code =3D SS_GSM_FORW_BUSY;
+		break;
+	case 2:
+		ss_code =3D SS_GSM_FORW_NO_REPLY;
+		break;
+	case 3:
+		ss_code =3D SS_GSM_FORW_NO_REACH;
+		break;
+	case 4:
+		ss_code =3D SS_GSM_ALL_FORWARDINGS;
+		break;
+	case 5:
+		ss_code =3D SS_GSM_ALL_COND_FORWARDINGS;
+		break;
+	default:
+		DBG("Unknown forwarding type %d\n", type);
+		ss_code =3D -1;
+		break;
+	}
+
+	return ss_code;
+}
+
+static gboolean decode_gsm_forwarding_info(const void *restrict data,
+						size_t len, uint8_t *status,
+						uint8_t *ton, uint8_t *norply,
+						char **number)
+{
+	GIsiSubBlockIter iter;
+
+	for (g_isi_sb_iter_init(&iter, data, len, 0);
+			g_isi_sb_iter_is_valid(&iter);
+			g_isi_sb_iter_next(&iter)) {
+		switch (g_isi_sb_iter_get_id(&iter)) {
+		case SS_GSM_FORWARDING_FEATURE: {
+			uint8_t _numlen;
+			uint8_t _status;
+			uint8_t _norply;
+			uint8_t _ton;
+			char *_number =3D NULL;
+
+			if (!g_isi_sb_iter_get_byte(&iter, &_status, 3)
+				|| !g_isi_sb_iter_get_byte(&iter, &_ton, 4)
+				|| !g_isi_sb_iter_get_byte(&iter, &_norply, 5)
+				|| !g_isi_sb_iter_get_byte(&iter, &_numlen, 7))
+					return FALSE;
+
+			g_isi_sb_iter_get_alpha_tag(&iter,
+						    &_number,
+						    _numlen * 2, /*can be zero*/
+						    10);
+
+			if (status)
+				*status =3D _status;
+
+			if (ton)
+				*ton =3D _ton;
+
+			if (norply)
+				*norply =3D _norply;
+
+			if (number)
+				*number =3D _number;
+			else
+				g_free(_number);
+
+			return TRUE;
+		}
+		default:
+			DBG("Skipping sub-block: %s (%zd bytes)",
+				ss_subblock_name(g_isi_sb_iter_get_id(&iter)),
+				g_isi_sb_iter_get_len(&iter));
+			break;
+		}
+	}
+
+	return FALSE;
+}
+
+static gboolean registration_resp_cb(GIsiClient *client,
+					const void *restrict data,
+					size_t len,
+					uint16_t object, void *opaque)
+{
+	GIsiSubBlockIter iter;
+	const unsigned char *msg =3D data;
+	struct isi_cb_data *cbd =3D opaque;
+	ofono_call_forwarding_set_cb_t cb =3D cbd->cb;
+
+	if (!msg) {
+		DBG("ISI client error: %d", g_isi_client_error(client));
+		goto error;
+	}
+
+	DBG("%s %s", ss_message_id_name(msg[0]), ss_operation_name(msg[1]));
+
+	if (len < 7 || msg[0] !=3D SS_SERVICE_COMPLETED_RESP)
+		goto error;
+
+	if (msg[1] !=3D SS_REGISTRATION)
+		goto error;
+
+	for (g_isi_sb_iter_init(&iter, msg, len, 7);
+			g_isi_sb_iter_is_valid(&iter);
+			g_isi_sb_iter_next(&iter)) {
+		DBG("Sub-block %s",
+			ss_subblock_name(g_isi_sb_iter_get_id(&iter)));
+
+		switch (g_isi_sb_iter_get_id(&iter)) {
+		case SS_GSM_ADDITIONAL_INFO:
+			break;
+		case SS_GSM_FORWARDING_INFO: {
+			guint8 status;
+			void *info =3D NULL;
+			size_t infolen;
+
+			if (!g_isi_sb_iter_get_data(&iter, &info, 4))
+				goto error;
+
+			infolen =3D g_isi_sb_iter_get_len(&iter) - 4;
+
+			if (!decode_gsm_forwarding_info(info, infolen, &status,
+							NULL, NULL, NULL))
+				goto error;
+
+			if (!(status & SS_GSM_ACTIVE)
+					|| !(status & SS_GSM_REGISTERED))
+				goto error;
+
+			break;
+		}
+		default:
+			DBG("Skipping sub-block: %s (%zd bytes)",
+				ss_subblock_name(g_isi_sb_iter_get_id(&iter)),
+				g_isi_sb_iter_get_len(&iter));
+			break;
+		}
+	}
+
+	CALLBACK_WITH_SUCCESS(cb, cbd->data);
+	goto out;
+error:
+	CALLBACK_WITH_FAILURE(cb, cbd->data);
+out:
+	g_free(cbd);
+	return TRUE;
+}
+
+static void isi_registration(struct ofono_call_forwarding *cf,
+				int type, int cls,
+				const struct ofono_phone_number *number,
+				int time,
+				ofono_call_forwarding_set_cb_t cb, void *data)
+{
+	struct forw_data *fd =3D ofono_call_forwarding_get_data(cf);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(cf, cb, data);
+	int ss_code;
+	int num_filler;
+	char *ucs2 =3D NULL;
+
+	if (!number)
+		goto error;
+	else {
+
+		unsigned char msg[100] =3D {
+			SS_SERVICE_REQ,
+			SS_REGISTRATION,
+			SS_GSM_TELEPHONY,
+			0, 0,	/* Supplementary services code */
+			SS_SEND_ADDITIONAL_INFO,
+			1,	/* Subblock count */
+			SS_FORWARDING,
+			0,	/* Variable subblock length (phone number) */
+			number->type,
+			SS_UNDEFINED_TIME,
+			strlen(number->number),
+			0	/* Sub address length */
+		};
+		/*
+		 * Followed by number in UCS-2, zero sub address bytes, and 0
+		 * to 3 bytes of filler
+		 */
+		DBG("SS_REGISTRATION forwarding type=3D%d class=3D%d nbr_type=3D%d,\
+				time=3D%d len=3D%d num=3D%s",
+				type, cls, number->type,
+				time, (int) strlen(number->number),
+				number->number);
+
+		if (!cbd || !number || strlen(number->number) > 28)
+			goto error;
+
+		ss_code =3D forw_type_to_isi_code(type);
+
+		if (ss_code < 0)
+			goto error;
+
+		msg[3] =3D ss_code >> 8;
+		msg[4] =3D ss_code & 0xFF;
+
+		/* Time must not be set for any other than NoReply */
+		if (ss_code =3D=3D SS_GSM_FORW_NO_REPLY)
+			msg[10] =3D time;
+
+		num_filler =3D (6 + 2 * strlen(number->number)) % 4;
+
+		if (num_filler !=3D 0)
+			num_filler =3D 4 - num_filler;
+
+		msg[8]  =3D 6 + 2 * strlen(number->number) + num_filler;
+		ucs2 =3D g_convert(number->number, strlen(number->number),
+				"UCS-2BE",
+				"UTF-8//TRANSLIT", NULL, NULL, NULL);
+
+		if (ucs2 =3D=3D NULL)
+			goto error;
+
+		memmove((char *) msg + 13, ucs2, strlen(number->number) * 2);
+		g_free(ucs2);
+
+		if (g_isi_request_make(fd->client, msg, 7 + msg[8], SS_TIMEOUT,
+					registration_resp_cb, cbd))
+			return;
+	}
+
+error:
+	CALLBACK_WITH_FAILURE(cb, data);
+	g_free(cbd);
+}
+
+static gboolean erasure_resp_cb(GIsiClient *client, const void *restrict d=
ata,
+				size_t len, uint16_t object, void *opaque)
+{
+	GIsiSubBlockIter iter;
+	const unsigned char *msg =3D data;
+	struct isi_cb_data *cbd =3D opaque;
+	ofono_call_forwarding_set_cb_t cb =3D cbd->cb;
+
+	if (!msg) {
+		DBG("ISI client error: %d", g_isi_client_error(client));
+		goto error;
+	}
+
+	DBG("%s %s", ss_message_id_name(msg[0]), ss_operation_name(msg[1]));
+
+	if (len < 7 || msg[0] !=3D SS_SERVICE_COMPLETED_RESP)
+		goto error;
+
+	if (msg[1] !=3D SS_ERASURE)
+		goto error;
+
+	for (g_isi_sb_iter_init(&iter, msg, len, 7);
+			g_isi_sb_iter_is_valid(&iter);
+			g_isi_sb_iter_next(&iter)) {
+		DBG("Sub-block %s",
+			ss_subblock_name(g_isi_sb_iter_get_id(&iter)));
+
+		switch (g_isi_sb_iter_get_id(&iter)) {
+		case SS_GSM_FORWARDING_INFO: {
+			guint8 status;
+			void *info =3D NULL;
+			size_t infolen;
+
+			if (!g_isi_sb_iter_get_data(&iter, &info, 4))
+				goto error;
+
+			infolen =3D g_isi_sb_iter_get_len(&iter) - 4;
+
+			if (!decode_gsm_forwarding_info(info, infolen, &status,
+							NULL, NULL, NULL)) {
+				DBG("SS_GSM_FORWARDING_INFO \
+				info=3D%p, len=3D%d, decoded status=3D%d",
+					info, (int) infolen, status);
+				goto error;
+			}
+
+			if (status & (SS_GSM_ACTIVE | SS_GSM_REGISTERED))
+				goto error;
+
+			break;
+		}
+		default:
+			DBG("Skipping sub-block: %s (%zd bytes)",
+				ss_subblock_name(g_isi_sb_iter_get_id(&iter)),
+				g_isi_sb_iter_get_len(&iter));
+			break;
+		}
+	}
+
+	CALLBACK_WITH_SUCCESS(cb, cbd->data);
+	goto out;
+error:
+	CALLBACK_WITH_FAILURE(cb, cbd->data);
+out:
+	g_free(cbd);
+	return TRUE;
+}
+
+
+static void isi_erasure(struct ofono_call_forwarding *cf, int type, int cl=
s,
+			ofono_call_forwarding_set_cb_t cb, void *data)
+{
+	struct forw_data *fd =3D ofono_call_forwarding_get_data(cf);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(cf, cb, data);
+	int ss_code;
+	unsigned char msg[] =3D {
+		SS_SERVICE_REQ,
+		SS_ERASURE,
+		SS_GSM_TELEPHONY,
+		0, 0,	/* Supplementary services code */
+		SS_SEND_ADDITIONAL_INFO,
+		0	/* Subblock count */
+	};
+	DBG("forwarding type %d class %d\n", type, cls);
+
+	if (!cbd)
+		goto error;
+
+	ss_code =3D forw_type_to_isi_code(type);
+
+	if (ss_code < 0)
+		goto error;
+
+	msg[3] =3D ss_code >> 8;
+	msg[4] =3D ss_code & 0xFF;
+
+	if (g_isi_request_make(fd->client, msg, sizeof(msg), SS_TIMEOUT,
+				erasure_resp_cb, cbd))
+		return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, data);
+	g_free(cbd);
+}
+
+static gboolean query_resp_cb(GIsiClient *client, const void *restrict dat=
a,
+				size_t len, uint16_t object, void *opaque)
+{
+	GIsiSubBlockIter iter;
+	const unsigned char *msg =3D data;
+	struct isi_cb_data *cbd =3D opaque;
+	ofono_call_forwarding_query_cb_t cb =3D cbd->cb;
+	struct ofono_call_forwarding_condition list;
+	list.status =3D 0;
+	list.cls =3D 7;
+	list.time =3D 0;
+	list.phone_number.number[0] =3D 0;
+	list.phone_number.type =3D 0;
+
+	if (!msg) {
+		DBG("ISI client error: %d", g_isi_client_error(client));
+		goto error;
+	}
+
+	DBG("%s %s", ss_message_id_name(msg[0]), ss_operation_name(msg[1]));
+
+	if (len < 7 || msg[0] !=3D SS_SERVICE_COMPLETED_RESP)
+		goto error;
+
+	if (msg[1] !=3D SS_INTERROGATION)
+		goto error;
+
+	for (g_isi_sb_iter_init(&iter, msg, len, 7);
+			g_isi_sb_iter_is_valid(&iter);
+			g_isi_sb_iter_next(&iter)) {
+		DBG("Sub-block %s",
+			ss_subblock_name(g_isi_sb_iter_get_id(&iter)));
+
+		switch (g_isi_sb_iter_get_id(&iter)) {
+		case SS_STATUS_RESULT: {
+			guint8 ss_status;
+
+			if (!g_isi_sb_iter_get_byte(&iter, &ss_status, 2))
+				goto error;
+
+			DBG("SS_STATUS_RESULT=3D%d", ss_status);
+			list.status =3D ss_status & (SS_GSM_ACTIVE
+							| SS_GSM_REGISTERED
+							| SS_GSM_PROVISIONED);
+			/* No other info in SS_RESULT */
+			break;
+		}
+		case SS_GSM_FORWARDING_INFO: {
+			guint8 status;
+			void *info =3D NULL;
+			size_t infolen;
+			guint8 ton;
+			guint8 norply;
+			char *number =3D NULL;
+
+			if (!g_isi_sb_iter_get_data(&iter, &info, 4))
+				goto error;
+
+			infolen =3D g_isi_sb_iter_get_len(&iter) - 4;
+
+			if (!decode_gsm_forwarding_info(info, infolen, &status,
+							&ton, &norply, &number))
+				goto error;
+
+			list.status =3D status & (SS_GSM_ACTIVE
+							| SS_GSM_REGISTERED
+							| SS_GSM_PROVISIONED);
+			list.time =3D norply;
+			list.phone_number.type =3D ton | 128;
+			list.phone_number.number[0] =3D '\0';
+
+			if (number) {
+				strncpy(list.phone_number.number, number,
+					OFONO_MAX_PHONE_NUMBER_LENGTH);
+				list.phone_number.number[
+					OFONO_MAX_PHONE_NUMBER_LENGTH] =3D '\0';
+			}
+
+			g_free(number);
+			break;
+		}
+		default:
+			DBG("Skipping sub-block: %s (%zd bytes)",
+				ss_subblock_name(g_isi_sb_iter_get_id(&iter)),
+				g_isi_sb_iter_get_len(&iter));
+			break;
+		}
+	}
+
+	DBG("forwarding query: status=3D%d, class=3D%d, number=3D%s(%d) - %d sec",
+		list.status, list.cls,
+		list.phone_number.number,
+		list.phone_number.type, list.time);
+	CALLBACK_WITH_SUCCESS(cb, 1, &list, cbd->data);
+	goto out;
+error:
+	CALLBACK_WITH_FAILURE(cb, 0, NULL, cbd->data);
+out:
+	g_free(cbd);
+	return TRUE;
+}
+
+
+static void isi_query(struct ofono_call_forwarding *cf, int type, int cls,
+			ofono_call_forwarding_query_cb_t cb,
+			void *data)
+{
+	struct forw_data *fd =3D ofono_call_forwarding_get_data(cf);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(cf, cb, data);
+	int ss_code;
+	unsigned char msg[] =3D {
+		SS_SERVICE_REQ,
+		SS_INTERROGATION,
+		SS_GSM_TELEPHONY,
+		0, 0,	/* Supplementary services code */
+		SS_SEND_ADDITIONAL_INFO,
+		0	/* Subblock count */
+	};
+	DBG("forwarding type %d class %d\n", type, cls);
+
+	if (!cbd || cls !=3D 7)
+		goto error;
+
+	ss_code =3D forw_type_to_isi_code(type);
+
+	if (ss_code < 0)
+		goto error;
+
+	msg[3] =3D ss_code >> 8;
+	msg[4] =3D ss_code & 0xFF;
+
+	if (g_isi_request_make(fd->client, msg, sizeof(msg), SS_TIMEOUT,
+				query_resp_cb, cbd))
+		return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, 0, NULL, data);
+	g_free(cbd);
+}
+/*=3D=3D=3D=3D=3D=3D=3D=3DCOMMON starts=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D*/
+static gboolean isi_call_forwarding_register(gpointer user)
+{
+	struct ofono_call_forwarding *cf =3D user;
+	ofono_call_forwarding_register(cf);
+	return FALSE;
+}
+
+static void reachable_cb(GIsiClient *client, gboolean alive, uint16_t obje=
ct,
+				void *opaque)
+{
+	struct ofono_call_forwarding *cf =3D opaque;
+
+	if (!alive) {
+		DBG("Unable to bootstrap call forwarding driver");
+		return;
+	}
+
+	DBG("%s (v%03d.%03d) reachable",
+		pn_resource_name(g_isi_client_resource(client)),
+		g_isi_version_major(client),
+		g_isi_version_minor(client));
+	g_idle_add(isi_call_forwarding_register, cf);
+}
+
+
+static int isi_call_forwarding_probe(struct ofono_call_forwarding *cf,
+					unsigned int vendor, void *user)
+{
+	GIsiModem *idx =3D user;
+	struct forw_data *data;
+	data =3D g_try_new0(struct forw_data, 1);
+
+	if (!data)
+		return -ENOMEM;
+
+	data->client =3D get_pn_ss_client(idx, PN_SS);
+
+	if (!data->client)
+		return -ENOMEM;
+
+	ofono_call_forwarding_set_data(cf, data);
+
+	if (!g_isi_verify(data->client, reachable_cb, cf))
+		DBG("Unable to verify reachability");
+
+	return 0;
+}
+
+static void isi_call_forwarding_remove(struct ofono_call_forwarding *cf)
+{
+	struct forw_data *data =3D ofono_call_forwarding_get_data(cf);
+
+	if (!data)
+		return;
+
+	ofono_call_forwarding_set_data(cf, NULL);
+	pn_ss_client_destroy(data->client);
+	g_free(data);
+}
+
+static struct ofono_call_forwarding_driver driver =3D {
+	.name			=3D "isimodem25",
+	.probe			=3D isi_call_forwarding_probe,
+	.remove			=3D isi_call_forwarding_remove,
+	.activation		=3D NULL,
+	.registration		=3D isi_registration,
+	.deactivation		=3D NULL,
+	.erasure		=3D isi_erasure,
+	.query			=3D isi_query
+};
+
+void isi_call_forwarding_init()
+{
+	ofono_call_forwarding_driver_register(&driver);
+}
+
+void isi_call_forwarding_exit()
+{
+	ofono_call_forwarding_driver_unregister(&driver);
+}
+/*=3D=3D=3D=3D=3D=3D=3D=3DCOMMON end=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D*/
diff --git a/drivers/isimodem2.5/call-settings.c b/drivers/isimodem2.5/call=
-settings.c
new file mode 100644
index 0000000..8e830ca
--- /dev/null
+++ b/drivers/isimodem2.5/call-settings.c
@@ -0,0 +1,1093 @@
+/*
+ * This file is part of oFono - Open Source Telephony
+ *
+ * Copyright (C) 2009 Nokia Corporation and/or its subsidiary(-ies).
+ * Copyright (C) ST-Ericsson SA 2010.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include <gisi/client.h>
+#include <gisi/iter.h>
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/call-settings.h>
+
+#include <glib.h>
+
+#include "call.h"
+#include "debug.h"
+#include "isimodem.h"
+#include "isiutil.h"
+#include "ss.h"
+
+/* File configuration flags */
+
+#define CLIP_ETC
+
+struct settings_data {
+	GIsiClient *client;
+};
+
+#define content_size  40
+static char content[content_size] =3D {0};
+
+/* For using one client of PN_SS */
+GIsiClient *pn_ss_client;
+
+static void update_status_mask(unsigned int *mask, int bsc)
+{
+	switch (bsc) {
+	case SS_GSM_TELEPHONY:
+		*mask |=3D 1;
+		break;
+	case SS_GSM_ALL_DATA_TELE:
+		*mask |=3D 1 << 1;
+		break;
+	case SS_GSM_FACSIMILE:
+		*mask |=3D 1 << 2;
+		break;
+	case SS_GSM_SMS:
+		*mask |=3D 1 << 3;
+		break;
+	case SS_GSM_ALL_DATA_CIRCUIT_SYNC:
+		*mask |=3D 1 << 4;
+		break;
+	case SS_GSM_ALL_DATA_CIRCUIT_ASYNC:
+		*mask |=3D 1 << 5;
+		break;
+	case SS_GSM_ALL_DATA_PACKET_SYNC:
+		*mask |=3D 1 << 6;
+		break;
+	case SS_GSM_ALL_PAD_ACCESS:
+		*mask |=3D 1 << 7;
+		break;
+	default:
+		DBG("Unknown BSC value %d, please report\n", bsc);
+		break;
+	}
+}
+
+#ifdef CLIP_ETC
+static gboolean clip_query_cb(GIsiClient *client, const void *restrict dat=
a,
+				size_t len, uint16_t object, void *opaque)
+{
+	GIsiSubBlockIter iter;
+	const unsigned char *msg =3D data;
+	struct isi_cb_data *cbd =3D opaque;
+	ofono_call_settings_status_cb_t cb =3D cbd->cb;
+	guint32 mask =3D 0;
+
+	if (!msg) {
+		DBG("ISI client error: %d", g_isi_client_error(client));
+		goto error;
+	}
+
+	DBG("%s %s", ss_message_id_name(msg[0]), ss_operation_name(msg[1]));
+
+	if (len < 7 || msg[0] !=3D SS_SERVICE_COMPLETED_RESP)
+		goto error;
+
+	DBG("%s", ss_ss_code_name(msg[3] << 8 | msg[4]));
+
+	if (msg[1] !=3D SS_INTERROGATION)
+		goto error;
+
+	for (g_isi_sb_iter_init(&iter, msg, len, 7);
+	     g_isi_sb_iter_is_valid(&iter);
+	     g_isi_sb_iter_next(&iter)) {
+
+		DBG("Sub-block %s",
+			ss_subblock_name(g_isi_sb_iter_get_id(&iter)));
+
+		switch (g_isi_sb_iter_get_id(&iter)) {
+		case SS_STATUS_RESULT: {
+			guint8 ss_status;
+
+			if (!g_isi_sb_iter_get_byte(&iter, &ss_status, 2))
+				goto error;
+
+			DBG("SS_STATUS_RESULT=3D%d", ss_status);
+
+			if (ss_status & SS_GSM_PROVISIONED)
+				mask =3D 1;
+		}
+		break;
+		case SS_GSM_ADDITIONAL_INFO:
+			break;
+		default:
+			DBG("Skipping sub-block: %s (%zd bytes)",
+				ss_subblock_name(g_isi_sb_iter_get_id(&iter)),
+				g_isi_sb_iter_get_len(&iter));
+			break;
+		}
+	}
+
+	DBG("status_mask %d\n", mask);
+	CALLBACK_WITH_SUCCESS(cb, mask, cbd->data);
+	goto out;
+error:
+	CALLBACK_WITH_FAILURE(cb, 0, cbd->data);
+out:
+	g_free(cbd);
+	return TRUE;
+}
+
+static void isi_clip_query(struct ofono_call_settings *cs,
+				ofono_call_settings_status_cb_t cb, void *data)
+{
+	struct settings_data *sd =3D ofono_call_settings_get_data(cs);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(cs, cb, data);
+	unsigned char msg[] =3D {
+		SS_SERVICE_REQ,
+		SS_INTERROGATION,
+		SS_ALL_TELE_AND_BEARER,
+		SS_GSM_CLIP >> 8,	/* Supplementary services */
+		SS_GSM_CLIP & 0xFF,	/* code */
+		SS_SEND_ADDITIONAL_INFO,
+		0			/* Subblock count */
+	};
+	DBG("");
+
+	if (!cbd)
+		goto error;
+
+	if (g_isi_request_make(sd->client, msg, sizeof(msg), SS_TIMEOUT,
+				clip_query_cb, cbd))
+		return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, 0, data);
+	g_free(cbd);
+}
+
+static int set_clir_status(const char *value)
+{
+	DBG("Setting CLIR status to %s", value);
+	strncpy(content, value, content_size);
+	content[content_size-1] =3D 0;
+	return EXIT_SUCCESS;
+}
+
+int get_clir_status(void)
+{
+	DBG("Getting CLIR status %s", content);
+
+	if (!strcmp(content, "OFONO_CLIR_OPTION_INVOCATION"))
+		return OFONO_CLIR_OPTION_INVOCATION;
+
+	if (!strcmp(content, "OFONO_CLIR_OPTION_SUPPRESSION"))
+		return OFONO_CLIR_OPTION_SUPPRESSION;
+
+	return OFONO_CLIR_OPTION_DEFAULT;
+}
+
+static gboolean clir_set_cb(GIsiClient *client, const void *restrict data,
+				size_t len, uint16_t object, void *opaque)
+{
+	GIsiSubBlockIter iter, iter_info;
+	const unsigned char *msg =3D data;
+	struct isi_cb_data *cbd =3D opaque;
+	ofono_call_settings_set_cb_t cb =3D cbd->cb;
+	gint override =3D OFONO_CLIR_OPTION_DEFAULT;
+	gint network =3D CLIR_STATUS_UNKNOWN;
+
+	if (!msg) {
+		DBG("ISI client error: %d", g_isi_client_error(client));
+		goto error;
+	}
+
+	DBG("%s %s", ss_message_id_name(msg[0]), ss_operation_name(msg[1]));
+
+	if (len < 7 || msg[0] !=3D SS_SERVICE_COMPLETED_RESP)
+		goto error;
+
+	DBG("%s", ss_ss_code_name(msg[3] << 8 | msg[4]));
+
+	if (msg[1] !=3D SS_INTERROGATION)
+		goto error;
+
+	for (g_isi_sb_iter_init(&iter, msg, len, 7);
+	     g_isi_sb_iter_is_valid(&iter);
+	     g_isi_sb_iter_next(&iter)) {
+		DBG("Sub-block %s",
+			ss_subblock_name(g_isi_sb_iter_get_id(&iter)));
+
+		switch (g_isi_sb_iter_get_id(&iter)) {
+		case SS_STATUS_RESULT: {
+			guint8 ss_status;
+
+			if (!g_isi_sb_iter_get_byte(&iter, &ss_status, 2))
+				goto error;
+
+			DBG("SS_STATUS_RESULT=3D%d", ss_status);
+
+			if (!(ss_status & SS_GSM_PROVISIONED))
+				network =3D CLIR_STATUS_NOT_PROVISIONED;
+		}
+		break;
+		case SS_GSM_ADDITIONAL_INFO:
+			break;
+		case SS_GSM_GENERIC_SERVICE_INFO: {
+			guint8 ss_status =3D 0;
+			guint8 clir_option =3D 0;
+			void *info =3D NULL;
+
+			if (!g_isi_sb_iter_get_byte(&iter, &ss_status, 2))
+				goto error;
+
+			if (!(ss_status & SS_GSM_PROVISIONED))
+				network =3D CLIR_STATUS_NOT_PROVISIONED;
+
+			if (!g_isi_sb_iter_get_data(&iter, &info, 4))
+				goto error;
+
+			for (g_isi_sb_iter_init(&iter_info, info, len - 7, 0);
+			     g_isi_sb_iter_is_valid(&iter_info);
+			     g_isi_sb_iter_next(&iter_info)) {
+				DBG("Sub-block %s",
+					ss_subblock_name(
+					    g_isi_sb_iter_get_id(&iter_info)));
+
+				switch (g_isi_sb_iter_get_id(&iter_info)) {
+				case SS_GSM_CLIR_INFO: {
+					if (!g_isi_sb_iter_get_byte(&iter_info,
+							&clir_option, 2))
+						goto error;
+				}
+				break;
+				}
+
+				DBG("SS_STATUS_RESULT=3D%d, CLIR_OPTION=3D%d",
+				    ss_status, clir_option);
+			}
+
+			if (network !=3D CLIR_STATUS_NOT_PROVISIONED) {
+				int result;
+				DBG("CLIR set successfully.");
+				result =3D
+					set_clir_status(
+						"OFONO_CLIR_OPTION_INVOCATION");
+
+				if (result =3D=3D EXIT_FAILURE)
+					goto error;
+			} else {
+				DBG("CLIR option not supported by \
+			  network provider.");
+			}
+		}
+		break;
+		default:
+			DBG("Skipping sub-block: %s (%zd bytes)",
+			    ss_subblock_name(g_isi_sb_iter_get_id(&iter)),
+				g_isi_sb_iter_get_len(&iter));
+			break;
+		}
+	}
+
+	DBG("override=3D%d, network=3D%d\n", override, network);
+	CALLBACK_WITH_SUCCESS(cb, cbd->data);
+	goto out;
+error:
+	CALLBACK_WITH_FAILURE(cb, cbd->data);
+out:
+	g_free(cbd);
+	return TRUE;
+}
+
+static void isi_clir_set(struct ofono_call_settings *cs,
+				int mode,
+				ofono_call_settings_set_cb_t cb,
+				void *data)
+{
+	struct settings_data *sd =3D ofono_call_settings_get_data(cs);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(cs, cb, data);
+	int result =3D 0;
+	/*
+	* CLIR cannot be activated in Network, but we can override it
+	* using local settings - 33GPP TS 24.081 Chapter 2.5
+	*/
+
+	switch (mode) {
+	case(OFONO_CLIR_OPTION_DEFAULT):
+		result =3D set_clir_status("OFONO_CLIR_OPTION_DEFAULT");
+		break;
+		/* CLIR enabled (number not shown) */
+	case(OFONO_CLIR_OPTION_INVOCATION): {
+		/*
+		 * We send interrogation request to check if Network
+		 * has CLIR option provisioned.
+		 */
+		unsigned char msg[] =3D {
+			SS_SERVICE_REQ,
+			SS_INTERROGATION,
+			SS_ALL_TELE_AND_BEARER,
+			SS_GSM_CLIR >> 8,	/* Supplementary services */
+			SS_GSM_CLIR & 0xFF,	/* code */
+			SS_SEND_ADDITIONAL_INFO,
+			0			/* Subblock count */
+		};
+
+		DBG("Attempting to set the CLIR - \
+			checking Network Settings...");
+
+		if (!cbd)
+			goto error;
+
+		if (g_isi_request_make(sd->client, msg, sizeof(msg), SS_TIMEOUT,
+					clir_set_cb, cbd))
+			return;
+		else
+			goto error;
+	}
+	break;
+	case(OFONO_CLIR_OPTION_SUPPRESSION): /* CLIR disabled (number shown) */
+		result =3D set_clir_status("OFONO_CLIR_OPTION_SUPPRESSION");
+		break;
+	default:
+		DBG("CLIR mode not supported %d", mode);
+		break;
+	}
+
+	if (result =3D=3D EXIT_FAILURE)
+		goto error;
+
+	DBG("CLIR set to mode: %d", mode);
+	CALLBACK_WITH_SUCCESS(cb, data);
+	goto out;
+error:
+	CALLBACK_WITH_FAILURE(cb, data);
+out:
+	g_free(cbd);
+	return;
+}
+
+static gboolean clir_query_cb(GIsiClient *client,
+				const void *restrict data, size_t
+				len, uint16_t object, void *opaque)
+{
+	GIsiSubBlockIter iter, iter_info;
+	const unsigned char *msg =3D data;
+	struct isi_cb_data *cbd =3D opaque;
+	ofono_call_settings_clir_cb_t cb =3D cbd->cb;
+	gint override =3D OFONO_CLIR_OPTION_DEFAULT;
+	gint network =3D CLIR_STATUS_UNKNOWN;
+
+	if (!msg) {
+		DBG("ISI client error: %d", g_isi_client_error(client));
+		goto error;
+	}
+
+	DBG("%s %s", ss_message_id_name(msg[0]), ss_operation_name(msg[1]));
+
+	if (len < 7 || msg[0] !=3D SS_SERVICE_COMPLETED_RESP)
+		goto error;
+
+	DBG("%s", ss_ss_code_name(msg[3] << 8 | msg[4]));
+
+	if (msg[1] !=3D SS_INTERROGATION)
+		goto error;
+
+	for (g_isi_sb_iter_init(&iter, msg, len, 7);
+		g_isi_sb_iter_is_valid(&iter);
+		g_isi_sb_iter_next(&iter)) {
+		DBG("Sub-block %s",
+			ss_subblock_name(g_isi_sb_iter_get_id(&iter)));
+
+		switch (g_isi_sb_iter_get_id(&iter)) {
+		case SS_STATUS_RESULT: {
+			guint8 ss_status;
+
+			if (!g_isi_sb_iter_get_byte(&iter, &ss_status, 2))
+				goto error;
+
+			DBG("SS_STATUS_RESULT=3D%d", ss_status);
+
+			if (!(ss_status & SS_GSM_PROVISIONED))
+				network =3D CLIR_STATUS_NOT_PROVISIONED;
+		}
+		break;
+		case SS_GSM_ADDITIONAL_INFO:
+			break;
+		case SS_GSM_GENERIC_SERVICE_INFO: {
+			guint8 ss_status =3D 0;
+			guint8 clir_option =3D 0;
+			void *info =3D NULL;
+
+			if (!g_isi_sb_iter_get_byte(&iter, &ss_status, 2))
+				goto error;
+
+			if (!(ss_status & SS_GSM_PROVISIONED))
+				network =3D CLIR_STATUS_NOT_PROVISIONED;
+
+			if (!g_isi_sb_iter_get_data(&iter, &info, 4))
+				goto error;
+
+			for (g_isi_sb_iter_init(&iter_info, info, len - 7, 0);
+				g_isi_sb_iter_is_valid(&iter_info);
+				g_isi_sb_iter_next(&iter_info)) {
+				DBG("Sub-sub-block %s",
+					ss_subblock_name(
+					g_isi_sb_iter_get_id(&iter_info)));
+
+				switch (g_isi_sb_iter_get_id(&iter_info)) {
+				case SS_GSM_CLIR_INFO: {
+					if (!g_isi_sb_iter_get_byte(&iter_info,
+							&clir_option, 2))
+						goto error;
+				}
+				break;
+				}
+
+				DBG("SS_STATUS_RESULT=3D%d, CLIR_OPTION=3D%d",
+				    ss_status, clir_option);
+			}
+
+			if (network !=3D CLIR_STATUS_NOT_PROVISIONED) {
+				switch (clir_option) {
+				case SS_GSM_CLI_PERMANENT:
+					network =3D
+					  CLIR_STATUS_PROVISIONED_PERMANENT;
+					break;
+				case SS_GSM_DEFAULT_RESTRICTED:
+					network =3D
+					  CLIR_STATUS_TEMPORARY_RESTRICTED;
+					break;
+				case SS_GSM_CLI_DEFAULT_ALLOWED:
+					network =3D
+						CLIR_STATUS_TEMPORARY_ALLOWED;
+					break;
+				case SS_GSM_OVERRIDE_ENABLED:
+					override =3D
+						OFONO_CLIR_OPTION_SUPPRESSION;
+					break;
+				case SS_GSM_OVERRIDE_DISABLED:
+					override =3D
+					  OFONO_CLIR_OPTION_INVOCATION;
+					break;
+				default:
+					break;
+				}
+			}
+		}
+		break;
+		default:
+			DBG("Skipping sub-block: %s (%zd bytes)",
+				ss_subblock_name(g_isi_sb_iter_get_id(&iter)),
+				g_isi_sb_iter_get_len(&iter));
+			break;
+		}
+	}
+
+	/*
+	 * CLIR cannot be activated,registrated in Network, but we can override
+	 * it using local settings - 33GPP TS 24.081 Chapter 2.5
+	 * we have to read status and pass override parameter to Ofono
+	 */
+
+	if (network !=3D CLIR_STATUS_NOT_PROVISIONED) {
+		override =3D get_clir_status();
+		DBG("CLIR mode queried %d\n", override);
+	}
+
+	DBG("override=3D%d, network=3D%d\n", override, network);
+	CALLBACK_WITH_SUCCESS(cb, override, network, cbd->data);
+	goto out;
+error:
+	CALLBACK_WITH_FAILURE(cb, override, network, cbd->data);
+out:
+	g_free(cbd);
+	return TRUE;
+}
+
+static void isi_clir_query(struct ofono_call_settings *cs,
+				ofono_call_settings_clir_cb_t cb, void *data)
+{
+	struct settings_data *sd =3D ofono_call_settings_get_data(cs);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(cs, cb, data);
+	int override =3D 0, network =3D 2;
+	unsigned char msg[] =3D {
+		SS_SERVICE_REQ,
+		SS_INTERROGATION,
+		SS_ALL_TELE_AND_BEARER,
+		SS_GSM_CLIR >> 8,	/* Supplementary services */
+		SS_GSM_CLIR & 0xFF,	/* code */
+		SS_SEND_ADDITIONAL_INFO,
+		0			/* Subblock count */
+	};
+	DBG("");
+
+	if (!cbd)
+		goto error;
+
+	if (g_isi_request_make(sd->client, msg, sizeof(msg), SS_TIMEOUT,
+				clir_query_cb, cbd))
+		return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, override, network, data);
+	g_free(cbd);
+}
+
+static gboolean colp_query_cb(GIsiClient *client, const void *restrict dat=
a,
+				size_t len, uint16_t object, void *opaque)
+{
+	GIsiSubBlockIter iter;
+	const unsigned char *msg =3D data;
+	struct isi_cb_data *cbd =3D opaque;
+	ofono_call_settings_status_cb_t cb =3D cbd->cb;
+	guint32 mask =3D 0;
+
+	if (!msg) {
+		DBG("ISI client error: %d", g_isi_client_error(client));
+		goto error;
+	}
+
+	DBG("%s %s", ss_message_id_name(msg[0]), ss_operation_name(msg[1]));
+
+	if (len < 7 || msg[0] !=3D SS_SERVICE_COMPLETED_RESP) {
+		if (msg[0] =3D=3D SS_SERVICE_FAILED_RESP) {
+			DBG("Sub-block nbr=3D%d, name=3D%s",
+				msg[2], ss_subblock_name(msg[3]));
+		}
+
+		goto error;
+	}
+
+	DBG("%s", ss_ss_code_name(msg[3] << 8 | msg[4]));
+
+	if (msg[1] !=3D SS_INTERROGATION)
+		goto error;
+
+	for (g_isi_sb_iter_init(&iter, msg, len, 7);
+		g_isi_sb_iter_is_valid(&iter);
+		g_isi_sb_iter_next(&iter)) {
+		DBG("Sub-block %s",
+			ss_subblock_name(g_isi_sb_iter_get_id(&iter)));
+
+		switch (g_isi_sb_iter_get_id(&iter)) {
+		case SS_STATUS_RESULT: {
+			guint8 ss_status;
+
+			if (!g_isi_sb_iter_get_byte(&iter, &ss_status, 2))
+				goto error;
+
+			DBG("SS_STATUS_RESULT=3D%d", ss_status);
+
+			if (ss_status & SS_GSM_PROVISIONED)
+				mask =3D 1;
+		}
+		break;
+		case SS_GSM_ADDITIONAL_INFO:
+			break;
+		case SS_GSM_BSC_INFO: {
+			guint8 bsc;
+			guint8 count;
+			guint8 i;
+
+			if (!g_isi_sb_iter_get_byte(&iter, &count, 2))
+				goto error;
+
+			for (i =3D 0; i < count; i++) {
+				if (!g_isi_sb_iter_get_byte(&iter, &bsc, 3 + i))
+					goto error;
+
+				update_status_mask(&mask, bsc);
+			}
+
+			break;
+		}
+		default:
+			DBG("Skipping sub-block: %s (%zd bytes)",
+				ss_subblock_name(g_isi_sb_iter_get_id(&iter)),
+				g_isi_sb_iter_get_len(&iter));
+			break;
+		}
+	}
+
+	DBG("status_mask %d\n", mask);
+	CALLBACK_WITH_SUCCESS(cb, mask, cbd->data);
+	goto out;
+error:
+	CALLBACK_WITH_FAILURE(cb, 0, cbd->data);
+out:
+	g_free(cbd);
+	return TRUE;
+}
+
+static void isi_colp_query(struct ofono_call_settings *cs,
+				ofono_call_settings_status_cb_t cb, void *data)
+{
+	struct settings_data *sd =3D ofono_call_settings_get_data(cs);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(cs, cb, data);
+	unsigned char msg[] =3D {
+		SS_SERVICE_REQ,
+		SS_INTERROGATION,
+		SS_ALL_TELE_AND_BEARER,
+		SS_GSM_COLP >> 8,	/* Supplementary services */
+		SS_GSM_COLP & 0xFF,	/* code */
+		SS_SEND_ADDITIONAL_INFO,
+		0			/* Subblock count */
+	};
+	DBG("");
+
+	if (!cbd)
+		goto error;
+
+	if (g_isi_request_make(sd->client, msg, sizeof(msg), SS_TIMEOUT,
+				colp_query_cb, cbd))
+		return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, 0, data);
+	g_free(cbd);
+}
+
+static gboolean colr_query_cb(GIsiClient *client, const void *restrict dat=
a,
+				size_t len, uint16_t object, void *opaque)
+{
+	GIsiSubBlockIter iter;
+	const unsigned char *msg =3D data;
+	struct isi_cb_data *cbd =3D opaque;
+	ofono_call_settings_status_cb_t cb =3D cbd->cb;
+	guint32 mask =3D 0;
+
+	if (!msg) {
+		DBG("ISI client error: %d", g_isi_client_error(client));
+		goto error;
+	}
+
+	DBG("%s %s", ss_message_id_name(msg[0]), ss_operation_name(msg[1]));
+
+	if (len < 7 || msg[0] !=3D SS_SERVICE_COMPLETED_RESP) {
+		if (msg[0] =3D=3D SS_SERVICE_FAILED_RESP) {
+			DBG("Sub-block nbr=3D%d, name=3D%s",
+				msg[2], ss_subblock_name(msg[3]));
+		}
+
+		goto error;
+	}
+
+	DBG("%s", ss_ss_code_name(msg[3] << 8 | msg[4]));
+	DBG("%s", ss_ss_code_name(msg[3] << 8 | msg[4]));
+
+	if (msg[1] !=3D SS_INTERROGATION)
+		goto error;
+
+	for (g_isi_sb_iter_init(&iter, msg, len, 7);
+		g_isi_sb_iter_is_valid(&iter);
+		g_isi_sb_iter_next(&iter)) {
+		DBG("Sub-block %s",
+			ss_subblock_name(g_isi_sb_iter_get_id(&iter)));
+
+		switch (g_isi_sb_iter_get_id(&iter)) {
+		case SS_STATUS_RESULT: {
+			guint8 ss_status;
+
+			if (!g_isi_sb_iter_get_byte(&iter, &ss_status, 2))
+				goto error;
+
+			DBG("SS_STATUS_RESULT=3D%d", ss_status);
+
+			if (ss_status & SS_GSM_PROVISIONED)
+				mask =3D 1;
+		}
+		break;
+		case SS_GSM_ADDITIONAL_INFO:
+			break;
+		case SS_GSM_BSC_INFO: {
+			guint8 bsc;
+			guint8 count;
+			guint8 i;
+
+			if (!g_isi_sb_iter_get_byte(&iter, &count, 2))
+				goto error;
+
+			for (i =3D 0; i < count; i++) {
+				if (!g_isi_sb_iter_get_byte(&iter, &bsc, 3 + i))
+					goto error;
+
+				update_status_mask(&mask, bsc);
+			}
+
+			break;
+		}
+		default:
+			DBG("Skipping sub-block: %s (%zd bytes)",
+				ss_subblock_name(g_isi_sb_iter_get_id(&iter)),
+				g_isi_sb_iter_get_len(&iter));
+			break;
+		}
+	}
+
+	DBG("status_mask %d\n", mask);
+	CALLBACK_WITH_SUCCESS(cb, mask, cbd->data);
+	goto out;
+error:
+	CALLBACK_WITH_FAILURE(cb, 0, cbd->data);
+out:
+	g_free(cbd);
+	return TRUE;
+}
+
+static void isi_colr_query(struct ofono_call_settings *cs,
+				ofono_call_settings_status_cb_t cb, void *data)
+{
+	struct settings_data *sd =3D ofono_call_settings_get_data(cs);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(cs, cb, data);
+	unsigned char msg[] =3D {
+		SS_SERVICE_REQ,
+		SS_INTERROGATION,
+		SS_ALL_TELE_AND_BEARER,
+		SS_GSM_COLR >> 8,	/* Supplementary services */
+		SS_GSM_COLR & 0xFF,	/* code */
+		SS_SEND_ADDITIONAL_INFO,
+		0			/* Subblock count */
+	};
+	DBG("");
+
+	if (!cbd)
+		goto error;
+
+	if (g_isi_request_make(sd->client, msg, sizeof(msg), SS_TIMEOUT,
+				colr_query_cb, cbd))
+		return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, 0, data);
+	g_free(cbd);
+}
+#endif
+
+static gboolean cw_query_resp_cb(GIsiClient *client, const void *restrict =
data,
+					size_t len,
+					uint16_t object, void *opaque)
+{
+	GIsiSubBlockIter iter;
+	const unsigned char *msg =3D data;
+	struct isi_cb_data *cbd =3D opaque;
+	ofono_call_settings_status_cb_t cb =3D cbd->cb;
+	guint32 mask =3D 0;
+
+	if (!msg) {
+		DBG("ISI client error: %d", g_isi_client_error(client));
+		goto error;
+	}
+
+	DBG("%s %s", ss_message_id_name(msg[0]), ss_operation_name(msg[1]));
+
+	if (len < 7 || msg[0] !=3D SS_SERVICE_COMPLETED_RESP)
+		goto error;
+
+	if (msg[1] !=3D SS_INTERROGATION)
+		goto error;
+
+	DBG("%s", ss_ss_code_name(msg[3] << 8 | msg[4]));
+
+	for (g_isi_sb_iter_init(&iter, msg, len, 7);
+		g_isi_sb_iter_is_valid(&iter);
+		g_isi_sb_iter_next(&iter)) {
+		DBG("Sub-block %s",
+			ss_subblock_name(g_isi_sb_iter_get_id(&iter)));
+
+		switch (g_isi_sb_iter_get_id(&iter)) {
+		case SS_STATUS_RESULT: {
+			guint8 ss_status;
+
+			if (!g_isi_sb_iter_get_byte(&iter, &ss_status, 2))
+				goto error;
+
+			DBG("SS_STATUS_RESULT=3D%d", ss_status);
+
+			if (ss_status & SS_GSM_ACTIVE)
+				mask =3D 1;
+			else
+				mask =3D 0;
+		}
+		break;
+		case SS_GSM_ADDITIONAL_INFO:
+			break;
+		case SS_GSM_BSC_INFO: {
+			guint8 bsc;
+			guint8 count;
+			guint8 i;
+
+			if (!g_isi_sb_iter_get_byte(&iter, &count, 2))
+				goto error;
+
+			for (i =3D 0; i < count; i++) {
+				if (!g_isi_sb_iter_get_byte(&iter, &bsc, 3 + i))
+					goto error;
+
+				update_status_mask(&mask, bsc);
+			}
+
+			break;
+		}
+		default:
+			DBG("Skipping sub-block: %s (%zd bytes)",
+				ss_subblock_name(g_isi_sb_iter_get_id(&iter)),
+			    g_isi_sb_iter_get_len(&iter));
+			break;
+		}
+	}
+
+	DBG("status_mask %d\n", mask);
+	CALLBACK_WITH_SUCCESS(cb, mask, cbd->data);
+	goto out;
+error:
+	CALLBACK_WITH_FAILURE(cb, 0, cbd->data);
+out:
+	g_free(cbd);
+	return TRUE;
+}
+
+static void isi_cw_query(struct ofono_call_settings *cs, int cls,
+				ofono_call_settings_status_cb_t cb, void *data)
+{
+	struct settings_data *sd =3D ofono_call_settings_get_data(cs);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(cs, cb, data);
+	unsigned char msg[] =3D {
+		SS_SERVICE_REQ,
+		SS_INTERROGATION,
+		SS_ALL_TELE_AND_BEARER,
+		SS_GSM_CALL_WAITING >> 8,	/* Supplementary services */
+		SS_GSM_CALL_WAITING & 0xFF,	/* code */
+		SS_SEND_ADDITIONAL_INFO,
+		0				/* Subblock count */
+	};
+	DBG("waiting class %d\n", cls);
+
+	if (!cbd)
+		goto error;
+
+	if (g_isi_request_make(sd->client, msg, sizeof(msg), SS_TIMEOUT,
+				cw_query_resp_cb, cbd))
+		return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, 0, data);
+	g_free(cbd);
+}
+
+static gboolean cw_set_resp_cb(GIsiClient *client, const void *restrict da=
ta,
+				size_t len, uint16_t object, void *opaque)
+{
+	GIsiSubBlockIter iter;
+	const unsigned char *msg =3D data;
+	struct isi_cb_data *cbd =3D opaque;
+	ofono_call_settings_set_cb_t cb =3D cbd->cb;
+	DBG("%s %s", ss_message_id_name(msg[0]), ss_operation_name(msg[1]));
+
+	if (len < 7 || msg[0] !=3D SS_SERVICE_COMPLETED_RESP)
+		goto error;
+
+	if (msg[1] !=3D SS_ACTIVATION && msg[1] !=3D SS_DEACTIVATION)
+		goto error;
+
+	DBG("%s", ss_ss_code_name(msg[3] << 8 | msg[4]));
+
+	for (g_isi_sb_iter_init(&iter, msg, len, 7);
+		g_isi_sb_iter_is_valid(&iter);
+		g_isi_sb_iter_next(&iter)) {
+		DBG("Sub-block %s",
+			ss_subblock_name(g_isi_sb_iter_get_id(&iter)));
+
+		switch (g_isi_sb_iter_get_id(&iter)) {
+		case SS_STATUS_RESULT: {
+			guint8 ss_status;
+
+			if (!g_isi_sb_iter_get_byte(&iter, &ss_status, 2))
+				goto error;
+
+			DBG("SS_STATUS_RESULT=3D%d", ss_status);
+		}
+		break;
+		case SS_GSM_ADDITIONAL_INFO:
+			break;
+		case SS_GSM_DATA: {
+			guint8 status;
+
+			if (!g_isi_sb_iter_get_byte(&iter, &status, 2))
+				goto error;
+
+			if ((status & SS_GSM_ACTIVE)
+			    && (msg[1] =3D=3D SS_DEACTIVATION))
+				goto error;
+
+			if (!(status & SS_GSM_ACTIVE)
+			    && (msg[1] =3D=3D SS_ACTIVATION))
+				goto error;
+
+			break;
+		}
+		default:
+			DBG("Skipping sub-block: %s (%zd bytes)",
+				ss_subblock_name(g_isi_sb_iter_get_id(&iter)),
+				g_isi_sb_iter_get_len(&iter));
+			break;
+		}
+	}
+
+	CALLBACK_WITH_SUCCESS(cb, cbd->data);
+	goto out;
+error:
+	CALLBACK_WITH_FAILURE(cb, cbd->data);
+out:
+	g_free(cbd);
+	return TRUE;
+}
+
+static void isi_cw_set(struct ofono_call_settings *cs, int mode, int cls,
+			ofono_call_settings_set_cb_t cb, void *data)
+{
+	struct settings_data *sd =3D ofono_call_settings_get_data(cs);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(cs, cb, data);
+	unsigned char msg[] =3D {
+		SS_SERVICE_REQ,
+		mode ? SS_ACTIVATION : SS_DEACTIVATION,
+		SS_ALL_TELE_AND_BEARER,
+		SS_GSM_CALL_WAITING >> 8,	/* Supplementary services */
+		SS_GSM_CALL_WAITING & 0xFF,	/* code */
+		SS_SEND_ADDITIONAL_INFO,
+		0				/* Subblock count */
+	};
+	DBG("waiting mode %d class %d\n", mode, cls);
+
+	if (!cbd)
+		goto error;
+
+	if (g_isi_request_make(sd->client, msg, sizeof(msg), SS_TIMEOUT,
+				cw_set_resp_cb, cbd))
+		return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, data);
+	g_free(cbd);
+}
+
+
+/* COMMON starts */
+static gboolean isi_call_settings_register(gpointer user)
+{
+	struct ofono_call_settings *cs =3D user;
+	ofono_call_settings_register(cs);
+	return FALSE;
+}
+
+static void reachable_cb(GIsiClient *client, gboolean alive, uint16_t obje=
ct,
+				void *opaque)
+{
+	struct ofono_call_settings *cs =3D opaque;
+
+	if (!alive) {
+		DBG("Unable to bootstrap call settings driver");
+		return;
+	}
+
+	DBG("%s (v%03d.%03d) reachable",
+		pn_resource_name(g_isi_client_resource(client)),
+		g_isi_version_major(client),
+		g_isi_version_minor(client));
+	g_idle_add(isi_call_settings_register, cs);
+}
+
+
+static int isi_call_settings_probe(struct ofono_call_settings *cs,
+					unsigned int vendor, void *user)
+{
+	GIsiModem *idx =3D user;
+	struct settings_data *data;
+	data =3D g_try_new0(struct settings_data, 1);
+
+	if (!data)
+		return -ENOMEM;
+
+	data->client =3D get_pn_ss_client(idx, PN_SS);
+
+	if (!data->client)
+		return -ENOMEM;
+
+	ofono_call_settings_set_data(cs, data);
+
+	if (!g_isi_verify(data->client, reachable_cb, cs))
+		DBG("Unable to verify reachability");
+
+	return 0;
+}
+
+static void isi_call_settings_remove(struct ofono_call_settings *cs)
+{
+	struct settings_data *data =3D ofono_call_settings_get_data(cs);
+
+	if (!data)
+		return;
+
+	ofono_call_settings_set_data(cs, NULL);
+	pn_ss_client_destroy(data->client);
+	g_free(data);
+}
+
+static struct ofono_call_settings_driver driver =3D {
+	.name			=3D "isimodem25",
+	.probe			=3D isi_call_settings_probe,
+	.remove			=3D isi_call_settings_remove,
+	.clip_query		=3D isi_clip_query,
+	.colp_query		=3D isi_colp_query,
+	.clir_query		=3D isi_clir_query,
+	.colr_query		=3D isi_colr_query,
+	.clir_set		=3D isi_clir_set,
+	.cw_query		=3D isi_cw_query,
+	.cw_set			=3D isi_cw_set
+};
+
+void isi_call_settings_init()
+{
+	pn_ss_client =3D NULL;
+	ofono_call_settings_driver_register(&driver);
+}
+
+void isi_call_settings_exit()
+{
+	ofono_call_settings_driver_unregister(&driver);
+}
+
+GIsiClient *get_pn_ss_client(GIsiModem *modem, uint8_t resource)
+{
+	if (!pn_ss_client)
+		pn_ss_client =3D g_isi_client_create(modem, resource);
+
+	return pn_ss_client;
+}
+
+void pn_ss_client_destroy(GIsiClient *client)
+{
+	if (pn_ss_client) {
+		g_isi_client_destroy(client);
+		pn_ss_client =3D NULL;
+	}
+}
+/* COMMON end */
diff --git a/drivers/isimodem2.5/call.h b/drivers/isimodem2.5/call.h
new file mode 100644
index 0000000..a0ba50c
--- /dev/null
+++ b/drivers/isimodem2.5/call.h
@@ -0,0 +1,237 @@
+/*
+ * This file is part of oFono - Open Source Telephony
+ *
+ * Copyright (C) 2009 Nokia Corporation and/or its subsidiary(-ies).
+ * Copyright (C) ST-Ericsson SA 2010.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#ifndef __ISIMODEM25_CALL_H
+#define __ISIMODEM25_CALL_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#define PN_MODEM_CALL					0xC9
+
+enum call_subblock {
+	CALL_MODEM_SB_ORIGIN_ADDRESS =3D			0x01,
+	CALL_MODEM_SB_DESTINATION_ADDRESS =3D		0x03,
+	CALL_MODEM_SB_DESTINATION_SUBADDRESS =3D		0x04,
+	CALL_MODEM_SB_DESTINATION_PRE_ADDRESS =3D		0x05,
+	CALL_MODEM_SB_DESTINATION_POST_ADDRESS =3D	0x06,
+	CALL_MODEM_SB_MODE =3D				0x07,
+	CALL_MODEM_SB_CAUSE =3D				0x08,
+	CALL_MODEM_SB_OPERATION =3D			0x09,
+	CALL_MODEM_SB_DTMF_STRING =3D			0x10,
+	CALL_MODEM_SB_STATUS =3D				0x0A,
+	CALL_MODEM_SB_STATUS_INFO =3D			0x0B,
+	CALL_MODEM_SB_DTMF_INFO =3D			0x1A,
+	CALL_MODEM_SB_ADDR_AND_STATUS_INFO =3D		0x1D,
+	CALL_MODEM_SB_DTMF_TIMERS =3D			0x1E,
+	CALL_MODEM_SB_STATUS_MODE =3D			0x1C,
+	CALL_MODEM_SB_NW_CAUSE =3D			0x20,
+	CALL_MODEM_SB_LINE_ID =3D				0x47,
+	CALL_MODEM_SB_DETAILED_CAUSE =3D			0xBF
+};
+
+enum call_message_id {
+	CALL_MODEM_CREATE_REQ =3D				0x01,
+	CALL_MODEM_CREATE_RESP =3D			0x02,
+	CALL_MODEM_MT_ALERT_IND =3D			0x05,
+	CALL_MODEM_ANSWER_REQ =3D				0x07,
+	CALL_MODEM_ANSWER_RESP =3D			0x08,
+	CALL_MODEM_RELEASE_REQ =3D			0x09,
+	CALL_MODEM_RELEASE_RESP =3D			0x0A,
+	CALL_MODEM_STATUS_REQ =3D				0x0D,
+	CALL_MODEM_STATUS_RESP =3D			0x0E,
+	CALL_MODEM_STATUS_IND =3D				0x0F,
+	CALL_MODEM_CONTROL_REQ =3D			0x11,
+	CALL_MODEM_CONTROL_RESP =3D			0x12,
+	CALL_MODEM_CONTROL_IND =3D			0x13,
+	CALL_MODEM_DTMF_SEND_REQ =3D			0x17,
+	CALL_MODEM_DTMF_SEND_RESP =3D			0x18,
+	CALL_MODEM_NOTIFICATION_IND =3D			0xA0
+};
+
+enum call_modem_mode {
+	CALL_MODEM_MODE_SPEECH =3D			0x01
+};
+
+enum call_modem_line_id {
+	CALL_MODEM_PRESENT_DEFAULT =3D			0x00,
+	CALL_MODEM_PRESENT_ALLOWED =3D			0x01,
+	CALL_MODEM_PRESENT_RESTRICTED =3D			0x02
+};
+
+enum call_modem_mode_info {
+	CALL_MODEM_MODE_ORIGINATOR =3D			0x01
+};
+
+enum call_modem_cause {
+	CALL_MODEM_CAUSE_NO_CALL =3D			0x01,
+	CALL_MODEM_CAUSE_RELEASE_BY_USER =3D		0x03,
+	CALL_MODEM_CAUSE_BUSY_USER_REQUEST =3D		0x04,
+	CALL_MODEM_NW_CAUSE_NORMAL =3D			0x10,
+	CALL_MODEM_NW_CAUSE_FACILITY_REJECTED =3D		0x1D
+};
+
+enum call_modem_operation {
+	CALL_MODEM_OP_UNKNOWN =3D				0x00,
+	CALL_MODEM_OP_HOLD =3D				0x01,
+	CALL_MODEM_OP_RETRIEVE =3D			0x02,
+	CALL_MODEM_OP_SWAP =3D				0x03,
+	CALL_MODEM_OP_CONFERENCE_BUILD =3D		0x04,
+	CALL_MODEM_OP_CONFERENCE_SPLIT =3D		0x05,
+	CALL_MODEM_OP_TRANSFER =3D			0xA1
+};
+
+enum call_modem_cause_type_sender {
+	CALL_MODEM_CAUSE_TYPE_CLIENT =3D			0x01,
+	CALL_MODEM_CAUSE_TYPE_SERVER =3D			0x02,
+	CALL_MODEM_CAUSE_TYPE_NETWORK =3D			0x03
+};
+
+enum call_modem_status_mode {
+	CALL_MODEM_STATUS_IDLE =3D			0x00,
+	CALL_MODEM_STATUS_CREATE =3D			0x01,
+	CALL_MODEM_STATUS_COMING =3D			0x02,
+	CALL_MODEM_STATUS_PROCEEDING =3D			0x03,
+	CALL_MODEM_STATUS_MO_ALERTING =3D			0x04,
+	CALL_MODEM_STATUS_MT_ALERTING =3D			0x05,
+	CALL_MODEM_STATUS_WAITING =3D			0x06,
+	CALL_MODEM_STATUS_ANSWERED =3D			0x07,
+	CALL_MODEM_STATUS_ACTIVE =3D			0x08,
+	CALL_MODEM_STATUS_MO_RELEASE =3D			0x09,
+	CALL_MODEM_STATUS_MT_RELEASE =3D			0x0A,
+	CALL_MODEM_STATUS_HOLD_INITIATED =3D		0x0B,
+	CALL_MODEM_STATUS_HOLD =3D			0x0C,
+	CALL_MODEM_STATUS_RETRIEVE_INITIATED =3D		0x0D,
+	CALL_MODEM_STATUS_RECONNECT_PENDING =3D		0x0E
+};
+
+enum call_modem_status_mod {
+	CALL_MODEM_STATUS_MODE_ADDR_AND_ORIGIN =3D	0x02
+};
+
+enum call_modem_id {
+	CALL_MODEM_ID_NONE =3D				0x00,
+	CALL_MODEM_ID_1 =3D				0x01,
+	CALL_MODEM_ID_2 =3D				0x02,
+	CALL_MODEM_ID_3 =3D				0x03,
+	CALL_MODEM_ID_4 =3D				0x04,
+	CALL_MODEM_ID_WAITING =3D				0x20,
+	CALL_MODEM_ID_HOLD =3D				0x40,
+	CALL_MODEM_ID_ACTIVE =3D				0x80,
+	CALL_MODEM_ID_ALL =3D				0xF0
+};
+
+enum call_modem_dtmf_pause_values {
+	CALL_MODEM_DTMF_PAUSE_1S =3D			0x01
+};
+
+enum call_modem_dtmf_info_values {
+	CALL_MODEM_DTMF_ENABLE_TONE_IND_SEND =3D		0x01
+};
+
+enum call_modem_notification_sb_values {
+	CALL_MODEM_SB_NOTIFY =3D				0xB1,
+	CALL_MODEM_SB_SS_NOTIFY =3D			0xB2,
+	CALL_MODEM_SB_SS_CODE =3D				0xB3,
+	CALL_MODEM_SB_SS_STATUS =3D			0xB4,
+	CALL_MODEM_SB_SS_NOTIFY_INDICATOR =3D		0xB5,
+	CALL_MODEM_SB_SS_HOLD_INDICATOR =3D		0xB6,
+	CALL_MODEM_SB_SS_ECT_INDICATOR =3D		0xB7,
+	CALL_MODEM_SB_REMOTE_ADDRESS =3D			0xA6,
+	CALL_MODEM_SB_REMOTE_SUBADDRESS =3D		0xA7,
+	CALL_MODEM_SB_CUG_INFO =3D			0xA0,
+	CALL_MODEM_SB_ORIGIN_INFO =3D			0x0E,
+	CALL_MODEM_SB_ALERTING_PATTERN =3D		0xA1,
+	CALL_MODEM_SB_ALERTING_INFO =3D			0x0C
+};
+
+enum call_modem_notification_indicator {
+	CALL_MODEM_NOTIFY_USER_SUSPENDED =3D		0x00,
+	CALL_MODEM_NOTIFY_USER_RESUMED =3D		0x01,
+	CALL_MODEM_NOTIFY_BEARER_CHANGE =3D		0x02
+};
+
+enum call_modem_mmi_ss_codes {
+	CALL_MODEM_SSC_ALL_FWDS =3D			0x0002,
+	CALL_MODEM_SSC_ALL_COND_FWD =3D			0x0004,
+	CALL_MODEM_SSC_CFU =3D				0x0015,
+	CALL_MODEM_SSC_CFB =3D				0x0043,
+	CALL_MODEM_SSC_CFNRY =3D				0x003D,
+	CALL_MODEM_SSC_CFGNC =3D				0x003E,
+	CALL_MODEM_SSC_OUTGOING_BARR_SERV =3D		0x014D,
+	CALL_MODEM_SSC_INCOMING_BARR_SERV =3D		0x0161,
+	CALL_MODEM_SSC_CALL_WAITING =3D			0x002B,
+	CALL_MODEM_SSC_CLIR =3D				0x001F,
+	CALL_MODEM_SSC_ETC =3D				0x0060,
+	CALL_MODEM_SSC_MPTY =3D				0xFFFE,
+	CALL_MODEM_SSC_CALL_HOLD =3D			0xFFFF
+};
+
+enum call_modem_ss_status {
+	CALL_MODEM_SS_STATUS_ACTIVE =3D			0x01,
+	CALL_MODEM_SS_STATUS_REGISTERED =3D		0x02,
+	CALL_MODEM_SS_STATUS_PROVISIONED =3D		0x04,
+	CALL_MODEM_SS_STATUS_QUIESCENT =3D		0x08
+};
+
+enum call_modem_ss_notification {
+	CALL_MODEM_SSN_INCOMING_IS_FWD =3D		0x01,
+	CALL_MODEM_SSN_INCOMING_FWD =3D			0x02,
+	CALL_MODEM_SSN_OUTGOING_FWD =3D			0x04
+};
+
+enum call_modem_ss_indicator {
+	CALL_MODEM_SSI_CALL_IS_WAITING =3D		0x01,
+	CALL_MODEM_SSI_MPTY =3D				0x02,
+	CALL_MODEM_SSI_CLIR_SUPPR_REJ =3D			0x04
+};
+
+enum call_modem_ss_hold_indicator {
+	CALL_MODEM_HOLD_IND_RETRIEVED =3D			0x00,
+	CALL_MODEM_HOLD_IND_ON_HOLD =3D			0x01
+};
+
+enum call_modem_ss_ect_indicator {
+	CALL_MODEM_ECT_CALL_STATE_ALERT =3D		0x00,
+	CALL_MODEM_ECT_CALL_STATE_ACTIVE =3D		0x01
+};
+
+/* 27.007 Section 7.7 */
+enum clir_status {
+	CLIR_STATUS_NOT_PROVISIONED =3D			0,
+	CLIR_STATUS_PROVISIONED_PERMANENT,
+	CLIR_STATUS_UNKNOWN,
+	CLIR_STATUS_TEMPORARY_RESTRICTED,
+	CLIR_STATUS_TEMPORARY_ALLOWED
+};
+
+int get_clir_status(void);
+
+GIsiClient *get_pn_callserver_client(GIsiModem *modem, uint8_t resource);
+void pn_callserver_client_destroy(GIsiClient *client);
+
+#ifdef __cplusplus
+};
+#endif
+
+#endif /* !__ISIMODEM25_CALL_H */
diff --git a/drivers/isimodem2.5/cbs.c b/drivers/isimodem2.5/cbs.c
new file mode 100644
index 0000000..c0087a5
--- /dev/null
+++ b/drivers/isimodem2.5/cbs.c
@@ -0,0 +1,433 @@
+/*
+ * This file is part of oFono - Open Source Telephony
+ *
+ * Copyright (C) 2009 Nokia Corporation and/or its subsidiary(-ies).
+ * Copyright (C) ST-Ericsson SA 2010.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <inttypes.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/uio.h>
+
+#include <gisi/client.h>
+#include <gisi/iter.h>
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/cbs.h>
+
+#include <glib.h>
+
+#include "debug.h"
+#include "isimodem.h"
+#include "isiutil.h"
+#include "sms.h"
+
+int cbs_subscription_nr;
+
+struct cbs_data {
+	GIsiClient *client;
+};
+
+GIsiClient *pn_sms_client;
+
+static void reset_buf(char *buf, char *buf_2, int buf_len)
+{
+	memset(buf, '\0', buf_len);
+	memset(buf_2, '\0', buf_len);
+}
+
+static int get_topics_len(const char *topics)
+{
+	int i =3D 0;
+	int k =3D 0;
+	int length =3D 0;
+	char buf[6];
+	char buf_2[6];
+
+	reset_buf(buf, buf_2, 6);
+
+	while (*topics !=3D '\0') {
+		if (*topics =3D=3D ',') {
+			reset_buf(buf, buf_2, 6);
+			k =3D 0;
+			length++;
+		} else if (*topics !=3D ',' && *topics !=3D '-') {
+			buf[k] =3D *topics;
+			k++;
+		} else if (*topics =3D=3D '-') {
+			topics++;
+			i++;
+			k =3D 0;
+
+			while (*topics !=3D ',' && *topics !=3D '\0') {
+				buf_2[k] =3D *topics;
+				topics++;
+				i++;
+				k++;
+			}
+
+			length =3D length + atoi(buf_2) - atoi(buf) + 1;
+			k =3D 0;
+		}
+
+		topics++;
+		i++;
+	}
+
+	topics =3D topics - i;
+	return length;
+}
+
+static void parse_topics(const char *topics, gint16 *topics_parsed)
+{
+	int j =3D 0;
+	int k =3D 0;
+	char buf[6];
+	char buf_2[6];
+
+	reset_buf(buf, buf_2, 6);
+
+	while (*topics !=3D '\0') {
+		if (*topics !=3D ',' && *topics !=3D '-') {
+			buf[j] =3D *topics;
+			j++;
+		} else if (*topics =3D=3D '-') {
+			topics++;
+			j =3D 0;
+
+			while (*topics !=3D ',' && *topics !=3D '\0') {
+				buf_2[j] =3D *topics;
+				topics++;
+				j++;
+			}
+
+			for (j =3D 0; j <=3D (atoi(buf_2) - atoi(buf)); j++) {
+				topics_parsed[k] =3D atoi(buf) + j;
+				topics_parsed[k] =3D g_ntohs(topics_parsed[k]);
+				k++;
+			}
+
+			j =3D 0;
+		} else if (*topics =3D=3D ',') {
+			topics_parsed[k] =3D atoi(buf);
+			topics_parsed[k] =3D g_ntohs(topics_parsed[k]);
+			reset_buf(buf, buf_2, 6);
+			j =3D 0;
+			k++;
+		}
+
+		topics++;
+	}
+}
+
+static gboolean set_resp_cb(GIsiClient *client, const void *restrict data,
+				size_t len, uint16_t object, void *opaque)
+{
+	const unsigned char *msg =3D data;
+	struct isi_cb_data *cbd =3D opaque;
+	ofono_cbs_set_cb_t cb =3D cbd->cb;
+
+	DBG("");
+
+	if (!msg) {
+		DBG("ISI client error: %d", g_isi_client_error(client));
+		goto error;
+	}
+
+	if (len < 3 || msg[0] !=3D SMS_CB_ROUTING_RESP)
+		goto error;
+
+	if (msg[2] !=3D SMS_OK)
+		goto error;
+
+	cbs_subscription_nr =3D msg[1];
+	CALLBACK_WITH_SUCCESS(cb, cbd->data);
+	goto out;
+error:
+	CALLBACK_WITH_FAILURE(cb, cbd->data);
+out:
+	g_free(cbd);
+	return TRUE;
+}
+
+static void isi_set_topics(struct ofono_cbs *cbs, const char *topics,
+				ofono_cbs_set_cb_t cb, void *data)
+{
+	struct cbs_data *cd =3D ofono_cbs_get_data(cbs);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(cbs, cb, data);
+	int topics_len =3D get_topics_len(topics);
+	gint16 topics_out[topics_len];
+
+	uint8_t msg[] =3D {
+		SMS_CB_ROUTING_REQ,
+		SMS_ROUTING_SET,
+		cbs_subscription_nr,
+		0x00,			/*Subscription type*/
+		0x00,			/*Fillers*/
+		0x00,
+		0x01,			/*Number of subblocks*/
+		0x00,
+		0x26,			/*Subblock*/
+		0x00,
+		topics_len * 2 + 6,	/*Subblock length*/
+		0x00,
+		topics_len,		/*Number of topics*/
+	};
+	struct iovec iov[2] =3D {
+		{ msg, sizeof(msg) },
+		{ topics_out, sizeof(topics_out) },
+	};
+	parse_topics(topics, topics_out);
+
+	DBG("");
+
+	if (g_isi_request_vmake(cd->client, iov, 2, CBS_TIMEOUT,
+				set_resp_cb, cbd))
+		return;
+
+	CALLBACK_WITH_FAILURE(cb, data);
+	g_free(cbd);
+}
+
+static gboolean clear_resp_cb(GIsiClient *client, const void *restrict dat=
a,
+				size_t len, uint16_t object, void *opaque)
+{
+	const unsigned char *msg =3D data;
+	struct isi_cb_data *cbd =3D opaque;
+	ofono_cbs_set_cb_t cb =3D cbd->cb;
+	DBG("");
+
+	if (!msg)
+		DBG("ISI client error: %d", g_isi_client_error(client));
+
+	cbs_subscription_nr =3D 0;
+	CALLBACK_WITH_SUCCESS(cb, cbd->data);
+	goto out;
+out:
+	g_free(cbd);
+	return TRUE;
+}
+
+static void isi_clear_topics(struct ofono_cbs *cbs,
+				ofono_cbs_set_cb_t cb, void *data)
+{
+	struct cbs_data *cd =3D ofono_cbs_get_data(cbs);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(cbs, cb, data);
+	uint8_t msg[] =3D {
+		SMS_CB_ROUTING_REQ,
+		SMS_ROUTING_RELEASE,
+		cbs_subscription_nr,	/* Subscription number */
+		0x00,			/* Subscription type */
+		0x00,			/* Fillers */
+		0x00,
+		0x00			/*No subblocks*/
+	};
+
+	DBG("");
+
+	if (g_isi_request_make(cd->client, msg, sizeof(msg), CBS_TIMEOUT,
+				clear_resp_cb, cbd))
+		return;
+
+	CALLBACK_WITH_FAILURE(cb, data);
+	g_free(cbd);
+}
+
+static void routing_ntf_cb(GIsiClient *client,
+				const void *restrict data, size_t len,
+				uint16_t object, void *opaque)
+{
+	const unsigned char *msg =3D data;
+	struct ofono_cbs *cbs =3D opaque;
+	GIsiSubBlockIter iter;
+	gboolean message_received =3D FALSE;
+	guint16 subblock_len;
+	guint8 i;
+	DBG("");
+
+	if (!msg || len < 3 || msg[0] !=3D SMS_CB_ROUTING_IND)
+		return;
+
+	for (g_isi_sb_iter_init_full(&iter, msg, len, 3, TRUE, msg[2]);
+	     g_isi_sb_iter_is_valid(&iter);
+	     g_isi_sb_iter_next(&iter)) {
+		switch (g_isi_sb_iter_get_id(&iter)) {
+		case SMS_SB_CB_MESSAGE: {
+			msg =3D iter.start + 4;
+			len =3D len - 4;
+			message_received =3D TRUE;
+			break;
+		}
+		case SMS_SB_CBS_SUBSCRIPTION: {
+			g_isi_sb_iter_get_word(&iter, &subblock_len, 2);
+			len =3D len - subblock_len;
+			break;
+		}
+		default:
+			break;
+		}
+	}
+
+	if (message_received) {
+		unsigned char *buf_msg =3D g_try_new(unsigned char, 91);
+		/*91 is a fixed size of CBS message including fillers*/
+
+		DBG("CBS Message received");
+		len =3D len - 7; /*exclude message header and fillers*/
+
+		for (i =3D 0; i < 91; i++) {
+			if (i < 6)
+				buf_msg[i] =3D msg[i];
+			else
+				buf_msg[i] =3D msg[i+1];
+		}
+
+		ofono_cbs_notify(cbs, buf_msg, len);
+		g_free(buf_msg);
+	} else
+		DBG("Error reading CBS message");
+}
+
+static gboolean routing_resp_cb(GIsiClient *client,
+				const void *restrict data, size_t len,
+				uint16_t object, void *opaque)
+{
+	const unsigned char *msg =3D data;
+	struct ofono_cbs *cbs =3D opaque;
+	DBG("");
+
+	if (!msg) {
+		DBG("ISI client error: %d", g_isi_client_error(client));
+		return TRUE;
+	}
+
+	if (len < 3 || msg[0] !=3D SMS_CB_ROUTING_RESP)
+		return FALSE;
+
+	if (msg[1] !=3D SMS_OK) {
+		if (msg[1] =3D=3D SMS_ERR_PP_RESERVED) {
+			DBG("Request failed:CBS already registered");
+			return TRUE;
+		}
+	}
+
+	g_isi_subscribe(client, SMS_CB_ROUTING_IND, routing_ntf_cb,
+			cbs);
+	ofono_cbs_register(cbs);
+	return TRUE;
+}
+
+
+static int isi_cbs_probe(struct ofono_cbs *cbs, unsigned int vendor, void =
*user)
+{
+	GIsiModem *idx =3D user;
+	struct cbs_data *cd =3D g_try_new0(struct cbs_data, 1);
+	unsigned char msg[] =3D {
+		SMS_CB_ROUTING_REQ,
+		SMS_ROUTING_QUERRY_ALL,
+		0x00,			/* New subscription*/
+		0x00,			/* Subscription type */
+		0x00,			/* Fillers */
+		0x00,
+		0x00			/* No subblocks*/
+	};
+
+	DBG("");
+
+	if (!cd)
+		return -ENOMEM;
+
+	cd->client =3D get_pn_sms_client(idx, PN_SMS);
+
+	if (!cd->client) {
+		g_free(cd);
+		return -ENOMEM;
+	}
+
+	ofono_cbs_set_data(cbs, cd);
+
+	if (!g_isi_request_make(cd->client, msg, sizeof(msg), CBS_TIMEOUT,
+				routing_resp_cb, cbs))
+		DBG("Failed to set CBS routing.");
+
+	return 0;
+}
+
+static gboolean isi_cbs_remove_cb(GIsiClient *client,
+					const void *restrict data,
+					size_t len,
+					uint16_t object, void *opaque)
+{
+	DBG("CBS subscription released.");
+	return TRUE;
+}
+
+static void isi_cbs_remove(struct ofono_cbs *cbs)
+{
+	struct cbs_data *data =3D ofono_cbs_get_data(cbs);
+	uint8_t msg[] =3D {
+		SMS_CB_ROUTING_REQ,
+		SMS_ROUTING_RELEASE,
+		cbs_subscription_nr,	/* Subscription number */
+		0x00,			/* Subscription type */
+		0x00,			/* Fillers */
+		0x00,
+		0x00			/* No subblocks*/
+	};
+
+	DBG("");
+
+	if (!data)
+		return;
+
+	if (is_pn_sms_client()) {
+		/* Release of modem resources for CBS subscription. */
+		cbs_subscription_nr =3D 0;
+		g_isi_request_make(data->client, msg, sizeof(msg),
+				CBS_TIMEOUT, isi_cbs_remove_cb, NULL);
+		pn_sms_client_destroy(data->client);
+	}
+	g_free(data);
+}
+
+static struct ofono_cbs_driver driver =3D {
+	.name			=3D "isimodem25",
+	.probe			=3D isi_cbs_probe,
+	.remove			=3D isi_cbs_remove,
+	.set_topics		=3D isi_set_topics,
+	.clear_topics		=3D isi_clear_topics
+};
+
+void isi_cbs_init()
+{
+	ofono_cbs_driver_register(&driver);
+}
+
+void isi_cbs_exit()
+{
+	ofono_cbs_driver_unregister(&driver);
+}
+
diff --git a/drivers/isimodem2.5/checkpatch.pl b/drivers/isimodem2.5/checkp=
atch.pl
new file mode 100755
index 0000000..a4d7434
--- /dev/null
+++ b/drivers/isimodem2.5/checkpatch.pl
@@ -0,0 +1,2789 @@
+#!/usr/bin/perl -w
+# (c) 2001, Dave Jones. (the file handling bit)
+# (c) 2005, Joel Schopp <jschopp@austin.ibm.com> (the ugly bit)
+# (c) 2007,2008, Andy Whitcroft <apw@uk.ibm.com> (new conditions, test s=
uite)
+# (c) 2008,2009, Andy Whitcroft <apw@canonical.com>
+# Licensed under the terms of the GNU GPL License version 2
+
+use strict;
+
+my $P =3D $0;
+$P =3D~ s(a).*/@@g;
+
+my $V =3D '0.30';
+
+use Getopt::Long qw(:config no_auto_abbrev);
+
+my $quiet =3D 0;
+my $tree =3D 1;
+my $chk_signoff =3D 1;
+my $chk_patch =3D 1;
+my $tst_only;
+my $emacs =3D 0;
+my $terse =3D 0;
+my $file =3D 0;
+my $check =3D 0;
+my $summary =3D 1;
+my $mailback =3D 0;
+my $summary_file =3D 0;
+my $root;
+my %debug;
+my $help =3D 0;
+
+sub help {
+	my ($exitcode) =3D @_;
+
+	print << "EOM";
+Usage: $P [OPTION]... [FILE]...
+Version: $V
+
+Options:
+  -q, --quiet                quiet
+  --no-tree                  run without a kernel tree
+  --no-signoff               do not check for 'Signed-off-by' line
+  --patch                    treat FILE as patchfile (default)
+  --emacs                    emacs compile window format
+  --terse                    one line per report
+  -f, --file                 treat FILE as regular source file
+  --subjective, --strict     enable more subjective tests
+  --root=3DPATH                PATH to the kernel tree root
+  --no-summary               suppress the per-file summary
+  --mailback                 only produce a report in case of warnings/err=
ors
+  --summary-file             include the filename in summary
+  --debug KEY=3D[0|1]          turn on/off debugging of KEY, where KEY is =
one of
+                             'values', 'possible', 'type', and 'attr' (def=
ault
+                             is all off)
+  --test-only=3DWORD           report only warnings/errors containing WORD
+                             literally
+  -h, --help, --version      display this help and exit
+
+When FILE is - read standard input.
+EOM
+
+	exit($exitcode);
+}
+
+GetOptions(
+	'q|quiet+'	=3D> \$quiet,
+	'tree!'		=3D> \$tree,
+	'signoff!'	=3D> \$chk_signoff,
+	'patch!'	=3D> \$chk_patch,
+	'emacs!'	=3D> \$emacs,
+	'terse!'	=3D> \$terse,
+	'f|file!'	=3D> \$file,
+	'subjective!'	=3D> \$check,
+	'strict!'	=3D> \$check,
+	'root=3Ds'	=3D> \$root,
+	'summary!'	=3D> \$summary,
+	'mailback!'	=3D> \$mailback,
+	'summary-file!'	=3D> \$summary_file,
+
+	'debug=3Ds'	=3D> \%debug,
+	'test-only=3Ds'	=3D> \$tst_only,
+	'h|help'	=3D> \$help,
+	'version'	=3D> \$help
+) or help(1);
+
+help(0) if ($help);
+
+my $exit =3D 0;
+
+if ($#ARGV < 0) {
+	print "$P: no input files\n";
+	exit(1);
+}
+
+my $dbg_values =3D 0;
+my $dbg_possible =3D 0;
+my $dbg_type =3D 0;
+my $dbg_attr =3D 0;
+for my $key (keys %debug) {
+	## no critic
+	eval "\${dbg_$key} =3D '$debug{$key}';";
+	die "$@" if ($@);
+}
+
+if ($terse) {
+	$emacs =3D 1;
+	$quiet++;
+}
+
+if ($tree) {
+	if (defined $root) {
+		if (!top_of_kernel_tree($root)) {
+			die "$P: $root: --root does not point@a valid tree\n";
+		}
+	} else {
+		if (top_of_kernel_tree('.')) {
+			$root =3D '.';
+		} elsif ($0 =3D~ m@(.*)/scripts/[^/]*$@ &&
+						top_of_kernel_tree($1)) {
+			$root =3D $1;
+		}
+	}
+
+	if (!defined $root) {
+		print "Must be run from the top-level dir. of a kernel tree\n";
+		exit(2);
+	}
+}
+
+my $emitted_corrupt =3D 0;
+
+our $Ident	=3D qr{
+			[A-Za-z_][A-Za-z\d_]*
+			(?:\s*\#\#\s*[A-Za-z_][A-Za-z\d_]*)*
+		}x;
+our $Storage	=3D qr{extern|static|asmlinkage};
+our $Sparse	=3D qr{
+			__user|
+			__kernel|
+			__force|
+			__iomem|
+			__must_check|
+			__init_refok|
+			__kprobes|
+			__ref
+		}x;
+
+# Notes to $Attribute:
+# We need \b after 'init' otherwise 'initconst' will cause a false positiv=
e in a check
+our $Attribute	=3D qr{
+			const|
+			__read_mostly|
+			__kprobes|
+			__(?:mem|cpu|dev|)(?:initdata|initconst|init\b)|
+			____cacheline_aligned|
+			____cacheline_aligned_in_smp|
+			____cacheline_internodealigned_in_smp|
+			__weak
+		  }x;
+our $Modifier;
+our $Inline	=3D qr{inline|__always_inline|noinline};
+our $Member	=3D qr{->$Ident|\.$Ident|\[[^]]*\]};
+our $Lval	=3D qr{$Ident(?:$Member)*};
+
+our $Constant	=3D qr{(?:[0-9]+|0x[0-9a-fA-F]+)[UL]*};
+our $Assignment	=3D qr{(?:\*\=3D|/=3D|%=3D|\+=3D|-=3D|<<=3D|>>=3D|&=3D|\^=
=3D|\|=3D|=3D)};
+our $Compare    =3D qr{<=3D|>=3D|=3D=3D|!=3D|<|>};
+our $Operators	=3D qr{
+			<=3D|>=3D|=3D=3D|!=3D|
+			=3D>|->|<<|>>|<|>|!|~|
+			&&|\|\||,|\^|\+\+|--|&|\||\+|-|\*|\/|%
+		  }x;
+
+our $NonptrType;
+our $Type;
+our $Declare;
+
+our $UTF8	=3D qr {
+	[\x09\x0A\x0D\x20-\x7E]              # ASCII
+	| [\xC2-\xDF][\x80-\xBF]             # non-overlong 2-byte
+	|  \xE0[\xA0-\xBF][\x80-\xBF]        # excluding overlongs
+	| [\xE1-\xEC\xEE\xEF][\x80-\xBF]{2}  # straight 3-byte
+	|  \xED[\x80-\x9F][\x80-\xBF]        # excluding surrogates
+	|  \xF0[\x90-\xBF][\x80-\xBF]{2}     # planes 1-3
+	| [\xF1-\xF3][\x80-\xBF]{3}          # planes 4-15
+	|  \xF4[\x80-\x8F][\x80-\xBF]{2}     # plane 16
+}x;
+
+our $typeTypedefs =3D qr{(?x:
+	(?:__)?(?:u|s|be|le)(?:8|16|32|64)|
+	atomic_t
+)};
+
+our $logFunctions =3D qr{(?x:
+	printk|
+	pr_(debug|dbg|vdbg|devel|info|warning|err|notice|alert|crit|emerg|cont)|
+	dev_(printk|dbg|vdbg|info|warn|err|notice|alert|crit|emerg|WARN)|
+	WARN|
+	panic
+)};
+
+our @typeList =3D (
+	qr{void},
+	qr{(?:unsigned\s+)?char},
+	qr{(?:unsigned\s+)?short},
+	qr{(?:unsigned\s+)?int},
+	qr{(?:unsigned\s+)?long},
+	qr{(?:unsigned\s+)?long\s+int},
+	qr{(?:unsigned\s+)?long\s+long},
+	qr{(?:unsigned\s+)?long\s+long\s+int},
+	qr{unsigned},
+	qr{float},
+	qr{double},
+	qr{bool},
+	qr{struct\s+$Ident},
+	qr{union\s+$Ident},
+	qr{enum\s+$Ident},
+	qr{${Ident}_t},
+	qr{${Ident}_handler},
+	qr{${Ident}_handler_fn},
+);
+our @modifierList =3D (
+	qr{fastcall},
+);
+
+sub build_types {
+	my $mods =3D "(?x:  \n" . join("|\n  ", @modifierList) . "\n)";
+	my $all =3D "(?x:  \n" . join("|\n  ", @typeList) . "\n)";
+	$Modifier	=3D qr{(?:$Attribute|$Sparse|$mods)};
+	$NonptrType	=3D qr{
+			(?:$Modifier\s+|const\s+)*
+			(?:
+				(?:typeof|__typeof__)\s*\(\s*\**\s*$Ident\s*\)|
+				(?:$typeTypedefs\b)|
+				(?:${all}\b)
+			)
+			(?:\s+$Modifier|\s+const)*
+		  }x;
+	$Type	=3D qr{
+			$NonptrType
+			(?:[\s\*]+\s*const|[\s\*]+|(?:\s*\[\s*\])+)?
+			(?:\s+$Inline|\s+$Modifier)*
+		  }x;
+	$Declare	=3D qr{(?:$Storage\s+)?$Type};
+}
+build_types();
+
+$chk_signoff =3D 0 if ($file);
+
+my @dep_includes =3D ();
+my @dep_functions =3D ();
+my $removal =3D "Documentation/feature-removal-schedule.txt";
+if ($tree && -f "$root/$removal") {
+	open(my $REMOVE, '<', "$root/$removal") ||
+				die "$P: $removal: open failed - $!\n";
+	while (<$REMOVE>) {
+		if (/^Check:\s+(.*\S)/) {
+			for my $entry (split(/[, ]+/, $1)) {
+				if ($entry =3D~ m(a)include/(.*)@) {
+					push(@dep_includes, $1);
+
+				} elsif ($entry !~ m@/@) {
+					push(@dep_functions, $entry);
+				}
+			}
+		}
+	}
+	close($REMOVE);
+}
+
+my @rawlines =3D ();
+my @lines =3D ();
+my $vname;
+for my $filename (@ARGV) {
+	my $FILE;
+	if ($file) {
+		open($FILE, '-|', "diff -u /dev/null $filename") ||
+			die "$P: $filename: diff failed - $!\n";
+	} elsif ($filename eq '-') {
+		open($FILE, '<&STDIN');
+	} else {
+		open($FILE, '<', "$filename") ||
+			die "$P: $filename: open failed - $!\n";
+	}
+	if ($filename eq '-') {
+		$vname =3D 'Your patch';
+	} else {
+		$vname =3D $filename;
+	}
+	while (<$FILE>) {
+		chomp;
+		push(@rawlines, $_);
+	}
+	close($FILE);
+	if (!process($filename)) {
+		$exit =3D 1;
+	}
+	@rawlines =3D ();
+	@lines =3D ();
+}
+
+exit($exit);
+
+sub top_of_kernel_tree {
+	my ($root) =3D @_;
+
+	my @tree_check =3D (
+		"COPYING", "CREDITS", "Kbuild", "MAINTAINERS", "Makefile",
+		"README", "Documentation", "arch", "include", "drivers",
+		"fs", "init", "ipc", "kernel", "lib", "scripts",
+	);
+
+	foreach my $check (@tree_check) {
+		if (! -e $root . '/' . $check) {
+			return 0;
+		}
+	}
+	return 1;
+}
+
+sub expand_tabs {
+	my ($str) =3D @_;
+
+	my $res =3D '';
+	my $n =3D 0;
+	for my $c (split(//, $str)) {
+		if ($c eq "\t") {
+			$res .=3D ' ';
+			$n++;
+			for (; ($n % 8) !=3D 0; $n++) {
+				$res .=3D ' ';
+			}
+			next;
+		}
+		$res .=3D $c;
+		$n++;
+	}
+
+	return $res;
+}
+sub copy_spacing {
+	(my $res =3D shift) =3D~ tr/\t/ /c;
+	return $res;
+}
+
+sub line_stats {
+	my ($line) =3D @_;
+
+	# Drop the diff line leader and expand tabs
+	$line =3D~ s/^.//;
+	$line =3D expand_tabs($line);
+
+	# Pick the indent from the front of the line.
+	my ($white) =3D ($line =3D~ /^(\s*)/);
+
+	return (length($line), length($white));
+}
+
+my $sanitise_quote =3D '';
+
+sub sanitise_line_reset {
+	my ($in_comment) =3D @_;
+
+	if ($in_comment) {
+		$sanitise_quote =3D '*/';
+	} else {
+		$sanitise_quote =3D '';
+	}
+}
+sub sanitise_line {
+	my ($line) =3D @_;
+
+	my $res =3D '';
+	my $l =3D '';
+
+	my $qlen =3D 0;
+	my $off =3D 0;
+	my $c;
+
+	# Always copy over the diff marker.
+	$res =3D substr($line, 0, 1);
+
+	for ($off =3D 1; $off < length($line); $off++) {
+		$c =3D substr($line, $off, 1);
+
+		# Comments we are wacking completly including the begin
+		# and end, all to $;.
+		if ($sanitise_quote eq '' && substr($line, $off, 2) eq '/*') {
+			$sanitise_quote =3D '*/';
+
+			substr($res, $off, 2, "$;$;");
+			$off++;
+			next;
+		}
+		if ($sanitise_quote eq '*/' && substr($line, $off, 2) eq '*/') {
+			$sanitise_quote =3D '';
+			substr($res, $off, 2, "$;$;");
+			$off++;
+			next;
+		}
+		if ($sanitise_quote eq '' && substr($line, $off, 2) eq '//') {
+			$sanitise_quote =3D '//';
+
+			substr($res, $off, 2, $sanitise_quote);
+			$off++;
+			next;
+		}
+
+		# A \ in a string means ignore the next character.
+		if (($sanitise_quote eq "'" || $sanitise_quote eq '"') &&
+		    $c eq "\\") {
+			substr($res, $off, 2, 'XX');
+			$off++;
+			next;
+		}
+		# Regular quotes.
+		if ($c eq "'" || $c eq '"') {
+			if ($sanitise_quote eq '') {
+				$sanitise_quote =3D $c;
+
+				substr($res, $off, 1, $c);
+				next;
+			} elsif ($sanitise_quote eq $c) {
+				$sanitise_quote =3D '';
+			}
+		}
+
+		#print "c<$c> SQ<$sanitise_quote>\n";
+		if ($off !=3D 0 && $sanitise_quote eq '*/' && $c ne "\t") {
+			substr($res, $off, 1, $;);
+		} elsif ($off !=3D 0 && $sanitise_quote eq '//' && $c ne "\t") {
+			substr($res, $off, 1, $;);
+		} elsif ($off !=3D 0 && $sanitise_quote && $c ne "\t") {
+			substr($res, $off, 1, 'X');
+		} else {
+			substr($res, $off, 1, $c);
+		}
+	}
+
+	if ($sanitise_quote eq '//') {
+		$sanitise_quote =3D '';
+	}
+
+	# The pathname on a #include may be surrounded by '<' and '>'.
+	if ($res =3D~ /^.\s*\#\s*include\s+\<(.*)\>/) {
+		my $clean =3D 'X' x length($1);
+		$res =3D~ s@\<.*\>@<$clean>@;
+
+	# The whole of a #error is a string.
+	} elsif ($res =3D~ /^.\s*\#\s*(?:error|warning)\s+(.*)\b/) {
+		my $clean =3D 'X' x length($1);
+		$res =3D~ s@(\#\s*(?:error|warning)\s+).*@$1$clean@;
+	}
+
+	return $res;
+}
+
+sub ctx_statement_block {
+	my ($linenr, $remain, $off) =3D @_;
+	my $line =3D $linenr - 1;
+	my $blk =3D '';
+	my $soff =3D $off;
+	my $coff =3D $off - 1;
+	my $coff_set =3D 0;
+
+	my $loff =3D 0;
+
+	my $type =3D '';
+	my $level =3D 0;
+	my @stack =3D ();
+	my $p;
+	my $c;
+	my $len =3D 0;
+
+	my $remainder;
+	while (1) {
+		@stack =3D (['', 0]) if ($#stack =3D=3D -1);
+
+		#warn "CSB: blk<$blk> remain<$remain>\n";
+		# If we are about to drop off the end, pull in more
+		# context.
+		if ($off >=3D $len) {
+			for (; $remain > 0; $line++) {
+				last if (!defined $lines[$line]);
+				next if ($lines[$line] =3D~ /^-/);
+				$remain--;
+				$loff =3D $len;
+				$blk .=3D $lines[$line] . "\n";
+				$len =3D length($blk);
+				$line++;
+				last;
+			}
+			# Bail if there is no further context.
+			#warn "CSB: blk<$blk> off<$off> len<$len>\n";
+			if ($off >=3D $len) {
+				last;
+			}
+		}
+		$p =3D $c;
+		$c =3D substr($blk, $off, 1);
+		$remainder =3D substr($blk, $off);
+
+		#warn "CSB: c<$c> type<$type> level<$level> remainder<$remainder> coff_s=
et<$coff_set>\n";
+
+		# Handle nested #if/#else.
+		if ($remainder =3D~ /^#\s*(?:ifndef|ifdef|if)\s/) {
+			push(@stack, [ $type, $level ]);
+		} elsif ($remainder =3D~ /^#\s*(?:else|elif)\b/) {
+			($type, $level) =3D @{$stack[$#stack - 1]};
+		} elsif ($remainder =3D~ /^#\s*endif\b/) {
+			($type, $level) =3D @{pop(@stack)};
+		}
+
+		# Statement ends at the ';' or a close '}' at the
+		# outermost level.
+		if ($level =3D=3D 0 && $c eq ';') {
+			last;
+		}
+
+		# An else is really a conditional as long as its not else if
+		if ($level =3D=3D 0 && $coff_set =3D=3D 0 &&
+				(!defined($p) || $p =3D~ /(?:\s|\}|\+)/) &&
+				$remainder =3D~ /^(else)(?:\s|{)/ &&
+				$remainder !~ /^else\s+if\b/) {
+			$coff =3D $off + length($1) - 1;
+			$coff_set =3D 1;
+			#warn "CSB: mark coff<$coff> soff<$soff> 1<$1>\n";
+			#warn "[" . substr($blk, $soff, $coff - $soff + 1) . "]\n";
+		}
+
+		if (($type eq '' || $type eq '(') && $c eq '(') {
+			$level++;
+			$type =3D '(';
+		}
+		if ($type eq '(' && $c eq ')') {
+			$level--;
+			$type =3D ($level !=3D 0)? '(' : '';
+
+			if ($level =3D=3D 0 && $coff < $soff) {
+				$coff =3D $off;
+				$coff_set =3D 1;
+				#warn "CSB: mark coff<$coff>\n";
+			}
+		}
+		if (($type eq '' || $type eq '{') && $c eq '{') {
+			$level++;
+			$type =3D '{';
+		}
+		if ($type eq '{' && $c eq '}') {
+			$level--;
+			$type =3D ($level !=3D 0)? '{' : '';
+
+			if ($level =3D=3D 0) {
+				last;
+			}
+		}
+		$off++;
+	}
+	# We are truly at the end, so shuffle to the next line.
+	if ($off =3D=3D $len) {
+		$loff =3D $len + 1;
+		$line++;
+		$remain--;
+	}
+
+	my $statement =3D substr($blk, $soff, $off - $soff + 1);
+	my $condition =3D substr($blk, $soff, $coff - $soff + 1);
+
+	#warn "STATEMENT<$statement>\n";
+	#warn "CONDITION<$condition>\n";
+
+	#print "coff<$coff> soff<$off> loff<$loff>\n";
+
+	return ($statement, $condition,
+			$line, $remain + 1, $off - $loff + 1, $level);
+}
+
+sub statement_lines {
+	my ($stmt) =3D @_;
+
+	# Strip the diff line prefixes and rip blank lines at start and end.
+	$stmt =3D~ s/(^|\n)./$1/g;
+	$stmt =3D~ s/^\s*//;
+	$stmt =3D~ s/\s*$//;
+
+	my @stmt_lines =3D ($stmt =3D~ /\n/g);
+
+	return $#stmt_lines + 2;
+}
+
+sub statement_rawlines {
+	my ($stmt) =3D @_;
+
+	my @stmt_lines =3D ($stmt =3D~ /\n/g);
+
+	return $#stmt_lines + 2;
+}
+
+sub statement_block_size {
+	my ($stmt) =3D @_;
+
+	$stmt =3D~ s/(^|\n)./$1/g;
+	$stmt =3D~ s/^\s*{//;
+	$stmt =3D~ s/}\s*$//;
+	$stmt =3D~ s/^\s*//;
+	$stmt =3D~ s/\s*$//;
+
+	my @stmt_lines =3D ($stmt =3D~ /\n/g);
+	my @stmt_statements =3D ($stmt =3D~ /;/g);
+
+	my $stmt_lines =3D $#stmt_lines + 2;
+	my $stmt_statements =3D $#stmt_statements + 1;
+
+	if ($stmt_lines > $stmt_statements) {
+		return $stmt_lines;
+	} else {
+		return $stmt_statements;
+	}
+}
+
+sub ctx_statement_full {
+	my ($linenr, $remain, $off) =3D @_;
+	my ($statement, $condition, $level);
+
+	my (@chunks);
+
+	# Grab the first conditional/block pair.
+	($statement, $condition, $linenr, $remain, $off, $level) =3D
+				ctx_statement_block($linenr, $remain, $off);
+	#print "F: c<$condition> s<$statement> remain<$remain>\n";
+	push(@chunks, [ $condition, $statement ]);
+	if (!($remain > 0 && $condition =3D~ /^\s*(?:\n[+-])?\s*(?:if|else|do)\b/=
s)) {
+		return ($level, $linenr, @chunks);
+	}
+
+	# Pull in the following conditional/block pairs and see if they
+	# could continue the statement.
+	for (;;) {
+		($statement, $condition, $linenr, $remain, $off, $level) =3D
+				ctx_statement_block($linenr, $remain, $off);
+		#print "C: c<$condition> s<$statement> remain<$remain>\n";
+		last if (!($remain > 0 && $condition =3D~ /^(?:\s*\n[+-])*\s*(?:else|do)=
\b/s));
+		#print "C: push\n";
+		push(@chunks, [ $condition, $statement ]);
+	}
+
+	return ($level, $linenr, @chunks);
+}
+
+sub ctx_block_get {
+	my ($linenr, $remain, $outer, $open, $close, $off) =3D @_;
+	my $line;
+	my $start =3D $linenr - 1;
+	my $blk =3D '';
+	my @o;
+	my @c;
+	my @res =3D ();
+
+	my $level =3D 0;
+	my @stack =3D ($level);
+	for ($line =3D $start; $remain > 0; $line++) {
+		next if ($rawlines[$line] =3D~ /^-/);
+		$remain--;
+
+		$blk .=3D $rawlines[$line];
+
+		# Handle nested #if/#else.
+		if ($rawlines[$line] =3D~ /^.\s*#\s*(?:ifndef|ifdef|if)\s/) {
+			push(@stack, $level);
+		} elsif ($rawlines[$line] =3D~ /^.\s*#\s*(?:else|elif)\b/) {
+			$level =3D $stack[$#stack - 1];
+		} elsif ($rawlines[$line] =3D~ /^.\s*#\s*endif\b/) {
+			$level =3D pop(@stack);
+		}
+
+		foreach my $c (split(//, $rawlines[$line])) {
+			##print "C<$c>L<$level><$open$close>O<$off>\n";
+			if ($off > 0) {
+				$off--;
+				next;
+			}
+
+			if ($c eq $close && $level > 0) {
+				$level--;
+				last if ($level =3D=3D 0);
+			} elsif ($c eq $open) {
+				$level++;
+			}
+		}
+
+		if (!$outer || $level <=3D 1) {
+			push(@res, $rawlines[$line]);
+		}
+
+		last if ($level =3D=3D 0);
+	}
+
+	return ($level, @res);
+}
+sub ctx_block_outer {
+	my ($linenr, $remain) =3D @_;
+
+	my ($level, @r) =3D ctx_block_get($linenr, $remain, 1, '{', '}', 0);
+	return @r;
+}
+sub ctx_block {
+	my ($linenr, $remain) =3D @_;
+
+	my ($level, @r) =3D ctx_block_get($linenr, $remain, 0, '{', '}', 0);
+	return @r;
+}
+sub ctx_statement {
+	my ($linenr, $remain, $off) =3D @_;
+
+	my ($level, @r) =3D ctx_block_get($linenr, $remain, 0, '(', ')', $off);
+	return @r;
+}
+sub ctx_block_level {
+	my ($linenr, $remain) =3D @_;
+
+	return ctx_block_get($linenr, $remain, 0, '{', '}', 0);
+}
+sub ctx_statement_level {
+	my ($linenr, $remain, $off) =3D @_;
+
+	return ctx_block_get($linenr, $remain, 0, '(', ')', $off);
+}
+
+sub ctx_locate_comment {
+	my ($first_line, $end_line) =3D @_;
+
+	# Catch a comment on the end of the line itself.
+	my ($current_comment) =3D ($rawlines[$end_line - 1] =3D~ m@.*(/\*.*\*/)=
\s*(?:\\\s*)?$@);
+	return $current_comment if (defined $current_comment);
+
+	# Look through the context and try and figure out if there is a
+	# comment.
+	my $in_comment =3D 0;
+	$current_comment =3D '';
+	for (my $linenr =3D $first_line; $linenr < $end_line; $linenr++) {
+		my $line =3D $rawlines[$linenr - 1];
+		#warn "           $line\n";
+		if ($linenr =3D=3D $first_line and $line =3D~ m@^.\s*\*@) {
+			$in_comment =3D 1;
+		}
+		if ($line =3D~ m@/\*@) {
+			$in_comment =3D 1;
+		}
+		if (!$in_comment && $current_comment ne '') {
+			$current_comment =3D '';
+		}
+		$current_comment .=3D $line . "\n" if ($in_comment);
+		if ($line =3D~ m@\*/@) {
+			$in_comment =3D 0;
+		}
+	}
+
+	chomp($current_comment);
+	return($current_comment);
+}
+sub ctx_has_comment {
+	my ($first_line, $end_line) =3D @_;
+	my $cmt =3D ctx_locate_comment($first_line, $end_line);
+
+	##print "LINE: $rawlines[$end_line - 1 ]\n";
+	##print "CMMT: $cmt\n";
+
+	return ($cmt ne '');
+}
+
+sub raw_line {
+	my ($linenr, $cnt) =3D @_;
+
+	my $offset =3D $linenr - 1;
+	$cnt++;
+
+	my $line;
+	while ($cnt) {
+		$line =3D $rawlines[$offset++];
+		next if (defined($line) && $line =3D~ /^-/);
+		$cnt--;
+	}
+
+	return $line;
+}
+
+sub cat_vet {
+	my ($vet) =3D @_;
+	my ($res, $coded);
+
+	$res =3D '';
+	while ($vet =3D~ /([^[:cntrl:]]*)([[:cntrl:]]|$)/g) {
+		$res .=3D $1;
+		if ($2 ne '') {
+			$coded =3D sprintf("^%c", unpack('C', $2) + 64);
+			$res .=3D $coded;
+		}
+	}
+	$res =3D~ s/$/\$/;
+
+	return $res;
+}
+
+my $av_preprocessor =3D 0;
+my $av_pending;
+my @av_paren_type;
+my $av_pend_colon;
+
+sub annotate_reset {
+	$av_preprocessor =3D 0;
+	$av_pending =3D '_';
+	@av_paren_type =3D ('E');
+	$av_pend_colon =3D 'O';
+}
+
+sub annotate_values {
+	my ($stream, $type) =3D @_;
+
+	my $res;
+	my $var =3D '_' x length($stream);
+	my $cur =3D $stream;
+
+	print "$stream\n" if ($dbg_values > 1);
+
+	while (length($cur)) {
+		@av_paren_type =3D ('E') if ($#av_paren_type < 0);
+		print " <" . join('', @av_paren_type) .
+				"> <$type> <$av_pending>" if ($dbg_values > 1);
+		if ($cur =3D~ /^(\s+)/o) {
+			print "WS($1)\n" if ($dbg_values > 1);
+			if ($1 =3D~ /\n/ && $av_preprocessor) {
+				$type =3D pop(@av_paren_type);
+				$av_preprocessor =3D 0;
+			}
+
+		} elsif ($cur =3D~ /^($Type)\s*(?:$Ident|,|\)|\()/) {
+			print "DECLARE($1)\n" if ($dbg_values > 1);
+			$type =3D 'T';
+
+		} elsif ($cur =3D~ /^($Modifier)\s*/) {
+			print "MODIFIER($1)\n" if ($dbg_values > 1);
+			$type =3D 'T';
+
+		} elsif ($cur =3D~ /^(\#\s*define\s*$Ident)(\(?)/o) {
+			print "DEFINE($1,$2)\n" if ($dbg_values > 1);
+			$av_preprocessor =3D 1;
+			push(@av_paren_type, $type);
+			if ($2 ne '') {
+				$av_pending =3D 'N';
+			}
+			$type =3D 'E';
+
+		} elsif ($cur =3D~ /^(\#\s*(?:undef\s*$Ident|include\b))/o) {
+			print "UNDEF($1)\n" if ($dbg_values > 1);
+			$av_preprocessor =3D 1;
+			push(@av_paren_type, $type);
+
+		} elsif ($cur =3D~ /^(\#\s*(?:ifdef|ifndef|if))/o) {
+			print "PRE_START($1)\n" if ($dbg_values > 1);
+			$av_preprocessor =3D 1;
+
+			push(@av_paren_type, $type);
+			push(@av_paren_type, $type);
+			$type =3D 'E';
+
+		} elsif ($cur =3D~ /^(\#\s*(?:else|elif))/o) {
+			print "PRE_RESTART($1)\n" if ($dbg_values > 1);
+			$av_preprocessor =3D 1;
+
+			push(@av_paren_type, $av_paren_type[$#av_paren_type]);
+
+			$type =3D 'E';
+
+		} elsif ($cur =3D~ /^(\#\s*(?:endif))/o) {
+			print "PRE_END($1)\n" if ($dbg_values > 1);
+
+			$av_preprocessor =3D 1;
+
+			# Assume all arms of the conditional end as this
+			# one does, and continue as if the #endif was not here.
+			pop(@av_paren_type);
+			push(@av_paren_type, $type);
+			$type =3D 'E';
+
+		} elsif ($cur =3D~ /^(\\\n)/o) {
+			print "PRECONT($1)\n" if ($dbg_values > 1);
+
+		} elsif ($cur =3D~ /^(__attribute__)\s*\(?/o) {
+			print "ATTR($1)\n" if ($dbg_values > 1);
+			$av_pending =3D $type;
+			$type =3D 'N';
+
+		} elsif ($cur =3D~ /^(sizeof)\s*(\()?/o) {
+			print "SIZEOF($1)\n" if ($dbg_values > 1);
+			if (defined $2) {
+				$av_pending =3D 'V';
+			}
+			$type =3D 'N';
+
+		} elsif ($cur =3D~ /^(if|while|for)\b/o) {
+			print "COND($1)\n" if ($dbg_values > 1);
+			$av_pending =3D 'E';
+			$type =3D 'N';
+
+		} elsif ($cur =3D~/^(case)/o) {
+			print "CASE($1)\n" if ($dbg_values > 1);
+			$av_pend_colon =3D 'C';
+			$type =3D 'N';
+
+		} elsif ($cur =3D~/^(return|else|goto|typeof|__typeof__)\b/o) {
+			print "KEYWORD($1)\n" if ($dbg_values > 1);
+			$type =3D 'N';
+
+		} elsif ($cur =3D~ /^(\()/o) {
+			print "PAREN('$1')\n" if ($dbg_values > 1);
+			push(@av_paren_type, $av_pending);
+			$av_pending =3D '_';
+			$type =3D 'N';
+
+		} elsif ($cur =3D~ /^(\))/o) {
+			my $new_type =3D pop(@av_paren_type);
+			if ($new_type ne '_') {
+				$type =3D $new_type;
+				print "PAREN('$1') -> $type\n"
+							if ($dbg_values > 1);
+			} else {
+				print "PAREN('$1')\n" if ($dbg_values > 1);
+			}
+
+		} elsif ($cur =3D~ /^($Ident)\s*\(/o) {
+			print "FUNC($1)\n" if ($dbg_values > 1);
+			$type =3D 'V';
+			$av_pending =3D 'V';
+
+		} elsif ($cur =3D~ /^($Ident\s*):(?:\s*\d+\s*(,|=3D|;))?/) {
+			if (defined $2 && $type eq 'C' || $type eq 'T') {
+				$av_pend_colon =3D 'B';
+			} elsif ($type eq 'E') {
+				$av_pend_colon =3D 'L';
+			}
+			print "IDENT_COLON($1,$type>$av_pend_colon)\n" if ($dbg_values > 1);
+			$type =3D 'V';
+
+		} elsif ($cur =3D~ /^($Ident|$Constant)/o) {
+			print "IDENT($1)\n" if ($dbg_values > 1);
+			$type =3D 'V';
+
+		} elsif ($cur =3D~ /^($Assignment)/o) {
+			print "ASSIGN($1)\n" if ($dbg_values > 1);
+			$type =3D 'N';
+
+		} elsif ($cur =3D~/^(;|{|})/) {
+			print "END($1)\n" if ($dbg_values > 1);
+			$type =3D 'E';
+			$av_pend_colon =3D 'O';
+
+		} elsif ($cur =3D~/^(,)/) {
+			print "COMMA($1)\n" if ($dbg_values > 1);
+			$type =3D 'C';
+
+		} elsif ($cur =3D~ /^(\?)/o) {
+			print "QUESTION($1)\n" if ($dbg_values > 1);
+			$type =3D 'N';
+
+		} elsif ($cur =3D~ /^(:)/o) {
+			print "COLON($1,$av_pend_colon)\n" if ($dbg_values > 1);
+
+			substr($var, length($res), 1, $av_pend_colon);
+			if ($av_pend_colon eq 'C' || $av_pend_colon eq 'L') {
+				$type =3D 'E';
+			} else {
+				$type =3D 'N';
+			}
+			$av_pend_colon =3D 'O';
+
+		} elsif ($cur =3D~ /^(\[)/o) {
+			print "CLOSE($1)\n" if ($dbg_values > 1);
+			$type =3D 'N';
+
+		} elsif ($cur =3D~ /^(-(?![->])|\+(?!\+)|\*|\&\&|\&)/o) {
+			my $variant;
+
+			print "OPV($1)\n" if ($dbg_values > 1);
+			if ($type eq 'V') {
+				$variant =3D 'B';
+			} else {
+				$variant =3D 'U';
+			}
+
+			substr($var, length($res), 1, $variant);
+			$type =3D 'N';
+
+		} elsif ($cur =3D~ /^($Operators)/o) {
+			print "OP($1)\n" if ($dbg_values > 1);
+			if ($1 ne '++' && $1 ne '--') {
+				$type =3D 'N';
+			}
+
+		} elsif ($cur =3D~ /(^.)/o) {
+			print "C($1)\n" if ($dbg_values > 1);
+		}
+		if (defined $1) {
+			$cur =3D substr($cur, length($1));
+			$res .=3D $type x length($1);
+		}
+	}
+
+	return ($res, $var);
+}
+
+sub possible {
+	my ($possible, $line) =3D @_;
+	my $notPermitted =3D qr{(?:
+		^(?:
+			$Modifier|
+			$Storage|
+			$Type|
+			DEFINE_\S+
+		)$|
+		^(?:
+			goto|
+			return|
+			case|
+			else|
+			asm|__asm__|
+			do
+		)(?:\s|$)|
+		^(?:typedef|struct|enum)\b
+	    )}x;
+	warn "CHECK<$possible> ($line)\n" if ($dbg_possible > 2);
+	if ($possible !~ $notPermitted) {
+		# Check for modifiers.
+		$possible =3D~ s/\s*$Storage\s*//g;
+		$possible =3D~ s/\s*$Sparse\s*//g;
+		if ($possible =3D~ /^\s*$/) {
+
+		} elsif ($possible =3D~ /\s/) {
+			$possible =3D~ s/\s*$Type\s*//g;
+			for my $modifier (split(' ', $possible)) {
+				if ($modifier !~ $notPermitted) {
+					warn "MODIFIER: $modifier ($possible) ($line)\n" if ($dbg_possible);
+					push(@modifierList, $modifier);
+				}
+			}
+
+		} else {
+			warn "POSSIBLE: $possible ($line)\n" if ($dbg_possible);
+			push(@typeList, $possible);
+		}
+		build_types();
+	} else {
+		warn "NOTPOSS: $possible ($line)\n" if ($dbg_possible > 1);
+	}
+}
+
+my $prefix =3D '';
+
+sub report {
+	if (defined $tst_only && $_[0] !~ /\Q$tst_only\E/) {
+		return 0;
+	}
+	my $line =3D $prefix . $_[0];
+
+	$line =3D (split('\n', $line))[0] . "\n" if ($terse);
+
+	push(our @report, $line);
+
+	return 1;
+}
+sub report_dump {
+	our @report;
+}
+sub ERROR {
+	if (report("ERROR: $_[0]\n")) {
+		our $clean =3D 0;
+		our $cnt_error++;
+	}
+}
+sub WARN {
+	if (report("WARNING: $_[0]\n")) {
+		our $clean =3D 0;
+		our $cnt_warn++;
+	}
+}
+sub CHK {
+	if ($check && report("CHECK: $_[0]\n")) {
+		our $clean =3D 0;
+		our $cnt_chk++;
+	}
+}
+
+sub check_absolute_file {
+	my ($absolute, $herecurr) =3D @_;
+	my $file =3D $absolute;
+
+	##print "absolute<$absolute>\n";
+
+	# See if any suffix of this path is a path within the tree.
+	while ($file =3D~ s@^[^/]*/@@) {
+		if (-f "$root/$file") {
+			##print "file<$file>\n";
+			last;
+		}
+	}
+	if (! -f _)  {
+		return 0;
+	}
+
+	# It is, so see if the prefix is acceptable.
+	my $prefix =3D $absolute;
+	substr($prefix, -length($file)) =3D '';
+
+	##print "prefix<$prefix>\n";
+	if ($prefix ne ".../") {
+		WARN("use relative pathname instead of absolute in changelog text\n" . $=
herecurr);
+	}
+}
+
+sub process {
+	my $filename =3D shift;
+
+	my $linenr=3D0;
+	my $prevline=3D"";
+	my $prevrawline=3D"";
+	my $stashline=3D"";
+	my $stashrawline=3D"";
+
+	my $length;
+	my $indent;
+	my $previndent=3D0;
+	my $stashindent=3D0;
+
+	our $clean =3D 1;
+	my $signoff =3D 0;
+	my $is_patch =3D 0;
+
+	our @report =3D ();
+	our $cnt_lines =3D 0;
+	our $cnt_error =3D 0;
+	our $cnt_warn =3D 0;
+	our $cnt_chk =3D 0;
+
+	# Trace the real file/line as we go.
+	my $realfile =3D '';
+	my $realline =3D 0;
+	my $realcnt =3D 0;
+	my $here =3D '';
+	my $in_comment =3D 0;
+	my $comment_edge =3D 0;
+	my $first_line =3D 0;
+	my $p1_prefix =3D '';
+
+	my $prev_values =3D 'E';
+
+	# suppression flags
+	my %suppress_ifbraces;
+	my %suppress_whiletrailers;
+	my %suppress_export;
+
+	# Pre-scan the patch sanitizing the lines.
+	# Pre-scan the patch looking for any __setup documentation.
+	#
+	my @setup_docs =3D ();
+	my $setup_docs =3D 0;
+
+	sanitise_line_reset();
+	my $line;
+	foreach my $rawline (@rawlines) {
+		$linenr++;
+		$line =3D $rawline;
+
+		if ($rawline=3D~/^\+\+\+\s+(\S+)/) {
+			$setup_docs =3D 0;
+			if ($1 =3D~ m(a)Documentation/kernel-parameters.txt$@) {
+				$setup_docs =3D 1;
+			}
+			#next;
+		}
+		if ($rawline=3D~/^\@\@ -\d+(?:,\d+)? \+(\d+)(,(\d+))? \@\@/) {
+			$realline=3D$1-1;
+			if (defined $2) {
+				$realcnt=3D$3+1;
+			} else {
+				$realcnt=3D1+1;
+			}
+			$in_comment =3D 0;
+
+			# Guestimate if this is a continuing comment.  Run
+			# the context looking for a comment "edge".  If this
+			# edge is a close comment then we must be in a comment
+			# at context start.
+			my $edge;
+			my $cnt =3D $realcnt;
+			for (my $ln =3D $linenr + 1; $cnt > 0; $ln++) {
+				next if (defined $rawlines[$ln - 1] &&
+					 $rawlines[$ln - 1] =3D~ /^-/);
+				$cnt--;
+				#print "RAW<$rawlines[$ln - 1]>\n";
+				last if (!defined $rawlines[$ln - 1]);
+				if ($rawlines[$ln - 1] =3D~ m@(/\*|\*/)@ &&
+				    $rawlines[$ln - 1] !~ m@"[^"]*(?:/\*|\*/)[^"]*"@) {
+					($edge) =3D $1;
+					last;
+				}
+			}
+			if (defined $edge && $edge eq '*/') {
+				$in_comment =3D 1;
+			}
+
+			# Guestimate if this is a continuing comment.  If this
+			# is the start of a diff block and this line starts
+			# ' *' then it is very likely a comment.
+			if (!defined $edge &&
+			    $rawlines[$linenr] =3D~ m@^.\s*(?:\*\*+| \*)(?:\s|$)@)
+			{
+				$in_comment =3D 1;
+			}
+
+			##print "COMMENT:$in_comment edge<$edge> $rawline\n";
+			sanitise_line_reset($in_comment);
+
+		} elsif ($realcnt && $rawline =3D~ /^(?:\+| |$)/) {
+			# Standardise the strings and chars within the input to
+			# simplify matching -- only bother with positive lines.
+			$line =3D sanitise_line($rawline);
+		}
+		push(@lines, $line);
+
+		if ($realcnt > 1) {
+			$realcnt-- if ($line =3D~ /^(?:\+| |$)/);
+		} else {
+			$realcnt =3D 0;
+		}
+
+		#print "=3D=3D>$rawline\n";
+		#print "-->$line\n";
+
+		if ($setup_docs && $line =3D~ /^\+/) {
+			push(@setup_docs, $line);
+		}
+	}
+
+	$prefix =3D '';
+
+	$realcnt =3D 0;
+	$linenr =3D 0;
+	foreach my $line (@lines) {
+		$linenr++;
+
+		my $rawline =3D $rawlines[$linenr - 1];
+
+#extract the line range in the file after the patch is applied
+		if ($line=3D~/^\@\@ -\d+(?:,\d+)? \+(\d+)(,(\d+))? \@\@/) {
+			$is_patch =3D 1;
+			$first_line =3D $linenr + 1;
+			$realline=3D$1-1;
+			if (defined $2) {
+				$realcnt=3D$3+1;
+			} else {
+				$realcnt=3D1+1;
+			}
+			annotate_reset();
+			$prev_values =3D 'E';
+
+			%suppress_ifbraces =3D ();
+			%suppress_whiletrailers =3D ();
+			%suppress_export =3D ();
+			next;
+
+# track the line number as we move through the hunk, note that
+# new versions of GNU diff omit the leading space on completely
+# blank context lines so we need to count that too.
+		} elsif ($line =3D~ /^( |\+|$)/) {
+			$realline++;
+			$realcnt-- if ($realcnt !=3D 0);
+
+			# Measure the line length and indent.
+			($length, $indent) =3D line_stats($rawline);
+
+			# Track the previous line.
+			($prevline, $stashline) =3D ($stashline, $line);
+			($previndent, $stashindent) =3D ($stashindent, $indent);
+			($prevrawline, $stashrawline) =3D ($stashrawline, $rawline);
+
+			#warn "line<$line>\n";
+
+		} elsif ($realcnt =3D=3D 1) {
+			$realcnt--;
+		}
+
+		my $hunk_line =3D ($realcnt !=3D 0);
+
+#make up the handle for any error we report on this line
+		$prefix =3D "$filename:$realline: " if ($emacs && $file);
+		$prefix =3D "$filename:$linenr: " if ($emacs && !$file);
+
+		$here =3D "#$linenr: " if (!$file);
+		$here =3D "#$realline: " if ($file);
+
+		# extract the filename as it passes
+		if ($line=3D~/^\+\+\+\s+(\S+)/) {
+			$realfile =3D $1;
+			$realfile =3D~ s@^([^/]*)/@@;
+
+			$p1_prefix =3D $1;
+			if (!$file && $tree && $p1_prefix ne '' &&
+			    -e "$root/$p1_prefix") {
+				WARN("patch prefix '$p1_prefix' exists, appears to be a -p0 patch\n");
+			}
+
+			if ($realfile =3D~ m@^include/asm/@) {
+				ERROR("do not modify files in include/asm, change architecture specifi=
c files in include/asm-<architecture>\n" . "$here$rawline\n");
+			}
+			next;
+		}
+
+		$here .=3D "FILE: $realfile:$realline:" if ($realcnt !=3D 0);
+
+		my $hereline =3D "$here\n$rawline\n";
+		my $herecurr =3D "$here\n$rawline\n";
+		my $hereprev =3D "$here\n$prevrawline\n$rawline\n";
+
+		$cnt_lines++ if ($realcnt !=3D 0);
+
+#check the patch for a signoff:
+		if ($line =3D~ /^\s*signed-off-by:/i) {
+			# This is a signoff, if ugly, so do not double report.
+			$signoff++;
+			if (!($line =3D~ /^\s*Signed-off-by:/)) {
+				WARN("Signed-off-by: is the preferred form\n" .
+					$herecurr);
+			}
+			if ($line =3D~ /^\s*signed-off-by:\S/i) {
+				WARN("space required after Signed-off-by:\n" .
+					$herecurr);
+			}
+		}
+
+# Check for wrappage within a valid hunk of the file
+		if ($realcnt !=3D 0 && $line !~ m{^(?:\+|-| |\\ No newline|$)}) {
+			ERROR("patch seems to be corrupt (line wrapped?)\n" .
+				$herecurr) if (!$emitted_corrupt++);
+		}
+
+# Check for absolute kernel paths.
+		if ($tree) {
+			while ($line =3D~ m{(?:^|\s)(/\S*)}g) {
+				my $file =3D $1;
+
+				if ($file =3D~ m{^(.*?)(?::\d+)+:?$} &&
+				    check_absolute_file($1, $herecurr)) {
+					#
+				} else {
+					check_absolute_file($file, $herecurr);
+				}
+			}
+		}
+
+# UTF-8 regex found at http://www.w3.org/International/questions/qa-forms-=
utf-8.en.php
+		if (($realfile =3D~ /^$/ || $line =3D~ /^\+/) &&
+		    $rawline !~ m/^$UTF8*$/) {
+			my ($utf8_prefix) =3D ($rawline =3D~ /^($UTF8*)/);
+
+			my $blank =3D copy_spacing($rawline);
+			my $ptr =3D substr($blank, 0, length($utf8_prefix)) . "^";
+			my $hereptr =3D "$hereline$ptr\n";
+
+			ERROR("Invalid UTF-8, patch and commit message should be encoded in UTF=
-8\n" . $hereptr);
+		}
+
+# ignore non-hunk lines and lines being removed
+		next if (!$hunk_line || $line =3D~ /^-/);
+
+#trailing whitespace
+		if ($line =3D~ /^\+.*\015/) {
+			my $herevet =3D "$here\n" . cat_vet($rawline) . "\n";
+			ERROR("DOS line endings\n" . $herevet);
+
+		} elsif ($rawline =3D~ /^\+.*\S\s+$/ || $rawline =3D~ /^\+\s+$/) {
+			my $herevet =3D "$here\n" . cat_vet($rawline) . "\n";
+			ERROR("trailing whitespace\n" . $herevet);
+		}
+
+# check we are in a valid source file if not then ignore this hunk
+		next if ($realfile !~ /\.(h|c|s|S|pl|sh)$/);
+
+#80 column limit
+		if ($line =3D~ /^\+/ && $prevrawline !~ /\/\*\*/ &&
+		    $rawline !~ /^.\s*\*\s*\@$Ident\s/ &&
+		    $line !~ /^\+\s*$logFunctions\s*\(\s*(?:KERN_\S+\s*)?"[X\t]*"\s*(?:,=
|\)\s*;)\s*$/ &&
+		    $length > 80)
+		{
+			WARN("line over 80 characters\n" . $herecurr);
+		}
+
+# check for spaces before a quoted newline
+		if ($rawline =3D~ /^.*\".*\s\\n/) {
+			WARN("unnecessary whitespace before a quoted newline\n" . $herecurr);
+		}
+
+# check for adding lines without a newline.
+		if ($line =3D~ /^\+/ && defined $lines[$linenr] && $lines[$linenr] =3D~ =
/^\\ No newline at end of file/) {
+			WARN("adding a line without newline at end of file\n" . $herecurr);
+		}
+
+# Blackfin: use hi/lo macros
+		if ($realfile =3D~ m(a)arch/blackfin/.*\.S$@) {
+			if ($line =3D~ /\.[lL][[:space:]]*=3D.*&[[:space:]]*0x[fF][fF][fF][fF]/=
) {
+				my $herevet =3D "$here\n" . cat_vet($line) . "\n";
+				ERROR("use the LO() macro, not (... & 0xFFFF)\n" . $herevet);
+			}
+			if ($line =3D~ /\.[hH][[:space:]]*=3D.*>>[[:space:]]*16/) {
+				my $herevet =3D "$here\n" . cat_vet($line) . "\n";
+				ERROR("use the HI() macro, not (... >> 16)\n" . $herevet);
+			}
+		}
+
+# check we are in a valid source file C or perl if not then ignore this hu=
nk
+		next if ($realfile !~ /\.(h|c|pl)$/);
+
+# at the beginning of a line any tabs must come first and anything
+# more than 8 must use tabs.
+		if ($rawline =3D~ /^\+\s* \t\s*\S/ ||
+		    $rawline =3D~ /^\+\s*        \s*/) {
+			my $herevet =3D "$here\n" . cat_vet($rawline) . "\n";
+			ERROR("code indent should use tabs where possible\n" . $herevet);
+		}
+
+# check for space before tabs.
+		if ($rawline =3D~ /^\+/ && $rawline =3D~ / \t/) {
+			my $herevet =3D "$here\n" . cat_vet($rawline) . "\n";
+			WARN("please, no space before tabs\n" . $herevet);
+		}
+
+# check we are in a valid C source file if not then ignore this hunk
+		next if ($realfile !~ /\.(h|c)$/);
+
+# check for RCS/CVS revision markers
+		if ($rawline =3D~ /^\+.*\$(Revision|Log|Id)(?:\$|)/) {
+			WARN("CVS style keyword markers, these will _not_ be updated\n". $herec=
urr);
+		}
+
+# Blackfin: don't use __builtin_bfin_[cs]sync
+		if ($line =3D~ /__builtin_bfin_csync/) {
+			my $herevet =3D "$here\n" . cat_vet($line) . "\n";
+			ERROR("use the CSYNC() macro in asm/blackfin.h\n" . $herevet);
+		}
+		if ($line =3D~ /__builtin_bfin_ssync/) {
+			my $herevet =3D "$here\n" . cat_vet($line) . "\n";
+			ERROR("use the SSYNC() macro in asm/blackfin.h\n" . $herevet);
+		}
+
+# Check for potential 'bare' types
+		my ($stat, $cond, $line_nr_next, $remain_next, $off_next,
+		    $realline_next);
+		if ($realcnt && $line =3D~ /.\s*\S/) {
+			($stat, $cond, $line_nr_next, $remain_next, $off_next) =3D
+				ctx_statement_block($linenr, $realcnt, 0);
+			$stat =3D~ s/\n./\n /g;
+			$cond =3D~ s/\n./\n /g;
+
+			# Find the real next line.
+			$realline_next =3D $line_nr_next;
+			if (defined $realline_next &&
+			    (!defined $lines[$realline_next - 1] ||
+			     substr($lines[$realline_next - 1], $off_next) =3D~ /^\s*$/)) {
+				$realline_next++;
+			}
+
+			my $s =3D $stat;
+			$s =3D~ s/{.*$//s;
+
+			# Ignore goto labels.
+			if ($s =3D~ /$Ident:\*$/s) {
+
+			# Ignore functions being called
+			} elsif ($s =3D~ /^.\s*$Ident\s*\(/s) {
+
+			} elsif ($s =3D~ /^.\s*else\b/s) {
+
+			# declarations always start with types
+			} elsif ($prev_values eq 'E' && $s =3D~ /^.\s*(?:$Storage\s+)?(?:$Inlin=
e\s+)?(?:const\s+)?((?:\s*$Ident)+?)\b(?:\s+$Sparse)?\s*\**\s*(?:$Ident|\(\=
*[^\)]*\))(?:\s*$Modifier)?\s*(?:;|=3D|,|\()/s) {
+				my $type =3D $1;
+				$type =3D~ s/\s+/ /g;
+				possible($type, "A:" . $s);
+
+			# definitions in global scope can only start with types
+			} elsif ($s =3D~ /^.(?:$Storage\s+)?(?:$Inline\s+)?(?:const\s+)?($Ident=
)\b\s*(?!:)/s) {
+				possible($1, "B:" . $s);
+			}
+
+			# any (foo ... *) is a pointer cast, and foo is a type
+			while ($s =3D~ /\(($Ident)(?:\s+$Sparse)*[\s\*]+\s*\)/sg) {
+				possible($1, "C:" . $s);
+			}
+
+			# Check for any sort of function declaration.
+			# int foo(something bar, other baz);
+			# void (*store_gdt)(x86_descr_ptr *);
+			if ($prev_values eq 'E' && $s =3D~ /^(.(?:typedef\s*)?(?:(?:$Storage|$I=
nline)\s*)*\s*$Type\s*(?:\b$Ident|\(\*\s*$Ident\))\s*)\(/s) {
+				my ($name_len) =3D length($1);
+
+				my $ctx =3D $s;
+				substr($ctx, 0, $name_len + 1, '');
+				$ctx =3D~ s/\)[^\)]*$//;
+
+				for my $arg (split(/\s*,\s*/, $ctx)) {
+					if ($arg =3D~ /^(?:const\s+)?($Ident)(?:\s+$Sparse)*\s*\**\s*(:?\b$Id=
ent)?$/s || $arg =3D~ /^($Ident)$/s) {
+
+						possible($1, "D:" . $s);
+					}
+				}
+			}
+
+		}
+
+#
+# Checks which may be anchored in the context.
+#
+
+# Check for switch () and associated case and default
+# statements should be at the same indent.
+		if ($line=3D~/\bswitch\s*\(.*\)/) {
+			my $err =3D '';
+			my $sep =3D '';
+			my @ctx =3D ctx_block_outer($linenr, $realcnt);
+			shift(@ctx);
+			for my $ctx (@ctx) {
+				my ($clen, $cindent) =3D line_stats($ctx);
+				if ($ctx =3D~ /^\+\s*(case\s+|default:)/ &&
+							$indent !=3D $cindent) {
+					$err .=3D "$sep$ctx\n";
+					$sep =3D '';
+				} else {
+					$sep =3D "[...]\n";
+				}
+			}
+			if ($err ne '') {
+				ERROR("switch and case should be at the same indent\n$hereline$err");
+			}
+		}
+
+# if/while/etc brace do not go on next line, unless defining a do while lo=
op,
+# or if that brace on the next line is for something else
+		if ($line =3D~ /(.*)\b((?:if|while|for|switch)\s*\(|do\b|else\b)/ && $li=
ne !~ /^.\s*\#/) {
+			my $pre_ctx =3D "$1$2";
+
+			my ($level, @ctx) =3D ctx_statement_level($linenr, $realcnt, 0);
+			my $ctx_cnt =3D $realcnt - $#ctx - 1;
+			my $ctx =3D join("\n", @ctx);
+
+			my $ctx_ln =3D $linenr;
+			my $ctx_skip =3D $realcnt;
+
+			while ($ctx_skip > $ctx_cnt || ($ctx_skip =3D=3D $ctx_cnt &&
+					defined $lines[$ctx_ln - 1] &&
+					$lines[$ctx_ln - 1] =3D~ /^-/)) {
+				##print "SKIP<$ctx_skip> CNT<$ctx_cnt>\n";
+				$ctx_skip-- if (!defined $lines[$ctx_ln - 1] || $lines[$ctx_ln - 1] !~=
 /^-/);
+				$ctx_ln++;
+			}
+
+			#print "realcnt<$realcnt> ctx_cnt<$ctx_cnt>\n";
+			#print "pre<$pre_ctx>\nline<$line>\nctx<$ctx>\nnext<$lines[$ctx_ln - 1]=
>\n";
+
+			if ($ctx !~ /{\s*/ && defined($lines[$ctx_ln -1]) && $lines[$ctx_ln - 1=
] =3D~ /^\+\s*{/) {
+				ERROR("that open brace { should be on the previous line\n" .
+					"$here\n$ctx\n$lines[$ctx_ln - 1]\n");
+			}
+			if ($level =3D=3D 0 && $pre_ctx !~ /}\s*while\s*\($/ &&
+			    $ctx =3D~ /\)\s*\;\s*$/ &&
+			    defined $lines[$ctx_ln - 1])
+			{
+				my ($nlength, $nindent) =3D line_stats($lines[$ctx_ln - 1]);
+				if ($nindent > $indent) {
+					WARN("trailing semicolon indicates no statements, indent implies othe=
rwise\n" .
+						"$here\n$ctx\n$lines[$ctx_ln - 1]\n");
+				}
+			}
+		}
+
+# Check relative indent for conditionals and blocks.
+		if ($line =3D~ /\b(?:(?:if|while|for)\s*\(|do\b)/ && $line !~ /^.\s*#/ &=
& $line !~ /\}\s*while\s*/) {
+			my ($s, $c) =3D ($stat, $cond);
+
+			substr($s, 0, length($c), '');
+
+			# Make sure we remove the line prefixes as we have
+			# none on the first line, and are going to readd them
+			# where necessary.
+			$s =3D~ s/\n./\n/gs;
+
+			# Find out how long the conditional actually is.
+			my @newlines =3D ($c =3D~ /\n/gs);
+			my $cond_lines =3D 1 + $#newlines;
+
+			# We want to check the first line inside the block
+			# starting at the end of the conditional, so remove:
+			#  1) any blank line termination
+			#  2) any opening brace { on end of the line
+			#  3) any do (...) {
+			my $continuation =3D 0;
+			my $check =3D 0;
+			$s =3D~ s/^.*\bdo\b//;
+			$s =3D~ s/^\s*{//;
+			if ($s =3D~ s/^\s*\\//) {
+				$continuation =3D 1;
+			}
+			if ($s =3D~ s/^\s*?\n//) {
+				$check =3D 1;
+				$cond_lines++;
+			}
+
+			# Also ignore a loop construct at the end of a
+			# preprocessor statement.
+			if (($prevline =3D~ /^.\s*#\s*define\s/ ||
+			    $prevline =3D~ /\\\s*$/) && $continuation =3D=3D 0) {
+				$check =3D 0;
+			}
+
+			my $cond_ptr =3D -1;
+			$continuation =3D 0;
+			while ($cond_ptr !=3D $cond_lines) {
+				$cond_ptr =3D $cond_lines;
+
+				# If we see an #else/#elif then the code
+				# is not linear.
+				if ($s =3D~ /^\s*\#\s*(?:else|elif)/) {
+					$check =3D 0;
+				}
+
+				# Ignore:
+				#  1) blank lines, they should be at 0,
+				#  2) preprocessor lines, and
+				#  3) labels.
+				if ($continuation ||
+				    $s =3D~ /^\s*?\n/ ||
+				    $s =3D~ /^\s*#\s*?/ ||
+				    $s =3D~ /^\s*$Ident\s*:/) {
+					$continuation =3D ($s =3D~ /^.*?\\\n/) ? 1 : 0;
+					if ($s =3D~ s/^.*?\n//) {
+						$cond_lines++;
+					}
+				}
+			}
+
+			my (undef, $sindent) =3D line_stats("+" . $s);
+			my $stat_real =3D raw_line($linenr, $cond_lines);
+
+			# Check if either of these lines are modified, else
+			# this is not this patch's fault.
+			if (!defined($stat_real) ||
+			    $stat !~ /^\+/ && $stat_real !~ /^\+/) {
+				$check =3D 0;
+			}
+			if (defined($stat_real) && $cond_lines > 1) {
+				$stat_real =3D "[...]\n$stat_real";
+			}
+
+			#print "line<$line> prevline<$prevline> indent<$indent> sindent<$sinden=
t> check<$check> continuation<$continuation> s<$s> cond_lines<$cond_lines> =
stat_real<$stat_real> stat<$stat>\n";
+
+			if ($check && (($sindent % 8) !=3D 0 ||
+			    ($sindent <=3D $indent && $s ne ''))) {
+				WARN("suspect code indent for conditional statements ($indent, $sinden=
t)\n" . $herecurr . "$stat_real\n");
+			}
+		}
+
+		# Track the 'values' across context and added lines.
+		my $opline =3D $line; $opline =3D~ s/^./ /;
+		my ($curr_values, $curr_vars) =3D
+				annotate_values($opline . "\n", $prev_values);
+		$curr_values =3D $prev_values . $curr_values;
+		if ($dbg_values) {
+			my $outline =3D $opline; $outline =3D~ s/\t/ /g;
+			print "$linenr > .$outline\n";
+			print "$linenr > $curr_values\n";
+			print "$linenr >  $curr_vars\n";
+		}
+		$prev_values =3D substr($curr_values, -1);
+
+#ignore lines not being added
+		if ($line=3D~/^[^\+]/) {next;}
+
+# TEST: allow direct testing of the type matcher.
+		if ($dbg_type) {
+			if ($line =3D~ /^.\s*$Declare\s*$/) {
+				ERROR("TEST: is type\n" . $herecurr);
+			} elsif ($dbg_type > 1 && $line =3D~ /^.+($Declare)/) {
+				ERROR("TEST: is not type ($1 is)\n". $herecurr);
+			}
+			next;
+		}
+# TEST: allow direct testing of the attribute matcher.
+		if ($dbg_attr) {
+			if ($line =3D~ /^.\s*$Modifier\s*$/) {
+				ERROR("TEST: is attr\n" . $herecurr);
+			} elsif ($dbg_attr > 1 && $line =3D~ /^.+($Modifier)/) {
+				ERROR("TEST: is not attr ($1 is)\n". $herecurr);
+			}
+			next;
+		}
+
+# check for initialisation to aggregates open brace on the next line
+		if ($line =3D~ /^.\s*{/ &&
+		    $prevline =3D~ /(?:^|[^=3D])=3D\s*$/) {
+			ERROR("that open brace { should be on the previous line\n" . $hereprev);
+		}
+
+#
+# Checks which are anchored on the added line.
+#
+
+# check for malformed paths in #include statements (uses RAW line)
+		if ($rawline =3D~ m{^.\s*\#\s*include\s+[<"](.*)[">]}) {
+			my $path =3D $1;
+			if ($path =3D~ m{//}) {
+				ERROR("malformed #include filename\n" .
+					$herecurr);
+			}
+		}
+
+# no C99 // comments
+		if ($line =3D~ m{//}) {
+			ERROR("do not use C99 // comments\n" . $herecurr);
+		}
+		# Remove C99 comments.
+		$line =3D~ s@//.*@@;
+		$opline =3D~ s@//.*@@;
+
+# EXPORT_SYMBOL should immediately follow the thing it is exporting, consi=
der
+# the whole statement.
+#print "APW <$lines[$realline_next - 1]>\n";
+		if (defined $realline_next &&
+		    exists $lines[$realline_next - 1] &&
+		    !defined $suppress_export{$realline_next} &&
+		    ($lines[$realline_next - 1] =3D~ /EXPORT_SYMBOL.*\((.*)\)/ ||
+		     $lines[$realline_next - 1] =3D~ /EXPORT_UNUSED_SYMBOL.*\((.*)\)/)) {
+			my $name =3D $1;
+			if ($stat !~ /(?:
+				\n.}\s*$|
+				^.DEFINE_$Ident\(\Q$name\E\)|
+				^.DECLARE_$Ident\(\Q$name\E\)|
+				^.LIST_HEAD\(\Q$name\E\)|
+				^.(?:$Storage\s+)?$Type\s*\(\s*\*\s*\Q$name\E\s*\)\s*\(|
+				\b\Q$name\E(?:\s+$Attribute)*\s*(?:;|=3D|\[|\()
+			    )/x) {
+#print "FOO A<$lines[$realline_next - 1]> stat<$stat> name<$name>\n";
+				$suppress_export{$realline_next} =3D 2;
+			} else {
+				$suppress_export{$realline_next} =3D 1;
+			}
+		}
+		if (!defined $suppress_export{$linenr} &&
+		    $prevline =3D~ /^.\s*$/ &&
+		    ($line =3D~ /EXPORT_SYMBOL.*\((.*)\)/ ||
+		     $line =3D~ /EXPORT_UNUSED_SYMBOL.*\((.*)\)/)) {
+#print "FOO B <$lines[$linenr - 1]>\n";
+			$suppress_export{$linenr} =3D 2;
+		}
+		if (defined $suppress_export{$linenr} &&
+		    $suppress_export{$linenr} =3D=3D 2) {
+			WARN("EXPORT_SYMBOL(foo); should immediately follow its function/variab=
le\n" . $herecurr);
+		}
+
+# check for external initialisers.
+		if ($line =3D~ /^.$Type\s*$Ident\s*(?:\s+$Modifier)*\s*=3D\s*(0|NULL|fal=
se)\s*;/) {
+			ERROR("do not initialise externals to 0 or NULL\n" .
+				$herecurr);
+		}
+# check for static initialisers.
+		if ($line =3D~ /\bstatic\s.*=3D\s*(0|NULL|false)\s*;/) {
+			ERROR("do not initialise statics to 0 or NULL\n" .
+				$herecurr);
+		}
+
+# check for new typedefs, only function parameters and sparse annotations
+# make sense.
+		if ($line =3D~ /\btypedef\s/ &&
+		    $line !~ /\btypedef\s+$Type\s*\(\s*\*?$Ident\s*\)\s*\(/ &&
+		    $line !~ /\btypedef\s+$Type\s+$Ident\s*\(/ &&
+		    $line !~ /\b$typeTypedefs\b/ &&
+		    $line !~ /\b__bitwise(?:__|)\b/) {
+			WARN("do not add new typedefs\n" . $herecurr);
+		}
+
+# * goes on variable not on type
+		# (char*[ const])
+		if ($line =3D~ m{\($NonptrType(\s*(?:$Modifier\b\s*|\*\s*)+)\)}) {
+			my ($from, $to) =3D ($1, $1);
+
+			# Should start with a space.
+			$to =3D~ s/^(\S)/ $1/;
+			# Should not end with a space.
+			$to =3D~ s/\s+$//;
+			# '*'s should not have spaces between.
+			while ($to =3D~ s/\*\s+\*/\*\*/) {
+			}
+
+			#print "from<$from> to<$to>\n";
+			if ($from ne $to) {
+				ERROR("\"(foo$from)\" should be \"(foo$to)\"\n" .  $herecurr);
+			}
+		} elsif ($line =3D~ m{\b$NonptrType(\s*(?:$Modifier\b\s*|\*\s*)+)($Ident=
)}) {
+			my ($from, $to, $ident) =3D ($1, $1, $2);
+
+			# Should start with a space.
+			$to =3D~ s/^(\S)/ $1/;
+			# Should not end with a space.
+			$to =3D~ s/\s+$//;
+			# '*'s should not have spaces between.
+			while ($to =3D~ s/\*\s+\*/\*\*/) {
+			}
+			# Modifiers should have spaces.
+			$to =3D~ s/(\b$Modifier$)/$1 /;
+
+			#print "from<$from> to<$to> ident<$ident>\n";
+			if ($from ne $to && $ident !~ /^$Modifier$/) {
+				ERROR("\"foo${from}bar\" should be \"foo${to}bar\"\n" .  $herecurr);
+			}
+		}
+
+# # no BUG() or BUG_ON()
+# 		if ($line =3D~ /\b(BUG|BUG_ON)\b/) {
+# 			print "Try to use WARN_ON & Recovery code rather than BUG() or BUG_ON=
()\n";
+# 			print "$herecurr";
+# 			$clean =3D 0;
+# 		}
+
+		if ($line =3D~ /\bLINUX_VERSION_CODE\b/) {
+			WARN("LINUX_VERSION_CODE should be avoided, code should be for the vers=
ion to which it is merged\n" . $herecurr);
+		}
+
+# printk should use KERN_* levels.  Note that follow on printk's on the
+# same line do not need a level, so we use the current block context
+# to try and find and validate the current printk.  In summary the current
+# printk includes all preceeding printk's which have no newline on the end.
+# we assume the first bad printk is the one to report.
+		if ($line =3D~ /\bprintk\((?!KERN_)\s*"/) {
+			my $ok =3D 0;
+			for (my $ln =3D $linenr - 1; $ln >=3D $first_line; $ln--) {
+				#print "CHECK<$lines[$ln - 1]\n";
+				# we have a preceeding printk if it ends
+				# with "\n" ignore it, else it is to blame
+				if ($lines[$ln - 1] =3D~ m{\bprintk\(}) {
+					if ($rawlines[$ln - 1] !~ m{\\n"}) {
+						$ok =3D 1;
+					}
+					last;
+				}
+			}
+			if ($ok =3D=3D 0) {
+				WARN("printk() should include KERN_ facility level\n" . $herecurr);
+			}
+		}
+
+# function brace can't be on same line, except for #defines of do while,
+# or if closed on same line
+		if (($line=3D~/$Type\s*$Ident\(.*\).*\s{/) and
+		    !($line=3D~/\#\s*define.*do\s{/) and !($line=3D~/}/)) {
+			ERROR("open brace '{' following function declarations go on the next li=
ne\n" . $herecurr);
+		}
+
+# open braces for enum, union and struct go on the same line.
+		if ($line =3D~ /^.\s*{/ &&
+		    $prevline =3D~ /^.\s*(?:typedef\s+)?(enum|union|struct)(?:\s+$Ident)=
?\s*$/) {
+			ERROR("open brace '{' following $1 go on the same line\n" . $hereprev);
+		}
+
+# check for spacing round square brackets; allowed:
+#  1. with a type on the left -- int [] a;
+#  2.@the beginning of a line for slice initialisers -- [0...10] =3D 5,
+#  3. inside a curly brace -- =3D { [0...10] =3D 5 }
+		while ($line =3D~ /(.*?\s)\[/g) {
+			my ($where, $prefix) =3D ($-[1], $1);
+			if ($prefix !~ /$Type\s+$/ &&
+			    ($where !=3D 0 || $prefix !~ /^.\s+$/) &&
+			    $prefix !~ /{\s+$/) {
+				ERROR("space prohibited before open square bracket '['\n" . $herecurr);
+			}
+		}
+
+# check for spaces between functions and their parentheses.
+		while ($line =3D~ /($Ident)\s+\(/g) {
+			my $name =3D $1;
+			my $ctx_before =3D substr($line, 0, $-[1]);
+			my $ctx =3D "$ctx_before$name";
+
+			# Ignore those directives where spaces _are_ permitted.
+			if ($name =3D~ /^(?:
+				if|for|while|switch|return|case|
+				volatile|__volatile__|
+				__attribute__|format|__extension__|
+				asm|__asm__)$/x)
+			{
+
+			# cpp #define statements have non-optional spaces, ie
+			# if there is a space between the name and the open
+			# parenthesis it is simply not a parameter group.
+			} elsif ($ctx_before =3D~ /^.\s*\#\s*define\s*$/) {
+
+			# cpp #elif statement condition may start with a (
+			} elsif ($ctx =3D~ /^.\s*\#\s*elif\s*$/) {
+
+			# If this whole things ends with a type its most
+			# likely a typedef for a function.
+			} elsif ($ctx =3D~ /$Type$/) {
+
+			} else {
+				WARN("space prohibited between function name and open parenthesis '('\=
n" . $herecurr);
+			}
+		}
+# Check operator spacing.
+		if (!($line=3D~/\#\s*include/)) {
+			my $ops =3D qr{
+				<<=3D|>>=3D|<=3D|>=3D|=3D=3D|!=3D|
+				\+=3D|-=3D|\*=3D|\/=3D|%=3D|\^=3D|\|=3D|&=3D|
+				=3D>|->|<<|>>|<|>|=3D|!|~|
+				&&|\|\||,|\^|\+\+|--|&|\||\+|-|\*|\/|%|
+				\?|:
+			}x;
+			my @elements =3D split(/($ops|;)/, $opline);
+			my $off =3D 0;
+
+			my $blank =3D copy_spacing($opline);
+
+			for (my $n =3D 0; $n < $#elements; $n +=3D 2) {
+				$off +=3D length($elements[$n]);
+
+				# Pick up the preceeding and succeeding characters.
+				my $ca =3D substr($opline, 0, $off);
+				my $cc =3D '';
+				if (length($opline) >=3D ($off + length($elements[$n + 1]))) {
+					$cc =3D substr($opline, $off + length($elements[$n + 1]));
+				}
+				my $cb =3D "$ca$;$cc";
+
+				my $a =3D '';
+				$a =3D 'V' if ($elements[$n] ne '');
+				$a =3D 'W' if ($elements[$n] =3D~ /\s$/);
+				$a =3D 'C' if ($elements[$n] =3D~ /$;$/);
+				$a =3D 'B' if ($elements[$n] =3D~ /(\[|\()$/);
+				$a =3D 'O' if ($elements[$n] eq '');
+				$a =3D 'E' if ($ca =3D~ /^\s*$/);
+
+				my $op =3D $elements[$n + 1];
+
+				my $c =3D '';
+				if (defined $elements[$n + 2]) {
+					$c =3D 'V' if ($elements[$n + 2] ne '');
+					$c =3D 'W' if ($elements[$n + 2] =3D~ /^\s/);
+					$c =3D 'C' if ($elements[$n + 2] =3D~ /^$;/);
+					$c =3D 'B' if ($elements[$n + 2] =3D~ /^(\)|\]|;)/);
+					$c =3D 'O' if ($elements[$n + 2] eq '');
+					$c =3D 'E' if ($elements[$n + 2] =3D~ /^\s*\\$/);
+				} else {
+					$c =3D 'E';
+				}
+
+				my $ctx =3D "${a}x${c}";
+
+				my $at =3D "(ctx:$ctx)";
+
+				my $ptr =3D substr($blank, 0, $off) . "^";
+				my $hereptr =3D "$hereline$ptr\n";
+
+				# Pull out the value of this operator.
+				my $op_type =3D substr($curr_values, $off + 1, 1);
+
+				# Get the full operator variant.
+				my $opv =3D $op . substr($curr_vars, $off, 1);
+
+				# Ignore operators passed as parameters.
+				if ($op_type ne 'V' &&
+				    $ca =3D~ /\s$/ && $cc =3D~ /^\s*,/) {
+
+#				# Ignore comments
+#				} elsif ($op =3D~ /^$;+$/) {
+
+				# ; should have either the end of line or a space or \ after it
+				} elsif ($op eq ';') {
+					if ($ctx !~ /.x[WEBC]/ &&
+					    $cc !~ /^\\/ && $cc !~ /^;/) {
+						ERROR("space required after that '$op' $at\n" . $hereptr);
+					}
+
+				# // is a comment
+				} elsif ($op eq '//') {
+
+				# No spaces for:
+				#   ->
+				#   :   when part of a bitfield
+				} elsif ($op eq '->' || $opv eq ':B') {
+					if ($ctx =3D~ /Wx.|.xW/) {
+						ERROR("spaces prohibited around that '$op' $at\n" . $hereptr);
+					}
+
+				# , must have a space on the right.
+				} elsif ($op eq ',') {
+					if ($ctx !~ /.x[WEC]/ && $cc !~ /^}/) {
+						ERROR("space required after that '$op' $at\n" . $hereptr);
+					}
+
+				# '*' as part of a type definition -- reported already.
+				} elsif ($opv eq '*_') {
+					#warn "'*' is part of type\n";
+
+				# unary operators should have a space before and
+				# none after.  May be left adjacent to another
+				# unary operator, or a cast
+				} elsif ($op eq '!' || $op eq '~' ||
+					 $opv eq '*U' || $opv eq '-U' ||
+					 $opv eq '&U' || $opv eq '&&U') {
+					if ($ctx !~ /[WEBC]x./ && $ca !~ /(?:\)|!|~|\*|-|\&|\||\+\+|\-\-|\{)$=
/) {
+						ERROR("space required before that '$op' $at\n" . $hereptr);
+					}
+					if ($op eq '*' && $cc =3D~/\s*$Modifier\b/) {
+						# A unary '*' may be const
+
+					} elsif ($ctx =3D~ /.xW/) {
+						ERROR("space prohibited after that '$op' $at\n" . $hereptr);
+					}
+
+				# unary ++ and unary -- are allowed no space on one side.
+				} elsif ($op eq '++' or $op eq '--') {
+					if ($ctx !~ /[WEOBC]x[^W]/ && $ctx !~ /[^W]x[WOBEC]/) {
+						ERROR("space required one side of that '$op' $at\n" . $hereptr);
+					}
+					if ($ctx =3D~ /Wx[BE]/ ||
+					    ($ctx =3D~ /Wx./ && $cc =3D~ /^;/)) {
+						ERROR("space prohibited before that '$op' $at\n" . $hereptr);
+					}
+					if ($ctx =3D~ /ExW/) {
+						ERROR("space prohibited after that '$op' $at\n" . $hereptr);
+					}
+
+
+				# << and >> may either have or not have spaces both sides
+				} elsif ($op eq '<<' or $op eq '>>' or
+					 $op eq '&' or $op eq '^' or $op eq '|' or
+					 $op eq '+' or $op eq '-' or
+					 $op eq '*' or $op eq '/' or
+					 $op eq '%')
+				{
+					if ($ctx =3D~ /Wx[^WCE]|[^WCE]xW/) {
+						ERROR("need consistent spacing around '$op' $at\n" .
+							$hereptr);
+					}
+
+				# A colon needs no spaces before when it is
+				# terminating a case value or a label.
+				} elsif ($opv eq ':C' || $opv eq ':L') {
+					if ($ctx =3D~ /Wx./) {
+						ERROR("space prohibited before that '$op' $at\n" . $hereptr);
+					}
+
+				# All the others need spaces both sides.
+				} elsif ($ctx !~ /[EWC]x[CWE]/) {
+					my $ok =3D 0;
+
+					# Ignore email addresses <foo@bar>
+					if (($op eq '<' &&
+					     $cc =3D~ /^\S+\@\S+>/) ||
+					    ($op eq '>' &&
+					     $ca =3D~ /<\S+\@\S+$/))
+					{
+						$ok =3D 1;
+					}
+
+					# Ignore ?:
+					if (($opv eq ':O' && $ca =3D~ /\?$/) ||
+					    ($op eq '?' && $cc =3D~ /^:/)) {
+						$ok =3D 1;
+					}
+
+					if ($ok =3D=3D 0) {
+						ERROR("spaces required around that '$op' $at\n" . $hereptr);
+					}
+				}
+				$off +=3D length($elements[$n + 1]);
+			}
+		}
+
+# check for multiple assignments
+		if ($line =3D~ /^.\s*$Lval\s*=3D\s*$Lval\s*=3D(?!=3D)/) {
+			CHK("multiple assignments should be avoided\n" . $herecurr);
+		}
+
+## # check for multiple declarations, allowing for a function declaration
+## # continuation.
+## 		if ($line =3D~ /^.\s*$Type\s+$Ident(?:\s*=3D[^,{]*)?\s*,\s*$Ident.*/ =
&&
+## 		    $line !~ /^.\s*$Type\s+$Ident(?:\s*=3D[^,{]*)?\s*,\s*$Type\s*$Ide=
nt.*/) {
+##
+## 			# Remove any bracketed sections to ensure we do not
+## 			# falsly report the parameters of functions.
+## 			my $ln =3D $line;
+## 			while ($ln =3D~ s/\([^\(\)]*\)//g) {
+## 			}
+## 			if ($ln =3D~ /,/) {
+## 				WARN("declaring multiple variables together should be avoided\n" . =
$herecurr);
+## 			}
+## 		}
+
+#need space before brace following if, while, etc
+		if (($line =3D~ /\(.*\){/ && $line !~ /\($Type\){/) ||
+		    $line =3D~ /do{/) {
+			ERROR("space required before the open brace '{'\n" . $herecurr);
+		}
+
+# closing brace should have a space following it when it has anything
+# on the line
+		if ($line =3D~ /}(?!(?:,|;|\)))\S/) {
+			ERROR("space required after that close brace '}'\n" . $herecurr);
+		}
+
+# check spacing on square brackets
+		if ($line =3D~ /\[\s/ && $line !~ /\[\s*$/) {
+			ERROR("space prohibited after that open square bracket '['\n" . $herecu=
rr);
+		}
+		if ($line =3D~ /\s\]/) {
+			ERROR("space prohibited before that close square bracket ']'\n" . $here=
curr);
+		}
+
+# check spacing on parentheses
+		if ($line =3D~ /\(\s/ && $line !~ /\(\s*(?:\\)?$/ &&
+		    $line !~ /for\s*\(\s+;/) {
+			ERROR("space prohibited after that open parenthesis '('\n" . $herecurr);
+		}
+		if ($line =3D~ /(\s+)\)/ && $line !~ /^.\s*\)/ &&
+		    $line !~ /for\s*\(.*;\s+\)/ &&
+		    $line !~ /:\s+\)/) {
+			ERROR("space prohibited before that close parenthesis ')'\n" . $herecur=
r);
+		}
+
+#goto labels aren't indented, allow a single space however
+		if ($line=3D~/^.\s+[A-Za-z\d_]+:(?![0-9]+)/ and
+		   !($line=3D~/^. [A-Za-z\d_]+:/) and !($line=3D~/^.\s+default:/)) {
+			WARN("labels should not be indented\n" . $herecurr);
+		}
+
+# Return is not a function.
+		if (defined($stat) && $stat =3D~ /^.\s*return(\s*)(\(.*);/s) {
+			my $spacing =3D $1;
+			my $value =3D $2;
+
+			# Flatten any parentheses
+			$value =3D~ s/\)\(/\) \(/g;
+			while ($value =3D~ s/\[[^\{\}]*\]/1/ ||
+			       $value !~ /(?:$Ident|-?$Constant)\s*
+					     $Compare\s*
+					     (?:$Ident|-?$Constant)/x &&
+			       $value =3D~ s/\([^\(\)]*\)/1/) {
+			}
+
+			if ($value =3D~ /^(?:$Ident|-?$Constant)$/) {
+				ERROR("return is not a function, parentheses are not required\n" . $he=
recurr);
+
+			} elsif ($spacing !~ /\s+/) {
+				ERROR("space required before the open parenthesis '('\n" . $herecurr);
+			}
+		}
+
+# Need a space before open parenthesis after if, while etc
+		if ($line=3D~/\b(if|while|for|switch)\(/) {
+			ERROR("space required before the open parenthesis '('\n" . $herecurr);
+		}
+
+# Check for illegal assignment in if conditional -- and check for trailing
+# statements after the conditional.
+		if ($line =3D~ /do\s*(?!{)/) {
+			my ($stat_next) =3D ctx_statement_block($line_nr_next,
+						$remain_next, $off_next);
+			$stat_next =3D~ s/\n./\n /g;
+			##print "stat<$stat> stat_next<$stat_next>\n";
+
+			if ($stat_next =3D~ /^\s*while\b/) {
+				# If the statement carries leading newlines,
+				# then count those as offsets.
+				my ($whitespace) =3D
+					($stat_next =3D~ /^((?:\s*\n[+-])*\s*)/s);
+				my $offset =3D
+					statement_rawlines($whitespace) - 1;
+
+				$suppress_whiletrailers{$line_nr_next +
+								$offset} =3D 1;
+			}
+		}
+		if (!defined $suppress_whiletrailers{$linenr} &&
+		    $line =3D~ /\b(?:if|while|for)\s*\(/ && $line !~ /^.\s*#/) {
+			my ($s, $c) =3D ($stat, $cond);
+
+			if ($c =3D~ /\bif\s*\(.*[^<>!=3D]=3D[^=3D].*/s) {
+				ERROR("do not use assignment in if condition\n" . $herecurr);
+			}
+
+			# Find out what is on the end of the line after the
+			# conditional.
+			substr($s, 0, length($c), '');
+			$s =3D~ s/\n.*//g;
+			$s =3D~ s/$;//g; 	# Remove any comments
+			if (length($c) && $s !~ /^\s*{?\s*\\*\s*$/ &&
+			    $c !~ /}\s*while\s*/)
+			{
+				# Find out how long the conditional actually is.
+				my @newlines =3D ($c =3D~ /\n/gs);
+				my $cond_lines =3D 1 + $#newlines;
+				my $stat_real =3D '';
+
+				$stat_real =3D raw_line($linenr, $cond_lines)
+							. "\n" if ($cond_lines);
+				if (defined($stat_real) && $cond_lines > 1) {
+					$stat_real =3D "[...]\n$stat_real";
+				}
+
+				ERROR("trailing statements should be on next line\n" . $herecurr . $st=
at_real);
+			}
+		}
+
+# Check for bitwise tests written as boolean
+		if ($line =3D~ /
+			(?:
+				(?:\[|\(|\&\&|\|\|)
+				\s*0[xX][0-9]+\s*
+				(?:\&\&|\|\|)
+			|
+				(?:\&\&|\|\|)
+				\s*0[xX][0-9]+\s*
+				(?:\&\&|\|\||\)|\])
+			)/x)
+		{
+			WARN("boolean test with hexadecimal, perhaps just 1 \& or \|?\n" . $her=
ecurr);
+		}
+
+# if and else should not have general statements after it
+		if ($line =3D~ /^.\s*(?:}\s*)?else\b(.*)/) {
+			my $s =3D $1;
+			$s =3D~ s/$;//g; 	# Remove any comments
+			if ($s !~ /^\s*(?:\sif|(?:{|)\s*\\?\s*$)/) {
+				ERROR("trailing statements should be on next line\n" . $herecurr);
+			}
+		}
+# if should not continue a brace
+		if ($line =3D~ /}\s*if\b/) {
+			ERROR("trailing statements should be on next line\n" .
+				$herecurr);
+		}
+# case and default should not have general statements after them
+		if ($line =3D~ /^.\s*(?:case\s*.*|default\s*):/g &&
+		    $line !~ /\G(?:
+			(?:\s*$;*)(?:\s*{)?(?:\s*$;*)(?:\s*\\)?\s*$|
+			\s*return\s+
+		    )/xg)
+		{
+			ERROR("trailing statements should be on next line\n" . $herecurr);
+		}
+
+		# Check for }<nl>else {, these must be at the same
+		# indent level to be relevant to each other.
+		if ($prevline=3D~/}\s*$/ and $line=3D~/^.\s*else\s*/ and
+						$previndent =3D=3D $indent) {
+			ERROR("else should follow close brace '}'\n" . $hereprev);
+		}
+
+		if ($prevline=3D~/}\s*$/ and $line=3D~/^.\s*while\s*/ and
+						$previndent =3D=3D $indent) {
+			my ($s, $c) =3D ctx_statement_block($linenr, $realcnt, 0);
+
+			# Find out what is on the end of the line after the
+			# conditional.
+			substr($s, 0, length($c), '');
+			$s =3D~ s/\n.*//g;
+
+			if ($s =3D~ /^\s*;/) {
+				ERROR("while should follow close brace '}'\n" . $hereprev);
+			}
+		}
+
+#studly caps, commented out until figure out how to distinguish between us=
e of existing and adding new
+#		if (($line=3D~/[\w_][a-z\d]+[A-Z]/) and !($line=3D~/print/)) {
+#		    print "No studly caps, use _\n";
+#		    print "$herecurr";
+#		    $clean =3D 0;
+#		}
+
+#no spaces allowed after \ in define
+		if ($line=3D~/\#\s*define.*\\\s$/) {
+			WARN("Whitepspace after \\ makes next lines useless\n" . $herecurr);
+		}
+
+#warn if <asm/foo.h> is #included and <linux/foo.h> is available (uses RAW=
 line)
+		if ($tree && $rawline =3D~ m{^.\s*\#\s*include\s*\<asm\/(.*)\.h\>}) {
+			my $file =3D "$1.h";
+			my $checkfile =3D "include/linux/$file";
+			if (-f "$root/$checkfile" &&
+			    $realfile ne $checkfile &&
+			    $1 ne 'irq')
+			{
+				if ($realfile =3D~ m{^arch/}) {
+					CHK("Consider using #include <linux/$file> instead of <asm/$file>\n" =
. $herecurr);
+				} else {
+					WARN("Use #include <linux/$file> instead of <asm/$file>\n" . $herecur=
r);
+				}
+			}
+		}
+
+# multi-statement macros should be enclosed in a do while loop, grab the
+# first statement and ensure its the whole macro if its not enclosed
+# in a known good container
+		if ($realfile !~ m@/vmlinux.lds.h$@ &&
+		    $line =3D~ /^.\s*\#\s*define\s*$Ident(\()?/) {
+			my $ln =3D $linenr;
+			my $cnt =3D $realcnt;
+			my ($off, $dstat, $dcond, $rest);
+			my $ctx =3D '';
+
+			my $args =3D defined($1);
+
+			# Find the end of the macro and limit our statement
+			# search to that.
+			while ($cnt > 0 && defined $lines[$ln - 1] &&
+				$lines[$ln - 1] =3D~ /^(?:-|..*\\$)/)
+			{
+				$ctx .=3D $rawlines[$ln - 1] . "\n";
+				$cnt-- if ($lines[$ln - 1] !~ /^-/);
+				$ln++;
+			}
+			$ctx .=3D $rawlines[$ln - 1];
+
+			($dstat, $dcond, $ln, $cnt, $off) =3D
+				ctx_statement_block($linenr, $ln - $linenr + 1, 0);
+			#print "dstat<$dstat> dcond<$dcond> cnt<$cnt> off<$off>\n";
+			#print "LINE<$lines[$ln-1]> len<" . length($lines[$ln-1]) . "\n";
+
+			# Extract the remainder of the define (if any) and
+			# rip off surrounding spaces, and trailing \'s.
+			$rest =3D '';
+			while ($off !=3D 0 || ($cnt > 0 && $rest =3D~ /\\\s*$/)) {
+				#print "ADDING cnt<$cnt> $off <" . substr($lines[$ln - 1], $off) . "> =
rest<$rest>\n";
+				if ($off !=3D 0 || $lines[$ln - 1] !~ /^-/) {
+					$rest .=3D substr($lines[$ln - 1], $off) . "\n";
+					$cnt--;
+				}
+				$ln++;
+				$off =3D 0;
+			}
+			$rest =3D~ s/\\\n.//g;
+			$rest =3D~ s/^\s*//s;
+			$rest =3D~ s/\s*$//s;
+
+			# Clean up the original statement.
+			if ($args) {
+				substr($dstat, 0, length($dcond), '');
+			} else {
+				$dstat =3D~ s/^.\s*\#\s*define\s+$Ident\s*//;
+			}
+			$dstat =3D~ s/$;//g;
+			$dstat =3D~ s/\\\n.//g;
+			$dstat =3D~ s/^\s*//s;
+			$dstat =3D~ s/\s*$//s;
+
+			# Flatten any parentheses and braces
+			while ($dstat =3D~ s/\([^\(\)]*\)/1/ ||
+			       $dstat =3D~ s/\{[^\{\}]*\}/1/ ||
+			       $dstat =3D~ s/\[[^\{\}]*\]/1/)
+			{
+			}
+
+			my $exceptions =3D qr{
+				$Declare|
+				module_param_named|
+				MODULE_PARAM_DESC|
+				DECLARE_PER_CPU|
+				DEFINE_PER_CPU|
+				__typeof__\(|
+				union|
+				struct|
+				\.$Ident\s*=3D\s*|
+				^\"|\"$
+			}x;
+			#print "REST<$rest> dstat<$dstat>\n";
+			if ($rest ne '') {
+				if ($rest !~ /while\s*\(/ &&
+				    $dstat !~ /$exceptions/)
+				{
+					ERROR("Macros with multiple statements should be enclosed in a do - w=
hile loop\n" . "$here\n$ctx\n");
+				}
+
+			} elsif ($ctx !~ /;/) {
+				if ($dstat ne '' &&
+				    $dstat !~ /^(?:$Ident|-?$Constant)$/ &&
+				    $dstat !~ /$exceptions/ &&
+				    $dstat !~ /^\.$Ident\s*=3D/ &&
+				    $dstat =3D~ /$Operators/)
+				{
+					ERROR("Macros with complex values should be enclosed in parenthesis\n=
" . "$here\n$ctx\n");
+				}
+			}
+		}
+
+# make sure symbols are always wrapped with VMLINUX_SYMBOL() ...
+# all assignments may have only one of the following with an assignment:
+#	.
+#	ALIGN(...)
+#	VMLINUX_SYMBOL(...)
+		if ($realfile eq 'vmlinux.lds.h' && $line =3D~ /(?:(?:^|\s)$Ident\s*=3D|=
=3D\s*$Ident(?:\s|$))/) {
+			WARN("vmlinux.lds.h needs VMLINUX_SYMBOL() around C-visible symbols\n" =
. $herecurr);
+		}
+
+# check for redundant bracing round if etc
+		if ($line =3D~ /(^.*)\bif\b/ && $1 !~ /else\s*$/) {
+			my ($level, $endln, @chunks) =3D
+				ctx_statement_full($linenr, $realcnt, 1);
+			#print "chunks<$#chunks> linenr<$linenr> endln<$endln> level<$level>\n";
+			#print "APW: <<$chunks[1][0]>><<$chunks[1][1]>>\n";
+			if ($#chunks > 0 && $level =3D=3D 0) {
+				my $allowed =3D 0;
+				my $seen =3D 0;
+				my $herectx =3D $here . "\n";
+				my $ln =3D $linenr - 1;
+				for my $chunk (@chunks) {
+					my ($cond, $block) =3D @{$chunk};
+
+					# If the condition carries leading newlines, then count those as offs=
ets.
+					my ($whitespace) =3D ($cond =3D~ /^((?:\s*\n[+-])*\s*)/s);
+					my $offset =3D statement_rawlines($whitespace) - 1;
+
+					#print "COND<$cond> whitespace<$whitespace> offset<$offset>\n";
+
+					# We have looked at and allowed this specific line.
+					$suppress_ifbraces{$ln + $offset} =3D 1;
+
+					$herectx .=3D "$rawlines[$ln + $offset]\n[...]\n";
+					$ln +=3D statement_rawlines($block) - 1;
+
+					substr($block, 0, length($cond), '');
+
+					$seen++ if ($block =3D~ /^\s*{/);
+
+					#print "cond<$cond> block<$block> allowed<$allowed>\n";
+					if (statement_lines($cond) > 1) {
+						#print "APW: ALLOWED: cond<$cond>\n";
+						$allowed =3D 1;
+					}
+					if ($block =3D~/\b(?:if|for|while)\b/) {
+						#print "APW: ALLOWED: block<$block>\n";
+						$allowed =3D 1;
+					}
+					if (statement_block_size($block) > 1) {
+						#print "APW: ALLOWED: lines block<$block>\n";
+						$allowed =3D 1;
+					}
+				}
+				if ($seen && !$allowed) {
+					WARN("braces {} are not necessary for any arm of this statement\n" . =
$herectx);
+				}
+			}
+		}
+		if (!defined $suppress_ifbraces{$linenr - 1} &&
+					$line =3D~ /\b(if|while|for|else)\b/) {
+			my $allowed =3D 0;
+
+			# Check the pre-context.
+			if (substr($line, 0, $-[0]) =3D~ /(\}\s*)$/) {
+				#print "APW: ALLOWED: pre<$1>\n";
+				$allowed =3D 1;
+			}
+
+			my ($level, $endln, @chunks) =3D
+				ctx_statement_full($linenr, $realcnt, $-[0]);
+
+			# Check the condition.
+			my ($cond, $block) =3D @{$chunks[0]};
+			#print "CHECKING<$linenr> cond<$cond> block<$block>\n";
+			if (defined $cond) {
+				substr($block, 0, length($cond), '');
+			}
+			if (statement_lines($cond) > 1) {
+				#print "APW: ALLOWED: cond<$cond>\n";
+				$allowed =3D 1;
+			}
+			if ($block =3D~/\b(?:if|for|while)\b/) {
+				#print "APW: ALLOWED: block<$block>\n";
+				$allowed =3D 1;
+			}
+			if (statement_block_size($block) > 1) {
+				#print "APW: ALLOWED: lines block<$block>\n";
+				$allowed =3D 1;
+			}
+			# Check the post-context.
+			if (defined $chunks[1]) {
+				my ($cond, $block) =3D @{$chunks[1]};
+				if (defined $cond) {
+					substr($block, 0, length($cond), '');
+				}
+				if ($block =3D~ /^\s*\{/) {
+					#print "APW: ALLOWED: chunk-1 block<$block>\n";
+					$allowed =3D 1;
+				}
+			}
+			if ($level =3D=3D 0 && $block =3D~ /^\s*\{/ && !$allowed) {
+				my $herectx =3D $here . "\n";;
+				my $cnt =3D statement_rawlines($block);
+
+				for (my $n =3D 0; $n < $cnt; $n++) {
+					$herectx .=3D raw_line($linenr, $n) . "\n";;
+				}
+
+				WARN("braces {} are not necessary for single statement blocks\n" . $he=
rectx);
+			}
+		}
+
+# don't include deprecated include files (uses RAW line)
+		for my $inc (@dep_includes) {
+			if ($rawline =3D~ m@^.\s*\#\s*include\s*\<$inc>@) {
+				ERROR("Don't use <$inc>: see Documentation/feature-removal-schedule.tx=
t\n" . $herecurr);
+			}
+		}
+
+# don't use deprecated functions
+		for my $func (@dep_functions) {
+			if ($line =3D~ /\b$func\b/) {
+				ERROR("Don't use $func(): see Documentation/feature-removal-schedule.t=
xt\n" . $herecurr);
+			}
+		}
+
+# no volatiles please
+		my $asm_volatile =3D qr{\b(__asm__|asm)\s+(__volatile__|volatile)\b};
+		if ($line =3D~ /\bvolatile\b/ && $line !~ /$asm_volatile/) {
+			WARN("Use of volatile is usually wrong: see Documentation/volatile-cons=
idered-harmful.txt\n" . $herecurr);
+		}
+
+# SPIN_LOCK_UNLOCKED & RW_LOCK_UNLOCKED are deprecated
+		if ($line =3D~ /\b(SPIN_LOCK_UNLOCKED|RW_LOCK_UNLOCKED)/) {
+			ERROR("Use of $1 is deprecated: see Documentation/spinlocks.txt\n" . $h=
erecurr);
+		}
+
+# warn about #if 0
+		if ($line =3D~ /^.\s*\#\s*if\s+0\b/) {
+			CHK("if this code is redundant consider removing it\n" .
+				$herecurr);
+		}
+
+# check for needless kfree() checks
+		if ($prevline =3D~ /\bif\s*\(([^\)]*)\)/) {
+			my $expr =3D $1;
+			if ($line =3D~ /\bkfree\(\Q$expr\E\);/) {
+				WARN("kfree(NULL) is safe this check is probably not required\n" . $he=
reprev);
+			}
+		}
+# check for needless usb_free_urb() checks
+		if ($prevline =3D~ /\bif\s*\(([^\)]*)\)/) {
+			my $expr =3D $1;
+			if ($line =3D~ /\busb_free_urb\(\Q$expr\E\);/) {
+				WARN("usb_free_urb(NULL) is safe this check is probably not required\n=
" . $hereprev);
+			}
+		}
+
+# warn about #ifdefs in C files
+#		if ($line =3D~ /^.\s*\#\s*if(|n)def/ && ($realfile =3D~ /\.c$/)) {
+#			print "#ifdef in C files should be avoided\n";
+#			print "$herecurr";
+#			$clean =3D 0;
+#		}
+
+# warn about spacing in #ifdefs
+		if ($line =3D~ /^.\s*\#\s*(ifdef|ifndef|elif)\s\s+/) {
+			ERROR("exactly one space required after that #$1\n" . $herecurr);
+		}
+
+# check for spinlock_t definitions without a comment.
+		if ($line =3D~ /^.\s*(struct\s+mutex|spinlock_t)\s+\S+;/ ||
+		    $line =3D~ /^.\s*(DEFINE_MUTEX)\s*\(/) {
+			my $which =3D $1;
+			if (!ctx_has_comment($first_line, $linenr)) {
+				CHK("$1 definition without comment\n" . $herecurr);
+			}
+		}
+# check for memory barriers without a comment.
+		if ($line =3D~ /\b(mb|rmb|wmb|read_barrier_depends|smp_mb|smp_rmb|smp_wm=
b|smp_read_barrier_depends)\(/) {
+			if (!ctx_has_comment($first_line, $linenr)) {
+				CHK("memory barrier without comment\n" . $herecurr);
+			}
+		}
+# check of hardware specific defines
+		if ($line =3D~ m@^.\s*\#\s*if.*\b(__i386__|__powerpc64__|__sun__|__s390x=
__)\b@ && $realfile !~ m(a)include/asm-@) {
+			CHK("architecture specific defines should be avoided\n" .  $herecurr);
+		}
+
+# check the location of the inline attribute, that it is between
+# storage class and type.
+		if ($line =3D~ /\b$Type\s+$Inline\b/ ||
+		    $line =3D~ /\b$Inline\s+$Storage\b/) {
+			ERROR("inline keyword should sit between storage class and type\n" . $h=
erecurr);
+		}
+
+# Check for __inline__ and __inline, prefer inline
+		if ($line =3D~ /\b(__inline__|__inline)\b/) {
+			WARN("plain inline is preferred over $1\n" . $herecurr);
+		}
+
+# check for sizeof(&)
+		if ($line =3D~ /\bsizeof\s*\(\s*\&/) {
+			WARN("sizeof(& should be avoided\n" . $herecurr);
+		}
+
+# check for new externs in .c files.
+		if ($realfile =3D~ /\.c$/ && defined $stat &&
+		    $stat =3D~ /^.\s*(?:extern\s+)?$Type\s+($Ident)(\s*)\(/s)
+		{
+			my $function_name =3D $1;
+			my $paren_space =3D $2;
+
+			my $s =3D $stat;
+			if (defined $cond) {
+				substr($s, 0, length($cond), '');
+			}
+			if ($s =3D~ /^\s*;/ &&
+			    $function_name ne 'uninitialized_var')
+			{
+				WARN("externs should be avoided in .c files\n" .  $herecurr);
+			}
+
+			if ($paren_space =3D~ /\n/) {
+				WARN("arguments for function declarations should follow identifier\n" =
. $herecurr);
+			}
+
+		} elsif ($realfile =3D~ /\.c$/ && defined $stat &&
+		    $stat =3D~ /^.\s*extern\s+/)
+		{
+			WARN("externs should be avoided in .c files\n" .  $herecurr);
+		}
+
+# checks for new __setup's
+		if ($rawline =3D~ /\b__setup\("([^"]*)"/) {
+			my $name =3D $1;
+
+			if (!grep(/$name/, @setup_docs)) {
+				CHK("__setup appears un-documented -- check Documentation/kernel-param=
eters.txt\n" . $herecurr);
+			}
+		}
+
+# check for pointless casting of kmalloc return
+		if ($line =3D~ /\*\s*\)\s*k[czm]alloc\b/) {
+			WARN("unnecessary cast may hide bugs, see http://c-faq.com/malloc/mallo=
cnocast.html\n" . $herecurr);
+		}
+
+# check for gcc specific __FUNCTION__
+		if ($line =3D~ /__FUNCTION__/) {
+			WARN("__func__ should be used instead of gcc specific __FUNCTION__\n"  =
. $herecurr);
+		}
+
+# check for semaphores used as mutexes
+		if ($line =3D~ /^.\s*(DECLARE_MUTEX|init_MUTEX)\s*\(/) {
+			WARN("mutexes are preferred for single holder semaphores\n" . $herecurr=
);
+		}
+# check for semaphores used as mutexes
+		if ($line =3D~ /^.\s*init_MUTEX_LOCKED\s*\(/) {
+			WARN("consider using a completion\n" . $herecurr);
+		}
+# recommend strict_strto* over simple_strto*
+		if ($line =3D~ /\bsimple_(strto.*?)\s*\(/) {
+			WARN("consider using strict_$1 in preference to simple_$1\n" . $herecur=
r);
+		}
+# check for __initcall(), use device_initcall() explicitly please
+		if ($line =3D~ /^.\s*__initcall\s*\(/) {
+			WARN("please use device_initcall() instead of __initcall()\n" . $herecu=
rr);
+		}
+# check for various ops structs, ensure they are const.
+		my $struct_ops =3D qr{acpi_dock_ops|
+				address_space_operations|
+				backlight_ops|
+				block_device_operations|
+				dentry_operations|
+				dev_pm_ops|
+				dma_map_ops|
+				extent_io_ops|
+				file_lock_operations|
+				file_operations|
+				hv_ops|
+				ide_dma_ops|
+				intel_dvo_dev_ops|
+				item_operations|
+				iwl_ops|
+				kgdb_arch|
+				kgdb_io|
+				kset_uevent_ops|
+				lock_manager_operations|
+				microcode_ops|
+				mtrr_ops|
+				neigh_ops|
+				nlmsvc_binding|
+				pci_raw_ops|
+				pipe_buf_operations|
+				platform_hibernation_ops|
+				platform_suspend_ops|
+				proto_ops|
+				rpc_pipe_ops|
+				seq_operations|
+				snd_ac97_build_ops|
+				soc_pcmcia_socket_ops|
+				stacktrace_ops|
+				sysfs_ops|
+				tty_operations|
+				usb_mon_operations|
+				wd_ops}x;
+		if ($line !~ /\bconst\b/ &&
+		    $line =3D~ /\bstruct\s+($struct_ops)\b/) {
+			WARN("struct $1 should normally be const\n" .
+				$herecurr);
+		}
+
+# use of NR_CPUS is usually wrong
+# ignore definitions of NR_CPUS and usage to define arrays as likely right
+		if ($line =3D~ /\bNR_CPUS\b/ &&
+		    $line !~ /^.\s*\s*#\s*if\b.*\bNR_CPUS\b/ &&
+		    $line !~ /^.\s*\s*#\s*define\b.*\bNR_CPUS\b/ &&
+		    $line !~ /^.\s*$Declare\s.*\[[^\]]*NR_CPUS[^\]]*\]/ &&
+		    $line !~ /\[[^\]]*\.\.\.[^\]]*NR_CPUS[^\]]*\]/ &&
+		    $line !~ /\[[^\]]*NR_CPUS[^\]]*\.\.\.[^\]]*\]/)
+		{
+			WARN("usage of NR_CPUS is often wrong - consider using cpu_possible(), =
num_possible_cpus(), for_each_possible_cpu(), etc\n" . $herecurr);
+		}
+
+# check for %L{u,d,i} in strings
+		my $string;
+		while ($line =3D~ /(?:^|")([X\t]*)(?:"|$)/g) {
+			$string =3D substr($rawline, $-[1], $+[1] - $-[1]);
+			$string =3D~ s/%%/__/g;
+			if ($string =3D~ /(?<!%)%L[udi]/) {
+				WARN("\%Ld/%Lu are not-standard C, use %lld/%llu\n" . $herecurr);
+				last;
+			}
+		}
+
+# whine mightly about in_atomic
+		if ($line =3D~ /\bin_atomic\s*\(/) {
+			if ($realfile =3D~ m@^drivers/@) {
+				ERROR("do not use in_atomic in drivers\n" . $herecurr);
+			} elsif ($realfile !~ m@^kernel/@) {
+				WARN("use of in_atomic() is incorrect outside core kernel code\n" . $h=
erecurr);
+			}
+		}
+	}
+
+	# If we have no input@all, then there is nothing to report on
+	# so just keep quiet.
+	if ($#rawlines =3D=3D -1) {
+		exit(0);
+	}
+
+	# In mailback mode only produce a report in the negative, for
+	# things that appear to be patches.
+	if ($mailback && ($clean =3D=3D 1 || !$is_patch)) {
+		exit(0);
+	}
+
+	# This is not a patch, and we are are in 'no-patch' mode so
+	# just keep quiet.
+	if (!$chk_patch && !$is_patch) {
+		exit(0);
+	}
+
+	if (!$is_patch) {
+		ERROR("Does not appear to be a unified-diff format patch\n");
+	}
+	if ($is_patch && $chk_signoff && $signoff =3D=3D 0) {
+		ERROR("Missing Signed-off-by: line(s)\n");
+	}
+
+	print report_dump();
+	if ($summary && !($clean =3D=3D 1 && $quiet =3D=3D 1)) {
+		print "$filename " if ($summary_file);
+		print "total: $cnt_error errors, $cnt_warn warnings, " .
+			(($check)? "$cnt_chk checks, " : "") .
+			"$cnt_lines lines checked\n";
+		print "\n" if ($quiet =3D=3D 0);
+	}
+
+	if ($clean =3D=3D 1 && $quiet =3D=3D 0) {
+		print "$vname has no obvious style problems and is ready for submission.=
\n"
+	}
+	if ($clean =3D=3D 0 && $quiet =3D=3D 0) {
+		print "$vname has style problems, please review.  If any of these errors=
\n";
+		print "are false positives report them to the maintainer, see\n";
+		print "CHECKPATCH in MAINTAINERS.\n";
+	}
+
+	return $clean;
+}
diff --git a/drivers/isimodem2.5/debug.c b/drivers/isimodem2.5/debug.c
new file mode 100644
index 0000000..14c538f
--- /dev/null
+++ b/drivers/isimodem2.5/debug.c
@@ -0,0 +1,694 @@
+/*
+ * This file is part of oFono - Open Source Telephony
+ *
+ * Copyright (C) 2009-2010 Nokia Corporation and/or its subsidiary(-ies).
+ * Copyright (C) ST-Ericsson SA 2010.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <string.h>
+#include <errno.h>
+
+#include <glib.h>
+
+#define OFONO_API_SUBJECT_TO_CHANGE
+#include <ofono/log.h>
+
+#include "debug.h"
+
+#define _(X) case X: return #X
+
+const char *pn_resource_name(int value)
+{
+	switch (value) {
+		_(PN_MODEM_NETWORK);
+		_(PN_MODEM_INFO);
+		_(PN_SS);
+		_(PN_MODEM_CALL);
+		_(PN_SMS);
+		_(PN_UICC);
+		_(PN_MODEM_MCE);
+		_(PN_GSS);
+		_(PN_GPDS);
+	}
+	return "PN_<UNKNOWN>";
+}
+
+const char *ss_message_id_name(uint8_t value)
+{
+	switch (value) {
+		_(SS_SERVICE_REQ);
+		_(SS_SERVICE_COMPLETED_RESP);
+		_(SS_SERVICE_FAILED_RESP);
+		_(SS_SERVICE_NOT_SUPPORTED_RESP);
+		_(SS_GSM_USSD_SEND_REQ);
+		_(SS_GSM_USSD_SEND_RESP);
+		_(SS_GSM_USSD_RECEIVE_IND);
+		_(SS_STATUS_IND);
+		_(SS_SERVICE_COMPLETED_IND);
+		_(SS_CANCEL_REQ);
+		_(SS_CANCEL_RESP);
+		_(SS_RESOURCE_CONTROL_IND);
+		_(SS_RESOURCE_CONTROL_REQ);
+		_(SS_RESOURCE_CONTROL_RESP);
+		_(SS_RESOURCE_CONF_IND);
+		_(SS_RESOURCE_CONF_REQ);
+		_(SS_RESOURCE_CONF_RESP);
+	}
+	return "SS_<UNKNOWN>";
+}
+
+const char *ss_subblock_name(uint8_t value)
+{
+	switch (value) {
+		_(SS_GSM_BARRING_FEATURE);
+		_(SS_GSM_BARRING_INFO);
+		_(SS_GSM_CLIR_INFO);
+		_(SS_GSM_GENERIC_SERVICE_INFO);
+		_(SS_GSM_INDICATE_PROBLEM);
+		_(SS_GSM_INDICATE_MSG_ERROR);
+		_(SS_OTHER_ERROR);
+		_(SS_GSM_MM_RELEASED);
+		_(SS_SB_RESOURCE);
+		_(SS_SB_RESOURCE_SEQ_ID);
+		_(SS_SB_SS_CONTROL);
+		_(SS_SB_USSD_CONTROL);
+		_(SS_SB_RESOURCE_STATUS);
+		_(SS_SB_RESOURCE_CONTROL_INFO);
+		_(SS_SB_CHECK_INFO);
+		_(SS_SB_RESOURCE_CONF_REQUIRED);
+		_(SS_SB_RESOURCE_CONF);
+		_(SS_FORWARDING);
+		_(SS_STATUS_RESULT);
+		_(SS_GSM_PASSWORD);
+		_(SS_GSM_FORWARDING_INFO);
+		_(SS_GSM_FORWARDING_FEATURE);
+		_(SS_GSM_DATA);
+		_(SS_GSM_BSC_INFO);
+		_(SS_GSM_PASSWORD_INFO);
+		_(SS_GSM_INDICATE_PASSWORD_ERROR);
+		_(SS_GSM_INDICATE_ERROR);
+		_(SS_GSM_ADDITIONAL_INFO);
+		_(SS_GSM_USSD_STRING);
+	}
+	return "SS_<UNKNOWN>";
+}
+
+const char *ss_operation_name(uint8_t value)
+{
+	switch (value) {
+		_(SS_ACTIVATION);
+		_(SS_DEACTIVATION);
+		_(SS_REGISTRATION);
+		_(SS_ERASURE);
+		_(SS_INTERROGATION);
+		_(SS_GSM_PASSWORD_REGISTRATION);
+	}
+	return "SS_<UNKNOWN>";
+}
+
+const char *ss_ss_code_name(uint16_t value)
+{
+	switch (value) {
+		_(SS_GSM_ALL_SS);
+		_(SS_GSM_ALL_FORWARDINGS);
+		_(SS_GSM_ALL_COND_FORWARDINGS);
+		_(SS_GSM_FORW_UNCONDITIONAL);
+		_(SS_GSM_FORW_BUSY);
+		_(SS_GSM_FORW_NO_REPLY);
+		_(SS_GSM_FORW_NO_REACH);
+		_(SS_GSM_ALL_BARRINGS);
+		_(SS_GSM_BARR_ALL_OUT);
+		_(SS_GSM_BARR_OUT_INTER);
+		_(SS_GSM_BARR_OUT_INTER_EXC_HOME);
+		_(SS_GSM_BARR_ALL_IN);
+		_(SS_GSM_BARR_ALL_IN_ROAM);
+		_(SS_GSM_OUTGOING_BARR_SERV);
+		_(SS_GSM_INCOMING_BARR_SERV);
+		_(SS_GSM_CALL_WAITING);
+		_(SS_GSM_CLIP);
+		_(SS_GSM_CLIR);
+		_(SS_GSM_COLP);
+		_(SS_GSM_COLR);
+		_(SS_GSM_CNAP);
+		_(SS_GSM_ECT);
+	}
+	return "SS_<UNKNOWN>";
+}
+
+
+const char *mce_isi_cause_name(enum mce_status_info value)
+{
+	switch (value) {
+		_(MCE_OK);
+		_(MCE_FAIL);
+		_(MCE_ALREADY_ACTIVE);
+		_(MCE_TRANSITION_ONGOING);
+	}
+	return "MCE_<UNKNOWN>";
+}
+
+const char *mce_message_id_name(enum mce_message_id value)
+{
+	switch (value) {
+		_(MCE_MODEM_STATE_IND);
+		_(MCE_MODEM_STATE_QUERY_REQ);
+		_(MCE_MODEM_STATE_QUERY_RESP);
+		_(MCE_RF_STATE_REQ);
+		_(MCE_RF_STATE_RESP);
+		_(MCE_RF_STATE_IND);
+		_(MCE_RF_STATE_QUERY_REQ);
+		_(MCE_RF_STATE_QUERY_RESP);
+		_(MCE_POWER_OFF_REQ);
+		_(MCE_POWER_OFF_RESP);
+	}
+	return "MCE_<UNKNOWN>";
+}
+
+const char *mce_modem_state_name(enum mce_modem_state value)
+{
+	switch (value) {
+		_(MCE_NORMAL);
+		_(MCE_LOCAL);
+		_(MCE_SW_RESET);
+		_(MCE_POWER_OFF);
+	}
+	return "MCE_<UNKNOWN>";
+}
+
+const char *uicc_service_type_name(uint8_t value)
+{
+	switch (value) {
+		_(UICC_APPL_LIST);
+		_(UICC_APPL_HOST_ACTIVATE);
+		/*_(UICC_APPL_DEACTIVATE);*/
+		_(UICC_APPL_START_UP_COMPLETE);
+		/*_(UICC_SHUT_DOWN_INITIATED);*/
+		_(UICC_APPL_SHUT_DOWN_INITIATED);
+		_(UICC_APPL_STATUS_GET);
+		_(UICC_APPL_HOST_DEACTIVATE);
+		_(UICC_PIN_VERIFY);
+		_(UICC_PIN_UNBLOCK);
+		_(UICC_PIN_DISABLE);
+		_(UICC_PIN_ENABLE);
+		_(UICC_PIN_CHANGE);
+		_(UICC_PIN_SUBSTITUTE);
+		_(UICC_PIN_INFO);
+		_(UICC_PIN_PROMPT_VERIFY);
+		_(UICC_APPL_READ_TRANSPARENT);
+		_(UICC_APPL_UPDATE_TRANSPARENT);
+		_(UICC_APPL_READ_LINEAR_FIXED);
+		_(UICC_APPL_UPDATE_LINEAR_FIXED);
+		_(UICC_APPL_FILE_INFO);
+		_(UICC_APPL_APDU_SEND);
+		_(UICC_APPL_CLEAR_CACHE);
+		_(UICC_APPL_SESSION_START);
+		_(UICC_APPL_SESSION_END);
+		_(UICC_APPL_READ_CYCLIC);
+		_(UICC_APPL_UPDATE_CYCLIC);
+		/*_(UICC_APPL_CACHE_UPDATED);*/
+		_(UICC_CONNECT);
+		_(UICC_DISCONNECT);
+		_(UICC_RECONNECT);
+		_(UICC_CAT_ENABLE);
+		_(UICC_CAT_DISABLE);
+		_(UICC_CAT_TERMINAL_PROFILE);
+		_(UICC_CAT_TERMINAL_RESPONSE);
+		_(UICC_CAT_ENVELOPE);
+		_(UICC_CAT_POLLING_SET);
+		_(UICC_CAT_REFRESH);
+		_(UICC_CAT_POLL);
+		_(UICC_APDU_SEND);
+		_(UICC_APDU_ATR_GET);
+		_(UICC_APDU_CONTROL);
+		_(UICC_REFRESH_STATUS);
+		_(UICC_APPL_TERMINATED);
+		_(UICC_APPL_RECOVERED);
+		/*_(UICC_APPL_UNAVAILABLE);*/
+		/*_(UICC_APPL_SHUT_DOWN);*/
+		_(UICC_APPL_ACTIVATED);
+		_(UICC_PIN_VERIFY_NEEDED);
+		_(UICC_PIN_UNBLOCK_NEEDED);
+		_(UICC_PIN_PERMANENTLY_BLOCKED);
+		_(UICC_PIN_VERIFIED);
+		_(UICC_CAT_FETCHED_CMD);
+		_(UICC_CAT_NOT_SUPPORTED);
+		_(UICC_CAT_REG_FAILED);
+		_(UICC_CAT_REG_OK);
+		_(UICC_REFRESH_PERMISSION);
+		_(UICC_REFRESH_STARTING);
+		_(UICC_REFRESH_CANCELLED);
+		_(UICC_REFRESH_NOW);
+		_(UICC_START_UP_COMPLETE);
+		_(UICC_STATUS_GET);
+		_(UICC_READY);
+		/*_(UICC_READY_FOR_ACTIVATION);*/
+		_(UICC_INITIALIZED);
+		_(UICC_SHUTTING_DOWN);
+		/*_(UICC_SHUT_DOWN_CONFIG);*/
+		_(UICC_ERROR);
+		_(UICC_CARD_DISCONNECTED);
+		_(UICC_CARD_REMOVED);
+		_(UICC_CARD_NOT_PRESENT);
+		/*_(UICC_CARD_RESET);*/
+		_(UICC_CARD_READY);
+		_(UICC_CARD_STATUS_GET);
+		_(UICC_CARD_REJECTED);
+		_(UICC_CARD_INFO_GET);
+		_(UICC_SIMLOCK_ACTIVE);
+		_(UICC_APDU_SAP_ACTIVATE);
+		_(UICC_APDU_SAP_DEACTIVATE);
+		_(UICC_APDU_SAP_ATR_GET);
+		_(UICC_APDU_SAP_COLD_RESET);
+		_(UICC_APDU_SAP_WARM_RESET);
+		_(UICC_APDU_SAP_APDU_SEND);
+		_(UICC_APDU_SAP_RECOVERY);
+		_(UICC_APDU_SAP_CONFIG_GET);
+		_(UICC_PWR_CTRL_ENABLE);
+		_(UICC_PWR_CTRL_DISABLE);
+		_(UICC_PWR_CTRL_WAIT);
+		_(UICC_PWR_CTRL_PROCEED);
+		_(UICC_PWR_CTRL_PERMISSION);
+	}
+	return "UICC_SERVICE_<UNKNOWN>";
+}
+
+const char *uicc_status_name(uint8_t value)
+{
+	switch (value) {
+		/* Request performed successfully */
+		_(UICC_STATUS_OK);
+		/* Error in performing the command */
+		_(UICC_STATUS_FAIL);
+		/* Status is Unknown */
+		_(UICC_STATUS_UNKNOWN);
+		/* Server is not ready */
+		_(UICC_STATUS_NOT_READY);
+		/* Server start up is completed */
+		_(UICC_STATUS_START_UP_COMPLETED);
+		/* Server is shutting down */
+		_(UICC_STATUS_SHUTTING_DOWN);
+		/* Smart card is not ready */
+		_(UICC_STATUS_CARD_NOT_READY);
+		/* Smart card is ready */
+		_(UICC_STATUS_CARD_READY);
+		/* Smart card is disconnected */
+		_(UICC_STATUS_CARD_DISCONNECTED);
+		/* Smart card is not present */
+		_(UICC_STATUS_CARD_NOT_PRESENT);
+		/* Smart card has been rejected */
+		_(UICC_STATUS_CARD_REJECTED);
+		/* Application is active */
+		_(UICC_STATUS_APPL_ACTIVE);
+		/* Application is not active */
+		_(UICC_STATUS_APPL_NOT_ACTIVE);
+		/* PIN verification used */
+		_(UICC_STATUS_PIN_ENABLED);
+		/* PIN verification not used */
+		_(UICC_STATUS_PIN_DISABLED);
+	}
+	return "UICC_STATUS<UNKNOWN>";
+}
+const char *uicc_message_id_name(uint8_t value)
+{
+	switch (value) {
+		_(UICC_REQ);
+		_(UICC_RESP);
+		_(UICC_IND);
+		_(UICC_CARD_REQ);
+		_(UICC_CARD_RESP);
+		_(UICC_CARD_IND);
+		_(UICC_APPLICATION_REQ);
+		_(UICC_APPLICATION_RESP);
+		_(UICC_APPLICATION_IND);
+		_(UICC_PIN_REQ);
+		_(UICC_PIN_RESP);
+		_(UICC_PIN_IND);
+		_(UICC_APPL_CMD_REQ);
+		_(UICC_APPL_CMD_RESP);
+		_(UICC_APPL_CMD_IND);
+		_(UICC_CONNECTOR_REQ);
+		_(UICC_CONNECTOR_RESP);
+		_(UICC_CAT_REQ);
+		_(UICC_CAT_RESP);
+		_(UICC_CAT_IND);
+		_(UICC_APDU_REQ);
+		_(UICC_APDU_RESP);
+		_(UICC_APDU_RESET_IND);
+		_(UICC_REFRESH_REQ);
+		_(UICC_REFRESH_RESP);
+		_(UICC_REFRESH_IND);
+		_(UICC_SIMLOCK_REQ);
+		_(UICC_SIMLOCK_RESP);
+		_(UICC_APDU_SAP_REQ);
+		_(UICC_APDU_SAP_RESP);
+		_(UICC_APDU_SAP_IND);
+		_(UICC_PWR_CTRL_REQ);
+		_(UICC_PWR_CTRL_RESP);
+		_(UICC_PWR_CTRL_IND);
+	}
+	return "UICC_<UNKNOWN>";
+}
+
+const char *uicc_subblock_name(uint8_t value)
+{
+	switch (value) {
+		_(UICC_SB_SHUT_DOWN_CONFIG);
+		_(UICC_SB_CARD_STATUS);
+		_(UICC_SB_CARD_INFO);
+		_(UICC_SB_CARD_REJECT_CAUSE);
+		_(UICC_SB_CLIENT);
+		_(UICC_SB_APPL_DATA_OBJECT);
+		_(UICC_SB_APPLICATION);
+		_(UICC_SB_APPL_INFO);
+		_(UICC_SB_APPL_STATUS);
+		_(UICC_SB_FCP);
+		_(UICC_SB_FCI);
+		_(UICC_SB_CHV);
+		_(UICC_SB_PIN);
+		_(UICC_SB_PIN_REF);
+		_(UICC_SB_PUK);
+		_(UICC_SB_PIN_SUBST);
+		_(UICC_SB_PIN_INFO);
+		_(UICC_SB_APPL_PATH);
+		_(UICC_SB_SESSION);
+		_(UICC_SB_FILE_DATA);
+		_(UICC_SB_APDU);
+		_(UICC_SB_TRANSPARENT_READ);
+		_(UICC_SB_TRANSPARENT_UPDATE);
+		_(UICC_SB_TRANSPARENT);
+		_(UICC_SB_LINEAR_FIXED);
+		_(UICC_SB_CYCLIC);
+		_(UICC_SB_TERMINAL_PROFILE);
+		_(UICC_SB_TERMINAL_RESPONSE);
+		_(UICC_SB_ENVELOPE);
+		_(UICC_SB_POLLING_SET);
+		_(UICC_SB_REFRESH);
+		_(UICC_SB_AID);
+		_(UICC_SB_REFRESH_RESULT);
+		_(UICC_SB_APDU_ACTIONS);
+		_(UICC_SB_OBJECT_ID);
+		_(UICC_SB_STATUS_WORD);
+		_(UICC_SB_APDU_SAP_INFO);
+		_(UICC_SB_ACCESS_MODE);
+		_(UICC_SB_RESP_INFO);
+		_(UICC_SB_APDU_SAP_CONFIG);
+	}
+	return "SIM_<UNKNOWN>";
+}
+
+const char *net_gsm_cause_name(uint8_t value)
+{
+	switch (value) {
+		_(NET_GSM_IMSI_UNKNOWN_IN_HLR);
+		_(NET_GSM_ILLEGAL_MS);
+		_(NET_GSM_IMSI_UNKNOWN_IN_VLR);
+		_(NET_GSM_IMEI_NOT_ACCEPTED);
+		_(NET_GSM_ILLEGAL_ME);
+		_(NET_GSM_GPRS_SERVICES_NOT_ALLOWED);
+		_(NET_GSM_GPRS_AND_NON_GPRS_NA);
+		_(NET_GSM_MS_ID_CANNOT_BE_DERIVED);
+		_(NET_GSM_IMPLICITLY_DETACHED);
+		_(NET_GSM_PLMN_NOT_ALLOWED);
+		_(NET_GSM_LA_NOT_ALLOWED);
+		_(NET_GSM_ROAMING_NOT_IN_THIS_LA);
+		_(NET_GSM_GPRS_SERV_NA_IN_THIS_PLMN);
+		_(NET_GSM_NO_SUITABLE_CELLS_IN_LA);
+		_(NET_GSM_MSC_TEMP_NOT_REACHABLE);
+		_(NET_GSM_NETWORK_FAILURE);
+		_(NET_GSM_MAC_FAILURE);
+		_(NET_GSM_SYNCH_FAILURE);
+		_(NET_GSM_CONGESTION);
+		_(NET_GSM_AUTH_UNACCEPTABLE);
+		_(NET_GSM_SERV_OPT_NOT_SUPPORTED);
+		_(NET_GSM_SERV_OPT_NOT_SUBSCRIBED);
+		_(NET_GSM_SERV_TEMP_OUT_OF_ORDER);
+		_(NET_GSM_RETRY_ENTRY_NEW_CELL_LOW);
+		_(NET_GSM_RETRY_ENTRY_NEW_CELL_HIGH);
+		_(NET_GSM_SEMANTICALLY_INCORRECT);
+		_(NET_GSM_INVALID_MANDATORY_INFO);
+		_(NET_GSM_MSG_TYPE_NONEXISTENT);
+		_(NET_GSM_CONDITIONAL_IE_ERROR);
+		_(NET_GSM_MSG_TYPE_WRONG_STATE);
+		_(NET_GSM_PROTOCOL_ERROR_UNSPECIFIED);
+	}
+	return "NET_<UNKNOWN>";
+}
+
+const char *net_isi_cause_name(uint8_t value)
+{
+	switch (value) {
+		_(NET_CAUSE_OK);
+		_(NET_CAUSE_COMMUNICATION_ERROR);
+		_(NET_CAUSE_INVALID_PARAMETER);
+		_(NET_CAUSE_NO_SIM);
+		_(NET_CAUSE_SIM_NOT_YET_READY);
+		_(NET_CAUSE_NET_NOT_FOUND);
+		_(NET_CAUSE_REQUEST_NOT_ALLOWED);
+		_(NET_CAUSE_CALL_ACTIVE);
+		_(NET_CAUSE_SERVER_BUSY);
+		_(NET_CAUSE_SECURITY_CODE_REQUIRED);
+		_(NET_CAUSE_NOTHING_TO_CANCEL);
+		_(NET_CAUSE_UNABLE_TO_CANCEL);
+		_(NET_CAUSE_NETWORK_FORBIDDEN);
+		_(NET_CAUSE_REQUEST_REJECTED);
+		_(NET_CAUSE_CS_NOT_SUPPORTED);
+		_(NET_CAUSE_PAR_INFO_NOT_AVAILABLE);
+		_(NET_CAUSE_NOT_DONE);
+		_(NET_CAUSE_NO_SELECTED_NETWORK);
+		_(NET_CAUSE_REQUEST_INTERRUPTED);
+		_(NET_CAUSE_TOO_BIG_INDEX);
+		_(NET_CAUSE_MEMORY_FULL);
+		_(NET_CAUSE_SERVICE_NOT_ALLOWED);
+		_(NET_CAUSE_NOT_SUPPORTED_IN_TECH);
+	}
+	return "NET_<UNKNOWN>";
+}
+
+const char *net_status_name(uint8_t value)
+{
+	switch (value) {
+		_(NET_REG_STATUS_HOME);
+		_(NET_REG_STATUS_ROAM);
+		_(NET_REG_STATUS_NOSERV);
+		_(NET_REG_STATUS_NOSERV_SEARCHING);
+		_(NET_REG_STATUS_NOSERV_NOTSEARCHING);
+		_(NET_REG_STATUS_NOSERV_NOSIM);
+		_(NET_REG_STATUS_POWER_OFF);
+		_(NET_REG_STATUS_NSPS);
+		_(NET_REG_STATUS_NSPS_NO_COVERAGE);
+		_(NET_REG_STATUS_NOSERV_SIM_REJECTED_BY_NW);
+	}
+	return "NET_<UNKNOWN>";
+}
+
+const char *net_message_id_name(uint8_t value)
+{
+	switch (value) {
+		_(NET_MODEM_REG_STATUS_GET_REQ);
+		_(NET_MODEM_REG_STATUS_GET_RESP);
+		_(NET_MODEM_REG_STATUS_IND);
+		_(NET_MODEM_AVAILABLE_GET_REQ);
+		_(NET_MODEM_AVAILABLE_GET_RESP);
+		_(NET_AVAILABLE_CANCEL_REQ);
+		_(NET_AVAILABLE_CANCEL_RESP);
+		_(NET_SET_REQ);
+		_(NET_SET_RESP);
+		_(NET_SET_CANCEL_REQ);
+		_(NET_SET_CANCEL_RESP);
+		_(NET_RSSI_GET_REQ);
+		_(NET_RSSI_GET_RESP);
+		_(NET_CS_CONTROL_REQ);
+		_(NET_CS_CONTROL_RESP);
+		_(NET_CS_WAKEUP_REQ);
+		_(NET_CS_WAKEUP_RESP);
+		_(NET_TEST_CARRIER_REQ);
+		_(NET_TEST_CARRIER_RESP);
+		_(NET_CS_STATE_IND);
+		_(NET_NEIGHBOUR_CELLS_REQ);
+		_(NET_NEIGHBOUR_CELLS_RESP);
+		_(NET_NETWORK_SELECT_MODE_SET_REQ);
+		_(NET_NETWORK_SELECT_MODE_SET_RESP);
+		_(NET_RSSI_IND);
+		_(NET_CIPHERING_IND);
+		_(NET_TIME_IND);
+		_(NET_CHANNEL_INFO_IND);
+		_(NET_CHANNEL_INFO_REQ);
+		_(NET_CHANNEL_INFO_RESP);
+		_(NET_RAT_IND);
+		_(NET_RAT_REQ);
+		_(NET_RAT_RESP);
+		_(NET_CS_STATE_REQ);
+		_(NET_CS_STATE_RESP);
+		_(NET_UMA_INFO_IND);
+		_(NET_RADIO_INFO_IND);
+		_(NET_CELL_INFO_GET_REQ);
+		_(NET_CELL_INFO_GET_RESP);
+		_(NET_CELL_INFO_IND);
+		_(NET_NITZ_NAME_IND);
+		_(NET_SOR_REQ);
+		_(NET_SOR_RESP);
+		_(NET_RSSI_CONF_REQ);
+		_(NET_RSSI_CONF_RESP);
+	}
+	return "NET_<UNKNOWN>";
+}
+
+const char *net_subblock_name(uint8_t value)
+{
+	switch (value) {
+		_(NET_MODEM_REG_INFO_COMMON);
+		_(NET_MODEM_AVAIL_NETWORK_INFO_COMMON);
+		_(NET_OPERATOR_INFO_COMMON);
+		_(NET_RSSI_CURRENT);
+		_(NET_TEST_CARRIER_PARAM);
+		_(NET_TEST_WCDMA_PARAMS);
+		_(NET_CIPHERING_INFO);
+		_(NET_MODEM_GSM_REG_INFO);
+		_(NET_MODEM_CURRENT_CELL_INFO);
+		_(NET_TIME_INFO);
+		_(NET_MODEM_DETAILED_NETWORK_INFO);
+		_(NET_MODEM_GSM_OPERATOR_INFO);
+		_(NET_GSM_HOME_CELLS_INFO);
+		_(NET_GSM_SIM_NMR_INFO);
+		_(NET_MODEM_CAUSE_EXTENSION);
+		_(NET_MODEM_GSM_BAND_INFO);
+		_(NET_UTRAN_SIM_NMR_INFO);
+		_(NET_ECID_GERAN_INFO);
+		_(NET_ECID_UTRAN_FDD_INFO);
+		_(NET_RAT_INFO);
+		_(NET_MODEM_UMA_SERVICE_ZONE_INFO);
+		_(NET_UMA_FAILURE_INFO);
+		_(NET_UTRAN_RADIO_INFO);
+		_(NET_UARFCN_INFO);
+		_(NET_GSM_CELL_INFO);
+		_(NET_WCDMA_CELL_INFO);
+		_(NET_EPS_CELL_INFO);
+		_(NET_FULL_NITZ_NAME);
+		_(NET_SHORT_NITZ_NAME);
+		_(NET_RSSI_CONF_INFO);
+	}
+	return "NET_<UNKNOWN>";
+}
+
+const char *gss_message_id_name(uint8_t value)
+{
+	switch (value) {
+		_(GSS_CS_SERVICE_REQ);
+		_(GSS_CS_SERVICE_RESP);
+		_(GSS_CS_SERVICE_FAIL_RESP);
+		_(GSS_CS_IND);
+		_(GSS_POWER_CLASS_IND);
+		_(GSS_HSXPA_USER_SETTING_WRITE_REQ);
+		_(GSS_HSXPA_USER_SETTING_WRITE_RESP);
+		_(GSS_HSXPA_USER_SETTING_IND);
+		_(GSS_HSXPA_USER_SETTING_READ_REQ);
+		_(GSS_HSXPA_USER_SETTING_READ_RESP);
+		_(GSS_SELECTED_RAT_IND);
+		_(GSS_UMA_PREF_MODE_IND);
+		_(GSS_HAC_MODE_WRITE_REQ);
+		_(GSS_HAC_MODE_WRITE_RESP);
+	}
+	return "GSS_<UNKNOWN>";
+}
+
+const char *gss_subblock_name(uint8_t value)
+{
+	switch (value) {
+		_(GSS_CS_LOCAL_INFO);
+		_(GSS_POWER_CLASS);
+		_(GSS_CS_STATUS);
+		_(GSS_CELL_INFO);
+		_(GSS_LONG_CELL_INFO);
+		_(GSS_BAND_INFO);
+		_(GSS_RAT_INFO);
+		_(GSS_ATK_TIMING_ADVANCE);
+		_(GSS_UMA_PREF_MODE_INFO);
+		_(GSS_PROV_INFO_SB_IDS);
+		_(GSS_SGW_INFO);
+		_(GSS_UNC_INFO);
+		_(GSS_REL_SIGNAL_LEVEL_INFO);
+		_(GSS_THRESHOLD_INFO);
+	}
+	return "GSS_<UNKNOWN>";
+}
+
+const char *gpds_transfer_cause(uint8_t value)
+{
+	switch (value) {
+		_(GPDS_TRANSFER_CAUSE_ATTACHED);
+		_(GPDS_TRANSFER_CAUSE_DETACHED);
+		_(GPDS_TRANSFER_CAUSE_RESUMED);
+		_(GPDS_TRANSFER_CAUSE_SUSPENDED_NO_COVERAGE);
+		_(GPDS_TRANSFER_CAUSE_SUSPENDED_CALL_SMS);
+		_(GPDS_TRANSFER_CAUSE_SUSPENDED_CALL);
+		_(GPDS_TRANSFER_CAUSE_SUSPENDED_RAU);
+		_(GPDS_TRANSFER_CAUSE_SUSPENDED_LU);
+		_(GPDS_TRANSFER_CAUSE_DSAC_RESTRICTION);
+	}
+	return "GPDS_<UNKNOWN>";
+}
+
+const char *gpds_transfer_status(uint8_t value)
+{
+	switch (value) {
+		_(GPDS_TRANSFER_NOT_AVAIL);
+		_(GPDS_TRANSFER_AVAIL);
+	}
+	return "GPDS_<UNKNOWN>";
+}
+
+static void hex_dump(const char *name, const uint8_t m[], size_t len)
+{
+	char hex[3 * 16 + 1];
+	char ascii[16 + 1];
+	size_t i, j, k;
+
+	ofono_debug("%s [%s=3D0x%02X len=3D%zu]:", name,
+			"message_id", m[0], len);
+
+	strcpy(hex, " **"), j =3D 3;
+	strcpy(ascii, "."), k =3D 1;
+
+	for (i =3D 0; i < len; i++) {
+		sprintf(hex + j, " %02X", m[i]), j +=3D 3;
+		ascii[k++] =3D g_ascii_isgraph(m[i]) ? m[i] : '.';
+
+		if ((j & 48) =3D=3D 48) {
+			ofono_debug("    *%-48s : %.*s", hex, (int)k, ascii);
+			j =3D 0, k =3D 0;
+		}
+	}
+
+	if (j)
+		ofono_debug("    *%-48s : %.*s", hex, (int)k, ascii);
+}
+
+void net_debug(const void *restrict buf, size_t len, void *data)
+{
+	const uint8_t *m =3D buf;
+	hex_dump(net_message_id_name(m[0]), m, len);
+}
+
diff --git a/drivers/isimodem2.5/debug.h b/drivers/isimodem2.5/debug.h
new file mode 100644
index 0000000..b137b6b
--- /dev/null
+++ b/drivers/isimodem2.5/debug.h
@@ -0,0 +1,66 @@
+/*
+ * This file is part of oFono - Open Source Telephony
+ *
+ * Copyright (C) 2009 Nokia Corporation and/or its subsidiary(-ies).
+ * Copyright (C) ST-Ericsson SA 2010.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#ifndef __ISIMODEM25_DEBUG_H
+#define __ISIMODEM25_DEBUG_H
+
+#include "ss.h"
+#include "mce.h"
+#include "sms.h"
+#include "uicc.h"
+#include "info.h"
+#include "call.h"
+#include "network.h"
+#include "gss.h"
+#include "gpds.h"
+
+const char *ss_message_id_name(uint8_t value);
+const char *ss_subblock_name(uint8_t value);
+const char *ss_operation_name(uint8_t value);
+const char *ss_ss_code_name(uint16_t value);
+
+const char *mce_isi_cause_name(enum mce_status_info value);
+const char *mce_message_id_name(enum mce_message_id value);
+const char *mce_modem_state_name(enum mce_modem_state value);
+
+const char *uicc_service_type_name(uint8_t value);
+const char *uicc_status_name(uint8_t value);
+const char *uicc_message_id_name(uint8_t value);
+const char *uicc_subblock_name(uint8_t value);
+
+const char *net_gsm_cause_name(uint8_t value);
+const char *net_isi_cause_name(uint8_t value);
+const char *net_status_name(uint8_t value);
+const char *net_message_id_name(uint8_t value);
+const char *net_subblock_name(uint8_t value);
+
+const char *gss_message_id_name(uint8_t value);
+const char *gss_subblock_name(uint8_t value);
+
+const char *gpds_transfer_status(uint8_t value);
+const char *gpds_transfer_cause(uint8_t value);
+
+void net_debug(const void *restrict buf, size_t len, void *data);
+
+const char *pn_resource_name(int value);
+
+#endif /* __ISIMODEM25_DEBUG_H */
diff --git a/drivers/isimodem2.5/devinfo.c b/drivers/isimodem2.5/devinfo.c
new file mode 100644
index 0000000..ab596bc
--- /dev/null
+++ b/drivers/isimodem2.5/devinfo.c
@@ -0,0 +1,246 @@
+/*
+ * This file is part of oFono - Open Source Telephony
+ *
+ * Copyright (C) 2009 Nokia Corporation and/or its subsidiary(-ies).
+ * Copyright (C) ST-Ericsson SA 2010.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include <gisi/client.h>
+#include <gisi/iter.h>
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/devinfo.h>
+
+#include <glib.h>
+
+#include "isimodem.h"
+#include "isiutil.h"
+#include "info.h"
+#include "timeout.h"
+
+
+struct devinfo_data {
+	GIsiClient *client;
+};
+
+static gboolean info_resp_cb(GIsiClient *client, const void *restrict data,
+				size_t len, uint16_t object, void *opaque)
+{
+	const unsigned char *msg =3D data;
+	struct isi_cb_data *cbd =3D opaque;
+	ofono_devinfo_query_cb_t cb =3D cbd->cb;
+	GIsiSubBlockIter iter;
+	char *info =3D NULL;
+	guint8 chars;
+	DBG("");
+
+	if (!msg) {
+		DBG("ISI client error: %d", g_isi_client_error(client));
+		goto error;
+	}
+
+	if (len < 3) {
+		DBG("truncated message");
+		return FALSE;
+	}
+
+	if (msg[0] !=3D M_INFO_VERSION_READ_RESP)
+		return FALSE;
+
+	if (msg[1] !=3D M_INFO_OK) {
+		DBG("request failed");
+		goto error;
+	}
+
+	for (g_isi_sb_iter_init(&iter, msg, len, 3);
+			g_isi_sb_iter_is_valid(&iter);
+			g_isi_sb_iter_next(&iter)) {
+		switch (g_isi_sb_iter_get_id(&iter)) {
+		case M_INFO_SB_MODEMSW_VERSION:
+
+			if (g_isi_sb_iter_get_len(&iter) < 5
+				|| !g_isi_sb_iter_get_byte(&iter,
+						&chars, 3)
+				|| !g_isi_sb_iter_get_latin_tag(&iter,
+							&info, chars, 4))
+				goto error;
+
+			CALLBACK_WITH_SUCCESS(cb, info, cbd->data);
+			g_free(info);
+			g_free(cbd);
+			return TRUE;
+		default:
+			DBG("unindentified subblock id");
+			break;
+		}
+	}
+
+error:
+	CALLBACK_WITH_FAILURE(cb, "", cbd->data);
+	g_free(cbd);
+	return TRUE;
+}
+
+static void isi_query_model(struct ofono_devinfo *info,
+				ofono_devinfo_query_cb_t cb,
+				void *data)
+{
+	/*
+	 * Temporary solution: Need to return error here othewise revision
+	 * won't get called. ISI specs do not have corresponding ISI
+	 * message for "INFO_PRODUCT_NAME".
+	 */
+	struct ofono_error error =3D { OFONO_ERROR_TYPE_FAILURE, 0 };
+	DBG("");
+	cb(&error, NULL, info);
+}
+
+static void isi_query_revision(struct ofono_devinfo *info,
+				ofono_devinfo_query_cb_t cb,
+				void *data)
+{
+	struct devinfo_data *dev =3D ofono_devinfo_get_data(info);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(dev, cb, data);
+	const unsigned char msg[] =3D {
+		M_INFO_VERSION_READ_REQ,
+		0x00, 0x00,
+		0x00, 0x00, 0x00, 0x01, /* M_INFO_MODEMSW */
+		0x00, 0x00
+	};
+	DBG("");
+
+	if (!cbd)
+		goto error;
+
+	if (g_isi_request_make(dev->client, msg, sizeof(msg),
+			       INFO_TIMEOUT, info_resp_cb, cbd))
+		return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, "", data);
+	g_free(cbd);
+}
+
+static void isi_query_serial(struct ofono_devinfo *info,
+				ofono_devinfo_query_cb_t cb,
+				void *data)
+{
+	char imei[16]; /* IMEI 15 digits + 1 null*/
+	char numbers[] =3D "1234567890";
+	FILE *fp =3D fopen("/etc/imei", "r");
+	DBG("");
+
+	if (fp =3D=3D NULL) {
+		DBG("failed to open /etc/imei file");
+		CALLBACK_WITH_FAILURE(cb, "", data);
+		return;
+	}
+
+	if (fgets(imei, 16, fp)) {
+		DBG(" IMEI =3D %s", imei);
+
+		if (15 =3D=3D strspn(imei, numbers))
+			CALLBACK_WITH_SUCCESS(cb, imei, data);
+		else
+			CALLBACK_WITH_FAILURE(cb, "", data);
+	}
+
+	fclose(fp);
+}
+
+static gboolean isi_devinfo_register(gpointer user)
+{
+	struct ofono_devinfo *info =3D user;
+	ofono_devinfo_register(info);
+	return FALSE;
+}
+
+static void reachable_cb(GIsiClient *client, gboolean alive, uint16_t obje=
ct,
+				void *opaque)
+{
+	struct ofono_devinfo *info =3D opaque;
+
+	if (!alive) {
+		DBG("devinfo driver bootstrap failed");
+		return;
+	}
+
+	g_idle_add(isi_devinfo_register, info);
+}
+
+static int isi_devinfo_probe(struct ofono_devinfo *info, unsigned int vend=
or,
+				void *user)
+{
+	GIsiModem *idx =3D user;
+	struct devinfo_data *data =3D g_try_new0(struct devinfo_data, 1);
+	DBG("");
+
+	if (!data)
+		return -ENOMEM;
+
+	data->client =3D g_isi_client_create(idx, PN_MODEM_INFO);
+
+	if (!data->client) {
+		g_free(data);
+		return -ENOMEM;
+	}
+
+	ofono_devinfo_set_data(info, data);
+	g_isi_verify(data->client, reachable_cb, info);
+	return 0;
+}
+
+static void isi_devinfo_remove(struct ofono_devinfo *info)
+{
+	struct devinfo_data *data =3D ofono_devinfo_get_data(info);
+
+	if (data) {
+		g_isi_client_destroy(data->client);
+		g_free(data);
+	}
+}
+
+static struct ofono_devinfo_driver driver =3D {
+	.name			=3D "isimodem25",
+	.probe			=3D isi_devinfo_probe,
+	.remove			=3D isi_devinfo_remove,
+	.query_manufacturer	=3D NULL,
+	.query_model		=3D isi_query_model,
+	.query_revision		=3D isi_query_revision,
+	.query_serial		=3D isi_query_serial
+};
+
+void isi_devinfo_init()
+{
+	ofono_devinfo_driver_register(&driver);
+}
+
+void isi_devinfo_exit()
+{
+	ofono_devinfo_driver_unregister(&driver);
+}
diff --git a/drivers/isimodem2.5/gpds-context.c b/drivers/isimodem2.5/gpds-=
context.c
new file mode 100644
index 0000000..5bc9d17
--- /dev/null
+++ b/drivers/isimodem2.5/gpds-context.c
@@ -0,0 +1,788 @@
+/*
+ * This file is part of oFono - Open Source Telephony
+ *
+ * Copyright (C) 2010 Nokia Corporation and/or its subsidary(-ies).
+ * Copyright (C) ST-Ericsson SA 2010.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+#include <arpa/inet.h>
+#include <errno.h>
+#include <inttypes.h>
+#include <net/if.h>
+#include <search.h>
+#include <string.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <sys/uio.h>
+
+#include <glib.h>
+
+#include <gisi/client.h>
+#include <gisi/iter.h>
+#include "ofono.h"
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/gprs-context.h>
+#include <gisi/pep.h>
+#include <gisi/pipe_wg25.h>
+
+#include "gpds.h"
+#include "isimodem.h"
+#include "isiutil.h"
+#include "timeout.h"
+
+# if (GPDS_CID_VOID < GPDS_MAX_CONTEXT_COUNT)
+#       error Uho! This should not happen!
+#endif
+
+struct gprs_context_data {
+	GIsiClient *client;
+	GIsiModem *idx;
+	uint16_t gpds;  /* GPDS object handle */
+	GSList *contexts;
+};
+
+struct context_data {
+	unsigned cid;   /* oFono core context ID */
+	struct ofono_gprs_context *driver;
+	union {
+		ofono_gprs_context_up_cb_t up_cb;
+		ofono_gprs_context_cb_t down_cb;
+	};
+	void *data;
+
+	GIsiPEP *pep;
+	GIsiPipe_wg25 *pipe;
+
+	char apn[GPDS_MAX_APN_STRING_SIZE + 1];
+	char username[GPDS_MAX_USERNAME_SIZE + 1];
+	char password[GPDS_MAX_PASSWORD_SIZE + 1];
+
+	uint8_t handle; /* GPDS context ID */
+	uint8_t type;
+};
+
+uint8_t last_handle;
+
+static struct context_data *find_context_by_cid(GSList *contexts,
+						unsigned int cid) {
+	GSList *m =3D NULL;
+
+	for (m =3D contexts; m; m =3D m->next) {
+		struct context_data *cd =3D m->data;
+
+		if (cd->cid =3D=3D cid)
+			return cd;
+	}
+
+	return NULL;
+}
+
+static struct context_data *find_context_by_handle(GSList *contexts,
+						uint8_t handle) {
+	GSList *m =3D NULL;
+
+	for (m =3D contexts; m; m =3D m->next) {
+		struct context_data *cd =3D m->data;
+
+		if (cd->handle =3D=3D handle)
+			return cd;
+	}
+
+	return NULL;
+}
+
+static void destroy_context(struct context_data *cd)
+{
+	if (!cd)
+		return;
+
+	DBG("Destroying %p (cid=3D%u)", cd, cd->cid);
+
+	if (cd->pipe) {
+		g_isi_pipe_destroy_wg25(cd->pipe);
+		cd->pipe =3D NULL;
+	}
+
+	if (cd->pep) {
+		g_isi_pep_destroy(cd->pep);
+		cd->pep =3D NULL;
+	}
+
+	g_free(cd);
+}
+
+static gboolean gprs_up_fail(struct context_data *cd)
+{
+	struct gprs_context_data *gcd =3D
+		ofono_gprs_context_get_data(cd->driver);
+	DBG("");
+
+	CALLBACK_WITH_FAILURE(cd->up_cb, NULL, 0, NULL, NULL, NULL, NULL,
+				cd->data);
+	gcd->contexts =3D g_slist_remove(gcd->contexts, cd);
+	destroy_context(cd);
+	return TRUE;
+}
+
+static gboolean gprs_down_fail(struct context_data *cd)
+{
+	struct gprs_context_data *gcd =3D
+		ofono_gprs_context_get_data(cd->driver);
+	DBG("");
+
+	CALLBACK_WITH_FAILURE(cd->down_cb, cd->data);
+	gcd->contexts =3D g_slist_remove(gcd->contexts, cd);
+	destroy_context(cd);
+	return TRUE;
+}
+
+static gboolean check_resp(GIsiClient *client,
+				const uint8_t *restrict msg, size_t len,
+				uint_fast8_t cmd, struct context_data *cd)
+{
+	DBG("");
+
+	if (!msg) {
+		DBG("ISI client error: %d", g_isi_client_error(client));
+		return FALSE;
+	}
+
+	if (len < 3) {
+		DBG("Truncated message");
+		return FALSE;
+	}
+
+	if (msg[0] !=3D cmd) {
+		DBG("Unexpected message ID: 0x%02"PRIx8"", msg[0]);
+		return FALSE;
+	}
+
+	if ((cd->handle !=3D GPDS_CID_VOID && msg[1] !=3D cd->handle)
+	    || (msg[1] =3D=3D GPDS_CID_VOID)) {
+		DBG("Invalid context ID: 0x%02"PRIx8"", msg[1]);
+		return FALSE;
+	}
+
+	if (msg[2] !=3D GPDS_OK) {
+		DBG("Context creation error: 0x%02"PRIx8"", msg[2]);
+
+		if (len > 3)
+			DBG(" fail cause: 0x%02"PRIx8"", msg[3]);
+
+		return FALSE;
+	}
+
+	return TRUE;
+}
+
+static void activate_ind_cb(GIsiClient *client, const void *restrict data,
+				size_t len, uint16_t object, void *opaque)
+{
+	struct gprs_context_data *gcd =3D opaque;
+	struct context_data *cd;
+	const unsigned char *msg =3D data;
+	GIsiSubBlockIter iter;
+	char ifname[IF_NAMESIZE];
+	char *ip =3D NULL;
+	char *pdns =3D NULL;
+	char *sdns =3D NULL;
+	const char *dns[3];
+	char *gwip =3D NULL;
+	char gwaddrstr[] =3D {0x00, 0x00, 0x00, 0x00,};
+
+	DBG("");
+
+	if (!msg || len < 3 || msg[0] !=3D GPDS_CONTEXT_ACTIVATE_IND)
+		return;
+
+	cd =3D find_context_by_handle(gcd->contexts, msg[1]);
+
+	if (!cd) {
+		DBG("Unknown context ID: 0x%02"PRIx8"", msg[1]);
+		return;
+	}
+
+	for (g_isi_sb_iter_init(&iter, msg, len, 3);
+	     g_isi_sb_iter_is_valid(&iter);
+	     g_isi_sb_iter_next(&iter)) {
+		uint8_t *addr_value =3D NULL;
+		uint8_t addr_len =3D 0;
+
+		switch (g_isi_sb_iter_get_id(&iter)) {
+			/* TODO: IPv6 address support */
+		case GPDS_PDP_ADDRESS_INFO:
+			if (!g_isi_sb_iter_get_byte(&iter, &addr_len, 3)
+			    || !g_isi_sb_iter_get_data(&iter,
+						       (void *) &addr_value, 4))
+				goto error;
+
+			ip =3D alloca(INET_ADDRSTRLEN);
+			/* converts ip address to a text string */
+			inet_ntop(AF_INET, (const void *) addr_value, ip,
+				  INET_ADDRSTRLEN);
+			break;
+		case GPDS_PDNS_ADDRESS_INFO:
+			if (!g_isi_sb_iter_get_byte(&iter, &addr_len, 3)
+			    || !g_isi_sb_iter_get_data(&iter,
+						       (void *) &addr_value, 4))
+				break;
+
+			pdns =3D alloca(INET_ADDRSTRLEN);
+			/* converts ip address to a text string */
+			inet_ntop(AF_INET, (const void *) addr_value, pdns,
+				  INET_ADDRSTRLEN);
+			break;
+		case GPDS_SDNS_ADDRESS_INFO:
+
+			if (!g_isi_sb_iter_get_byte(&iter, &addr_len, 3)
+			    || !g_isi_sb_iter_get_data(&iter,
+						       (void *) &addr_value, 4))
+				break;
+
+			sdns =3D alloca(INET_ADDRSTRLEN);
+			/* converts ip address to a text string */
+			inet_ntop(AF_INET, (const void *) addr_value, sdns,
+				  INET_ADDRSTRLEN);
+			break;
+		default:
+			DBG("Skipped sub-block ID: 0x%02"PRIx8"",
+			    g_isi_sb_iter_get_id(&iter));
+		}
+	}
+
+	if (!g_isi_pep_get_ifname(cd->pep, ifname))
+		goto error;
+
+	dns[0] =3D pdns;
+	dns[1] =3D sdns;
+	dns[2] =3D 0;
+
+	gwip =3D alloca(INET_ADDRSTRLEN);
+	/* converts ip address to a text string */
+	inet_ntop(AF_INET, (const void *) gwaddrstr, gwip, INET_ADDRSTRLEN);
+	DBG("Context 0x%02"PRIx8" activated", msg[1]);
+	CALLBACK_WITH_SUCCESS(cd->up_cb, ifname, TRUE,
+			      (const char *) ip, STATIC_IP_NETMASK,
+			      (const char *) gwip, dns, cd->data);
+	return;
+error:
+	gprs_up_fail(cd);
+}
+
+static void activate_fail_ind_cb(GIsiClient *client, const void *restrict =
data,
+					size_t len, uint16_t object,
+					void *opaque)
+{
+	const unsigned char *msg =3D data;
+	struct gprs_context_data *gcd =3D opaque;
+	struct context_data *cd;
+	DBG("");
+
+	if (!msg || len < 3 || msg[0] !=3D GPDS_CONTEXT_ACTIVATE_FAIL_IND)
+		return;
+
+	cd =3D find_context_by_handle(gcd->contexts, msg[1]);
+
+	if (cd =3D=3D NULL) {
+		DBG("Unknown context ID: 0x%02"PRIx8"", msg[1]);
+		return;
+	}
+
+	gprs_up_fail(cd);
+}
+
+static gboolean context_activate_cb(GIsiClient *client,
+					const void *restrict data,
+					size_t len,
+					uint16_t object,
+					void *opaque)
+{
+	struct context_data *cd =3D opaque;
+	DBG("");
+
+	if (!check_resp(client, data, len, GPDS_CONTEXT_ACTIVATE_RESP, cd))
+		return gprs_up_fail(cd);
+
+	g_isi_pipe_start_wg25(cd->pipe);
+	return TRUE;
+}
+
+static gboolean send_context_activate(GIsiClient *client, void *opaque)
+{
+	struct context_data *cd =3D opaque;
+	const unsigned char msg[] =3D {
+		GPDS_CONTEXT_ACTIVATE_REQ,
+		cd->handle,     /* context ID */
+		0,              /* sub blocks */
+	};
+	DBG("");
+
+	if (!g_isi_request_make(client, msg, sizeof(msg), GPDS_TIMEOUT,
+				context_activate_cb, cd))
+		return gprs_up_fail(cd);
+
+	return TRUE;
+}
+
+static gboolean context_auth_cb(GIsiClient *client, const void *restrict d=
ata,
+				size_t len, uint16_t object, void *opaque)
+{
+	struct context_data *cd =3D opaque;
+	DBG("");
+
+	if (!check_resp(client, data, len, GPDS_CONTEXT_AUTH_RESP, cd))
+		return gprs_up_fail(cd);
+
+	send_context_activate(client, cd);
+	return TRUE;
+}
+
+static gboolean send_context_authenticate(GIsiClient *client, void *opaque)
+{
+	struct context_data *cd =3D opaque;
+	size_t username_len =3D strlen(cd->username);
+	size_t password_len =3D strlen(cd->password);
+	const unsigned char top[] =3D {
+		GPDS_CONTEXT_AUTH_REQ,
+		cd->handle,     /* context ID */
+		2,              /* sub blocks */
+		GPDS_USERNAME_INFO,
+		(3 + username_len + 3) & ~3,
+		username_len,
+		/* Username goes here */
+	};
+	const unsigned char bottom[] =3D {
+		GPDS_PASSWORD_INFO,
+		(3 + password_len + 3) & ~3,
+		password_len,
+		/* Password goes here */
+	};
+	struct iovec iov[4] =3D {
+		{ (uint8_t *) top, sizeof(top) },
+		{ cd->username, username_len },
+		{ (uint8_t *) bottom, sizeof(bottom) },
+		{ cd->password, password_len },
+	};
+	DBG("");
+
+	if (!g_isi_request_vmake(client, iov, 4, GPDS_TIMEOUT,
+				 context_auth_cb, cd))
+		return gprs_up_fail(cd);
+
+	return TRUE;
+}
+
+static gboolean context_conf_cb(GIsiClient *client, const void *restrict d=
ata,
+				size_t len, uint16_t object, void *opaque)
+{
+	struct context_data *cd =3D opaque;
+	const unsigned char *resp =3D data;
+
+	if (!check_resp(client, data, len, GPDS_CONTEXT_CONFIGURE_RESP, cd))
+		return gprs_up_fail(cd);
+
+	DBG("Context 0x%02"PRIx8" configured", resp[1]);
+
+	if (cd->username[0] !=3D '\0')
+		send_context_authenticate(client, cd);
+	else
+		send_context_activate(client, cd);
+
+	return TRUE;
+}
+
+static gboolean link_conf_cb(GIsiClient *client, const void *restrict data,
+				size_t len, uint16_t object, void *opaque)
+{
+	struct context_data *cd =3D opaque;
+	size_t apn_len =3D strlen(cd->apn);
+	const unsigned char apn_name[GPDS_MAX_APN_STRING_SIZE + 1];
+	memset(&apn_name, 0x00, sizeof(apn_name));
+	memmove(&apn_name, cd->apn, apn_len);
+	DBG("");
+
+	if (check_resp(client, data, len, GPDS_LL_CONFIGURE_RESP, cd)) {
+
+		const unsigned char msg[] =3D {
+			GPDS_CONTEXT_CONFIGURE_REQ,
+			cd->handle,		/* context ID */
+			cd->type,		/* PDP type */
+			GPDS_CONT_TYPE_NORMAL,	/*
+						 * No other context types are
+						 * needed since Ofono does not
+						 * support secondary or
+						 * network originated context*/
+			cd->handle,		/* primary context ID */
+			0x00,			/* filler */
+			2,			/* sub blocks */
+			GPDS_DNS_ADDRESS_REQ_INFO,
+			4,			/* subblock length */
+			0, 0,			/* padding */
+			GPDS_APN_INFO,
+			(3 + apn_len + 3) & ~3,
+			apn_len,
+		};
+
+		struct iovec iov[2] =3D {
+			{ (uint8_t *) msg, sizeof(msg) },
+			{ &apn_name, ((3 + apn_len + 3) & ~3) - 3 },
+		};
+
+		if (last_handle =3D=3D cd->handle)
+			last_handle =3D GPDS_CID_VOID;
+
+		DBG("Configuring context 0x%02"PRIx8"", msg[1]);
+
+		if (!g_isi_request_vmake(client, iov, 2, GPDS_TIMEOUT,
+						context_conf_cb, cd))
+			return gprs_up_fail(cd);
+
+	} else
+		return gprs_up_fail(cd);
+
+	return TRUE;
+}
+
+static void create_pipe_cb(GIsiPipe_wg25 *pipe)
+{
+	struct context_data *cd =3D g_isi_pipe_get_userdata_wg25(pipe);
+	struct gprs_context_data *gcd =3D
+		ofono_gprs_context_get_data(cd->driver);
+	unsigned char msg[] =3D {
+		GPDS_LL_CONFIGURE_REQ,
+		cd->handle,     /* GPDS context ID */
+		g_isi_pipe_get_handle_wg25(cd->pipe),
+		GPDS_LL_PLAIN,  /* link type */
+	};
+	DBG("LL Configure, context 0x%02"PRIx8"", cd->handle);
+
+	if (!g_isi_request_make(gcd->client, msg, sizeof(msg), GPDS_TIMEOUT,
+				link_conf_cb, cd))
+		gprs_up_fail(cd);
+}
+
+static gboolean create_context_cb(GIsiClient *client,
+					const void *restrict data,
+					size_t len,
+					uint16_t object, void *opaque)
+{
+	const unsigned char *resp =3D data;
+	struct context_data *cd =3D opaque;
+	struct gprs_context_data *gcd =3D
+		ofono_gprs_context_get_data(cd->driver);
+	DBG("");
+
+	if (!check_resp(client, data, len, GPDS_CONTEXT_ID_CREATE_RESP, cd))
+		goto error;
+
+	cd->handle =3D resp[1];
+	last_handle =3D resp[1];
+	DBG("Context id 0x%02"PRIx8" created", cd->handle);
+	DBG("Creating pipe interface");
+	cd->pep =3D g_isi_pep_create(gcd->idx, NULL, NULL);
+
+	if (cd->pep =3D=3D NULL)
+		goto error;
+
+	cd->pipe =3D g_isi_pipe_create_wg25(gcd->idx, create_pipe_cb);
+
+	if (cd->pipe =3D=3D NULL)
+		goto error;
+
+	g_isi_pipe_set_userdata_wg25(cd->pipe, cd);
+	return TRUE;
+error:
+	return gprs_up_fail(cd);
+}
+
+static void context_id_delete_ind_cb(GIsiClient *client,
+					const void *restrict data,
+					size_t len,
+					uint16_t object,
+					void *opaque)
+{
+	struct gprs_context_data *gcd =3D opaque;
+	struct context_data *cd;
+	const unsigned char *msg =3D data;
+	DBG("");
+
+	if (!msg || len < 2 || msg[0] !=3D GPDS_CONTEXT_ID_DELETE_IND)
+		return;
+
+	cd =3D find_context_by_handle(gcd->contexts, msg[1]);
+
+	if (cd =3D=3D NULL) {
+		DBG("Unknown context ID: 0x%02"PRIx8"", msg[1]);
+		return;
+	}
+
+	DBG("Context id 0x%02"PRIx8" deleted", msg[1]);
+	gcd->contexts =3D g_slist_remove(gcd->contexts, cd);
+	destroy_context(cd);
+}
+
+static void deactivate_ind_cb(GIsiClient *client, const void *restrict dat=
a,
+				size_t len, uint16_t object, void *opaque)
+{
+	struct gprs_context_data *gcd =3D opaque;
+	struct context_data *cd;
+	const unsigned char *msg =3D data;
+	DBG("Received");
+
+	if (!msg || len < 3 || msg[0] !=3D GPDS_CONTEXT_DEACTIVATE_IND)
+		return;
+
+	cd =3D find_context_by_handle(gcd->contexts, msg[1]);
+
+	if (cd =3D=3D NULL) {
+		DBG("Unknown context ID: 0x%02"PRIx8"", msg[1]);
+		return;
+	}
+
+	DBG("Context deactivated with cause: 0x%02"PRIx8"", msg[2]);
+	ofono_gprs_context_deactivated(cd->driver, cd->cid);
+
+	if (cd->pipe)
+		g_isi_pipe_remove_wg25(cd->pipe);
+}
+
+static void isi_gprs_activate_primary(struct ofono_gprs_context *gc,
+				const struct ofono_gprs_primary_context *ctx,
+				ofono_gprs_context_up_cb_t cb,
+				void *data)
+{
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	struct context_data *cd =3D g_try_new0(struct context_data, 1);
+	struct context_data *old =3D NULL;
+	const unsigned char msg[] =3D {
+		GPDS_CONTEXT_ID_CREATE_REQ,
+	};
+
+	DBG("");
+
+	if (!cd)
+		return;
+
+	cd->cid =3D ctx->cid;
+	cd->driver =3D gc;
+	cd->up_cb =3D cb;
+	cd->data =3D data;
+	cd->pep =3D NULL;
+	cd->pipe =3D NULL;
+	cd->handle =3D last_handle;
+	cd->type =3D GPDS_PDP_TYPE_IPV4;
+	old =3D find_context_by_cid(gcd->contexts, ctx->cid);
+
+	if (old) {
+		DBG("Duplicate context ID: %u", ctx->cid);
+		goto error;
+	}
+
+	gcd->contexts =3D g_slist_append(gcd->contexts, cd);
+
+	if (strlen(ctx->apn) >=3D GPDS_MAX_APN_STRING_SIZE
+	    || strlen(ctx->username) >=3D GPDS_MAX_USERNAME_SIZE
+	    || strlen(ctx->password) >=3D GPDS_MAX_PASSWORD_SIZE)
+		goto error;
+
+	strncpy(cd->apn, ctx->apn, GPDS_MAX_APN_STRING_SIZE);
+	cd->apn[GPDS_MAX_APN_STRING_SIZE] =3D '\0';
+	strncpy(cd->username, ctx->username, GPDS_MAX_USERNAME_SIZE);
+	cd->username[GPDS_MAX_USERNAME_SIZE] =3D '\0';
+	strncpy(cd->password, ctx->password, GPDS_MAX_PASSWORD_SIZE);
+	cd->username[GPDS_MAX_PASSWORD_SIZE] =3D '\0';
+
+	if (cd->handle !=3D GPDS_CID_VOID) {
+		DBG("Context ID already created");
+		DBG("Creating pipe interface");
+		cd->pep =3D g_isi_pep_create(gcd->idx, NULL, NULL);
+
+		if (cd->pep =3D=3D NULL)
+			goto error;
+
+		cd->pipe =3D g_isi_pipe_create_wg25(gcd->idx, create_pipe_cb);
+
+		if (cd->pipe =3D=3D NULL)
+			goto error;
+
+		g_isi_pipe_set_userdata_wg25(cd->pipe, cd);
+	} else {
+		DBG("Creating context ID");
+
+		if (!g_isi_request_make(gcd->client, msg, sizeof(msg),
+					GPDS_TIMEOUT, create_context_cb, cd))
+			gprs_up_fail(cd);
+	}
+
+	return;
+error:
+	gprs_up_fail(cd);
+}
+
+static gboolean context_deactivate_cb(GIsiClient *client,
+					const void *restrict data,
+					size_t len, uint16_t object,
+					void *opaque)
+{
+	struct context_data *cd =3D opaque;
+	DBG("");
+
+	if (!check_resp(client, data, len, GPDS_CONTEXT_DEACTIVATE_RESP, cd))
+		return gprs_down_fail(cd);
+
+	CALLBACK_WITH_SUCCESS(cd->down_cb, cd->data);
+
+	if (cd->pipe)
+		g_isi_pipe_remove_wg25(cd->pipe);
+
+	return TRUE;
+}
+
+static void isi_gprs_deactivate_primary(struct ofono_gprs_context *gc,
+					unsigned int cid,
+					ofono_gprs_context_cb_t cb, void *data)
+{
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	struct context_data *cd;
+	unsigned char msg[] =3D {
+		GPDS_CONTEXT_DEACTIVATE_REQ,
+		0x00,   /* GPDS context ID, added later */
+	};
+	DBG("");
+
+	cd =3D find_context_by_cid(gcd->contexts, cid);
+
+	if (!cd) {
+		DBG("Unknown context ID: %u", cid);
+		return;
+	}
+
+	cd->down_cb =3D cb;
+	cd->data =3D data;
+	msg[1] =3D cd->handle;
+
+	if (!g_isi_request_make(gcd->client, msg, sizeof(msg), GPDS_TIMEOUT,
+				context_deactivate_cb, cd))
+		gprs_down_fail(cd);
+}
+
+static void gpds_ctx_reachable_cb(GIsiClient *client, gboolean alive,
+					uint16_t object,
+					void *opaque)
+{
+	struct ofono_gprs_context *gc =3D opaque;
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	DBG("");
+
+	if (!alive) {
+		DBG("Unable to bootstrap gprs context driver");
+		return;
+	}
+
+	DBG("PN_GPDS (v%03d.%03d) for PDP contexts",
+	    g_isi_version_major(client),
+	    g_isi_version_minor(client));
+	gcd->gpds =3D object;
+	g_isi_subscribe(client, GPDS_CONTEXT_ACTIVATE_IND,
+			activate_ind_cb, gcd);
+	g_isi_subscribe(client, GPDS_CONTEXT_ACTIVATE_FAIL_IND,
+			activate_fail_ind_cb, gcd);
+	g_isi_subscribe(client, GPDS_CONTEXT_DEACTIVATE_IND,
+			deactivate_ind_cb, gcd);
+	g_isi_subscribe(client, GPDS_CONTEXT_ID_DELETE_IND,
+			context_id_delete_ind_cb, gcd);
+}
+
+static int isi_gprs_context_probe(struct ofono_gprs_context *gc,
+					unsigned int vendor, void *user)
+{
+	GIsiModem *idx =3D user;
+	struct gprs_context_data *gcd =3D g_try_new0(struct gprs_context_data, 1);
+	struct ofono_atom *gprsa;
+	struct gprs_data *gd;
+
+	DBG("");
+
+	if (!gcd)
+		return -ENOMEM;
+
+	gprsa =3D __ofono_modem_find_atom(
+			ofono_gprs_context_get_modem(gc),
+			OFONO_ATOM_TYPE_GPRS);
+	gd =3D ofono_gprs_get_data(
+			__ofono_atom_get_data(gprsa));
+
+	gcd->client =3D gd->client;
+
+	if (!gcd->client) {
+		g_free(gcd);
+		return -ENOMEM;
+	}
+
+	last_handle =3D GPDS_CID_VOID;
+	ofono_gprs_context_set_data(gc, gcd);
+	gcd->idx =3D idx;
+	gcd->contexts =3D NULL;
+	g_isi_verify(gcd->client, gpds_ctx_reachable_cb, gc);
+	return 0;
+}
+
+static void isi_gprs_context_remove(struct ofono_gprs_context *gc)
+{
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	GSList *m;
+	DBG("");
+
+	ofono_gprs_context_set_data(gc, NULL);
+
+	for (m =3D gcd->contexts; m; m =3D m->next)
+		destroy_context(m->data);
+
+	g_slist_free(gcd->contexts);
+
+	if (gcd->client)
+		gcd->client =3D NULL;/* Do not destroy, will be done in gpds.c */
+
+	g_free(gcd);
+}
+
+static struct ofono_gprs_context_driver driver =3D {
+	.name                   =3D "isimodem25",
+	.probe                  =3D isi_gprs_context_probe,
+	.remove                 =3D isi_gprs_context_remove,
+	.activate_primary       =3D isi_gprs_activate_primary,
+	.deactivate_primary     =3D isi_gprs_deactivate_primary,
+};
+
+void isi_gprs_context_init()
+{
+	DBG("");
+	g_isi_pipe_init_wg25();
+	ofono_gprs_context_driver_register(&driver);
+}
+
+void isi_gprs_context_exit()
+{
+	DBG("");
+	ofono_gprs_context_driver_unregister(&driver);
+}
diff --git a/drivers/isimodem2.5/gpds.c b/drivers/isimodem2.5/gpds.c
new file mode 100644
index 0000000..64280da
--- /dev/null
+++ b/drivers/isimodem2.5/gpds.c
@@ -0,0 +1,395 @@
+/*
+ * This file is part of oFono - Open Source Telephony
+ *
+ * Copyright (C) 2010 Nokia Corporation and/or its subsidary(-ies).
+ * Copyright (C) ST-Ericsson SA 2010.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <inttypes.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include <glib.h>
+
+#include <gisi/client.h>
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/gprs.h>
+
+#include "debug.h"
+#include "gpds.h"
+#include "isimodem.h"
+#include "isiutil.h"
+#include "timeout.h"
+
+static void transfer_status_ind_cb(GIsiClient *client,
+				   const void *restrict data,
+				   size_t len,
+				   uint16_t object,
+				   void *opaque)
+{
+	const unsigned char *msg =3D data;
+	DBG("");
+
+	if (!msg || len < 3 || msg[0] !=3D GPDS_TRANSFER_STATUS_IND)
+		return;
+
+	DBG("Transfer status changed: %s with cause: %s",
+	    gpds_transfer_status(msg[1]), gpds_transfer_cause(msg[2]));
+}
+
+static void detach_ind_cb(GIsiClient *client, const void *restrict data,
+			  size_t len, uint16_t object, void *opaque)
+{
+	struct ofono_gprs *gprs =3D opaque;
+	const unsigned char *msg =3D data;
+	struct gprs_data *gd =3D ofono_gprs_get_data(gprs);
+	struct isi_cb_data *cbd =3D NULL;
+	ofono_gprs_cb_t cb =3D NULL;
+	DBG("");
+
+	if (!msg || len < 3 || msg[0] !=3D GPDS_DETACH_IND)
+		return;
+
+	DBG("Detached with cause: 0x%02"PRIx8"", msg[1]);
+
+	if (gd)
+		cbd =3D gd->cbd;
+
+	if (cbd)
+		cb =3D cbd->cb;
+
+	if (gd->cbd) {
+		CALLBACK_WITH_SUCCESS(cb, cbd->data);
+		gd->cbd =3D NULL;
+		ofono_gprs_set_data(gprs, gd);
+		g_free(cbd);
+	}
+
+	ofono_gprs_detached_notify(gprs);
+}
+
+static gboolean isi_gprs_register(gpointer user)
+{
+	struct ofono_gprs *gprs =3D user;
+	struct gprs_data *gd =3D ofono_gprs_get_data(gprs);
+	DBG("");
+
+	g_isi_subscribe(gd->client, GPDS_DETACH_IND, detach_ind_cb, gprs);
+	g_isi_subscribe(gd->client,
+			GPDS_TRANSFER_STATUS_IND,
+			transfer_status_ind_cb, gprs);
+	ofono_gprs_register(user);
+	return FALSE;
+}
+
+static gboolean configure_resp_cb(GIsiClient *client,
+				  const void *restrict data,
+				  size_t len,
+				  uint16_t object,
+				  void *opaque)
+{
+	const unsigned char *msg =3D data;
+	DBG("");
+
+	if (!msg || len < 2 || msg[0] !=3D GPDS_CONFIGURE_RESP)
+		return FALSE;
+
+	if (msg[1] !=3D GPDS_OK)
+		DBG("Failed to configure");
+
+	return TRUE;
+}
+
+static void gpds_reachable_cb(GIsiClient *client,
+			      gboolean alive,
+			      uint16_t object,
+			      void *opaque)
+{
+	struct ofono_gprs *gprs =3D opaque;
+	const unsigned char msg[] =3D {
+		GPDS_CONFIGURE_REQ,
+		GPDS_ATTACH_MODE_MANUAL,
+		GPDS_MT_ACT_MODE_DEFAULT,
+		GPDS_CLASSC_MODE_DEFAULT,
+		GPDS_AOL_CTX_DEFAULT,
+		0x00, 0x00
+	};
+	DBG("");
+
+	if (!alive) {
+		DBG("Unable to bootsrap gprs driver");
+		return;
+	}
+
+	DBG("PN_GPDS (v%03d.%03d) for PDP contexts",
+	g_isi_version_major(client),
+	g_isi_version_minor(client));
+
+	g_idle_add(isi_gprs_register, gprs);
+
+	DBG("Configure GPDS");
+
+	if (g_isi_request_make(client, msg, sizeof(msg), GPDS_TIMEOUT,
+			       configure_resp_cb, gprs) =3D=3D NULL)
+		DBG("Send failed");
+}
+
+static int isi_gprs_probe(struct ofono_gprs *gprs,
+			  unsigned int vendor, void *user)
+{
+	GIsiModem *idx =3D user;
+	struct gprs_data *gd =3D g_try_new0(struct gprs_data, 1);
+	DBG("");
+
+	if (!gd)
+		return -ENOMEM;
+
+	gd->client =3D g_isi_client_create(idx, PN_GPDS);
+
+	if (!gd->client) {
+		g_free(gd);
+		return -ENOMEM;
+	}
+
+	ofono_gprs_set_data(gprs, gd);
+	ofono_gprs_set_cid_range(gprs, 1, GPDS_MAX_CONTEXT_COUNT + 1);
+	g_isi_verify(gd->client, gpds_reachable_cb, gprs);
+	return 0;
+}
+
+static void isi_gprs_remove(struct ofono_gprs *gprs)
+{
+	struct gprs_data *data =3D ofono_gprs_get_data(gprs);
+	DBG("");
+
+	if (!data)
+		return;
+
+	ofono_gprs_set_data(gprs, NULL);
+	g_isi_client_destroy(data->client);
+	g_free(data);
+}
+
+static gboolean attach_resp_cb(GIsiClient *client, const void *restrict da=
ta,
+			       size_t len, uint16_t object, void *opaque)
+{
+	const unsigned char *msg =3D data;
+	struct isi_cb_data *cbd =3D opaque;
+	ofono_gprs_cb_t cb =3D cbd->cb;
+	DBG("");
+
+	if (!msg) {
+		DBG("ISI client error: %d", g_isi_client_error(client));
+		goto error;
+	}
+
+	if (len !=3D 4 || msg[0] !=3D GPDS_ATTACH_RESP)
+		return FALSE;
+
+	if (msg[1] !=3D GPDS_OK) {
+		DBG("Attach failed with cause: 0x%02"PRIx8"", msg[2]);
+		goto error;
+	}
+
+	DBG("Attached");
+	CALLBACK_WITH_SUCCESS(cb, cbd->data);
+	goto out;
+error:
+	CALLBACK_WITH_FAILURE(cb, cbd->data);
+out:
+	g_free(cbd);
+	return TRUE;
+}
+
+static gboolean detach_resp_cb(GIsiClient *client, const void *restrict da=
ta,
+			       size_t len, uint16_t object, void *opaque)
+{
+	const unsigned char *msg =3D data;
+	struct isi_cb_data *cbd =3D opaque;
+	ofono_gprs_cb_t cb =3D NULL;
+	struct ofono_gprs *gprs =3D NULL;
+	struct gprs_data *gd =3D NULL;
+	DBG("");
+
+	if (!msg) {
+		DBG("ISI client error: %d", g_isi_client_error(client));
+		goto error;
+	}
+
+	if (len !=3D 3 || msg[0] !=3D GPDS_DETACH_RESP)
+		return FALSE;
+
+	if (msg[1] =3D=3D GPDS_OK) {
+		DBG("Detached");
+		goto out;
+	}
+
+error:
+
+	if (cbd) {
+		cb =3D cbd->cb;
+		gprs =3D cbd->data;
+		gd =3D ofono_gprs_get_data(gprs);
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+	}
+
+	if (gd) {
+		gd->cbd =3D NULL;
+		ofono_gprs_set_data(gprs, gd);
+	}
+
+	g_free(cbd);
+out:
+	return TRUE;
+}
+
+static GIsiRequest *attach_request_make(GIsiClient *client, void *data)
+{
+	const unsigned char msg[] =3D {
+		GPDS_ATTACH_REQ,
+		GPDS_FOLLOW_OFF
+	};
+	DBG("");
+
+	return g_isi_request_make(client, msg, sizeof(msg), GPDS_TIMEOUT,
+				  attach_resp_cb, data);
+}
+
+static GIsiRequest *detach_request_make(GIsiClient *client, void *data)
+{
+	const unsigned char msg[] =3D {
+		GPDS_DETACH_REQ,
+		0x00,   /* filler */
+		0x00    /* sub-blocks */
+	};
+	DBG("");
+
+	return g_isi_request_make(client, msg, sizeof(msg), GPDS_TIMEOUT,
+				  detach_resp_cb, data);
+}
+
+static void isi_gprs_set_attached(struct ofono_gprs *gprs, int attached,
+				  ofono_gprs_cb_t cb, void *data)
+{
+	struct gprs_data *gd =3D ofono_gprs_get_data(gprs);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(NULL, cb, data);
+	GIsiRequest *req;
+	DBG("");
+
+	if (!cbd || !gd)
+		goto error;
+
+	if (attached)
+		req =3D attach_request_make(gd->client, cbd);
+	else {
+		req =3D detach_request_make(gd->client, cbd);
+
+		if (req) {
+			gd->cbd =3D cbd;
+			ofono_gprs_set_data(gprs, gd);
+		}
+	}
+
+	if (req)
+		return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, data);
+	g_free(cbd);
+}
+
+static gboolean status_resp_cb(GIsiClient *client, const void *restrict da=
ta,
+			       size_t len, uint16_t object, void *opaque)
+{
+	const unsigned char *msg =3D data;
+	struct isi_cb_data *cbd =3D opaque;
+	ofono_gprs_status_cb_t cb =3D cbd->cb;
+	DBG("");
+
+	if (!msg) {
+		DBG("ISI client error: %d", g_isi_client_error(client));
+		goto error;
+	}
+
+	if (len < 2 || msg[0] !=3D GPDS_STATUS_RESP)
+		return FALSE;
+
+	DBG("Attach status: 0x%02"PRIx8"", msg[1]);
+	/*
+	 * Even though gprs status inside ofono can have several other
+	 * values gboolean value suits here since there is no way to
+	 * get other values than attached or detached from modem.
+	 */
+	CALLBACK_WITH_SUCCESS(cb, msg[1] =3D=3D GPDS_ATTACHED, cbd->data);
+	goto out;
+error:
+	CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
+out:
+	g_free(cbd);
+	return TRUE;
+}
+
+static void isi_gprs_attached_status(struct ofono_gprs *gprs,
+				     ofono_gprs_status_cb_t cb,
+				     void *data)
+{
+	struct gprs_data *gd =3D ofono_gprs_get_data(gprs);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(NULL, cb, data);
+	const unsigned char msg[] =3D {
+		GPDS_STATUS_REQ,
+	};
+	DBG("");
+
+	if (!cbd || !gd)
+		goto error;
+
+	if (g_isi_request_make(gd->client, msg, sizeof(msg), GPDS_TIMEOUT,
+			       status_resp_cb, cbd))
+		return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, -1, data);
+	g_free(cbd);
+}
+
+static struct ofono_gprs_driver driver =3D {
+	.name                   =3D "isimodem25",
+	.probe                  =3D isi_gprs_probe,
+	.remove                 =3D isi_gprs_remove,
+	.set_attached           =3D isi_gprs_set_attached,
+	.attached_status        =3D isi_gprs_attached_status,
+};
+
+void isi_gprs_init(void)
+{
+	DBG("");
+	ofono_gprs_driver_register(&driver);
+}
+
+void isi_gprs_exit(void)
+{
+	DBG("");
+	ofono_gprs_driver_unregister(&driver);
+}
diff --git a/drivers/isimodem2.5/gpds.h b/drivers/isimodem2.5/gpds.h
new file mode 100644
index 0000000..67980d7
--- /dev/null
+++ b/drivers/isimodem2.5/gpds.h
@@ -0,0 +1,295 @@
+/*
+ * This file is part of oFono - Open Source Telephony
+ *
+ * Copyright (C) 2010 Nokia Corporation and/or its subsidary(-ies).
+ * Copyright (C) ST-Ericsson SA 2010.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ *
+ */
+
+#ifndef __ISIMODEM25_GPDS_H
+#define __ISIMODEM25_GPDS_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <gisi/client.h>
+
+#define PN_GPDS				0x31
+#define GPDS_MAX_CONTEXT_COUNT		11
+#define GPDS_CID_VOID			0xFF
+#define GPDS_MAX_APN_STRING_SIZE	0x64
+#define GPDS_MAX_USERNAME_SIZE		0x35
+#define GPDS_MAX_PASSWORD_SIZE		0x35
+
+#define STATIC_IP_NETMASK "255.255.255.255"
+
+struct gprs_data {
+	GIsiClient *client;
+	struct isi_cb_data *cbd;
+};
+
+enum gpds_message_id {
+	GPDS_LL_CONFIGURE_REQ =3D			0x00,
+	GPDS_LL_CONFIGURE_RESP =3D		0x01,
+	GPDS_CONTEXT_ID_CREATE_REQ =3D		0x02,
+	GPDS_CONTEXT_ID_CREATE_RESP =3D		0x03,
+	GPDS_CONTEXT_ID_CREATE_IND =3D		0x04,
+	GPDS_CONTEXT_ID_DELETE_IND =3D		0x05,
+	GPDS_CONTEXT_CONFIGURE_REQ =3D		0x06,
+	GPDS_CONTEXT_CONFIGURE_RESP =3D		0x07,
+	GPDS_CONTEXT_ACTIVATE_REQ =3D		0x08,
+	GPDS_CONTEXT_ACTIVATE_RESP =3D		0x09,
+	GPDS_CONTEXT_ACTIVATE_IND =3D		0x0A,
+	GPDS_CONTEXT_DEACTIVATE_REQ =3D		0x0B,
+	GPDS_CONTEXT_DEACTIVATE_RESP =3D		0x0C,
+	GPDS_CONTEXT_DEACTIVATE_IND =3D		0x0D,
+	GPDS_CONTEXT_MWI_ACT_REQUEST_IND =3D	0x0E,
+	GPDS_CONTEXT_NWI_ACT_REJECT_REQ =3D	0x0F,
+	GPDS_CONTEXT_NWI_ACT_REJECT_RESP =3D	0x10,
+	GPDS_CONFIGURE_REQ =3D			0x11,
+	GPDS_CONFIGURE_RESP =3D			0x12,
+	GPDS_ATTACH_REQ =3D			0x13,
+	GPDS_ATTACH_RESP =3D			0x14,
+	GPDS_ATTACH_IND =3D			0x15,
+	GPDS_DETACH_REQ =3D			0x16,
+	GPDS_DETACH_RESP =3D			0x17,
+	GPDS_DETACH_IND =3D			0x18,
+	GPDS_STATUS_REQ =3D			0x19,
+	GPDS_STATUS_RESP =3D			0x1A,
+	GPDS_SMS_PDU_SEND_REQ =3D			0x1B,
+	GPDS_SMS_PDU_SEND_RESP =3D		0x1C,
+	GPDS_SMS_PDU_RECEIVE_IND =3D		0x1D,
+	GPDS_TRANSFER_STATUS_IND =3D		0x1E,
+	GPDS_CONTEXT_ACTIVATE_FAIL_IND =3D	0x1F,
+	GPDS_LL_BIND_REQ =3D			0x20,
+	GPDS_LL_BIND_RESP =3D			0x21,
+	GPDS_CONTEXT_STATUS_REQ =3D		0x22,
+	GPDS_CONTEXT_STATUS_RESP =3D		0x23,
+	GPDS_CONTEXT_STATUS_IND =3D		0x24,
+	GPDS_CONTEXT_ACTIVATING_IND =3D		0x25,
+	GPDS_CONTEXT_MODIFY_REQ =3D		0x2A,
+	GPDS_CONTEXT_MODIFY_RESP =3D		0x2B,
+	GPDS_CONTEXT_MODIFY_IND =3D		0x2C,
+	GPDS_ATTACH_FAIL_IND =3D			0x2D,
+	GPDS_CONTEXT_DEACTIVATING_IND =3D		0x2F,
+	GPDS_CONFIGURATION_INFO_REQ =3D		0x30,
+	GPDS_CONFIGURATION_INFO_RESP =3D		0x31,
+	GPDS_CONFIGURATION_INFO_IND =3D		0x32,
+	GPDS_CONTEXT_AUTH_REQ =3D			0x33,
+	GPDS_CONTEXT_AUTH_RESP =3D		0x34,
+	GPDS_TEST_MODE_REQ =3D			0x35,
+	GPDS_TEST_MODE_RESP =3D			0x36,
+	GPDS_RADIO_ACTIVITY_IND =3D		0x37,
+	GPDS_FORCED_READY_STATE_REQ =3D		0x38,
+	GPDS_FORCED_READY_STATE_RESP =3D		0x39,
+	GPDS_CONTEXTS_CLEAR_REQ =3D		0x3A,
+	GPDS_CONTEXTS_CLEAR_RESP =3D		0x3B,
+	GPDS_MBMS_SERVICE_SELECTION_REQ =3D	0x3C,
+	GPDS_MBMS_SERVICE_SELECTION_RESP =3D	0x3D,
+	GPDS_MBMS_STATUS_IND =3D			0x3E,
+	GPDS_MBMS_CONTEXT_CREATE_REQ =3D		0x3F,
+	GPDS_MBMS_CONTEXT_CREATE_RESP =3D		0x40,
+	GPDS_MBMS_CONTEXT_ACTIVATE_REQ =3D	0x41,
+	GPDS_MBMS_CONTEXT_ACTIVATE_RESP =3D	0x42,
+	GPDS_MBMS_CONTEXT_DELETE_REQ =3D		0x43,
+	GPDS_MBMS_CONTEXT_DELETE_RESP =3D		0x44,
+	GPDS_MBMS_CONTEXT_DELETE_IND =3D		0x45,
+	GPDS_MBMS_SERVICE_SELECTION_IND =3D	0x46,
+	GPDS_MBMS_SERVICE_AVAILABLE_IND =3D	0x47,
+	GPDS_TEST_REQ =3D				0x48,
+	GPDS_TEST_RESP =3D			0x49
+};
+
+enum gpds_subblock {
+	GPDS_COMP_INFO =3D			0x00,
+	GPDS_QOS_REQ_INFO =3D			0x01,
+	GPDS_QOS_MIN_INFO =3D			0x02,
+	GPDS_QOS_NEG_INFO =3D			0x03,
+	GPDS_PDP_ADDRESS_INFO =3D			0x04,
+	GPDS_APN_INFO =3D				0x05,
+	GPDS_QOS99_REQ_INFO =3D			0x06,
+	GPDS_QOS99_MIN_INFO =3D			0x07,
+	GPDS_QOS99_NEG_INFO =3D			0x08,
+	GPDS_TFT_INFO =3D				0x09,
+	GPDS_TFT_FILTER_INFO =3D			0x0A,
+	GPDS_USERNAME_INFO =3D			0x0B,
+	GPDS_PASSWORD_INFO =3D			0x0C,
+	GPDS_PDNS_ADDRESS_INFO =3D		0x0D,
+	GPDS_SDNS_ADDRESS_INFO =3D		0x0E,
+	GPDS_CHALLENGE_INFO =3D			0x0F,
+	GPDS_DNS_ADDRESS_REQ_INFO =3D		0x90,
+};
+
+enum gpds_status {
+	GPDS_ERROR =3D				0x00,
+	GPDS_OK =3D				0x01,
+	GPDS_FAIL =3D				0x02
+};
+
+enum gpds_isi_cause {
+	GPDS_CAUSE_UNKNOWN =3D			0x00,
+	GPDS_CAUSE_IMSI =3D			0x02,
+	GPDS_CAUSE_MS_ILLEGAL =3D			0x03,
+	GPDS_CAUSE_ME_ILLEGAL =3D			0x06,
+	GPDS_CAUSE_GPRS_NOT_ALLOWED =3D		0x07,
+	GPDS_NOT_ALLOWED =3D			0x08,
+	GPDS_CAUSE_MS_IDENTITY =3D		0x09,
+	GPDS_CAUSE_DETACH =3D			0x0A,
+	GPDS_PLMN_NOT_ALLOWED =3D			0x0B,
+	GPDS_LA_NOT_ALLOWED =3D			0x0C,
+	GPDS_ROAMING_NOT_ALLOWED =3D		0x0D,
+	GPDS_CAUSE_GPRS_NOT_ALLOWED_IN_PLMN =3D	0x0E,
+	GPDS_CAUSE_NO_SUITABLE_CELLS_IN_LA =3D	0x0F,
+	GPDS_CAUSE_MSC_NOT_REACH =3D		0x10,
+	GPDS_CAUSE_PLMN_FAIL =3D			0x11,
+	GPDS_CAUSE_NETWORK_CONGESTION =3D		0x16,
+	GPDS_CAUSE_LLC_SNDCP_FAILURE =3D		0x19,
+	GPDS_CAUSE_RESOURCE_INSUFF =3D		0x1A,
+	GPDS_CAUSE_APN =3D			0x1B,
+	GPDS_CAUSE_PDP_UNKNOWN =3D		0x1C,
+	GPDS_CAUSE_AUTHENTICATION =3D		0x1D,
+	GPDS_CAUSE_ACT_REJECT_GGSN =3D		0x1E,
+	GPDS_CAUSE_ACT_REJECT =3D			0x1F,
+	GPDS_CAUSE_SERV_OPT_NOT_SUPPORTED =3D	0x20,
+	GPDS_CAUSE_SERV_OPT_NOT_SUBSCRIBED =3D	0x21,
+	GPDS_CAUSE_SERV_OPT_OUT_OF_ORDER =3D	0x22,
+	GPDS_CAUSE_NSAPI_ALREADY_USED =3D		0x23,
+	GPDS_CAUSE_DEACT_REGULAR =3D		0x24,
+	GPDS_CAUSE_QOS =3D			0x25,
+	GPDS_CAUSE_NETWORK_FAIL =3D		0x26,
+	GPDS_CAUSE_REACTIVATION_REQ =3D		0x27,
+	GPDS_CAUSE_FEAT_NOT_SUPPORTED =3D		0x28,
+	GPDS_CAUSE_TFT_SEMANTIC_ERROR =3D		0x29,
+	GPDS_CAUSE_TFT_SYNTAX_ERROR =3D		0x2A,
+	GPDS_CAUSE_CONTEXT_UNKNOWN =3D		0x2B,
+	GPDS_CAUSE_FILTER_SEMANTIC_ERROR =3D	0x2C,
+	GPDS_CAUSE_FILTER_SYNTAX_ERROR =3D	0x2D,
+	GPDS_CAUSE_CONT_WITHOUT_TFT =3D		0x2E,
+	GPDS_CAUSE_MULTICAST_MEMBERSHIP_TIMEOUT =3D 0x2F,
+	GPDS_CAUSE_INVALID_MANDATORY_INFO =3D	0x60,
+	GPDS_CAUSE_MSG_TYPE_NON_EXISTENTOR_NOT_IMPLTD =3D	0x61,
+	GPDS_CAUSE_MSG_TYPE_NOT_COMPATIBLE_WITH_PROTOCOL_STATE =3D 0x62,
+	GPDS_CAUSE_IE_NON_EXISTENT_OR_NOT_IMPLEMENTED =3D	0x63,
+	GPDS_CAUSE_CONDITIONAL_IE_ERROR =3D	0x64,
+	GPDS_CUASEMSG_NOT_COMPATIBLE_WITH_PROTOCOL_STATE =3D 0x65,
+	GPDS_CAUSE_UNSPECIFIED =3D		0x6F,
+	GPDS_CAUSE_APN_INCOMPATIBLE_WITH_CURR_CTXT =3D 0x70,
+	GPDS_CAUSE_FDN =3D			0xA0,
+	GPDS_CAUSE_USER_ABORT =3D			0xA1,
+	GPDS_CAUSE_CS_INACTIVE =3D		0xA2,
+	GPDS_CAUSE_CSD_OVERRIDE =3D		0xA3,
+	GPDS_CAUSE_APN_CONTROL =3D		0xA4,
+	GPDS_CAUSE_CALL_CONTROL =3D		0xA5,
+	GPDS_CAUSE_TEMPERATURE_LIMIT =3D		0xA6,
+	GPDS_CAUSE_RETRY_COUNTER_EXPIRED =3D	0xC8,
+	GPDS_CAUSE_NO_CONNECTION =3D		0xC9,
+	GPDS_CAUSE_DETACHED =3D			0xF5,
+	GPDS_CAUSE_NO_SERVICE_POWER_SAVE =3D	0xF7,
+	GPDS_CAUSE_SIM_REMOVED =3D		0xF9,
+	GPDS_CAUSE_POWER_OFF =3D			0xFA,
+	GPDS_CAUSE_LAI_FORBIDDEN_NATIONAL_ROAM_LIST =3D 0xFB,
+	GPDS_CAUSE_LAI_FORBIDDEN_REG_PROVISION_LIST =3D 0xFC,
+	GPDS_CAUSE_ACCESS_BARRED =3D		0xFD,
+	GPDS_CAUSE_FATAL_FAILURE =3D		0xFE,
+	GPDS_CAUSE_AUT_FAILURE =3D		0xFF,
+};
+
+enum gpds_context_type {
+	GPDS_CONT_TYPE_NORMAL =3D			0x00,
+	GPDS_CONT_TYPE_NWI =3D			0x01,
+	GPDS_CONT_TYPE_SEC =3D			0x02
+};
+
+enum gpds_ppp_mode {
+	GPDS_LL_FRAMED_PPP =3D			0x00,
+	GPDS_LL_NONFRAMED_PPP =3D			0x01,
+	GPDS_LL_PLAIN =3D				0x02
+};
+
+enum gpds_pdp_type {
+	GPDS_PDP_TYPE_PPP =3D			0x01,
+	GPDS_PDP_TYPE_IPV4 =3D			0x21,
+	GPDS_PDP_TYPE_IPV6 =3D			0x57,
+	GPDS_PDP_TYPE_DEFAULT =3D			0xFF
+};
+
+enum gpds_request_mode {
+	GPDS_FOLLOW_OFF =3D			0x00,
+	GPDS_FOLLOW_ON =3D			0x01
+};
+
+enum gpds_attach_status {
+	GPDS_DETACHED =3D				0x00,
+	GPDS_ATTACHED =3D				0x01
+};
+
+enum gpds_attach_type {
+	GPDS_ATTACH_TYPE_GPRS =3D			0x01
+};
+
+enum gpds_detach_type {
+	GPDS_DETACH_TYPE_GPRS_MO =3D		0x01
+};
+
+enum gpds_transfer_status {
+	GPDS_TRANSFER_NOT_AVAIL =3D		0x00,
+	GPDS_TRANSFER_AVAIL =3D			0x01
+};
+
+enum gpds_transfer_cause {
+	GPDS_TRANSFER_CAUSE_ATTACHED =3D		0x02,
+	GPDS_TRANSFER_CAUSE_DETACHED =3D		0x03,
+	GPDS_TRANSFER_CAUSE_RESUMED =3D		0x04,
+	GPDS_TRANSFER_CAUSE_SUSPENDED_NO_COVERAGE =3D 0x05,
+	GPDS_TRANSFER_CAUSE_SUSPENDED_CALL_SMS =3D 0x07,
+	GPDS_TRANSFER_CAUSE_SUSPENDED_CALL =3D	0x08,
+	GPDS_TRANSFER_CAUSE_SUSPENDED_RAU =3D	0x09,
+	GPDS_TRANSFER_CAUSE_SUSPENDED_LU =3D	0x0A,
+	GPDS_TRANSFER_CAUSE_DSAC_RESTRICTION =3D	0x0B
+};
+
+enum gpds_attach_mode {
+	GPDS_ATTACH_MODE_MANUAL =3D		0x00,
+	GPDS_ATTACH_MODE_AUTOMATIC =3D		0x01,
+	GPDS_ATTACH_MODE_DEFAULT =3D		0xFF
+};
+
+enum gpds_mt_act_mode {
+	GPDS_MT_ACT_MODE_REJECT =3D		0x00,
+	GPDS_MT_ACT_MODE_ACCEPT =3D		0x01,
+	GPDS_MT_ACT_MODE_DEFAULT =3D		0xFF
+};
+
+enum gpds_classc_mode {
+	GPDS_CLASSC_MODE_GPRS =3D			0x00,
+	GPDS_CLASSC_MODE_GSM =3D			0x01,
+	GPDS_CLASSC_MODE_DEFAULT =3D		0xFF
+};
+
+enum gpds_aol_context {
+	GPDS_AOL_CTX_NOT_ACTIVE =3D		0x00,
+	GPDS_AOL_CTX_HPLMN_ACTIVE =3D		0x01,
+	GPDS_AOL_CTX_VPLMN_ACTIVE =3D		0x02,
+	GPDS_AOL_CTX_ACTIVE =3D			0x03,
+	GPDS_AOL_CTX_DEFAULT =3D			0xFF
+};
+
+#ifdef __cplusplus
+};
+#endif
+
+#endif /* !__ISIMODEM25_GPDS_H */
diff --git a/drivers/isimodem2.5/gss.h b/drivers/isimodem2.5/gss.h
new file mode 100644
index 0000000..2c7fc68
--- /dev/null
+++ b/drivers/isimodem2.5/gss.h
@@ -0,0 +1,84 @@
+/*
+ * This file is part of oFono - Open Source Telephony
+ *
+ * Copyright (C) 2010 Nokia Corporation and/or its subsidiary(-ies).
+ * Copyright (C) ST-Ericsson SA 2010.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#ifndef __ISIMODEM25_GSS_H
+#define __ISIMODEM25_GSS_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#define PN_GSS 0x32
+
+enum gss_message_id {
+	GSS_CS_SERVICE_REQ =3D			0x00,
+	GSS_CS_SERVICE_RESP =3D			0x01,
+	GSS_CS_SERVICE_FAIL_RESP =3D		0x02,
+	GSS_CS_IND =3D				0x03,
+	GSS_POWER_CLASS_IND =3D			0x0A,
+	GSS_HSXPA_USER_SETTING_WRITE_REQ =3D	0x0F,
+	GSS_HSXPA_USER_SETTING_WRITE_RESP =3D	0x10,
+	GSS_HSXPA_USER_SETTING_IND =3D		0x11,
+	GSS_HSXPA_USER_SETTING_READ_REQ =3D	0x12,
+	GSS_HSXPA_USER_SETTING_READ_RESP =3D	0x13,
+	GSS_SELECTED_RAT_IND =3D			0x14,
+	GSS_UMA_PREF_MODE_IND =3D			0x15,
+	GSS_HAC_MODE_WRITE_REQ =3D		0x17,
+	GSS_HAC_MODE_WRITE_RESP =3D		0x18,
+	GSS_ENV_INFO_REQ =3D			0x19,
+	GSS_ENV_INFO_RESP =3D			0x20,
+	GSS_ENV_INFO_IND =3D			0x21
+};
+
+enum gss_subblock {
+	GSS_CS_LOCAL_INFO =3D			0x01,
+	GSS_POWER_CLASS =3D			0x02,
+	GSS_CS_STATUS =3D				0x00,
+	GSS_CELL_INFO =3D				0x03,
+	GSS_LONG_CELL_INFO =3D			0x11,
+	GSS_BAND_INFO =3D				0x04,
+	GSS_RAT_INFO =3D				0x0B,
+	GSS_ATK_TIMING_ADVANCE =3D		0x0C,
+	GSS_UMA_PREF_MODE_INFO =3D		0x0D,
+	GSS_PROV_INFO_SB_IDS =3D			0x10,
+	GSS_SGW_INFO =3D				0x0E,
+	GSS_UNC_INFO =3D				0x0F,
+	GSS_REL_SIGNAL_LEVEL_INFO =3D		0x14,
+	GSS_THRESHOLD_INFO =3D			0x15
+};
+
+enum gss_selection_mode {
+	GSS_GSM_RAT =3D				0x01,
+	GSS_UMTS_RAT =3D				0x02,
+	GSS_DUAL_RAT =3D				0x03,
+};
+
+enum gss_operation {
+	GSS_SELECTED_RAT_WRITE =3D		0x0E,
+	GSS_SELECTED_RAT_READ =3D			0x9C
+};
+
+#ifdef __cplusplus
+};
+#endif
+
+#endif /* !__ISIMODEM25_GSS_H */
diff --git a/drivers/isimodem2.5/info.h b/drivers/isimodem2.5/info.h
new file mode 100644
index 0000000..58dd118
--- /dev/null
+++ b/drivers/isimodem2.5/info.h
@@ -0,0 +1,53 @@
+/*
+ * This file is part of oFono - Open Source Telephony
+ *
+ * Copyright (C) 2009-2010 Nokia Corporation and/or its subsidiary(-ies).
+ * Copyright (C) ST-Ericsson SA 2010.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#ifndef __ISIMODEM25_INFO_H
+#define __ISIMODEM25_INFO_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#define PN_MODEM_INFO 0xC5
+
+	enum info_isi_cause {
+		M_INFO_OK =3D 0x00
+	};
+
+	enum info_message_id {
+		M_INFO_VERSION_READ_REQ =3D 0x00,
+		M_INFO_VERSION_READ_RESP =3D 0x01
+	};
+
+	enum info_subblock {
+		M_INFO_SB_MODEMSW_VERSION =3D 0x00
+	};
+
+	enum info_version_targets {
+		M_INFO_MODEMSW =3D 0x00000001
+	};
+
+#ifdef __cplusplus
+};
+#endif
+
+#endif /* !__ISIMODEM25_INFO_H */
diff --git a/drivers/isimodem2.5/isimodem.c b/drivers/isimodem2.5/isimodem.c
new file mode 100644
index 0000000..fac4d80
--- /dev/null
+++ b/drivers/isimodem2.5/isimodem.c
@@ -0,0 +1,534 @@
+/*
+ * This file is part of oFono - Open Source Telephony
+ *
+ * Copyright (C) 2009 Nokia Corporation and/or its subsidiary(-ies).
+ * Copyright (C) ST-Ericsson SA 2010.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdio.h>
+#include <errno.h>
+#include <stdlib.h>
+#include <string.h>
+#include <glib.h>
+
+#define OFONO_API_SUBJECT_TO_CHANGE
+#include <ofono/modem.h>
+#include <gisi/client.h>
+#include <gisi/netlink.h>
+#include <ofono/log.h>
+#include <ofono/call-forwarding.h>
+#include <ofono/call-settings.h>
+#include <ofono/call-barring.h>
+#include <ofono/call-meter.h>
+#include <ofono/devinfo.h>
+#include <ofono/gprs.h>
+#include <ofono/gprs-context.h>
+#include <ofono/radio-settings.h>
+#include <ofono/phonebook.h>
+#include <ofono/plugin.h>
+#include <ofono/netreg.h>
+#include <ofono/sms.h>
+#include <ofono/cbs.h>
+#include <ofono/sim.h>
+#include <ofono/ssn.h>
+#include <ofono/ussd.h>
+#include <ofono/voicecall.h>
+
+#include "debug.h"
+#include "mce.h"
+#include "isimodem.h"
+#include "isiutil.h"
+#include "timeout.h"
+
+struct isi_data {
+	struct ofono_modem *modem;
+	char const *ifname;
+	GIsiModem *idx;
+	GIsiClient *client;
+	GPhonetNetlink *link;
+	unsigned interval;
+	int reported;
+	int iface_up;
+};
+
+static GPhonetNetlink *link;
+static GSList *g_modems;
+
+static struct isi_data *find_modem_by_idx(GSList *modems, GIsiModem *idx)
+{
+	GSList *m =3D NULL;
+
+	for (m =3D g_modems; m; m =3D m->next) {
+		struct isi_data *isi =3D m->data;
+
+		if (isi->idx =3D=3D idx)
+			return isi;
+	}
+
+	return NULL;
+}
+
+static void mce_state_cb(GIsiClient *client, const void *restrict data,
+				size_t len, uint16_t object, void *opaque)
+{
+	const unsigned char *msg =3D data;
+	struct isi_data *isi =3D opaque;
+	DBG("");
+
+	if (!msg) {
+		DBG("ISI client error: %d", g_isi_client_error(client));
+		return;
+	}
+
+	DBG("%s, state %s, action %d",
+		mce_message_id_name(msg[0]),
+			mce_modem_state_name(msg[1]), msg[2]);
+
+	if (len < 3 || msg[0] !=3D MCE_MODEM_STATE_IND)
+		return;
+
+	DBG("ofono_modem_set_powered-> %d", (msg[1] !=3D MCE_POWER_OFF));
+	ofono_modem_set_powered(isi->modem, (msg[1] !=3D MCE_POWER_OFF));
+	DBG("<-ofono_modem_set_powered");
+}
+
+static gboolean mce_modem_state_query_cb(GIsiClient *client,
+						const void *restrict data,
+						size_t len, uint16_t object,
+						void *opaque)
+{
+	const unsigned char *msg =3D data;
+	struct isi_data *isi =3D opaque;
+	DBG("");
+
+	if (!msg) {
+		DBG("ISI client error: %d", g_isi_client_error(client));
+		return TRUE;
+	}
+
+	DBG("%s, current %s, target %s", mce_message_id_name(msg[0]),
+		mce_modem_state_name(msg[1]), mce_modem_state_name(msg[2]));
+
+	if (len < 3 || msg[0] !=3D MCE_MODEM_STATE_QUERY_RESP)
+		return FALSE;
+
+	DBG("ofono_modem_set_powered-> %d", (msg[1] !=3D MCE_POWER_OFF));
+	ofono_modem_set_powered(isi->modem, (msg[1] !=3D MCE_POWER_OFF));
+	DBG("<-ofono_modem_set_powered");
+	return TRUE;
+}
+
+
+
+static gboolean mce_rf_state_query_cb(GIsiClient *client,
+					const void *restrict data,
+					size_t len, uint16_t object,
+					void *opaque)
+{
+	const unsigned char *msg =3D data;
+	DBG("");
+
+	if (!msg) {
+		DBG("ISI client error: %d", g_isi_client_error(client));
+		return TRUE;
+	}
+
+	DBG("%s, current=3D%d, target=3D%d",
+		mce_message_id_name(msg[0]), msg[1], msg[2]);
+
+	if (len < 3 || msg[0] !=3D MCE_RF_STATE_QUERY_RESP)
+		return FALSE;
+
+	/* There is no proper way to indicate RF status to oFono !! */
+	return TRUE;
+}
+
+static void reachable_cb(GIsiClient *client, gboolean alive, uint16_t obje=
ct,
+				void *opaque)
+{
+	const unsigned char msg[] =3D {
+		MCE_MODEM_STATE_QUERY_REQ,
+		0x00, 0x00 /* Filler */
+	};
+	DBG("");
+
+	if (!alive) {
+		DBG("Unable to bootstrap mce driver");
+		return;
+	}
+
+	DBG("Resource %s (v%03d.%03d) reachable",
+		pn_resource_name(g_isi_client_resource(client)),
+		g_isi_version_major(client),
+		g_isi_version_minor(client));
+	g_isi_subscribe(client, MCE_MODEM_STATE_IND, mce_state_cb, opaque);
+	g_isi_request_make(client, msg, sizeof(msg), MCE_TIMEOUT,
+			   mce_modem_state_query_cb, opaque);
+}
+
+static void phonet_status_cb(GIsiModem *idx,
+				GPhonetLinkState st,
+				char const *ifname,
+				void *data)
+{
+	struct ofono_modem *modem =3D data;
+	struct isi_data *isi =3D ofono_modem_get_data(modem);
+
+	if (!isi)
+		return;
+
+	DBG("Link %s (%u) is %s",
+		isi->ifname, g_isi_modem_index(isi->idx),
+		st =3D=3D PN_LINK_REMOVED ? "removed" :
+		st =3D=3D PN_LINK_DOWN ? "down" : "up");
+	isi->iface_up =3D st =3D=3D PN_LINK_UP;
+
+	if (st =3D=3D PN_LINK_UP)
+		g_isi_verify(isi->client, reachable_cb, isi);
+	else if (st =3D=3D PN_LINK_DOWN)
+		return;
+	else if (st =3D=3D PN_LINK_REMOVED)
+		ofono_modem_remove(modem);
+}
+
+
+static void netlink_status_cb(GIsiModem *idx,
+				GPhonetLinkState st,
+				char const ifname[],
+				void *data)/* data not used anywhere...*/
+
+{
+	struct isi_data *isi =3D find_modem_by_idx(g_modems, idx);
+	DBG(" Link state=3D %d", st);
+
+	if (st =3D=3D PN_LINK_UP) {
+		if (isi) {
+			DBG("Modem already registered: (0x%02x)",
+				g_isi_modem_index(idx));
+			return;
+		}
+
+		isi =3D g_new0(struct isi_data, 1);
+
+		if (!isi)
+			return;
+
+		isi->modem =3D ofono_modem_create(NULL, "isimodem25");
+
+		if (!isi->modem) {
+			g_free(isi);
+			return;
+		}
+
+		isi->idx =3D idx;
+#ifdef STE_8500_PHONET
+		verify_link_up(TRUE);
+#endif
+		ofono_modem_set_string(isi->modem, "Interface", ifname);
+		g_modems =3D g_slist_prepend(g_modems, isi);
+		ofono_modem_set_data(isi->modem, isi);
+		ofono_modem_register(isi->modem);
+		DBG("Done regging modem");
+	} else {
+		GPhonetNetlink *netlink;
+
+		if (!isi) {
+			DBG("Unknown modem: (0x%02x)",
+				g_isi_modem_index(idx));
+			return;
+		}
+
+#ifdef STE_8500_PHONET
+		verify_link_up(FALSE);
+#endif
+		netlink =3D g_pn_netlink_by_modem(idx);
+		g_pn_netlink_stop(netlink);
+		g_modems =3D g_slist_remove(g_modems, isi);
+		g_isi_client_destroy(isi->client);
+		DBG("Now removing modem");
+		ofono_modem_remove(isi->modem);
+		g_free(isi);
+		isi =3D NULL;
+	}
+}
+
+static gboolean mce_rf_state_set_cb(GIsiClient *client,
+					const void *restrict data,
+					size_t len,
+					uint16_t object,
+					void *opaque)
+{
+	const unsigned char *msg =3D data;
+	struct isi_cb_data *cbd =3D opaque;
+	ofono_modem_online_cb_t cb =3D cbd->cb;
+
+	if (!msg) {
+		DBG("ISI client error: %d", g_isi_client_error(client));
+		return TRUE;
+	}
+
+	DBG("%s, status %s",
+		mce_message_id_name(msg[0]), mce_isi_cause_name(msg[1]));
+
+	if (len < 2 || msg[0] !=3D MCE_RF_STATE_RESP)
+		goto error;
+
+	if (msg[1] !=3D MCE_OK && msg[1] !=3D MCE_ALREADY_ACTIVE)
+		goto error;
+
+	CALLBACK_WITH_SUCCESS(cb, cbd->data);
+	goto out;
+error:
+	DBG("Error setting RF on/off");
+	CALLBACK_WITH_FAILURE(cb, cbd->data);
+out:
+	g_free(cbd);
+	return TRUE;
+}
+
+static int isi_modem_probe(struct ofono_modem *modem)
+{
+	struct isi_data *isi;
+	char const *ifname =3D ofono_modem_get_string(modem, "Interface");
+	GIsiModem *idx;
+	GPhonetNetlink *link;
+
+	if (ifname =3D=3D NULL)
+		return -EINVAL;
+
+	DBG("(%p) with %s", modem, ifname);
+	idx =3D g_isi_modem_by_name(ifname);
+
+	if (idx =3D=3D NULL) {
+		DBG("Interface=3D%s: %s", ifname, strerror(errno));
+		return -errno;
+	}
+
+	link =3D g_pn_netlink_start(idx, phonet_status_cb, modem);
+
+	if (!link) {
+		DBG("%s: %s", ifname, strerror(errno));
+		return -errno;
+	}
+
+	isi =3D g_new0(struct isi_data, 1);
+
+	if (isi =3D=3D NULL)
+		return -ENOMEM;
+
+	ofono_modem_set_data(isi->modem =3D modem, isi);
+	isi->idx =3D idx;
+	isi->ifname =3D ifname;
+	isi->link =3D link;
+	isi->client =3D g_isi_client_create(isi->idx, PN_MODEM_MCE);
+	return 0;
+}
+
+static void isi_modem_remove(struct ofono_modem *modem)
+{
+	struct isi_data *isi =3D ofono_modem_get_data(modem);
+	DBG("");
+
+	if (!isi)
+		return;
+
+	ofono_modem_set_data(modem, NULL);
+	g_isi_client_destroy(isi->client);
+	g_free(isi);
+}
+
+static int isi_modem_enable(struct ofono_modem *modem)
+{
+	struct isi_data *isi =3D ofono_modem_get_data(modem);
+	/*
+	 * Modem boots automatically to MCE_POWER_OFF state
+	 * and then moves automatically to MCE_NORMAL or
+	 * MCE_LOCAL mode depending about the configuration.
+	 * I think only thing to do is to listen the state
+	 * indication.
+	 */
+	const unsigned char modem_msg[] =3D {
+		MCE_MODEM_STATE_QUERY_REQ,
+		0x00, 0x00 /* Filler */
+	};
+	const unsigned char rf_msg[] =3D {
+		MCE_RF_STATE_QUERY_REQ,
+		0x00, 0x00 /* Filler */
+	};
+	DBG("");
+
+	g_isi_request_make(isi->client, modem_msg, sizeof(modem_msg),
+				MCE_TIMEOUT,
+				mce_modem_state_query_cb, isi);
+
+	g_isi_request_make(isi->client, rf_msg, sizeof(rf_msg), MCE_TIMEOUT,
+			   mce_rf_state_query_cb, modem);
+	g_isi_subscribe(isi->client, MCE_MODEM_STATE_IND, mce_state_cb, isi);
+	return 0;
+}
+
+static int isi_modem_disable(struct ofono_modem *modem)
+{
+	DBG("");
+	return 0;
+}
+
+static void isi_modem_set_online(struct ofono_modem *modem, ofono_bool_t o=
nline,
+					ofono_modem_online_cb_t cb, void *data)
+{
+	struct isi_data *isi =3D ofono_modem_get_data(modem);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(isi, cb, data);
+	const unsigned char msg[] =3D {
+		MCE_RF_STATE_REQ,
+		online ? MCE_RF_ON : MCE_RF_OFF,
+		0x00    /* Filler */
+	};
+	DBG("");
+
+	if (!cbd)
+		goto error;
+
+	if (g_isi_request_make(isi->client, msg, sizeof(msg), MCE_TIMEOUT,
+				mce_rf_state_set_cb, cbd))
+		return;
+
+error:
+	DBG("Online/offline setting failed");
+	CALLBACK_WITH_FAILURE(cb, data);
+	g_free(cbd);
+}
+
+static void isi_modem_pre_sim(struct ofono_modem *modem)
+{
+	struct isi_data *isi =3D ofono_modem_get_data(modem);
+	DBG("(%p) with %s", modem, isi->ifname);
+	ofono_sim_create(isi->modem, 0, "isimodem25", isi->idx);
+	ofono_devinfo_create(isi->modem, 0, "isimodem25", isi->idx);
+	ofono_voicecall_create(isi->modem, 0, "isimodem25", isi->idx);
+}
+
+static void isi_modem_post_sim(struct ofono_modem *modem)
+{
+	struct isi_data *isi =3D ofono_modem_get_data(modem);
+	DBG("(%p) with %s", modem, isi->ifname);
+	ofono_phonebook_create(isi->modem, 0, "isimodem25", isi->idx);
+}
+
+static void isi_modem_post_online(struct ofono_modem *modem)
+{
+	struct isi_data *isi =3D ofono_modem_get_data(modem);
+	struct ofono_gprs *gprs;
+	struct ofono_gprs_context *gc;
+	DBG("(%p) with %s", modem, isi->ifname);
+	ofono_netreg_create(isi->modem, 0, "isimodem25", isi->idx);
+	ofono_sms_create(isi->modem, 0, "isimodem25", isi->idx);
+	ofono_cbs_create(isi->modem, 0, "isimodem25", isi->idx);
+	ofono_ssn_create(isi->modem, 0, "isimodem25", isi->idx);
+	ofono_ussd_create(isi->modem, 0, "isimodem25", isi->idx);
+	ofono_call_forwarding_create(isi->modem, 0, "isimodem25", isi->idx);
+	ofono_call_settings_create(isi->modem, 0, "isimodem25", isi->idx);
+	ofono_call_barring_create(isi->modem, 0, "isimodem25", isi->idx);
+	ofono_radio_settings_create(isi->modem, 0, "isimodem25", isi->idx);
+	gprs =3D ofono_gprs_create(isi->modem, 0, "isimodem25", isi->idx);
+	gc =3D ofono_gprs_context_create(isi->modem, 0, "isimodem25", isi->idx);
+
+	if (gprs && gc)
+		ofono_gprs_add_context(gprs, gc);
+	else
+		DBG("Failed to add context");
+}
+
+static struct ofono_modem_driver driver =3D {
+	.name =3D "isimodem25",
+	.probe =3D isi_modem_probe,
+	.remove =3D isi_modem_remove,
+	.enable =3D isi_modem_enable,
+	.disable =3D isi_modem_disable,
+	.set_online =3D isi_modem_set_online,
+	.pre_sim =3D isi_modem_pre_sim,
+	.post_sim =3D isi_modem_post_sim,
+	.post_online =3D isi_modem_post_online
+};
+
+static int isimodem_init(void)
+{
+	link =3D NULL;
+	g_modems =3D NULL;
+	DBG("");
+	g_pn_netlink_start(NULL, netlink_status_cb, NULL);
+	isi_devinfo_init();
+	isi_phonebook_init();
+	isi_netreg_init();
+	isi_voicecall_init();
+	isi_sms_init();
+	isi_cbs_init();
+	isi_sim_init();
+	isi_ssn_init();
+	isi_ussd_init();
+	isi_call_settings_init();
+	isi_call_barring_init();
+	isi_call_forwarding_init();
+	isi_radio_settings_init();
+	isi_gprs_init();
+	isi_gprs_context_init();
+	ofono_modem_driver_register(&driver);
+	return 0;
+}
+
+static void isimodem_exit(void)
+{
+	GSList *m;
+
+	for (m =3D g_modems; m; m =3D m->next) {
+		struct isi_data *isi =3D m->data;
+		ofono_modem_remove(isi->modem);
+		g_free(isi);
+	}
+
+	g_slist_free(g_modems);
+	g_modems =3D NULL;
+
+	if (link) {
+		g_pn_netlink_stop(link);
+		link =3D NULL;
+	}
+
+	ofono_modem_driver_unregister(&driver);
+	isi_devinfo_exit();
+	isi_phonebook_exit();
+	isi_netreg_exit();
+	isi_voicecall_exit();
+	isi_sms_exit();
+	isi_cbs_exit();
+	isi_sim_exit();
+	isi_ssn_exit();
+	isi_ussd_exit();
+	isi_call_settings_exit();
+	isi_call_barring_exit();
+	isi_call_forwarding_exit();
+	isi_radio_settings_exit();
+	isi_gprs_exit();
+	isi_gprs_context_exit();
+}
+
+OFONO_PLUGIN_DEFINE(isimodem25, "PhoNet / ISI modem 2.5 driver", VERSION,
+		    OFONO_PLUGIN_PRIORITY_DEFAULT, isimodem_init, isimodem_exit)
diff --git a/drivers/isimodem2.5/isimodem.h b/drivers/isimodem2.5/isimodem.h
new file mode 100644
index 0000000..4fdd2a8
--- /dev/null
+++ b/drivers/isimodem2.5/isimodem.h
@@ -0,0 +1,69 @@
+/*
+ * This file is part of oFono - Open Source Telephony
+ *
+ * Copyright (C) 2009 Nokia Corporation and/or its subsidiary(-ies).
+ * Copyright (C) ST-Ericsson SA 2010.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+extern void isi_phonebook_init();
+extern void isi_phonebook_exit();
+
+extern void isi_devinfo_init();
+extern void isi_devinfo_exit();
+
+extern void isi_netreg_init();
+extern void isi_netreg_exit();
+
+extern void isi_voicecall_init();
+extern void isi_voicecall_exit();
+
+extern void isi_sms_init();
+extern void isi_sms_exit();
+
+extern void isi_cbs_init();
+extern void isi_cbs_exit();
+
+extern void isi_sim_init();
+extern void isi_sim_exit();
+
+extern void isi_ussd_init();
+extern void isi_ussd_exit();
+
+extern void isi_ssn_init();
+extern void isi_ssn_exit();
+
+extern void isi_call_forwarding_init();
+extern void isi_call_forwarding_exit();
+
+extern void isi_call_settings_init();
+extern void isi_call_settings_exit();
+
+extern void isi_call_barring_init();
+extern void isi_call_barring_exit();
+
+extern void isi_call_meter_init();
+extern void isi_call_meter_exit();
+
+extern void isi_radio_settings_init();
+extern void isi_radio_settings_exit();
+
+extern void isi_gprs_init();
+extern void isi_gprs_exit();
+
+extern void isi_gprs_context_init();
+extern void isi_gprs_context_exit();
diff --git a/drivers/isimodem2.5/isiutil.h b/drivers/isimodem2.5/isiutil.h
new file mode 100644
index 0000000..dd5eed1
--- /dev/null
+++ b/drivers/isimodem2.5/isiutil.h
@@ -0,0 +1,64 @@
+/*
+ * This file is part of oFono - Open Source Telephony
+ *
+ * Copyright (C) 2009 Nokia Corporation and/or its subsidiary(-ies).
+ * Copyright (C) ST-Ericsson SA 2010.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#ifndef __ISIMODEM_UTIL_H
+#define __ISIMODEM_UTIL_H
+
+struct isi_cb_data {
+	void *cb;
+	void *data;
+	void *user;
+};
+
+static inline struct isi_cb_data *isi_cb_data_new(void *user, void *cb,
+							void *data)
+{
+	struct isi_cb_data *ret;
+
+	ret =3D g_try_new0(struct isi_cb_data, 1);
+
+	if (ret) {
+		ret->cb =3D cb;
+		ret->data =3D data;
+		ret->user =3D user;
+	}
+
+	return ret;
+}
+
+#define CALLBACK_WITH_FAILURE(f, args...)				\
+		do {							\
+				struct ofono_error e;			\
+				e.type =3D OFONO_ERROR_TYPE_FAILURE;	\
+				e.error =3D 0;				\
+				f(&e, ##args);				\
+		} while (0)
+
+#define CALLBACK_WITH_SUCCESS(f, args...)				\
+		do {							\
+				struct ofono_error e;			\
+				e.type =3D OFONO_ERROR_TYPE_NO_ERROR;	\
+				e.error =3D 0;				\
+				f(&e, ##args);				\
+		} while (0)
+
+#endif /* !__ISIMODEM_UTIL_H */
diff --git a/drivers/isimodem2.5/mce.h b/drivers/isimodem2.5/mce.h
new file mode 100644
index 0000000..5584b98
--- /dev/null
+++ b/drivers/isimodem2.5/mce.h
@@ -0,0 +1,65 @@
+/*
+ * This file is part of oFono - Open Source Telephony
+ *
+ * Copyright (C) 2009 Nokia Corporation and/or its subsidiary(-ies).
+ * Copyright (C) ST-Ericsson SA 2010.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#ifndef __ISIMODEM25_MCE_H
+#define __ISIMODEM25_MCE_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#define PN_MODEM_MCE 0xC2
+
+	enum mce_message_id {
+		MCE_MODEM_STATE_IND =3D		0x00,
+		MCE_MODEM_STATE_QUERY_REQ =3D	0x01,
+		MCE_MODEM_STATE_QUERY_RESP =3D	0x02,
+		MCE_RF_STATE_REQ =3D		0x03,
+		MCE_RF_STATE_RESP =3D		0x04,
+		MCE_RF_STATE_IND =3D		0x05,
+		MCE_RF_STATE_QUERY_REQ =3D	0x06,
+		MCE_RF_STATE_QUERY_RESP =3D	0x07,
+		MCE_POWER_OFF_REQ =3D		0x08,
+		MCE_POWER_OFF_RESP =3D		0x09
+	};
+	enum mce_rf_state {
+		MCE_RF_OFF =3D			0x00,
+		MCE_RF_ON =3D			0x01
+	};
+	enum mce_status_info {
+		MCE_OK =3D			0x00,
+		MCE_FAIL =3D			0x01,
+		MCE_ALREADY_ACTIVE =3D		0x06,
+		MCE_TRANSITION_ONGOING =3D	0x16
+	};
+	enum mce_modem_state {
+		MCE_NORMAL =3D			0x00,
+		MCE_LOCAL =3D			0x01,
+		MCE_SW_RESET =3D			0x80,
+		MCE_POWER_OFF =3D			0x81
+	};
+
+#ifdef __cplusplus
+};
+#endif
+
+#endif /* __ISIMODEM25_MCE_H */
diff --git a/drivers/isimodem2.5/network-registration.c b/drivers/isimodem2=
.5/network-registration.c
new file mode 100644
index 0000000..22d6026
--- /dev/null
+++ b/drivers/isimodem2.5/network-registration.c
@@ -0,0 +1,1158 @@
+/*
+ * This file is part of oFono - Open Source Telephony
+ *
+ * Copyright (C) 2009 Nokia Corporation and/or its subsidiary(-ies).
+ * Copyright (C) ST-Ericsson SA 2010.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include <glib.h>
+
+#include <ofono/modem.h>
+#include <common.h>
+#include <gisi/client.h>
+#include <gisi/iter.h>
+#include <ofono/log.h>
+#include <ofono/netreg.h>
+
+#include "debug.h"
+#include "network.h"
+#include "isimodem.h"
+#include "isiutil.h"
+
+struct netreg_data {
+	GIsiClient *client;
+	guint8 last_reg_mode;
+	guint8 rat;
+	guint8 gsm_compact;
+	gboolean cs_active;	/*
+				 * CS active or inactive. If inactive all
+				 * requests to NET server are rejected.
+				 */
+};
+
+static inline guint8 *mccmnc_to_bcd(const char *mcc, const char *mnc,
+					guint8 *bcd)
+{
+	bcd[0] =3D (mcc[0] - '0') | (mcc[1] - '0') << 4;
+	bcd[1] =3D (mcc[2] - '0');
+	bcd[1] |=3D (mnc[2] =3D=3D '\0' ? 0x0f : (mnc[2] - '0')) << 4;
+	bcd[2] =3D (mnc[0] - '0') | (mnc[1] - '0') << 4;
+	return bcd;
+}
+
+static inline int isi_status_to_at_status(guint8 status)
+{
+	switch (status) {
+	case NET_REG_STATUS_NOSERV:
+	case NET_REG_STATUS_NOSERV_NOTSEARCHING:
+	case NET_REG_STATUS_NOSERV_NOSIM:
+	case NET_REG_STATUS_POWER_OFF:
+	case NET_REG_STATUS_NSPS:
+	case NET_REG_STATUS_NSPS_NO_COVERAGE:
+		return NETWORK_REGISTRATION_STATUS_NOT_REGISTERED;
+	case NET_REG_STATUS_HOME:
+		return NETWORK_REGISTRATION_STATUS_REGISTERED;
+	case NET_REG_STATUS_NOSERV_SEARCHING:
+		return NETWORK_REGISTRATION_STATUS_SEARCHING;
+	case NET_REG_STATUS_NOSERV_SIM_REJECTED_BY_NW:
+		return NETWORK_REGISTRATION_STATUS_DENIED;
+	case NET_REG_STATUS_ROAM:
+		return NETWORK_REGISTRATION_STATUS_ROAMING;
+	default:
+		return NETWORK_REGISTRATION_STATUS_UNKNOWN;
+	}
+}
+
+static gboolean decode_reg_status(struct netreg_data *nd, const guint8 *ms=
g,
+					size_t len, int *status, int *lac,
+					int *ci, int *tech)
+{
+	GIsiSubBlockIter iter;
+	g_isi_sb_iter_init(&iter, msg, len, 0);
+
+	while (g_isi_sb_iter_is_valid(&iter)) {
+		DBG("Sub-block %s",
+		    net_subblock_name(g_isi_sb_iter_get_id(&iter)));
+
+		switch (g_isi_sb_iter_get_id(&iter)) {
+		case NET_MODEM_REG_INFO_COMMON: {
+			guint8 byte =3D 0;
+
+			if (!g_isi_sb_iter_get_byte(&iter, &byte, 2))
+				return FALSE;
+
+			if (!g_isi_sb_iter_get_byte(&iter,
+							&nd->last_reg_mode, 3))
+				return FALSE;
+
+			*status =3D byte;
+			break;
+		}
+		case NET_MODEM_GSM_REG_INFO: {
+			guint16 word =3D 0;
+			guint32 dword =3D 0;
+			guint8 egprs =3D 0;
+			guint8 hsdpa =3D 0;
+			guint8 hsupa =3D 0;
+
+			if (!g_isi_sb_iter_get_word(&iter, &word, 2) ||
+				!g_isi_sb_iter_get_dword(&iter, &dword, 4) ||
+				!g_isi_sb_iter_get_byte(&iter, &egprs, 17) ||
+				!g_isi_sb_iter_get_byte(&iter, &hsdpa, 20) ||
+				!g_isi_sb_iter_get_byte(&iter, &hsupa, 21))
+				return FALSE;
+
+			*ci =3D (int)dword;
+			*lac =3D (int)word;
+
+			switch (nd->rat) {
+			case NET_GSM_RAT:
+				*tech =3D ACCESS_TECHNOLOGY_GSM;
+
+				if (nd->gsm_compact)
+					*tech =3D ACCESS_TECHNOLOGY_GSM_COMPACT;
+				else if (egprs)
+					*tech =3D ACCESS_TECHNOLOGY_GSM_EGPRS;
+
+				break;
+			case NET_UMTS_RAT:
+				*tech =3D 2;
+
+				if (hsdpa)
+					*tech =3D ACCESS_TECHNOLOGY_UTRAN_HSDPA;
+
+				if (hsupa)
+					*tech =3D ACCESS_TECHNOLOGY_UTRAN_HSUPA;
+
+				if (hsdpa && hsupa)
+					*tech =3D
+					  ACCESS_TECHNOLOGY_UTRAN_HSDPA_HSUPA;
+
+				break;
+			default:
+				*tech =3D ACCESS_TECHNOLOGY_GSM;
+			}
+
+			break;
+		}
+		default:
+			DBG("Skipping sub-block: %s (%zu bytes)",
+				net_subblock_name(g_isi_sb_iter_get_id(&iter)),
+				g_isi_sb_iter_get_len(&iter));
+			break;
+		}
+
+		g_isi_sb_iter_next(&iter);
+	}
+
+	DBG("status=3D%d, lac=3D%d, ci=3D%d, tech=3D%d",
+		(*status), *lac, *ci, *tech);
+	return TRUE;
+}
+
+static void cs_power_on_req(GIsiClient *client)
+{
+	const unsigned char msg[] =3D {
+		NET_CS_CONTROL_REQ,
+		0x03,
+		0x00, /* Sub-block count */
+	};
+	DBG("");
+
+	/* Just send message, ignore the reponse */
+	g_isi_request_make(client, msg, sizeof(msg),
+				NETWORK_SET_TIMEOUT,
+				NULL , NULL);
+}
+
+static void reg_status_ind_cb(GIsiClient *client, const void *restrict dat=
a,
+				size_t len, uint16_t object, void *opaque)
+{
+	const unsigned char *msg =3D data;
+	struct ofono_netreg *netreg =3D opaque;
+	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+	int status =3D -1;
+	int lac =3D -1;
+	int ci =3D -1;
+	int tech =3D -1;
+
+	if (!msg || len < 3 || msg[0] !=3D NET_MODEM_REG_STATUS_IND)
+		return;
+
+	DBG("%s", net_message_id_name(msg[0]));
+
+	if (decode_reg_status(nd, msg + 3,
+					len - 3,
+					&status,
+					&lac, &ci,
+					&tech)) {
+		status =3D isi_status_to_at_status(status);
+		ofono_netreg_status_notify(netreg, status, lac, ci, tech);
+	}
+}
+
+static gboolean reg_status_resp_cb(GIsiClient *client,
+					const void *restrict data,
+					size_t len,
+					uint16_t object,
+					void *opaque)
+{
+	const unsigned char *msg =3D data;
+	struct isi_cb_data *cbd =3D opaque;
+	struct ofono_netreg *netreg =3D cbd->user;
+	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+	ofono_netreg_status_cb_t cb =3D cbd->cb;
+	int status =3D -1;
+	int lac =3D -1;
+	int ci =3D -1;
+	int tech =3D -1;
+
+	if (!msg) {
+		DBG("ISI client error: %d", g_isi_client_error(client));
+		goto error;
+	}
+
+	DBG("%s", net_message_id_name(msg[0]));
+
+	if (len < 3 || msg[0] !=3D NET_MODEM_REG_STATUS_GET_RESP)
+		goto error;
+
+	if (msg[1] !=3D NET_CAUSE_OK) {
+		DBG("Request failed: %s", net_isi_cause_name(msg[1]));
+		goto error;
+	}
+
+	if (decode_reg_status(nd, msg + 3,
+				len - 3,
+				&status,
+				&lac,
+				&ci,
+				&tech)) {
+		DBG("status=3D%d, lac=3D%d, ci=3D%d, tech=3D%d", status, lac, ci, tech);
+		CALLBACK_WITH_SUCCESS(cb, isi_status_to_at_status(status),
+					lac, ci, tech, cbd->data);
+		goto out;
+	}
+
+error:
+	CALLBACK_WITH_FAILURE(cb, -1, -1, -1, -1, cbd->data);
+out:
+	g_free(cbd);
+	return TRUE;
+}
+
+static void isi_registration_status(struct ofono_netreg *netreg,
+					ofono_netreg_status_cb_t cb,
+					void *data)
+{
+	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(netreg, cb, data);
+	const unsigned char msg[] =3D {
+		NET_MODEM_REG_STATUS_GET_REQ
+	};
+
+	if (!cbd || !nd)
+		goto error;
+
+	if (g_isi_request_make(nd->client, msg, sizeof(msg),
+				NETWORK_TIMEOUT,
+				reg_status_resp_cb, cbd))
+		return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, -1, -1, -1, -1, data);
+	g_free(cbd);
+}
+
+/* This replaces the isimodem name_get_resp_cb */
+static gboolean cell_info_get_resp_cb(GIsiClient *client,
+					const void *restrict data,
+					size_t len,
+					uint16_t object,
+					void *opaque)
+{
+	struct isi_cb_data *cbd =3D opaque;
+	const unsigned char *msg =3D data;
+	ofono_netreg_operator_cb_t cb =3D cbd->cb;
+	struct ofono_network_operator op;
+	GIsiSubBlockIter iter;
+	memset(&op, 0, sizeof(struct ofono_network_operator));
+
+	if (!msg) {
+		DBG("ISI client error: %d", g_isi_client_error(client));
+		goto error;
+	}
+
+	DBG("%s", net_message_id_name(msg[0]));
+
+	if (len < 3 || msg[0] !=3D NET_CELL_INFO_GET_RESP)
+		return FALSE;
+
+	if (msg[1] !=3D NET_CAUSE_OK) {
+		DBG("Request failed: %s", net_isi_cause_name(msg[1]));
+		goto error;
+	}
+
+	g_isi_sb_iter_init(&iter, msg, len, 3);
+
+	while (g_isi_sb_iter_is_valid(&iter)) {
+		DBG("Sub-block %s",
+			net_subblock_name(g_isi_sb_iter_get_id(&iter)));
+
+		switch (g_isi_sb_iter_get_id(&iter)) {
+		case NET_GSM_CELL_INFO:
+
+			if (!g_isi_sb_iter_get_oper_code(&iter,
+							 op.mcc, op.mnc, 12))
+				goto error;
+
+			op.tech =3D 0; /*ACCESS_TECHNOLOGY_GSM;*/
+			/* NOTE: Operator name, status not updated here !!!*/
+			DBG("NET_GSM_CELL_INFO name=3D%s mcc=3D%s mnc=3D%s tech=3D%d",
+			    op.name, op.mcc, op.mnc, op.tech);
+			break;
+		case NET_WCDMA_CELL_INFO:
+
+			if (!g_isi_sb_iter_get_oper_code(&iter,
+							 op.mcc, op.mnc, 12))
+				goto error;
+
+			op.tech =3D 2; /*ACCESS_TECHNOLOGY_UTRAN;*/
+			/* NOTE: Operator name, status not updated here */
+			DBG("NET_WCDMA_CELL_INFO name=3D%s mcc=3D%s mnc=3D%s tech=3D%d",
+			    op.name, op.mcc, op.mnc, op.tech);
+			break;
+		default:
+			DBG("Skipping sub-block: %s (%zu bytes)",
+				net_subblock_name(g_isi_sb_iter_get_id(&iter)),
+				g_isi_sb_iter_get_len(&iter));
+			break;
+		}
+
+		g_isi_sb_iter_next(&iter);
+	}
+
+	CALLBACK_WITH_SUCCESS(cb, &op, cbd->data);
+	goto out;
+error:
+	CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
+out:
+	g_free(cbd);
+	return TRUE;
+}
+
+
+static void isi_current_operator(struct ofono_netreg *netreg,
+					ofono_netreg_operator_cb_t cb,
+					void *data)
+{
+	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(netreg, cb, data);
+	const unsigned char msg[] =3D {
+		NET_CELL_INFO_GET_REQ
+	};
+	DBG("");
+
+	if (!cbd || !nd)
+		goto error;
+
+	if (g_isi_request_make(nd->client, msg, sizeof(msg),
+				NETWORK_TIMEOUT,
+				cell_info_get_resp_cb, cbd))
+		return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, NULL, data);
+	g_free(cbd);
+}
+
+
+static gboolean available_resp_cb(GIsiClient *client,
+					const void *restrict data,
+					size_t len,
+					uint16_t object, void *opaque)
+{
+	const unsigned char *msg =3D data;
+	struct isi_cb_data *cbd =3D opaque;
+	ofono_netreg_operator_list_cb_t cb =3D cbd->cb;
+	struct ofono_network_operator *list =3D NULL;
+	int total =3D 0;
+	GIsiSubBlockIter iter;
+	int common =3D 0;
+	int detail =3D 0;
+
+	if (!msg) {
+		DBG("ISI client error: %d", g_isi_client_error(client));
+		goto error;
+	}
+
+	DBG("%s", net_message_id_name(msg[0]));
+
+	if (len < 3 || msg[0] !=3D NET_MODEM_AVAILABLE_GET_RESP)
+		return FALSE;
+
+	if (msg[1] !=3D NET_CAUSE_OK) {
+		DBG("Request failed: %s", net_isi_cause_name(msg[1]));
+		goto error;
+	}
+
+	/* Each description of an operator has a pair of sub-blocks */
+	total =3D msg[2] / 2;
+	list =3D alloca(total * sizeof(struct ofono_network_operator));
+	memset(list, 0, total * sizeof(struct ofono_network_operator));
+	g_isi_sb_iter_init(&iter, msg, len, 3);
+
+	while (g_isi_sb_iter_is_valid(&iter)) {
+		struct ofono_network_operator *op =3D NULL;
+		DBG("Sub-block %s",
+			net_subblock_name(g_isi_sb_iter_get_id(&iter)));
+		switch (g_isi_sb_iter_get_id(&iter)) {
+		case NET_MODEM_AVAIL_NETWORK_INFO_COMMON: {
+			guint8 status =3D 0;
+			guint8 mode =3D 0; /* Not used !!! */
+
+			if (!g_isi_sb_iter_get_byte(&iter, &status, 2))
+				goto error;
+
+			if (!g_isi_sb_iter_get_byte(&iter, &mode, 3))
+				goto error;
+
+			DBG("NET_MODEM_AVAIL_NETWORK_INFO_COMMON \
+				status=3D%d, mode=3D%d",
+				status, mode);
+			op =3D list + common++;
+			op->status =3D status;
+			break;
+		}
+		case NET_MODEM_DETAILED_NETWORK_INFO: {
+			uint16_t lac =3D 0;
+			op =3D list + detail++;
+
+			if (!g_isi_sb_iter_get_oper_code(&iter, op->mcc,
+								op->mnc, 2))
+				goto error;
+
+			if (!g_isi_sb_iter_get_word(&iter, &lac, 8))
+				goto error;
+
+			op->name[0] =3D 0;
+			DBG("NET_MODEM_DETAILED_NETWORK_INFO name=3D%s \
+				mcc=3D%s mnc=3D%s lac=3D%d",
+				op->name, op->mcc, op->mnc, lac);
+			break;
+		}
+		default:
+			DBG("Skipping sub-block: %s (%zu bytes)",
+				net_subblock_name(g_isi_sb_iter_get_id(&iter)),
+				g_isi_sb_iter_get_len(&iter));
+			break;
+		}
+
+		g_isi_sb_iter_next(&iter);
+	}
+
+	if (common =3D=3D detail && detail =3D=3D total) {
+		CALLBACK_WITH_SUCCESS(cb, total, list, cbd->data);
+		goto out;
+	}
+
+error:
+	CALLBACK_WITH_FAILURE(cb, 0, NULL, cbd->data);
+out:
+	g_free(cbd);
+	return TRUE;
+}
+
+static void isi_list_operators(struct ofono_netreg *netreg,
+				ofono_netreg_operator_list_cb_t cb,
+				void *data)
+{
+	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(netreg, cb, data);
+
+	if (!nd)
+		return;
+	else {
+		const unsigned char msg[] =3D {
+			NET_MODEM_AVAILABLE_GET_REQ,
+			NET_MANUAL_SEARCH,
+			0x01,	/* Sub-block count */
+			NET_MODEM_GSM_BAND_INFO,
+			0x04,	/* Sub-block length */
+			NET_GSM_BAND_ALL_SUPPORTED_BANDS,
+			0x00
+		};
+		DBG("NET_MODEM_AVAILABLE_GET_REQ");
+
+		/* Activate CS in case inactive */
+		if (nd->cs_active =3D=3D FALSE)
+			cs_power_on_req(nd->client);
+
+		if (!cbd || !nd)
+			goto error;
+
+		if (g_isi_request_make(nd->client, msg, sizeof(msg),
+					NETWORK_SCAN_TIMEOUT,
+					available_resp_cb, cbd))
+			return;
+	}
+error:
+	CALLBACK_WITH_FAILURE(cb, 0, NULL, data);
+	g_free(cbd);
+}
+
+static gboolean set_auto_resp_cb(GIsiClient *client,
+					const void *restrict data,
+					size_t len,
+					uint16_t object,
+					void *opaque)
+{
+	const unsigned char *msg =3D data;
+	struct isi_cb_data *cbd =3D opaque;
+	struct netreg_data *net =3D cbd->user;
+	ofono_netreg_register_cb_t cb =3D cbd->cb;
+	int error;
+
+	if (!msg) {
+		error =3D g_isi_client_error(client);
+		DBG("ISI client error: %d", error);
+
+		if (error =3D=3D -ESHUTDOWN)
+			goto out;
+
+		goto error;
+	}
+
+	DBG("%s", net_message_id_name(msg[0]));
+
+	if (!msg || len < 3 || msg[0] !=3D NET_SET_RESP)
+		goto error;
+
+	if (msg[1] !=3D NET_CAUSE_OK) {
+		DBG("Request failed: %s", net_isi_cause_name(msg[1]));
+		goto error;
+	}
+
+	CALLBACK_WITH_SUCCESS(cb, cbd->data);
+	net->last_reg_mode =3D NET_SELECT_MODE_AUTOMATIC;
+	goto out;
+error:
+	CALLBACK_WITH_FAILURE(cb, cbd->data);
+out:
+	g_free(cbd);
+	return TRUE;
+}
+
+static void isi_register_auto(struct ofono_netreg *netreg,
+				ofono_netreg_register_cb_t cb,
+				void *data)
+{
+	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(netreg, cb, data);
+
+	if (!nd)
+		return;
+	else {
+		const unsigned char msg[] =3D {
+			NET_SET_REQ,
+			0x00,	/* Registered in another protocol? */
+			0x01,	/* Sub-block count */
+			NET_OPERATOR_INFO_COMMON,
+			0x04,	/* Sub-block length */
+			nd->last_reg_mode =3D=3D NET_SELECT_MODE_AUTOMATIC
+				? NET_SELECT_MODE_USER_RESELECTION
+				: NET_SELECT_MODE_AUTOMATIC,
+			0x00	/* Index not used */
+		};
+
+		/* Activate CS in case inactive */
+		if (nd->cs_active =3D=3D FALSE)
+			cs_power_on_req(nd->client);
+
+		if (nd->last_reg_mode =3D=3D NET_SELECT_MODE_AUTOMATIC)
+			DBG("isi_register_auto: \
+					NET_SELECT_MODE_USER_RESELECTION");
+		else
+			DBG("isi_register_auto: NET_SELECT_MODE_AUTOMATIC");
+
+		if (!cbd || !nd)
+			goto error;
+
+		if (g_isi_request_make(nd->client, msg, sizeof(msg),
+					NETWORK_SET_TIMEOUT,
+					set_auto_resp_cb, cbd))
+			return;
+	}
+
+error:
+	CALLBACK_WITH_FAILURE(cb, data);
+	g_free(cbd);
+}
+
+static gboolean set_manual_resp_cb(GIsiClient *client,
+					const void *restrict data,
+					size_t len,
+					uint16_t object,
+					void *opaque)
+{
+	const unsigned char *msg =3D data;
+	struct isi_cb_data *cbd =3D opaque;
+	struct ofono_netreg *netreg =3D cbd->user;
+	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+	ofono_netreg_register_cb_t cb =3D cbd->cb;
+
+	if (!msg) {
+		DBG("ISI client error: %d", g_isi_client_error(client));
+		goto error;
+	}
+
+	DBG("%s", net_message_id_name(msg[0]));
+
+	if (len < 3 || msg[0] !=3D NET_SET_RESP)
+		goto error;
+
+	if (msg[1] !=3D NET_CAUSE_OK) {
+		DBG("Request failed: %s", net_isi_cause_name(msg[1]));
+		goto error;
+	}
+
+	CALLBACK_WITH_SUCCESS(cb, cbd->data);
+	nd->last_reg_mode =3D NET_SELECT_MODE_MANUAL;
+	goto out;
+error:
+	CALLBACK_WITH_FAILURE(cb, cbd->data);
+out:
+	g_free(cbd);
+	return TRUE;
+}
+
+static void isi_register_manual(struct ofono_netreg *netreg,
+				const char *mcc, const char *mnc,
+				ofono_netreg_register_cb_t cb, void *data)
+{
+	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(netreg, cb, data);
+
+	if (!nd)
+		return;
+	else {
+		guint8 buffer[3] =3D { 0 };
+		guint8 *bcd =3D mccmnc_to_bcd(mcc, mnc, buffer);
+		const unsigned char msg[] =3D {
+			NET_SET_REQ,
+			0x00, /* Registered in another protocol? */
+			0x03, /* Sub-block count */
+			NET_OPERATOR_INFO_COMMON,
+			0x04, /* Sub-block length */
+			NET_SELECT_MODE_MANUAL,
+			0x00, /* Index not used */
+			NET_MODEM_GSM_OPERATOR_INFO,
+			0x08, /* Sub-block length */
+			bcd[0], bcd[1], bcd[2],
+			NET_GSM_BAND_INFO_NOT_AVAIL, /* Pick any band */
+			0x00, 0x00, /* Filler */
+		};
+		DBG("NET_SET_REQ manual, mcc=3D%s, mnc=3D%s", mcc, mnc);
+
+		/* Activate CS in case inactive */
+		if (nd->cs_active =3D=3D FALSE)
+			cs_power_on_req(nd->client);
+
+		if (!cbd || !nd)
+			goto error;
+
+		if (g_isi_request_make(nd->client, msg, sizeof(msg),
+					NETWORK_SET_TIMEOUT,
+					set_manual_resp_cb, cbd))
+			return;
+	}
+
+error:
+	CALLBACK_WITH_FAILURE(cb, data);
+	g_free(cbd);
+}
+
+static gboolean deregister_resp_cb(GIsiClient *client,
+					const void *restrict data,
+					size_t len,
+					uint16_t object,
+					void *opaque)
+{
+	const unsigned char *msg =3D data;
+	struct isi_cb_data *cbd =3D opaque;
+	ofono_netreg_register_cb_t cb =3D cbd->cb;
+	DBG("");
+
+	if (msg[0] !=3D NET_CS_CONTROL_RESP)
+		return FALSE;
+
+	if (msg[2] !=3D NET_CAUSE_OK) {
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+		g_free(cbd);
+		return TRUE;
+	}
+
+	CALLBACK_WITH_SUCCESS(cb, cbd->data);
+	DBG("EXIT OK");
+	g_free(cbd);
+	return TRUE;
+}
+
+static void isi_deregister(struct ofono_netreg *netreg,
+				ofono_netreg_register_cb_t cb,
+				void *data)
+{
+	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(netreg, cb, data);
+	const unsigned char msg[] =3D {
+		NET_CS_CONTROL_REQ,
+		0x02,
+		0x00,
+	};
+	DBG("");
+
+	if (!cbd || !nd)
+		goto error;
+
+	if (g_isi_request_make(nd->client, msg, sizeof(msg),
+				NETWORK_SET_TIMEOUT,
+				deregister_resp_cb, cbd))
+		return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, data);
+	g_free(cbd);
+}
+
+
+static void nitz_name_ind_cb(GIsiClient *client, const void *restrict data,
+			size_t len, uint16_t object, void *opaque)
+{
+	const unsigned char *msg =3D data;
+	struct ofono_network_operator op;
+	GIsiSubBlockIter iter;
+
+	if (!msg || len < 3 || msg[0] !=3D NET_NITZ_NAME_IND)
+		return;
+
+	memset(&op, 0, sizeof(struct ofono_network_operator));
+	DBG("%s", net_message_id_name(msg[0]));
+	g_isi_sb_iter_init(&iter, msg, len, 7);
+
+	while (g_isi_sb_iter_is_valid(&iter)) {
+		DBG("Sub-block %s",
+			net_subblock_name(g_isi_sb_iter_get_id(&iter)));
+
+		switch (g_isi_sb_iter_get_id(&iter)) {
+		case NET_FULL_NITZ_NAME:
+		case NET_SHORT_NITZ_NAME: {
+			char *tag =3D NULL;
+			guint8 taglen =3D 0;
+
+			if (!g_isi_sb_iter_get_byte(&iter, &taglen, 5)
+				|| !g_isi_sb_iter_get_alpha_tag(&iter, &tag,
+								taglen * 2, 7))
+				return;
+
+			strncpy(op.name, tag, OFONO_MAX_OPERATOR_NAME_LENGTH);
+			op.name[OFONO_MAX_OPERATOR_NAME_LENGTH] =3D '\0';
+			g_free(tag);
+			break;
+		}
+		default:
+			DBG("Skipping sub-block: %s (%zu bytes)",
+				net_subblock_name(g_isi_sb_iter_get_id(&iter)),
+				g_isi_sb_iter_get_len(&iter));
+			break;
+		}
+
+		g_isi_sb_iter_next(&iter);
+	}
+
+	/* TODO Here we should notify framework once it
+	 * supports this indication e.g.
+	 * ofono_netreg_name_notify(netreg, op.name);
+	 */
+}
+
+static void rat_ind_cb(GIsiClient *client, const void *restrict data,
+			size_t len, uint16_t object, void *opaque)
+{
+	const unsigned char *msg =3D data;
+	struct ofono_netreg *netreg =3D opaque;
+	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+	GIsiSubBlockIter iter;
+	DBG("%s", net_message_id_name(msg[0]));
+
+	if (!msg || len < 3 || msg[0] !=3D NET_RAT_IND)
+		return;
+
+	g_isi_sb_iter_init(&iter, msg, len, 3);
+
+	while (g_isi_sb_iter_is_valid(&iter)) {
+		DBG("Sub-block %s",
+			net_subblock_name(g_isi_sb_iter_get_id(&iter)));
+
+		switch (g_isi_sb_iter_get_id(&iter)) {
+		case NET_RAT_INFO: {
+			guint8 info =3D 0;
+
+			if (!g_isi_sb_iter_get_byte(&iter, &nd->rat, 2)
+				|| !g_isi_sb_iter_get_byte(&iter, &info, 3))
+				return;
+
+			DBG("RAT=3D%d, info len=3D%d", nd->rat, info);
+
+			if (info) {
+				(void) g_isi_sb_iter_get_byte(&iter,
+							&nd->gsm_compact,
+							4);
+			}
+
+			break;
+		}
+		default:
+			DBG("Skipping sub-block: %s (%zu bytes)",
+				net_subblock_name(g_isi_sb_iter_get_id(&iter)),
+				g_isi_sb_iter_get_len(&iter));
+			break;
+		}
+
+		g_isi_sb_iter_next(&iter);
+	}
+}
+
+static gboolean rat_resp_cb(GIsiClient *client, const void *restrict data,
+				size_t len, uint16_t object, void *opaque)
+{
+	const unsigned char *msg =3D data;
+	struct ofono_netreg *netreg =3D opaque;
+	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+	GIsiSubBlockIter iter;
+
+	if (!msg) {
+		DBG("ISI client error: %d", g_isi_client_error(client));
+		return FALSE;
+	}
+
+	DBG("%s", net_message_id_name(msg[0]));
+
+	if (len < 3 || msg[0] !=3D NET_RAT_RESP)
+		return FALSE;
+
+	if (msg[1] !=3D NET_CAUSE_OK) {
+		DBG("Request failed: %s", net_isi_cause_name(msg[1]));
+		return TRUE;
+	}
+
+	g_isi_sb_iter_init(&iter, msg, len, 3);
+
+	while (g_isi_sb_iter_is_valid(&iter)) {
+		DBG("Sub-block %s",
+			net_subblock_name(g_isi_sb_iter_get_id(&iter)));
+
+		switch (g_isi_sb_iter_get_id(&iter)) {
+		case NET_RAT_INFO: {
+			guint8 info_len =3D 0;
+			g_isi_sb_iter_get_byte(&iter, &nd->rat, 2);
+			g_isi_sb_iter_get_byte(&iter, &info_len, 3);
+
+			if (info_len)
+				g_isi_sb_iter_get_byte(&iter, &nd->gsm_compact,
+							 4);
+
+			DBG("Current RAT %d, info len=3D%d", nd->rat, info_len);
+			break;
+		}
+		default:
+			DBG("Skipping sub-block: %s (%zu bytes)",
+				net_subblock_name(g_isi_sb_iter_get_id(&iter)),
+				g_isi_sb_iter_get_len(&iter));
+			break;
+		}
+
+		g_isi_sb_iter_next(&iter);
+	}
+
+	return TRUE;
+}
+
+static void rssi_ind_cb(GIsiClient *client, const void *restrict data,
+			size_t len, uint16_t object, void *opaque)
+{
+	const unsigned char *msg =3D data;
+	struct ofono_netreg *netreg =3D opaque;
+
+	if (!msg || len < 3 || msg[0] !=3D NET_RSSI_IND)
+		return;
+
+	DBG("%s", net_message_id_name(msg[0]));
+	ofono_netreg_strength_notify(netreg, msg[1]);
+}
+
+static void cs_state_ind_cb(GIsiClient *client, const void *restrict data,
+				size_t len, uint16_t object, void *opaque)
+{
+	const unsigned char *msg =3D data;
+	struct ofono_netreg *netreg =3D opaque;
+	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+	gboolean new_state =3D FALSE;
+	DBG("");
+
+	if (!msg || len < 3 || msg[0] !=3D NET_CS_STATE_IND)
+		return;
+
+	if (msg[1] =3D=3D 0x01) /* active */
+		new_state =3D TRUE;
+
+	nd->cs_active =3D new_state;
+	DBG("CS active %d", nd->cs_active);
+}
+
+static gboolean cs_state_resp_cb(GIsiClient *client,
+					const void *restrict data,
+					size_t len,
+					uint16_t object, void *opaque)
+{
+	const unsigned char *msg =3D data;
+	struct ofono_netreg *netreg =3D opaque;
+	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+	gboolean new_state =3D FALSE;
+	DBG("");
+
+	if (!msg || len < 3 || msg[0] !=3D NET_CS_STATE_RESP)
+		return FALSE;
+
+	if (msg[2] =3D=3D 0x01)
+		new_state =3D TRUE;
+
+	nd->cs_active =3D new_state;
+	DBG("CS active %d", nd->cs_active);
+	return TRUE;
+}
+
+static gboolean rssi_resp_cb(GIsiClient *client, const void *restrict data,
+				size_t len, uint16_t object, void *opaque)
+{
+	const unsigned char *msg =3D data;
+	struct isi_cb_data *cbd =3D opaque;
+	ofono_netreg_strength_cb_t cb =3D cbd->cb;
+	GIsiSubBlockIter iter;
+	int strength =3D -1;
+
+	if (!msg) {
+		DBG("ISI client error: %d", g_isi_client_error(client));
+		goto error;
+	}
+
+	DBG("%s", net_message_id_name(msg[0]));
+
+	if (len < 3 || msg[0] !=3D NET_RSSI_GET_RESP)
+		return FALSE;
+
+	if (msg[1] !=3D NET_CAUSE_OK) {
+		DBG("Request failed: 0x%02X", msg[1]);
+		goto error;
+	}
+
+	g_isi_sb_iter_init(&iter, msg, len, 3);
+
+	while (g_isi_sb_iter_is_valid(&iter)) {
+		DBG("Sub-block %s",
+			net_subblock_name(g_isi_sb_iter_get_id(&iter)));
+
+		switch (g_isi_sb_iter_get_id(&iter)) {
+		case NET_RSSI_CURRENT: {
+			guint8 rssi =3D 0;
+
+			if (!g_isi_sb_iter_get_byte(&iter, &rssi, 2))
+				goto error;
+
+			strength =3D rssi !=3D 0 ? rssi : -1;
+			break;
+		}
+		default:
+			DBG("Skipping sub-block: %s (%zd bytes)",
+				net_subblock_name(g_isi_sb_iter_get_id(&iter)),
+				g_isi_sb_iter_get_len(&iter));
+			break;
+		}
+
+		g_isi_sb_iter_next(&iter);
+	}
+
+	CALLBACK_WITH_SUCCESS(cb, strength, cbd->data);
+	goto out;
+error:
+	CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
+out:
+	g_free(cbd);
+	return TRUE;
+}
+
+static void isi_strength(struct ofono_netreg *netreg,
+				ofono_netreg_strength_cb_t cb,
+				void *data)
+{
+	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(netreg, cb, data);
+	const unsigned char msg[] =3D {
+		NET_RSSI_GET_REQ,
+		NET_CS_GSM,
+		NET_CURRENT_CELL_RSSI,
+		0, 0, 0, 0 /* Week 18 specs requires these */
+	};
+
+	if (!cbd || !nd)
+		goto error;
+
+	if (g_isi_request_make(nd->client, msg, sizeof(msg),
+				NETWORK_TIMEOUT,
+				rssi_resp_cb, cbd))
+		return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, -1, data);
+	g_free(cbd);
+}
+
+static gboolean isi_netreg_register(gpointer user)
+{
+	struct ofono_netreg *netreg =3D user;
+	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+	const unsigned char rat[] =3D {
+		NET_RAT_REQ,
+		NET_CURRENT_RAT
+	};
+	const unsigned char cs_state[] =3D {
+		NET_CS_STATE_REQ
+	};
+	DBG("");
+
+	if (!nd)
+		return FALSE;
+
+	g_isi_subscribe(nd->client, NET_RSSI_IND, rssi_ind_cb, netreg);
+	g_isi_subscribe(nd->client, NET_MODEM_REG_STATUS_IND, reg_status_ind_cb,
+			netreg);
+	g_isi_subscribe(nd->client, NET_RAT_IND, rat_ind_cb, netreg);
+	g_isi_subscribe(nd->client,
+			NET_NITZ_NAME_IND, nitz_name_ind_cb, netreg);
+	g_isi_subscribe(nd->client, NET_CS_STATE_IND, cs_state_ind_cb, netreg);
+	/* Bootstrap current RAT setting */
+	DBG("NET_RAT_REQ,NET_CURRENT_RAT");
+
+	if (!g_isi_request_make(nd->client, rat, sizeof(rat),
+				NETWORK_TIMEOUT,
+				rat_resp_cb, netreg)) {
+		DBG("Failed to bootstrap RAT");
+	}
+
+	DBG("NET_CS_STATE_REQ");
+
+	if (!g_isi_request_make(nd->client, cs_state, sizeof(cs_state),
+				NETWORK_TIMEOUT,
+				cs_state_resp_cb, netreg)) {
+		DBG("Failed to query CS state");
+	}
+
+	ofono_netreg_register(netreg);
+	return FALSE;
+}
+
+static void reachable_cb(GIsiClient *client, gboolean alive, uint16_t obje=
ct,
+			 void *opaque)
+{
+	struct ofono_netreg *netreg =3D opaque;
+
+	if (!alive) {
+		DBG("Unable to bootsrap netreg driver");
+		return;
+	}
+
+	DBG("Resource %s (v%03d.%03d) reachable",
+		pn_resource_name(g_isi_client_resource(client)),
+		g_isi_version_major(client),
+		g_isi_version_minor(client));
+	g_idle_add(isi_netreg_register, netreg);
+}
+
+static int isi_netreg_probe(struct ofono_netreg *netreg, unsigned int vend=
or,
+				void *user)
+{
+	GIsiModem *idx =3D user;
+	struct netreg_data *nd =3D g_try_new0(struct netreg_data, 1);
+
+	if (!nd)
+		return -ENOMEM;
+
+	nd->client =3D g_isi_client_create(idx, PN_MODEM_NETWORK);
+
+	if (!nd->client) {
+		g_free(nd);
+		return -ENOMEM;
+	}
+
+	ofono_netreg_set_data(netreg, nd);
+	g_isi_verify(nd->client, reachable_cb, netreg);
+	nd->cs_active =3D FALSE; /* Assume CS is inactive (updated later) */
+	return 0;
+}
+
+static void isi_netreg_remove(struct ofono_netreg *net)
+{
+	struct netreg_data *data =3D ofono_netreg_get_data(net);
+
+	if (data) {
+		g_isi_client_destroy(data->client);
+		g_free(data);
+	}
+}
+
+static struct ofono_netreg_driver driver =3D {
+	.name			=3D "isimodem25",
+	.probe			=3D isi_netreg_probe,
+	.remove			=3D isi_netreg_remove,
+	.registration_status	=3D isi_registration_status,
+	.current_operator	=3D isi_current_operator,
+	.list_operators		=3D isi_list_operators,
+	.register_auto		=3D isi_register_auto,
+	.register_manual	=3D isi_register_manual,
+	.deregister		=3D isi_deregister,
+	.strength		=3D isi_strength,
+};
+
+void isi_netreg_init()
+{
+	ofono_netreg_driver_register(&driver);
+}
+
+void isi_netreg_exit()
+{
+	ofono_netreg_driver_unregister(&driver);
+}
diff --git a/drivers/isimodem2.5/network.h b/drivers/isimodem2.5/network.h
new file mode 100644
index 0000000..2fbd586
--- /dev/null
+++ b/drivers/isimodem2.5/network.h
@@ -0,0 +1,257 @@
+/*
+ * This file is part of oFono - Open Source Telephony
+ *
+ * Copyright (C) 2009 Nokia Corporation and/or its subsidiary(-ies).
+ * Copyright (C) ST-Ericsson SA 2010.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#ifndef __ISIMODEM25_NETWORK_H
+#define __ISIMODEM25_NETWORK_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#define PN_MODEM_NETWORK				0xC8
+#define NETWORK_TIMEOUT					5
+#define NETWORK_SCAN_TIMEOUT				180
+#define NETWORK_SET_TIMEOUT				240
+
+enum net_message_id {
+	NET_MODEM_REG_STATUS_GET_REQ =3D			0x00,
+	NET_MODEM_REG_STATUS_GET_RESP =3D			0x01,
+	NET_MODEM_REG_STATUS_IND =3D			0x02,
+	NET_MODEM_AVAILABLE_GET_REQ =3D			0x03,
+	NET_MODEM_AVAILABLE_GET_RESP =3D			0x04,
+	NET_AVAILABLE_CANCEL_REQ =3D			0x05,
+	NET_AVAILABLE_CANCEL_RESP =3D			0x06,
+	NET_SET_REQ =3D					0x07,
+	NET_SET_RESP =3D					0x08,
+	NET_SET_CANCEL_REQ =3D				0x09,
+	NET_SET_CANCEL_RESP =3D				0x0A,
+	NET_RSSI_GET_REQ =3D				0x0B,
+	NET_RSSI_GET_RESP =3D				0x0C,
+	NET_CS_CONTROL_REQ =3D				0x0D,
+	NET_CS_CONTROL_RESP =3D				0x0E,
+	NET_CS_WAKEUP_REQ =3D				0x0F,
+	NET_CS_WAKEUP_RESP =3D				0x10,
+	NET_TEST_CARRIER_REQ =3D				0x11,
+	NET_TEST_CARRIER_RESP =3D				0x12,
+	NET_CS_STATE_IND =3D				0x19,
+	NET_NEIGHBOUR_CELLS_REQ =3D			0x1A,
+	NET_NEIGHBOUR_CELLS_RESP =3D			0x1B,
+	NET_NETWORK_SELECT_MODE_SET_REQ =3D		0x1C,
+	NET_NETWORK_SELECT_MODE_SET_RESP =3D		0x1D,
+	NET_RSSI_IND =3D					0x1E,
+	NET_CIPHERING_IND =3D				0x20,
+	NET_TIME_IND =3D					0x27,
+	NET_CHANNEL_INFO_IND =3D				0x2C,
+	NET_CHANNEL_INFO_REQ =3D				0x2D,
+	NET_CHANNEL_INFO_RESP =3D				0x2E,
+	NET_RAT_IND =3D					0x35,
+	NET_RAT_REQ =3D					0x36,
+	NET_RAT_RESP =3D					0x37,
+	NET_CS_STATE_REQ =3D				0x3A,
+	NET_CS_STATE_RESP =3D				0x3B,
+	NET_UMA_INFO_IND =3D				0x3C,
+	NET_RADIO_INFO_IND =3D				0x3F,
+	NET_CELL_INFO_GET_REQ =3D				0x40,
+	NET_CELL_INFO_GET_RESP =3D			0x41,
+	NET_CELL_INFO_IND =3D				0x42,
+	NET_NITZ_NAME_IND =3D				0x43,
+	NET_SOR_REQ =3D					0x44,
+	NET_SOR_RESP =3D					0x45,
+	NET_RSSI_CONF_REQ =3D				0x46,
+	NET_RSSI_CONF_RESP =3D				0x47
+};
+
+enum net_subblock {
+	NET_MODEM_REG_INFO_COMMON =3D			0x00,
+	NET_MODEM_AVAIL_NETWORK_INFO_COMMON =3D		0x01,
+	NET_OPERATOR_INFO_COMMON =3D			0x02,
+	NET_RSSI_CURRENT =3D				0x04,
+	NET_TEST_CARRIER_PARAM =3D			0x05,
+	NET_TEST_WCDMA_PARAMS =3D				0x2D,
+	NET_CIPHERING_INFO =3D				0x29,
+	NET_MODEM_GSM_REG_INFO =3D			0x09,
+	NET_MODEM_CURRENT_CELL_INFO =3D			0x39,
+	NET_TIME_INFO =3D					0x10,
+	NET_MODEM_DETAILED_NETWORK_INFO =3D		0x0B,
+	NET_MODEM_GSM_OPERATOR_INFO =3D			0x0C,
+	NET_GSM_HOME_CELLS_INFO =3D			0x0D,
+	NET_GSM_SIM_NMR_INFO =3D				0x0E,
+	NET_MODEM_CAUSE_EXTENSION =3D			0x0F,
+	NET_MODEM_GSM_BAND_INFO =3D			0x11,
+	NET_UTRAN_SIM_NMR_INFO =3D			0x3D,
+	NET_ECID_GERAN_INFO =3D				0x3E,
+	NET_ECID_UTRAN_FDD_INFO =3D			0x3F,
+	NET_RAT_INFO =3D					0x2C,
+	NET_MODEM_UMA_SERVICE_ZONE_INFO =3D		0x37,
+	NET_UMA_FAILURE_INFO =3D				0x38,
+	NET_UTRAN_RADIO_INFO =3D				0x3C,
+	NET_UARFCN_INFO =3D				0x28,
+	NET_GSM_CELL_INFO =3D				0x46,
+	NET_WCDMA_CELL_INFO =3D				0x47,
+	NET_EPS_CELL_INFO =3D				0x50,
+	NET_FULL_NITZ_NAME =3D				0x48,
+	NET_SHORT_NITZ_NAME =3D				0x49,
+	NET_RSSI_CONF_INFO =3D				0x54
+};
+enum net_modem_gprs_network_mode {
+	NET_GPRS_MODE_NONE =3D				0x00
+};
+
+enum net_service_status {
+	NET_SERVICE =3D					0x00
+};
+enum net_reg_status {
+	NET_REG_STATUS_HOME =3D				0x00,
+	NET_REG_STATUS_ROAM =3D				0x01,
+	NET_REG_STATUS_ROAM_BLINK =3D			0x02,
+	NET_REG_STATUS_NOSERV =3D				0x03,
+	NET_REG_STATUS_NOSERV_SEARCHING =3D		0x04,
+	NET_REG_STATUS_NOSERV_NOTSEARCHING =3D		0x05,
+	NET_REG_STATUS_NOSERV_NOSIM =3D			0x06,
+	NET_REG_STATUS_POWER_OFF =3D			0x08,
+	NET_REG_STATUS_NSPS =3D				0x09,
+	NET_REG_STATUS_NSPS_NO_COVERAGE =3D		0x0A,
+	NET_REG_STATUS_NOSERV_SIM_REJECTED_BY_NW =3D	0x0B
+};
+
+enum net_network_status {
+	NET_OPER_STATUS_UNKNOWN =3D			0x00,
+	NET_OPER_STATUS_AVAILABLE =3D			0x01,
+	NET_OPER_STATUS_CURRENT =3D			0x02,
+	NET_OPER_STATUS_FORBIDDEN =3D			0x03
+};
+
+enum net_network_pref {
+	NET_GSM_HOME_PLMN =3D				0x00,
+	NET_GSM_PREFERRED_PLMN =3D			0x01,
+	NET_GSM_FORBIDDEN_PLMN =3D			0x02,
+	NET_GSM_OTHER_PLMN =3D				0x03,
+	NET_GSM_NO_PLMN_AVAIL =3D				0x04
+};
+
+enum net_umts_available {
+	NET_UMTS_NOT_AVAILABLE =3D			0x00,
+	NET_UMTS_AVAILABLE =3D				0x01
+};
+
+enum net_band_info {
+	NET_GSM_BAND_900_1800 =3D				0x00,
+	NET_GSM_BAND_850_1900 =3D				0x01,
+	NET_GSM_BAND_INFO_NOT_AVAIL =3D			0x02,
+	NET_GSM_BAND_ALL_SUPPORTED_BANDS =3D		0x03
+};
+
+enum net_gsm_cause {
+	NET_GSM_IMSI_UNKNOWN_IN_HLR =3D			0x02,
+	NET_GSM_ILLEGAL_MS =3D				0x03,
+	NET_GSM_IMSI_UNKNOWN_IN_VLR =3D			0x04,
+	NET_GSM_IMEI_NOT_ACCEPTED =3D			0x05,
+	NET_GSM_ILLEGAL_ME =3D				0x06,
+	NET_GSM_GPRS_SERVICES_NOT_ALLOWED =3D		0x07,
+	NET_GSM_GPRS_AND_NON_GPRS_NA =3D			0x08,
+	NET_GSM_MS_ID_CANNOT_BE_DERIVED =3D		0x09,
+	NET_GSM_IMPLICITLY_DETACHED =3D			0x0A,
+	NET_GSM_PLMN_NOT_ALLOWED =3D			0x0B,
+	NET_GSM_LA_NOT_ALLOWED =3D			0x0C,
+	NET_GSM_ROAMING_NOT_IN_THIS_LA =3D		0x0D,
+	NET_GSM_GPRS_SERV_NA_IN_THIS_PLMN =3D		0x0E,
+	NET_GSM_NO_SUITABLE_CELLS_IN_LA =3D		0x0F,
+	NET_GSM_MSC_TEMP_NOT_REACHABLE =3D		0x10,
+	NET_GSM_NETWORK_FAILURE =3D			0x11,
+	NET_GSM_MAC_FAILURE =3D				0x14,
+	NET_GSM_SYNCH_FAILURE =3D				0x15,
+	NET_GSM_CONGESTION =3D				0x16,
+	NET_GSM_AUTH_UNACCEPTABLE =3D			0x17,
+	NET_GSM_SERV_OPT_NOT_SUPPORTED =3D		0x20,
+	NET_GSM_SERV_OPT_NOT_SUBSCRIBED =3D		0x21,
+	NET_GSM_SERV_TEMP_OUT_OF_ORDER =3D		0x22,
+	NET_GSM_RETRY_ENTRY_NEW_CELL_LOW =3D		0x30,
+	NET_GSM_RETRY_ENTRY_NEW_CELL_HIGH =3D		0x3F,
+	NET_GSM_SEMANTICALLY_INCORRECT =3D		0x5F,
+	NET_GSM_INVALID_MANDATORY_INFO =3D		0x60,
+	NET_GSM_MSG_TYPE_NONEXISTENT =3D			0x61,
+	NET_GSM_CONDITIONAL_IE_ERROR =3D			0x64,
+	NET_GSM_MSG_TYPE_WRONG_STATE =3D			0x65,
+	NET_GSM_PROTOCOL_ERROR_UNSPECIFIED =3D		0x6F
+};
+
+enum net_cs_type {
+	NET_CS_GSM =3D					0x00
+};
+
+enum net_rat_name {
+	NET_GSM_RAT =3D					0x01,
+	NET_UMTS_RAT =3D					0x02
+};
+
+enum net_rat_type {
+	NET_CURRENT_RAT =3D				0x00,
+	NET_SUPPORTED_RATS =3D				0x01
+};
+
+enum net_measurement_type {
+	NET_CURRENT_CELL_RSSI =3D				0x02
+};
+
+enum net_search_mode {
+	NET_MANUAL_SEARCH =3D				0x00
+};
+
+enum net_select_mode {
+	NET_SELECT_MODE_UNKNOWN =3D			0x00,
+	NET_SELECT_MODE_MANUAL =3D			0x01,
+	NET_SELECT_MODE_AUTOMATIC =3D			0x02,
+	NET_SELECT_MODE_USER_RESELECTION =3D		0x03,
+	NET_SELECT_MODE_NO_SELECTION =3D			0x04
+};
+
+enum net_isi_cause {
+	NET_CAUSE_OK =3D					0x00,
+	NET_CAUSE_COMMUNICATION_ERROR =3D			0x01,
+	NET_CAUSE_INVALID_PARAMETER =3D			0x02,
+	NET_CAUSE_NO_SIM =3D				0x03,
+	NET_CAUSE_SIM_NOT_YET_READY =3D			0x04,
+	NET_CAUSE_NET_NOT_FOUND =3D			0x05,
+	NET_CAUSE_REQUEST_NOT_ALLOWED =3D			0x06,
+	NET_CAUSE_CALL_ACTIVE =3D				0x07,
+	NET_CAUSE_SERVER_BUSY =3D				0x08,
+	NET_CAUSE_SECURITY_CODE_REQUIRED =3D		0x09,
+	NET_CAUSE_NOTHING_TO_CANCEL =3D			0x0A,
+	NET_CAUSE_UNABLE_TO_CANCEL =3D			0x0B,
+	NET_CAUSE_NETWORK_FORBIDDEN =3D			0x0C,
+	NET_CAUSE_REQUEST_REJECTED =3D			0x0D,
+	NET_CAUSE_CS_NOT_SUPPORTED =3D			0x0E,
+	NET_CAUSE_PAR_INFO_NOT_AVAILABLE =3D		0x0F,
+	NET_CAUSE_NOT_DONE =3D				0x10,
+	NET_CAUSE_NO_SELECTED_NETWORK =3D			0x11,
+	NET_CAUSE_REQUEST_INTERRUPTED =3D			0x12,
+	NET_CAUSE_TOO_BIG_INDEX =3D			0x14,
+	NET_CAUSE_MEMORY_FULL =3D				0x15,
+	NET_CAUSE_SERVICE_NOT_ALLOWED =3D			0x16,
+	NET_CAUSE_NOT_SUPPORTED_IN_TECH =3D		0x17
+};
+
+#ifdef __cplusplus
+};
+#endif
+
+#endif /* !__ISIMODEM25_NETWORK_H */
diff --git a/drivers/isimodem2.5/phonebook.c b/drivers/isimodem2.5/phoneboo=
k.c
new file mode 100644
index 0000000..397b4e5
--- /dev/null
+++ b/drivers/isimodem2.5/phonebook.c
@@ -0,0 +1,1320 @@
+/*
+ * This file is part of oFono - Open Source Telephony
+ *
+ * Copyright (C) 2009 Nokia Corporation and/or its subsidiary(-ies).
+ * Copyright (C) ST-Ericsson SA 2010.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include <gisi/client.h>
+#include <gisi/iter.h>
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/phonebook.h>
+#include "util.h"
+
+#include <glib.h>
+
+#include "debug.h"
+#include "sim.h"
+#include "simutil.h"
+#include "isimodem.h"
+#include "isiutil.h"
+#include "timeout.h"
+#include "uicc.h"
+#include "uicc_interface.h"
+
+/* File info parameters */
+#define FCP_TEMPLATE			0x62
+#define FCP_FILE_SIZE			0x80
+#define FCP_FILE_DESC			0x82
+#define FCP_FILE_ID			0x83
+#define FCP_FILE_LIFECYCLE		0x8A
+#define FCP_FILE_SECURITY_ARR		0x8B
+#define FCP_FILE_SECURITY_COMPACT	0x8C
+#define FCP_FILE_SECURITY_EXPANDED	0xAB
+
+#define UNUSED				0xff
+
+#define EXT1_CP_SUBADDRESS		1
+#define EXT1_ADDITIONAL_DATA		2
+
+#define NAME_SIZE			64
+#define NUMBER_SIZE			256
+#define EMAIL_SIZE			128
+#define EXT_NUMBER_SIZE			24
+#define SNE_SIZE			64
+
+/* TON (Type Of Number) See TS 24.008 */
+#define TON_MASK 0x70
+#define TON_INTERNATIONAL 0x10
+
+enum constructed_tag {
+	TYPE_1_TAG =3D 0xA8,
+	TYPE_2_TAG =3D 0xA9,
+	TYPE_3_TAG =3D 0xAA
+};
+
+enum file_type_tag {
+	TYPE_ADN =3D 0xC0,
+	TYPE_IAD =3D 0xC1,
+	TYPE_EXT1 =3D 0xC2,
+	TYPE_SNE =3D 0xC3,
+	TYPE_ANR =3D 0xC4,
+	TYPE_PBC =3D 0xC5,
+	TYPE_GPR =3D 0xC6,
+	TYPE_AAS =3D 0xC7,
+	TYPE_GAS =3D 0xC8,
+	TYPE_UID =3D 0xC9,
+	TYPE_EMAIL =3D 0xCA,
+	TYPE_CCP1 =3D 0xCB
+};
+
+struct pb_file_info {
+	int file_id;
+	uint8_t file_type;
+	uint8_t structure;
+	int file_length;
+	int record_length;
+	int record;
+	gboolean handled;
+};
+
+struct file_info {
+	int fileid;
+	int length;
+	int structure;
+	int record_length;
+	unsigned char access[3];
+};
+
+struct phonebook_entry {
+	int entry;
+	char *name;
+	char *number;
+	char *email;
+	char *anr;
+	char *sne;
+};
+
+struct pb_data {
+	GIsiClient *client;
+	struct ofono_sim_driver *sim_func;
+	gint pb_entry;
+	struct pb_file_info pb_reference_file_info;
+	struct pb_file_info *extension_file_info;
+	uint8_t ext1_to_type;
+	uint8_t ext1_to_entry;
+};
+
+static GSList *pb_files;
+static GSList *pb_next;
+
+static GSList *phonebook_entry_start;
+static GSList *phonebook_entry_current;
+
+static void pb_reference_info_cb(const struct ofono_error *error,
+					int filelength,
+					enum ofono_sim_file_structure structure,
+					int recordlength,
+					const unsigned char access[3],
+					unsigned char file_status, void *data);
+
+static void pb_content_data_read(struct pb_data *pbd,
+					struct pb_file_info *file_info,
+					struct isi_cb_data *cbd);
+
+static struct pb_file_info *decode_read_response(struct pb_file_info *file=
_info,
+						 const unsigned char *msg,
+						 size_t len,
+						 struct ofono_phonebook *pb)
+{
+
+	char *name =3D NULL;
+	char *number =3D NULL;
+	char *ext_number =3D NULL;
+	char *email =3D NULL;
+	char *sne =3D NULL;
+	char *anr =3D NULL;
+
+	static const char digit_to_utf8[] =3D "0123456789*#pwe\0";
+
+	struct pb_file_info *next_file =3D NULL;
+	int type =3D file_info->file_type;
+	struct pb_data *pbd =3D ofono_phonebook_get_data(pb);
+
+	switch (type) {
+	case TYPE_ADN:{
+			const uint8_t name_length =3D len - 14;
+			const uint8_t number_start =3D name_length;
+			uint8_t number_length =3D 0;
+			uint8_t extension_record =3D UNUSED;
+			uint8_t i, prefix;
+			name =3D sim_string_to_utf8(msg, name_length);
+			/* Length contains also TON&NPI */
+			number_length =3D msg[number_start];
+
+			if ((number_length !=3D UNUSED) && (number_length !=3D 0)) {
+				number =3D g_try_malloc0(NUMBER_SIZE);
+				number_length--;
+
+				if (number) {
+					prefix =3D 0;
+
+					if ((msg[number_start + 1] & TON_MASK)
+							=3D=3D TON_INTERNATIONAL) {
+						number[0] =3D '+';
+						prefix =3D 1;
+					}
+
+					for (i =3D 0; i < number_length; i++) {
+
+						number[2 * i + prefix] =3D
+							digit_to_utf8[msg
+								[number_start
+								+ 2 +
+								i] & 0x0f];
+
+						number[2 * i + 1 + prefix] =3D
+							digit_to_utf8[(msg
+								[number_start
+								+ 2 +
+								i] >> 4) &
+									0x0f];
+					}
+
+					extension_record =3D msg[len - 1];
+				}
+			}
+
+			DBG("ADN name %s, number %s number \
+				length %d extension_record %d",
+				name, number, number_length, extension_record);
+
+			if (extension_record !=3D UNUSED) {
+				next_file =3D g_try_new0(struct pb_file_info, 1);
+
+				if (next_file) {
+					if (pbd->extension_file_info) {
+						memmove(next_file,
+							pbd->
+							extension_file_info,
+							sizeof(struct
+								pb_file_info));
+					} else {
+						next_file->file_type =3D
+							TYPE_EXT1;
+						next_file->file_id =3D
+							SIM_EFEXT1_SIM_FILEID;
+					}
+
+					next_file->record =3D extension_record;
+					pbd->ext1_to_type =3D TYPE_ADN;
+					pbd->ext1_to_entry =3D pbd->pb_entry;
+				}
+			}
+
+			if (name || number) {
+				struct phonebook_entry *new_entry =3D
+					g_try_new0(struct phonebook_entry, 1);
+
+				if (new_entry) {
+					new_entry->name =3D name;
+					new_entry->number =3D number;
+
+					DBG("Creating PB entry %d with \
+						name %s and number %s",
+						pbd->pb_entry,
+						new_entry->name,
+						new_entry->number);
+
+					phonebook_entry_current =3D
+						g_slist_insert
+						(phonebook_entry_start,
+							new_entry,
+							pbd->pb_entry);
+
+					if (!phonebook_entry_start)
+						phonebook_entry_start =3D
+						phonebook_entry_current;
+
+					pbd->pb_entry++;
+				}
+			}
+
+			break;
+		}
+	case TYPE_SNE:{
+			uint8_t sne_end =3D 0;
+			const uint8_t sne_length =3D len - 2;
+			uint8_t i =3D 0;
+			uint8_t phonebook_entry_nbr =3D msg[len - 1];
+
+			DBG("SNE");
+			for (i =3D 0; (msg[i] !=3D UNUSED) && (i < sne_length); i++)
+				;
+
+			sne_end =3D i;
+			sne =3D sim_string_to_utf8(msg, sne_length);
+
+			if (sne) {
+				/* GSlist nth counts from 0,
+					PB entries from 1 */
+				GSList *list_entry =3D
+					g_slist_nth(phonebook_entry_start,
+							phonebook_entry_nbr - 1);
+
+				DBG("SNE \'%s\' to PB entry %d", sne,
+					phonebook_entry_nbr);
+
+				if (list_entry) {
+					struct phonebook_entry *entry =3D
+						list_entry->data;
+
+					if (entry) {
+						/* If one already exists,
+								delete it */
+						if (entry->sne)
+							g_free(entry->sne);
+
+						DBG("Adding SNE to entry %d,\
+							name %s",
+							phonebook_entry_nbr,
+							entry->name);
+
+						entry->sne =3D sne;
+					} else {
+						g_free(sne);
+					}
+				}
+			}
+
+			break;
+		}
+	case TYPE_ANR:{
+			uint8_t number_length =3D 0;
+			uint8_t extension_record =3D UNUSED;
+			uint8_t aas_record =3D UNUSED;
+			uint8_t i, prefix;
+			uint8_t phonebook_entry_nbr =3D msg[len - 1];
+			GSList *list_entry;
+
+			DBG("ANR");
+			if (msg[0] =3D=3D UNUSED)
+				break;
+
+			aas_record =3D msg[0];
+			/* Length contains also TON&NPI */
+			number_length =3D msg[1];
+
+			if (number_length) {
+				number_length--;
+				anr =3D g_try_malloc0(NUMBER_SIZE);
+
+				if (anr) {
+					prefix =3D 0;
+
+					if ((msg[2] & TON_MASK) =3D=3D
+					    TON_INTERNATIONAL) {
+						anr[0] =3D '+';
+						prefix =3D 1;
+					}
+
+					for (i =3D 0; i < number_length; i++) {
+						anr[2 * i + prefix] =3D
+							digit_to_utf8[msg[3 + i] &
+									0x0f];
+						anr[2 * i + 1 + prefix] =3D
+							digit_to_utf8[(msg[3 + i] >>
+								4) & 0x0f];
+					}
+
+					extension_record =3D msg[len - 3];
+				}
+			}
+
+			DBG("ANR to entry %d number %s number length %d\
+						extension_record %d aas %d",
+				phonebook_entry_nbr, anr, number_length,
+						extension_record, aas_record);
+
+			if (extension_record !=3D UNUSED) {
+				next_file =3D g_try_new0(struct pb_file_info, 1);
+
+				if (next_file) {
+					if (pbd->extension_file_info) {
+						memmove(next_file,
+							pbd->
+							extension_file_info,
+							sizeof(struct
+								pb_file_info));
+					} else {
+						next_file->file_type =3D
+							TYPE_EXT1;
+						next_file->file_id =3D
+							SIM_EFEXT1_SIM_FILEID;
+					}
+
+					next_file->record =3D extension_record;
+					pbd->ext1_to_type =3D TYPE_ANR;
+					pbd->ext1_to_entry =3D
+						phonebook_entry_nbr;
+				}
+			}
+
+			/* GSlist nth counts from 0, PB entries from 1 */
+			list_entry =3D
+				g_slist_nth(phonebook_entry_start,
+					phonebook_entry_nbr - 1);
+
+			if (list_entry) {
+				struct phonebook_entry *entry =3D
+					list_entry->data;
+
+				if (entry) {
+					/* if one already exists, delete it */
+					if (entry->anr)
+						g_free(entry->anr);
+
+					DBG("Adding ANR to entry %d, name %s",
+							phonebook_entry_nbr,
+								entry->name);
+					entry->anr =3D anr;
+				}
+			} else {
+				g_free(anr);
+			}
+
+			break;
+		}
+	case TYPE_AAS:{
+			DBG("AAS");
+			break;
+		}
+	case TYPE_EMAIL:{
+			uint8_t phonebook_entry_nbr =3D msg[len - 1];
+			email =3D sim_string_to_utf8(msg, len - 2);
+
+			/* GSlist nth counts from 0, PB entries from 1 */
+			if (email) {
+				GSList *list_entry =3D
+					g_slist_nth(phonebook_entry_start,
+						phonebook_entry_nbr - 1);
+
+				DBG("Email \'%s\' to PB entry %d", email,
+					phonebook_entry_nbr);
+				if (list_entry) {
+					struct phonebook_entry *entry =3D
+						list_entry->data;
+
+					/* if one already exists, delete it */
+					if (entry) {
+						if (entry->email)
+							g_free(entry->email);
+
+						DBG("Adding email to entry %d,\
+								 name %s",
+							phonebook_entry_nbr,
+								entry->name);
+
+						entry->email =3D email;
+					}
+				} else {
+					g_free(email);
+				}
+			}
+
+			break;
+		}
+	case TYPE_EXT1:{
+			uint8_t number_length, i, next_extension_record;
+
+			DBG("EXT1 to type=3D%02X, entry=3D%d", pbd->ext1_to_type,
+				pbd->ext1_to_entry);
+			if (msg[0] =3D=3D EXT1_ADDITIONAL_DATA) {
+				ext_number =3D g_try_malloc0(EXT_NUMBER_SIZE);
+
+				if (ext_number) {
+					number_length =3D msg[1];
+
+					for (i =3D 0; i < number_length; i++) {
+						ext_number[2 * i] =3D
+							digit_to_utf8[msg[2 + i] &
+									0x0f];
+						ext_number[2 * i + 1] =3D
+							digit_to_utf8[(msg[2 + i] >>
+									4) & 0x0f];
+					}
+
+					next_extension_record =3D
+						msg[number_length + 2];
+
+					DBG("Number extension %s\
+						number length %d\
+						extension_record %d",
+						ext_number,
+						number_length,
+						next_extension_record);
+
+					/* pb_entry is already incremented
+						& g_slist_nth counts from 0 */
+					if (pbd->ext1_to_type =3D=3D TYPE_ADN) {
+						GSList *list_entry =3D
+							g_slist_nth
+							(phonebook_entry_start,
+							pbd->ext1_to_entry - 1);
+						DBG("Looking for ADN entry %d",
+							pbd->ext1_to_entry);
+
+						if (list_entry) {
+							struct phonebook_entry
+								*entry =3D
+								list_entry->data;
+
+							if (entry) {
+								strcat(entry->
+									number,
+									ext_number);
+							}
+						}
+					} else if (pbd->ext1_to_type =3D=3D
+							TYPE_ANR) {
+						GSList *list_entry =3D
+							g_slist_nth
+							(phonebook_entry_start,
+							pbd->ext1_to_entry - 1);
+						DBG("Looking for ANR entry %d",
+							pbd->ext1_to_entry);
+
+						if (list_entry) {
+							struct phonebook_entry
+								*entry =3D
+								list_entry->data;
+
+							if (entry) {
+								strcat(entry->anr,
+								       ext_number);
+							}
+						}
+					}
+
+					g_free(ext_number);
+
+					/* Check if there is
+					more extension data */
+					if (next_extension_record !=3D UNUSED) {
+						next_file =3D
+							g_try_new0(struct
+								pb_file_info, 1);
+
+						if (next_file) {
+							if (pbd->extension_file_info) {
+								memmove
+								(next_file,
+								pbd->
+								extension_file_info,
+								sizeof
+								(struct
+								pb_file_info));
+							} else {
+								next_file->
+									file_type =3D
+									TYPE_EXT1;
+								next_file->
+									file_id =3D
+									SIM_EFEXT1_SIM_FILEID;
+							}
+
+							next_file->record =3D
+								next_extension_record;
+						}
+					}
+				}
+			}
+
+			break;
+		}
+	default:{
+			DBG("Skipping type %02X", type);
+			break;
+		}
+	}
+
+	return next_file;
+}
+
+struct pb_file_info *extension_file_info;
+
+static void pb_adn_sim_data_cb(const struct ofono_error *error,
+				const unsigned char *sdata,
+				int length, void *data)
+{
+	struct isi_cb_data *cbd_outer =3D data;
+	struct isi_cb_data *cbd =3D NULL;
+	struct pb_file_info *file_info;
+	struct ofono_phonebook *pb;
+	ofono_phonebook_cb_t cb;
+	struct pb_data *pbd;
+
+	DBG("");
+	if (!cbd_outer)
+		goto out;
+
+	file_info =3D cbd_outer->user;
+	cbd =3D cbd_outer->data;
+
+	if (!cbd)
+		goto out;
+
+	pb =3D cbd->user;
+	cb =3D cbd->cb;
+	pbd =3D ofono_phonebook_get_data(pb);
+
+	if (extension_file_info)
+		file_info =3D
+			decode_read_response(extension_file_info, sdata, length,
+						pb);
+	else
+		file_info =3D decode_read_response(file_info, sdata, length, pb);
+
+	if (file_info) {
+		DBG("Reading extension file %04X, record %d",
+			file_info->file_id, file_info->record);
+		pbd->sim_func->read_file_linear(get_sim(), file_info->file_id,
+						file_info->record,
+						file_info->record_length,
+						pb_adn_sim_data_cb, cbd_outer);
+
+		/* Delete if there is a previous one */
+		g_free(extension_file_info);
+		extension_file_info =3D file_info;
+		return;
+	} else {
+		g_free(extension_file_info);
+		extension_file_info =3D NULL;
+		file_info =3D cbd_outer->user;
+
+		if (file_info->record <
+			(file_info->file_length / file_info->record_length)) {
+
+			file_info->record++;
+			DBG("Same file, next record %d", file_info->record);
+			pbd->sim_func->read_file_linear(get_sim(),
+							file_info->file_id,
+							file_info->record,
+							file_info->
+							record_length,
+							pb_adn_sim_data_cb,
+							cbd_outer);
+		} else {
+			GSList *list_entry =3D
+				g_slist_nth(phonebook_entry_start, 0);
+			DBG("All data requested, start vCard creation");
+			g_free(file_info);
+
+			while (list_entry) {
+				struct phonebook_entry *entry =3D
+					list_entry->data;
+
+				if (entry) {
+					DBG("vCard:\nname=3D%s\nnumber=3D%s\n\
+						email=3D%s\nanr=3D%s\nsne=3D%s",
+						entry->name, entry->number,
+						entry->email, entry->anr,
+								entry->sne);
+
+					ofono_phonebook_entry(pb, -1,
+								entry->number, -1,
+								entry->name, -1,
+								NULL,
+								entry->anr, -1,
+								entry->sne,
+								entry->email,
+								NULL, NULL);
+					g_free(entry->number);
+					g_free(entry->name);
+					g_free(entry->anr);
+					g_free(entry->sne);
+					g_free(entry->email);
+					g_free(entry);
+				}
+
+				list_entry =3D g_slist_next(list_entry);
+			}
+
+			g_slist_free(phonebook_entry_start);
+			g_slist_free(pb_files);
+			g_free(cbd_outer);
+			DBG("Finally all PB data read");
+			CALLBACK_WITH_SUCCESS(cb, cbd->data);
+			goto out;
+		}
+	}
+
+	return;
+out:
+	g_free(cbd);
+	DBG("Exiting");
+}
+
+static void pb_adn_sim_info_cb(const struct ofono_error *error,
+				int filelength,
+				enum ofono_sim_file_structure structure,
+				int recordlength,
+				const unsigned char access[3],
+				unsigned char file_status, void *data)
+{
+	struct isi_cb_data *cbd =3D data;
+	struct ofono_phonebook *pb =3D cbd->user;
+	ofono_phonebook_cb_t cb =3D cbd->cb;
+	struct pb_data *pbd =3D ofono_phonebook_get_data(pb);
+	struct pb_file_info *file_info =3D NULL;
+	struct isi_cb_data *cbd_outer;
+	int records =3D 0;
+
+	DBG("");
+	if (!cbd)
+		goto error;
+
+	pb =3D cbd->user;
+	cb =3D cbd->cb;
+	pbd =3D ofono_phonebook_get_data(pb);
+	file_info =3D NULL;
+
+	if (!pbd)
+		goto error;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR)
+		goto error;
+
+	if (structure !=3D OFONO_SIM_FILE_STRUCTURE_FIXED)
+		goto error;
+
+	if (!pbd->sim_func->read_file_linear)
+		goto error;
+
+	records =3D filelength / recordlength;
+
+	if (!records)
+		goto error;
+
+	file_info =3D g_try_new0(struct pb_file_info, 1);
+
+	if (!file_info)
+		goto error;
+
+	file_info->file_id =3D SIM_EFADN_SIM_FILEID;
+	file_info->file_type =3D TYPE_ADN;
+	file_info->structure =3D structure;
+	file_info->file_length =3D filelength;
+	file_info->record_length =3D recordlength;
+	file_info->record =3D 1;
+	/* Regenerate cbd (include file_info) */
+	cbd_outer =3D isi_cb_data_new(file_info, cb, cbd);
+	pbd->sim_func->read_file_linear(get_sim(),
+					file_info->file_id,
+					file_info->record,
+					file_info->record_length,
+					pb_adn_sim_data_cb, cbd_outer);
+	return;
+error:
+
+	if (cb && cbd)
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+
+	g_free(cbd);
+}
+
+static gboolean is_reading_required(uint8_t file_type)
+{
+	switch (file_type) {
+	case TYPE_ADN:
+	case TYPE_EMAIL:
+	case TYPE_SNE:
+	case TYPE_ANR:
+		return TRUE;
+	default:
+		return FALSE;
+	}
+}
+
+static void pb_content_data_cb(const struct ofono_error *error,
+				const unsigned char *sdata,
+				int length, void *data)
+{
+	struct isi_cb_data *cbd =3D data;
+	struct ofono_phonebook *pb;
+	ofono_phonebook_cb_t cb;
+	struct pb_data *pbd;
+	struct pb_file_info *file_info =3D NULL;
+
+	if (!cbd)
+		goto out;
+
+	pb =3D cbd->user;
+	cb =3D cbd->cb;
+	pbd =3D ofono_phonebook_get_data(pb);
+
+	if (extension_file_info)
+		file_info =3D decode_read_response(extension_file_info, sdata,
+						 length, pb);
+	else
+		file_info =3D
+			decode_read_response(pb_next->data, sdata, length, pb);
+
+	if (file_info) {
+		DBG("Reading extension file %04X, record %d, structure %d",
+			file_info->file_id, file_info->record,
+			file_info->structure);
+		pb_content_data_read(pbd, file_info, cbd);
+		/* Delete if there is a previous one */
+		g_free(extension_file_info);
+		extension_file_info =3D file_info;
+		return;
+	} else {
+		g_free(extension_file_info);
+		extension_file_info =3D NULL;
+		file_info =3D pb_next->data;
+
+		if (((file_info->structure =3D=3D
+		      OFONO_SIM_FILE_STRUCTURE_FIXED) ||
+			(file_info->structure =3D=3D
+			 OFONO_SIM_FILE_STRUCTURE_CYCLIC))
+			&& (file_info->record <
+			(file_info->file_length / file_info->record_length))) {
+
+			file_info->record++;
+			DBG("Same file, next record %d", file_info->record);
+		} else {
+			g_free(file_info);
+			pb_next =3D g_slist_next(pb_next);
+			DBG("Next file in list");
+
+			if (pb_next) {
+				file_info =3D pb_next->data;
+
+				while (pb_next
+						&&
+						(!is_reading_required
+						(file_info->file_type))) {
+					DBG("Skipping file type %02X",
+						file_info->file_type);
+					g_free(file_info);
+					pb_next =3D g_slist_next(pb_next);
+
+					if (pb_next)
+						file_info =3D pb_next->data;
+				}
+			}
+
+			if (pb_next =3D=3D NULL) {
+				GSList *list_entry =3D
+					g_slist_nth(phonebook_entry_start, 0);
+
+				DBG("All data requested, start vCard creation");
+				while (list_entry) {
+					struct phonebook_entry *entry =3D
+					    list_entry->data;
+
+					if (entry) {
+						DBG("vCard:\nname=3D%s\n \
+							number=3D%s\nemail=3D%s\n \
+							anr=3D%s\nsne=3D%s",
+							entry->name,
+							entry->number,
+							entry->email,
+							entry->anr,
+							entry->sne);
+
+						ofono_phonebook_entry(pb, -1,
+								entry->number,
+								-1,
+								entry->name,
+								-1,
+								NULL,
+								entry->anr,
+								-1,
+								entry->sne,
+								entry->email,
+								NULL,
+								NULL);
+
+						g_free(entry->number);
+						g_free(entry->name);
+						g_free(entry->anr);
+						g_free(entry->sne);
+						g_free(entry->email);
+						g_free(entry);
+					}
+
+					list_entry =3D g_slist_next(list_entry);
+				}
+
+				g_slist_free(phonebook_entry_start);
+				g_slist_free(pb_files);
+				DBG("Finally all PB data read");
+				CALLBACK_WITH_SUCCESS(cb, cbd->data);
+				goto out;
+			}
+
+			file_info =3D pb_next->data;
+		}
+	}
+
+	pb_content_data_read(pbd, file_info, cbd);
+	return;
+out:
+	g_free(cbd);
+}
+
+static void pb_content_data_read(struct pb_data *pbd,
+					struct pb_file_info *file_info,
+					struct isi_cb_data *cbd)
+{
+	ofono_phonebook_cb_t cb;
+
+	if (!pbd || !file_info || !cbd)
+		goto out;
+
+	cb =3D cbd->cb;
+	DBG("Reading content of file type=3D%02X, file ID=3D%04X, structure=3D%d",
+		file_info->file_type, file_info->file_id, file_info->structure);
+
+	switch (file_info->structure) {
+	case OFONO_SIM_FILE_STRUCTURE_FIXED:
+
+		if (!pbd->sim_func->read_file_linear)
+			goto error;
+
+		pbd->sim_func->read_file_linear(get_sim(), file_info->file_id,
+						file_info->record,
+						file_info->record_length,
+						pb_content_data_cb, cbd);
+		break;
+	case OFONO_SIM_FILE_STRUCTURE_CYCLIC:
+
+		if (!pbd->sim_func->read_file_cyclic)
+			goto error;
+
+		pbd->sim_func->read_file_cyclic(get_sim(), file_info->file_id,
+						file_info->record,
+						file_info->record_length,
+						pb_content_data_cb, cbd);
+		break;
+	case OFONO_SIM_FILE_STRUCTURE_TRANSPARENT:
+
+		if (!pbd->sim_func->read_file_transparent)
+			goto error;
+
+		pbd->sim_func->read_file_transparent(get_sim(),
+							file_info->file_id, 0,
+							file_info->file_length,
+							pb_content_data_cb,
+							cbd);
+		break;
+	}
+
+	return;
+error:
+
+	if (cb && cbd)
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+
+out:
+	DBG("Exiting");
+}
+
+static void pb_content_info_cb(const struct ofono_error *error,
+				int filelength,
+				enum ofono_sim_file_structure structure,
+				int recordlength,
+				const unsigned char access[3],
+				unsigned char file_status, void *data)
+{
+	struct isi_cb_data *cbd =3D data;
+	struct ofono_phonebook *pb;
+	ofono_phonebook_cb_t cb;
+	struct pb_data *pbd;
+	struct pb_file_info *file_info =3D NULL;
+
+	if (!cbd)
+		goto error;
+
+	pb =3D cbd->user;
+	cb =3D cbd->cb;
+	pbd =3D ofono_phonebook_get_data(pb);
+
+	if (!pbd)
+		goto error;
+
+	file_info =3D pb_next->data;
+
+	if (!file_info)
+		goto error;
+
+	file_info->structure =3D structure;
+	file_info->file_length =3D filelength;
+	file_info->record_length =3D recordlength;
+	file_info->record =3D 1;
+
+	DBG("File type=3D%02X, File ID=3D%04X, Struct=3D%d, File len=3D%d, Rec le=
n=3D%d",
+		file_info->file_type, file_info->file_id, file_info->structure,
+		file_info->file_length, file_info->record_length);
+
+	if (file_info->file_type =3D=3D TYPE_EXT1)
+		/* Save for quick access */
+		pbd->extension_file_info =3D file_info;
+
+	pb_next =3D g_slist_next(pb_next);
+
+	if (pb_next =3D=3D NULL) {
+		DBG("All info requested, start content reading");
+
+		/* Re-start from beginning */
+		pb_next =3D g_slist_nth(pb_files, 0);
+		file_info =3D pb_next->data;
+
+		DBG("Calling pb_content_data_read pb=3D%p, list=3D%p, type=3D%02X",
+			cbd->user, pb_next, file_info->file_type);
+
+		pb_content_data_read(pbd, file_info, cbd);
+		return;
+	}
+
+	file_info =3D pb_next->data;
+
+	DBG("Reading next content info %04X", file_info->file_id);
+	pbd->sim_func->read_file_info(get_sim(), file_info->file_id,
+					pb_content_info_cb, cbd);
+	return;
+error:
+
+	if (cb && cbd) {
+		DBG("Error cbd=3D%p, pbd=3D%p, file_info=3D%p", cbd, pbd, file_info);
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+	}
+
+	g_free(cbd);
+}
+
+static void pb_reference_data_cb(const struct ofono_error *error,
+					const unsigned char *sdata,
+					int length, void *data)
+{
+	struct isi_cb_data *cbd =3D data;
+	struct ofono_phonebook *pb;
+	ofono_phonebook_cb_t cb;
+	struct pb_data *pbd;
+	const unsigned char *ptr =3D sdata;
+	int typelen =3D 0;
+	int i =3D 0;
+	int file_id =3D 0;
+	gboolean finished =3D FALSE;
+
+	if (!cbd)
+		goto error;
+
+	pb =3D cbd->user;
+	cb =3D cbd->cb;
+
+	if (!cb || !pb)
+		goto out;
+
+	pbd =3D ofono_phonebook_get_data(pb);
+
+	if (!pbd)
+		goto error;
+
+	while ((ptr < sdata + length) && (finished =3D=3D FALSE)) {
+		switch (*ptr) {
+		case TYPE_1_TAG:
+		case TYPE_2_TAG:
+		case TYPE_3_TAG:
+			typelen =3D *(ptr + 1);
+			DBG("File type=3D%02X, len=3D%d", *ptr, typelen);
+			ptr +=3D 2;
+			i =3D 0;
+
+			while (i < typelen) {
+				struct pb_file_info *file_info =3D
+					g_try_new0(struct pb_file_info, 1);
+				file_id =3D (ptr[i + 2] << 8) + ptr[i + 3];
+
+				DBG("creating file info for File type=3D%02X,\
+								File ID=3D%04X",
+								ptr[i],
+								file_id);
+
+				if (!file_info)
+					goto error;
+
+				file_info->file_type =3D ptr[i];
+				file_info->file_id =3D file_id;
+				pb_files =3D
+					g_slist_append(pb_files,
+							(void *)file_info);
+				i +=3D ptr[i + 1] + 2;
+			}
+
+			ptr +=3D typelen;
+			break;
+		default:
+			DBG("All handled %02x", *ptr);
+			finished =3D TRUE;
+			break;
+		}
+	}
+
+	if (pbd->pb_reference_file_info.record <
+			(pbd->pb_reference_file_info.file_length /
+			pbd->pb_reference_file_info.record_length)) {
+		pbd->pb_reference_file_info.record++;
+		DBG("Next EFpbr record %d", pbd->pb_reference_file_info.record);
+		pbd->sim_func->read_file_linear(get_sim(),
+						pbd->pb_reference_file_info.
+						file_id,
+						pbd->pb_reference_file_info.
+						record,
+						pbd->pb_reference_file_info.
+						record_length,
+						pb_reference_data_cb, cbd);
+	} else {
+		struct pb_file_info *file_info;
+		DBG("All EFpbr records read");
+		pb_next =3D g_slist_nth(pb_files, 0);
+
+		if (!pb_next)
+			goto error;
+
+		file_info =3D pb_next->data;
+
+		if (!file_info || !pbd->sim_func)
+			goto error;
+
+		pbd->sim_func->read_file_info(get_sim(), file_info->file_id,
+						pb_content_info_cb, cbd);
+	}
+
+	return;
+error:
+
+	if (cb && cbd)
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+
+out:
+	g_free(cbd);
+}
+
+static void pb_reference_info_cb(const struct ofono_error *error,
+					int filelength,
+					enum ofono_sim_file_structure structure,
+					int recordlength,
+					const unsigned char access[3],
+					unsigned char file_status,
+					void *data)
+{
+
+	struct isi_cb_data *cbd =3D data;
+	struct ofono_phonebook *pb;
+	ofono_phonebook_cb_t cb;
+	struct pb_data *pbd;
+	int records =3D 0;
+
+	DBG("");
+	if (!cbd)
+		goto error;
+
+	pb =3D cbd->user;
+	cb =3D cbd->cb;
+	pbd =3D ofono_phonebook_get_data(pb);
+
+	if (!pbd)
+		goto error;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR)
+		goto error;
+
+	if (structure !=3D OFONO_SIM_FILE_STRUCTURE_FIXED)
+		goto error;
+
+	if (!pbd->sim_func->read_file_linear)
+		goto error;
+
+	records =3D filelength / recordlength;
+
+	if (!records)
+		goto error;
+
+	DBG("EFpbr size %d, record length %d, records %d",
+		filelength, recordlength, records);
+	pbd->pb_reference_file_info.file_id =3D SIM_EFPBR_FILEID;
+	pbd->pb_reference_file_info.file_length =3D filelength;
+	pbd->pb_reference_file_info.record_length =3D recordlength;
+	pbd->pb_reference_file_info.record =3D 1;	/* Current record, not amount */
+	pbd->pb_reference_file_info.structure =3D OFONO_SIM_FILE_STRUCTURE_FIXED;
+	pbd->sim_func->read_file_linear(get_sim(), SIM_EFPBR_FILEID,
+					1, recordlength,
+					pb_reference_data_cb, cbd);
+	return;
+error:
+
+	if (cb && cbd)
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+
+	g_free(cbd);
+}
+
+static void isi_export_entries(struct ofono_phonebook *pb, const char *sto=
rage,
+				ofono_phonebook_cb_t cb, void *data)
+{
+	struct pb_data *pbd =3D ofono_phonebook_get_data(pb);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(pb, cb, data);
+
+	DBG("Storage %s", storage);
+	if (strcmp(storage, "SM"))	/* Only for SIM memory */
+		goto error;
+
+	if (!pbd->sim_func->read_file_info)
+		goto error;
+
+	if (!cbd)
+		goto error;
+
+	pbd->pb_entry =3D 1;
+	pb_files =3D NULL;
+	pb_next =3D NULL;
+	phonebook_entry_current =3D NULL;
+	phonebook_entry_start =3D NULL;
+
+	switch (get_app_type()) {
+	case UICC_APPL_TYPE_ICC_SIM:
+		DBG("SIM application");
+		pbd->sim_func->read_file_info(get_sim(), SIM_EFADN_SIM_FILEID,
+						pb_adn_sim_info_cb, cbd);
+		break;
+	case UICC_APPL_TYPE_UICC_USIM:
+		DBG("USIM application");
+		pbd->sim_func->read_file_info(get_sim(), SIM_EFPBR_FILEID,
+						pb_reference_info_cb, cbd);
+		break;
+	default:
+		DBG("UICC application type not unknown or supported");
+		goto error;
+		break;
+	}
+
+	return;
+error:
+
+	if (cb && cbd)
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+
+	g_free(cbd);
+}
+
+static gboolean isi_phonebook_register(gpointer user)
+{
+	struct ofono_phonebook *pb =3D user;
+	DBG("");
+	ofono_phonebook_register(pb);
+	return FALSE;
+}
+
+static void reachable_cb(GIsiClient *client, gboolean alive, uint16_t obje=
ct,
+			 void *opaque)
+{
+	struct ofono_phonebook *pb =3D opaque;
+
+	if (!alive) {
+		DBG("Unable to bootstrap phonebook driver");
+		return;
+	}
+
+	DBG("%s (v%03d.%03d) reachable",
+		pn_resource_name(g_isi_client_resource(client)),
+		g_isi_version_major(client), g_isi_version_minor(client));
+	g_idle_add(isi_phonebook_register, pb);
+}
+
+static int isi_phonebook_probe(struct ofono_phonebook *pb, unsigned int ve=
ndor,
+				void *user)
+{
+	GIsiModem *idx =3D user;
+	struct pb_data *data =3D g_try_new0(struct pb_data, 1);
+	DBG("");
+
+	if (!data)
+		return -ENOMEM;
+
+	data->client =3D get_pn_uicc_client(idx, PN_UICC);
+
+	if (!data->client) {
+		g_free(data);
+		return -ENOMEM;
+	}
+
+	data->sim_func =3D get_sim_driver_func();
+	ofono_phonebook_set_data(pb, data);
+
+	if (!g_isi_verify(data->client, reachable_cb, pb))
+		DBG("Unable to verify reachability");
+
+	return 0;
+}
+
+static void isi_phonebook_remove(struct ofono_phonebook *pb)
+{
+	struct pb_data *data =3D ofono_phonebook_get_data(pb);
+	DBG("");
+	pb_files =3D NULL;
+	pb_next =3D NULL;
+	phonebook_entry_start =3D NULL;
+	phonebook_entry_current =3D NULL;
+
+	if (data) {
+		pn_uicc_client_destroy(data->client);
+		g_free(data);
+	}
+}
+
+static struct ofono_phonebook_driver driver =3D {
+	.name =3D "isimodem25",
+	.probe =3D isi_phonebook_probe,
+	.remove =3D isi_phonebook_remove,
+	.export_entries =3D isi_export_entries
+};
+
+void isi_phonebook_init()
+{
+	DBG("");
+	ofono_phonebook_driver_register(&driver);
+}
+
+void isi_phonebook_exit()
+{
+	DBG("");
+	ofono_phonebook_driver_unregister(&driver);
+}
diff --git a/drivers/isimodem2.5/radio-settings.c b/drivers/isimodem2.5/rad=
io-settings.c
new file mode 100644
index 0000000..237fd72
--- /dev/null
+++ b/drivers/isimodem2.5/radio-settings.c
@@ -0,0 +1,313 @@
+/*
+ * This file is part of oFono - Open Source Telephony
+ *
+ * Copyright (C) 2010 Nokia Corporation and/or its subsidiary(-ies).
+ * Copyright (C) ST-Ericsson SA 2010.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include <gisi/client.h>
+#include <gisi/iter.h>
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/radio-settings.h>
+
+#include <glib.h>
+
+#include "debug.h"
+#include "gss.h"
+#include "network.h"
+#include "isimodem.h"
+#include "isiutil.h"
+#include "timeout.h"
+
+struct radio_data {
+	GIsiClient *client;
+};
+
+static enum ofono_radio_access_mode isi_mode_to_ofono_mode(guint8 mode)
+{
+	switch (mode) {
+	case GSS_DUAL_RAT:
+		return OFONO_RADIO_ACCESS_MODE_ANY;
+	case GSS_GSM_RAT:
+		return OFONO_RADIO_ACCESS_MODE_GSM;
+	case GSS_UMTS_RAT:
+		return OFONO_RADIO_ACCESS_MODE_UMTS;
+	default:
+		return -1;
+	}
+}
+
+static int ofono_mode_to_isi_mode(enum ofono_radio_access_mode mode)
+{
+	switch (mode) {
+	case OFONO_RADIO_ACCESS_MODE_ANY:
+		return GSS_DUAL_RAT;
+	case OFONO_RADIO_ACCESS_MODE_GSM:
+		return GSS_GSM_RAT;
+	case OFONO_RADIO_ACCESS_MODE_UMTS:
+		return GSS_UMTS_RAT;
+	default:
+		return -1;
+	}
+}
+
+static gboolean rat_mode_read_resp_cb(GIsiClient *client,
+						const void *restrict data,
+						size_t len,
+						uint16_t object,
+						void *opaque)
+{
+	const unsigned char *msg =3D data;
+	struct isi_cb_data *cbd =3D opaque;
+	ofono_radio_settings_rat_mode_query_cb_t cb =3D cbd->cb;
+	int mode =3D -1;
+
+	if (!msg) {
+		DBG("ISI client error: %d", g_isi_client_error(client));
+		goto error;
+	}
+
+	DBG("%s", gss_message_id_name(msg[0]));
+
+	if (len < 3) {
+		DBG("truncated message");
+		return FALSE;
+	}
+
+	if (msg[0] =3D=3D GSS_CS_SERVICE_FAIL_RESP)
+		goto error;
+
+	if (msg[0] =3D=3D GSS_CS_SERVICE_RESP) {
+		GIsiSubBlockIter iter;
+
+		for (g_isi_sb_iter_init(&iter, msg, len, 3);
+				g_isi_sb_iter_is_valid(&iter);
+				g_isi_sb_iter_next(&iter)) {
+			switch (g_isi_sb_iter_get_id(&iter)) {
+			case GSS_RAT_INFO: {
+				guint8 isi_mode;
+
+				if (!g_isi_sb_iter_get_byte(&iter,
+								&isi_mode, 2))
+					goto error;
+
+				mode =3D isi_mode_to_ofono_mode(isi_mode);
+				DBG("ISI mode=3D%d, oFono mode=3D%d",
+					isi_mode, mode);
+				break;
+			}
+			default:
+				DBG("Skipping sub-block: %s (%zu bytes)",
+					gss_subblock_name(
+						g_isi_sb_iter_get_id(&iter)),
+					g_isi_sb_iter_get_len(&iter));
+				break;
+			}
+		}
+
+		CALLBACK_WITH_SUCCESS(cb, mode, cbd->data);
+		goto out;
+	}
+
+	return FALSE;
+error:
+	CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
+out:
+	g_free(cbd);
+	return TRUE;
+}
+
+static void isi_query_rat_mode(struct ofono_radio_settings *rs,
+				ofono_radio_settings_rat_mode_query_cb_t cb,
+				void *data)
+{
+	struct radio_data *rd =3D ofono_radio_settings_get_data(rs);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(rd, cb, data);
+	const unsigned char msg[] =3D {
+		GSS_CS_SERVICE_REQ,
+		GSS_SELECTED_RAT_READ,
+		0x00 /* subblock count */
+	};
+	DBG("");
+
+	if (!cbd)
+		goto error;
+
+	if (g_isi_request_make(rd->client, msg, sizeof(msg), GSS_TIMEOUT,
+				rat_mode_read_resp_cb, cbd))
+		return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, -1, data);
+	g_free(cbd);
+}
+
+static gboolean mode_write_resp_cb(GIsiClient *client,
+					const void *restrict data, size_t len,
+					uint16_t object, void *opaque)
+{
+	const unsigned char *msg =3D data;
+	struct isi_cb_data *cbd =3D opaque;
+	ofono_radio_settings_rat_mode_set_cb_t cb =3D cbd->cb;
+
+	if (!msg) {
+		DBG("ISI client error: %d", g_isi_client_error(client));
+		goto error;
+	}
+
+	DBG("%s", gss_message_id_name(msg[0]));
+
+	if (len < 3) {
+		DBG("truncated message");
+		return FALSE;
+	}
+
+	if (msg[0] =3D=3D GSS_CS_SERVICE_FAIL_RESP)
+		goto error;
+
+	if (msg[0] =3D=3D GSS_CS_SERVICE_RESP) {
+		CALLBACK_WITH_SUCCESS(cb, cbd->data);
+		goto out;
+	}
+
+	return FALSE;
+error:
+	CALLBACK_WITH_FAILURE(cb, cbd->data);
+out:
+	g_free(cbd);
+	return TRUE;
+}
+
+static void isi_set_rat_mode(struct ofono_radio_settings *rs,
+				enum ofono_radio_access_mode mode,
+				ofono_radio_settings_rat_mode_set_cb_t cb,
+				void *data)
+{
+	struct radio_data *rd =3D ofono_radio_settings_get_data(rs);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(rd, cb, data);
+	int isi_mode =3D ofono_mode_to_isi_mode(mode);
+	const unsigned char msg[] =3D {
+		GSS_CS_SERVICE_REQ,
+		GSS_SELECTED_RAT_WRITE,
+		0x01, /* subblock count */
+		GSS_RAT_INFO,
+		0x04, /* subblock length */
+		isi_mode,
+		0x00 /* filler */
+	};
+	DBG("oFono RAT mode=3D%d, ISI mode=3D%d", mode, isi_mode);
+
+	if (!cbd)
+		goto error;
+
+	if (isi_mode =3D=3D -1)
+		goto error;
+
+	if (g_isi_request_make(rd->client, msg, sizeof(msg), GSS_TIMEOUT,
+				mode_write_resp_cb, cbd))
+		return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, data);
+	g_free(cbd);
+}
+
+static gboolean isi_radio_settings_register(gpointer user)
+{
+	struct ofono_radio_settings *rs =3D user;
+	ofono_radio_settings_register(rs);
+	return FALSE;
+}
+
+static void reachable_cb(GIsiClient *client, gboolean alive, uint16_t obje=
ct,
+				void *opaque)
+{
+	struct ofono_radio_settings *rs =3D opaque;
+
+	if (!alive) {
+		DBG("Radio settings driver bootstrap failed");
+		return;
+	}
+
+	DBG("%s (v%03d.%03d) reachable",
+		pn_resource_name(g_isi_client_resource(client)),
+		g_isi_version_major(client),
+		g_isi_version_minor(client));
+	g_idle_add(isi_radio_settings_register, rs);
+}
+
+static int isi_radio_settings_probe(struct ofono_radio_settings *rs,
+					unsigned int vendor,
+					void *user)
+{
+	GIsiModem *idx =3D user;
+	struct radio_data *rd =3D g_try_new0(struct radio_data, 1);
+
+	if (!rd)
+		return -ENOMEM;
+
+	rd->client =3D g_isi_client_create(idx, PN_GSS);
+
+	if (!rd->client) {
+		g_free(rd);
+		return -ENOMEM;
+	}
+
+	ofono_radio_settings_set_data(rs, rd);
+	g_isi_verify(rd->client, reachable_cb, rs);
+	return 0;
+}
+
+static void isi_radio_settings_remove(struct ofono_radio_settings *rs)
+{
+	struct radio_data *rd =3D ofono_radio_settings_get_data(rs);
+
+	if (rd->client)
+		g_isi_client_destroy(rd->client);
+
+	g_free(rd);
+}
+
+static struct ofono_radio_settings_driver driver =3D {
+	.name			=3D "isimodem25",
+	.probe			=3D isi_radio_settings_probe,
+	.remove			=3D isi_radio_settings_remove,
+	.query_rat_mode		=3D isi_query_rat_mode,
+	.set_rat_mode		=3D isi_set_rat_mode
+};
+
+void isi_radio_settings_init()
+{
+	ofono_radio_settings_driver_register(&driver);
+}
+
+void isi_radio_settings_exit()
+{
+	ofono_radio_settings_driver_unregister(&driver);
+}
diff --git a/drivers/isimodem2.5/simu_resps.h b/drivers/isimodem2.5/simu_re=
sps.h
new file mode 100644
index 0000000..043cec6
--- /dev/null
+++ b/drivers/isimodem2.5/simu_resps.h
@@ -0,0 +1,6800 @@
+/*
+ * This file is part of oFono - Open Source Telephony
+ *
+ * Copyright (C) ST-Ericsson SA 2010.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+#include <stdint.h>
+#include <drivers/isimodem2.5/mce.h>
+#include <drivers/isimodem2.5/gpds.h>
+#include <drivers/isimodem2.5/sms.h>
+#include <drivers/isimodem2.5/network.h>
+#include <drivers/isimodem2.5/call.h>
+#include <drivers/isimodem2.5/uicc.h>
+#include <drivers/isimodem2.5/info.h>
+#include <drivers/isimodem2.5/ss.h>
+#include <drivers/isimodem2.5/gss.h>
+#include <gisi/pipe_wg25.h>
+#include <src/simutil.h>
+
+/*struct ofono_modem *fake_modem;*/
+struct isimodem25_simu {
+	GIsiClient *client;
+	uint8_t request;
+	GIsiResponseFunc first_cb;
+	struct isi_cb_data *cbd;
+	unsigned char *nextmsg;
+	unsigned char *longreq;
+};
+
+struct isimodem25_response {
+	uint8_t resource;
+	uint8_t request;
+	const unsigned char *response;
+	uint8_t len;
+	const unsigned char *next;
+	const uint16_t *longreq;
+	const uint8_t reqlen;
+};
+
+/* UICC type defintions */
+#define         UICC_TYPE 2
+
+/* NET_MODEM Simulation messages */
+const uint16_t reg_auto[] =3D {
+	NET_SET_REQ,
+	-1,			/* Registered in another protocol? */
+	0x01,			/* Sub-block count */
+	NET_OPERATOR_INFO_COMMON,
+	0x04,			/* Sub-block length */
+	NET_SELECT_MODE_USER_RESELECTION,
+	0x00			/* Index not used */
+};
+
+const unsigned char set_auto_resp_cb_msg[] =3D {
+	NET_SET_RESP,
+	NET_CAUSE_OK,
+	2,			/* Number of sub-blocks */
+	NET_MODEM_REG_INFO_COMMON,
+	4,
+	NET_REG_STATUS_HOME,
+	NET_SELECT_MODE_AUTOMATIC,
+	/* Extra Sub-block (check code coverage) */
+	NET_RAT_INFO,		/* (=3D 0x2C) */
+	4,
+	NET_GSM_RAT,
+	0,
+};
+
+const uint16_t reg_manual[] =3D {
+	NET_SET_REQ,
+	-1,			/* Registered in another protocol? */
+	-1,			/* Sub-block count */
+	NET_OPERATOR_INFO_COMMON,
+	0x04,			/* Sub-block length */
+	NET_SELECT_MODE_MANUAL,
+	0x00			/* Index not used */
+};
+
+const unsigned char set_manual_resp_cb_msg[] =3D {
+	NET_SET_RESP,
+	NET_CAUSE_OK,
+	2,			/* Number of sub-blocks */
+	NET_MODEM_REG_INFO_COMMON,
+	4,
+	NET_REG_STATUS_HOME,
+	NET_SELECT_MODE_MANUAL,
+	/* Extra Sub-block (check code coverage) */
+	NET_RAT_INFO,		/* (=3D 0x2C) */
+	4,
+	NET_GSM_RAT,
+	0,
+};
+
+const unsigned char reg_status_resp_cb_auto_msg[] =3D {
+	NET_MODEM_REG_STATUS_GET_RESP,
+	NET_CAUSE_OK,
+	3,			/* Number of sub-blocks */
+	/* Subblock 1 */
+	NET_MODEM_REG_INFO_COMMON,
+	4,			/*len */
+	NET_REG_STATUS_HOME, /*=3D0*/
+	NET_SELECT_MODE_AUTOMATIC, /*=3D2*/
+	/* Subblock 2 */
+	NET_MODEM_GSM_REG_INFO,
+	24,			/*len */
+	2, 1, /*LAC*/ 0, 0, 0, 15,	/*cell id */
+	0x42, 0xF4, 0x50,	/*BCD operator code (MCC & MNC) */
+	NET_GSM_BAND_900_1800,
+	NET_GSM_HOME_PLMN,
+	0,			/*GPRS support true/false */
+	NET_GPRS_MODE_NONE,
+	1,			/*CS services */
+	0,			/*GPRS serv */
+	0,			/*EGPRS support */
+	0,			/*DTM support */
+	0, /*RAC*/ 0, /*HSDPA*/ 0, /*HSUPA*/ 1,	/*camped in HPLMN */
+	NET_GSM_RAT,		/* RAT name */
+	/* Extra Sub-block (check code coverage) */
+	NET_RAT_INFO,		/* (=3D 0x2C) */
+	4,
+	NET_GSM_RAT,
+	0,
+};
+
+const unsigned char rssi_resp_cb_msg[] =3D {
+	NET_RSSI_GET_RESP,
+	NET_CAUSE_OK,
+	2,
+	/* Sub-block 1 */
+	NET_RSSI_CURRENT,
+	4,
+	75,			/*signal bars % */
+	80,			/*dBm */
+	/* Extra Sub-block (check code coverage) */
+	NET_RAT_INFO,		/* (=3D 0x2C) */
+	4,
+	NET_GSM_RAT,
+	0,
+};
+
+const unsigned char rssi_ind_cb_msg[] =3D {
+	NET_RSSI_IND,
+	50,			/*signal bars % */
+	100			/*dBm */
+};
+
+const unsigned char reg_status_ind_cb_msg[] =3D {
+	NET_MODEM_REG_STATUS_IND,
+	0,			/*filler */
+	2,			/*number of sub-blocks */
+	/* Sub-block 1 */
+	NET_MODEM_REG_INFO_COMMON,
+	4,			/*len */
+	NET_REG_STATUS_HOME, /*=3D1*/
+	NET_SELECT_MODE_AUTOMATIC, /*=3D2*(*/
+	/* Extra Sub-block (check code coverage) */
+	NET_RAT_INFO,		/* (=3D 0x2C) */
+	4,
+	NET_GSM_RAT,
+	0,
+};
+
+const unsigned char rat_ind_cb_msg[] =3D {
+	NET_RAT_IND,		/* (=3D 0x35) */
+	0,			/*Filler */
+	2,			/*number of sub-blocks */
+	/* Sub-block 1 */
+	NET_RAT_INFO,		/* (=3D 0x2C) */
+	8,
+	NET_GSM_RAT,
+	1,
+	0,
+	0, 0, 0,
+	/* Sub-block 1 */
+	NET_RAT_INFO,		/* (=3D 0x2C) */
+	4,
+	NET_UMTS_RAT,
+	0,
+};
+
+const unsigned char rat_resp[] =3D {
+	NET_RAT_RESP,
+	NET_CAUSE_OK,
+	2,			/*number of sub-blocks */
+	/* Sub-block 1 */
+	NET_RAT_INFO,		/* (=3D 0x2C) */
+	8,
+	NET_GSM_RAT,
+	1,
+	0,
+	0, 0, 0,
+	/* Sub-block 1 */
+	NET_RAT_INFO,		/* (=3D 0x2C) */
+	4,
+	NET_UMTS_RAT,
+	0,
+};
+
+const unsigned char available_resp_cb_msg[] =3D {
+	NET_MODEM_AVAILABLE_GET_RESP,
+	NET_CAUSE_OK,
+	7,			/*number of sub-blocks */
+	/* Sub-block 1 */
+	NET_MODEM_AVAIL_NETWORK_INFO_COMMON,
+	4,
+	NET_OPER_STATUS_CURRENT,
+	15,			/*index of CS arrays */
+	/* Sub-block 2 */
+	NET_MODEM_DETAILED_NETWORK_INFO,
+	12,
+	0x42, 0xF4, 0x50,	/*BCD operator code */
+	NET_GSM_BAND_900_1800,
+	NET_GSM_PREFERRED_PLMN,
+	NET_UMTS_NOT_AVAILABLE,
+	0x05, 0x00,		/* LAC */
+	0,			/*Filler */
+	0,			/*Filler */
+	/* Sub-block 3 */
+	NET_MODEM_AVAIL_NETWORK_INFO_COMMON,
+	4,
+	NET_OPER_STATUS_FORBIDDEN,
+	254,			/*index of CS arrays */
+	/* Sub-block 4 */
+	NET_MODEM_DETAILED_NETWORK_INFO,
+	12,
+	0x42, 0xF4, 0x19,	/*BCD operator code (MCC & MNC) */
+	NET_GSM_BAND_900_1800,
+	NET_GSM_PREFERRED_PLMN,
+	NET_UMTS_NOT_AVAILABLE,
+	0x00, 0x04,		/* LAC */
+	0,			/*Filler */
+	0,			/*Filler */
+	/* Sub-block 5 */
+	NET_MODEM_AVAIL_NETWORK_INFO_COMMON,
+	4,
+	NET_OPER_STATUS_AVAILABLE,
+	4,			/*index of CS arrays */
+	/* Sub-block 6 */
+	NET_MODEM_DETAILED_NETWORK_INFO,
+	12,
+	0x42, 0xF0, 0x07,	/*BCD operator code (MCC & MNC) */
+	NET_GSM_BAND_900_1800,
+	NET_GSM_PREFERRED_PLMN,
+	NET_UMTS_AVAILABLE,
+	0x00, 0x04,		/* LAC */
+	0,			/*Filler */
+	0,			/*Filler */
+	/* Extra Sub-block (check code coverage) */
+	NET_RAT_INFO,		/* (=3D 0x2C) */
+	4,
+	NET_GSM_RAT,
+	0,
+};
+
+const unsigned char cell_info_resp_cb_msg[] =3D {
+	NET_CELL_INFO_GET_RESP,
+	NET_CAUSE_OK,
+	3,			/*number of sub-blocks */
+	/* Sub-block 1 */
+	NET_WCDMA_CELL_INFO,
+	20,			/*len */
+	01, 02, /*LAC*/ 0, 0, 0, 63,	/*Cell Id */
+	0, 0, 0, 0,		/*Bands info */
+	0x42, 0xF4, 0x50,	/*BCD operator code */
+	NET_SERVICE,
+	NET_GSM_HOME_PLMN,
+	0, 0, 0,		/* filler */
+	/* Sub-block 2 */
+	NET_GSM_CELL_INFO,
+	20,			/*len */
+	01, 02, /*LAC*/ 0, 0, 0, 63,	/*Cell Id */
+	0, 0, 0, 0,		/*Bands info */
+	0x42, 0xF4, 0x50,	/*BCD operator code */
+	NET_SERVICE,
+	NET_GSM_HOME_PLMN,
+	0, 0, 0,		/* filler */
+	/* Extra Sub-block (check code coverage) */
+	NET_RAT_INFO,		/* (=3D 0x2C) */
+	4,
+	NET_GSM_RAT,
+	0,
+};
+
+const unsigned char nitz_name_ind_msg[] =3D {
+	NET_NITZ_NAME_IND,
+	0x42, 0xF4, 0x50,	/*BCD operator code (MCC & MNC) */
+	0, 0,			/*Filler */
+	1,			/*number of sub-blocks */
+	/* Sub-block 1 */
+	NET_SHORT_NITZ_NAME,
+	12,			/*SB Len */
+	3,			/*Data len */
+	0,			/*Filler */
+	/*Network IE, see TS24.008 */
+	0,			/*Network Name IEI (ETSI spec. not found) */
+	1,			/*Len */
+	0x80,			/*Coding scheme etc */
+	0, 'A',			/*Name */
+	0, 0, 0,		/*Filler */
+	/* Extra Sub-block (check code coverage) */
+	NET_RAT_INFO,		/* (=3D 0x2C) */
+	4,
+	NET_GSM_RAT,
+	0,
+};
+
+const unsigned char net_cs_state_resp[] =3D {
+	NET_CS_STATE_RESP,
+	0x00,
+	0x01,
+	0x00,
+};
+
+const unsigned char net_cs_state_ind_msg[] =3D {
+	NET_CS_STATE_IND,
+	0x01,
+	0x00,
+	0x00,
+	0x00, 0x00, 0x00,	/* Fillers */
+};
+
+const unsigned char net_cs_control_resp[] =3D {
+	NET_CS_CONTROL_RESP,
+	0x00,
+	0x00,
+	0x03,
+};
+
+/* GSS NET_MODEM Simulation messages */
+const uint16_t rat_query_req[] =3D {
+	GSS_CS_SERVICE_REQ,
+	GSS_SELECTED_RAT_READ
+};
+
+const unsigned char rat_query_resp_msg[] =3D {
+	GSS_CS_SERVICE_RESP,
+	GSS_SELECTED_RAT_READ,
+	4,			/*Number of sub-block */
+	/* Sub-block 1 */
+	GSS_RAT_INFO,
+	4,
+	GSS_DUAL_RAT,
+	0,
+	/* Sub-block 2 */
+	GSS_RAT_INFO,
+	4,
+	GSS_GSM_RAT,
+	0,
+	/* Sub-block 3 */
+	GSS_RAT_INFO,
+	4,
+	GSS_UMTS_RAT,
+	0,
+	/* Extra Sub-block */
+	0xfe,
+	2,
+};
+
+const uint16_t rat_set_any_req[] =3D {
+	GSS_CS_SERVICE_REQ,
+	GSS_SELECTED_RAT_WRITE,
+	-1, -1, -1,
+	GSS_DUAL_RAT
+};
+
+const unsigned char rat_set_any_resp_msg[] =3D {
+	GSS_CS_SERVICE_RESP,
+	GSS_SELECTED_RAT_WRITE,
+	1,			/* Number of sub-block */
+	/* Sub-block 1 */
+	GSS_RAT_INFO,
+	4,
+	GSS_DUAL_RAT,
+	0,
+};
+
+const uint16_t rat_set_umts_req[] =3D {
+	GSS_CS_SERVICE_REQ,
+	GSS_SELECTED_RAT_WRITE,
+	-1, -1, -1,
+	GSS_UMTS_RAT
+};
+
+const unsigned char rat_set_umts_resp_msg[] =3D {
+	GSS_CS_SERVICE_RESP,
+	GSS_SELECTED_RAT_WRITE,
+	1,			/*Number of sub-block */
+	/* Sub-block 1 */
+	GSS_RAT_INFO,
+	4,
+	GSS_UMTS_RAT,
+	0,
+};
+
+const uint16_t rat_set_gsm_req[] =3D {
+	GSS_CS_SERVICE_REQ,
+	GSS_SELECTED_RAT_WRITE,
+	-1, -1, -1,
+	GSS_GSM_RAT
+};
+
+const unsigned char rat_set_gsm_resp_msg[] =3D {
+	GSS_CS_SERVICE_RESP,
+	GSS_SELECTED_RAT_WRITE,
+	1,			/*Number of sub-block */
+	/* Sub-block 1 */
+	GSS_RAT_INFO,
+	4,
+	GSS_GSM_RAT,
+	0,
+};
+
+/* MCE Simulation messages set 1 */
+const unsigned char rf_on_resp_ok[] =3D {
+	MCE_RF_STATE_RESP,
+	MCE_OK, 0x00		/* Filler */
+};
+
+const unsigned char rf_state_query_resp[] =3D {
+	MCE_RF_STATE_QUERY_RESP,
+	MCE_RF_ON,		/*Current */
+	MCE_RF_ON		/*Target */
+};
+
+unsigned char modem_state_normal_ind[] =3D {
+	MCE_MODEM_STATE_IND,
+	MCE_OK, 0x00		/* Filler */
+};
+
+const unsigned char modem_state_query_resp_ok[] =3D {
+	MCE_MODEM_STATE_QUERY_RESP,
+	MCE_NORMAL, MCE_NORMAL
+};
+
+/* GPRS Simulation messages */
+const unsigned char gpds_attach_resp_msg[] =3D {
+	GPDS_ATTACH_RESP, GPDS_OK,
+	GPDS_CAUSE_UNKNOWN,
+	GPDS_ATTACH_TYPE_GPRS
+};
+
+const unsigned char gpds_status_resp_attached_msg[] =3D {
+	GPDS_STATUS_RESP, GPDS_ATTACHED, 0x00,
+	0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00,
+	GPDS_TRANSFER_AVAIL, GPDS_TRANSFER_CAUSE_ATTACHED
+};
+
+const unsigned char gpds_transfer_status_ind_not_avail_detach_msg[] =3D {
+	GPDS_TRANSFER_STATUS_IND,
+	GPDS_TRANSFER_NOT_AVAIL, GPDS_TRANSFER_CAUSE_DETACHED
+};
+
+const unsigned char gpds_detach_resp_msg[] =3D {
+	GPDS_DETACH_RESP, GPDS_OK, GPDS_DETACH_TYPE_GPRS_MO
+};
+
+const unsigned char gpds_detach_ind_msg1[] =3D {
+	GPDS_DETACH_IND,
+	GPDS_CAUSE_DETACHED,
+	GPDS_DETACH_TYPE_GPRS_MO
+};
+
+const unsigned char gpds_configure_resp_msg[] =3D {
+	GPDS_CONFIGURE_RESP, GPDS_OK
+};
+
+const unsigned char gpds_context_id_create_resp_msg1[] =3D {
+	GPDS_CONTEXT_ID_CREATE_RESP, 0x01, GPDS_OK
+};
+
+const unsigned char gpds_ll_configure_resp_msg1[] =3D {
+	GPDS_LL_CONFIGURE_RESP, 0x01, GPDS_OK
+};
+
+const unsigned char gpds_context_configure_resp_msg1[] =3D {
+	GPDS_CONTEXT_CONFIGURE_RESP, 0x01, GPDS_OK
+};
+
+const unsigned char gpds_context_auth_resp_msg1[] =3D {
+	GPDS_CONTEXT_AUTH_RESP, 0x01, GPDS_OK
+};
+
+const unsigned char gpds_context_activate_resp_msg1[] =3D {
+	GPDS_CONTEXT_ACTIVATE_RESP, 0x01,
+	GPDS_OK, GPDS_CAUSE_UNKNOWN,
+	0x00, 0x00, 0x00
+};
+
+const unsigned char gpds_context_activate_ind_msg1[] =3D {
+	GPDS_CONTEXT_ACTIVATE_IND, 0x01, 0x04,
+	GPDS_PDP_ADDRESS_INFO, 0x08, 0x00, 0x04,
+	0x7F, 0x00, 0x00, 0x00,
+	GPDS_PDNS_ADDRESS_INFO, 0x08, 0x00, 0x04,
+	0x0A, 0x00, 0x00, 0x02,
+	GPDS_SDNS_ADDRESS_INFO, 0x08, 0x00, 0x04,
+	0x0A, 0x00, 0x00, 0x02,
+	GPDS_APN_INFO, 0x0C, 0X08,
+	0x69, 0x6E, 0x74, 0x65, 0x72, 0x69, 0x65, 0x74, 0x00
+};
+
+const unsigned char gpds_context_deactivate_resp_msg1[] =3D {
+	GPDS_CONTEXT_DEACTIVATE_RESP, 0x01, GPDS_OK
+};
+
+const unsigned char gpds_context_deactivate_ind_msg1[] =3D {
+	GPDS_CONTEXT_DEACTIVATE_IND, 0x01,
+	GPDS_CAUSE_DEACT_REGULAR, 0x00, 0x00, 0x00, 0x00
+};
+
+const unsigned char gpds_context_id_delete_ind_msg1[] =3D {
+	GPDS_CONTEXT_ID_DELETE_IND, 0x01
+};
+
+/* PIPE Simulation messages */
+const unsigned char pns_pep_connect_resp_msg1[] =3D {
+	PNS_PEP_CONNECT_RESP,
+	0x01,
+	PN_PIPE_NO_ERROR,
+	0x00, 0x00, 0x00, 0x00
+};
+
+const unsigned char pns_pep_disconnect_resp_msg1[] =3D {
+	PNS_PEP_DISCONNECT_RESP, 0x01, PN_PIPE_NO_ERROR
+};
+
+const unsigned char pns_pep_enable_resp_msg1[] =3D {
+	PNS_PEP_ENABLE_RESP, 0x01, PN_PIPE_NO_ERROR
+};
+
+/* UICC Simulation messages */
+const unsigned char uicc_card_ind_card_ready[] =3D {
+	UICC_CARD_IND,
+	UICC_CARD_READY,
+	UICC_CARD_TYPE_UICC
+};
+
+const unsigned char uicc_pin1_ind_pin_required[] =3D {
+	UICC_PIN_IND,
+	UICC_PIN_VERIFY_NEEDED,
+	/*PIN ID, PIN1=3D1...8, PIN2=3D0x81...0x88,
+	 * 0x11=3DPHNET_PIN what ever it means
+	 */
+	0x01,
+	1,			/*application id */
+	0,			/*filler */
+	0,			/*filler */
+	0			/*filler */
+};
+
+const unsigned char uicc_pin2_ind_pin_required[] =3D {
+	UICC_PIN_IND,
+	UICC_PIN_VERIFY_NEEDED,
+	0x81,
+	1,			/*application id */
+	0,			/*filler */
+	0,			/*filler */
+	0			/*filler */
+};
+
+const unsigned char uicc_pin1_ind_pin_verified[] =3D {
+	UICC_PIN_IND,
+	UICC_PIN_VERIFIED,
+	/*PIN ID, PIN1=3D1...8, PIN2=3D0x81...0x88,
+	 * 0x11=3DPHNET_PIN what ever it means
+	 */
+	0x01,
+	1,			/*application id */
+	0,			/*filler */
+	0,			/*filler */
+	0			/*filler */
+};
+
+const unsigned char uicc_pin2_ind_pin_verified[] =3D {
+	UICC_PIN_IND,
+	UICC_PIN_VERIFIED,
+	0x81,			/*PIN ID, PIN1=3D1...8, PIN2=3D0x81...0x88,
+				 * 0x11=3DPHNET_PIN what ever it means
+				 */
+	1,			/*application id */
+	0,			/*filler */
+	0,			/*filler */
+	0			/*filler */
+};
+
+const unsigned char uicc_pin_phnet_ind_pin_verified[] =3D {
+	UICC_PIN_IND,
+	UICC_PIN_VERIFIED,
+	/*PIN ID, PIN1=3D1...8, PIN2=3D0x81...0x88,
+	 * 0x11=3DPHNET_PIN what ever it means
+	 */
+	0x11,
+	1,			/*application id */
+	0,			/*filler */
+	0,			/*filler */
+	0			/*filler */
+};
+
+const unsigned char uicc_pin1_ind_puk_required[] =3D {
+	UICC_PIN_IND,
+	UICC_PIN_UNBLOCK_NEEDED,	/* UICC_PIN_UNBLOCK_NEEDED, */
+	/*PIN ID, PIN1=3D1...8, PIN2=3D0x81...0x88,
+	 * 0x11=3DPHNET_PIN what ever it means
+	 */
+	0x01,
+	1,			/*application id */
+	0,			/*filler */
+	0,			/*filler */
+	0			/*filler */
+};
+
+const unsigned char uicc_pin2_ind_puk_required[] =3D {
+	UICC_PIN_IND,
+	UICC_PIN_UNBLOCK_NEEDED,	/* UICC_PIN_UNBLOCK_NEEDED, */
+	0x81,			/*PIN ID, PIN1=3D1...8, PIN2=3D0x81...0x88,
+				 *0x11=3DPHNET_PIN what ever it means
+				 */
+	1,			/*application id */
+	0,			/*filler */
+	0,			/*filler */
+	0			/*filler */
+};
+
+const unsigned char uicc_pin_phnet_ind_puk_required[] =3D {
+	UICC_PIN_IND,
+	UICC_PIN_UNBLOCK_NEEDED,	/* UICC_PIN_UNBLOCK_NEEDED, */
+	/*PIN ID, PIN1=3D1...8, PIN2=3D0x81...0x88,
+	 *0x11=3DPHNET_PIN what ever it means
+	 */
+	0x11,
+	1,			/*application id */
+	0,			/*filler */
+	0,			/*filler */
+	0			/*filler */
+};
+
+const unsigned char uicc_ind_startup_complete[] =3D {
+	UICC_IND,
+	UICC_START_UP_COMPLETE
+};
+
+const uint16_t uicc_appl_cmd_file_info_EFECC_req[] =3D {
+	UICC_APPL_CMD_REQ,
+	UICC_APPL_FILE_INFO,
+	2,
+	-1,			/*Session ID */
+	-1,			/*Filler */
+	-1,			/*Filler */
+	-1,			/*number of subblocks */
+	/* Subblock 1 */
+	-1,
+	-1,
+	-1,
+	-1,			/*Sub block length */
+	SIM_EFECC_FILEID >> 8,	/* UICC elementary file ID */
+	SIM_EFECC_FILEID & 0xff,
+};
+
+const unsigned char uicc_appl_cmd_file_info_EFECC_resp[] =3D {
+	UICC_APPL_CMD_RESP,
+	UICC_APPL_FILE_INFO,
+	UICC_STATUS_OK,
+	UICC_NO_DETAILS,
+	0x55,			/*filler */
+	UICC_CARD_TYPE_UICC,
+	1,			/*Number of subblocks */
+	/*Subblock 1 (actual of 6FB7) */
+	/*UICC_SB_FCI, FCI len =3D 0x1D=3D29 */
+	0x00, 0x1C, 0x00, 0x28, 0x00, 0x1D, 0x02, 0x55,
+	0x62, 0x1B,		/* FCP template, len =3D0x1B=3D27 */
+	/*M Descriptor desc=3D0x41, coding=3D0x21(always 0x21),
+	 *0x41: Shareable, working EF, transparent
+	 */
+	0x82, 0x02, 0x41, 0x21,
+	/*M file id */
+	0x83, 0x02, SIM_EFECC_FILEID >> 8, SIM_EFECC_FILEID & 0xff,
+	0xA5, 0x03, 0xDA, 0x01, 0x01,	/*O proprietary */
+	0x8A, 0x01, 0x05,	/*O life cycle, state=3Dactivated */
+	/*M EFarr file id=3D6f06, EFarr record number */
+	0x8B, 0x03, 0x6F, 0x06, 0x06,
+	0x80, 0x02, 0x00, 0x0F,	/*M EF File size=3D0x0f=3D15 */
+	0x88, 0x00, /*SFI*/ 0x55, 0x55, 0x55
+};
+
+const uint16_t uicc_appl_cmd_file_info_EFIMSI_req[] =3D {
+	UICC_APPL_CMD_REQ,
+	UICC_APPL_FILE_INFO,
+	2,
+	-1,			/*Session ID */
+	-1,			/*Filler */
+	-1,			/*Filler */
+	-1,			/*number of subblocks */
+	/* Subblock 1 */
+	-1,
+	-1,
+	-1,
+	-1,			/*Sub block length */
+	SIM_EFIMSI_FILEID >> 8,	/* UICC elementary file ID */
+	SIM_EFIMSI_FILEID & 0xff
+};
+
+const unsigned char uicc_appl_cmd_file_info_EFIMSI_resp[] =3D {
+	UICC_APPL_CMD_RESP,
+	UICC_APPL_FILE_INFO,
+	UICC_STATUS_OK,
+	UICC_NO_DETAILS,
+	0x55,			/*filler */
+	UICC_CARD_TYPE_UICC,
+	1,			/*Number of subblocks */
+	/*Subblock 1 */
+	/*UICC_SB_FCI, FCI */
+	0x00, 0x1C, 0x00, 20, 0x00, (20 - 8 - 2), 0x02, 0x55,
+	0x62, 0x1B,		/* FCP template, len */
+	/*M Descriptor desc=3D0x41 (transparent),
+	 * coding=3D0x21(always 0x21)*/
+	0x82, 0x02, 0x41, 0x21,
+	0x80, 0x02, 0x00, 0x08,	/*M EF File size */
+	0x55, 0x55
+};
+
+const uint16_t uicc_appl_cmd_file_info_EFPNN_req[] =3D {
+	UICC_APPL_CMD_REQ,
+	UICC_APPL_FILE_INFO,
+	2,
+	-1,			/*Session ID */
+	-1,			/*Filler */
+	-1,			/*Filler */
+	-1,			/*number of subblocks */
+	/* Subblock 1 */
+	-1,
+	-1,
+	-1,
+	-1,			/*Sub block length */
+	SIM_EFPNN_FILEID >> 8,	/* UICC elementary file ID */
+	SIM_EFPNN_FILEID & 0xff
+};
+
+const unsigned char uicc_appl_cmd_file_info_EFPNN_resp[] =3D {
+	UICC_APPL_CMD_RESP,
+	UICC_APPL_FILE_INFO,
+	UICC_STATUS_OK,
+	UICC_NO_DETAILS,
+	0x55,			/*filler */
+	UICC_CARD_TYPE_UICC,
+	1,			/*Number of subblocks */
+	/*Subblock 1 */
+	/*UICC_SB_FCI, FCI */
+	0x00, 0x1C, 0x00, 20, 0x00, (20 - 8 - 2), 0x02, 0x55,
+	0x62, 0x1B,		/* FCP template, len */
+	/*M Descriptor desc=3D0x42 (linear fixed),
+	 * coding=3D0x21(always 0x21)*/
+	0x82, 0x05, 0x42, 0x21, 0x00, 0x08, 0x01,
+	0x80, 0x02, 0x00, 0x08,	/*M EF File size */
+	0x55, 0x55
+};
+
+const uint16_t uicc_appl_cmd_file_info_EFMSISDN_req[] =3D {
+	UICC_APPL_CMD_REQ,
+	UICC_APPL_FILE_INFO,
+	2,
+	-1,			/*Session ID */
+	-1,			/*Filler */
+	-1,			/*Filler */
+	-1,			/*number of subblocks */
+	/* Subblock 1 */
+	-1,
+	-1,
+	-1,
+	-1,			/*Sub block length */
+	SIM_EFMSISDN_FILEID >> 8,	/* UICC elementary file ID */
+	SIM_EFMSISDN_FILEID & 0xff
+};
+
+const unsigned char uicc_appl_cmd_file_info_EFMSISDN_resp[] =3D {
+	UICC_APPL_CMD_RESP,
+	UICC_APPL_FILE_INFO,
+	UICC_STATUS_OK,
+	UICC_NO_DETAILS,
+	0x55,			/*filler */
+	UICC_CARD_TYPE_UICC,
+	1,			/*Number of subblocks */
+	/*Subblock 1 */
+	/*UICC_SB_FCI, FCI */
+	0x00, 0x1C, 0x00, 20, 0x00, (20 - 8 - 2), 0x02, 0x55,
+	0x62, 0x1B,		/* FCP template, len */
+	/*M Descriptor desc=3D0x42 (linear fixed),
+	 * coding=3D0x21(always 0x21)*/
+	0x82, 0x05, 0x42, 0x21, 0x00, 0x18, 0x05,
+	0x80, 0x02, 0x00, 0x78,	/*M EF File size */
+	0x55, 0x55
+};
+
+const uint16_t uicc_appl_cmd_file_info_EFPNN_SIM_req[] =3D {
+	UICC_APPL_CMD_REQ,
+	UICC_APPL_FILE_INFO,
+	0,
+	-1,			/*Session ID */
+	-1,			/*Filler */
+	-1,			/*Filler */
+	-1,			/*number of subblocks */
+	/* Subblock 1 */
+	-1,
+	-1,
+	-1,
+	-1,			/*Sub block length */
+	SIM_EFPNN_FILEID >> 8,	/* UICC elementary file ID */
+	SIM_EFPNN_FILEID & 0xff
+};
+
+const unsigned char uicc_appl_cmd_file_info_EFPNN_SIM_resp[] =3D {
+	UICC_APPL_CMD_RESP,
+	UICC_APPL_FILE_INFO,
+	UICC_STATUS_OK,
+	UICC_NO_DETAILS,
+	0x55,			/*filler */
+	UICC_CARD_TYPE_ICC,
+	1,			/*Number of subblocks */
+	/*Subblock 1 */
+	0x00, 0x1C, 0x00, 0x18, 0x00, 0x0F,
+	0x01, 0x55,
+	0x00, 0x00, /*RFU*/ 0x00, 0x08,	/*File size */
+	0x6F, 0xC5,		/*File Id */
+	0x04,			/*File type */
+	0x01,
+	0x11, 0xF0, 0x22,	/*Access conditions */
+	0x01,			/*Status */
+	0x02,			/*Len of following */
+	0x01,			/*Structure */
+	0x08,			/*Record length */
+	0x55
+};
+
+const uint16_t uicc_appl_cmd_file_info_EFICI_req[] =3D {
+	UICC_APPL_CMD_REQ,
+	UICC_APPL_FILE_INFO,
+	2,
+	-1,			/*Session ID */
+	-1,			/*Filler */
+	-1,			/*Filler */
+	-1,			/*number of subblocks */
+	/* Subblock 1 */
+	-1,
+	-1,
+	-1,
+	-1,			/*Sub block length */
+	0x6f80 >> 8,		/* UICC elementary file ID */
+	0x6f80 & 0xff
+};
+
+const unsigned char uicc_appl_cmd_file_info_EFICI_resp[] =3D {
+	UICC_APPL_CMD_RESP,
+	UICC_APPL_FILE_INFO,
+	UICC_STATUS_OK,
+	UICC_NO_DETAILS,
+	0x55,			/*filler */
+	UICC_CARD_TYPE_UICC,
+	1,			/*Number of subblocks */
+	/*Subblock 1 */
+	/*UICC_SB_FCI, FCI */
+	0x00, 0x1C, 0x00, 20, 0x00, (20 - 8 - 2), 0x02, 0x55,
+	0x62, 0x1B,		/* FCP template, len */
+	/*M Descriptor desc=3D0x46 (cyclic),
+	 *coding=3D0x21(always 0x21)*/
+	0x82, 0x05, 0x46, 0x21, 0x00, 0x04, 0x02,
+	0x80, 0x02, 0x00, 0x08,	/*M EF File size */
+	0x55, 0x55
+};
+
+const uint16_t uicc_appl_cmd_file_info_EFLI_req[] =3D {
+	UICC_APPL_CMD_REQ,
+	UICC_APPL_FILE_INFO,
+	2,
+	-1,			/*Session ID */
+	-1,			/*Filler */
+	-1,			/*Filler */
+	-1,			/*number of subblocks */
+	/* Subblock 1 */
+	-1,
+	-1,
+	-1,
+	-1,			/*Sub block length */
+	SIM_EFLI_FILEID >> 8,		/* UICC elementary file ID */
+	SIM_EFLI_FILEID & 0xff
+};
+
+const unsigned char uicc_appl_cmd_file_info_EFLI_resp[] =3D {
+	UICC_APPL_CMD_RESP,
+	UICC_APPL_FILE_INFO,
+	UICC_STATUS_OK,
+	UICC_NO_DETAILS,
+	0x55,			/*filler */
+	UICC_CARD_TYPE_UICC,
+	1,			/*Number of subblocks */
+	/*Subblock 1 */
+	/*UICC_SB_FCI, FCI */
+	0x00, 0x1C, 0x00, 20, 0x00, (20 - 8 - 2), 0x02, 0x55,
+	0x62, 0x1B,		/* FCP template, len */
+	/*M Descriptor desc=3D0x41 (transparent),
+	 *coding=3D0x21(always 0x21)*/
+	0x82, 0x03, 0x41, 0x21, 0x00,
+	0x80, 0x02, 0x00, 0x02,	/*M EF File size */
+	0x55, 0x55
+};
+
+const uint16_t uicc_appl_cmd_file_info_EFPL_req[] =3D {
+	UICC_APPL_CMD_REQ,
+	UICC_APPL_FILE_INFO,
+	2,
+	-1,			/*Session ID */
+	-1,			/*Filler */
+	-1,			/*Filler */
+	-1,			/*number of subblocks */
+	/* Subblock 1 */
+	-1,
+	-1,
+	-1,
+	-1,			/*Sub block length */
+	SIM_EFPL_FILEID >> 8,		/* UICC elementary file ID */
+	SIM_EFPL_FILEID & 0xff
+};
+
+const unsigned char uicc_appl_cmd_file_info_EFPL_resp[] =3D {
+	UICC_APPL_CMD_RESP,
+	UICC_APPL_FILE_INFO,
+	UICC_STATUS_OK,
+	UICC_NO_DETAILS,
+	0x55,			/*filler */
+	UICC_CARD_TYPE_UICC,
+	1,			/*Number of subblocks */
+	/*Subblock 1 */
+	/*UICC_SB_FCI, FCI */
+	0x00, 0x1C, 0x00, 20, 0x00, (20 - 8 - 2), 0x02, 0x55,
+	0x62, 0x1B,		/* FCP template, len */
+	/*M Descriptor desc=3D0x41 (transparent),
+	 *coding=3D0x21(always 0x21)*/
+	0x82, 0x03, 0x41, 0x21, 0x00,
+	0x80, 0x02, 0x00, 0x0a,	/*M EF File size */
+	0x55, 0x55
+};
+
+
+/* Phonebook Simulation messages set */
+const uint16_t uicc_appl_cmd_file_info_EFADN_SIM_req[] =3D {
+	UICC_APPL_CMD_REQ,
+	UICC_APPL_FILE_INFO,
+	1,
+	-1,			/*Session ID */
+	-1,			/*Filler */
+	-1,			/*Filler */
+	-1,			/*number of subblocks */
+	/* Subblock 1 */
+	-1,
+	-1,
+	-1,
+	-1,			/*Sub block length */
+	0x6F3A >> 8,		/* UICC elementary file ID */
+	0x6F3A & 0xff,
+};
+
+const unsigned char uicc_appl_cmd_file_info_EFADN_SIM_resp[] =3D {
+	0x0D, 0x25, 0x00, 0x00, 0x55, 0x01, 0x01,
+	0x00, 0x1C, 0x00, 0x18, 0x00, 0x0F,
+	0x01, 0x55,
+	0x00, 0x00, /*RFU*/ 0x02, 0x58,	/*File size */
+	0x6F, 0x3A,		/*File Id */
+	0x04,			/*File type */
+	0x01,
+	0x11, 0xF0, 0x22,	/*Access conditions */
+	0x01,			/*Status */
+	0x02,			/*Len of following */
+	0x01,			/*Structure */
+	0x1E,			/*Record length */
+	0x55
+};
+
+const uint16_t uicc_appl_cmd_file_info_EFPBR_req[] =3D {
+	UICC_APPL_CMD_REQ,
+	UICC_APPL_FILE_INFO,
+	2,
+	-1,			/*Session ID */
+	-1,			/*Filler */
+	-1,			/*Filler */
+	-1,			/*number of subblocks */
+	/* Subblock 1 */
+	-1,
+	-1,
+	-1,
+	-1,			/*Sub block length */
+	SIM_EFPBR_FILEID >> 8,	/* UICC elementary file ID */
+	SIM_EFPBR_FILEID & 0xff,
+};
+
+const unsigned char uicc_appl_cmd_file_info_EFPBR_resp[] =3D {
+	0x0D, 0x25, 0x00, 0x00, 0x55, 0x02, 0x01,	/* 1 SB */
+	/*UICC_SB_FCI, FCI */
+	0x00, 0x1C, 0x00, 20, 0x00, (20 - 8 - 2), 0x02, 0x55,
+	0x62, 0x1B,		/* FCP template, len */
+	/*M Descriptor desc=3D0x42 (linear fixed),
+	 *coding=3D0x21(always 0x21)
+	 */
+	0x82, 0x05, 0x42, 0x21, 0x00, 0x64, 0x02,
+	0x80, 0x02, 0x00, 0xC8,	/*M EF File size */
+	0x55, 0x55
+};
+
+const uint16_t uicc_appl_cmd_file_info_EFADN_req[] =3D {
+	UICC_APPL_CMD_REQ,
+	UICC_APPL_FILE_INFO,
+	2,
+	-1,			/*Session ID */
+	-1,			/*Filler */
+	-1,			/*Filler */
+	-1,			/*number of subblocks */
+	/* Subblock 1 */
+	-1,
+	-1,
+	-1,
+	-1,			/*Sub block length */
+	0x4F3A >> 8,		/* UICC elementary file ID */
+	0x4F3A & 0xff,
+};
+
+const unsigned char uicc_appl_cmd_file_info_EFADN_resp[] =3D {
+	0x0D, 0x25, 0x00, 0x00, 0x55, 0x02, 0x01,
+	0x00, 0x1C, 0x00, 0x2C, 0x00, 0x21, 0x02, 0x55,
+	0x62, 0x1F,
+	0x82, 0x05, 0x42, 0x21, 0x00, 0x26, 0x14,
+	0x83, 0x02, 0x4F, 0x3A, 0xA5, 0x03, 0xDA, 0x01, 0x01,
+	0x8A, 0x01, 0x05,
+	0x8B, 0x03, 0x6F, 0x06, 0x02,
+	0x80, 0x02, 0x02, 0xF8,	/* 20 records * 38 record_length */
+	0x88, 0x01, 0xD0, 0x55, 0x55, 0x55
+};
+
+const uint16_t uicc_appl_cmd_file_info_EFEXT1_req[] =3D {
+	UICC_APPL_CMD_REQ,
+	UICC_APPL_FILE_INFO,
+	2,
+	-1,			/*Session ID */
+	-1,			/*Filler */
+	-1,			/*Filler */
+	-1,			/*number of subblocks */
+	/* Subblock 1 */
+	-1,
+	-1,
+	-1,
+	-1,			/*Sub block length */
+	0x4F4A >> 8,		/* UICC elementary file ID */
+	0x4F4A & 0xff,
+};
+
+const unsigned char uicc_appl_cmd_file_info_EFEXT1_resp[] =3D {
+	0x0D, 0x25, 0x00, 0x00, 0x55, 0x02, 0x01,
+	0x00, 0x1C, 0x00, 0x2C, 0x00, 0x21, 0x02, 0x55,
+	0x62, 0x1F,
+	0x82, 0x05, 0x42, 0x21, 0x00, 0x0D, 0x14,
+	0x83, 0x02, 0x4F, 0x4A, 0xA5, 0x03, 0xDA, 0x01, 0x01,
+	0x8A, 0x01, 0x05,
+	0x8B, 0x03, 0x6F, 0x06, 0x02,
+	0x80, 0x02, 0x01, 0x04,
+	0x88, 0x01, 0x50, 0x55, 0x55, 0x55
+};
+
+const uint16_t uicc_appl_cmd_file_info_EFEMAIL_req[] =3D {
+	UICC_APPL_CMD_REQ,
+	UICC_APPL_FILE_INFO,
+	2,
+	-1,			/*Session ID */
+	-1,			/*Filler */
+	-1,			/*Filler */
+	-1,			/*number of subblocks */
+	/* Subblock 1 */
+	-1,
+	-1,
+	-1,
+	-1,			/*Sub block length */
+	0x4F50 >> 8,		/* UICC elementary file ID */
+	0x4F50 & 0xff,
+};
+
+const unsigned char uicc_appl_cmd_file_info_EFEMAIL_resp[] =3D {
+	0x0D, 0x25, 0x00, 0x00, 0x55, 0x02, 0x01,
+	0x00, 0x1C, 0x00, 0x2C, 0x00, 0x21, 0x02, 0x55,
+	0x62, 0x1F,
+	0x82, 0x05, 0x42, 0x21, 0x00, 0x32, 0x32,
+	0x83, 0x02, 0x4F, 0x50, 0xA5, 0x03, 0xDA, 0x01, 0x01,
+	0x8A, 0x01, 0x05,
+	0x8B, 0x03, 0x6F, 0x06, 0x02,
+	0x80, 0x02, 0x00, 0x64,
+	0x88, 0x01, 0x80, 0x55, 0x55, 0x55
+};
+
+const uint16_t uicc_appl_cmd_file_info_EFSNE_req[] =3D {
+	UICC_APPL_CMD_REQ,
+	UICC_APPL_FILE_INFO,
+	2,
+	-1,			/*Session ID */
+	-1,			/*Filler */
+	-1,			/*Filler */
+	-1,			/*number of subblocks */
+	/* Subblock 1 */
+	-1,
+	-1,
+	-1,
+	-1,			/*Sub block length */
+	0x4F19 >> 8,		/* UICC elementary file ID */
+	0x4F19 & 0xff,
+};
+
+const unsigned char uicc_appl_cmd_file_info_EFSNE_resp[] =3D {
+	0x0D, 0x25, 0x00, 0x00, 0x55, 0x02, 0x01,
+	0x00, 0x1C, 0x00, 0x2C, 0x00, 0x21, 0x02, 0x55,
+	0x62, 0x1F,
+	0x82, 0x05, 0x42, 0x21, 0x00, 0x32, 0x01,
+	0x83, 0x02, 0x4F, 0x19, 0xA5, 0x03, 0xDA, 0x01, 0x01,
+	0x8A, 0x01, 0x05,
+	0x8B, 0x03, 0x6F, 0x06, 0x02,
+	0x80, 0x02, 0x00, 0x32,
+	0x88, 0x01, 0x80, 0x55, 0x55, 0x55
+};
+
+const uint16_t uicc_appl_cmd_file_info_EFANR_req[] =3D {
+	UICC_APPL_CMD_REQ,
+	UICC_APPL_FILE_INFO,
+	2,
+	-1,			/*Session ID */
+	-1,			/*Filler */
+	-1,			/*Filler */
+	-1,			/*number of subblocks */
+	/* Subblock 1 */
+	-1,
+	-1,
+	-1,
+	-1,			/*Sub block length */
+	0x4F19 >> 8,		/* UICC elementary file ID */
+	0x4F11 & 0xff,
+};
+
+const unsigned char uicc_appl_cmd_file_info_EFANR_resp[] =3D {
+	0x0D, 0x25, 0x00, 0x00, 0x55, 0x02, 0x01,
+	0x00, 0x1C, 0x00, 0x2C, 0x00, 0x21, 0x02, 0x55,
+	0x62, 0x1F,
+	0x82, 0x05, 0x42, 0x21, 0x00, 0x1C, 0x01,
+	0x83, 0x02, 0x4F, 0x11, 0xA5, 0x03, 0xDA, 0x01, 0x01,
+	0x8A, 0x01, 0x05,
+	0x8B, 0x03, 0x6F, 0x06, 0x02,
+	0x80, 0x02, 0x00, 0x1C,
+	0x88, 0x01, 0x80, 0x55, 0x55, 0x55
+};
+
+const uint16_t uicc_appl_cmd_file_info_general_transparent_SIM_req[] =3D {
+	UICC_APPL_CMD_REQ,
+	UICC_APPL_FILE_INFO,
+	1
+};
+
+const unsigned char uicc_appl_cmd_file_info_general_transparent_SIM_resp[]=
 =3D {
+	UICC_APPL_CMD_RESP,
+	UICC_APPL_FILE_INFO,
+	UICC_STATUS_OK,
+	UICC_NO_DETAILS,
+	0x55,			/*filler */
+	UICC_CARD_TYPE_ICC,
+	1,			/*Number of subblocks */
+	/*Subblock 1 */
+	0x00, 0x1C, 0x00, 0x18, 0x00, 0x0F,
+	0x01, 0x55,
+	0x00, 0x00, /*RFU*/ 0x00, 0x08,	/*File size */
+	0x6F, 0xC5,		/*File Id */
+	0x04,			/*File type */
+	0x01,
+	0x11, 0xF0, 0x22,	/*Access conditions */
+	0x01,			/*Status */
+	0x02,			/*Len of following */
+	0x01,			/*Structure */
+	0x08,			/*Record length */
+	0x55
+};
+
+const uint16_t uicc_appl_cmd_file_info_general_transparent_req[] =3D {
+	UICC_APPL_CMD_REQ,
+	UICC_APPL_FILE_INFO,
+	2
+};
+
+const unsigned char uicc_appl_cmd_file_info_general_transparent_resp[] =3D=
 {
+	UICC_APPL_CMD_RESP,
+	UICC_APPL_FILE_INFO,
+	UICC_STATUS_OK,
+	UICC_NO_DETAILS,
+	0x55,			/*filler */
+	UICC_CARD_TYPE_UICC,
+	1,			/*Number of subblocks */
+	/*Subblock 1 */
+	/*UICC_SB_FCI, FCI */
+	0x00, 0x1C, 0x00, 20, 0x00, (20 - 8 - 2), 0x02, 0x55,
+	0x62, 0x1B,		/* FCP template, len */
+	/*M Descriptor desc=3D0x41, coding=3D0x21(always 0x21),
+	 * 0x41: Shareable, working EF, transparent
+	 */
+	0x82, 0x02, 0x41, 0x21,
+	0x80, 0x02, 0x00, 0x08,	/*M EF File size */
+	0x55, 0x55
+};
+
+const uint16_t uicc_appl_cmd_EFLI_req[] =3D {
+	UICC_APPL_CMD_REQ,
+	UICC_APPL_READ_TRANSPARENT,
+	-1,
+	-1,			/* Session ID */
+	-1,			/* Filler */
+	-1,			/* Filler */
+	-1,			/* number of subblocks */
+	/* Subblock 1 */
+	-1,
+	-1,
+	-1,
+	-1,			/* Sub block length */
+	-1, -1, -1,		/* Filler */
+	-1,			/* Client ID,
+				read from UICC_APPL_HOST_ACTIVATE */
+	/* Subblock 2 */
+	-1,
+	-1,
+	-1,			/* Sub block length */
+	-1,			/* Sub block length */
+	-1,			/* Record */
+	-1,			/* Record offset (0=3Dbeginning) */
+	-1,			/* Data amount (0=3Dall) */
+	-1,			/* Filler */
+	/* Subblock 3 */
+	-1,
+	-1,
+	-1,
+	-1,			/* Sub block length */
+	SIM_EFLI_FILEID >> 8,
+	SIM_EFLI_FILEID & 0xFF,	/* UICC elementary file ID */
+};
+
+const unsigned char uicc_appl_cmd_EFLI_response[] =3D {
+	UICC_APPL_CMD_RESP,
+	UICC_APPL_READ_TRANSPARENT,
+	UICC_STATUS_OK,
+	UICC_NO_DETAILS,
+	0,			/*filler */
+	UICC_CARD_TYPE_UICC,
+	1,			/*Number of subblocks */
+	/*Subblock 1 */
+	UICC_SB_FILE_DATA >> 8,
+	UICC_SB_FILE_DATA & 0xff,
+	0,			/*subblock length */
+	(8 + 2),		/*subblock length */
+	0, 0, 0, 2,		/*Length of filedata */
+	'f',
+	'i'
+};
+
+const uint16_t uicc_appl_cmd_EFPL_req[] =3D {
+	UICC_APPL_CMD_REQ,
+	UICC_APPL_READ_TRANSPARENT,
+	-1,
+	-1,			/* Session ID */
+	-1,			/* Filler */
+	-1,			/* Filler */
+	-1,			/* number of subblocks */
+	/* Subblock 1 */
+	-1,
+	-1,
+	-1,
+	-1,			/* Sub block length */
+	-1, -1, -1,		/* Filler */
+	-1,			/* Client ID,
+				read from UICC_APPL_HOST_ACTIVATE */
+	/* Subblock 2 */
+	-1,
+	-1,
+	-1,			/* Sub block length */
+	-1,			/* Sub block length */
+	-1,			/* Record */
+	-1,			/* Record offset (0=3Dbeginning) */
+	-1,			/* Data amount (0=3Dall) */
+	-1,			/* Filler */
+	/* Subblock 3 */
+	-1,
+	-1,
+	-1,
+	-1,			/* Sub block length */
+	SIM_EFPL_FILEID >> 8,
+	SIM_EFPL_FILEID & 0xFF,	/* UICC elementary file ID */
+};
+
+const unsigned char uicc_appl_cmd_EFPL_response[] =3D {
+	UICC_APPL_CMD_RESP,
+	UICC_APPL_READ_TRANSPARENT,
+	UICC_STATUS_OK,
+	UICC_NO_DETAILS,
+	0,			/*filler */
+	UICC_CARD_TYPE_UICC,
+	1,			/*Number of subblocks */
+	/*Subblock 1 */
+	UICC_SB_FILE_DATA >> 8,
+	UICC_SB_FILE_DATA & 0xff,
+	0,			/*subblock length */
+	(8 + 10),		/*subblock length */
+	0, 0, 0, 10,		/*Length of filedata */
+	'e',
+	'n',
+	'n',
+	'l',
+	's',
+	'w',
+	'p',
+	'l',
+	'p',
+	't'
+};
+
+
+const uint16_t uicc_appl_cmd_transparent_req[] =3D {
+	UICC_APPL_CMD_REQ,
+	UICC_APPL_READ_TRANSPARENT
+};
+
+const unsigned char uicc_appl_cmd_transparent_response[] =3D {
+	UICC_APPL_CMD_RESP,
+	UICC_APPL_READ_TRANSPARENT,
+	UICC_STATUS_OK,
+	UICC_NO_DETAILS,
+	0,			/*filler */
+	UICC_CARD_TYPE_UICC,
+	1,			/*Number of subblocks */
+	/*Subblock 1 */
+	UICC_SB_FILE_DATA >> 8,
+	UICC_SB_FILE_DATA & 0xff,
+	0,			/*subblock length */
+	(8 + 8),		/*subblock length */
+	0, 0, 0, 9,		/*Length of filedata */
+	8,			/*Filedata: len */
+	0x10,			/*Filedata: number */
+	0x23,
+	0x45,
+	0x67,
+	0x89,
+	0x01,
+	0x23,
+	0x45
+};
+
+const uint16_t uicc_appl_cmd_linear_fixed_ADN1_SIM_req[] =3D {
+	UICC_APPL_CMD_REQ,
+	UICC_APPL_READ_LINEAR_FIXED,
+	-1,
+	-1,			/* Session ID */
+	-1,			/* Filler */
+	-1,			/* Filler */
+	-1,			/* number of subblocks */
+	/* Subblock 1 */
+	-1,
+	-1,
+	-1,
+	-1,			/* Sub block length */
+	-1, -1, -1,		/* Filler */
+	-1,			/* Client ID,
+				read from UICC_APPL_HOST_ACTIVATE */
+	/* Subblock 2 */
+	-1,
+	-1,
+	-1,			/* Sub block length */
+	-1,			/* Sub block length */
+	1,			/* Record */
+	-1,			/* Record offset (0=3Dbeginning) */
+	-1,			/* Data amount (0=3Dall) */
+	-1,			/* Filler */
+	/* Subblock 3 */
+	-1,
+	-1,
+	-1,
+	-1,			/* Sub block length */
+	0x6F,
+	0x3A,			/* UICC elementary file ID */
+};
+
+const uint16_t uicc_appl_cmd_linear_fixed_ADN1_req[] =3D {
+	UICC_APPL_CMD_REQ,
+	UICC_APPL_READ_LINEAR_FIXED,
+	-1,
+	-1,			/* Session ID */
+	-1,			/* Filler */
+	-1,			/* Filler */
+	-1,			/* number of subblocks */
+	/* Subblock 1 */
+	-1,
+	-1,
+	-1,
+	-1,			/* Sub block length */
+	-1, -1, -1,		/* Filler */
+	-1,			/* Client ID,
+				read from UICC_APPL_HOST_ACTIVATE */
+	/* Subblock 2 */
+	-1,
+	-1,
+	-1,			/* Sub block length */
+	-1,			/* Sub block length */
+	1,			/* Record */
+	-1,			/* Record offset (0=3Dbeginning) */
+	-1,			/* Data amount (0=3Dall) */
+	-1,			/* Filler */
+	/* Subblock 3 */
+	-1,
+	-1,
+	-1,
+	-1,			/* Sub block length */
+	0x4F,
+	0x3A,			/* UICC elementary file ID */
+};
+
+const unsigned char uicc_appl_cmd_linear_fixed_ADN1_response[] =3D {
+	/* UCS2 */
+	0x0D, 0x23, 0x00, 0x00, 0x55, 0x02, 0x01,
+	0x00, 0x0F, 0x00, 0x30, 0x00, 0x00, 0x00, 0x26,
+	0x80, 0x00, 0x41, 0x00, 0x73, 0x00, 0x69, 0x00,
+	0x61, 0x00, 0x6B, 0x00, 0x61, 0x00, 0x73, 0x00,
+	0x70, 0x00, 0x61, 0x00, 0x6C, 0x00, 0xE4, 0xFF,
+	0x07, 0x81, 0x53, 0x28, 0x00, 0x71, 0x00, 0xF0,
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x55, 0x55
+};
+
+const uint16_t uicc_appl_cmd_linear_fixed_ADN2_SIM_req[] =3D {
+	UICC_APPL_CMD_REQ,
+	UICC_APPL_READ_LINEAR_FIXED,
+	-1,
+	-1,			/* Session ID */
+	-1,			/* Filler */
+	-1,			/* Filler */
+	-1,			/* number of subblocks */
+	/* Subblock 1 */
+	-1,
+	-1,
+	-1,
+	-1,			/* Sub block length */
+	-1, -1, -1,		/* Filler */
+	-1,			/* Client ID,
+				read from UICC_APPL_HOST_ACTIVATE */
+	/* Subblock 2 */
+	-1,
+	-1,
+	-1,			/* Sub block length */
+	-1,			/* Sub block length */
+	2,			/* Record */
+	-1,			/* Record offset (0=3Dbeginning) */
+	-1,			/* Data amount (0=3Dall) */
+	-1,			/* Filler */
+	/* Subblock 3 */
+	-1,
+	-1,
+	-1,
+	-1,			/* Sub block length */
+	0x6F,
+	0x3A,			/* UICC elementary file ID */
+};
+
+const uint16_t uicc_appl_cmd_linear_fixed_ADN2_req[] =3D {
+	UICC_APPL_CMD_REQ,
+	UICC_APPL_READ_LINEAR_FIXED,
+	-1,
+	-1,			/* Session ID */
+	-1,			/* Filler */
+	-1,			/* Filler */
+	-1,			/* number of subblocks */
+	/* Subblock 1 */
+	-1,
+	-1,
+	-1,
+	-1,			/* Sub block length */
+	-1, -1, -1,		/* Filler */
+	-1,			/* Client ID,
+				read from UICC_APPL_HOST_ACTIVATE */
+	/* Subblock 2 */
+	-1,
+	-1,
+	-1,			/* Sub block length */
+	-1,			/* Sub block length */
+	2,			/* Record */
+	-1,			/* Record offset (0=3Dbeginning) */
+	-1,			/* Data amount (0=3Dall) */
+	-1,			/* Filler */
+	/* Subblock 3 */
+	-1,
+	-1,
+	-1,
+	-1,			/* Sub block length */
+	0x4F,
+	0x3A,			/* UICC elementary file ID */
+};
+
+const unsigned char uicc_appl_cmd_linear_fixed_ADN2_response[] =3D {
+	0x0D, 0x23, 0x00, 0x00, 0x55, 0x02, 0x01,
+	0x00, 0x0F, 0x00, 0x30, 0x00, 0x00, 0x00, 0x26,
+	'N', 'u', 'm', 'b', 'e', 'r', ' ', 'e', 'x', 't', 'e', 'n',
+	's', 'i', 'o', 'n',
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
+	0x0B, 0x91, 0x53, 0x48, 0x10, 0x32, 0x54, 0x76, 0x98, 0x10, 0x32,
+	0x54, 0xFF,
+	0x01, 0x55, 0x55	/* With EXT1 file, record 1 */
+};
+
+const uint16_t uicc_appl_cmd_linear_fixed_ADN3_req[] =3D {
+	UICC_APPL_CMD_REQ,
+	UICC_APPL_READ_LINEAR_FIXED,
+	-1,
+	-1,			/* Session ID */
+	-1,			/* Filler */
+	-1,			/* Filler */
+	-1,			/* number of subblocks */
+	/* Subblock 1 */
+	-1,
+	-1,
+	-1,
+	-1,			/* Sub block length */
+	-1, -1, -1,		/* Filler */
+	-1,			/* Client ID,
+				read from UICC_APPL_HOST_ACTIVATE */
+	/* Subblock 2 */
+	-1,
+	-1,
+	-1,			/* Sub block length */
+	-1,			/* Sub block length */
+	3,			/* Record */
+	-1,			/* Record offset (0=3Dbeginning) */
+	-1,			/* Data amount (0=3Dall) */
+	-1,			/* Filler */
+	/* Subblock 3 */
+	-1,
+	-1,
+	-1,
+	-1,			/* Sub block length */
+	0x4F,
+	0x3A,			/* UICC elementary file ID */
+};
+
+const unsigned char uicc_appl_cmd_linear_fixed_ADN3_response[] =3D {
+	0x0D, 0x23, 0x00, 0x00, 0x55, 0x02, 0x01,
+	0x00, 0x0F, 0x00, 0x30, 0x00, 0x00, 0x00, 0x26,
+	'B', 'o', 'n', 'd', '/', 'h', 0xFF, 0xFF, 0xFF,
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
+	0x0B, 0x91, 0x64, 0x48, 0x10, 0x32, 0x54, 0x76,
+	0x98, 0x10, 0x32,
+	0x54, 0xFF,
+	0x01, 0x55, 0x55	/* With EXT1 file, record 1 */
+};
+
+const uint16_t uicc_appl_cmd_linear_fixed_ADN4_req[] =3D {
+	UICC_APPL_CMD_REQ,
+	UICC_APPL_READ_LINEAR_FIXED,
+	-1,
+	-1,			/* Session ID */
+	-1,			/* Filler */
+	-1,			/* Filler */
+	-1,			/* number of subblocks */
+	/* Subblock 1 */
+	-1,
+	-1,
+	-1,
+	-1,			/* Sub block length */
+	-1, -1, -1,		/* Filler */
+	-1,			/* Client ID,
+				read from UICC_APPL_HOST_ACTIVATE */
+	/* Subblock 2 */
+	-1,
+	-1,
+	-1,			/* Sub block length */
+	-1,			/* Sub block length */
+	4,			/* Record */
+	-1,			/* Record offset (0=3Dbeginning) */
+	-1,			/* Data amount (0=3Dall) */
+	-1,			/* Filler */
+	/* Subblock 3 */
+	-1,
+	-1,
+	-1,
+	-1,			/* Sub block length */
+	0x4F,
+	0x3A,			/* UICC elementary file ID */
+};
+
+const unsigned char uicc_appl_cmd_linear_fixed_ADN4_response[] =3D {
+	0x0D, 0x23, 0x00, 0x00, 0x55, 0x02, 0x01,
+	0x00, 0x0F, 0x00, 0x30, 0x00, 0x00, 0x00, 0x26,
+	'B', 'o', 'n', 'd', '/', 'm', 0xFF, 0xFF, 0xFF,
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
+	0x0B, 0x91, 0x76, 0x48, 0x10, 0x32, 0x54, 0x76, 0x98, 0x10, 0x32,
+	0x54, 0xFF,
+	0x01, 0x55, 0x55	/* With EXT1 file, record 1 */
+};
+
+const uint16_t uicc_appl_cmd_linear_fixed_ADN5_req[] =3D {
+	UICC_APPL_CMD_REQ,
+	UICC_APPL_READ_LINEAR_FIXED,
+	-1,
+	-1,			/* Session ID */
+	-1,			/* Filler */
+	-1,			/* Filler */
+	-1,			/* number of subblocks */
+	/* Subblock 1 */
+	-1,
+	-1,
+	-1,
+	-1,			/* Sub block length */
+	-1, -1, -1,		/* Filler */
+	-1,			/* Client ID,
+				read from UICC_APPL_HOST_ACTIVATE */
+	/* Subblock 2 */
+	-1,
+	-1,
+	-1,			/* Sub block length */
+	-1,			/* Sub block length */
+	5,			/* Record */
+	-1,			/* Record offset (0=3Dbeginning) */
+	-1,			/* Data amount (0=3Dall) */
+	-1,			/* Filler */
+	/* Subblock 3 */
+	-1,
+	-1,
+	-1,
+	-1,			/* Sub block length */
+	0x4F,
+	0x3A,			/* UICC elementary file ID */
+};
+
+const unsigned char uicc_appl_cmd_linear_fixed_ADN5_response[] =3D {
+	0x0D, 0x23, 0x00, 0x00, 0x55, 0x02, 0x01,
+	0x00, 0x0F, 0x00, 0x30, 0x00, 0x00, 0x00, 0x26,
+	'B', 'o', 'n', 'd', '/', 'w', 0xFF, 0xFF, 0xFF,
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
+	0x0B, 0x91, 0x76, 0x48, 0x10, 0x32, 0x54, 0x76, 0x98, 0x10, 0x32,
+	0x54, 0xFF,
+	0x01, 0x55, 0x55	/* With EXT1 file, record 1 */
+};
+
+const uint16_t uicc_appl_cmd_linear_fixed_ADNx_SIM_req[] =3D {
+	UICC_APPL_CMD_REQ,
+	UICC_APPL_READ_LINEAR_FIXED,
+	-1,
+	-1,			/* Session ID */
+	-1,			/* Filler */
+	-1,			/* Filler */
+	-1,			/* number of subblocks */
+	/* Subblock 1 */
+	-1,
+	-1,
+	-1,
+	-1,			/* Sub block length */
+	-1, -1, -1,		/* Filler */
+	-1,			/* Client ID,
+				read from UICC_APPL_HOST_ACTIVATE */
+	/* Subblock 2 */
+	-1,
+	-1,
+	-1,			/* Sub block length */
+	-1,			/* Sub block length */
+	-1,			/* Record */
+	-1,			/* Record offset (0=3Dbeginning) */
+	-1,			/* Data amount (0=3Dall) */
+	-1,			/* Filler */
+	/* Subblock 3 */
+	-1,
+	-1,
+	-1,
+	-1,			/* Sub block length */
+	0x6F,
+	0x3A,			/* UICC elementary file ID */
+};
+
+const uint16_t uicc_appl_cmd_linear_fixed_ADNx_req[] =3D {
+	UICC_APPL_CMD_REQ,
+	UICC_APPL_READ_LINEAR_FIXED,
+	-1,
+	-1,			/* Session ID */
+	-1,			/* Filler */
+	-1,			/* Filler */
+	-1,			/* number of subblocks */
+	/* Subblock 1 */
+	-1,
+	-1,
+	-1,
+	-1,			/* Sub block length */
+	-1, -1, -1,		/* Filler */
+	-1,			/* Client ID,
+				read from UICC_APPL_HOST_ACTIVATE */
+	/* Subblock 2 */
+	-1,
+	-1,
+	-1,			/* Sub block length */
+	-1,			/* Sub block length */
+	-1,			/* Record */
+	-1,			/* Record offset (0=3Dbeginning) */
+	-1,			/* Data amount (0=3Dall) */
+	-1,			/* Filler */
+	/* Subblock 3 */
+	-1,
+	-1,
+	-1,
+	-1,			/* Sub block length */
+	0x4F,
+	0x3A,			/* UICC elementary file ID */
+};
+
+const unsigned char uicc_appl_cmd_linear_fixed_ADNx_response[] =3D {
+	0x0D, 0x23, 0x00, 0x00, 0x55, 0x02, 0x01, 0x00, 0x0F, 0x00, 0x30,
+	0x00, 0x00, 0x00, 0x26,
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
+	0xFF, 0xFF, 0x55, 0x55
+};
+
+const uint16_t uicc_appl_cmd_linear_fixed_EXT1_req[] =3D {
+	UICC_APPL_CMD_REQ,
+	UICC_APPL_READ_LINEAR_FIXED,
+	2,
+	-1,			/* Session ID */
+	-1,			/* Filler */
+	-1,			/* Filler */
+	-1,			/* number of subblocks */
+	/* Subblock 1 */
+	-1,
+	-1,
+	-1,
+	-1,			/* Sub block length */
+	-1, -1, -1,		/* Filler */
+	-1,			/* Client ID,
+				read from UICC_APPL_HOST_ACTIVATE */
+	/* Subblock 2 */
+	-1,
+	-1,
+	-1,			/* Sub block length */
+	-1,			/* Sub block length */
+	1,			/* Record */
+	-1,			/* Record offset (0=3Dbeginning) */
+	-1,			/* Data amount (0=3Dall) */
+	-1,			/* Filler */
+	/* Subblock 3 */
+	-1,
+	-1,
+	-1,
+	-1,			/* Sub block length */
+	0x4F,
+	0x4A,			/* UICC elementary file ID */
+};
+
+const uint16_t uicc_appl_cmd_linear_fixed_EXT1_SIM_req[] =3D {
+	UICC_APPL_CMD_REQ,
+	UICC_APPL_READ_LINEAR_FIXED,
+	1,
+	-1,			/* Session ID */
+	-1,			/* Filler */
+	-1,			/* Filler */
+	-1,			/* number of subblocks */
+	/* Subblock 1 */
+	-1,
+	-1,
+	-1,
+	-1,			/* Sub block length */
+	-1, -1, -1,		/* Filler */
+	-1,			/* Client ID,
+				read from UICC_APPL_HOST_ACTIVATE */
+	/* Subblock 2 */
+	-1,
+	-1,
+	-1,			/* Sub block length */
+	-1,			/* Sub block length */
+	1,			/* Record */
+	-1,			/* Record offset (0=3Dbeginning) */
+	-1,			/* Data amount (0=3Dall) */
+	-1,			/* Filler */
+	/* Subblock 3 */
+	-1,
+	-1,
+	-1,
+	-1,			/* Sub block length */
+	0x6F,
+	0x4A,			/* UICC elementary file ID */
+};
+
+const unsigned char uicc_appl_cmd_linear_fixed_EXT1_response[] =3D {
+	0x0D, 0x23, 0x00, 0x00, 0x55, 0x02, 0x01,
+	0x00, 0x0F, 0x00, 0x18, 0x00, 0x00, 0x00, 0x0D,
+	0x02,			/* additional data */
+	0x0A,			/* length */
+	0x76, 0x98, 0x10, 0x32, 0x54, 0x76, 0x98, 0x10, 0x32, 0x54,
+	0x03,			/* next additional */
+	0x55, 0x55, 0x55
+};
+
+const uint16_t uicc_appl_cmd_linear_fixed_EXT3_req[] =3D {
+	UICC_APPL_CMD_REQ,
+	UICC_APPL_READ_LINEAR_FIXED,
+	2,
+	-1,			/* Session ID */
+	-1,			/* Filler */
+	-1,			/* Filler */
+	-1,			/* number of subblocks */
+	/* Subblock 1 */
+	-1,
+	-1,
+	-1,
+	-1,			/* Sub block length */
+	-1, -1, -1,		/* Filler */
+	-1,			/* Client ID,
+				read from UICC_APPL_HOST_ACTIVATE */
+	/* Subblock 2 */
+	-1,
+	-1,
+	-1,			/* Sub block length */
+	-1,			/* Sub block length */
+	3,			/* Record */
+	-1,			/* Record offset (0=3Dbeginning) */
+	-1,			/* Data amount (0=3Dall) */
+	-1,			/* Filler */
+	/* Subblock 3 */
+	-1,
+	-1,
+	-1,
+	-1,			/* Sub block length */
+	0x4F,
+	0x4A,			/* UICC elementary file ID */
+};
+
+const uint16_t uicc_appl_cmd_linear_fixed_EXT3_SIM_req[] =3D {
+	UICC_APPL_CMD_REQ,
+	UICC_APPL_READ_LINEAR_FIXED,
+	1,
+	-1,			/* Session ID */
+	-1,			/* Filler */
+	-1,			/* Filler */
+	-1,			/* number of subblocks */
+	/* Subblock 1 */
+	-1,
+	-1,
+	-1,
+	-1,			/* Sub block length */
+	-1, -1, -1,		/* Filler */
+	-1,			/* Client ID,
+				read from UICC_APPL_HOST_ACTIVATE */
+	/* Subblock 2 */
+	-1,
+	-1,
+	-1,			/* Sub block length */
+	-1,			/* Sub block length */
+	3,			/* Record */
+	-1,			/* Record offset (0=3Dbeginning) */
+	-1,			/* Data amount (0=3Dall) */
+	-1,			/* Filler */
+	/* Subblock 3 */
+	-1,
+	-1,
+	-1,
+	-1,			/* Sub block length */
+	0x6F,
+	0x4A,			/* UICC elementary file ID */
+};
+
+const unsigned char uicc_appl_cmd_linear_fixed_EXT3_response[] =3D {
+	0x0D, 0x23, 0x00, 0x00, 0x55, 0x02, 0x01,
+	0x00, 0x0F, 0x00, 0x18, 0x00, 0x00, 0x00, 0x0D,
+	0x02,			/* additional data */
+	0x03,			/* length */
+	0x76, 0x98, 0xF0, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
+	0xff,			/* next additional */
+	0x55, 0x55, 0x55
+};
+
+const uint16_t uicc_appl_cmd_linear_fixed_EFEMAIL_req[] =3D {
+	UICC_APPL_CMD_REQ,
+	UICC_APPL_READ_LINEAR_FIXED,
+	-1,
+	-1,			/* Session ID */
+	-1,			/* Filler */
+	-1,			/* Filler */
+	-1,			/* number of subblocks */
+	/* Subblock 1 */
+	-1,
+	-1,
+	-1,
+	-1,			/* Sub block length */
+	-1, -1, -1,		/* Filler */
+	-1,			/* Client ID,
+				read from UICC_APPL_HOST_ACTIVATE */
+	/* Subblock 2 */
+	-1,
+	-1,
+	-1,			/* Sub block length */
+	-1,			/* Sub block length */
+	-1,			/* Record */
+	-1,			/* Record offset (0=3Dbeginning) */
+	-1,			/* Data amount (0=3Dall) */
+	-1,			/* Filler */
+	/* Subblock 3 */
+	-1,
+	-1,
+	-1,
+	-1,			/* Sub block length */
+	0x4F,
+	0x50,			/* UICC elementary file ID */
+};
+
+const unsigned char uicc_appl_cmd_linear_fixed_EFEMAIL_response[] =3D {
+	0x0D, 0x23, 0x00, 0x00, 0x55, 0x02, 0x01,
+	0x00, 0x0F, 0x00, 0x3C, 0x00, 0x00, 0x00, 0x32,
+	0x74, 0x65, 0x6B, 0x6E, 0x69, 0x73, 0x65, 0x74,
+	0x00, 0x76, 0x69, 0x61, 0x74, 0x2E, 0x66, 0x69, 0xff,
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
+	0xFF, 0x1A, 0x02, 0x55, 0x55
+};
+
+const uint16_t uicc_appl_cmd_linear_fixed_EFSNE_req[] =3D {
+	UICC_APPL_CMD_REQ,
+	UICC_APPL_READ_LINEAR_FIXED,
+	-1,
+	-1,			/* Session ID */
+	-1,			/* Filler */
+	-1,			/* Filler */
+	-1,			/* number of subblocks */
+	/* Subblock 1 */
+	-1,
+	-1,
+	-1,
+	-1,			/* Sub block length */
+	-1, -1, -1,		/* Filler */
+	-1,			/* Client ID,
+				read from UICC_APPL_HOST_ACTIVATE */
+	/* Subblock 2 */
+	-1,
+	-1,
+	-1,			/* Sub block length */
+	-1,			/* Sub block length */
+	-1,			/* Record */
+	-1,			/* Record offset (0=3Dbeginning) */
+	-1,			/* Data amount (0=3Dall) */
+	-1,			/* Filler */
+	/* Subblock 3 */
+	-1,
+	-1,
+	-1,
+	-1,			/* Sub block length */
+	0x4F,
+	0x19,			/* UICC elementary file ID */
+};
+
+const unsigned char uicc_appl_cmd_linear_fixed_EFSNE_resp[] =3D {
+	0x0D, 0x23, 0x00, 0x00, 0x55, 0x02, 0x01,
+	0x00, 0x0F, 0x00, 0x3C, 0x00, 0x00, 0x00, 0x32,
+	'S', 'e', 'c', 'o', 'n', 'd', ' ', 'n',
+	'a', 'm', 'e', 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
+	0xFF, 0xFF, 0x02, 0x55, 0x55
+};
+
+const uint16_t uicc_appl_cmd_linear_fixed_EFANR_req[] =3D {
+	UICC_APPL_CMD_REQ,
+	UICC_APPL_READ_LINEAR_FIXED,
+	-1,
+	-1,			/* Session ID */
+	-1,			/* Filler */
+	-1,			/* Filler */
+	-1,			/* number of subblocks */
+	/* Subblock 1 */
+	-1,
+	-1,
+	-1,
+	-1,			/* Sub block length */
+	-1, -1, -1,		/* Filler */
+	-1,			/* Client ID,
+				read from UICC_APPL_HOST_ACTIVATE */
+	/* Subblock 2 */
+	-1,
+	-1,
+	-1,			/* Sub block length */
+	-1,			/* Sub block length */
+	-1,			/* Record */
+	-1,			/* Record offset (0=3Dbeginning) */
+	-1,			/* Data amount (0=3Dall) */
+	-1,			/* Filler */
+	/* Subblock 3 */
+	-1,
+	-1,
+	-1,
+	-1,			/* Sub block length */
+	0x4F,
+	0x11,			/* UICC elementary file ID */
+};
+
+const unsigned char uicc_appl_cmd_linear_fixed_EFANR_response[] =3D {
+	0x0D, 0x23, 0x00, 0x00, 0x55, 0x02, 0x01,
+	0x00, 0x0F, 0x00, 0x1C, 0x00, 0x00, 0x00, 0x11,
+	0x00,			/* EFaas record */
+	0x0B, 0x81, 0x20, 0x10, 0x32, 0x54, 0x76, 0x98, 0x10, 0x32, 0x54, 0x76,
+	0xFF,			/* Capability */
+	0x01,			/* EXT 1 */
+	0x1A,			/* ADN SFI */
+	0x01,			/* ADN */
+	0x55, 0x55, 0x55
+};
+
+const uint16_t uicc_appl_cmd_linear_fixed_EFPBR1_req[] =3D {
+	UICC_APPL_CMD_REQ,
+	UICC_APPL_READ_LINEAR_FIXED,
+	-1,
+	-1,			/* Session ID */
+	-1,			/* Filler */
+	-1,			/* Filler */
+	-1,			/* number of subblocks */
+	/* Subblock 1 */
+	-1,
+	-1,
+	-1,
+	-1,			/* Sub block length */
+	-1, -1, -1,		/* Filler */
+	-1,			/* Client ID,
+				read from UICC_APPL_HOST_ACTIVATE */
+	/* Subblock 2 */
+	-1,
+	-1,
+	-1,			/* Sub block length */
+	-1,			/* Sub block length */
+	1,			/* Record */
+	-1,			/* Record offset (0=3Dbeginning) */
+	-1,			/* Data amount (0=3Dall) */
+	-1,			/* Filler */
+	/* Subblock 3 */
+	-1,
+	-1,
+	-1,
+	-1,			/* Sub block length */
+	0x4F,
+	0x30,			/* UICC elementary file ID */
+};
+
+const unsigned char uicc_appl_cmd_linear_fixed_EFPBR1_response[] =3D {
+	0x0D, 0x23, 0x00, 0x00, 0x55, 0x02, 0x01,
+	0x00, 0x0F, 0x00, 0x6C, 0x00, 0x00, 0x00, 0x64,	/* UICC_SB_FILE_DATA */
+	0xA8, 0x19,		/*Type 1, len=3D0x19=3D25 */
+	0xC0, 0x03, 0x4F, 0x3A, 0x02,
+	0xC1, 0x03, 0x4F, 0x25, 0x01,
+	0xC5, 0x03, 0x4F, 0x09, 0x04,
+	0xC6, 0x03, 0x4F, 0x35, 0x05,
+	0xC9, 0x03, 0x4F, 0x99, 0x0C,
+	0xA9, 0x0F,		/*Type 2, len=3D0x0f=3D15 */
+	0xC4, 0x03, 0x4F, 0x11, 0x08,
+	0xC3, 0x03, 0x4F, 0x19, 0x09,
+	0xCA, 0x03, 0x4F, 0x50, 0x0B,
+	0xAA, 0x14,		/*Type 3, len=3D0x14=3D20 */
+	0xC2, 0x03, 0x4F, 0x4A, 0x03,
+	0xC7, 0x03, 0x4F, 0x4B, 0x06,
+	0xC8, 0x03, 0x4F, 0x4C, 0x07,
+	0xCB, 0x03, 0x4F, 0x3D, 0x0A,
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
+	0xFF, 0xFF, 0xFF, 0xFF
+};
+
+const uint16_t uicc_appl_cmd_linear_fixed_EFPBR2_req[] =3D {
+	UICC_APPL_CMD_REQ,
+	UICC_APPL_READ_LINEAR_FIXED,
+	-1,
+	-1,			/* Session ID */
+	-1,			/* Filler */
+	-1,			/* Filler */
+	-1,			/* number of subblocks */
+	/* Subblock 1 */
+	-1,
+	-1,
+	-1,
+	-1,			/* Sub block length */
+	-1, -1, -1,		/* Filler */
+	-1,			/* Client ID,
+				read from UICC_APPL_HOST_ACTIVATE */
+	/* Subblock 2 */
+	-1,
+	-1,
+	-1,			/* Sub block length */
+	-1,			/* Sub block length */
+	2,			/* Record */
+	-1,			/* Record offset (0=3Dbeginning) */
+	-1,			/* Data amount (0=3Dall) */
+	-1,			/* Filler */
+	/* Subblock 3 */
+	-1,
+	-1,
+	-1,
+	-1,			/* Sub block length */
+	0x4F,
+	0x30,			/* UICC elementary file ID */
+};
+
+const unsigned char uicc_appl_cmd_linear_fixed_EFPBR2_response[] =3D {
+	0x0D, 0x23, 0x00, 0x00, 0x55, 0x02, 0x01,
+	0x00, 0x0F, 0x00, 0x6C, 0x00, 0x00, 0x00, 0x64,	/* UICC_SB_FILE_DATA */
+	0xA8, 0x05,		/*Type 1, len=3D5 */
+	0xC7, 0x03, 0x4F, 0x4B, 0x06,
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
+	0xA9, 0x00,		/*Type 2, len=3D0 */
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
+	0xAA, 0x00,		/*Type 3, len=3D0 */
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
+	0xFF, 0xFF, 0xFF, 0xFF
+};
+
+const uint16_t uicc_appl_cmd_linear_fixed_EFMSISDN_req[] =3D {
+	UICC_APPL_CMD_REQ,
+	UICC_APPL_READ_LINEAR_FIXED,
+	-1,
+	-1,			/* Session ID */
+	-1,			/* Filler */
+	-1,			/* Filler */
+	-1,			/* number of subblocks */
+	/* Subblock 1 */
+	-1,
+	-1,
+	-1,
+	-1,			/* Sub block length */
+	-1, -1, -1,		/* Filler */
+	-1,			/* Client ID,
+				read from UICC_APPL_HOST_ACTIVATE */
+	/* Subblock 2 */
+	-1,
+	-1,
+	-1,			/* Sub block length */
+	-1,			/* Sub block length */
+	-1,			/* Record */
+	-1,			/* Record offset (0=3Dbeginning) */
+	-1,			/* Data amount (0=3Dall) */
+	-1,			/* Filler */
+	/* Subblock 3 */
+	-1,
+	-1,
+	-1,
+	-1,			/* Sub block length */
+	0x6f,
+	0x40,			/* UICC elementary file ID */
+};
+
+const unsigned char uicc_appl_cmd_linear_fixed_EFMSISDN_response[] =3D {
+	0x0D, 0x23, 0x00, 0x00, 0x55, 0x02, 0x01,
+	0x00, 0x0F, 0x00, 0x20, 0x00, 0x00, 0x00, 0x18,
+	'A', 'b', 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
+	0x0B, 0x91, 0x76, 0x48, 0x10, 0x32, 0x54, 0x76, 0x98, 0x10,
+	0x32, 0x54, 0xFF, 0xFF
+};
+
+const uint16_t uicc_appl_cmd_linear_fixed_req[] =3D {
+	UICC_APPL_CMD_REQ,
+	UICC_APPL_READ_LINEAR_FIXED
+};
+
+const unsigned char uicc_appl_cmd_linear_fixed_response[] =3D {
+	UICC_APPL_CMD_RESP,
+	UICC_APPL_READ_LINEAR_FIXED,
+	UICC_STATUS_OK,
+	UICC_NO_DETAILS,
+	0,			/*filler */
+	UICC_CARD_TYPE_UICC,
+	1,			/*Number of subblocks */
+	/*Subblock 1 */
+	UICC_SB_FILE_DATA >> 8,
+	UICC_SB_FILE_DATA & 0xff,
+	0,			/*subblock length */
+	(8 + 7),		/*subblock length */
+	0, 0, 0, 7,		/*Length of filedata */
+	0,			/*Filedata: Display condition */
+	'T',			/*Filedata: Name */
+	'i',
+	'e',
+	't',
+	'o',
+	0xff
+};
+
+const uint16_t uicc_appl_cmd_cyclic_req[] =3D {
+	UICC_APPL_CMD_REQ,
+	UICC_APPL_READ_CYCLIC
+};
+
+const unsigned char uicc_appl_cmd_cyclic_response[] =3D {
+	UICC_APPL_CMD_RESP,
+	UICC_APPL_READ_CYCLIC,
+	UICC_STATUS_OK,
+	UICC_NO_DETAILS,
+	0,			/*filler */
+	UICC_CARD_TYPE_UICC,
+	1,			/*Number of subblocks */
+	/*Subblock 1 */
+	UICC_SB_FILE_DATA >> 8,
+	UICC_SB_FILE_DATA & 0xff,
+	0,			/*subblock length */
+	(8 + 1 + 3),		/*subblock length */
+	0, 0, 0, 1,		/*Length of filedata */
+	0,			/*Filedata: Display condition */
+	0x55, 0x55, 0x55
+};
+
+const uint16_t uicc_appl_cmd_transparent_write_req[] =3D {
+	UICC_APPL_CMD_REQ,
+	UICC_APPL_UPDATE_TRANSPARENT,
+};
+
+const unsigned char uicc_appl_cmd_transparent_write_resp[] =3D {
+	UICC_APPL_CMD_RESP,
+	UICC_APPL_UPDATE_TRANSPARENT,
+	UICC_STATUS_OK,
+	UICC_NO_DETAILS,
+};
+
+const uint16_t uicc_appl_cmd_linear_fixed_write_req[] =3D {
+	UICC_APPL_CMD_REQ,
+	UICC_APPL_UPDATE_LINEAR_FIXED,
+};
+
+const unsigned char uicc_appl_cmd_linear_fixed_write_resp[] =3D {
+	UICC_APPL_CMD_RESP,
+	UICC_APPL_UPDATE_LINEAR_FIXED,
+	UICC_STATUS_OK,
+	UICC_NO_DETAILS,
+};
+
+const uint16_t uicc_appl_cmd_cyclic_write_req[] =3D {
+	UICC_APPL_CMD_REQ,
+	UICC_APPL_UPDATE_CYCLIC,
+};
+
+const unsigned char uicc_appl_cmd_cyclic_write_resp[] =3D {
+	UICC_APPL_CMD_RESP,
+	UICC_APPL_UPDATE_CYCLIC,
+	UICC_STATUS_OK,
+	UICC_NO_DETAILS,
+};
+
+const uint16_t uicc_app_activate_req[] =3D {
+	UICC_APPLICATION_REQ,
+	UICC_APPL_HOST_ACTIVATE,
+};
+
+const unsigned char uicc_app_activate_ok_resp[] =3D {
+	UICC_APPLICATION_RESP,
+	UICC_APPL_HOST_ACTIVATE,
+	UICC_STATUS_OK,
+	UICC_NO_DETAILS,
+	0,
+	UICC_TYPE,		/*Card type */
+	4,			/* Number of subblocks */
+
+	/* Subblock 1 */
+	UICC_SB_CLIENT >> 8,
+	UICC_SB_CLIENT & 0xff,
+	0,			/*len */
+	8,			/*len */
+	0x55, 0x55, 0x55,
+	5,			/* Client ID */
+
+	/* Subblock 2 */
+	UICC_SB_FCI >> 8,
+	UICC_SB_FCI & 0xff,
+	0,			/*len */
+	0x17,			/*len */
+	0,
+	0x0D,
+	UICC_TYPE,
+	0x55,
+	0x62, 0x0B,
+	0xC6, 0x09, 0x90, 0x01, 0xC0,
+	0x83, 0x01, 0x01, 0x83, 0x01, 0x81, 0x55, 0x55,
+
+	/* Subblock 3 */
+	UICC_SB_CHV >> 8,
+	UICC_SB_CHV & 0xff,
+	0,			/*len */
+	8,			/*len */
+	0x01, 0x01, 0x55, 0x55,
+
+	/* Subblock 4 */
+	UICC_SB_CHV >> 8,
+	UICC_SB_CHV & 0xff,
+	0,			/*len */
+	8,			/*len */
+	0x02, 0x02, 0x55, 0x55,
+};
+
+const unsigned char uicc_app_activate_fail_resp[] =3D {
+	UICC_APPLICATION_RESP,
+	UICC_APPL_HOST_ACTIVATE,
+	UICC_STATUS_FAIL,
+	UICC_INVALID_PARAMETERS,
+	0,
+	UICC_CARD_TYPE_ICC,
+	0,			/* Number of subblocks */
+};
+
+const uint16_t uicc_app_list_req[] =3D {
+	UICC_APPLICATION_REQ,
+	UICC_APPL_LIST,
+};
+
+const unsigned char uicc_app_list_resp[] =3D {
+	UICC_APPLICATION_RESP,
+	UICC_APPL_LIST,
+	UICC_STATUS_CARD_NOT_PRESENT,	/* UICC_STATUS_OK, */
+	UICC_NO_DETAILS,
+	0,			/*filler */
+	UICC_TYPE,		/*Card type */
+	2,			/* Number of subblocks */
+
+	/* Sub-block 1 */
+	UICC_SB_APPL_DATA_OBJECT >> 8,
+	UICC_SB_APPL_DATA_OBJECT & 0xff,
+	0,			/*len */
+	12,			/*len */
+	0,			/*filler */
+	0,			/*filler */
+	UICC_TYPE,		/*Appl type */
+	UICC_TYPE,		/*Appl ID */
+	UICC_STATUS_APPL_ACTIVE,
+	0,			/*Appl Data Object len */
+	0,			/*filler */
+	0,			/*filler */
+
+	/* Sub-block 2 */
+	UICC_SB_APPLICATION >> 8,
+	UICC_SB_APPLICATION & 0xff,
+	0,			/*len */
+	8,			/*len */
+	0,			/*fille*r */
+	0,			/*filler */
+	UICC_TYPE,		/*Apll type */
+	UICC_TYPE,		/*Appl ID */
+};
+
+const unsigned char uicc_app_list_fail_resp[] =3D {
+	UICC_APPLICATION_RESP,
+	UICC_APPL_LIST,
+	UICC_STATUS_OK,
+	UICC_NO_DETAILS,
+	0,			/*filler */
+	1,			/*Card type */
+	2,			/* Number of subblocks */
+	/* Sub-block 1 */
+	UICC_SB_APPL_DATA_OBJECT >> 8,
+	UICC_SB_APPL_DATA_OBJECT & 0xff,
+	0,			/*len */
+	12,			/*len */
+	0,			/*filler */
+	0,			/*filler */
+	1,			/*Appl type */
+	1,			/*Appl ID */
+	UICC_STATUS_APPL_ACTIVE,
+	0,			/*Appl Data Object len */
+	0,			/*filler */
+	0,			/*filler */
+	/* Sub-block 2 */
+	UICC_SB_APPLICATION >> 8,
+	UICC_SB_APPLICATION & 0xff,
+	0,			/*len */
+	8,			/*len */
+	0,			/*fille*r */
+	0,			/*filler */
+	1,			/*Apll type */
+	1,			/*Appl ID */
+};
+
+/* SECURITY Simulation messages */
+const uint16_t uicc_pin_verify_req[] =3D {
+	UICC_PIN_REQ,
+	UICC_PIN_VERIFY,
+};
+
+const unsigned char uicc_pin_verify_resp[] =3D {
+	UICC_PIN_RESP,
+	UICC_PIN_VERIFY,
+	UICC_STATUS_OK,
+	0,
+	UICC_CARD_TYPE_UICC,
+	0x01,
+	0
+};
+
+const uint16_t uicc_pin_enable_req[] =3D {
+	UICC_PIN_REQ,
+	UICC_PIN_ENABLE,
+};
+
+const unsigned char uicc_pin_enable_resp[] =3D {
+	UICC_PIN_RESP,
+	UICC_PIN_ENABLE,
+	UICC_STATUS_OK,
+	0,
+	UICC_CARD_TYPE_UICC,
+	0x01,
+	0
+};
+
+const uint16_t uicc_pin_disable_req[] =3D {
+	UICC_PIN_REQ,
+	UICC_PIN_DISABLE,
+};
+
+const unsigned char uicc_pin_disable_resp[] =3D {
+	UICC_PIN_RESP,
+	UICC_PIN_DISABLE,
+	UICC_STATUS_FAIL,
+	0,
+	UICC_CARD_TYPE_UICC,
+	0x01,
+	1,
+	/*Sub-block 1 */
+	UICC_SB_STATUS_WORD >> 8,
+	UICC_SB_STATUS_WORD & 0xff,
+	0,
+	8,
+	0x55, 0x55,		/*filler */
+	0x63, 0xC1,
+};
+
+const uint16_t uicc_pin_reset_req[] =3D {
+	UICC_PIN_REQ,
+	UICC_PIN_UNBLOCK,
+};
+
+const unsigned char uicc_pin_reset_resp[] =3D {
+	UICC_PIN_RESP,
+	UICC_PIN_UNBLOCK,
+	UICC_STATUS_OK,
+	0,
+	UICC_CARD_TYPE_UICC,
+	0x01,
+	0
+};
+
+const uint16_t uicc_pin_change_req[] =3D {
+	UICC_PIN_REQ,
+	UICC_PIN_CHANGE,
+};
+
+const unsigned char uicc_pin_change_resp[] =3D {
+	UICC_PIN_RESP,
+	UICC_PIN_CHANGE,
+	UICC_STATUS_OK,
+	0,
+	UICC_CARD_TYPE_UICC,
+	0x01,
+	0
+};
+
+const uint16_t uicc_pin_query_req[] =3D {
+	UICC_PIN_REQ,
+	UICC_PIN_INFO,
+};
+
+const unsigned char uicc_pin_query_resp[] =3D {
+	UICC_PIN_RESP,
+	UICC_PIN_INFO,
+	UICC_STATUS_OK,
+	UICC_NO_DETAILS,
+	0,
+	UICC_CARD_TYPE_UICC,
+	1,
+	/*SB 1 */
+	UICC_SB_PIN_INFO >> 8,
+	UICC_SB_PIN_INFO & 0xff,
+	0,
+	8,
+	UICC_STATUS_PIN_ENABLED,
+	5,			/*PIN attempts */
+	5,			/*PUK attempts */
+	0
+};
+
+const uint16_t uicc_pin_prompt_req[] =3D {
+	UICC_PIN_REQ,
+	UICC_PIN_PROMPT_VERIFY,
+};
+
+const unsigned char uicc_pin_prompt_resp[] =3D {
+	0x0A, 0x18, 0x41, 0x00, 0x55, 0x02, 0x00
+};
+
+const uint16_t uicc_simlock_query_req[] =3D {
+	UICC_SIMLOCK_REQ,
+	UICC_SIMLOCK_ACTIVE,
+};
+
+const unsigned char uicc_simlock_query_resp[] =3D {
+	UICC_SIMLOCK_RESP,
+	UICC_SIMLOCK_ACTIVE,
+	UICC_STATUS_OK,
+	0,
+	UICC_SIMLOCK_STATUS_INACTIVE
+};
+
+/* CALL PIPE Simulation messages */
+const unsigned char call_modem_status_resp_msg[] =3D {
+	CALL_MODEM_STATUS_RESP, 0x00, 0x03,
+	CALL_MODEM_SB_STATUS_INFO, 0x08,
+	CALL_MODEM_ID_1, CALL_MODEM_MODE_SPEECH,
+	0x01, CALL_MODEM_STATUS_WAITING, 0x00, 0x00,
+	CALL_MODEM_SB_ADDR_AND_STATUS_INFO, 0x20,
+	CALL_MODEM_ID_1, CALL_MODEM_MODE_SPEECH,
+	0x01, CALL_MODEM_STATUS_WAITING, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x0A,
+	0x00, 0x00, 0x00, 0x37, 0x00, 0x00, 0x00, 0x31, 0x00, 0x32,
+	0x00, 0x33, 0x00, 0x34, 0x00, 0x35, 0x00, 0x36, 0x00, 0x36,
+	CALL_MODEM_SB_CAUSE, 0x04,
+	CALL_MODEM_CAUSE_TYPE_SERVER, CALL_MODEM_CAUSE_NO_CALL
+};
+
+const unsigned char call_modem_create_resp_msg2[] =3D {
+	CALL_MODEM_CREATE_RESP, CALL_MODEM_ID_2, 0
+};
+
+const unsigned char call_modem_release_resp_msg2[] =3D {
+	CALL_MODEM_RELEASE_RESP, CALL_MODEM_ID_2, 1,
+	CALL_MODEM_SB_CAUSE, 4,
+	CALL_MODEM_CAUSE_TYPE_CLIENT, CALL_MODEM_CAUSE_RELEASE_BY_USER
+};
+
+const uint16_t call_modem_control_req_hold_msg[] =3D {
+	CALL_MODEM_CONTROL_REQ, CALL_MODEM_ID_ACTIVE, 0x01,
+	CALL_MODEM_SB_OPERATION, 0x04,
+	CALL_MODEM_OP_HOLD, 0x00
+};
+
+const unsigned char call_modem_control_resp_hold_msg[] =3D {
+	CALL_MODEM_CONTROL_RESP, CALL_MODEM_ID_ACTIVE, 0x02,
+	CALL_MODEM_SB_OPERATION, 0x04,
+	CALL_MODEM_OP_HOLD, 0x00,
+	CALL_MODEM_SB_CAUSE, 0x04,
+	CALL_MODEM_CAUSE_TYPE_CLIENT, 0x00
+};
+
+const uint16_t call_modem_control_req_retr_msg[] =3D {
+	CALL_MODEM_CONTROL_REQ, CALL_MODEM_ID_HOLD, 0x01,
+	CALL_MODEM_SB_OPERATION, 0x04,
+	CALL_MODEM_OP_RETRIEVE, 0x00
+};
+
+const unsigned char call_modem_control_resp_retr_msg[] =3D {
+	CALL_MODEM_CONTROL_RESP, CALL_MODEM_ID_HOLD, 0x01,
+	CALL_MODEM_SB_OPERATION, 0x04,
+	CALL_MODEM_OP_RETRIEVE, 0x00
+};
+
+const uint16_t call_modem_control_req_swap_msg[] =3D {
+	CALL_MODEM_CONTROL_REQ, CALL_MODEM_ID_ACTIVE, 0x01,
+	CALL_MODEM_SB_OPERATION, 0x04,
+	CALL_MODEM_OP_SWAP, 0x00
+};
+
+const unsigned char call_modem_control_resp_swap_msg[] =3D {
+	CALL_MODEM_CONTROL_RESP, CALL_MODEM_ID_ACTIVE, 0x01,
+	CALL_MODEM_SB_OPERATION, 0x04,
+	CALL_MODEM_OP_SWAP, 0x00
+};
+
+const uint16_t call_modem_control_req_transfer_msg[] =3D {
+	CALL_MODEM_CONTROL_REQ, CALL_MODEM_ID_HOLD, 0x01,
+	CALL_MODEM_SB_OPERATION, 0x04,
+	CALL_MODEM_OP_TRANSFER, 0x00
+};
+
+const unsigned char call_modem_control_resp_transfer_msg[] =3D {
+	CALL_MODEM_CONTROL_RESP, CALL_MODEM_ID_ACTIVE, 0x02,
+	CALL_MODEM_SB_OPERATION, 0x04,
+	CALL_MODEM_OP_TRANSFER, 0x00,
+	CALL_MODEM_SB_CAUSE, 0x04,
+	CALL_MODEM_CAUSE_TYPE_NETWORK,
+	CALL_MODEM_NW_CAUSE_FACILITY_REJECTED
+};
+
+const uint16_t call_modem_control_req_conf_build_msg[] =3D {
+	CALL_MODEM_CONTROL_REQ, CALL_MODEM_ID_ACTIVE, 0x01,
+	CALL_MODEM_SB_OPERATION, 0x04,
+	CALL_MODEM_OP_CONFERENCE_BUILD, 0x00
+};
+
+const unsigned char call_modem_control_resp_conf_build_msg[] =3D {
+	CALL_MODEM_CONTROL_RESP, CALL_MODEM_ID_ACTIVE, 0x01,
+	CALL_MODEM_SB_OPERATION, 0x04,
+	CALL_MODEM_OP_CONFERENCE_BUILD, 0x00
+};
+
+const uint16_t call_modem_control_req_pri_chat_msg[] =3D {
+	CALL_MODEM_CONTROL_REQ, CALL_MODEM_ID_2, 0x01,
+	CALL_MODEM_SB_OPERATION, 0x04,
+	CALL_MODEM_OP_CONFERENCE_SPLIT, 0x00
+};
+
+const unsigned char call_modem_control_resp_pri_chat_msg[] =3D {
+	CALL_MODEM_CONTROL_RESP, CALL_MODEM_ID_2, 0x01,
+	CALL_MODEM_SB_OPERATION, 0x04,
+	CALL_MODEM_OP_CONFERENCE_SPLIT, 0x00
+};
+
+const unsigned char call_modem_control_ind_msg[] =3D {
+	CALL_MODEM_CONTROL_IND, CALL_MODEM_ID_NONE, 0x01,
+	CALL_MODEM_SB_OPERATION, 0x04,
+	CALL_MODEM_OP_UNKNOWN, 0x00
+};
+
+const unsigned char call_modem_control_ind_error_msg[] =3D {
+	CALL_MODEM_CONTROL_IND, CALL_MODEM_ID_NONE, 0x02,
+	CALL_MODEM_SB_OPERATION, 0x04,
+	CALL_MODEM_OP_UNKNOWN, 0x00,
+	CALL_MODEM_SB_CAUSE, 0x04,
+	CALL_MODEM_CAUSE_TYPE_NETWORK, CALL_MODEM_NW_CAUSE_FACILITY_REJECTED
+};
+
+const unsigned char call_modem_notification_ind_test[] =3D {
+	CALL_MODEM_NOTIFICATION_IND, 0x01, 0x07,
+	CALL_MODEM_SB_NOTIFY, 0x04, 0x00, 0x00,
+	CALL_MODEM_SB_SS_CODE, 0x04, 0x01, 0x4D,
+	CALL_MODEM_SB_SS_STATUS, 0x04, 0x07, 0x00,
+	CALL_MODEM_SB_SS_NOTIFY, 0x04, 0x07, 0x00,
+	CALL_MODEM_SB_SS_NOTIFY_INDICATOR, 0x04, 0x07, 0x00,
+	CALL_MODEM_SB_SS_HOLD_INDICATOR, 0x04, 0x00, 0x00,
+	CALL_MODEM_SB_SS_ECT_INDICATOR, 0x04, 0x01, 0x00
+};
+
+const unsigned char call_modem_notification_ind_barring_inc[] =3D {
+	CALL_MODEM_NOTIFICATION_IND, 0x01, 0x02,
+	CALL_MODEM_SB_SS_CODE, 0x04, 0x01, 0x61,
+	CALL_MODEM_SB_SS_STATUS, 0x04, 0x07, 0x00
+};
+
+const unsigned char call_modem_notification_ind_barring_out[] =3D {
+	CALL_MODEM_NOTIFICATION_IND, 0x01, 0x02,
+	CALL_MODEM_SB_SS_CODE, 0x04, 0x01, 0x4D,
+	CALL_MODEM_SB_SS_STATUS, 0x04, 0x07, 0x00
+};
+
+const unsigned char call_modem_notification_ind_forwarding_uncond[] =3D {
+	CALL_MODEM_NOTIFICATION_IND, 0x01, 0x02,
+	CALL_MODEM_SB_SS_CODE, 0x04, 0x00, 0x15,
+	CALL_MODEM_SB_SS_STATUS, 0x04, 0x07, 0x00
+};
+
+const unsigned char call_modem_notification_ind_forwarding_cond[] =3D {
+	CALL_MODEM_NOTIFICATION_IND, 0x01, 0x02,
+	CALL_MODEM_SB_SS_CODE, 0x04, 0x00, 0x04,
+	CALL_MODEM_SB_SS_STATUS, 0x04, 0x07, 0x00
+};
+
+const unsigned char call_modem_notification_ind_call_hold[] =3D {
+	CALL_MODEM_NOTIFICATION_IND, 0x01, 0x02,
+	CALL_MODEM_SB_SS_CODE, 0x04, 0xFF, 0xFF,
+	CALL_MODEM_SB_SS_STATUS, 0x04, CALL_MODEM_SS_STATUS_QUIESCENT, 0x00
+};
+
+const unsigned char call_modem_notification_ind_mpty[] =3D {
+	CALL_MODEM_NOTIFICATION_IND, 0x01, 0x02,
+	CALL_MODEM_SB_SS_CODE, 0x04, 0xFF, 0xFE,
+	CALL_MODEM_SB_SS_STATUS, 0x04, CALL_MODEM_SS_STATUS_ACTIVE, 0x00
+};
+
+const unsigned char call_modem_notification_ind_cug_call[] =3D {
+	CALL_MODEM_NOTIFICATION_IND, 0x01, 0x03,
+	CALL_MODEM_SB_CUG_INFO, 0x08, 0x00, 0x00, 0x7F, 0xFF, 0x00, 0x00,
+	CALL_MODEM_SB_SS_STATUS, 0x04, 0x07, 0x00,
+	CALL_MODEM_SB_REMOTE_ADDRESS, 0x19, 0x10, 0x00, 0x00,
+	0x09,
+	0x00, 0x36, 0x00, 0x36, 0x00, 0x38, 0x00, 0x31, 0x00, 0x32, 0x00, 0x33,
+	0x00, 0x34, 0x00, 0x35, 0x00, 0x36,
+	0x00
+};
+
+const unsigned char call_modem_dtmf_send_resp_msg2[] =3D {
+	CALL_MODEM_DTMF_SEND_RESP, CALL_MODEM_ID_2, 1,
+	CALL_MODEM_SB_CAUSE, 0x04,
+	CALL_MODEM_CAUSE_TYPE_CLIENT, 0x00
+};
+
+const unsigned char call_modem_answer_resp_msg3[] =3D {
+	CALL_MODEM_ANSWER_RESP, CALL_MODEM_ID_3, 0
+};
+
+const unsigned char call_modem_status_ind_idle_msg[] =3D {
+	CALL_MODEM_STATUS_IND, CALL_MODEM_ID_1, 0x03,
+	CALL_MODEM_SB_STATUS, 0x04,
+	CALL_MODEM_STATUS_IDLE, 0x00,
+	CALL_MODEM_SB_MODE, 0x04,
+	CALL_MODEM_MODE_SPEECH, 0x00,
+	CALL_MODEM_SB_CAUSE, 0x04,
+	CALL_MODEM_CAUSE_TYPE_CLIENT, CALL_MODEM_CAUSE_BUSY_USER_REQUEST
+};
+
+const unsigned char call_modem_status_ind_create_msg2[] =3D {
+	CALL_MODEM_STATUS_IND, CALL_MODEM_ID_2, 4,
+	CALL_MODEM_SB_STATUS, 4,
+	CALL_MODEM_STATUS_CREATE, 0,
+	CALL_MODEM_SB_MODE, 4,
+	CALL_MODEM_MODE_SPEECH, 0,
+	CALL_MODEM_SB_ORIGIN_ADDRESS, 0x1C,
+	0x28, 0x01, 0x00, 0x0A,
+	0x00, 0x00, 0x00, 0x37, 0x00, 0x00, 0x00, 0x31, 0x00, 0x32,
+	0x00, 0x33, 0x00, 0x34, 0x00, 0x35, 0x00, 0x36, 0x00, 0x37,
+	0x00, 0x00,
+	CALL_MODEM_SB_DESTINATION_ADDRESS, 0x1C,
+	0x28, 0x01, 0x00, 0x0A,
+	0x00, 0x00, 0x00, 0x37, 0x00, 0x00, 0x00, 0x31, 0x00, 0x32,
+	0x00, 0x33, 0x00, 0x34, 0x00, 0x35, 0x00, 0x36, 0x00, 0x38,
+	0x00, 0x00
+};
+
+const unsigned char call_modem_status_ind_proceeding_msg2[] =3D {
+	CALL_MODEM_STATUS_IND, CALL_MODEM_ID_2, 4,
+	CALL_MODEM_SB_STATUS, 4,
+	CALL_MODEM_STATUS_PROCEEDING, 0,
+	CALL_MODEM_SB_MODE, 4,
+	CALL_MODEM_MODE_SPEECH, 0,
+	CALL_MODEM_SB_ORIGIN_ADDRESS, 0x1C,
+	0x28, 0x01, 0x00, 0x0A,
+	0x00, 0x00, 0x00, 0x37, 0x00, 0x00, 0x00, 0x31, 0x00, 0x32,
+	0x00, 0x33, 0x00, 0x34, 0x00, 0x35, 0x00, 0x36, 0x00, 0x37,
+	0x00, 0x00,
+	CALL_MODEM_SB_DESTINATION_ADDRESS, 0x1C,
+	0x28, 0x01, 0x00, 0x0A,
+	0x00, 0x00, 0x00, 0x37, 0x00, 0x00, 0x00, 0x31, 0x00, 0x32,
+	0x00, 0x33, 0x00, 0x34, 0x00, 0x35, 0x00, 0x36, 0x00, 0x38,
+	0x00, 0x00
+};
+
+const unsigned char call_modem_status_ind_mo_alert_msg2[] =3D {
+	CALL_MODEM_STATUS_IND, CALL_MODEM_ID_2, 4,
+	CALL_MODEM_SB_STATUS, 4,
+	CALL_MODEM_STATUS_MO_ALERTING, 0,
+	CALL_MODEM_SB_MODE, 4,
+	CALL_MODEM_MODE_SPEECH, 0,
+	CALL_MODEM_SB_ORIGIN_ADDRESS, 0x1C,
+	0x28, 0x01, 0x00, 0x0A,
+	0x00, 0x00, 0x00, 0x37, 0x00, 0x00, 0x00, 0x31, 0x00, 0x32,
+	0x00, 0x33, 0x00, 0x34, 0x00, 0x35, 0x00, 0x36, 0x00, 0x37,
+	0x00, 0x00,
+	CALL_MODEM_SB_DESTINATION_ADDRESS, 0x1C,
+	0x28, 0x01, 0x00, 0x0A,
+	0x00, 0x00, 0x00, 0x37, 0x00, 0x00, 0x00, 0x31, 0x00, 0x32,
+	0x00, 0x33, 0x00, 0x34, 0x00, 0x35, 0x00, 0x36, 0x00, 0x38,
+	0x00, 0x00
+};
+
+const unsigned char call_modem_status_ind_active_msg2[] =3D {
+	CALL_MODEM_STATUS_IND, CALL_MODEM_ID_2, 0x04,
+	CALL_MODEM_SB_STATUS, 0x04,
+	CALL_MODEM_STATUS_ACTIVE, 0x00,
+	CALL_MODEM_SB_MODE, 0x04,
+	CALL_MODEM_MODE_SPEECH, 0x00,
+	CALL_MODEM_SB_ORIGIN_ADDRESS, 0x1C,
+	0x28, 0x01, 0x00, 0x0A,
+	0x00, 0x00, 0x00, 0x37, 0x00, 0x00, 0x00, 0x31, 0x00, 0x32,
+	0x00, 0x33, 0x00, 0x34, 0x00, 0x35, 0x00, 0x36, 0x00, 0x37,
+	0x00, 0x00,
+	CALL_MODEM_SB_DESTINATION_ADDRESS, 0x1C,
+	0x28, 0x01, 0x00, 0x0A,
+	0x00, 0x00, 0x00, 0x37, 0x00, 0x00, 0x00, 0x31, 0x00, 0x32,
+	0x00, 0x33, 0x00, 0x34, 0x00, 0x35, 0x00, 0x36, 0x00, 0x38,
+	0x00, 0x00
+};
+
+const unsigned char call_modem_status_ind_hold_msg2[] =3D {
+	CALL_MODEM_STATUS_IND, CALL_MODEM_ID_2, 0x03,
+	CALL_MODEM_SB_STATUS, 0x04,
+	CALL_MODEM_STATUS_HOLD, 0x00,
+	CALL_MODEM_SB_MODE, 0x04,
+	CALL_MODEM_MODE_SPEECH, 0x00
+};
+
+const unsigned char call_modem_status_ind_hold_msg2multi[] =3D {
+	CALL_MODEM_STATUS_IND, CALL_MODEM_ID_2, 0x03,
+	CALL_MODEM_SB_STATUS, 0x04,
+	CALL_MODEM_STATUS_HOLD, 0x00,
+	CALL_MODEM_SB_MODE, 0x04,
+	CALL_MODEM_MODE_SPEECH, 0x00
+};
+
+const unsigned char call_modem_status_ind_mo_release_msg2[] =3D {
+	CALL_MODEM_STATUS_IND, CALL_MODEM_ID_2, 0x03,
+	CALL_MODEM_SB_STATUS, 0x04,
+	CALL_MODEM_STATUS_MO_RELEASE, 0x00,
+	CALL_MODEM_SB_MODE, 0x04,
+	CALL_MODEM_MODE_SPEECH, 0x00,
+	CALL_MODEM_SB_CAUSE, 0x04,
+	CALL_MODEM_CAUSE_TYPE_CLIENT, CALL_MODEM_CAUSE_RELEASE_BY_USER
+};
+
+const unsigned char call_modem_status_ind_idle_msg2[] =3D {
+	CALL_MODEM_STATUS_IND, CALL_MODEM_ID_2, 0x03,
+	CALL_MODEM_SB_STATUS, 0x04,
+	CALL_MODEM_STATUS_IDLE, 0x00,
+	CALL_MODEM_SB_MODE, 0x04,
+	CALL_MODEM_MODE_SPEECH, 0x00,
+	CALL_MODEM_SB_CAUSE, 0x04,
+	CALL_MODEM_CAUSE_TYPE_CLIENT, CALL_MODEM_CAUSE_RELEASE_BY_USER
+};
+
+const unsigned char call_modem_status_ind_coming_msg3[] =3D {
+	CALL_MODEM_STATUS_IND, CALL_MODEM_ID_3, 4,
+	CALL_MODEM_SB_STATUS, 4,
+	CALL_MODEM_STATUS_COMING, 0,
+	CALL_MODEM_SB_MODE, 4,
+	CALL_MODEM_MODE_SPEECH, 0,
+	CALL_MODEM_SB_ORIGIN_ADDRESS, 0x1C,
+	0x28, 0x01, 0x00, 0x0A,
+	0x00, 0x00, 0x00, 0x37, 0x00, 0x00, 0x00, 0x31, 0x00, 0x32,
+	0x00, 0x33, 0x00, 0x34, 0x00, 0x35, 0x00, 0x36, 0x00, 0x38,
+	0x00, 0x00,
+	CALL_MODEM_SB_DESTINATION_ADDRESS, 0x1C,
+	0x28, 0x01, 0x00, 0x0A,
+	0x00, 0x00, 0x00, 0x37, 0x00, 0x00, 0x00, 0x31, 0x00, 0x32,
+	0x00, 0x33, 0x00, 0x34, 0x00, 0x35, 0x00, 0x36, 0x00, 0x37,
+	0x00, 0x00
+};
+
+const unsigned char call_modem_status_ind_proceeding_msg3[] =3D {
+	CALL_MODEM_STATUS_IND, CALL_MODEM_ID_3, 4,
+	CALL_MODEM_SB_STATUS, 4,
+	CALL_MODEM_STATUS_PROCEEDING, 0,
+	CALL_MODEM_SB_MODE, 4,
+	CALL_MODEM_MODE_SPEECH, 0,
+	CALL_MODEM_SB_ORIGIN_ADDRESS, 0x1C,
+	0x28, 0x01, 0x00, 0x0A,
+	0x00, 0x00, 0x00, 0x37, 0x00, 0x00, 0x00, 0x31, 0x00, 0x32,
+	0x00, 0x33, 0x00, 0x34, 0x00, 0x35, 0x00, 0x36, 0x00, 0x38,
+	0x00, 0x00,
+	CALL_MODEM_SB_DESTINATION_ADDRESS, 0x1C,
+	0x28, 0x01, 0x00, 0x0A,
+	0x00, 0x00, 0x00, 0x37, 0x00, 0x00, 0x00, 0x31, 0x00, 0x32,
+	0x00, 0x33, 0x00, 0x34, 0x00, 0x35, 0x00, 0x36, 0x00, 0x37,
+	0x00, 0x00
+};
+
+const unsigned char call_modem_status_ind_mt_alerting_msg3[] =3D {
+	CALL_MODEM_STATUS_IND, CALL_MODEM_ID_3, 4,
+	CALL_MODEM_SB_STATUS, 4,
+	CALL_MODEM_STATUS_MT_ALERTING, 0,
+	CALL_MODEM_SB_MODE, 4,
+	CALL_MODEM_MODE_SPEECH, 0,
+	CALL_MODEM_SB_ORIGIN_ADDRESS, 0x1C,
+	0x28, 0x01, 0x00, 0x0A,
+	0x00, 0x00, 0x00, 0x37, 0x00, 0x00, 0x00, 0x31, 0x00, 0x32,
+	0x00, 0x33, 0x00, 0x34, 0x00, 0x35, 0x00, 0x36, 0x00, 0x38,
+	0x00, 0x00,
+	CALL_MODEM_SB_DESTINATION_ADDRESS, 0x1C,
+	0x28, 0x01, 0x00, 0x0A,
+	0x00, 0x00, 0x00, 0x37, 0x00, 0x00, 0x00, 0x31, 0x00, 0x32,
+	0x00, 0x33, 0x00, 0x34, 0x00, 0x35, 0x00, 0x36, 0x00, 0x37,
+	0x00, 0x00
+};
+
+const unsigned char call_modem_status_ind_answered_msg3[] =3D {
+	CALL_MODEM_STATUS_IND, CALL_MODEM_ID_3, 0x04,
+	CALL_MODEM_SB_STATUS, 0x04,
+	CALL_MODEM_STATUS_ANSWERED, 0x00,
+	CALL_MODEM_SB_MODE, 0x04,
+	CALL_MODEM_MODE_SPEECH, 0x00,
+	CALL_MODEM_SB_ORIGIN_ADDRESS, 0x1C,
+	0x28, 0x01, 0x00, 0x0A,
+	0x00, 0x00, 0x00, 0x37, 0x00, 0x00, 0x00, 0x31, 0x00, 0x32,
+	0x00, 0x33, 0x00, 0x34, 0x00, 0x35, 0x00, 0x36, 0x00, 0x38,
+	0x00, 0x00,
+	CALL_MODEM_SB_DESTINATION_ADDRESS, 0x1C,
+	0x28, 0x01, 0x00, 0x0A,
+	0x00, 0x00, 0x00, 0x37, 0x00, 0x00, 0x00, 0x31, 0x00, 0x32,
+	0x00, 0x33, 0x00, 0x34, 0x00, 0x35, 0x00, 0x36, 0x00, 0x37,
+	0x00, 0x00
+};
+
+const unsigned char call_modem_status_ind_active_msg3[] =3D {
+	CALL_MODEM_STATUS_IND, CALL_MODEM_ID_3, 0x04,
+	CALL_MODEM_SB_STATUS, 0x04,
+	CALL_MODEM_STATUS_ACTIVE, 0x00,
+	CALL_MODEM_SB_MODE, 0x04,
+	CALL_MODEM_MODE_SPEECH, 0x00,
+	CALL_MODEM_SB_ORIGIN_ADDRESS, 0x1C,
+	0x28, 0x01, 0x00, 0x0A,
+	0x00, 0x00, 0x00, 0x37, 0x00, 0x00, 0x00, 0x31, 0x00, 0x32,
+	0x00, 0x33, 0x00, 0x34, 0x00, 0x35, 0x00, 0x36, 0x00, 0x38,
+	0x00, 0x00,
+	CALL_MODEM_SB_DESTINATION_ADDRESS, 0x1C,
+	0x28, 0x01, 0x00, 0x0A,
+	0x00, 0x00, 0x00, 0x37, 0x00, 0x00, 0x00, 0x31, 0x00, 0x32,
+	0x00, 0x33, 0x00, 0x34, 0x00, 0x35, 0x00, 0x36, 0x00, 0x37,
+	0x00, 0x00
+};
+
+const unsigned char call_modem_status_ind_hold_init_msg3[] =3D {
+	CALL_MODEM_STATUS_IND, CALL_MODEM_ID_3, 0x03,
+	CALL_MODEM_SB_STATUS, 0x04,
+	CALL_MODEM_STATUS_HOLD_INITIATED, 0x00,
+	CALL_MODEM_SB_MODE, 0x04,
+	CALL_MODEM_MODE_SPEECH, 0x00
+};
+
+const unsigned char call_modem_status_ind_hold_msg3[] =3D {
+	CALL_MODEM_STATUS_IND, CALL_MODEM_ID_3, 0x03,
+	CALL_MODEM_SB_STATUS, 0x04,
+	CALL_MODEM_STATUS_HOLD, 0x00,
+	CALL_MODEM_SB_MODE, 0x04,
+	CALL_MODEM_MODE_SPEECH, 0x00
+};
+
+const unsigned char call_modem_status_ind_mt_release_msg3[] =3D {
+	CALL_MODEM_STATUS_IND, CALL_MODEM_ID_3, 0x03,
+	CALL_MODEM_SB_STATUS, 0x04,
+	CALL_MODEM_STATUS_MT_RELEASE, 0x00,
+	CALL_MODEM_SB_MODE, 0x04,
+	CALL_MODEM_MODE_SPEECH, 0x00,
+	CALL_MODEM_SB_CAUSE, 0x04,
+	CALL_MODEM_CAUSE_TYPE_NETWORK, CALL_MODEM_NW_CAUSE_NORMAL
+};
+
+const unsigned char call_modem_status_ind_idle_msg3[] =3D {
+	CALL_MODEM_STATUS_IND, CALL_MODEM_ID_3, 0x03,
+	CALL_MODEM_SB_STATUS, 0x04,
+	CALL_MODEM_STATUS_IDLE, 0x00,
+	CALL_MODEM_SB_MODE, 0x04,
+	CALL_MODEM_MODE_SPEECH, 0x00,
+	CALL_MODEM_SB_CAUSE, 0x04,
+	CALL_MODEM_CAUSE_TYPE_NETWORK, CALL_MODEM_NW_CAUSE_NORMAL
+};
+
+const unsigned char call_modem_mt_alert[] =3D {
+	CALL_MODEM_MT_ALERT_IND,
+	CALL_MODEM_ID_ALL,
+	0x00
+};
+
+const unsigned char call_modem_status_ind_waiting_msg[] =3D {
+	CALL_MODEM_STATUS_IND, CALL_MODEM_ID_1, 4,
+	CALL_MODEM_SB_STATUS, 4,
+	CALL_MODEM_STATUS_WAITING, 0,
+	CALL_MODEM_SB_MODE, 4,
+	CALL_MODEM_MODE_SPEECH, 0,
+	CALL_MODEM_SB_ORIGIN_ADDRESS, 0x1C,
+	0x28, 0x01, 0x00, 0x0A,
+	0x00, 0x00, 0x00, 0x37, 0x00, 0x00, 0x00, 0x31, 0x00, 0x32,
+	0x00, 0x33, 0x00, 0x34, 0x00, 0x35, 0x00, 0x36, 0x00, 0x36,
+	0x00, 0x00,
+	CALL_MODEM_SB_DESTINATION_ADDRESS, 0x1C,
+	0x28, 0x01, 0x00, 0x0A,
+	0x00, 0x00, 0x00, 0x37, 0x00, 0x00, 0x00, 0x31, 0x00, 0x32,
+	0x00, 0x33, 0x00, 0x34, 0x00, 0x35, 0x00, 0x36, 0x00, 0x37,
+	0x00, 0x00
+};
+
+const uint16_t call_modem_relese_req_waiting_msg[] =3D {
+	CALL_MODEM_RELEASE_REQ, CALL_MODEM_ID_1, 0x01,
+	CALL_MODEM_SB_CAUSE, 0x04,
+	CALL_MODEM_CAUSE_TYPE_CLIENT, CALL_MODEM_CAUSE_BUSY_USER_REQUEST
+};
+
+const unsigned char call_modem_relese_resp_waiting_msg[] =3D {
+	CALL_MODEM_RELEASE_RESP, CALL_MODEM_ID_1, 0x01,
+	CALL_MODEM_SB_CAUSE, 0x04,
+	CALL_MODEM_CAUSE_TYPE_CLIENT, CALL_MODEM_CAUSE_BUSY_USER_REQUEST
+};
+
+/* INFO Simulation messages */
+const unsigned char version_info_query_resp_ok[] =3D {
+	M_INFO_VERSION_READ_RESP,
+	M_INFO_OK,
+	1,
+	M_INFO_SB_MODEMSW_VERSION,
+	9,			/* subblock lenght */
+	0x00,
+	0x05,			/* lenght of string */
+	0x55, 0x38, 0x35, 0x30, 0x30	/*U8500 */
+};
+
+/* SMS Simulation messages */
+/*Receive*/
+const unsigned char sms_received_msg_ind[] =3D {
+	SMS_RECEIVED_MSG_IND, 0x00, 0x02,
+	SMS_SB_ADDRESS >> 8,	/*address subblock */
+	SMS_SB_ADDRESS & 0xFF,
+	0X10 >> 8,		/*subblock lenght */
+	0X10 & 0xFF,
+	SMS_SMSC_ADDRESS,	/*type */
+	8,			/* address lenght */
+	0x07,			/*Length of the SMSC information */
+	0x91,			/*Type of address of SMSC */
+	0x13, 0x26, 0x04, 0x00, 0x00, 0xF0,	/*SMSC number */
+	0x00, 0x00,		/*filler */
+	SMS_SB_TPDU >> 8,	/*message subblock */
+	SMS_SB_TPDU & 0xFF,
+	0X26 >> 8,		/*subblock lenght */
+	0X26 & 0xFF,
+	0x1E,			/*the lenght of the message(data)
+						SMS_TPDU_MAX_LEN =3D 232 */
+	0x00,			/*filler */
+	0x04,			/*First octet of this SMS-DELIVER message. */
+	0x0B,			/*Length of the sender address */
+	0x91,			/*Type of address of the sender number */
+	0x13, 0x46, 0x61, 0x00, 0x89, 0xF6,	/*Sender number */
+	0x00, 0x00,		/*Protocol identifier , Data encoding scheme */
+	0x20, 0x80, 0x62, 0x91, 0x73, 0x14, 0x08,	/*Time stamp */
+	0x0C,			/*Length of User data (SMS message) */
+	0xC8, 0xF7, 0x1D, 0x14, 0x96, 0x97, 0x41,
+	0xF9, 0x77, 0xFD, 0x07,	/*User data */
+	0x00, 0x00		/*fillers */
+};
+
+/*CBS message receive*/
+
+const unsigned char sms_received_cbs_msg_ind[] =3D {
+	SMS_CB_ROUTING_IND,
+	0x00,
+	0x02,
+	0x00,
+	0x2D,
+	0x00,
+	0x0C,
+	0x06,
+	0x01,
+	0x02,
+	0x06,
+	0x07,
+	0x08,
+	0x09,
+	0x00,
+	0x00, 0x0E,
+	0x00, 0x60,
+	0x10, 0x50, 0x00, 0x32, 0x01, 0x11, 0xFF, 0x57,
+	0xF9, 0x7B, 0xCC, 0x0E, 0xDF, 0x1B,
+	0x8D, 0x46,
+	0xA3, 0xD1, 0x68, 0x34, 0x1A, 0x8D, 0x46,
+	0xA3, 0xD1, 0x68, 0x34, 0x1A, 0x8D, 0x46,
+	0xA3, 0xD1, 0x68, 0x34, 0x1A, 0x8D, 0x46,
+	0xA3, 0xD1, 0x68, 0x34, 0x1A, 0x8D, 0x46,
+	0xA3, 0xD1, 0x68, 0x34, 0x1A, 0x8D, 0x46,
+	0xA3, 0xD1, 0x68, 0x34, 0x1A, 0x8D, 0x46,
+	0xA3, 0xD1, 0x68, 0x34, 0x1A, 0x8D, 0x46,
+	0xA3, 0xD1, 0x68, 0x34, 0x1A, 0x8D, 0x46,
+	0xA3, 0xD1, 0x68, 0x34, 0x1A, 0x8D, 0x46,
+	0xA3, 0xD1, 0x68, 0x34, 0x1A, 0x8D, 0x46,
+	0xA3, 0xD1, 0x00, 0x00, 0x00, 0x00
+};
+
+const unsigned char sms_received_incorrect_msg_ind[] =3D {
+	0
+};
+
+const unsigned char sms_received_msg_report_resp[] =3D {
+	SMS_RECEIVED_MSG_REPORT_RESP,
+	SMS_OK,
+	0x00
+};
+
+const unsigned char sms_received_msg_report_resp_fail[] =3D {
+	0x00,
+	0x00,
+	0x00
+};
+
+const unsigned char sms_receive_message_resp_inactive[] =3D {
+	SMS_RECEIVE_MESSAGE_RESP,
+	SMS_RECEPTION_INACTIVE,
+	0x01,
+	SMS_SB_CAUSE,
+	0x08,
+	SMS_CAUSE_TYPE_COMMON,	/*this could be SMS_CAUSE_TYPE_EXT
+				 *and thus needs to be checked
+				 */
+	SMS_ERR_CS_INACTIVE,
+	0x00, 0x00		/*fillers */
+};
+
+const unsigned char sms_receive_message_resp_active[] =3D {
+	SMS_RECEIVE_MESSAGE_RESP,
+	SMS_RECEPTION_ACTIVE,
+	0x01,
+	SMS_SB_CAUSE,
+	0x08,
+	SMS_CAUSE_TYPE_COMMON,
+	SMS_OK,
+	0x00, 0x00		/*fillers */
+};
+
+/*send*/
+const unsigned char sms_message_send_resp[] =3D {
+	SMS_MESSAGE_SEND_RESP,
+	SMS_CAUSE_TYPE_COMMON,
+	SMS_OK,
+	0x00,			/* this should be reference number for
+				 * identifying a sent short message
+				 */
+	0x00, 0x00,		/*fillers */
+	0x00			/* nro of sub blocks */
+};
+
+const unsigned char sms_message_send_resp_fail[] =3D {
+	SMS_MESSAGE_SEND_RESP,
+	SMS_CAUSE_TYPE_COMMON,
+	0x02,
+	0x00,			/* this should be reference number for
+				 * identifying a sent short message
+				 */
+	0x00, 0x00,		/*fillers */
+	0x00			/* nro of sub blocks */
+};
+
+/* SMS_SETTINGS Simulation messages */
+const unsigned char sms_settings_update_resp_ok[] =3D {
+	SMS_SETTINGS_UPDATE_RESP,
+	0x02,			/* Route */
+	0x00,			/* SMS_OK */
+};
+
+const unsigned char sms_settings_update_resp_false[] =3D {
+	SMS_SETTINGS_UPDATE_RESP,
+	0x02,			/* Route */
+	0x02,
+};
+
+const unsigned char sms_settings_read_resp_cs_only[] =3D {
+	SMS_SETTINGS_READ_RESP,
+	0x00,			/* SMS_OK */
+	0x01,			/* number of sub blocks */
+	0x00,
+	0x23,			/* sub block id */
+	0x00,
+	0x08,			/* len */
+	0x01,			/* cs prio */
+	0x00,			/* ps prio */
+	0x00,
+	0x00,
+};
+
+/*SMS SCA Simulation messages */
+const uint16_t sms_appl_cmd_linear_req[] =3D {
+	0x0C, 0x23, -1, -1, -1, -1, 0x03, 0x00,
+	0x1F, 0x00, 0x08, 0x00, 0x00, 0x00, -1, 0x00,
+	0x0D, 0x00, 0x10, 0x6F, 0x42, 0x00, 0x00, 0x04,
+	0x00, 0x3F, 0x00, 0x7F, -1, 0x00, 0x00, 0x00,
+	0x13, 0x00, 0x08, 0x01, 0x00, 0x00, 0x00
+};
+
+const unsigned char sms_sca_query_resp_ok[] =3D {
+	UICC_APPL_CMD_RESP,
+	UICC_APPL_READ_LINEAR_FIXED,
+	UICC_STATUS_OK,
+	UICC_NO_DETAILS,
+	0,			/*filler */
+	UICC_CARD_TYPE_UICC,
+	1,
+	UICC_SB_FILE_DATA >> 8,
+	UICC_SB_FILE_DATA & 0xFF,
+	0x34 >> 8,		/*sb length */
+	0x34 & 0xFF,
+	0,
+	0,
+	0,
+	0x2C,			/*data length */
+	0xFF, 0xFF, 0xFF, 0xFF,
+	0xFF, 0xFF, 0xFF, 0xFF,
+	0xFF, 0xFF, 0xFF, 0xFF,
+	0xFF, 0xFF, 0xFF, 0xFF,
+	0xE9,			/*parameter indicator */
+	0xFF,			/*TP-destination address */
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
+	/*TS-Service-centre-address */
+	0x07,			/*length of sca in bytes */
+	0x91,			/*type of sca */
+	0x53, 0x48, 0x50, 0x02, 0x02, 0x00,
+	0xFF, 0xFF, 0xFF, 0xFF,
+	0x00,			/*protocol identifier */
+	0xFF,			/*data coding scheme */
+	0xAD			/*TP validity period */
+};
+
+const unsigned char sms_sca_query_resp_fail[] =3D {
+	UICC_APPL_CMD_RESP,
+	UICC_APPL_READ_LINEAR_FIXED,
+	0x02,
+	UICC_NO_DETAILS
+};
+
+const uint16_t sms_appl_cmd_linear_update_req[] =3D {
+	0x0C, 0x24	/*, 0x01, 0x00, 0x00, 0x00, 0x04,
+			   0x00, 0x1F, 0x00, 0x08, 0x00, 0x00, 0x00, 0x01,
+			   0x00, 0x13, 0x00, 0x08, 0x01, 0x1D, 0x03, 0x00,
+			   0x00, 0x0D, 0x00, 0x10, 0x6F, 0x42, 0x00,
+			   0x00, 0x04, 0x00, 0x3F, 0x00, 0x7F, 0x10, 0x00,
+			   0x00, 0x00, 0x0F, 0x00, 0x10, 0x00, 0x00,
+			   0x00 */
+};
+
+const unsigned char sms_sca_set_resp_ok[] =3D {
+	UICC_APPL_CMD_RESP,
+	UICC_APPL_UPDATE_LINEAR_FIXED,
+	UICC_STATUS_OK,
+	UICC_NO_DETAILS,
+	0,
+	UICC_CARD_TYPE_UICC,
+	0
+};
+
+const unsigned char sms_sca_set_resp_fail[] =3D {
+	UICC_APPL_CMD_RESP,
+	UICC_APPL_UPDATE_LINEAR_FIXED,
+	0x02,
+	UICC_NO_DETAILS,
+	0,
+	UICC_CARD_TYPE_UICC,
+	0
+};
+
+/* ADVANCED VOICE CALL messages */
+
+/* Call forwarding */
+const uint16_t req_query_forw[] =3D {
+	SS_SERVICE_REQ,
+	SS_INTERROGATION,
+	SS_GSM_TELEPHONY,
+	SS_GSM_ALL_FORWARDINGS >> 8,
+	SS_GSM_ALL_FORWARDINGS & 0xFF,
+};
+
+const unsigned char call_forward_query_resp_forw[] =3D {
+	SS_SERVICE_COMPLETED_RESP,
+	SS_INTERROGATION,
+	SS_GSM_TELEPHONY,
+	SS_GSM_ALL_FORWARDINGS >> 8,
+	SS_GSM_ALL_FORWARDINGS & 0XFF,
+	0,			/* Filler */
+	1,			/* Number of sub blocks */
+	/* Sub block 1 */
+	SS_STATUS_RESULT,
+	4,
+	SS_GSM_PROVISIONED,
+	0
+};
+
+const uint16_t req_query_forw_A0[] =3D {
+	SS_SERVICE_REQ,
+	SS_INTERROGATION,
+	SS_GSM_TELEPHONY,
+	SS_GSM_FORW_UNCONDITIONAL >> 8,
+	SS_GSM_FORW_UNCONDITIONAL & 0xFF,
+};
+
+const unsigned char call_forward_query_resp_A0[] =3D {
+	SS_SERVICE_COMPLETED_RESP,
+	SS_INTERROGATION,
+	SS_GSM_TELEPHONY,
+	SS_GSM_FORW_UNCONDITIONAL >> 8,
+	SS_GSM_FORW_UNCONDITIONAL & 0XFF,
+	0,			/* Filler */
+	1,			/* Number of sub blocks */
+	0x04, 0x24, 0x00, 0x01,
+	0x05, 0x20, 0x0B, 0x07, 0x11, 0x00, 0x04, 0x0B,
+	0x00, 0x00, 0x00, 0x34, 0x00, 0x38, 0x00, 0x36,
+	0x00, 0x30, 0x00, 0x32, 0x00, 0x39, 0x00, 0x35,
+	0x00, 0x33, 0x00, 0x30, 0x00, 0x30, 0x00, 0x30
+};
+
+const uint16_t req_query_forw_B0[] =3D {
+	SS_SERVICE_REQ,
+	SS_INTERROGATION,
+	SS_GSM_TELEPHONY,
+	SS_GSM_FORW_BUSY >> 8, SS_GSM_FORW_BUSY & 0xFF,
+};
+
+const unsigned char call_forward_query_resp_B0[] =3D {
+	0x01, 0x05, 0x0B, 0x00, 0x43, 0x00, 0x02,
+	0x04, 0x10, 0x00, 0x01,	/* SS_GSM_FORWARDING_INFO */
+	0x05, 0x0C, 0x0B, 0x04, 0x00, 0x00, 0x04, 0x00,
+	0x00, 0x00, 0x00, 0x00,
+	0x2F, 0x0C, 0x08, 0x0E, 0xA3, 0x05, 0x30, 0x03,
+	0x84, 0x01, 0x04, 0x00
+};
+
+const uint16_t req_query_forw_C0[] =3D {
+	SS_SERVICE_REQ,
+	SS_INTERROGATION,
+	SS_GSM_TELEPHONY,
+	SS_GSM_FORW_NO_REPLY >> 8, SS_GSM_FORW_NO_REPLY & 0xFF,
+};
+
+const unsigned char call_forward_query_resp_C0[] =3D {
+	SS_SERVICE_COMPLETED_RESP,
+	SS_INTERROGATION,
+	SS_GSM_TELEPHONY,
+	SS_GSM_FORW_NO_REPLY >> 8,
+	SS_GSM_FORW_NO_REPLY & 0XFF,
+	0,			/* Filler */
+	1,			/* Number of sub blocks */
+	/* Sub block 1 */
+	SS_STATUS_RESULT,
+	4,
+	(SS_GSM_PROVISIONED | SS_GSM_ACTIVE | SS_GSM_REGISTERED),
+	0
+};
+
+const uint16_t req_query_forw_D0[] =3D {
+	SS_SERVICE_REQ,
+	SS_INTERROGATION,
+	SS_GSM_TELEPHONY,
+	SS_GSM_FORW_NO_REACH >> 8, SS_GSM_FORW_NO_REACH & 0xFF,
+};
+
+const unsigned char call_forward_query_resp_D0[] =3D {
+	SS_SERVICE_COMPLETED_RESP,
+	SS_INTERROGATION,
+	SS_GSM_TELEPHONY,
+	SS_GSM_FORW_NO_REACH >> 8, SS_GSM_FORW_NO_REACH & 0XFF,
+	0,			/* Filler */
+	1,			/* Number of sub blocks */
+	SS_GSM_FORWARDING_INFO,
+	0x10,			/* length */
+	0x00,			/* filler */
+	0x01,			/* # of SB */
+	SS_GSM_FORWARDING_FEATURE,
+	0x0C,
+	SS_GSM_TELEPHONY,
+	SS_GSM_PROVISIONED,
+	0x00, 0x00, 0x08,
+	0x00,			/*len */
+	0x00,			/*subaddres len */
+	0x00, 0x00, 0x00	/*fillers */
+};
+
+const uint16_t req_query_forw_erase[] =3D {
+	SS_SERVICE_REQ,
+	SS_ERASURE,
+	SS_GSM_TELEPHONY,
+	SS_GSM_FORW_NO_REPLY >> 8, SS_GSM_FORW_NO_REPLY & 0xFF,
+};
+
+const unsigned char call_forward_query_resp_erase[] =3D {
+	SS_SERVICE_COMPLETED_RESP,
+	SS_ERASURE,
+	SS_GSM_TELEPHONY,
+	SS_GSM_FORW_NO_REPLY >> 8,
+	SS_GSM_FORW_NO_REPLY & 0XFF,
+	0,			/* Filler */
+	1,			/* Number of sub blocks */
+	/* Sub block 1 */
+	0x04, 0x10, 0x00, 0x01,
+	0x05, 0x0C, 0x0B, 0x04, 0x00, 0x00, 0x08, 0x00,
+	0x00, 0x00, 0x00, 0x00
+};
+
+const uint16_t req_query_forw_erase_A0[] =3D {
+	SS_SERVICE_REQ,
+	SS_ERASURE,
+	SS_GSM_TELEPHONY,
+	SS_GSM_ALL_COND_FORWARDINGS >> 8,
+	SS_GSM_ALL_COND_FORWARDINGS & 0xFF,
+};
+
+const unsigned char call_forward_query_resp_erase_A0[] =3D {
+	SS_SERVICE_COMPLETED_RESP,
+	SS_ERASURE,
+	SS_GSM_TELEPHONY,
+	SS_GSM_ALL_COND_FORWARDINGS >> 8,
+	SS_GSM_ALL_COND_FORWARDINGS & 0XFF,
+	0,			/* Filler */
+	1,			/* Number of sub blocks */
+	/* Sub block 1 */
+	SS_STATUS_RESULT,
+	4,
+	SS_GSM_PROVISIONED,
+	0
+};
+
+const uint16_t req_query_forw_erase_B0[] =3D {
+	SS_SERVICE_REQ,
+	SS_ERASURE,
+	SS_GSM_TELEPHONY,
+	SS_GSM_ALL_FORWARDINGS >> 8,
+	SS_GSM_ALL_FORWARDINGS & 0xFF,
+};
+
+const unsigned char call_forward_query_resp_erase_B0[] =3D {
+	SS_SERVICE_COMPLETED_RESP,
+	SS_ERASURE,
+	SS_GSM_TELEPHONY,
+	SS_GSM_ALL_FORWARDINGS >> 8, SS_GSM_ALL_FORWARDINGS & 0XFF,
+	0,			/* Filler */
+	1,			/* Number of sub blocks */
+	/* Sub block 1 */
+	SS_STATUS_RESULT,
+	4,
+	SS_GSM_PROVISIONED,
+	0
+};
+
+const uint16_t forw_no_reply_set_req[] =3D {
+	SS_SERVICE_REQ,
+	SS_REGISTRATION,
+	SS_GSM_TELEPHONY,
+	SS_GSM_FORW_NO_REPLY >> 8,
+	SS_GSM_FORW_NO_REPLY & 0xFF,
+};
+
+const unsigned char forw_no_reply_set_resp[] =3D {
+	SS_SERVICE_COMPLETED_RESP,
+	SS_REGISTRATION,
+	SS_GSM_TELEPHONY,
+	SS_GSM_FORW_NO_REPLY >> 8, SS_GSM_FORW_NO_REPLY & 0XFF,
+	0,			/* Filler */
+	1,			/* Number of sub blocks */
+	/* Sub block 1 */
+	0x04, 0x1C, 0x00, 0x01,
+	0x05, 0x18, 0x0B, 0x07, 0x11, 0x14, 0x08, 0x06, 0x00, 0x00,
+	0x00, 0x31, 0x00, 0x33, 0x00, 0x34, 0x00, 0x34, 0x00, 0x34,
+	0x00, 0x34, 0x00, 0x00
+};
+
+const uint16_t forw_uncond_set_req[] =3D {
+	SS_SERVICE_REQ,
+	SS_REGISTRATION,
+	SS_GSM_TELEPHONY,
+	SS_GSM_FORW_UNCONDITIONAL >> 8,
+	SS_GSM_FORW_UNCONDITIONAL & 0xFF,
+};
+
+const unsigned char forw_uncond_set_resp[] =3D {
+	SS_SERVICE_COMPLETED_RESP,
+	SS_REGISTRATION,
+	SS_GSM_TELEPHONY,
+	SS_GSM_FORW_UNCONDITIONAL >> 8,
+	SS_GSM_FORW_UNCONDITIONAL & 0XFF,
+	0,			/* Filler */
+	1,			/* Number of sub blocks */
+	/* Sub block 1 */
+	0x04, 0x1C, 0x00, 0x01,
+	0x05, 0x18, 0x0B, 0x07, 0x11, 0x00, 0x0C, 0x06, 0x00, 0x00,
+	0x00, 0x31, 0x00, 0x33, 0x00, 0x34, 0x00, 0x34, 0x00, 0x34,
+	0x00, 0x34, 0x00, 0x00
+};
+
+/* CALL BARRING Simulation messages */
+#define BARRING_TYPE    SS_GSM_BARR_ALL_IN
+#define VOICE_OUT_STATUS        SS_GSM_TELEPHONY
+#define VOICE_IN_STATUS SS_GSM_SMS
+#define BARR_ENABLED    SS_GSM_TELEPHONY
+#define BARR_DISABLED   SS_GSM_SMS
+
+const uint16_t req_query_AO[] =3D {
+	SS_SERVICE_REQ,
+	SS_INTERROGATION,
+	SS_ALL_TELE_AND_BEARER,
+	SS_GSM_BARR_ALL_OUT >> 8, SS_GSM_BARR_ALL_OUT & 0xFF,
+};
+
+const unsigned char call_barring_query_resp_AO[] =3D {
+	SS_SERVICE_COMPLETED_RESP,
+	SS_INTERROGATION,
+	SS_GSM_TELEPHONY,
+	SS_GSM_BARR_ALL_OUT >> 8,
+	SS_GSM_BARR_ALL_OUT & 0XFF,
+	0,			/* Filler */
+	2,			/* Number of sub blocks */
+	/* Sub block 1 */
+	SS_STATUS_RESULT,
+	4,
+	SS_GSM_PROVISIONED,
+	0,
+	/* Sub block 2 */
+	SS_GSM_BARRING_INFO,
+	12,
+	0x55,
+	2,
+	/* sub sub block 1 */
+	SS_GSM_BARRING_FEATURE,
+	4,
+	SS_GSM_TELEPHONY,
+	SS_GSM_PROVISIONED,
+	/* sub sub block 2 */
+	SS_GSM_BARRING_FEATURE,
+	4,
+	SS_GSM_ALL_DATA_CIRCUIT_SYNC,
+	SS_GSM_PROVISIONED,
+};
+
+const uint16_t req_query_OI[] =3D {
+	SS_SERVICE_REQ,
+	SS_INTERROGATION,
+	SS_ALL_TELE_AND_BEARER,
+	SS_GSM_BARR_OUT_INTER >> 8, SS_GSM_BARR_OUT_INTER & 0xFF,
+};
+
+const unsigned char call_barring_query_resp_OI[] =3D {
+	SS_SERVICE_COMPLETED_RESP,
+	SS_INTERROGATION,
+	SS_GSM_TELEPHONY,
+	SS_GSM_BARR_OUT_INTER >> 8,
+	SS_GSM_BARR_OUT_INTER & 0XFF,
+	0,			/*Filler */
+	2,			/* Number of sub blocks */
+	/* Sub block 1 */
+	SS_STATUS_RESULT,
+	4,
+	SS_GSM_ACTIVE,
+	0,
+	/* Sub block 2 */
+	SS_GSM_BARRING_INFO,
+	12,
+	0x55,
+	2,
+	/* sub sub block 1 */
+	SS_GSM_BARRING_FEATURE,
+	4,
+	SS_GSM_TELEPHONY,
+	SS_GSM_ACTIVE,
+	/* sub sub block 2 */
+	SS_GSM_BARRING_FEATURE,
+	4,
+	SS_GSM_ALL_DATA_CIRCUIT_SYNC,
+	0,			/*SS_GSM_ACTIVE, */
+};
+
+const uint16_t req_query_OX[] =3D {
+	SS_SERVICE_REQ,
+	SS_INTERROGATION,
+	SS_ALL_TELE_AND_BEARER,
+	SS_GSM_BARR_OUT_INTER_EXC_HOME >> 8,
+	SS_GSM_BARR_OUT_INTER_EXC_HOME & 0xFF,
+};
+
+const unsigned char call_barring_query_resp_OX[] =3D {
+	SS_SERVICE_COMPLETED_RESP,
+	SS_INTERROGATION,
+	SS_GSM_TELEPHONY,
+	SS_GSM_BARR_OUT_INTER_EXC_HOME >> 8,
+	SS_GSM_BARR_OUT_INTER_EXC_HOME & 0XFF,
+	0,			/* Filler */
+	1,			/* Number of sub blocks */
+	/* Sub block 1 */
+	SS_STATUS_RESULT,
+	4,
+	SS_GSM_PROVISIONED,
+	0
+};
+
+const uint16_t req_query_AI[] =3D {
+	SS_SERVICE_REQ,
+	SS_INTERROGATION,
+	SS_ALL_TELE_AND_BEARER,
+	SS_GSM_BARR_ALL_IN >> 8,
+	SS_GSM_BARR_ALL_IN & 0xFF,
+};
+
+const unsigned char call_barring_query_resp_AI[] =3D {
+	SS_SERVICE_COMPLETED_RESP,
+	SS_INTERROGATION,
+	SS_GSM_TELEPHONY,
+	SS_GSM_BARR_ALL_IN >> 8,
+	SS_GSM_BARR_ALL_IN & 0XFF,
+	0,			/* Filler */
+	1,			/* Number of sub blocks */
+	/* Sub block 1 */
+	SS_STATUS_RESULT,
+	4,
+	SS_GSM_PROVISIONED,
+	0
+};
+
+const uint16_t req_query_IR[] =3D {
+	SS_SERVICE_REQ,
+	SS_INTERROGATION,
+	SS_ALL_TELE_AND_BEARER,
+	SS_GSM_BARR_ALL_IN_ROAM >> 8,
+	SS_GSM_BARR_ALL_IN_ROAM & 0xFF,
+};
+
+const unsigned char call_barring_query_resp_IR[] =3D {
+	SS_SERVICE_COMPLETED_RESP,
+	SS_INTERROGATION,
+	SS_GSM_TELEPHONY,
+	SS_GSM_BARR_ALL_IN_ROAM >> 8,
+	SS_GSM_BARR_ALL_IN_ROAM & 0XFF,
+	0,			/* Filler */
+	3,			/* Number of sub blocks */
+	/* Sub block 1 */
+	SS_STATUS_RESULT,
+	4,
+	SS_GSM_PROVISIONED,
+	0,
+	/* Sub block 2 */
+	SS_GSM_BSC_INFO,
+	16,
+	9,
+	SS_GSM_TELEPHONY,
+	SS_GSM_ALL_DATA_TELE,
+	SS_GSM_FACSIMILE, SS_GSM_SMS,
+	SS_GSM_ALL_DATA_CIRCUIT_SYNC,
+	SS_GSM_ALL_DATA_CIRCUIT_ASYNC,
+	SS_GSM_ALL_DATA_PACKET_SYNC,
+	SS_GSM_ALL_PAD_ACCESS,
+	0xff,
+	0,
+	0,
+	0,
+	0,
+	/* Sub block 3 */
+	0x2F, 0x10, 0x0C, 0x0E, 0xA2, 0x09, 0x83, 0x01,
+	0x10, 0x83, 0x01, 0x20, 0x82, 0x01, 0x10, 0x00
+};
+
+const uint16_t req_disable_all_in[] =3D {
+	SS_SERVICE_REQ,
+	SS_DEACTIVATION,
+	SS_ALL_TELE_AND_BEARER,
+	SS_GSM_INCOMING_BARR_SERV >> 8,
+	SS_GSM_INCOMING_BARR_SERV & 0xFF,
+};
+
+const unsigned char call_barring_disable_all_in_msg[] =3D {
+	SS_SERVICE_COMPLETED_RESP,
+	SS_DEACTIVATION,
+	SS_ALL_TELE_AND_BEARER,
+	SS_GSM_INCOMING_BARR_SERV >> 8,
+	SS_GSM_INCOMING_BARR_SERV & 0XFF,
+	0,			/* Filler */
+	1,			/* Number of sub blocks */
+	/* Sub block 1 */
+	SS_STATUS_RESULT,
+	4,
+	SS_GSM_PROVISIONED,
+	0
+};
+
+const uint16_t req_disable_all_out[] =3D {
+	SS_SERVICE_REQ,
+	SS_DEACTIVATION,
+	SS_ALL_TELE_AND_BEARER,
+	SS_GSM_OUTGOING_BARR_SERV >> 8,
+	SS_GSM_OUTGOING_BARR_SERV & 0xFF,
+};
+
+const unsigned char call_barring_disable_all_out_msg[] =3D {
+	SS_SERVICE_COMPLETED_RESP,
+	SS_DEACTIVATION,
+	SS_ALL_TELE_AND_BEARER,
+	SS_GSM_OUTGOING_BARR_SERV >> 8,
+	SS_GSM_OUTGOING_BARR_SERV & 0XFF,
+	0,			/* Filler */
+	1,			/* Number of sub blocks */
+	/* Sub block 1 */
+	SS_STATUS_RESULT,
+	4,
+	SS_GSM_PROVISIONED,
+	0
+};
+
+const uint16_t req_enable_all_in[] =3D {
+	SS_SERVICE_REQ,
+	SS_ACTIVATION,
+	SS_ALL_TELE_AND_BEARER,
+	SS_GSM_BARR_ALL_IN >> 8, SS_GSM_BARR_ALL_IN & 0xFF
+};
+
+const unsigned char call_barring_enable_all_in_msg[] =3D {
+	SS_SERVICE_COMPLETED_RESP,
+	SS_ACTIVATION,
+	SS_GSM_TELEPHONY,
+	SS_GSM_BARR_ALL_IN >> 8,
+	SS_GSM_BARR_ALL_IN & 0XFF,
+	0,			/* Filler */
+	1,			/* Number of sub blocks */
+	/* Sub block 1 */
+	SS_STATUS_RESULT,
+	4,
+	(SS_GSM_PROVISIONED | SS_GSM_ACTIVE),
+	0
+};
+
+const uint16_t req_enable_all_out[] =3D {
+	SS_SERVICE_REQ,
+	SS_ACTIVATION,
+	SS_ALL_TELE_AND_BEARER,
+	SS_GSM_BARR_ALL_OUT >> 8, SS_GSM_BARR_ALL_OUT & 0xFF
+};
+
+const unsigned char call_barring_enable_all_out_msg[] =3D {
+	SS_SERVICE_COMPLETED_RESP,
+	SS_ACTIVATION,
+	SS_GSM_TELEPHONY,
+	SS_GSM_BARR_ALL_OUT >> 8, SS_GSM_BARR_ALL_OUT & 0XFF,
+	0,			/* Filler */
+	1,			/* Number of sub blocks */
+	/* Sub block 1 */
+	SS_STATUS_RESULT,
+	4,
+	(SS_GSM_PROVISIONED | SS_GSM_ACTIVE),
+	0
+};
+
+const uint16_t req_change_cb_password[] =3D {
+	SS_SERVICE_REQ,
+	SS_GSM_PASSWORD_REGISTRATION
+};
+
+const unsigned char req_change_cb_password_msg[] =3D {
+	SS_SERVICE_COMPLETED_RESP,
+	SS_GSM_PASSWORD_REGISTRATION,
+	SS_ALL_TELE_AND_BEARER
+};
+
+/* CALL WAITING Simulation messages */
+const uint16_t req_query_cw[] =3D {
+	SS_SERVICE_REQ,
+	SS_INTERROGATION,
+	SS_ALL_TELE_AND_BEARER,
+	SS_GSM_CALL_WAITING >> 8, SS_GSM_CALL_WAITING & 0xFF,
+};
+
+const unsigned char call_waiting_query_resp[] =3D {
+	SS_SERVICE_COMPLETED_RESP,
+	SS_INTERROGATION,
+	SS_ALL_TELE_AND_BEARER,
+	SS_GSM_CALL_WAITING >> 8,
+	SS_GSM_CALL_WAITING & 0xFF,
+	0,			/* Filler */
+	3,			/* Number of sub blocks */
+	/* Sub block 1 */
+	SS_STATUS_RESULT,
+	4,
+	SS_GSM_PROVISIONED,
+	0,
+	/* Sub block 2 */
+	SS_GSM_BSC_INFO,
+	16,
+	9,
+	SS_GSM_TELEPHONY,
+	SS_GSM_ALL_DATA_TELE,
+	SS_GSM_FACSIMILE,
+	SS_GSM_SMS,
+	SS_GSM_ALL_DATA_CIRCUIT_SYNC,
+	SS_GSM_ALL_DATA_CIRCUIT_ASYNC,
+	SS_GSM_ALL_DATA_PACKET_SYNC,
+	SS_GSM_ALL_PAD_ACCESS,
+	0xff,
+	0,
+	0,
+	0,
+	0,
+	/* Sub block 3 */
+	SS_GSM_DATA,
+	8,
+	SS_GSM_ACTIVE,
+	SS_GSM_CLI_PERMANENT,
+	0, 0, 0,		/*Filler */
+	0,			/* Number of sub-sub-blocks */
+};
+
+const uint16_t req_query_cw_A0[] =3D {
+	SS_SERVICE_REQ,
+	SS_DEACTIVATION,
+	SS_ALL_TELE_AND_BEARER,
+	SS_GSM_CALL_WAITING >> 8, SS_GSM_CALL_WAITING & 0xFF
+};
+
+const unsigned char call_waiting_query_resp_A0[] =3D {
+	SS_SERVICE_COMPLETED_RESP,
+	SS_DEACTIVATION,
+	SS_ALL_TELE_AND_BEARER,
+	SS_GSM_CALL_WAITING >> 8,
+	SS_GSM_CALL_WAITING & 0xFF,
+	0,			/*Filler */
+	2,			/* Number of sub blocks */
+	/* Sub block 1 */
+	SS_STATUS_RESULT,
+	4,
+	SS_GSM_PROVISIONED,
+	0,
+	/* Sub block 2 */
+	SS_GSM_DATA,
+	8,
+	SS_GSM_PROVISIONED,
+	SS_GSM_CLI_PERMANENT,
+	0, 0, 0,		/* Filler */
+	0,			/* Number of sub-sub-blocks */
+};
+
+const uint16_t req_query_cw_B0[] =3D {
+	SS_SERVICE_REQ,
+	SS_ACTIVATION,
+	SS_ALL_TELE_AND_BEARER,
+	SS_GSM_CALL_WAITING >> 8,
+	SS_GSM_CALL_WAITING & 0xFF
+};
+
+const unsigned char call_waiting_query_resp_B0[] =3D {
+	SS_SERVICE_COMPLETED_RESP,
+	SS_ACTIVATION,
+	SS_ALL_TELE_AND_BEARER,
+	SS_GSM_CALL_WAITING >> 8,
+	SS_GSM_CALL_WAITING & 0xFF,
+	0,			/* Filler */
+	2,			/* Number of sub blocks */
+	/* Sub block 1 */
+	SS_STATUS_RESULT,
+	4,
+	SS_GSM_PROVISIONED,
+	0,
+	/* Sub block 2 */
+	SS_GSM_DATA,
+	8,
+	SS_GSM_ACTIVE,
+	SS_GSM_CLI_PERMANENT,
+	0, 0, 0,		/*Filler */
+	0,			/* Number of sub-sub-blocks */
+};
+
+/* CLIP Simulation messages */
+const uint16_t req_query_clip[] =3D {
+	SS_SERVICE_REQ,
+	SS_INTERROGATION,
+	SS_ALL_TELE_AND_BEARER,
+	SS_GSM_CLIP >> 8, SS_GSM_CLIP & 0xFF
+};
+
+const unsigned char clip_query_resp[] =3D {
+	SS_SERVICE_COMPLETED_RESP,
+	SS_INTERROGATION,
+	SS_ALL_TELE_AND_BEARER,
+	SS_GSM_CLIP >> 8,
+	SS_GSM_CLIP & 0xFF,
+	0,			/* Filler */
+	2,			/* Number of sub blocks */
+	/* Sub block 1 */
+	SS_STATUS_RESULT,
+	4,
+	SS_GSM_PROVISIONED,
+	0,
+	/* Sub block 2 */
+	SS_GSM_BSC_INFO,
+	16,
+	9,
+	SS_GSM_TELEPHONY,
+	SS_GSM_ALL_DATA_TELE,
+	SS_GSM_FACSIMILE,
+	SS_GSM_SMS,
+	SS_GSM_ALL_DATA_CIRCUIT_SYNC,
+	SS_GSM_ALL_DATA_CIRCUIT_ASYNC,
+	SS_GSM_ALL_DATA_PACKET_SYNC,
+	SS_GSM_ALL_PAD_ACCESS,
+	0xff,
+	0,
+	0,
+	0,
+	0,
+};
+
+/* CLIR Simulation messages */
+const uint16_t req_query_clir[] =3D {
+	SS_SERVICE_REQ,
+	SS_INTERROGATION,
+	SS_ALL_TELE_AND_BEARER,
+	SS_GSM_CLIR >> 8,
+	SS_GSM_CLIR & 0xFF
+};
+
+const unsigned char clir_query_resp[] =3D {
+	SS_SERVICE_COMPLETED_RESP,
+	SS_INTERROGATION,
+	SS_ALL_TELE_AND_BEARER,
+	SS_GSM_CLIR >> 8,
+	SS_GSM_CLIR & 0xFF,
+	0,			/*Filler */
+	3,			/* Number of sub blocks */
+	/* Sub block 1 */
+	SS_GSM_GENERIC_SERVICE_INFO,
+	8,
+	SS_GSM_PROVISIONED,
+	1,
+	/* Sub-sub block */
+	SS_GSM_CLIR_INFO,
+	4,
+	SS_GSM_CLI_PERMANENT,
+	0,			/*Filler */
+	/* Sub block 2 */
+	SS_GSM_BSC_INFO,
+	16,
+	9,
+	SS_GSM_TELEPHONY,
+	SS_GSM_ALL_DATA_TELE,
+	SS_GSM_FACSIMILE,
+	SS_GSM_SMS,
+	SS_GSM_ALL_DATA_CIRCUIT_SYNC,
+	SS_GSM_ALL_DATA_CIRCUIT_ASYNC,
+	SS_GSM_ALL_DATA_PACKET_SYNC,
+	SS_GSM_ALL_PAD_ACCESS,
+	0xff,
+	0,
+	0,
+	0,
+	0,
+	/* Sub block 3 */
+	SS_STATUS_RESULT,
+	4,
+	SS_GSM_PROVISIONED,
+	0,
+};
+
+/* COLP Simulation messages */
+const uint16_t req_query_colp[] =3D {
+	SS_SERVICE_REQ,
+	SS_INTERROGATION,
+	SS_ALL_TELE_AND_BEARER,
+	SS_GSM_COLP >> 8, SS_GSM_COLP & 0xFF
+};
+
+const unsigned char colp_query_resp[] =3D {
+	SS_SERVICE_COMPLETED_RESP,
+	SS_INTERROGATION,
+	SS_ALL_TELE_AND_BEARER,
+	SS_GSM_COLP >> 8, SS_GSM_COLP & 0xFF,
+	0,			/*Filler */
+	2,			/* Number of sub blocks */
+	/* Sub block 1 */
+	SS_STATUS_RESULT,
+	4,
+	SS_GSM_PROVISIONED,
+	0,
+	/* Sub block 2 */
+	SS_GSM_BSC_INFO,
+	16,
+	9,
+	SS_GSM_TELEPHONY,
+	SS_GSM_ALL_DATA_TELE,
+	SS_GSM_FACSIMILE,
+	SS_GSM_SMS,
+	SS_GSM_ALL_DATA_CIRCUIT_SYNC,
+	SS_GSM_ALL_DATA_CIRCUIT_ASYNC,
+	SS_GSM_ALL_DATA_PACKET_SYNC,
+	SS_GSM_ALL_PAD_ACCESS,
+	0xff,
+	0,
+	0,
+	0,
+	0,
+};
+
+/* COLR Simulation messages */
+const uint16_t req_query_colr[] =3D {
+	SS_SERVICE_REQ,
+	SS_INTERROGATION,
+	SS_ALL_TELE_AND_BEARER,
+	SS_GSM_COLR >> 8,
+	SS_GSM_COLR & 0xFF
+};
+
+const unsigned char colr_query_resp[] =3D {
+	SS_SERVICE_COMPLETED_RESP,
+	SS_INTERROGATION,
+	SS_ALL_TELE_AND_BEARER,
+	SS_GSM_COLR >> 8, SS_GSM_COLR & 0xFF,
+	0,			/*Filler */
+	2,			/* Number of sub blocks */
+	/* Sub block 1 */
+	SS_STATUS_RESULT,
+	4,
+	SS_GSM_PROVISIONED,
+	0,
+	/* Sub block 2 */
+	SS_GSM_BSC_INFO,
+	16,
+	9,
+	SS_GSM_TELEPHONY,
+	SS_GSM_ALL_DATA_TELE,
+	SS_GSM_FACSIMILE,
+	SS_GSM_SMS,
+	SS_GSM_ALL_DATA_CIRCUIT_SYNC,
+	SS_GSM_ALL_DATA_CIRCUIT_ASYNC,
+	SS_GSM_ALL_DATA_PACKET_SYNC,
+	SS_GSM_ALL_PAD_ACCESS,
+	0xff,
+	0,
+	0,
+	0,
+	0,
+};
+
+
+/* USSD Simulation messages */
+const uint16_t req_ussd_init[] =3D {
+	SS_GSM_USSD_SEND_REQ,
+	SS_GSM_USSD_COMMAND,
+};
+
+const unsigned char req_ussd_init_resp[] =3D {
+	0x05, 0x0F, 0x05, 0x79, 0xCC, 0x74, 0x9A, 0x4E,
+	0xCF, 0xB7, 0xF7, 0xF3, 0x34, 0x68, 0x1E, 0x66,
+	0x93, 0xDF, 0xA0, 0xB7, 0x1B, 0x64, 0x73, 0xC1,
+	0x60, 0xA0, 0x62, 0x55, 0xCA, 0x02, 0xC1, 0xC3,
+	0x6C, 0x7B, 0x99, 0x5D, 0x9F, 0x87, 0xD9, 0xE4,
+	0x37, 0x08, 0x05, 0xAF, 0xA3, 0xCB, 0xEC, 0x3A,
+	0xFD, 0x45, 0x4F, 0x97, 0xC9, 0x6F, 0xF7, 0x3C,
+	0x9D, 0x96, 0xD3, 0xDF, 0xA0, 0x22, 0x3B, 0x3D,
+	0x0F, 0x83, 0xDA, 0x6F, 0x71, 0x3A, 0xCD, 0x4E,
+	0xDB, 0xCB, 0xF2, 0xF5, 0x7B, 0x3E, 0x0F, 0xA7,
+	0x40, 0x6F, 0x37, 0x08, 0xE6, 0x82, 0xC1, 0x40,
+	0xC5, 0xAA, 0x14, 0xA4, 0x0E, 0x83, 0xEC, 0xEF,
+	0x74, 0x3B, 0x3C, 0x9F, 0x87, 0xDF, 0xEC, 0x77,
+	0x38, 0xBD, 0x0E, 0x83, 0xE0, 0xFB, 0x3D, 0x9D,
+	0x9E, 0xCF, 0x83, 0x66, 0x30, 0x57, 0x0C, 0xE6,
+	0x92, 0xC1, 0x62, 0x30, 0x17, 0x00, 0x00
+};
+
+const unsigned char req_ussd_init_ind[] =3D {
+	/*test */
+	0x06, 0xfF, 0x02, 0x00
+};
+
+const uint16_t req_ussd_cancel[] =3D {
+	SS_GSM_USSD_SEND_REQ,
+	SS_GSM_USSD_END,
+	0x00			/* subblock count */
+};
+
+const unsigned char req_ussd_cancel_resp[] =3D {
+	SS_GSM_USSD_SEND_RESP,
+	0x0f,			/*Coding */
+	SS_GSM_USSD_END,
+	0,			/*Length of USSD string */
+};
+
+/* CBS Simulation messages */
+const unsigned char req_cbs_routing_resp[] =3D {
+	SMS_CB_ROUTING_RESP,
+	SMS_OK,			/*Sms cause */
+	0,
+};
+
+struct isimodem25_response fakeresps[] =3D {
+	/*
+	 * How to add new simulation msgs:
+	 * 1) Phonet resource
+	 * 2) Request for which you want a response OR
+			 Indication you want to subscribe for
+	 * 3) Response or indication message
+	 * 4) Size of the response message
+	 * 5) Next message
+	 * 6) Long request (in case a more detailed match is required)
+	 * 7) Size of long request
+	 */
+	/*Changeable responses. Do not change the order */
+	{
+	 PN_UICC, UICC_APPLICATION_REQ,
+	 uicc_app_list_resp,
+	 sizeof(uicc_app_list_resp),
+	 NULL,
+	 uicc_app_list_req,
+	 sizeof(uicc_app_list_req) / 2}
+	,
+
+	/*Not changeable responses */
+	{
+	 PN_UICC, UICC_APPLICATION_REQ,
+	 uicc_app_activate_ok_resp,
+	 sizeof(uicc_app_activate_ok_resp),
+	 NULL,
+	 uicc_app_activate_req,
+	 sizeof(uicc_app_activate_req) / 2}
+	,
+	/*PN_MODEM_MCE messages */
+	{
+	 PN_MODEM_MCE, MCE_MODEM_STATE_IND,
+	 modem_state_normal_ind,
+	 sizeof(modem_state_normal_ind),
+	 NULL,
+	 NULL,
+	 0}
+	,
+	{
+	 PN_MODEM_MCE, MCE_RF_STATE_REQ,
+	 rf_on_resp_ok,
+	 sizeof(rf_on_resp_ok),
+	 NULL,
+	 NULL,
+	 0}
+	,
+	{
+	 PN_MODEM_MCE, MCE_RF_STATE_QUERY_REQ,
+	 rf_state_query_resp,
+	 sizeof(rf_state_query_resp),
+	 NULL,
+	 NULL,
+	 0}
+	,
+	{
+	 PN_MODEM_MCE, MCE_MODEM_STATE_QUERY_REQ,
+	 modem_state_query_resp_ok,
+	 sizeof(modem_state_query_resp_ok),
+	 NULL,
+	 NULL,
+	 0}
+	,
+
+	/* Network registration messages */
+	{
+	 PN_MODEM_NETWORK, NET_SET_REQ,
+	 set_auto_resp_cb_msg,
+	 sizeof(set_auto_resp_cb_msg),
+	 NULL, reg_auto,
+	 sizeof(reg_auto) / 2}
+	,
+	{
+	 PN_MODEM_NETWORK, NET_SET_REQ,
+	 set_manual_resp_cb_msg,
+	 sizeof(set_manual_resp_cb_msg),
+	 NULL,
+	 reg_manual,
+	 sizeof(reg_manual) / 2}
+	,
+	{
+	 PN_MODEM_NETWORK, NET_MODEM_REG_STATUS_GET_REQ,
+	 reg_status_resp_cb_auto_msg,
+	 sizeof(reg_status_resp_cb_auto_msg),
+	 NULL,
+	 NULL,
+	 0}
+	,
+	{
+	 PN_MODEM_NETWORK, NET_RSSI_GET_REQ,
+	 rssi_resp_cb_msg,
+	 sizeof(rssi_resp_cb_msg),
+	 NULL}
+	,
+	{
+	 PN_MODEM_NETWORK, NET_MODEM_AVAILABLE_GET_REQ,
+	 available_resp_cb_msg,
+	 sizeof(available_resp_cb_msg),
+	 NULL}
+	,
+	{
+	 PN_MODEM_NETWORK, NET_RSSI_IND,
+	 rssi_ind_cb_msg,
+	 sizeof(rssi_ind_cb_msg),
+	 NULL}
+	,
+	{
+	 PN_MODEM_NETWORK, NET_MODEM_REG_STATUS_IND,
+	 reg_status_ind_cb_msg,
+	 sizeof(reg_status_ind_cb_msg),
+	 NULL}
+	,
+	{
+	 PN_MODEM_NETWORK, NET_RAT_IND,
+	 rat_ind_cb_msg,
+	 sizeof(rat_ind_cb_msg),
+	 NULL}
+	,
+	{
+	 PN_MODEM_NETWORK, NET_RAT_REQ,
+	 rat_resp,
+	 sizeof(rat_resp),
+	 NULL}
+	,
+	{
+	 PN_MODEM_NETWORK, NET_CELL_INFO_GET_REQ,
+	 cell_info_resp_cb_msg,
+	 sizeof(cell_info_resp_cb_msg),
+	 NULL}
+	,
+	{
+	 PN_MODEM_NETWORK, NET_NITZ_NAME_IND,
+	 nitz_name_ind_msg,
+	 sizeof(nitz_name_ind_msg),
+	 NULL}
+	,
+	{
+	 PN_MODEM_NETWORK, NET_CS_STATE_IND,
+	 net_cs_state_ind_msg,
+	 sizeof(net_cs_state_ind_msg),
+	 NULL}
+	,
+	{
+	 PN_MODEM_NETWORK, NET_CS_STATE_REQ,
+	 net_cs_state_resp,
+	 sizeof(net_cs_state_resp),
+	 NULL}
+	,
+	{
+	 PN_MODEM_NETWORK, NET_CS_CONTROL_REQ,
+	 net_cs_control_resp,
+	 sizeof(net_cs_control_resp),
+	 NULL}
+	,
+
+	/* GSS messages */
+	{
+	 PN_GSS, GSS_CS_SERVICE_REQ,
+	 rat_query_resp_msg,
+	 sizeof(rat_query_resp_msg),
+	 NULL, rat_query_req,
+	 sizeof(rat_query_req) / 2}
+	,
+	{
+	 PN_GSS, GSS_CS_SERVICE_REQ,
+	 rat_set_any_resp_msg,
+	 sizeof(rat_set_any_resp_msg),
+	 NULL, rat_set_any_req,
+	 sizeof(rat_set_any_req) / 2}
+	,
+	{
+	 PN_GSS, GSS_CS_SERVICE_REQ,
+	 rat_set_umts_resp_msg,
+	 sizeof(rat_set_umts_resp_msg),
+	 NULL, rat_set_umts_req,
+	 sizeof(rat_set_umts_req) / 2}
+	,
+	{
+	 PN_GSS, GSS_CS_SERVICE_REQ,
+	 rat_set_gsm_resp_msg,
+	 sizeof(rat_set_gsm_resp_msg),
+	 NULL, rat_set_gsm_req,
+	 sizeof(rat_set_gsm_req) / 2}
+	,
+
+	/* GPDS/GPRS messages */
+	{
+	 PN_GPDS, GPDS_ATTACH_REQ,
+	 gpds_attach_resp_msg,
+	 sizeof(gpds_attach_resp_msg),
+	 NULL}
+	,
+	{
+	 PN_GPDS, GPDS_STATUS_REQ,
+	 gpds_status_resp_attached_msg,
+	 sizeof(gpds_status_resp_attached_msg),
+	 NULL}
+	,
+	{
+	 PN_GPDS, GPDS_DETACH_REQ,
+	 gpds_detach_resp_msg,
+	 sizeof(gpds_detach_resp_msg),
+	 gpds_detach_ind_msg1}
+	,
+	{
+	 PN_GPDS, GPDS_CONFIGURE_REQ,
+	 gpds_configure_resp_msg,
+	 sizeof(gpds_configure_resp_msg),
+	 NULL}
+	,
+	{
+	 PN_GPDS, GPDS_CONTEXT_ID_CREATE_REQ,
+	 gpds_context_id_create_resp_msg1,
+	 sizeof(gpds_context_id_create_resp_msg1),
+	 NULL}
+	,
+	{
+	 PN_GPDS, GPDS_LL_CONFIGURE_REQ,
+	 gpds_ll_configure_resp_msg1,
+	 sizeof(gpds_ll_configure_resp_msg1),
+	 NULL}
+	,
+	{
+	 PN_GPDS, GPDS_CONTEXT_CONFIGURE_REQ,
+	 gpds_context_configure_resp_msg1,
+	 sizeof(gpds_context_configure_resp_msg1),
+	 NULL}
+	,
+	{
+	 PN_GPDS, GPDS_CONTEXT_AUTH_REQ,
+	 gpds_context_auth_resp_msg1,
+	 sizeof(gpds_context_auth_resp_msg1),
+	 NULL}
+	,
+	{
+	 PN_GPDS, GPDS_CONTEXT_ACTIVATE_REQ,
+	 gpds_context_activate_resp_msg1,
+	 sizeof(gpds_context_activate_resp_msg1),
+	 gpds_context_activate_ind_msg1}
+	,
+	{
+	 PN_GPDS, GPDS_CONTEXT_DEACTIVATE_REQ,
+	 gpds_context_deactivate_resp_msg1,
+	 sizeof(gpds_context_deactivate_resp_msg1),
+	 gpds_context_deactivate_ind_msg1}
+	,
+	{
+	 PN_GPDS, -1,
+	 gpds_context_activate_ind_msg1,
+	 sizeof(gpds_context_activate_ind_msg1),
+	 NULL}
+	,
+	{
+	 PN_GPDS, -1,
+	 gpds_context_deactivate_ind_msg1,
+	 sizeof(gpds_context_deactivate_ind_msg1),
+	 gpds_context_id_delete_ind_msg1}
+	,
+	{
+	 PN_GPDS, -1,
+	 gpds_context_id_delete_ind_msg1,
+	 sizeof(gpds_context_id_delete_ind_msg1),
+	 NULL}
+	,
+	{
+	 PN_GPDS, -1,
+	 gpds_detach_ind_msg1,
+	 sizeof(gpds_detach_ind_msg1),
+	 gpds_transfer_status_ind_not_avail_detach_msg}
+	,
+	{
+	 PN_GPDS, -1,
+	 gpds_transfer_status_ind_not_avail_detach_msg,
+	 sizeof(gpds_transfer_status_ind_not_avail_detach_msg),
+	 NULL}
+	,
+
+	/* PIPE/PEP messages */
+	{
+	 PN_PIPE, PNS_PEP_CONNECT_REQ,
+	 pns_pep_connect_resp_msg1,
+	 sizeof(pns_pep_connect_resp_msg1),
+	 NULL}
+	,
+	{
+	 PN_PIPE, PNS_PEP_DISCONNECT_REQ,
+	 pns_pep_disconnect_resp_msg1,
+	 sizeof(pns_pep_disconnect_resp_msg1),
+	 NULL}
+	,
+	{
+	 PN_PIPE, PNS_PEP_ENABLE_REQ,
+	 pns_pep_enable_resp_msg1,
+	 sizeof(pns_pep_enable_resp_msg1),
+	 NULL}
+	,
+
+	/*UICC messages */
+	/*SMS SCA query is here */
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 sms_sca_query_resp_ok,
+	 sizeof(sms_sca_query_resp_ok),
+	 NULL,
+	 sms_appl_cmd_linear_req,
+	 sizeof(sms_appl_cmd_linear_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 sms_sca_set_resp_ok,
+	 sizeof(sms_sca_set_resp_ok),
+	 NULL,
+	 sms_appl_cmd_linear_update_req,
+	 sizeof(sms_appl_cmd_linear_update_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_CARD_IND,
+	 uicc_card_ind_card_ready,
+	 sizeof(uicc_card_ind_card_ready),
+	 NULL}
+	,
+	{
+	 PN_UICC, UICC_PIN_IND,
+	 uicc_pin1_ind_pin_required,
+	 sizeof(uicc_pin1_ind_pin_required),
+	 uicc_pin2_ind_pin_verified}
+	,
+	{
+	 PN_UICC, -1,
+	 uicc_pin2_ind_pin_required,
+	 sizeof(uicc_pin1_ind_pin_required),
+	 uicc_pin2_ind_pin_verified}
+	,
+	{
+	 PN_UICC, -1,
+	 uicc_pin2_ind_pin_verified,
+	 sizeof(uicc_pin2_ind_pin_verified),
+	 uicc_pin_phnet_ind_pin_verified}
+	,
+	{
+	 PN_UICC, -1,
+	 uicc_pin_phnet_ind_pin_verified,
+	 sizeof(uicc_pin_phnet_ind_pin_verified),
+	 uicc_ind_startup_complete}
+	,
+	{
+	 PN_UICC, -1,
+	 uicc_pin1_ind_puk_required,
+	 sizeof(uicc_pin1_ind_puk_required),
+	 uicc_pin2_ind_puk_required}
+	,
+	{
+	 PN_UICC, -1,
+	 uicc_pin2_ind_puk_required,
+	 sizeof(uicc_pin2_ind_puk_required),
+	 uicc_pin_phnet_ind_puk_required}
+	,
+	{
+	 PN_UICC, -1,
+	 uicc_pin_phnet_ind_puk_required,
+	 sizeof(uicc_pin_phnet_ind_puk_required),
+	 uicc_ind_startup_complete}
+	,
+	{
+	 PN_UICC, -1,
+	 uicc_ind_startup_complete,
+	 sizeof(uicc_ind_startup_complete),
+	 NULL}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_file_info_EFIMSI_resp,
+	 sizeof(uicc_appl_cmd_file_info_EFIMSI_resp),
+	 NULL,
+	 uicc_appl_cmd_file_info_EFIMSI_req,
+	 sizeof(uicc_appl_cmd_file_info_EFIMSI_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_file_info_EFPNN_resp,
+	 sizeof(uicc_appl_cmd_file_info_EFPNN_resp),
+	 NULL,
+	 uicc_appl_cmd_file_info_EFPNN_req,
+	 sizeof(uicc_appl_cmd_file_info_EFPNN_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_file_info_EFMSISDN_resp,
+	 sizeof(uicc_appl_cmd_file_info_EFMSISDN_resp),
+	 NULL,
+	 uicc_appl_cmd_file_info_EFMSISDN_req,
+	 sizeof(uicc_appl_cmd_file_info_EFMSISDN_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_file_info_EFPNN_SIM_resp,
+	 sizeof(uicc_appl_cmd_file_info_EFPNN_SIM_resp),
+	 NULL,
+	 uicc_appl_cmd_file_info_EFPNN_SIM_req,
+	 sizeof(uicc_appl_cmd_file_info_EFPNN_SIM_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_file_info_EFECC_resp,
+	 sizeof(uicc_appl_cmd_file_info_EFECC_resp),
+	 NULL,
+	 uicc_appl_cmd_file_info_EFECC_req,
+	 sizeof(uicc_appl_cmd_file_info_EFECC_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_file_info_EFICI_resp,
+	 sizeof(uicc_appl_cmd_file_info_EFICI_resp),
+	 NULL,
+	 uicc_appl_cmd_file_info_EFICI_req,
+	 sizeof(uicc_appl_cmd_file_info_EFICI_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_file_info_EFLI_resp,
+	 sizeof(uicc_appl_cmd_file_info_EFLI_resp),
+	 NULL,
+	 uicc_appl_cmd_file_info_EFLI_req,
+	 sizeof(uicc_appl_cmd_file_info_EFLI_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_file_info_EFPL_resp,
+	 sizeof(uicc_appl_cmd_file_info_EFPL_resp),
+	 NULL,
+	 uicc_appl_cmd_file_info_EFPL_req,
+	 sizeof(uicc_appl_cmd_file_info_EFPL_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_file_info_EFADN_SIM_resp,
+	 sizeof(uicc_appl_cmd_file_info_EFADN_SIM_resp),
+	 NULL,
+	 uicc_appl_cmd_file_info_EFADN_SIM_req,
+	 sizeof(uicc_appl_cmd_file_info_EFADN_SIM_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_file_info_EFPBR_resp,
+	 sizeof(uicc_appl_cmd_file_info_EFPBR_resp),
+	 NULL,
+	 uicc_appl_cmd_file_info_EFPBR_req,
+	 sizeof(uicc_appl_cmd_file_info_EFPBR_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_file_info_EFADN_resp,
+	 sizeof(uicc_appl_cmd_file_info_EFADN_resp),
+	 NULL,
+	 uicc_appl_cmd_file_info_EFADN_req,
+	 sizeof(uicc_appl_cmd_file_info_EFADN_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_file_info_EFEXT1_resp,
+	 sizeof(uicc_appl_cmd_file_info_EFEXT1_resp),
+	 NULL,
+	 uicc_appl_cmd_file_info_EFEXT1_req,
+	 sizeof(uicc_appl_cmd_file_info_EFEXT1_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_file_info_EFEMAIL_resp,
+	 sizeof(uicc_appl_cmd_file_info_EFEMAIL_resp),
+	 NULL,
+	 uicc_appl_cmd_file_info_EFEMAIL_req,
+	 sizeof(uicc_appl_cmd_file_info_EFEMAIL_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_file_info_EFSNE_resp,
+	 sizeof(uicc_appl_cmd_file_info_EFSNE_resp),
+	 NULL,
+	 uicc_appl_cmd_file_info_EFSNE_req,
+	 sizeof(uicc_appl_cmd_file_info_EFSNE_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_file_info_EFANR_resp,
+	 sizeof(uicc_appl_cmd_file_info_EFANR_resp),
+	 NULL,
+	 uicc_appl_cmd_file_info_EFANR_req,
+	 sizeof(uicc_appl_cmd_file_info_EFANR_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_file_info_general_transparent_SIM_resp,
+	 sizeof(uicc_appl_cmd_file_info_general_transparent_SIM_resp),
+	 NULL,
+	 uicc_appl_cmd_file_info_general_transparent_SIM_req,
+	 sizeof(uicc_appl_cmd_file_info_general_transparent_SIM_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_file_info_general_transparent_resp,
+	 sizeof(uicc_appl_cmd_file_info_general_transparent_resp),
+	 NULL,
+	 uicc_appl_cmd_file_info_general_transparent_req,
+	 sizeof(uicc_appl_cmd_file_info_general_transparent_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_EFLI_response,
+	 sizeof(uicc_appl_cmd_EFLI_response),
+	 NULL,
+	 uicc_appl_cmd_EFLI_req,
+	 sizeof(uicc_appl_cmd_EFLI_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_EFPL_response,
+	 sizeof(uicc_appl_cmd_EFPL_response),
+	 NULL,
+	 uicc_appl_cmd_EFPL_req,
+	 sizeof(uicc_appl_cmd_EFPL_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_transparent_response,
+	 sizeof(uicc_appl_cmd_transparent_response),
+	 NULL,
+	 uicc_appl_cmd_transparent_req,
+	 sizeof(uicc_appl_cmd_transparent_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_linear_fixed_EFPBR1_response,
+	 sizeof(uicc_appl_cmd_linear_fixed_EFPBR1_response),
+	 NULL,
+	 uicc_appl_cmd_linear_fixed_EFPBR1_req,
+	 sizeof(uicc_appl_cmd_linear_fixed_EFPBR1_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_linear_fixed_EFPBR2_response,
+	 sizeof(uicc_appl_cmd_linear_fixed_EFPBR2_response),
+	 NULL,
+	 uicc_appl_cmd_linear_fixed_EFPBR2_req,
+	 sizeof(uicc_appl_cmd_linear_fixed_EFPBR2_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_linear_fixed_ADN1_response,
+	 sizeof(uicc_appl_cmd_linear_fixed_ADN1_response),
+	 NULL,
+	 uicc_appl_cmd_linear_fixed_ADN1_SIM_req,
+	 sizeof(uicc_appl_cmd_linear_fixed_ADN1_SIM_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_linear_fixed_ADN2_response,
+	 sizeof(uicc_appl_cmd_linear_fixed_ADN2_response),
+	 NULL,
+	 uicc_appl_cmd_linear_fixed_ADN2_SIM_req,
+	 sizeof(uicc_appl_cmd_linear_fixed_ADN2_SIM_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_linear_fixed_ADN3_response,
+	 sizeof(uicc_appl_cmd_linear_fixed_ADN3_response),
+	 NULL,
+	 uicc_appl_cmd_linear_fixed_ADN3_req,
+	 sizeof(uicc_appl_cmd_linear_fixed_ADN3_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_linear_fixed_ADN4_response,
+	 sizeof(uicc_appl_cmd_linear_fixed_ADN4_response),
+	 NULL,
+	 uicc_appl_cmd_linear_fixed_ADN4_req,
+	 sizeof(uicc_appl_cmd_linear_fixed_ADN4_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_linear_fixed_ADN5_response,
+	 sizeof(uicc_appl_cmd_linear_fixed_ADN5_response),
+	 NULL,
+	 uicc_appl_cmd_linear_fixed_ADN5_req,
+	 sizeof(uicc_appl_cmd_linear_fixed_ADN5_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_linear_fixed_ADNx_response,
+	 sizeof(uicc_appl_cmd_linear_fixed_ADNx_response),
+	 NULL,
+	 uicc_appl_cmd_linear_fixed_ADNx_SIM_req,
+	 sizeof(uicc_appl_cmd_linear_fixed_ADNx_SIM_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_linear_fixed_ADN1_response,
+	 sizeof(uicc_appl_cmd_linear_fixed_ADN1_response),
+	 NULL,
+	 uicc_appl_cmd_linear_fixed_ADN1_req,
+	 sizeof(uicc_appl_cmd_linear_fixed_ADN1_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_linear_fixed_ADN2_response,
+	 sizeof(uicc_appl_cmd_linear_fixed_ADN2_response),
+	 NULL,
+	 uicc_appl_cmd_linear_fixed_ADN2_req,
+	 sizeof(uicc_appl_cmd_linear_fixed_ADN2_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_linear_fixed_ADNx_response,
+	 sizeof(uicc_appl_cmd_linear_fixed_ADNx_response),
+	 NULL,
+	 uicc_appl_cmd_linear_fixed_ADNx_req,
+	 sizeof(uicc_appl_cmd_linear_fixed_ADNx_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_linear_fixed_EFMSISDN_response,
+	 sizeof(uicc_appl_cmd_linear_fixed_EFMSISDN_response),
+	 NULL,
+	 uicc_appl_cmd_linear_fixed_EFMSISDN_req,
+	 sizeof(uicc_appl_cmd_linear_fixed_EFMSISDN_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_linear_fixed_EXT1_response,
+	 sizeof(uicc_appl_cmd_linear_fixed_EXT1_response),
+	 NULL,
+	 uicc_appl_cmd_linear_fixed_EXT1_req,
+	 sizeof(uicc_appl_cmd_linear_fixed_EXT1_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_linear_fixed_EXT1_response,
+	 sizeof(uicc_appl_cmd_linear_fixed_EXT1_response),
+	 NULL,
+	 uicc_appl_cmd_linear_fixed_EXT1_SIM_req,
+	 sizeof(uicc_appl_cmd_linear_fixed_EXT1_SIM_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_linear_fixed_EXT3_response,
+	 sizeof(uicc_appl_cmd_linear_fixed_EXT3_response),
+	 NULL,
+	 uicc_appl_cmd_linear_fixed_EXT3_req,
+	 sizeof(uicc_appl_cmd_linear_fixed_EXT3_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_linear_fixed_EXT3_response,
+	 sizeof(uicc_appl_cmd_linear_fixed_EXT3_response),
+	 NULL,
+	 uicc_appl_cmd_linear_fixed_EXT3_SIM_req,
+	 sizeof(uicc_appl_cmd_linear_fixed_EXT3_SIM_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_linear_fixed_EFEMAIL_response,
+	 sizeof(uicc_appl_cmd_linear_fixed_EFEMAIL_response),
+	 NULL,
+	 uicc_appl_cmd_linear_fixed_EFEMAIL_req,
+	 sizeof(uicc_appl_cmd_linear_fixed_EFEMAIL_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_linear_fixed_EFSNE_resp,
+	 sizeof(uicc_appl_cmd_linear_fixed_EFSNE_resp),
+	 NULL,
+	 uicc_appl_cmd_linear_fixed_EFSNE_req,
+	 sizeof(uicc_appl_cmd_linear_fixed_EFSNE_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_linear_fixed_EFANR_response,
+	 sizeof(uicc_appl_cmd_linear_fixed_EFANR_response),
+	 NULL,
+	 uicc_appl_cmd_linear_fixed_EFANR_req,
+	 sizeof(uicc_appl_cmd_linear_fixed_EFANR_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_linear_fixed_response,
+	 sizeof(uicc_appl_cmd_linear_fixed_response),
+	 NULL,
+	 uicc_appl_cmd_linear_fixed_req,
+	 sizeof(uicc_appl_cmd_linear_fixed_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_cyclic_response,
+	 sizeof(uicc_appl_cmd_cyclic_response),
+	 NULL,
+	 uicc_appl_cmd_cyclic_req,
+	 sizeof(uicc_appl_cmd_cyclic_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_transparent_write_resp,
+	 sizeof(uicc_appl_cmd_transparent_write_resp),
+	 NULL,
+	 uicc_appl_cmd_transparent_write_req,
+	 sizeof(uicc_appl_cmd_transparent_write_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_linear_fixed_write_resp,
+	 sizeof(uicc_appl_cmd_linear_fixed_write_resp),
+	 NULL,
+	 uicc_appl_cmd_linear_fixed_write_req,
+	 sizeof(uicc_appl_cmd_linear_fixed_write_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_cyclic_write_resp,
+	 sizeof(uicc_appl_cmd_cyclic_write_resp),
+	 NULL,
+	 uicc_appl_cmd_cyclic_write_req,
+	 sizeof(uicc_appl_cmd_cyclic_write_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_PIN_REQ,
+	 uicc_pin_verify_resp,
+	 sizeof(uicc_pin_verify_resp),
+	 uicc_ind_startup_complete,
+	 uicc_pin_verify_req,
+	 sizeof(uicc_pin_verify_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_PIN_REQ,
+	 uicc_pin_enable_resp,
+	 sizeof(uicc_pin_enable_resp),
+	 NULL,
+	 uicc_pin_enable_req,
+	 sizeof(uicc_pin_enable_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_PIN_REQ,
+	 uicc_pin_disable_resp,
+	 sizeof(uicc_pin_disable_resp),
+	 NULL,
+	 uicc_pin_disable_req,
+	 sizeof(uicc_pin_disable_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_PIN_REQ,
+	 uicc_pin_reset_resp,
+	 sizeof(uicc_pin_reset_resp),
+	 uicc_pin1_ind_pin_required,
+	 uicc_pin_reset_req,
+	 sizeof(uicc_pin_reset_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_PIN_REQ,
+	 uicc_pin_change_resp,
+	 sizeof(uicc_pin_change_resp),
+	 NULL,
+	 uicc_pin_change_req,
+	 sizeof(uicc_pin_change_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_PIN_REQ,
+	 uicc_pin_query_resp,
+	 sizeof(uicc_pin_query_resp),
+	 NULL,
+	 uicc_pin_query_req,
+	 sizeof(uicc_pin_query_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_PIN_REQ,
+	 uicc_pin_prompt_resp,
+	 sizeof(uicc_pin_prompt_resp),
+	 NULL,
+	 uicc_pin_prompt_req,
+	 sizeof(uicc_pin_prompt_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_SIMLOCK_REQ,
+	 uicc_simlock_query_resp,
+	 sizeof(uicc_simlock_query_resp),
+	 NULL,
+	 uicc_simlock_query_req,
+	 sizeof(uicc_simlock_query_req) / 2}
+	,
+
+	/*CALL messages */
+	{
+	 PN_MODEM_CALL, CALL_MODEM_STATUS_REQ,
+	 call_modem_status_resp_msg,
+	 sizeof(call_modem_status_resp_msg),
+	 NULL}
+	,
+	{
+	 PN_MODEM_CALL, CALL_MODEM_CREATE_REQ,
+	 call_modem_create_resp_msg2,
+	 sizeof(call_modem_create_resp_msg2),
+	 call_modem_status_ind_idle_msg}
+	,
+	{
+	 PN_MODEM_CALL, -1,
+	 call_modem_status_ind_idle_msg,
+	 sizeof(call_modem_status_ind_idle_msg),
+	 call_modem_status_ind_create_msg2}
+	,
+	{
+	 PN_MODEM_CALL, -1,
+	 call_modem_status_ind_create_msg2,
+	 sizeof(call_modem_status_ind_create_msg2),
+	 call_modem_status_ind_proceeding_msg2}
+	,
+	{
+	 PN_MODEM_CALL, -1,
+	 call_modem_status_ind_proceeding_msg2,
+	 sizeof(call_modem_status_ind_proceeding_msg2),
+	 call_modem_status_ind_mo_alert_msg2}
+	,
+	{
+	 PN_MODEM_CALL, -1,
+	 call_modem_status_ind_mo_alert_msg2,
+	 sizeof(call_modem_status_ind_mo_alert_msg2),
+	 call_modem_status_ind_active_msg2}
+	,
+	{
+	 PN_MODEM_CALL, -1,
+	 call_modem_status_ind_active_msg2,
+	 sizeof(call_modem_status_ind_active_msg2),
+	 call_modem_control_ind_msg}
+	,
+	{
+	 PN_MODEM_CALL, CALL_MODEM_RELEASE_REQ,
+	 call_modem_relese_resp_waiting_msg,
+	 sizeof(call_modem_relese_resp_waiting_msg),
+	 call_modem_status_ind_idle_msg,
+	 call_modem_relese_req_waiting_msg,
+	 sizeof(call_modem_relese_req_waiting_msg) / 2}
+	,
+	{
+	 PN_MODEM_CALL, CALL_MODEM_RELEASE_REQ,
+	 call_modem_release_resp_msg2,
+	 sizeof(call_modem_release_resp_msg2),
+	 call_modem_status_ind_mo_release_msg2}
+	,
+	{
+	 PN_MODEM_CALL, -1,
+	 call_modem_status_ind_mo_release_msg2,
+	 sizeof(call_modem_status_ind_mo_release_msg2),
+	 call_modem_status_ind_idle_msg2}
+	,
+	{
+	 PN_MODEM_CALL, -1,
+	 call_modem_status_ind_idle_msg2,
+	 sizeof(call_modem_status_ind_idle_msg2),
+	 call_modem_status_ind_mt_release_msg3}
+	,
+	{
+	 PN_MODEM_CALL, CALL_MODEM_CONTROL_REQ,
+	 call_modem_control_resp_hold_msg,
+	 sizeof(call_modem_control_resp_hold_msg),
+	 call_modem_status_ind_hold_init_msg3,
+	 call_modem_control_req_hold_msg,
+	 sizeof(call_modem_control_req_hold_msg) / 2}
+	,
+	{
+	 PN_MODEM_CALL, CALL_MODEM_CONTROL_REQ,
+	 call_modem_control_resp_retr_msg,
+	 sizeof(call_modem_control_resp_retr_msg),
+	 call_modem_status_ind_active_msg3,
+	 call_modem_control_req_retr_msg,
+	 sizeof(call_modem_control_req_retr_msg) / 2}
+	,
+	{
+	 PN_MODEM_CALL, CALL_MODEM_CONTROL_REQ,
+	 call_modem_control_resp_swap_msg,
+	 sizeof(call_modem_control_resp_swap_msg),
+	 call_modem_status_ind_hold_msg2,
+	 call_modem_control_req_swap_msg,
+	 sizeof(call_modem_control_req_swap_msg) / 2}
+	,
+	{
+	 PN_MODEM_CALL, CALL_MODEM_CONTROL_REQ,
+	 call_modem_control_resp_transfer_msg,
+	 sizeof(call_modem_control_resp_transfer_msg),
+	 call_modem_control_ind_error_msg,
+	 call_modem_control_req_transfer_msg,
+	 sizeof(call_modem_control_req_transfer_msg) / 2}
+	,
+	{
+	 PN_MODEM_CALL, CALL_MODEM_CONTROL_REQ,
+	 call_modem_control_resp_conf_build_msg,
+	 sizeof(call_modem_control_resp_conf_build_msg),
+	 call_modem_status_ind_active_msg2,
+	 call_modem_control_req_conf_build_msg,
+	 sizeof(call_modem_control_req_conf_build_msg) / 2}
+	,
+	{
+	 PN_MODEM_CALL, CALL_MODEM_CONTROL_REQ,
+	 call_modem_control_resp_pri_chat_msg,
+	 sizeof(call_modem_control_resp_pri_chat_msg),
+	 call_modem_status_ind_hold_msg3,
+	 call_modem_control_req_pri_chat_msg,
+	 sizeof(call_modem_control_req_pri_chat_msg) / 2}
+	,
+	{
+	 PN_MODEM_CALL, -1,
+	 call_modem_status_ind_hold_init_msg3,
+	 sizeof(call_modem_status_ind_hold_init_msg3),
+	 call_modem_status_ind_hold_msg3}
+	,
+	{
+	 PN_MODEM_CALL, -1,
+	 call_modem_status_ind_hold_msg3,
+	 sizeof(call_modem_status_ind_hold_msg3),
+	 call_modem_control_ind_msg}
+	,
+	{
+	 PN_MODEM_CALL, -1,
+	 call_modem_status_ind_hold_msg2,
+	 sizeof(call_modem_status_ind_hold_msg2),
+	 call_modem_status_ind_active_msg3}
+	,
+	{
+	 PN_MODEM_CALL, CALL_MODEM_STATUS_IND,
+	 call_modem_status_ind_coming_msg3,
+	 sizeof(call_modem_status_ind_coming_msg3),
+	 call_modem_status_ind_proceeding_msg3}
+	,
+	{
+	 PN_MODEM_CALL, -1,
+	 call_modem_status_ind_proceeding_msg3,
+	 sizeof(call_modem_status_ind_proceeding_msg3),
+	 call_modem_status_ind_mt_alerting_msg3}
+	,
+	{
+	 PN_MODEM_CALL, -1,
+	 call_modem_status_ind_mt_alerting_msg3,
+	 sizeof(call_modem_status_ind_mt_alerting_msg3),
+	 NULL}
+	,
+	{
+	 PN_MODEM_CALL, CALL_MODEM_ANSWER_REQ,
+	 call_modem_answer_resp_msg3,
+	 sizeof(call_modem_answer_resp_msg3),
+	 call_modem_status_ind_answered_msg3}
+	,
+	{
+	 PN_MODEM_CALL, -1,
+	 call_modem_status_ind_answered_msg3,
+	 sizeof(call_modem_status_ind_answered_msg3),
+	 call_modem_status_ind_active_msg3}
+	,
+	{
+	 PN_MODEM_CALL, -1,
+	 call_modem_status_ind_active_msg3,
+	 sizeof(call_modem_status_ind_active_msg3),
+	 call_modem_control_ind_msg}
+	,
+	{
+	 PN_MODEM_CALL, -1,
+	 call_modem_status_ind_mt_release_msg3,
+	 sizeof(call_modem_status_ind_mt_release_msg3),
+	 call_modem_status_ind_idle_msg3}
+	,
+	{
+	 PN_MODEM_CALL, -1,
+	 call_modem_status_ind_idle_msg3,
+	 sizeof(call_modem_status_ind_idle_msg3),
+	 call_modem_mt_alert}
+	,
+	{
+	 PN_MODEM_CALL, -1,
+	 call_modem_mt_alert,
+	 sizeof(call_modem_mt_alert),
+	 NULL}
+	,
+	{
+	 PN_MODEM_CALL, CALL_MODEM_DTMF_SEND_REQ,
+	 call_modem_dtmf_send_resp_msg2,
+	 sizeof(call_modem_dtmf_send_resp_msg2),
+	 call_modem_status_ind_hold_msg2multi}
+	,
+	{
+	 PN_MODEM_CALL, -1,
+	 call_modem_status_ind_hold_msg2multi,
+	 sizeof(call_modem_status_ind_hold_msg2multi),
+	 call_modem_status_ind_hold_msg3}
+	,
+	{
+	 PN_MODEM_CALL, -1,
+	 call_modem_control_ind_msg,
+	 sizeof(call_modem_control_ind_msg),
+	 NULL}
+	,
+	{
+	 PN_MODEM_CALL, -1,
+	 call_modem_control_ind_error_msg,
+	 sizeof(call_modem_control_ind_error_msg),
+	 call_modem_status_ind_waiting_msg}
+	,
+	{
+	 PN_MODEM_CALL, CALL_MODEM_NOTIFICATION_IND,
+	 call_modem_notification_ind_test,
+	 sizeof(call_modem_notification_ind_test),
+	 call_modem_notification_ind_barring_inc}
+	,
+	{
+	 PN_MODEM_CALL, -1,
+	 call_modem_notification_ind_barring_inc,
+	 sizeof(call_modem_notification_ind_barring_inc),
+	 call_modem_notification_ind_barring_out}
+	,
+	{
+	 PN_MODEM_CALL, -1,
+	 call_modem_notification_ind_barring_out,
+	 sizeof(call_modem_notification_ind_barring_out),
+	 call_modem_notification_ind_forwarding_uncond}
+	,
+	{
+	 PN_MODEM_CALL, -1,
+	 call_modem_notification_ind_forwarding_uncond,
+	 sizeof(call_modem_notification_ind_forwarding_uncond),
+	 call_modem_notification_ind_forwarding_cond}
+	,
+	{
+	 PN_MODEM_CALL, -1,
+	 call_modem_notification_ind_forwarding_cond,
+	 sizeof(call_modem_notification_ind_forwarding_cond),
+	 call_modem_notification_ind_call_hold}
+	,
+	{
+	 PN_MODEM_CALL, -1,
+	 call_modem_notification_ind_call_hold,
+	 sizeof(call_modem_notification_ind_call_hold),
+	 call_modem_notification_ind_mpty}
+	,
+	{
+	 PN_MODEM_CALL, -1,
+	 call_modem_notification_ind_mpty,
+	 sizeof(call_modem_notification_ind_mpty),
+	 call_modem_notification_ind_cug_call}
+	,
+	{
+	 PN_MODEM_CALL, -1,
+	 call_modem_notification_ind_cug_call,
+	 sizeof(call_modem_notification_ind_cug_call),
+	 NULL}
+	,
+	{
+	 PN_MODEM_CALL, -1,
+	 call_modem_status_ind_waiting_msg,
+	 sizeof(call_modem_status_ind_waiting_msg),
+	 NULL}
+	,
+
+	/* INFO messages */
+	{
+	 PN_MODEM_INFO, M_INFO_VERSION_READ_REQ,
+	 version_info_query_resp_ok,
+	 sizeof(version_info_query_resp_ok),
+	 NULL}
+	,
+
+	/*SMS messages */
+	/* Receive */
+	{
+	 PN_SMS, SMS_RECEIVED_MSG_IND,
+	 sms_received_incorrect_msg_ind,
+	 sizeof(sms_received_incorrect_msg_ind),
+	 sms_received_msg_ind}
+	,
+	{
+	 PN_SMS, -1,
+	 sms_received_msg_ind,
+	 sizeof(sms_received_msg_ind)
+	 }
+	,
+	/*
+	 * {PN_SMS, SMS_RECEIVE_MESSAGE_REQ,
+	 * sms_receive_message_resp_inactive,
+	 * sizeof(sms_receive_message_resp_inactive)},
+	 */
+	{
+	 PN_SMS, SMS_RECEIVE_MESSAGE_REQ,
+	 sms_receive_message_resp_active,
+	 sizeof(sms_receive_message_resp_active)
+	 }
+	,
+	{
+	 PN_SMS, SMS_RECEIVED_MSG_REPORT_REQ,
+	 sms_received_msg_report_resp,
+	 sizeof(sms_received_msg_report_resp)
+	 }
+	,
+	/* Send */
+	{
+	 PN_SMS, SMS_MESSAGE_SEND_REQ,
+	 sms_message_send_resp,
+	 sizeof(sms_message_send_resp)
+	 }
+	,
+	/* SETTINGS_UPDATE */
+	{
+	 PN_SMS, SMS_SETTINGS_UPDATE_REQ,
+	 sms_settings_update_resp_ok,
+	 sizeof(sms_settings_update_resp_ok)
+	 }
+	,
+	/* Route settings query */
+	{
+	 PN_SMS, SMS_SETTINGS_READ_REQ,
+	 sms_settings_read_resp_cs_only,
+	 sizeof(sms_settings_read_resp_cs_only)
+	 }
+	,
+
+	 /*CBS*/ {
+		  PN_SMS, SMS_CB_ROUTING_REQ,
+		  req_cbs_routing_resp,
+		  sizeof(req_cbs_routing_resp),
+		  sms_received_cbs_msg_ind,
+		  }
+	,
+	/*Receive cbs */
+	{
+	 PN_SMS, -1,
+	 sms_received_cbs_msg_ind,
+	 sizeof(sms_received_cbs_msg_ind),
+	 NULL}
+	,
+	/*Advanced voice calls */
+	/*Call forwarding */
+	{
+	 PN_SS, SS_SERVICE_REQ,
+	 call_forward_query_resp_forw,
+	 sizeof(call_forward_query_resp_forw),
+	 NULL,
+	 req_query_forw,
+	 sizeof(req_query_forw) / 2}
+	,
+	{
+	 PN_SS, SS_SERVICE_REQ,
+	 call_forward_query_resp_A0,
+	 sizeof(call_forward_query_resp_A0),
+	 NULL,
+	 req_query_forw_A0,
+	 sizeof(req_query_forw_A0) / 2}
+	,
+	{
+	 PN_SS, SS_SERVICE_REQ,
+	 call_forward_query_resp_B0,
+	 sizeof(call_forward_query_resp_B0),
+	 NULL,
+	 req_query_forw_B0,
+	 sizeof(req_query_forw_B0) / 2}
+	,
+	{
+	 PN_SS, SS_SERVICE_REQ,
+	 call_forward_query_resp_C0,
+	 sizeof(call_forward_query_resp_C0),
+	 NULL,
+	 req_query_forw_C0,
+	 sizeof(req_query_forw_C0) / 2}
+	,
+	{
+	 PN_SS, SS_SERVICE_REQ,
+	 call_forward_query_resp_D0,
+	 sizeof(call_forward_query_resp_D0),
+	 NULL,
+	 req_query_forw_D0,
+	 sizeof(req_query_forw_D0) / 2}
+	,
+	{
+	 PN_SS, SS_SERVICE_REQ,
+	 call_forward_query_resp_erase,
+	 sizeof(call_forward_query_resp_erase),
+	 NULL,
+	 req_query_forw_erase,
+	 sizeof(req_query_forw_erase) / 2}
+	,
+	{
+	 PN_SS, SS_SERVICE_REQ,
+	 call_forward_query_resp_erase_A0,
+	 sizeof(call_forward_query_resp_erase_A0),
+	 NULL,
+	 req_query_forw_erase_A0,
+	 sizeof(req_query_forw_erase_A0) / 2}
+	,
+	{
+	 PN_SS, SS_SERVICE_REQ,
+	 call_forward_query_resp_erase_B0,
+	 sizeof(call_forward_query_resp_erase_B0),
+	 NULL,
+	 req_query_forw_erase_B0,
+	 sizeof(req_query_forw_erase_B0) / 2}
+	,
+	{
+	 PN_SS, SS_SERVICE_REQ,
+	 forw_no_reply_set_resp,
+	 sizeof(forw_no_reply_set_resp),
+	 NULL,
+	 forw_no_reply_set_req,
+	 sizeof(forw_no_reply_set_req) / 2}
+	,
+	{
+	 PN_SS, SS_SERVICE_REQ,
+	 forw_uncond_set_resp,
+	 sizeof(forw_uncond_set_resp),
+	 NULL,
+	 forw_uncond_set_req,
+	 sizeof(forw_uncond_set_req) / 2}
+	,
+	{
+	 PN_SS, SS_GSM_USSD_SEND_REQ,
+	 req_ussd_init_resp,
+	 sizeof(req_ussd_init_resp),
+	 req_ussd_init_ind,
+	 req_ussd_init,
+	 sizeof(req_ussd_init) / 2}
+	,
+	{
+	 PN_SS, -1,
+	 req_ussd_init_ind,
+	 sizeof(req_ussd_init_ind),
+	 NULL,
+	 NULL,
+	 0}
+	,
+	{
+	 PN_SS, SS_GSM_USSD_SEND_REQ,
+	 req_ussd_cancel_resp,
+	 sizeof(req_ussd_cancel_resp),
+	 NULL,
+	 req_ussd_cancel,
+	 sizeof(req_ussd_cancel) / 2}
+	,
+
+	/*Call Barring */
+	{
+	 PN_SS, SS_SERVICE_REQ,
+	 call_barring_query_resp_AO,
+	 sizeof(call_barring_query_resp_AO),
+	 NULL,
+	 req_query_AO,
+	 sizeof(req_query_AO) / 2}
+	,
+	/* ISIMODEM2.5 messages */
+	{
+	 PN_SS, SS_SERVICE_REQ,
+	 call_barring_query_resp_AO,
+	 sizeof(call_barring_query_resp_AO),
+	 NULL,
+	 req_query_AO,
+	 sizeof(req_query_AO) / 2}
+	,
+	{
+	 PN_SS, SS_SERVICE_REQ,
+	 call_barring_query_resp_OI,
+	 sizeof(call_barring_query_resp_OI),
+	 NULL, req_query_OI,
+	 sizeof(req_query_OI) / 2}
+	,
+	{
+	 PN_SS, SS_SERVICE_REQ,
+	 call_barring_query_resp_OX,
+	 sizeof(call_barring_query_resp_OX),
+	 NULL,
+	 req_query_OX,
+	 sizeof(req_query_OX) / 2}
+	,
+	{
+	 PN_SS, SS_SERVICE_REQ,
+	 call_barring_query_resp_AI,
+	 sizeof(call_barring_query_resp_AI),
+	 NULL,
+	 req_query_AI,
+	 sizeof(req_query_AI) / 2}
+	,
+	{
+	 PN_SS, SS_SERVICE_REQ,
+	 call_barring_query_resp_IR,
+	 sizeof(call_barring_query_resp_IR),
+	 NULL,
+	 req_query_IR,
+	 sizeof(req_query_IR) / 2}
+	,
+	{
+	 PN_SS, SS_SERVICE_REQ,
+	 call_barring_disable_all_in_msg,
+	 sizeof(call_barring_disable_all_in_msg),
+	 NULL,
+	 req_disable_all_in,
+	 sizeof(req_disable_all_in) / 2}
+	,
+	{
+	 PN_SS, SS_SERVICE_REQ,
+	 call_barring_disable_all_out_msg,
+	 sizeof(call_barring_disable_all_out_msg),
+	 NULL,
+	 req_disable_all_out,
+	 sizeof(req_disable_all_out) / 2}
+	,
+	{
+	 PN_SS, SS_SERVICE_REQ,
+	 call_barring_enable_all_in_msg,
+	 sizeof(call_barring_enable_all_in_msg),
+	 NULL,
+	 req_enable_all_in,
+	 sizeof(req_enable_all_in) / 2}
+	,
+	{
+	 PN_SS, SS_SERVICE_REQ,
+	 call_barring_enable_all_out_msg,
+	 sizeof(call_barring_enable_all_out_msg),
+	 NULL,
+	 req_enable_all_out,
+	 sizeof(req_enable_all_out) / 2}
+	,
+	{
+	 PN_SS, SS_SERVICE_REQ,
+	 req_change_cb_password_msg,
+	 sizeof(req_change_cb_password_msg),
+	 NULL,
+	 req_change_cb_password,
+	 sizeof(req_change_cb_password) / 2}
+	,
+	/*Call waiting */
+	{
+	 PN_SS, SS_SERVICE_REQ,
+	 call_waiting_query_resp,
+	 sizeof(call_waiting_query_resp),
+	 NULL, req_query_cw,
+	 sizeof(req_query_cw) / 2}
+	,
+	{
+	 PN_SS, SS_SERVICE_REQ,
+	 call_waiting_query_resp_A0,
+	 sizeof(call_waiting_query_resp_A0),
+	 NULL,
+	 req_query_cw_A0,
+	 sizeof(req_query_cw_A0) / 2}
+	,
+	{
+	 PN_SS, SS_SERVICE_REQ,
+	 call_waiting_query_resp_B0,
+	 sizeof(call_waiting_query_resp_B0),
+	 NULL,
+	 req_query_cw_B0,
+	 sizeof(req_query_cw_B0) / 2}
+	,
+	 /*CLIP*/ {
+		   PN_SS, SS_SERVICE_REQ,
+		   clip_query_resp,
+		   sizeof(clip_query_resp),
+		   NULL,
+		   req_query_clip,
+		   sizeof(req_query_clip) / 2}
+	,
+	 /*CLIR*/ {
+		   PN_SS, SS_SERVICE_REQ,
+		   clir_query_resp,
+		   sizeof(clir_query_resp),
+		   NULL,
+		   req_query_clir,
+		   sizeof(req_query_clir) / 2}
+	,
+	 /*COLP*/ {
+		   PN_SS, SS_SERVICE_REQ,
+		   colp_query_resp,
+		   sizeof(colp_query_resp),
+		   NULL,
+		   req_query_colp,
+		   sizeof(req_query_colp) / 2}
+	,
+	 /*COLR*/ {
+		   PN_SS, SS_SERVICE_REQ,
+		   colr_query_resp,
+		   sizeof(colr_query_resp),
+		   NULL,
+		   req_query_colr,
+		   sizeof(req_query_colr) / 2}
+	,
+};
+
+struct isimodem25_response fakeresps_sms_fail[] =3D {
+	/*
+	 * How to add new simulation msgs:
+	 * 1) Phonet resource
+	 * 2) Request for which you want a response OR Indication you
+	 *       want to subscribe for
+	 * 3) Response or indication message
+	 * 4) Size of the response message
+	 * 5) Next message
+	 * 6) Long request (in case a more detailed match is required)
+	 * 7) Size of long request
+	 */
+	/*Changeable responses. Do not change the order */
+	{
+	 PN_UICC, UICC_APPLICATION_REQ,
+	 uicc_app_list_resp,
+	 sizeof(uicc_app_list_resp),
+	 NULL,
+	 uicc_app_list_req,
+	 sizeof(uicc_app_list_req) / 2}
+	,
+
+	/*Not changeable responses */
+	{
+	 PN_UICC, UICC_APPLICATION_REQ,
+	 uicc_app_activate_ok_resp,
+	 sizeof(uicc_app_activate_ok_resp),
+	 NULL,
+	 uicc_app_activate_req,
+	 sizeof(uicc_app_activate_req) / 2}
+	,
+	/*PN_MODEM_MCE messages */
+	{
+	 PN_MODEM_MCE, MCE_MODEM_STATE_IND,
+	 modem_state_normal_ind,
+	 sizeof(modem_state_normal_ind),
+	 NULL,
+	 NULL,
+	 0}
+	,
+	{
+	 PN_MODEM_MCE, MCE_RF_STATE_REQ,
+	 rf_on_resp_ok,
+	 sizeof(rf_on_resp_ok),
+	 NULL,
+	 NULL,
+	 0}
+	,
+	{
+	 PN_MODEM_MCE, MCE_RF_STATE_QUERY_REQ,
+	 rf_state_query_resp,
+	 sizeof(rf_state_query_resp),
+	 NULL,
+	 NULL,
+	 0}
+	,
+	{
+	 PN_MODEM_MCE, MCE_MODEM_STATE_QUERY_REQ,
+	 modem_state_query_resp_ok,
+	 sizeof(modem_state_query_resp_ok),
+	 NULL,
+	 NULL,
+	 0}
+	,
+
+	/* Network registration messages */
+	{
+	 PN_MODEM_NETWORK, NET_SET_REQ,
+	 set_auto_resp_cb_msg,
+	 sizeof(set_auto_resp_cb_msg),
+	 NULL, reg_auto,
+	 sizeof(reg_auto) / 2}
+	,
+	{
+	 PN_MODEM_NETWORK, NET_SET_REQ,
+	 set_manual_resp_cb_msg,
+	 sizeof(set_manual_resp_cb_msg),
+	 NULL,
+	 reg_manual,
+	 sizeof(reg_manual) / 2}
+	,
+	{
+	 PN_MODEM_NETWORK, NET_MODEM_REG_STATUS_GET_REQ,
+	 reg_status_resp_cb_auto_msg,
+	 sizeof(reg_status_resp_cb_auto_msg),
+	 NULL,
+	 NULL,
+	 0}
+	,
+	{
+	 PN_MODEM_NETWORK, NET_RSSI_GET_REQ,
+	 rssi_resp_cb_msg,
+	 sizeof(rssi_resp_cb_msg),
+	 NULL}
+	,
+	{
+	 PN_MODEM_NETWORK, NET_MODEM_AVAILABLE_GET_REQ,
+	 available_resp_cb_msg,
+	 sizeof(available_resp_cb_msg),
+	 NULL}
+	,
+	{
+	 PN_MODEM_NETWORK, NET_RSSI_IND,
+	 rssi_ind_cb_msg,
+	 sizeof(rssi_ind_cb_msg),
+	 NULL}
+	,
+	{
+	 PN_MODEM_NETWORK, NET_MODEM_REG_STATUS_IND,
+	 reg_status_ind_cb_msg,
+	 sizeof(reg_status_ind_cb_msg),
+	 NULL}
+	,
+	{
+	 PN_MODEM_NETWORK, NET_RAT_IND,
+	 rat_ind_cb_msg,
+	 sizeof(rat_ind_cb_msg),
+	 NULL}
+	,
+	{
+	 PN_MODEM_NETWORK, NET_RAT_REQ,
+	 rat_resp,
+	 sizeof(rat_resp),
+	 NULL}
+	,
+	{
+	 PN_MODEM_NETWORK, NET_CELL_INFO_GET_REQ,
+	 cell_info_resp_cb_msg,
+	 sizeof(cell_info_resp_cb_msg),
+	 NULL}
+	,
+	{
+	 PN_MODEM_NETWORK, NET_NITZ_NAME_IND,
+	 nitz_name_ind_msg,
+	 sizeof(nitz_name_ind_msg),
+	 NULL}
+	,
+	{
+	 PN_MODEM_NETWORK, NET_CS_STATE_IND,
+	 net_cs_state_ind_msg,
+	 sizeof(net_cs_state_ind_msg),
+	 NULL}
+	,
+	{
+	 PN_MODEM_NETWORK, NET_CS_STATE_REQ,
+	 net_cs_state_resp,
+	 sizeof(net_cs_state_resp),
+	 NULL}
+	,
+	{
+	 PN_MODEM_NETWORK, NET_CS_CONTROL_REQ,
+	 net_cs_control_resp,
+	 sizeof(net_cs_control_resp),
+	 NULL}
+	,
+
+	/* GSS messages */
+	{
+	 PN_GSS, GSS_CS_SERVICE_REQ,
+	 rat_query_resp_msg,
+	 sizeof(rat_query_resp_msg),
+	 NULL, rat_query_req,
+	 sizeof(rat_query_req) / 2}
+	,
+	{
+	 PN_GSS, GSS_CS_SERVICE_REQ,
+	 rat_set_any_resp_msg,
+	 sizeof(rat_set_any_resp_msg),
+	 NULL, rat_set_any_req,
+	 sizeof(rat_set_any_req) / 2}
+	,
+	{
+	 PN_GSS, GSS_CS_SERVICE_REQ,
+	 rat_set_umts_resp_msg,
+	 sizeof(rat_set_umts_resp_msg),
+	 NULL, rat_set_umts_req,
+	 sizeof(rat_set_umts_req) / 2}
+	,
+	{
+	 PN_GSS, GSS_CS_SERVICE_REQ,
+	 rat_set_gsm_resp_msg,
+	 sizeof(rat_set_gsm_resp_msg),
+	 NULL, rat_set_gsm_req,
+	 sizeof(rat_set_gsm_req) / 2}
+	,
+
+	/* GPDS/GPRS messages */
+	{
+	 PN_GPDS, GPDS_ATTACH_REQ,
+	 gpds_attach_resp_msg,
+	 sizeof(gpds_attach_resp_msg),
+	 NULL}
+	,
+	{
+	 PN_GPDS, GPDS_STATUS_REQ,
+	 gpds_status_resp_attached_msg,
+	 sizeof(gpds_status_resp_attached_msg),
+	 NULL}
+	,
+	{
+	 PN_GPDS, GPDS_DETACH_REQ,
+	 gpds_detach_resp_msg,
+	 sizeof(gpds_detach_resp_msg),
+	 gpds_detach_ind_msg1}
+	,
+	{
+	 PN_GPDS, GPDS_CONFIGURE_REQ,
+	 gpds_configure_resp_msg,
+	 sizeof(gpds_configure_resp_msg),
+	 NULL}
+	,
+	{
+	 PN_GPDS, GPDS_CONTEXT_ID_CREATE_REQ,
+	 gpds_context_id_create_resp_msg1,
+	 sizeof(gpds_context_id_create_resp_msg1),
+	 NULL}
+	,
+	{
+	 PN_GPDS, GPDS_LL_CONFIGURE_REQ,
+	 gpds_ll_configure_resp_msg1,
+	 sizeof(gpds_ll_configure_resp_msg1),
+	 NULL}
+	,
+	{
+	 PN_GPDS, GPDS_CONTEXT_CONFIGURE_REQ,
+	 gpds_context_configure_resp_msg1,
+	 sizeof(gpds_context_configure_resp_msg1),
+	 NULL}
+	,
+	{
+	 PN_GPDS, GPDS_CONTEXT_AUTH_REQ,
+	 gpds_context_auth_resp_msg1,
+	 sizeof(gpds_context_auth_resp_msg1),
+	 NULL}
+	,
+	{
+	 PN_GPDS, GPDS_CONTEXT_ACTIVATE_REQ,
+	 gpds_context_activate_resp_msg1,
+	 sizeof(gpds_context_activate_resp_msg1),
+	 gpds_context_activate_ind_msg1}
+	,
+	{
+	 PN_GPDS, GPDS_CONTEXT_DEACTIVATE_REQ,
+	 gpds_context_deactivate_resp_msg1,
+	 sizeof(gpds_context_deactivate_resp_msg1),
+	 gpds_context_deactivate_ind_msg1}
+	,
+	{
+	 PN_GPDS, -1,
+	 gpds_context_activate_ind_msg1,
+	 sizeof(gpds_context_activate_ind_msg1),
+	 NULL}
+	,
+	{
+	 PN_GPDS, -1,
+	 gpds_context_deactivate_ind_msg1,
+	 sizeof(gpds_context_deactivate_ind_msg1),
+	 gpds_context_id_delete_ind_msg1}
+	,
+	{
+	 PN_GPDS, -1,
+	 gpds_context_id_delete_ind_msg1,
+	 sizeof(gpds_context_id_delete_ind_msg1),
+	 NULL}
+	,
+	{
+	 PN_GPDS, -1,
+	 gpds_detach_ind_msg1,
+	 sizeof(gpds_detach_ind_msg1),
+	 gpds_transfer_status_ind_not_avail_detach_msg}
+	,
+	{
+	 PN_GPDS, -1,
+	 gpds_transfer_status_ind_not_avail_detach_msg,
+	 sizeof(gpds_transfer_status_ind_not_avail_detach_msg),
+	 NULL}
+	,
+
+	/* PIPE/PEP messages */
+	{
+	 PN_PIPE, PNS_PEP_CONNECT_REQ,
+	 pns_pep_connect_resp_msg1,
+	 sizeof(pns_pep_connect_resp_msg1),
+	 NULL}
+	,
+	{
+	 PN_PIPE, PNS_PEP_DISCONNECT_REQ,
+	 pns_pep_disconnect_resp_msg1,
+	 sizeof(pns_pep_disconnect_resp_msg1),
+	 NULL}
+	,
+	{
+	 PN_PIPE, PNS_PEP_ENABLE_REQ,
+	 pns_pep_enable_resp_msg1,
+	 sizeof(pns_pep_enable_resp_msg1),
+	 NULL}
+	,
+
+	/*UICC messages */
+	/*SMS SCA query is here */
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 sms_sca_query_resp_fail,
+	 sizeof(sms_sca_query_resp_fail),
+	 NULL,
+	 sms_appl_cmd_linear_req,
+	 sizeof(sms_appl_cmd_linear_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 sms_sca_set_resp_fail,
+	 sizeof(sms_sca_set_resp_fail),
+	 NULL,
+	 sms_appl_cmd_linear_update_req,
+	 sizeof(sms_appl_cmd_linear_update_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_CARD_IND,
+	 uicc_card_ind_card_ready,
+	 sizeof(uicc_card_ind_card_ready),
+	 NULL}
+	,
+	{
+	 PN_UICC, UICC_PIN_IND,
+	 uicc_pin1_ind_pin_verified,
+	 sizeof(uicc_pin1_ind_pin_verified),
+	 uicc_pin2_ind_pin_verified}
+	,
+	{
+	 PN_UICC, -1,
+	 uicc_pin2_ind_pin_verified,
+	 sizeof(uicc_pin2_ind_pin_verified),
+	 uicc_pin_phnet_ind_pin_verified}
+	,
+	{
+	 PN_UICC, -1,
+	 uicc_pin_phnet_ind_pin_verified,
+	 sizeof(uicc_pin_phnet_ind_pin_verified),
+	 uicc_pin1_ind_puk_required}
+	,
+	{
+	 PN_UICC, -1,
+	 uicc_pin1_ind_puk_required,
+	 sizeof(uicc_pin1_ind_puk_required),
+	 uicc_pin2_ind_puk_required}
+	,
+	{
+	 PN_UICC, -1,
+	 uicc_pin2_ind_puk_required,
+	 sizeof(uicc_pin2_ind_puk_required),
+	 uicc_pin_phnet_ind_puk_required}
+	,
+	{
+	 PN_UICC, -1,
+	 uicc_pin_phnet_ind_puk_required,
+	 sizeof(uicc_pin_phnet_ind_puk_required),
+	 uicc_ind_startup_complete}
+	,
+	{
+	 PN_UICC, -1,
+	 uicc_ind_startup_complete,
+	 sizeof(uicc_ind_startup_complete),
+	 NULL}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_file_info_EFIMSI_resp,
+	 sizeof(uicc_appl_cmd_file_info_EFIMSI_resp),
+	 NULL,
+	 uicc_appl_cmd_file_info_EFIMSI_req,
+	 sizeof(uicc_appl_cmd_file_info_EFIMSI_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_file_info_EFPNN_resp,
+	 sizeof(uicc_appl_cmd_file_info_EFPNN_resp),
+	 NULL,
+	 uicc_appl_cmd_file_info_EFPNN_req,
+	 sizeof(uicc_appl_cmd_file_info_EFPNN_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_file_info_EFMSISDN_resp,
+	 sizeof(uicc_appl_cmd_file_info_EFMSISDN_resp),
+	 NULL,
+	 uicc_appl_cmd_file_info_EFMSISDN_req,
+	 sizeof(uicc_appl_cmd_file_info_EFMSISDN_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_file_info_EFPNN_SIM_resp,
+	 sizeof(uicc_appl_cmd_file_info_EFPNN_SIM_resp),
+	 NULL,
+	 uicc_appl_cmd_file_info_EFPNN_SIM_req,
+	 sizeof(uicc_appl_cmd_file_info_EFPNN_SIM_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_file_info_EFECC_resp,
+	 sizeof(uicc_appl_cmd_file_info_EFECC_resp),
+	 NULL,
+	 uicc_appl_cmd_file_info_EFECC_req,
+	 sizeof(uicc_appl_cmd_file_info_EFECC_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_file_info_EFICI_resp,
+	 sizeof(uicc_appl_cmd_file_info_EFICI_resp),
+	 NULL,
+	 uicc_appl_cmd_file_info_EFICI_req,
+	 sizeof(uicc_appl_cmd_file_info_EFICI_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_file_info_EFADN_SIM_resp,
+	 sizeof(uicc_appl_cmd_file_info_EFADN_SIM_resp),
+	 NULL,
+	 uicc_appl_cmd_file_info_EFADN_SIM_req,
+	 sizeof(uicc_appl_cmd_file_info_EFADN_SIM_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_file_info_EFPBR_resp,
+	 sizeof(uicc_appl_cmd_file_info_EFPBR_resp),
+	 NULL,
+	 uicc_appl_cmd_file_info_EFPBR_req,
+	 sizeof(uicc_appl_cmd_file_info_EFPBR_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_file_info_EFADN_resp,
+	 sizeof(uicc_appl_cmd_file_info_EFADN_resp),
+	 NULL,
+	 uicc_appl_cmd_file_info_EFADN_req,
+	 sizeof(uicc_appl_cmd_file_info_EFADN_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_file_info_EFEXT1_resp,
+	 sizeof(uicc_appl_cmd_file_info_EFEXT1_resp),
+	 NULL,
+	 uicc_appl_cmd_file_info_EFEXT1_req,
+	 sizeof(uicc_appl_cmd_file_info_EFEXT1_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_file_info_EFEMAIL_resp,
+	 sizeof(uicc_appl_cmd_file_info_EFEMAIL_resp),
+	 NULL,
+	 uicc_appl_cmd_file_info_EFEMAIL_req,
+	 sizeof(uicc_appl_cmd_file_info_EFEMAIL_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_file_info_EFSNE_resp,
+	 sizeof(uicc_appl_cmd_file_info_EFSNE_resp),
+	 NULL,
+	 uicc_appl_cmd_file_info_EFSNE_req,
+	 sizeof(uicc_appl_cmd_file_info_EFSNE_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_file_info_EFANR_resp,
+	 sizeof(uicc_appl_cmd_file_info_EFANR_resp),
+	 NULL,
+	 uicc_appl_cmd_file_info_EFANR_req,
+	 sizeof(uicc_appl_cmd_file_info_EFANR_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_file_info_general_transparent_SIM_resp,
+	 sizeof(uicc_appl_cmd_file_info_general_transparent_SIM_resp),
+	 NULL,
+	 uicc_appl_cmd_file_info_general_transparent_SIM_req,
+	 sizeof(uicc_appl_cmd_file_info_general_transparent_SIM_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_file_info_general_transparent_resp,
+	 sizeof(uicc_appl_cmd_file_info_general_transparent_resp),
+	 NULL,
+	 uicc_appl_cmd_file_info_general_transparent_req,
+	 sizeof(uicc_appl_cmd_file_info_general_transparent_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_transparent_response,
+	 sizeof(uicc_appl_cmd_transparent_response),
+	 NULL,
+	 uicc_appl_cmd_transparent_req,
+	 sizeof(uicc_appl_cmd_transparent_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_linear_fixed_EFPBR1_response,
+	 sizeof(uicc_appl_cmd_linear_fixed_EFPBR1_response),
+	 NULL,
+	 uicc_appl_cmd_linear_fixed_EFPBR1_req,
+	 sizeof(uicc_appl_cmd_linear_fixed_EFPBR1_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_linear_fixed_EFPBR2_response,
+	 sizeof(uicc_appl_cmd_linear_fixed_EFPBR2_response),
+	 NULL,
+	 uicc_appl_cmd_linear_fixed_EFPBR2_req,
+	 sizeof(uicc_appl_cmd_linear_fixed_EFPBR2_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_linear_fixed_ADN1_response,
+	 sizeof(uicc_appl_cmd_linear_fixed_ADN1_response),
+	 NULL,
+	 uicc_appl_cmd_linear_fixed_ADN1_SIM_req,
+	 sizeof(uicc_appl_cmd_linear_fixed_ADN1_SIM_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_linear_fixed_ADN2_response,
+	 sizeof(uicc_appl_cmd_linear_fixed_ADN2_response),
+	 NULL,
+	 uicc_appl_cmd_linear_fixed_ADN2_SIM_req,
+	 sizeof(uicc_appl_cmd_linear_fixed_ADN2_SIM_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_linear_fixed_ADN3_response,
+	 sizeof(uicc_appl_cmd_linear_fixed_ADN3_response),
+	 NULL,
+	 uicc_appl_cmd_linear_fixed_ADN3_req,
+	 sizeof(uicc_appl_cmd_linear_fixed_ADN3_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_linear_fixed_ADN4_response,
+	 sizeof(uicc_appl_cmd_linear_fixed_ADN4_response),
+	 NULL,
+	 uicc_appl_cmd_linear_fixed_ADN4_req,
+	 sizeof(uicc_appl_cmd_linear_fixed_ADN4_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_linear_fixed_ADN5_response,
+	 sizeof(uicc_appl_cmd_linear_fixed_ADN5_response),
+	 NULL,
+	 uicc_appl_cmd_linear_fixed_ADN5_req,
+	 sizeof(uicc_appl_cmd_linear_fixed_ADN5_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_linear_fixed_ADNx_response,
+	 sizeof(uicc_appl_cmd_linear_fixed_ADNx_response),
+	 NULL,
+	 uicc_appl_cmd_linear_fixed_ADNx_SIM_req,
+	 sizeof(uicc_appl_cmd_linear_fixed_ADNx_SIM_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_linear_fixed_ADN1_response,
+	 sizeof(uicc_appl_cmd_linear_fixed_ADN1_response),
+	 NULL,
+	 uicc_appl_cmd_linear_fixed_ADN1_req,
+	 sizeof(uicc_appl_cmd_linear_fixed_ADN1_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_linear_fixed_ADN2_response,
+	 sizeof(uicc_appl_cmd_linear_fixed_ADN2_response),
+	 NULL,
+	 uicc_appl_cmd_linear_fixed_ADN2_req,
+	 sizeof(uicc_appl_cmd_linear_fixed_ADN2_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_linear_fixed_ADNx_response,
+	 sizeof(uicc_appl_cmd_linear_fixed_ADNx_response),
+	 NULL,
+	 uicc_appl_cmd_linear_fixed_ADNx_req,
+	 sizeof(uicc_appl_cmd_linear_fixed_ADNx_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_linear_fixed_EFMSISDN_response,
+	 sizeof(uicc_appl_cmd_linear_fixed_EFMSISDN_response),
+	 NULL,
+	 uicc_appl_cmd_linear_fixed_EFMSISDN_req,
+	 sizeof(uicc_appl_cmd_linear_fixed_EFMSISDN_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_linear_fixed_EXT1_response,
+	 sizeof(uicc_appl_cmd_linear_fixed_EXT1_response),
+	 NULL,
+	 uicc_appl_cmd_linear_fixed_EXT1_req,
+	 sizeof(uicc_appl_cmd_linear_fixed_EXT1_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_linear_fixed_EXT1_response,
+	 sizeof(uicc_appl_cmd_linear_fixed_EXT1_response),
+	 NULL,
+	 uicc_appl_cmd_linear_fixed_EXT1_SIM_req,
+	 sizeof(uicc_appl_cmd_linear_fixed_EXT1_SIM_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_linear_fixed_EXT3_response,
+	 sizeof(uicc_appl_cmd_linear_fixed_EXT3_response),
+	 NULL,
+	 uicc_appl_cmd_linear_fixed_EXT3_req,
+	 sizeof(uicc_appl_cmd_linear_fixed_EXT3_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_linear_fixed_EXT3_response,
+	 sizeof(uicc_appl_cmd_linear_fixed_EXT3_response),
+	 NULL,
+	 uicc_appl_cmd_linear_fixed_EXT3_SIM_req,
+	 sizeof(uicc_appl_cmd_linear_fixed_EXT3_SIM_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_linear_fixed_EFEMAIL_response,
+	 sizeof(uicc_appl_cmd_linear_fixed_EFEMAIL_response),
+	 NULL,
+	 uicc_appl_cmd_linear_fixed_EFEMAIL_req,
+	 sizeof(uicc_appl_cmd_linear_fixed_EFEMAIL_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_linear_fixed_EFSNE_resp,
+	 sizeof(uicc_appl_cmd_linear_fixed_EFSNE_resp),
+	 NULL,
+	 uicc_appl_cmd_linear_fixed_EFSNE_req,
+	 sizeof(uicc_appl_cmd_linear_fixed_EFSNE_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_linear_fixed_EFANR_response,
+	 sizeof(uicc_appl_cmd_linear_fixed_EFANR_response),
+	 NULL,
+	 uicc_appl_cmd_linear_fixed_EFANR_req,
+	 sizeof(uicc_appl_cmd_linear_fixed_EFANR_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_linear_fixed_response,
+	 sizeof(uicc_appl_cmd_linear_fixed_response),
+	 NULL,
+	 uicc_appl_cmd_linear_fixed_req,
+	 sizeof(uicc_appl_cmd_linear_fixed_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_cyclic_response,
+	 sizeof(uicc_appl_cmd_cyclic_response),
+	 NULL,
+	 uicc_appl_cmd_cyclic_req,
+	 sizeof(uicc_appl_cmd_cyclic_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_transparent_write_resp,
+	 sizeof(uicc_appl_cmd_transparent_write_resp),
+	 NULL,
+	 uicc_appl_cmd_transparent_write_req,
+	 sizeof(uicc_appl_cmd_transparent_write_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_linear_fixed_write_resp,
+	 sizeof(uicc_appl_cmd_linear_fixed_write_resp),
+	 NULL,
+	 uicc_appl_cmd_linear_fixed_write_req,
+	 sizeof(uicc_appl_cmd_linear_fixed_write_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_APPL_CMD_REQ,
+	 uicc_appl_cmd_cyclic_write_resp,
+	 sizeof(uicc_appl_cmd_cyclic_write_resp),
+	 NULL,
+	 uicc_appl_cmd_cyclic_write_req,
+	 sizeof(uicc_appl_cmd_cyclic_write_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_PIN_REQ,
+	 uicc_pin_verify_resp,
+	 sizeof(uicc_pin_verify_resp),
+	 uicc_ind_startup_complete,
+	 uicc_pin_verify_req,
+	 sizeof(uicc_pin_verify_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_PIN_REQ,
+	 uicc_pin_enable_resp,
+	 sizeof(uicc_pin_enable_resp),
+	 NULL,
+	 uicc_pin_enable_req,
+	 sizeof(uicc_pin_enable_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_PIN_REQ,
+	 uicc_pin_disable_resp,
+	 sizeof(uicc_pin_disable_resp),
+	 NULL,
+	 uicc_pin_disable_req,
+	 sizeof(uicc_pin_disable_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_PIN_REQ,
+	 uicc_pin_reset_resp,
+	 sizeof(uicc_pin_reset_resp),
+	 uicc_pin1_ind_pin_required,
+	 uicc_pin_reset_req,
+	 sizeof(uicc_pin_reset_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_PIN_REQ,
+	 uicc_pin_change_resp,
+	 sizeof(uicc_pin_change_resp),
+	 NULL,
+	 uicc_pin_change_req,
+	 sizeof(uicc_pin_change_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_PIN_REQ,
+	 uicc_pin_query_resp,
+	 sizeof(uicc_pin_query_resp),
+	 NULL,
+	 uicc_pin_query_req,
+	 sizeof(uicc_pin_query_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_PIN_REQ,
+	 uicc_pin_prompt_resp,
+	 sizeof(uicc_pin_prompt_resp),
+	 NULL,
+	 uicc_pin_prompt_req,
+	 sizeof(uicc_pin_prompt_req) / 2}
+	,
+	{
+	 PN_UICC, UICC_SIMLOCK_REQ,
+	 uicc_simlock_query_resp,
+	 sizeof(uicc_simlock_query_resp),
+	 NULL,
+	 uicc_simlock_query_req,
+	 sizeof(uicc_simlock_query_req) / 2}
+	,
+
+	/*CALL messages */
+	{
+	 PN_MODEM_CALL, CALL_MODEM_STATUS_REQ,
+	 call_modem_status_resp_msg,
+	 sizeof(call_modem_status_resp_msg),
+	 NULL}
+	,
+	{
+	 PN_MODEM_CALL, CALL_MODEM_CREATE_REQ,
+	 call_modem_create_resp_msg2,
+	 sizeof(call_modem_create_resp_msg2),
+	 call_modem_status_ind_idle_msg}
+	,
+	{
+	 PN_MODEM_CALL, -1,
+	 call_modem_status_ind_idle_msg,
+	 sizeof(call_modem_status_ind_idle_msg),
+	 call_modem_status_ind_create_msg2}
+	,
+	{
+	 PN_MODEM_CALL, -1,
+	 call_modem_status_ind_create_msg2,
+	 sizeof(call_modem_status_ind_create_msg2),
+	 call_modem_status_ind_proceeding_msg2}
+	,
+	{
+	 PN_MODEM_CALL, -1,
+	 call_modem_status_ind_proceeding_msg2,
+	 sizeof(call_modem_status_ind_proceeding_msg2),
+	 call_modem_status_ind_mo_alert_msg2}
+	,
+	{
+	 PN_MODEM_CALL, -1,
+	 call_modem_status_ind_mo_alert_msg2,
+	 sizeof(call_modem_status_ind_mo_alert_msg2),
+	 call_modem_status_ind_active_msg2}
+	,
+	{
+	 PN_MODEM_CALL, -1,
+	 call_modem_status_ind_active_msg2,
+	 sizeof(call_modem_status_ind_active_msg2),
+	 call_modem_control_ind_msg}
+	,
+	{
+	 PN_MODEM_CALL, CALL_MODEM_RELEASE_REQ,
+	 call_modem_relese_resp_waiting_msg,
+	 sizeof(call_modem_relese_resp_waiting_msg),
+	 call_modem_status_ind_idle_msg,
+	 call_modem_relese_req_waiting_msg,
+	 sizeof(call_modem_relese_req_waiting_msg) / 2}
+	,
+	{
+	 PN_MODEM_CALL, CALL_MODEM_RELEASE_REQ,
+	 call_modem_release_resp_msg2,
+	 sizeof(call_modem_release_resp_msg2),
+	 call_modem_status_ind_mo_release_msg2}
+	,
+	{
+	 PN_MODEM_CALL, -1,
+	 call_modem_status_ind_mo_release_msg2,
+	 sizeof(call_modem_status_ind_mo_release_msg2),
+	 call_modem_status_ind_idle_msg2}
+	,
+	{
+	 PN_MODEM_CALL, -1,
+	 call_modem_status_ind_idle_msg2,
+	 sizeof(call_modem_status_ind_idle_msg2),
+	 call_modem_status_ind_mt_release_msg3}
+	,
+	{
+	 PN_MODEM_CALL, CALL_MODEM_CONTROL_REQ,
+	 call_modem_control_resp_hold_msg,
+	 sizeof(call_modem_control_resp_hold_msg),
+	 call_modem_status_ind_hold_init_msg3,
+	 call_modem_control_req_hold_msg,
+	 sizeof(call_modem_control_req_hold_msg) / 2}
+	,
+	{
+	 PN_MODEM_CALL, CALL_MODEM_CONTROL_REQ,
+	 call_modem_control_resp_retr_msg,
+	 sizeof(call_modem_control_resp_retr_msg),
+	 call_modem_status_ind_active_msg3,
+	 call_modem_control_req_retr_msg,
+	 sizeof(call_modem_control_req_retr_msg) / 2}
+	,
+	{
+	 PN_MODEM_CALL, CALL_MODEM_CONTROL_REQ,
+	 call_modem_control_resp_swap_msg,
+	 sizeof(call_modem_control_resp_swap_msg),
+	 call_modem_status_ind_hold_msg2,
+	 call_modem_control_req_swap_msg,
+	 sizeof(call_modem_control_req_swap_msg) / 2}
+	,
+	{
+	 PN_MODEM_CALL, CALL_MODEM_CONTROL_REQ,
+	 call_modem_control_resp_transfer_msg,
+	 sizeof(call_modem_control_resp_transfer_msg),
+	 call_modem_control_ind_error_msg,
+	 call_modem_control_req_transfer_msg,
+	 sizeof(call_modem_control_req_transfer_msg) / 2}
+	,
+	{
+	 PN_MODEM_CALL, CALL_MODEM_CONTROL_REQ,
+	 call_modem_control_resp_conf_build_msg,
+	 sizeof(call_modem_control_resp_conf_build_msg),
+	 call_modem_status_ind_active_msg2,
+	 call_modem_control_req_conf_build_msg,
+	 sizeof(call_modem_control_req_conf_build_msg) / 2}
+	,
+	{
+	 PN_MODEM_CALL, CALL_MODEM_CONTROL_REQ,
+	 call_modem_control_resp_pri_chat_msg,
+	 sizeof(call_modem_control_resp_pri_chat_msg),
+	 call_modem_status_ind_hold_msg3,
+	 call_modem_control_req_pri_chat_msg,
+	 sizeof(call_modem_control_req_pri_chat_msg) / 2}
+	,
+	{
+	 PN_MODEM_CALL, -1,
+	 call_modem_status_ind_hold_init_msg3,
+	 sizeof(call_modem_status_ind_hold_init_msg3),
+	 call_modem_status_ind_hold_msg3}
+	,
+	{
+	 PN_MODEM_CALL, -1,
+	 call_modem_status_ind_hold_msg3,
+	 sizeof(call_modem_status_ind_hold_msg3),
+	 call_modem_control_ind_msg}
+	,
+	{
+	 PN_MODEM_CALL, -1,
+	 call_modem_status_ind_hold_msg2,
+	 sizeof(call_modem_status_ind_hold_msg2),
+	 call_modem_status_ind_active_msg3}
+	,
+	{
+	 PN_MODEM_CALL, CALL_MODEM_STATUS_IND,
+	 call_modem_status_ind_coming_msg3,
+	 sizeof(call_modem_status_ind_coming_msg3),
+	 call_modem_status_ind_proceeding_msg3}
+	,
+	{
+	 PN_MODEM_CALL, -1,
+	 call_modem_status_ind_proceeding_msg3,
+	 sizeof(call_modem_status_ind_proceeding_msg3),
+	 call_modem_status_ind_mt_alerting_msg3}
+	,
+	{
+	 PN_MODEM_CALL, -1,
+	 call_modem_status_ind_mt_alerting_msg3,
+	 sizeof(call_modem_status_ind_mt_alerting_msg3),
+	 NULL}
+	,
+	{
+	 PN_MODEM_CALL, CALL_MODEM_ANSWER_REQ,
+	 call_modem_answer_resp_msg3,
+	 sizeof(call_modem_answer_resp_msg3),
+	 call_modem_status_ind_answered_msg3}
+	,
+	{
+	 PN_MODEM_CALL, -1,
+	 call_modem_status_ind_answered_msg3,
+	 sizeof(call_modem_status_ind_answered_msg3),
+	 call_modem_status_ind_active_msg3}
+	,
+	{
+	 PN_MODEM_CALL, -1,
+	 call_modem_status_ind_active_msg3,
+	 sizeof(call_modem_status_ind_active_msg3),
+	 call_modem_control_ind_msg}
+	,
+	{
+	 PN_MODEM_CALL, -1,
+	 call_modem_status_ind_mt_release_msg3,
+	 sizeof(call_modem_status_ind_mt_release_msg3),
+	 call_modem_status_ind_idle_msg3}
+	,
+	{
+	 PN_MODEM_CALL, -1,
+	 call_modem_status_ind_idle_msg3,
+	 sizeof(call_modem_status_ind_idle_msg3),
+	 NULL}
+	,
+	{
+	 PN_MODEM_CALL, CALL_MODEM_DTMF_SEND_REQ,
+	 call_modem_dtmf_send_resp_msg2,
+	 sizeof(call_modem_dtmf_send_resp_msg2),
+	 call_modem_status_ind_hold_msg2multi}
+	,
+	{
+	 PN_MODEM_CALL, -1,
+	 call_modem_status_ind_hold_msg2multi,
+	 sizeof(call_modem_status_ind_hold_msg2multi),
+	 call_modem_status_ind_hold_msg3}
+	,
+	{
+	 PN_MODEM_CALL, -1,
+	 call_modem_control_ind_msg,
+	 sizeof(call_modem_control_ind_msg),
+	 NULL}
+	,
+	{
+	 PN_MODEM_CALL, -1,
+	 call_modem_control_ind_error_msg,
+	 sizeof(call_modem_control_ind_error_msg),
+	 call_modem_status_ind_waiting_msg}
+	,
+	{
+	 PN_MODEM_CALL, CALL_MODEM_NOTIFICATION_IND,
+	 call_modem_notification_ind_test,
+	 sizeof(call_modem_notification_ind_test),
+	 call_modem_notification_ind_barring_inc}
+	,
+	{
+	 PN_MODEM_CALL, -1,
+	 call_modem_notification_ind_barring_inc,
+	 sizeof(call_modem_notification_ind_barring_inc),
+	 call_modem_notification_ind_barring_out}
+	,
+	{
+	 PN_MODEM_CALL, -1,
+	 call_modem_notification_ind_barring_out,
+	 sizeof(call_modem_notification_ind_barring_out),
+	 call_modem_notification_ind_forwarding_uncond}
+	,
+	{
+	 PN_MODEM_CALL, -1,
+	 call_modem_notification_ind_forwarding_uncond,
+	 sizeof(call_modem_notification_ind_forwarding_uncond),
+	 call_modem_notification_ind_forwarding_cond}
+	,
+	{
+	 PN_MODEM_CALL, -1,
+	 call_modem_notification_ind_forwarding_cond,
+	 sizeof(call_modem_notification_ind_forwarding_cond),
+	 call_modem_notification_ind_call_hold}
+	,
+	{
+	 PN_MODEM_CALL, -1,
+	 call_modem_notification_ind_call_hold,
+	 sizeof(call_modem_notification_ind_call_hold),
+	 call_modem_notification_ind_mpty}
+	,
+	{
+	 PN_MODEM_CALL, -1,
+	 call_modem_notification_ind_mpty,
+	 sizeof(call_modem_notification_ind_mpty),
+	 call_modem_notification_ind_cug_call}
+	,
+	{
+	 PN_MODEM_CALL, -1,
+	 call_modem_notification_ind_cug_call,
+	 sizeof(call_modem_notification_ind_cug_call),
+	 NULL}
+	,
+	{
+	 PN_MODEM_CALL, -1,
+	 call_modem_status_ind_waiting_msg,
+	 sizeof(call_modem_status_ind_waiting_msg),
+	 NULL}
+	,
+
+	/* INFO messages */
+	{
+	 PN_MODEM_INFO, M_INFO_VERSION_READ_REQ,
+	 version_info_query_resp_ok,
+	 sizeof(version_info_query_resp_ok),
+	 NULL}
+	,
+
+	/*SMS messages */
+	/* Receive */
+	{
+	 PN_SMS, SMS_RECEIVED_MSG_IND,
+	 sms_received_incorrect_msg_ind,
+	 sizeof(sms_received_incorrect_msg_ind),
+	 sms_received_msg_ind}
+	,
+	{
+	 PN_SMS, -1,
+	 sms_received_msg_ind,
+	 sizeof(sms_received_msg_ind)
+	 }
+	,
+
+	{
+	 PN_SMS, SMS_RECEIVE_MESSAGE_REQ,
+	 sms_receive_message_resp_active,
+	 sizeof(sms_receive_message_resp_active)
+	 }
+	,
+	{
+	 PN_SMS, SMS_RECEIVED_MSG_REPORT_REQ,
+	 sms_received_msg_report_resp_fail,
+	 sizeof(sms_received_msg_report_resp_fail)
+	 }
+	,
+	/* Send */
+	{
+	 PN_SMS, SMS_MESSAGE_SEND_REQ,
+	 sms_message_send_resp_fail,
+	 sizeof(sms_message_send_resp_fail)
+	 }
+	,
+	/* SETTINGS_UPDATE */
+	{
+	 PN_SMS, SMS_SETTINGS_UPDATE_REQ,
+	 sms_settings_update_resp_false,
+	 sizeof(sms_settings_update_resp_false)
+	 }
+	,
+	/* Route settings query */
+	{
+	 PN_SMS, SMS_SETTINGS_READ_REQ,
+	 sms_settings_read_resp_cs_only,
+	 sizeof(sms_settings_read_resp_cs_only)
+	 }
+	,
+
+	 /*CBS*/ {
+		  PN_SMS, SMS_CB_ROUTING_REQ,
+		  req_cbs_routing_resp,
+		  sizeof(req_cbs_routing_resp),
+		  sms_received_cbs_msg_ind,
+		  }
+	,
+	/*Receive cbs */
+	{
+	 PN_SMS, -1,
+	 sms_received_cbs_msg_ind,
+	 sizeof(sms_received_cbs_msg_ind),
+	 NULL}
+	,
+
+	/*Advanced voice calls */
+	/*Call forwarding */
+	{
+	 PN_SS, SS_SERVICE_REQ,
+	 call_forward_query_resp_forw,
+	 sizeof(call_forward_query_resp_forw),
+	 NULL,
+	 req_query_forw,
+	 sizeof(req_query_forw) / 2}
+	,
+	{
+	 PN_SS, SS_SERVICE_REQ,
+	 call_forward_query_resp_A0,
+	 sizeof(call_forward_query_resp_A0),
+	 NULL,
+	 req_query_forw_A0,
+	 sizeof(req_query_forw_A0) / 2}
+	,
+	{
+	 PN_SS, SS_SERVICE_REQ,
+	 call_forward_query_resp_B0,
+	 sizeof(call_forward_query_resp_B0),
+	 NULL,
+	 req_query_forw_B0,
+	 sizeof(req_query_forw_B0) / 2}
+	,
+	{
+	 PN_SS, SS_SERVICE_REQ,
+	 call_forward_query_resp_C0,
+	 sizeof(call_forward_query_resp_C0),
+	 NULL,
+	 req_query_forw_C0,
+	 sizeof(req_query_forw_C0) / 2}
+	,
+	{
+	 PN_SS, SS_SERVICE_REQ,
+	 call_forward_query_resp_D0,
+	 sizeof(call_forward_query_resp_D0),
+	 NULL,
+	 req_query_forw_D0,
+	 sizeof(req_query_forw_D0) / 2}
+	,
+	{
+	 PN_SS, SS_SERVICE_REQ,
+	 call_forward_query_resp_erase,
+	 sizeof(call_forward_query_resp_erase),
+	 NULL,
+	 req_query_forw_erase,
+	 sizeof(req_query_forw_erase) / 2}
+	,
+	{
+	 PN_SS, SS_SERVICE_REQ,
+	 call_forward_query_resp_erase_A0,
+	 sizeof(call_forward_query_resp_erase_A0),
+	 NULL,
+	 req_query_forw_erase_A0,
+	 sizeof(req_query_forw_erase_A0) / 2}
+	,
+	{
+	 PN_SS, SS_SERVICE_REQ,
+	 call_forward_query_resp_erase_B0,
+	 sizeof(call_forward_query_resp_erase_B0),
+	 NULL,
+	 req_query_forw_erase_B0,
+	 sizeof(req_query_forw_erase_B0) / 2}
+	,
+	{
+	 PN_SS, SS_SERVICE_REQ,
+	 forw_no_reply_set_resp,
+	 sizeof(forw_no_reply_set_resp),
+	 NULL,
+	 forw_no_reply_set_req,
+	 sizeof(forw_no_reply_set_req) / 2}
+	,
+	{
+	 PN_SS, SS_SERVICE_REQ,
+	 forw_uncond_set_resp,
+	 sizeof(forw_uncond_set_resp),
+	 NULL,
+	 forw_uncond_set_req,
+	 sizeof(forw_uncond_set_req) / 2}
+	,
+	{
+	 PN_SS, SS_GSM_USSD_SEND_REQ,
+	 req_ussd_init_resp,
+	 sizeof(req_ussd_init_resp),
+	 req_ussd_init_ind,
+	 req_ussd_init,
+	 sizeof(req_ussd_init) / 2}
+	,
+	{
+	 PN_SS, -1,
+	 req_ussd_init_ind,
+	 sizeof(req_ussd_init_ind),
+	 NULL,
+	 NULL,
+	 0}
+	,
+	{
+	 PN_SS, SS_GSM_USSD_SEND_REQ,
+	 req_ussd_cancel_resp,
+	 sizeof(req_ussd_cancel_resp),
+	 NULL,
+	 req_ussd_cancel,
+	 sizeof(req_ussd_cancel) / 2}
+	,
+
+	/*Call Barring */
+	{
+	 PN_SS, SS_SERVICE_REQ,
+	 call_barring_query_resp_AO,
+	 sizeof(call_barring_query_resp_AO),
+	 NULL,
+	 req_query_AO,
+	 sizeof(req_query_AO) / 2}
+	,
+	/* ISIMODEM2.5 messages */
+	{
+	 PN_SS, SS_SERVICE_REQ,
+	 call_barring_query_resp_AO,
+	 sizeof(call_barring_query_resp_AO),
+	 NULL,
+	 req_query_AO,
+	 sizeof(req_query_AO) / 2}
+	,
+	{
+	 PN_SS, SS_SERVICE_REQ,
+	 call_barring_query_resp_OI,
+	 sizeof(call_barring_query_resp_OI),
+	 NULL, req_query_OI,
+	 sizeof(req_query_OI) / 2}
+	,
+	{
+	 PN_SS, SS_SERVICE_REQ,
+	 call_barring_query_resp_OX,
+	 sizeof(call_barring_query_resp_OX),
+	 NULL,
+	 req_query_OX,
+	 sizeof(req_query_OX) / 2}
+	,
+	{
+	 PN_SS, SS_SERVICE_REQ,
+	 call_barring_query_resp_AI,
+	 sizeof(call_barring_query_resp_AI),
+	 NULL,
+	 req_query_AI,
+	 sizeof(req_query_AI) / 2}
+	,
+	{
+	 PN_SS, SS_SERVICE_REQ,
+	 call_barring_query_resp_IR,
+	 sizeof(call_barring_query_resp_IR),
+	 NULL,
+	 req_query_IR,
+	 sizeof(req_query_IR) / 2}
+	,
+	{
+	 PN_SS, SS_SERVICE_REQ,
+	 call_barring_disable_all_in_msg,
+	 sizeof(call_barring_disable_all_in_msg),
+	 NULL,
+	 req_disable_all_in,
+	 sizeof(req_disable_all_in) / 2}
+	,
+	{
+	 PN_SS, SS_SERVICE_REQ,
+	 call_barring_disable_all_out_msg,
+	 sizeof(call_barring_disable_all_out_msg),
+	 NULL,
+	 req_disable_all_out,
+	 sizeof(req_disable_all_out) / 2}
+	,
+	{
+	 PN_SS, SS_SERVICE_REQ,
+	 call_barring_enable_all_in_msg,
+	 sizeof(call_barring_enable_all_in_msg),
+	 NULL,
+	 req_enable_all_in,
+	 sizeof(req_enable_all_in) / 2}
+	,
+	{
+	 PN_SS, SS_SERVICE_REQ,
+	 call_barring_enable_all_out_msg,
+	 sizeof(call_barring_enable_all_out_msg),
+	 NULL,
+	 req_enable_all_out,
+	 sizeof(req_enable_all_out) / 2}
+	,
+	{
+	 PN_SS, SS_SERVICE_REQ,
+	 req_change_cb_password_msg,
+	 sizeof(req_change_cb_password_msg),
+	 NULL,
+	 req_change_cb_password,
+	 sizeof(req_change_cb_password) / 2}
+	,
+	/*Call waiting */
+	{
+	 PN_SS, SS_SERVICE_REQ,
+	 call_waiting_query_resp,
+	 sizeof(call_waiting_query_resp),
+	 NULL, req_query_cw,
+	 sizeof(req_query_cw) / 2}
+	,
+	{
+	 PN_SS, SS_SERVICE_REQ,
+	 call_waiting_query_resp_A0,
+	 sizeof(call_waiting_query_resp_A0),
+	 NULL,
+	 req_query_cw_A0,
+	 sizeof(req_query_cw_A0) / 2}
+	,
+	{
+	 PN_SS, SS_SERVICE_REQ,
+	 call_waiting_query_resp_B0,
+	 sizeof(call_waiting_query_resp_B0),
+	 NULL,
+	 req_query_cw_B0,
+	 sizeof(req_query_cw_B0) / 2}
+	,
+	 /*CLIP*/ {
+		   PN_SS, SS_SERVICE_REQ,
+		   clip_query_resp,
+		   sizeof(clip_query_resp),
+		   NULL,
+		   req_query_clip,
+		   sizeof(req_query_clip) / 2}
+	,
+	 /*CLIR*/ {
+		   PN_SS, SS_SERVICE_REQ,
+		   clir_query_resp,
+		   sizeof(clir_query_resp),
+		   NULL,
+		   req_query_clir,
+		   sizeof(req_query_clir) / 2}
+	,
+	 /*COLP*/ {
+		   PN_SS, SS_SERVICE_REQ,
+		   colp_query_resp,
+		   sizeof(colp_query_resp),
+		   NULL,
+		   req_query_colp,
+		   sizeof(req_query_colp) / 2}
+	,
+	 /*COLR*/ {
+		   PN_SS, SS_SERVICE_REQ,
+		   colr_query_resp,
+		   sizeof(colr_query_resp),
+		   NULL,
+		   req_query_colr,
+		   sizeof(req_query_colr) / 2}
+	,
+};
+
+static void ChangeResponses()
+{
+	fakeresps[0].response =3D uicc_app_list_fail_resp;
+	fakeresps[0].len =3D sizeof(uicc_app_list_fail_resp);
+}
diff --git a/drivers/isimodem2.5/sms.c b/drivers/isimodem2.5/sms.c
new file mode 100644
index 0000000..e9c2a79
--- /dev/null
+++ b/drivers/isimodem2.5/sms.c
@@ -0,0 +1,869 @@
+/*
+ * This file is part of oFono - Open Source Telephony
+ *
+ * Copyright (C) 2009 Nokia Corporation and/or its subsidiary(-ies).
+ * Copyright (C) ST-Ericsson SA 2010.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <inttypes.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/uio.h>
+
+#include <gisi/client.h>
+#include <gisi/iter.h>
+
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/sms.h>
+
+#include <glib.h>
+
+#include "debug.h"
+#include "isimodem.h"
+#include "isiutil.h"
+#include "sms.h"
+#include "smsutil.h"
+#include "timeout.h"
+#include "uicc_interface.h"
+
+struct sms_data {
+	GIsiClient *client;
+};
+
+struct sms_sca_data {
+	struct ofono_phone_number sca;
+};
+struct sms_sca_data *new_sca;
+
+int alpha_identifier =3D -1;
+int mf_path =3D 0x3F00;
+int df_path =3D 0x7F10;
+int df_len =3D 4;
+const unsigned char SMS_STATUS_REPORT =3D 0x02;
+GIsiClient *pn_sms_client;
+
+static void isi_sca_set(struct ofono_sms *sms,
+			const struct ofono_phone_number *sca,
+			ofono_sms_sca_set_cb_t cb, void *user_data);
+
+static gboolean handle_failure(ofono_sms_sca_query_cb_t cb,
+					struct isi_cb_data *cbd)
+{
+	if (!new_sca)
+		CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
+	else
+		CALLBACK_WITH_FAILURE(cb, cbd->data, NULL);
+
+	g_free(cbd);
+	g_free(new_sca);
+	new_sca =3D NULL;
+	return TRUE;
+}
+
+static gboolean isi_sca_query_cb(GIsiClient *client, const void *restrict =
data,
+							size_t len,
+							uint16_t object,
+							void *opaque)
+{
+	const uint8_t *msg =3D data;
+	struct isi_cb_data *cbd =3D opaque;
+	ofono_sms_sca_query_cb_t cb =3D cbd->cb;
+	struct ofono_phone_number sca;
+	const uint8_t *bcd;
+	uint8_t bcd_len;
+
+	DBG("");
+
+	if (!msg) {
+		DBG("ISI client error: %d", g_isi_client_error(client));
+		return handle_failure(cb, cbd);
+	}
+
+	if (msg[0] !=3D UICC_APPL_CMD_RESP
+			|| msg[1] !=3D UICC_APPL_READ_LINEAR_FIXED) {
+		return FALSE;
+	}
+
+	if ((msg[2] !=3D UICC_STATUS_OK) || (msg[6] =3D=3D 0))
+		return handle_failure(cb, cbd);
+	else {
+		GIsiSubBlockIter iter;
+		uint32_t data_len =3D 0;
+
+		g_isi_sb_iter_init_full(&iter, msg, len, 7, TRUE, msg[7]);
+
+		if (g_isi_sb_iter_get_id(&iter) =3D=3D UICC_SB_FILE_DATA)
+			g_isi_sb_iter_get_dword(&iter, &data_len, 4);
+
+		if (data_len < 28)
+			return handle_failure(cb, cbd);
+
+		/*y is alphaidentifier see 3GPP TS 31.102*/
+		alpha_identifier =3D data_len - 28;
+
+		/*if TS=E2=80=91Service Centre Address absent*/
+		if (msg[14 + alpha_identifier + 1] & 0x2)
+			return handle_failure(cb, cbd);
+
+		/*the beginning of TS-SCA */
+		bcd =3D msg + 14 + alpha_identifier + 1 + 12 + 1;
+		bcd_len =3D bcd[0];
+
+		if (bcd_len <=3D 1 || bcd_len > 12)
+			return handle_failure(cb, cbd);
+
+		extract_bcd_number(bcd + 2, bcd_len - 1, sca.number);
+		sca.type =3D bcd[1];
+
+		if (new_sca) {
+			isi_sca_set(cbd->user, &new_sca->sca,
+					(ofono_sms_sca_set_cb_t)cbd->cb,
+								cbd->data);
+			g_free(cbd);
+			return TRUE;
+		}
+
+		CALLBACK_WITH_SUCCESS(cb, &sca, cbd->data);
+		g_free(cbd);
+		return TRUE;
+	}
+}
+static void isi_sca_query(struct ofono_sms *sms, ofono_sms_sca_query_cb_t =
cb,
+				void *user_data)
+{
+	int8_t app_id =3D -1;
+	uint8_t client_id =3D 0;
+	int app_type =3D -1;
+	struct isi_cb_data *cbd =3D isi_cb_data_new(sms, cb, user_data);
+	GIsiClient *uicc_client =3D read_pn_uicc_client();
+
+	DBG("");
+	app_id =3D get_app_id();
+	app_type =3D get_app_type() ;
+	client_id =3D get_client_id();
+
+	if ((app_id =3D=3D -1) || !client_id || !uicc_client || !cbd) {
+		if (!new_sca)
+			CALLBACK_WITH_FAILURE(cb, NULL, user_data);
+		else
+			CALLBACK_WITH_FAILURE(cb, user_data, NULL);
+
+		g_free(cbd);
+		g_free(new_sca);
+		new_sca =3D NULL;
+		return;
+	}
+
+	DBG("app_id: %04X", app_id);
+	DBG("client_id: %04X", client_id);
+
+	if (app_type =3D=3D UICC_APPL_TYPE_UICC_USIM)
+		df_path =3D 0x7FFF;
+	else
+		df_path =3D 0x7F10;
+
+	if (cbd) {
+		uint8_t msg[] =3D {
+			UICC_APPL_CMD_REQ,
+			UICC_APPL_READ_LINEAR_FIXED,
+			app_id,
+			UICC_SESSION_ID_NOT_USED,
+			0, 0, /*fillers*/
+			3, /*nro of sub blocks*/
+
+			UICC_SB_CLIENT >> 8, /*1st subblock*/
+			UICC_SB_CLIENT & 0xFF,
+			0,/*subblock length*/
+			8,/*subblock length*/
+			0, 0, 0,/*fillers*/
+			client_id,
+
+			UICC_SB_APPL_PATH >> 8,/*2nd subblock*/
+			UICC_SB_APPL_PATH & 0xFF,
+			0,/*subblock length*/
+			16,/*subblock length*/
+			0x6F42 >> 8,/*Elementary file ID for EFsmsp*/
+			0x6F42 & 0xFF,
+			UICC_SFI_NOT_PRESENT,
+			0,/*filler*/
+			df_len,/*Path length*/
+			0,/*filler*/
+			mf_path >> 8,/*DF Path MF*/
+			mf_path & 0xFF,
+			df_path >> 8,/*DF Path DFtelecom*/
+			df_path & 0xFF,
+			0, 0,/*fillers 0-3*/
+			UICC_SB_LINEAR_FIXED >> 8,/*3rd subblock*/
+			UICC_SB_LINEAR_FIXED & 0xFF,
+			0,/*subblock length*/
+			8,/*subblock length*/
+			1,/*The record in the file*/
+			0,/*offset 0 =3D=3D beginning of the record*/
+			0,/*data amount 0 =3D=3D until end of record*/
+			0,/*filler*/
+		};
+
+		if (g_isi_request_make(uicc_client, msg, sizeof(msg),
+				SIM_TIMEOUT, isi_sca_query_cb, cbd))
+			return;
+	}
+
+	CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
+	/* No need to free cbd */
+}
+static gboolean sca_set_resp_cb(GIsiClient *client,
+				const void *restrict data, size_t len,
+				uint16_t object, void *opaque)
+{
+	const uint8_t *msg =3D data;
+	struct isi_cb_data *cbd =3D opaque;
+	ofono_sms_sca_set_cb_t cb =3D cbd->cb;
+
+	DBG("");
+
+	if (!msg) {
+		DBG("ISI client error: %d", g_isi_client_error(client));
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+		g_free(cbd);
+		return TRUE;
+	}
+
+	if (msg[0] !=3D UICC_APPL_CMD_RESP
+			|| msg[1] !=3D UICC_APPL_UPDATE_LINEAR_FIXED) {
+		return FALSE;
+	}
+
+	if (msg[2] !=3D UICC_STATUS_OK) {
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+		g_free(cbd);
+		return TRUE;
+	}
+
+	if (new_sca) {
+		g_free(new_sca);
+		new_sca =3D NULL;
+	}
+
+	CALLBACK_WITH_SUCCESS(cb, cbd->data);
+	g_free(cbd);
+	return TRUE;
+}
+static void isi_sca_set(struct ofono_sms *sms,
+			const struct ofono_phone_number *sca,
+			ofono_sms_sca_set_cb_t cb, void *user_data)
+{
+	DBG("");
+	DBG("original sca: %04X", (unsigned int) strlen(sca->number));
+
+	if (alpha_identifier < 0) {
+		new_sca =3D g_try_new(struct sms_sca_data,
+					1);
+		if (!new_sca) {
+			CALLBACK_WITH_FAILURE(cb, user_data);
+			return;
+		}
+
+		strncpy(new_sca->sca.number,
+			sca->number, OFONO_MAX_PHONE_NUMBER_LENGTH);
+		new_sca->sca.number[OFONO_MAX_PHONE_NUMBER_LENGTH] =3D '\0';
+
+		new_sca->sca.type =3D sca->type;
+		isi_sca_query(sms, (ofono_sms_sca_query_cb_t)cb, user_data);
+	} else {
+		struct isi_cb_data *cbd =3D isi_cb_data_new(sms, cb, user_data);
+		GIsiClient *uicc_client =3D read_pn_uicc_client();
+		int8_t app_id =3D get_app_id();
+		int8_t client_id =3D get_client_id();
+		int the_length_of_sca =3D 1 + (strlen(sca->number) + 1) / 2;
+		size_t sb_file_data_legth =3D 2 + 2 + 4 + 12;
+		int fillers =3D sb_file_data_legth -
+				(2 + 2 + 4 + the_length_of_sca + 1);
+
+		uint8_t bcd[12];
+
+		DBG("app_id: %04X", app_id);
+		DBG("client_id: %04X", client_id);
+		DBG("sca_length: %04X", the_length_of_sca);
+
+		encode_bcd_number(sca->number, bcd + 2);
+
+		bcd[0] =3D 1 + (strlen(sca->number) + 1) / 2;
+		bcd[1] =3D sca->type;
+
+		if (fillers) {
+			int i;
+			for (i =3D 0; i < fillers; i++)
+				bcd[the_length_of_sca + 1 + i] =3D 0xFF;
+		}
+
+		DBG("sca_length: %04X", the_length_of_sca);
+		DBG("nro fillers: %04X", fillers);
+		DBG("file_data_length: %04X", the_length_of_sca + 1);
+		DBG("bcd: %04X", (unsigned int) sizeof(bcd));
+
+		if ((app_id =3D=3D -1) || (client_id =3D=3D -1) || !uicc_client
+							|| !cbd) {
+
+			CALLBACK_WITH_FAILURE(cb, user_data);
+			g_free(cbd);
+			return;
+		} else {
+
+			uint8_t msg[] =3D {
+				UICC_APPL_CMD_REQ,
+				UICC_APPL_UPDATE_LINEAR_FIXED,
+				app_id,
+				UICC_SESSION_ID_NOT_USED,
+				0, 0, /*fillers*/
+				4, /*nro of sub blocks*/
+		/*1*/
+				UICC_SB_CLIENT >> 8, /*1st subblock*/
+				UICC_SB_CLIENT & 0xFF,
+				0,/*subblock length*/
+				8,/*subblock length*/
+				0, 0, 0,/*fillers*/
+				client_id,
+		/*2*/
+				UICC_SB_LINEAR_FIXED >> 8,/*3rd subblock*/
+				UICC_SB_LINEAR_FIXED & 0xFF,
+				0,/*subblock length*/
+				8,/*subblock length*/
+				1,/*The record in the file*/
+				alpha_identifier + 14-1,/* offset 0 =3D=3D beginning
+							 * of the record
+							 */
+				the_length_of_sca + 1, /* data amount 0
+							* =3D=3D until end of
+							* record
+							*/
+				0,/*filler*/
+		/*3*/
+				UICC_SB_APPL_PATH >> 8,/*2nd subblock*/
+				UICC_SB_APPL_PATH & 0xFF,
+				0,/*subblock length*/
+				16,/*subblock length*/
+				0x6F42 >> 8,/*Elementary file ID for EFsmsp*/
+				0x6F42 & 0xFF,
+				UICC_SFI_NOT_PRESENT,
+				0,/*filler*/
+				df_len,/*Path length*/
+				0,/*filler*/
+				mf_path >> 8,/*DF Path MF*/
+				mf_path & 0xFF,
+				df_path >> 8,/*DF Path DFtelecom*/
+				df_path & 0xFF,
+				0, 0,/*fillers 0-3*/
+		/*4*/
+				UICC_SB_FILE_DATA >> 8,
+				UICC_SB_FILE_DATA & 0xFF,
+				sb_file_data_legth >> 8,
+				sb_file_data_legth & 0xFF,
+				(the_length_of_sca + 1) >> 24,
+				(the_length_of_sca + 1) >> 16,
+				(the_length_of_sca + 1) >> 8,
+				(the_length_of_sca + 1) & 0xFF,
+			};
+
+			struct iovec iov[2] =3D {
+				{ msg, sizeof(msg) },
+				{ bcd, sizeof(bcd) },
+			};
+
+			if (g_isi_request_vmake(uicc_client,
+					iov, 2, SIM_TIMEOUT,
+					sca_set_resp_cb, cbd))
+				return;
+		}
+	}
+}
+static gboolean isi_submit_cb(GIsiClient *client, const void *restrict dat=
a,
+				size_t len, uint16_t object, void *opaque)
+{
+	const unsigned char *msg =3D data;
+	struct isi_cb_data *cbd =3D opaque;
+	ofono_sms_submit_cb_t cb =3D cbd->cb;
+	int msg_reference =3D -1;
+	DBG("");
+
+	if (!msg)
+		goto error;
+
+	if (msg[0] !=3D SMS_MESSAGE_SEND_RESP)
+		return FALSE;
+
+	if (msg[1] =3D=3D SMS_CAUSE_TYPE_COMMON) {
+		if (msg[2] !=3D SMS_OK)
+			goto error;
+		else
+			msg_reference =3D msg[3];
+	}
+
+	if (msg_reference =3D=3D -1)
+		goto error;
+
+	CALLBACK_WITH_SUCCESS(cb, msg_reference, cbd->data);
+	goto out;
+error:
+	CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
+out:
+	g_free(cbd);
+	return TRUE;
+}
+
+static void isi_submit(struct ofono_sms *sms, unsigned char *pdu,
+			int pdu_len, int tpdu_len, int mms,
+			ofono_sms_submit_cb_t cb, void *user_data)
+{
+	struct sms_data *sd =3D ofono_sms_get_data(sms);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(sms, cb, user_data);
+	uint8_t sca_len =3D pdu_len - tpdu_len;
+	uint8_t *tpdu =3D pdu + sca_len;
+	uint8_t msg[] =3D {
+		SMS_MESSAGE_SEND_REQ,
+		mms,			/* More messages to send*/
+		SMS_ROUTE_DEFAULT,
+		FALSE,			/* Repeated message*/
+		0, 0,			/* fillers*/
+		2,			/* nro of subblocks*/
+		SMS_SB_TPDU >> 8,	/* first subblock*/
+		SMS_SB_TPDU & 0xFF,
+		(tpdu_len + 6) >> 8,
+		(tpdu_len + 6) & 0xFF,
+		tpdu_len,
+		0x00,
+		/* databytes come here */
+	};
+	uint8_t parameters[] =3D {
+		SMS_SB_SMS_PARAMETERS >> 8,
+		SMS_SB_SMS_PARAMETERS & 0xFF,
+		8 >> 8,			/* subblock length*/
+		8 & 0xFF,
+		/*
+		 * location. We might have to fetch this by
+		 * SMS_SETTINGS_READ_REQ
+		 */
+		1, /*SMS_DEFAULT_PARAMETER_LOCATION =3D 0 else range 1-255*/
+		0x02,/*SMS_PI_SERVICE_CENTRE_ADDRESS*/
+		0, 0,
+	};
+	struct iovec iov[3] =3D {
+		{ msg, sizeof(msg) },
+		{ tpdu, tpdu_len },
+		{ parameters, sizeof(parameters) },
+	};
+
+	DBG("");
+
+	if (cbd && (g_isi_request_vmake(sd->client, iov, 3, SMS_TIMEOUT,
+					isi_submit_cb, cbd)))
+		return;
+
+	CALLBACK_WITH_FAILURE(cb, -1, user_data);
+	g_free(cbd);
+}
+
+static gboolean report_resp_cb(GIsiClient *client, const void *restrict da=
ta,
+				size_t len, uint16_t object, void *opaque)
+{
+	const uint8_t *msg =3D data;
+	DBG("");
+
+	if (!msg) {
+		DBG("ISI client error: %d", g_isi_client_error(client));
+		return FALSE;
+	}
+
+	if (len < 3 || msg[0] !=3D SMS_RECEIVED_MSG_REPORT_RESP)
+		return FALSE;
+
+	DBG("Report resp cause=3D0x%"PRIx8, msg[1]);
+	return TRUE;
+}
+
+static gboolean send_received_deliver_report(GIsiClient *client,
+						gboolean success)
+{
+	uint8_t cause_type =3D !success ? SMS_CAUSE_TYPE_EXT : 0;
+	uint8_t cause =3D !success ? SMS_EXT_ERR_MEMORY_CAPACITY_EXC : 0;
+	uint8_t msg[] =3D {
+		SMS_RECEIVED_MSG_REPORT_REQ,
+		cause_type,
+		cause,
+		0, 0, 0,	/* Filler */
+		0,		/* nro of subblocks*/
+	};
+
+	DBG("");
+	return g_isi_request_make(client, msg, sizeof(msg), SMS_TIMEOUT,
+					report_resp_cb, NULL) !=3D NULL;
+}
+static void received_msg_ind_cb(GIsiClient *client, const void *restrict d=
ata,
+				size_t len, uint16_t object, void *opaque)
+{
+	const uint8_t *msg =3D data;
+	struct ofono_sms *sms =3D opaque;
+	GIsiSubBlockIter iter;
+	uint8_t *sca =3D NULL;
+	uint8_t sca_len =3D 0;
+	uint8_t *tpdu =3D NULL;
+	uint8_t tpdu_len =3D 0;
+	unsigned char pdu[176];
+	unsigned char type;
+	/*subblocks SMS_SB_ADDRESS and SMS_SB_TPDU*/
+	DBG("len =3D %d", (int) len);
+
+	if (!msg) {
+		DBG("ISI client error: %d", g_isi_client_error(client));
+		return;
+	}
+
+	if (len < 3 || msg[0] !=3D SMS_RECEIVED_MSG_IND)
+		return;
+
+	for (g_isi_sb_iter_init_full(&iter, msg, len, 3, TRUE, msg[2]);
+			g_isi_sb_iter_is_valid(&iter);
+			g_isi_sb_iter_next(&iter)) {
+		switch (g_isi_sb_iter_get_id(&iter)) {
+			uint8_t type;
+			void *data;
+			uint8_t data_len;
+		case SMS_SB_ADDRESS:
+
+			if (!g_isi_sb_iter_get_byte(&iter, &type, 4)
+				|| !g_isi_sb_iter_get_byte(&iter, &data_len, 5)
+				|| !g_isi_sb_iter_get_data(&iter, &data, 6)
+				|| type !=3D SMS_SMSC_ADDRESS)
+				break;
+
+			sca =3D data;
+			sca_len =3D data_len;
+			break;
+		case SMS_SB_TPDU:
+
+			if (!g_isi_sb_iter_get_byte(&iter, &data_len, 4)
+				|| !g_isi_sb_iter_get_data(&iter, &data, 6))
+				break;
+
+			tpdu =3D data;
+			tpdu_len =3D data_len;
+			break;
+		}
+	}
+
+	if (!tpdu || !sca || tpdu_len + sca_len > sizeof(pdu))
+		return;
+
+	memmove(pdu, sca, sca_len);
+	memmove(pdu + sca_len, tpdu, tpdu_len);
+	/* 23.040 9.2.3.1 */
+	type =3D tpdu[0] & 0x03;
+	DBG("Type of TPDU=3D%d", type);
+
+	if (type =3D=3D SMS_STATUS_REPORT) {
+		ofono_sms_status_notify(sms,
+					pdu, tpdu_len + sca_len, tpdu_len);
+	} else {
+		ofono_sms_deliver_notify(sms,
+					 pdu, tpdu_len + sca_len, tpdu_len);
+	}
+
+	send_received_deliver_report(client, TRUE);
+}
+
+static gboolean routing_resp_cb(GIsiClient *client, const void *restrict d=
ata,
+				size_t len, uint16_t object, void *opaque)
+{
+	const unsigned char *msg =3D data;
+	struct ofono_sms *sms =3D opaque;
+	DBG("");
+
+	if (!msg) {
+		DBG("ISI client error: %d", g_isi_client_error(client));
+		goto error;
+	}
+
+	if (len < 3 || msg[0] !=3D SMS_RECEIVE_MESSAGE_RESP)
+		goto error;
+
+	if (msg[1] !=3D SMS_RECEPTION_ACTIVE) {
+		DBG("Request failed: 0x%02X", msg[1]);
+		goto error;
+	}
+
+	/*for received indications*/
+	g_isi_subscribe(client, SMS_RECEIVED_MSG_IND, received_msg_ind_cb, sms);
+	new_sca =3D NULL;
+	alpha_identifier =3D -1;
+	ofono_sms_register(sms);
+	return TRUE;
+error:
+	DBG("Unable to bootstrap SMS routing.");
+	return FALSE;
+}
+
+static int isi_sms_probe(struct ofono_sms *sms, unsigned int vendor,
+				void *user)
+{
+	GIsiModem *idx =3D user;
+	struct sms_data *data =3D g_try_new0(struct sms_data, 1);
+	const unsigned char msg[] =3D {
+		SMS_RECEIVE_MESSAGE_REQ,
+		SMS_RECEPTION_ACTIVATE,
+		0,
+	};
+
+	DBG("");
+
+	if (!data)
+		return -ENOMEM;
+
+	data->client =3D get_pn_sms_client(idx, PN_SMS);
+
+	if (!data->client)
+		return -ENOMEM;
+
+	ofono_sms_set_data(sms, data);
+
+	if (!g_isi_request_make(data->client, msg, sizeof(msg),
+				SMS_TIMEOUT, routing_resp_cb, sms))
+		DBG("Failed to set SMS routing.");
+
+	return 0;
+}
+
+static void isi_sms_remove(struct ofono_sms *sms)
+{
+	struct sms_data *data =3D ofono_sms_get_data(sms);
+	const unsigned char msg[] =3D {
+		SMS_RECEIVE_MESSAGE_REQ,
+		SMS_RECEPTION_DEACTIVATE,
+		0x0,
+	};
+
+	DBG("");
+
+	if (!data)
+		return;
+
+	if (is_pn_sms_client()) {
+		g_isi_request_make(data->client, msg, sizeof(msg),
+					SMS_TIMEOUT, NULL, NULL);
+		pn_sms_client_destroy(data->client);
+	}
+
+	if (new_sca) {
+		g_free(new_sca);
+		new_sca =3D NULL;
+	}
+
+	g_free(data);
+}
+
+static int bearer_query_resp_cb(GIsiClient *client, const void *restrict d=
ata,
+				size_t len, uint16_t object, void *opaque)
+{
+	const unsigned char *msg =3D data;
+	struct isi_cb_data *cbd =3D opaque;
+	ofono_sms_bearer_query_cb_t cb =3D cbd->cb;
+	int bearer =3D 0;
+
+	DBG("");
+
+	if (!msg) {
+		DBG("ISI client error: %d", g_isi_client_error(client));
+		goto error;
+	}
+
+	if ((len < 3 || msg[0] !=3D SMS_SETTINGS_READ_RESP) || (msg[1] !=3D SMS_O=
K))
+		goto error;
+
+	/* check what bearer type was set */
+	if (msg[7] =3D=3D 0x00 && msg[8] =3D=3D 0x01)
+		bearer =3D 0;
+	else if (msg[7] =3D=3D 0x01 && msg[8] =3D=3D 0x00)
+		bearer =3D 1;
+	else if (msg[7] =3D=3D 0x02 && msg[8] =3D=3D 0x01)
+		bearer =3D 2;
+	else if (msg[7] =3D=3D 0x01 && msg[8] =3D=3D 0x02)
+		bearer =3D 3;
+
+	DBG("bearer =3D %d", bearer);
+	CALLBACK_WITH_SUCCESS(cb, bearer, cbd->data);
+	goto out;
+error:
+	DBG("Error");
+	CALLBACK_WITH_FAILURE(cb, bearer, cbd->data);
+out:
+	g_free(cbd);
+	return TRUE;
+}
+
+static void isi_bearer_query(struct ofono_sms *sms,
+				ofono_sms_bearer_query_cb_t cb, void *data)
+{
+	struct sms_data *sd =3D ofono_sms_get_data(sms);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(sms, cb, data);
+	unsigned char msg[] =3D {
+		SMS_SETTINGS_READ_REQ,
+		SMS_SETTING_TYPE_ROUTE,
+		0
+	};
+	DBG("");
+
+	if (cbd && g_isi_request_make(sd->client, msg, sizeof(msg),
+					SMS_TIMEOUT, bearer_query_resp_cb, cbd))
+		return;
+
+	CALLBACK_WITH_FAILURE(cb, 0, data);
+	g_free(cbd);
+}
+
+
+static gboolean set_resp_cb(GIsiClient *client, const void *restrict data,
+				size_t len, uint16_t object, void *opaque)
+{
+	const unsigned char *msg =3D data;
+	struct isi_cb_data *cbd =3D opaque;
+	ofono_sms_bearer_set_cb_t cb =3D cbd->cb;
+	DBG("");
+
+	if (!msg) {
+		DBG("ISI client error: %d", g_isi_client_error(client));
+		goto error;
+	}
+
+	if (len < 3 || msg[0] !=3D SMS_SETTINGS_UPDATE_RESP)
+		return FALSE;
+
+	if (msg[2] !=3D SMS_OK)
+		goto error;
+
+	CALLBACK_WITH_SUCCESS(cb, cbd->data);
+	goto out;
+error:
+	DBG(" Error");
+	CALLBACK_WITH_FAILURE(cb, cbd->data);
+out:
+	g_free(cbd);
+	return TRUE;
+}
+
+static void isi_bearer_set(struct ofono_sms *sms, int bearer,
+			   ofono_sms_bearer_set_cb_t cb, void *data)
+{
+	struct sms_data *sd =3D ofono_sms_get_data(sms);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(sms, cb, data);
+	unsigned char bearer_type[2] =3D {SMS_ROUTE_NOT_AVAILABLE,
+					SMS_ROUTE_NOT_AVAILABLE
+	};
+
+	DBG("");
+	switch (bearer) {
+	case 0:
+		bearer_type[0] =3D SMS_ROUTE_NOT_AVAILABLE;
+		bearer_type[1] =3D SMS_ROUTE_PRIORITY_1;
+		break;
+	case 1:
+		bearer_type[0] =3D SMS_ROUTE_PRIORITY_1;
+		bearer_type[1] =3D SMS_ROUTE_NOT_AVAILABLE;
+		break;
+	case 2:
+		bearer_type[0] =3D SMS_ROUTE_PRIORITY_2;
+		bearer_type[1] =3D SMS_ROUTE_PRIORITY_1;
+		break;
+	case 3:
+		bearer_type[0] =3D SMS_ROUTE_PRIORITY_1;
+		bearer_type[1] =3D SMS_ROUTE_PRIORITY_2;
+		break;
+	}
+
+	if (cbd && sd) {
+		unsigned char msg[] =3D {
+			SMS_SETTINGS_UPDATE_REQ,
+			SMS_SETTING_TYPE_ROUTE,
+			1, /* one subblock */
+			SMS_SB_ROUTE_INFO >> 8,
+			SMS_SB_ROUTE_INFO & 0xFF,
+			8 >> 8,
+			8 & 0xFF,
+			bearer_type[0], /* cs priority */
+			bearer_type[1], /* ps priority */
+			0, 0
+		};
+
+		if (g_isi_request_make(sd->client, msg, sizeof(msg),
+				SMS_TIMEOUT, set_resp_cb, cbd))
+			return;
+	}
+
+	CALLBACK_WITH_FAILURE(cb, data);
+	g_free(cbd);
+}
+
+static struct ofono_sms_driver driver =3D {
+	.name			=3D "isimodem25",
+	.probe			=3D isi_sms_probe,
+	.remove			=3D isi_sms_remove,
+	.sca_query		=3D isi_sca_query,
+	.sca_set		=3D isi_sca_set,
+	.submit			=3D isi_submit,
+	.bearer_query		=3D isi_bearer_query,
+	.bearer_set		=3D isi_bearer_set
+};
+
+void isi_sms_init()
+{
+	DBG("");
+	pn_sms_client =3D NULL;
+	ofono_sms_driver_register(&driver);
+}
+
+void isi_sms_exit()
+{
+	DBG("");
+	ofono_sms_driver_unregister(&driver);
+}
+
+GIsiClient *get_pn_sms_client(GIsiModem *modem, uint8_t resource)
+{
+	if (!pn_sms_client)
+		pn_sms_client =3D g_isi_client_create(modem, resource);
+
+	return pn_sms_client;
+}
+
+void pn_sms_client_destroy(GIsiClient *client)
+{
+	if (pn_sms_client) {
+		g_isi_client_destroy(client);
+		pn_sms_client =3D NULL;
+	}
+}
+
+gboolean is_pn_sms_client()
+{
+	return (pn_sms_client !=3D NULL);
+}
diff --git a/drivers/isimodem2.5/sms.h b/drivers/isimodem2.5/sms.h
new file mode 100644
index 0000000..c58158c
--- /dev/null
+++ b/drivers/isimodem2.5/sms.h
@@ -0,0 +1,188 @@
+/*
+ * This file is part of oFono - Open Source Telephony
+ *
+ * Copyright (C) 2009 Nokia Corporation and/or its subsidiary(-ies).
+ * Copyright (C) ST-Ericsson SA 2010.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#ifndef __ISIMODEM25_SMS_H
+#define __ISIMODEM25_SMS_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#define SMS_DEFAULT_PARAMETER_LOCATION		0x00
+#define PN_SMS					0x02
+#define CBS_TIMEOUT				5
+
+enum sms_cause {
+	SMS_OK =3D				0x00,
+	SMS_ERR_PP_RESERVED =3D			0x04,
+	SMS_ERR_CS_INACTIVE =3D			0x11
+};
+enum sms_cause_type {
+	SMS_CAUSE_TYPE_COMMON =3D			0x00,
+	SMS_CAUSE_TYPE_EXT =3D			0x01
+};
+enum sms_ext_cause {
+	SMS_EXT_ERR_MEMORY_CAPACITY_EXC =3D	0x16
+};
+enum sms_message_id {
+	SMS_MESSAGE_CAPABILITY_REQ =3D		0x00,
+	SMS_MESSAGE_CAPABILITY_RESP =3D		0x01,
+	SMS_MESSAGE_SEND_REQ =3D			0x02,
+	SMS_MESSAGE_SEND_RESP =3D			0x03,
+	SMS_RECEIVED_MT_PP_IND =3D		0x04,
+	SMS_RECEIVED_MWI_PP_IND =3D		0x05,
+	SMS_PP_ROUTING_REQ =3D			0x06,
+	SMS_PP_ROUTING_RESP =3D			0x07,
+	SMS_PP_ROUTING_NTF =3D			0x08,
+	SMS_GSM_RECEIVED_PP_REPORT_REQ =3D	0x09,
+	SMS_GSM_RECEIVED_PP_REPORT_RESP =3D	0x0A,
+	SMS_GSM_CB_ROUTING_REQ =3D		0x0B,
+	SMS_GSM_CB_ROUTING_RESP =3D		0x0C,
+	SMS_GSM_CB_ROUTING_NTF =3D		0x0D,
+	SMS_GSM_TEMP_CB_ROUTING_REQ =3D		0x0E,
+	SMS_GSM_TEMP_CB_ROUTING_RESP =3D		0x0F,
+	SMS_GSM_TEMP_CB_ROUTING_NTF =3D		0x10,
+	SMS_GSM_CBCH_PRESENT_IND =3D		0x11,
+	SMS_PARAMETERS_UPDATE_REQ =3D		0x12,
+	SMS_PARAMETERS_UPDATE_RESP =3D		0x13,
+	SMS_PARAMETERS_READ_REQ =3D		0x14,
+	SMS_PARAMETERS_READ_RESP =3D		0x15,
+	SMS_PARAMETERS_CAPACITY_REQ =3D		0x16,
+	SMS_PARAMETERS_CAPACITY_RESP =3D		0x17,
+	SMS_GSM_SETTINGS_UPDATE_REQ =3D		0x18,
+	SMS_GSM_SETTINGS_UPDATE_RESP =3D		0x19,
+	SMS_GSM_SETTINGS_READ_REQ =3D		0x1A,
+	SMS_GSM_SETTINGS_READ_RESP =3D		0x1B,
+	SMS_GSM_MCN_SETTING_CHANGED_IND =3D	0x1C,
+	SMS_MEMORY_CAPACITY_EXC_IND =3D		0x1D,
+	SMS_STORAGE_STATUS_UPDATE_REQ =3D		0x1E,
+	SMS_STORAGE_STATUS_UPDATE_RESP =3D	0x1F,
+	SMS_MESSAGE_SEND_STATUS_IND =3D		0x22,
+	SMS_GSM_RESEND_CANCEL_REQ =3D		0x23,
+	SMS_GSM_RESEND_CANCEL_RESP =3D		0x24,
+	SMS_SM_CONTROL_ACTIVATE_REQ =3D		0x25,
+	SMS_SM_CONTROL_ACTIVATE_RESP =3D		0x26,
+	SMS_GSM_INDICATE_STORAGE_REQ =3D		0x2A,
+	SMS_GSM_INDICATE_STORAGE_RESP =3D		0x2B,
+	SMS_STATUS_IND =3D			0x2D,
+	SMS_STATUS_REQ =3D			0x2E,
+	SMS_STATUS_RESP =3D			0x2F,
+	SMS_SETTINGS_UPDATE_REQ =3D		0x30,
+	SMS_SETTINGS_UPDATE_RESP =3D		0x31,
+	SMS_SETTINGS_READ_REQ =3D			0x32,
+	SMS_SETTINGS_READ_RESP =3D		0x33,
+	SMS_CB_ROUTING_REQ =3D			0x34,
+	SMS_CB_ROUTING_RESP =3D			0x35,
+	SMS_CB_ROUTING_IND =3D			0x36,
+	SMS_CB_SIM_ROUTING_IND =3D		0x37,
+	SMS_RECEIVED_MSG_REPORT_REQ =3D		0x3B,
+	SMS_RECEIVED_MSG_REPORT_RESP =3D		0x3C,
+	SMS_RECEIVE_MESSAGE_REQ =3D		0x41,
+	SMS_RECEIVE_MESSAGE_RESP =3D		0x42,
+	SMS_RECEIVED_MSG_IND =3D			0x43,
+	SMS_RECEIVED_SIM_MSG_IND =3D		0x44,
+	SMS_RESOURCE_CONF_REQ =3D			0x45,
+	SMS_RESOURCE_CONF_RESP =3D		0x46,
+	SMS_RESOURCE_CONF_IND =3D			0x47,
+	SMS_RESOURCE_CLEAR_IND =3D		0x48,
+	SMS_RESOURCE_REQ =3D			0x49,
+	SMS_RESOURCE_RESP =3D			0x4A,
+	SMS_RESOURCE_IND =3D			0x4B,
+	SMS_MODEM_MEM_SETTINGS_UPDATE_REQ =3D	0x4C,
+	SMS_MODEM_MEM_SETTINGS_UPDATE_RESP =3D	0x4D,
+	SMS_MODEM_MEM_SETTINGS_IND =3D		0x4E,
+	SMS_MODEM_MEM_SETTINGS_READ_REQ =3D	0x4F,
+	SMS_MODEM_MEM_SETTINGS_READ_RESP =3D	0x50,
+	SMS_MODEM_MEM_DATA_READ_REQ =3D		0x53,
+	SMS_MODEM_MEM_DATA_READ_RESP =3D		0x54,
+	SMS_MODEM_MEM_RECORD_STATUS_READ_REQ =3D	0x55,
+	SMS_MODEM_MEM_RECORD_STATUS_READ_RESP =3D	0x56,
+	SMS_MODEM_MEM_RECORD_ERASE_REQ =3D	0x57,
+	SMS_MODEM_MEM_RECORD_ERASE_RESP =3D	0x58,
+	SMS_MODEM_MEM_RECORD_QUERY_REQ =3D	0x59,
+	SMS_MODEM_MEM_RECORD_QUERY_RESP =3D	0x5A,
+	SMS_MODEM_MEM_DATA_STORED_IND =3D		0x5B,
+};
+enum sms_reception_command {
+	SMS_RECEPTION_ACTIVATE =3D		0x01,
+	SMS_RECEPTION_DEACTIVATE =3D		0x02
+};
+enum sms_reception_status {
+	SMS_RECEPTION_ACTIVE =3D			0x01,
+	SMS_RECEPTION_INACTIVE =3D		0x02
+};
+enum sms_subblock_id {
+	SMS_SB_CB_MESSAGE =3D			0x000E,
+	SMS_SB_TPDU =3D				0x001C,
+	SMS_SB_ROUTE_INFO =3D			0x0023,
+	SMS_SB_CBS_SUBSCRIPTION =3D		0x002D,
+	SMS_SB_CAUSE =3D				0x0029,
+	SMS_SB_SMS_PARAMETERS =3D			0x0031,
+	SMS_SB_ADDRESS =3D			0x0082
+};
+enum sms_address_type {
+	SMS_SMSC_ADDRESS =3D			0x02
+};
+enum sms_route {
+	SMS_ROUTE_CS =3D				0x01,
+	SMS_ROUTE_DEFAULT =3D			0x04
+};
+enum sms_route_priority {
+	SMS_ROUTE_NOT_AVAILABLE =3D		0x00,
+	SMS_ROUTE_PRIORITY_1 =3D			0x01,
+	SMS_ROUTE_PRIORITY_2 =3D			0x02
+};
+enum sms_parameter_indicator {
+	SMS_PI_SERVICE_CENTRE_ADDRESS =3D		0x02
+};
+
+enum sms_setting_type {
+	SMS_SETTING_TYPE_ROUTE =3D		0x02
+};
+enum sms_server_status {
+	SMS_SERVER_READY =3D			0x00,
+	SMS_SERVER_NOT_READY =3D			0x01
+};
+enum sms_routing_command {
+	SMS_ROUTING_RELEASE =3D			0x00,
+	SMS_ROUTING_SET =3D			0x01,
+	SMS_ROUTING_UPDATE =3D			0x04,
+	SMS_ROUTING_QUERRY_ALL =3D		0x06
+};
+enum sms_gsm_routing_mode {
+	SMS_GSM_ROUTING_MODE_ALL =3D		0x0B,
+};
+
+enum sms_gsm_cb_subject_list_type {
+	SMS_CB_ALLOWED_IDS_LIST =3D		0x00,
+	SMS_CB_NOT_ALLOWED_IDS_LIST =3D		0x01,
+};
+
+GIsiClient *get_pn_sms_client(GIsiModem * modem, uint8_t resource);
+void pn_sms_client_destroy(GIsiClient *client);
+gboolean is_pn_sms_client();
+
+#ifdef __cplusplus
+};
+#endif
+
+#endif /* __ISIMODEM25_SMS_H */
diff --git a/drivers/isimodem2.5/ss.h b/drivers/isimodem2.5/ss.h
new file mode 100644
index 0000000..1716822
--- /dev/null
+++ b/drivers/isimodem2.5/ss.h
@@ -0,0 +1,174 @@
+/*
+ * This file is part of oFono - Open Source Telephony
+ *
+ * Copyright (C) 2009 Nokia Corporation and/or its subsidiary(-ies).
+ * Copyright (C) ST-Ericsson SA 2010.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#ifndef __ISIMODEM25_SS_H
+#define __ISIMODEM25_SS_H
+
+#include <gisi/client.h>
+
+#define PN_SS				0x06
+#define SS_TIMEOUT			15
+#define SS_MAX_USSD_LENGTH		160
+
+enum ss_message_id {
+	SS_SERVICE_REQ =3D			0x00,
+	SS_SERVICE_COMPLETED_RESP =3D		0x01,
+	SS_SERVICE_FAILED_RESP =3D		0x02,
+	SS_SERVICE_NOT_SUPPORTED_RESP =3D		0x03,
+	SS_GSM_USSD_SEND_REQ =3D			0x04,
+	SS_GSM_USSD_SEND_RESP =3D			0x05,
+	SS_GSM_USSD_RECEIVE_IND =3D		0x06,
+	SS_STATUS_IND =3D				0x09,
+	SS_SERVICE_COMPLETED_IND =3D		0x10,
+	SS_CANCEL_REQ =3D				0x11,
+	SS_CANCEL_RESP =3D			0x12,
+	SS_RESOURCE_CONTROL_IND =3D		0x21,
+	SS_RESOURCE_CONTROL_REQ =3D		0x22,
+	SS_RESOURCE_CONTROL_RESP =3D		0x23,
+	SS_RESOURCE_CONF_IND =3D			0x24,
+	SS_RESOURCE_CONF_REQ =3D			0x25,
+	SS_RESOURCE_CONF_RESP =3D			0x26
+};
+
+enum ss_ussd_type {
+	SS_GSM_USSD_MT_REPLY =3D			0x01,
+	SS_GSM_USSD_COMMAND =3D			0x02,
+	SS_GSM_USSD_REQUEST =3D			0x03,
+	SS_GSM_USSD_NOTIFY =3D			0x04,
+	SS_GSM_USSD_END =3D			0x05
+};
+
+enum ss_ussd_status {
+	SS_GSM_STATUS_REQUEST_USSD_START =3D	0x02,
+	SS_GSM_STATUS_REQUEST_USSD_STOP =3D	0x03,
+	SS_GSM_STATUS_REQUEST_USSD_FAILED =3D	0x04
+};
+
+enum ss_operations {
+	SS_ACTIVATION =3D				0x01,
+	SS_DEACTIVATION =3D			0x02,
+	SS_REGISTRATION =3D			0x03,
+	SS_ERASURE =3D				0x04,
+	SS_INTERROGATION =3D			0x05,
+	SS_GSM_PASSWORD_REGISTRATION =3D		0x06
+};
+
+enum ss_basic_service_codes {
+	SS_ALL_TELE_AND_BEARER =3D		0,
+	SS_GSM_ALL_TELE =3D			10,
+	SS_GSM_TELEPHONY =3D			11,
+	SS_GSM_ALL_DATA_TELE =3D			12,
+	SS_GSM_FACSIMILE =3D			13,
+	SS_GSM_SMS =3D				16,
+	SS_GSM_VOICE_GROUP =3D			17,
+	SS_GSM_ALL_TELE_EXC_SMS =3D		19,
+	SS_GSM_ALL_BEARER =3D			20,
+	SS_GSM_ALL_ASYNC =3D			21,
+	SS_GSM_ALL_SYNC =3D			22,
+	SS_GSM_ALL_DATA_CIRCUIT_SYNC =3D		24,
+	SS_GSM_ALL_DATA_CIRCUIT_ASYNC =3D		25,
+	SS_GSM_ALL_DATA_PACKET_SYNC =3D		26,
+	SS_GSM_ALL_PAD_ACCESS =3D			27
+};
+
+enum ss_codes {
+	SS_GSM_ALL_SS =3D				0x0000,
+	SS_GSM_ALL_FORWARDINGS =3D		0x0002,
+	SS_GSM_ALL_COND_FORWARDINGS =3D		0x0004,
+	SS_GSM_FORW_UNCONDITIONAL =3D		0x0015,
+	SS_GSM_FORW_BUSY =3D			0x0043,
+	SS_GSM_FORW_NO_REPLY =3D			0x003D,
+	SS_GSM_FORW_NO_REACH =3D			0x003E,
+	SS_GSM_ALL_BARRINGS =3D			0x014A,
+	SS_GSM_BARR_ALL_OUT =3D			0x0021,
+	SS_GSM_BARR_OUT_INTER =3D			0x014B,
+	SS_GSM_BARR_OUT_INTER_EXC_HOME =3D	0x014C,
+	SS_GSM_BARR_ALL_IN =3D			0x0023,
+	SS_GSM_BARR_ALL_IN_ROAM =3D		0x015F,
+	SS_GSM_OUTGOING_BARR_SERV =3D		0x014D,
+	SS_GSM_INCOMING_BARR_SERV =3D		0x0161,
+	SS_GSM_CALL_WAITING =3D			0x002B,
+	SS_GSM_CLIP =3D				0x001E,
+	SS_GSM_CLIR =3D				0x001F,
+	SS_GSM_COLP =3D				0x004C,
+	SS_GSM_COLR =3D				0x004D,
+	SS_GSM_CNAP =3D				0x012C,
+	SS_GSM_ECT =3D				0x0060
+};
+
+enum ss_response_data {
+	SS_SEND_ADDITIONAL_INFO =3D		0x01
+};
+
+enum ss_subblock {
+	SS_FORWARDING =3D				0x00,
+	SS_STATUS_RESULT =3D			0x01,
+	SS_OTHER_ERROR =3D			0x02,
+	SS_GSM_PASSWORD =3D			0x03,
+	SS_GSM_FORWARDING_INFO =3D		0x04,
+	SS_GSM_FORWARDING_FEATURE =3D		0x05,
+	SS_GSM_BARRING_INFO =3D			0x06,
+	SS_GSM_BARRING_FEATURE =3D		0x07,
+	SS_GSM_DATA =3D				0x08,
+	SS_GSM_BSC_INFO =3D			0x09,
+	SS_GSM_GENERIC_SERVICE_INFO =3D		0x0A,
+	SS_GSM_PASSWORD_INFO =3D			0x0B,
+	SS_GSM_CLIR_INFO =3D			0x0C,
+	SS_GSM_INDICATE_PASSWORD_ERROR =3D	0x0D,
+	SS_GSM_INDICATE_ERROR =3D			0x0E,
+	SS_GSM_INDICATE_PROBLEM =3D		0x0F,
+	SS_GSM_INDICATE_MSG_ERROR =3D		0x10,
+	SS_GSM_ADDITIONAL_INFO =3D		0x2F,
+	SS_GSM_MM_RELEASED =3D			0x30,
+	SS_GSM_USSD_STRING =3D			0x32,
+	SS_SB_RESOURCE =3D			0x41,
+	SS_SB_RESOURCE_SEQ_ID =3D			0x42,
+	SS_SB_RESOURCE_STATUS =3D			0x43,
+	SS_SB_SS_CONTROL =3D			0x44,
+	SS_SB_USSD_CONTROL =3D			0x45,
+	SS_SB_RESOURCE_CONTROL_INFO =3D		0x46,
+	SS_SB_CHECK_INFO =3D			0x47,
+	SS_SB_RESOURCE_CONF_REQUIRED =3D		0x48,
+	SS_SB_RESOURCE_CONF =3D			0x49
+};
+
+enum ss_isi_cause {
+	SS_GSM_ACTIVE =3D				0x01,
+	SS_GSM_REGISTERED =3D			0x02,
+	SS_GSM_PROVISIONED =3D			0x04,
+	SS_GSM_QUIESCENT =3D			0x08
+};
+enum ss_gsm_cli_restriction_option {
+	SS_GSM_CLI_PERMANENT =3D			0x00,
+	SS_GSM_DEFAULT_RESTRICTED =3D		0x01,
+	SS_GSM_CLI_DEFAULT_ALLOWED =3D		0x02,
+	SS_GSM_OVERRIDE_ENABLED =3D		0x03,
+	SS_GSM_OVERRIDE_DISABLED =3D		0x04
+};
+enum ss_constants {
+	SS_UNDEFINED_TIME =3D			0x00,
+};
+
+GIsiClient *get_pn_ss_client(GIsiModem *modem, uint8_t resource);
+void pn_ss_client_destroy(GIsiClient *client);
+
+#endif /* __ISIMODEM25_SS_H */
diff --git a/drivers/isimodem2.5/ssn.c b/drivers/isimodem2.5/ssn.c
new file mode 100644
index 0000000..b948500
--- /dev/null
+++ b/drivers/isimodem2.5/ssn.c
@@ -0,0 +1,456 @@
+/*
+ * This file is part of oFono - Open Source Telephony
+ *
+ * Copyright (C) 2009 Nokia Corporation and/or its subsidiary(-ies).
+ * Copyright (C) ST-Ericsson SA 2010.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include <gisi/client.h>
+#include <gisi/iter.h>
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/ssn.h>
+
+#include <glib.h>
+
+#include "call.h"
+#include "isimodem.h"
+
+#define NOT_3GGP_NOTIFICATION -1
+
+/* Specified by 3GGP in TS.27007 */
+enum gpp_cssi_codes {
+	UNCONDITIONAL_CALL_FORWARDING_IS_ACTIVE,
+	SOME_OF_CONDITIONAL_CALL_FORWARDINGS_ARE_ACTIVE,
+	CALL_HAS_BEEN_FORWARDED,
+	CALL_IS_WAITING,
+	THIS_IS_A_CUG_CALL,
+	OUTGOING_CALLS_ARE_BARRED,
+	INCOMING_CALLS_ARE_BARRED,
+	CLIR_SUPPRESSION_REJECTED,
+	CALL_HAS_BEEN_DEFLECTED
+};
+
+enum gpp_cssu_codes {
+	THIS_IS_A_FORWARDED_CALL,
+	THIS_IS_A_CUG_CALL_CSSU,
+	CALL_HAS_BEEN_PUT_ON_HOLD,
+	CALL_HAS_BEEN_RETRIEVED,
+	MULTIPARTY_CALL_ENTERED,
+	CALL_ON_HOLD_HAS_BEEN_RELEASED,
+	FORWARD_CHECK_SS_MESSAGE_RECEIVED,
+	CALL_IS_BEING_CON_WT_RM_PARTY_ALRT,
+	CALL_IS_BEING_CON_WT_OTH_RM_PARTY_EXPL,
+	THIS_IS_A_DEFLECTED_CALL,
+	ADDITIONAL_INCOMING_CALL_FORWARDED
+};
+
+
+struct ssn_data {
+	GIsiClient *client;
+};
+
+struct isi_ssn_prop {
+	char		number[OFONO_MAX_PHONE_NUMBER_LENGTH + 1];
+	int		type;
+	uint16_t	cug_index;
+};
+
+struct isi_ssn {
+	GIsiClient *client;
+	struct isi_call_req_context *queue;
+};
+
+static void isi_cm_sb_rem_address_sb_proc(struct isi_ssn_prop *ssn_prop,
+						GIsiSubBlockIter const *sb)
+{
+	uint8_t addr_type, addr_len;
+	char *address;
+	DBG("CALL_MODEM_SB_REMOTE_ADDRESS");
+
+	if (!g_isi_sb_iter_get_byte(sb, &addr_type, 2) ||
+			/* address type */
+			/* presentation indicator */
+			/* fillerbyte */
+		!g_isi_sb_iter_get_byte(sb, &addr_len, 5) ||
+		!g_isi_sb_iter_get_alpha_tag(sb, &address, 2 * addr_len, 6))
+		return;
+
+	strncpy(ssn_prop->number, address, addr_len);
+
+	g_free(address);
+}
+
+static void isi_ssn_notify_ofono(void *_ssn, int cssi, int cssu,
+					struct isi_ssn_prop *ssn_prop)
+{
+	struct ofono_phone_number *phone_nr =3D
+			(struct ofono_phone_number *) ssn_prop;
+
+	if (cssi !=3D NOT_3GGP_NOTIFICATION)
+		ofono_ssn_cssi_notify(_ssn, cssi, ssn_prop->cug_index);
+
+	if (cssu !=3D NOT_3GGP_NOTIFICATION)
+		ofono_ssn_cssu_notify(_ssn, cssi, ssn_prop->cug_index,
+					phone_nr);
+}
+
+static void isi_ssn_call_modem_sb_notify(GIsiSubBlockIter const *sb)
+{
+	uint8_t sb_property;
+	g_isi_sb_iter_get_byte(sb, &sb_property, 2);
+
+	if (sb_property =3D=3D CALL_MODEM_NOTIFY_USER_SUSPENDED)
+		DBG("CALL_MODEM_NOTIFY_USER_SUSPENDED");
+
+	if (sb_property =3D=3D CALL_MODEM_NOTIFY_USER_RESUMED)
+		DBG("CALL_MODEM_NOTIFY_USER_RESUMED");
+
+	if (sb_property =3D=3D CALL_MODEM_NOTIFY_BEARER_CHANGE)
+		DBG("CALL_MODEM_NOTIFY_BEARER_CHANGE");
+}
+
+static void isi_ssn_call_modem_sb_ss_code(GIsiSubBlockIter const *sb,
+						int *cssi_p, int *cssu_p)
+{
+	uint16_t sb_property;
+	g_isi_sb_iter_get_word(sb, &sb_property, 2);
+
+	switch (sb_property) {
+	case(CALL_MODEM_SSC_ALL_FWDS):
+		DBG("Call forwarding is active");
+		break;
+	case(CALL_MODEM_SSC_ALL_COND_FWD): {
+		*(cssi_p) =3D SOME_OF_CONDITIONAL_CALL_FORWARDINGS_ARE_ACTIVE;
+		DBG("Some of conditional call forwardings active");
+	}
+	break;
+	case(CALL_MODEM_SSC_CFU): {
+		*(cssi_p) =3D UNCONDITIONAL_CALL_FORWARDING_IS_ACTIVE;
+		DBG("Unconditional call forwarding is active");
+	}
+	break;
+	case(CALL_MODEM_SSC_CFB):
+		DBG("Unknown notification #1");
+		break;
+	case(CALL_MODEM_SSC_CFNRY):
+		DBG("Unknown notification #2");
+		break;
+	case(CALL_MODEM_SSC_CFGNC):
+		DBG("Unknown notification #3");
+		break;
+	case(CALL_MODEM_SSC_OUTGOING_BARR_SERV): {
+		*(cssi_p) =3D OUTGOING_CALLS_ARE_BARRED;
+		DBG("Outgoing calls are barred");
+	}
+	break;
+	case(CALL_MODEM_SSC_INCOMING_BARR_SERV): {
+		*(cssi_p) =3D INCOMING_CALLS_ARE_BARRED;
+		DBG("Incoming calls are barred");
+	}
+	break;
+	case(CALL_MODEM_SSC_CALL_WAITING):
+		DBG("Incoming calls are barred");
+		break;
+	case(CALL_MODEM_SSC_CLIR):
+		DBG("CLIR connected unknown indication.");
+		break;
+	case(CALL_MODEM_SSC_ETC):
+		DBG("Unknown notification #4");
+		break;
+	case(CALL_MODEM_SSC_MPTY): {
+		*(cssu_p) =3D MULTIPARTY_CALL_ENTERED;
+		DBG("Multiparty call entered.");
+	}
+	break;
+	case(CALL_MODEM_SSC_CALL_HOLD): {
+		*(cssu_p) =3D CALL_ON_HOLD_HAS_BEEN_RELEASED;
+		DBG("Call on hold has been released.");
+	}
+	break;
+	default:
+		break;
+	}
+}
+
+static void isi_ssn_call_modem_sb_ss_status(GIsiSubBlockIter const *sb)
+{
+	uint8_t sb_property;
+	g_isi_sb_iter_get_byte(sb, &sb_property, 2);
+
+	if (sb_property & CALL_MODEM_SS_STATUS_ACTIVE)
+		DBG("CALL_MODEM_SS_STATUS_ACTIVE");
+
+	if (sb_property & CALL_MODEM_SS_STATUS_REGISTERED)
+		DBG("CALL_MODEM_SS_STATUS_REGISTERED");
+
+	if (sb_property & CALL_MODEM_SS_STATUS_PROVISIONED)
+		DBG("CALL_MODEM_SS_STATUS_PROVISIONED");
+
+	if (sb_property & CALL_MODEM_SS_STATUS_QUIESCENT)
+		DBG("CALL_MODEM_SS_STATUS_QUIESCENT");
+}
+
+static void isi_ssn_call_modem_sb_ss_notify(GIsiSubBlockIter const *sb,
+						int *cssi_p, int *cssu_p)
+{
+	uint8_t sb_property;
+	g_isi_sb_iter_get_byte(sb, &sb_property, 2);
+
+	if (sb_property & CALL_MODEM_SSN_INCOMING_IS_FWD) {
+		*(cssu_p) =3D THIS_IS_A_FORWARDED_CALL;
+		DBG("This is a forwarded call #1.");
+	}
+
+	if (sb_property & CALL_MODEM_SSN_INCOMING_FWD)
+		DBG("This is a forwarded call #2.");
+
+	if (sb_property & CALL_MODEM_SSN_OUTGOING_FWD) {
+		*(cssi_p) =3D CALL_HAS_BEEN_FORWARDED;
+		DBG("Call has been forwarded.");
+	}
+}
+
+static void isi_ssn_call_modem_sb_ss_notify_ind(GIsiSubBlockIter const *sb,
+						int *cssi_p)
+{
+	uint8_t sb_property;
+	g_isi_sb_iter_get_byte(sb, &sb_property, 2);
+
+	if (sb_property & CALL_MODEM_SSI_CALL_IS_WAITING) {
+		*(cssi_p) =3D CALL_IS_WAITING;
+		DBG("Call is waiting.");
+	}
+
+	if (sb_property & CALL_MODEM_SSI_MPTY)
+		DBG("Multiparty call.");
+
+	if (sb_property & CALL_MODEM_SSI_CLIR_SUPPR_REJ) {
+		*(cssi_p) =3D CLIR_SUPPRESSION_REJECTED;
+		DBG("CLIR suppression rejected.");
+	}
+}
+
+static void isi_ssn_call_modem_sb_ss_hold(GIsiSubBlockIter const *sb,
+						int *cssu_p)
+{
+	uint8_t sb_property;
+	g_isi_sb_iter_get_byte(sb, &sb_property, 2);
+
+	if (sb_property & CALL_MODEM_HOLD_IND_RETRIEVED) {
+		*(cssu_p) =3D CALL_HAS_BEEN_RETRIEVED;
+		DBG("Call has been retrieved.");
+	}
+
+	if (sb_property & CALL_MODEM_HOLD_IND_ON_HOLD) {
+		*(cssu_p) =3D CALL_HAS_BEEN_PUT_ON_HOLD;
+		DBG("Call has been put on hold.");
+	}
+}
+
+static void isi_ssn_call_modem_sb_ss_ect_ind(GIsiSubBlockIter const *sb,
+						int *cssu_p)
+{
+	uint8_t sb_property;
+	g_isi_sb_iter_get_byte(sb, &sb_property, 2);
+
+	if (sb_property & CALL_MODEM_ECT_CALL_STATE_ALERT) {
+		*(cssu_p) =3D CALL_IS_BEING_CON_WT_RM_PARTY_ALRT;
+		DBG("Call is being connected with the remote party");
+		DBG("in alerting state.");
+	}
+
+	if (sb_property & CALL_MODEM_ECT_CALL_STATE_ACTIVE) {
+		*(cssu_p) =3D CALL_IS_BEING_CON_WT_OTH_RM_PARTY_EXPL;
+		DBG("Call has been connected with the other remote");
+		DBG("party in explicit call transfer operation.");
+	}
+}
+
+static int isi_ssn_call_modem_sb_cug_info(GIsiSubBlockIter const *sb,
+						struct isi_ssn_prop *ssn_prop)
+{
+	uint8_t sb_property;
+	g_isi_sb_iter_get_byte(sb, &sb_property, 2);
+	DBG("CALL_MODEM_SB_CUG_INFO: This is a CUG Call.");
+	DBG("Preferential CUG: 0x%x,", sb_property);
+	g_isi_sb_iter_get_byte(sb, &sb_property, 3);
+	DBG("Cug Output Access: 0x%x,", sb_property);
+	g_isi_sb_iter_get_word(sb, &ssn_prop->cug_index, 4);
+	DBG("Cug Call Index: 0x%x,", ssn_prop->cug_index);
+	return THIS_IS_A_CUG_CALL;
+}
+
+
+static void isi_callmodem_notif_ind_cb(GIsiClient *client,
+					void const *restrict data,
+					size_t len,
+					uint16_t object,
+					void *_ssn)
+{
+	struct ofono_ssn *ssn =3D _ssn;
+	struct isi_ssn *issn =3D ofono_ssn_get_data(ssn);
+	struct isi_ssn_prop *ssn_prop =3D g_try_new0(struct isi_ssn_prop, 1);
+	struct {
+		uint8_t message_id, call_id, sub_blocks;
+	} const *m =3D data;
+	int cssi =3D NOT_3GGP_NOTIFICATION;
+	int cssu =3D NOT_3GGP_NOTIFICATION;
+	GIsiSubBlockIter sb[1];
+	DBG("Received CallServer notification.");
+
+	if (len < 3)
+		goto out;
+
+	if (!issn->client)
+		goto out;
+
+	for (g_isi_sb_iter_init(sb, data, len, (sizeof *m));
+			g_isi_sb_iter_is_valid(sb);
+			g_isi_sb_iter_next(sb)) {
+		switch (g_isi_sb_iter_get_id(sb)) {
+		case CALL_MODEM_SB_NOTIFY:
+			isi_ssn_call_modem_sb_notify(sb);
+			break;
+		case CALL_MODEM_SB_SS_CODE:
+			isi_ssn_call_modem_sb_ss_code(sb, &cssi, &cssu);
+			break;
+		case CALL_MODEM_SB_SS_STATUS:
+			isi_ssn_call_modem_sb_ss_status(sb);
+			break;
+		case CALL_MODEM_SB_SS_NOTIFY:
+			isi_ssn_call_modem_sb_ss_notify(sb, &cssi, &cssu);
+			break;
+		case CALL_MODEM_SB_SS_NOTIFY_INDICATOR:
+			isi_ssn_call_modem_sb_ss_notify_ind(sb, &cssi);
+			break;
+		case CALL_MODEM_SB_SS_HOLD_INDICATOR:
+			isi_ssn_call_modem_sb_ss_hold(sb, &cssu);
+			break;
+		case CALL_MODEM_SB_SS_ECT_INDICATOR:
+			isi_ssn_call_modem_sb_ss_ect_ind(sb, &cssu);
+			break;
+		case CALL_MODEM_SB_REMOTE_ADDRESS:
+			isi_cm_sb_rem_address_sb_proc(ssn_prop, sb);
+			break;
+		case CALL_MODEM_SB_REMOTE_SUBADDRESS:
+			break;
+		case CALL_MODEM_SB_CUG_INFO:
+			cssu =3D isi_ssn_call_modem_sb_cug_info(sb, ssn_prop);
+			break;
+		case CALL_MODEM_SB_ORIGIN_INFO:
+			break;
+		case CALL_MODEM_SB_ALERTING_PATTERN:
+			break;
+		case CALL_MODEM_SB_ALERTING_INFO:
+			break;
+		}
+	}
+
+	isi_ssn_notify_ofono(_ssn, cssi, cssu, ssn_prop);
+out:
+	g_free(ssn_prop);
+}
+
+static gboolean isi_ssn_register(gpointer user)
+{
+	struct ofono_ssn *ssn =3D user;
+	struct ssn_data *sd =3D ofono_ssn_get_data(ssn);
+	DBG("");
+
+	g_isi_subscribe(sd->client, CALL_MODEM_NOTIFICATION_IND,
+					isi_callmodem_notif_ind_cb, ssn);
+
+	ofono_ssn_register(user);
+
+	return FALSE;
+}
+
+static void ssn_reachable_cb(GIsiClient *client, gboolean alive,
+					uint16_t object, void *opaque)
+{
+	struct ofono_ssn *ssn =3D opaque;
+	DBG("");
+
+	if (!alive) {
+		DBG("Unable to bootsrap ssn driver");
+		return;
+	}
+
+	DBG("PN_SSN (v%03d.%03d) reachable.",
+		g_isi_version_major(client),
+		g_isi_version_minor(client));
+	g_idle_add(isi_ssn_register, ssn);
+}
+
+static int isi_ssn_probe(struct ofono_ssn *ssn, unsigned int vendor,
+				void *user)
+{
+	GIsiModem *idx =3D user;
+	struct ssn_data *data =3D g_try_new0(struct ssn_data, 1);
+	DBG("");
+
+	if (!data)
+		return -ENOMEM;
+
+	data->client =3D g_isi_client_create(idx, PN_MODEM_CALL);
+
+	if (!data->client)
+		return -ENOMEM;
+
+	ofono_ssn_set_data(ssn, data);
+	g_isi_verify(data->client, ssn_reachable_cb, ssn);
+	return 0;
+}
+
+static void isi_ssn_remove(struct ofono_ssn *ssn)
+{
+	struct ssn_data *data =3D ofono_ssn_get_data(ssn);
+	DBG("");
+
+	if (data) {
+		g_isi_client_destroy(data->client);
+		g_free(data);
+	}
+}
+
+static struct ofono_ssn_driver driver =3D {
+	.name			=3D "isimodem25",
+	.probe			=3D isi_ssn_probe,
+	.remove			=3D isi_ssn_remove
+};
+
+void isi_ssn_init()
+{
+	ofono_ssn_driver_register(&driver);
+}
+
+void isi_ssn_exit()
+{
+	ofono_ssn_driver_unregister(&driver);
+}
diff --git a/drivers/isimodem2.5/timeout.h b/drivers/isimodem2.5/timeout.h
new file mode 100644
index 0000000..e24471a
--- /dev/null
+++ b/drivers/isimodem2.5/timeout.h
@@ -0,0 +1,33 @@
+/*
+ * This file is part of oFono - Open Source Telephony
+ *
+ * Copyright (C) ST-Ericsson SA 2010.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#define MCE_TIMEOUT		5
+#define GPDS_TIMEOUT		120
+#define GSS_TIMEOUT		5
+#define INFO_TIMEOUT		5
+#define NETWORK_TIMEOUT		5
+#define GSS_TIMEOUT		5
+#define SIM_TIMEOUT		5
+#define CBS_TIMEOUT		5
+#define SMS_TIMEOUT		15
+#define SS_TIMEOUT		15
+#define ISI_CALL_TIMEOUT	1000
+
diff --git a/drivers/isimodem2.5/uicc.c b/drivers/isimodem2.5/uicc.c
new file mode 100644
index 0000000..4b7c1e6
--- /dev/null
+++ b/drivers/isimodem2.5/uicc.c
@@ -0,0 +1,3316 @@
+/*
+ * This file is part of oFono - Open Source Telephony
+ *
+ * Copyright (C) 2009 Nokia Corporation and/or its subsidiary(-ies).
+ * Copyright (C) ST-Ericsson SA 2010.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/uio.h>
+
+#include <gisi/client.h>
+#include <gisi/iter.h>
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/sim.h>
+
+#include <ofono/dbus.h>
+#include <glib.h>
+
+#include "debug.h"
+#include "isimodem.h"
+#include "isiutil.h"
+#include "simutil.h"
+#include "timeout.h"
+#include "uicc.h"
+#include "uicc_interface.h"
+
+#define CLIENT_ID 1
+
+/* #define STATIC_FILE_INFO */
+/* #define READ_FILE_CYCLIC */
+/* #define WRITE_FILE_CYCLIC */
+/* #define WRITE_FILE_TRANSPARENT */
+/* #define QUERY_LOCKED */
+#define PIN_PROMPT
+#define STATUS_WORD_HANDLING
+
+/* File info parameters */
+#define FCP_TEMPLATE			0x62
+#define FCP_FILE_SIZE			0x80
+#define FCP_FILE_DESC			0x82
+#define FCP_FILE_ID			0x83
+#define FCP_FILE_LIFECYCLE		0x8A
+#define FCP_FILE_SECURITY_ARR		0x8B
+#define FCP_FILE_SECURITY_COMPACT	0x8C
+#define FCP_FILE_SECURITY_EXPANDED	0xAB
+#define FCP_PIN_STATUS			0xC6
+#define SIM_EFARR_FILEID		0x6f06
+#define ADF_USIM			0x7FFF
+#define MAX_SIM_APPS			10
+#define NOT_AVAILABLE			-1
+#define NOT_ACTIVATED			-1
+
+struct sim_data {
+	GIsiClient *client;
+	gboolean iccid;
+	gboolean registered;
+	gboolean uicc_app_started;
+	gboolean pin_state_received;
+	gboolean passwd_required;
+	int app_id;
+	int trying_app_id;
+	int app_type;
+	int trying_app_type;
+	uint8_t client_id;
+	uint8_t current_pin_id;
+	uint8_t pin1_id;
+	uint8_t pin2_id;
+};
+
+
+struct ofono_sim_local {
+	char *iccid;
+	char *imsi;
+	enum ofono_sim_phase phase;
+	unsigned char mnc_length;
+	GSList *own_numbers;
+	GSList *new_numbers;
+	GSList *service_numbers;
+	gboolean sdn_ready;
+	enum ofono_sim_state state;
+	enum ofono_sim_password_type pin_type;
+	gboolean locked_pins[OFONO_SIM_PASSWORD_INVALID];
+	char **language_prefs;
+	GQueue *simop_q;
+	gint simop_source;
+	unsigned char efmsisdn_length;
+	unsigned char efmsisdn_records;
+	unsigned char *efli;
+	unsigned char efli_length;
+	enum ofono_sim_cphs_phase cphs_phase;
+	unsigned char cphs_service_table[2];
+	struct ofono_watchlist *state_watches;
+	const struct ofono_sim_driver *driver;
+	void *driver_data;
+	struct ofono_atom *atom;
+	DBusMessage *pending;
+};
+
+
+struct sim_passwd_to_pin_id {
+	uint8_t passwd_type;
+	uint8_t pin_id;
+};
+
+static struct sim_passwd_to_pin_id const pin_ids[] =3D {
+	{OFONO_SIM_PASSWORD_NONE, 0},
+	{OFONO_SIM_PASSWORD_SIM_PIN, 1},
+	{OFONO_SIM_PASSWORD_PHSIM_PIN, 0},
+	{OFONO_SIM_PASSWORD_PHFSIM_PIN, 0},
+	{OFONO_SIM_PASSWORD_SIM_PIN2, -1},
+	{OFONO_SIM_PASSWORD_PHNET_PIN, 0x11},
+	{OFONO_SIM_PASSWORD_PHNETSUB_PIN, 0},
+	{OFONO_SIM_PASSWORD_PHSP_PIN, 0},
+	{OFONO_SIM_PASSWORD_PHCORP_PIN, 0},
+	{OFONO_SIM_PASSWORD_SIM_PUK, -1},
+	{OFONO_SIM_PASSWORD_PHFSIM_PUK, 0},
+	{OFONO_SIM_PASSWORD_SIM_PUK2, -1},
+	{OFONO_SIM_PASSWORD_PHNET_PUK, 0},
+	{OFONO_SIM_PASSWORD_PHNETSUB_PUK, 0},
+	{OFONO_SIM_PASSWORD_PHSP_PUK, 0},
+	{OFONO_SIM_PASSWORD_PHCORP_PUK, 0},
+	{OFONO_SIM_PASSWORD_INVALID, 0}
+};
+
+const uint8_t upin_id =3D 0x11;
+
+/* Current SIM */
+static struct ofono_sim *uicc_sim;
+/* UICC client */
+static GIsiClient *pn_uicc_client;
+static int uicc_users;
+
+struct sim_applications {
+	int app_list[MAX_SIM_APPS];
+	int app_type[MAX_SIM_APPS];
+};
+
+struct sim_applications *sim_application_list_p;
+
+struct file_info {
+	int fileid;
+	int length;
+	int structure;
+	int record_length;
+	unsigned char access[3];
+};
+
+static struct file_info const static_file_info[] =3D {
+	{
+		SIM_EFSPN_FILEID, 17, OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
+		0, { 0x0e, 0xff, 0xee }
+	},
+	{
+		SIM_EF_ICCID_FILEID, 10, OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
+		10, { 0x0f, 0xff, 0xee }
+	},
+	{
+		SIM_EFPL_FILEID, 1, OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
+		1, { 0x0f, 0xff, 0xff }
+	}, /* not found */
+	{
+		SIM_EFLI_FILEID, 1, OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
+		1, { 0x0f, 0xff, 0xff }
+	}, /* not found */
+	{
+		SIM_EFMSISDN_FILEID, 28, OFONO_SIM_FILE_STRUCTURE_FIXED,
+		28, { 0x01, 0xff, 0xee }
+	},
+	{
+		SIM_EFAD_FILEID, 20, OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
+		20, { 0x0e, 0xff, 0xee }
+	},
+	{
+		SIM_EFPHASE_FILEID, 1, OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
+		1, { 0x0e, 0xff, 0xee }
+	},
+	{
+		SIM_EFPNN_FILEID, 4 * 18, OFONO_SIM_FILE_STRUCTURE_FIXED,
+		18, { 0x0e, 0xff, 0xee }
+	}, /* 4 records, name 16 bytes */
+	{
+		SIM_EFOPL_FILEID, 4 * 24, OFONO_SIM_FILE_STRUCTURE_FIXED,
+		24, { 0x0e, 0xff, 0xee }
+	}, /* 4 records, name 16 bytes */
+	{
+		SIM_EFMBI_FILEID, 5, OFONO_SIM_FILE_STRUCTURE_FIXED,
+		5, { 0x0e, 0xff, 0xee }
+	},
+	{
+		SIM_EFMWIS_FILEID, 6, OFONO_SIM_FILE_STRUCTURE_FIXED,
+		6, { 0x01, 0xff, 0xee }
+	},
+	{
+		SIM_EFSPDI_FILEID, 64, OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
+		64, { 0x0e, 0xff, 0xee }
+	},
+	{
+		SIM_EFECC_FILEID, 5 * 3, OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
+		3, { 0x0e, 0xff, 0xee }
+	}, /* Can be also FIXED in 3G */
+	{
+		SIM_EFCBMIR_FILEID, 8 * 4, OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
+		4, { 0x01, 0xff, 0xee }
+	}, /* 8 records */
+	{
+		SIM_EFCBMI_FILEID, 8 * 2, OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
+		2, { 0x01, 0xff, 0xee }
+	}, /* 8 records */
+	{
+		SIM_EFCBMID_FILEID, 8 * 2, OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
+		2, { 0x01, 0xff, 0x11 }
+	}, /* 8 records */
+	{
+		SIM_EFSMSP_FILEID, 56, OFONO_SIM_FILE_STRUCTURE_FIXED,
+		56, { 0x01, 0xff, 0xee }
+	},
+	{
+		SIM_EFIMSI_FILEID, 9, OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
+		9, { 0x0e, 0xff, 0xee }
+	},
+};
+static uint8_t get_sfi(const int fileid);
+
+static void uicc_pin_prompt(struct ofono_sim *sim,
+				enum ofono_sim_password_type passwd_type,
+				ofono_sim_passwd_cb_t cb,
+				void *data,
+				uint8_t service);
+
+static void uicc_application_activate_req(GIsiClient *client,
+						void *opaque,
+						unsigned char appl_type,
+						unsigned char aid);
+
+static int sim_applications_get_next_index(struct sim_applications *sa,
+						int current_app)
+{
+	if (current_app < (MAX_SIM_APPS - 1)) {
+		int i;
+
+		for (i =3D ++current_app; i < MAX_SIM_APPS; i++) {
+			if (sa->app_list[i] &&
+				(sa->app_type[i] !=3D UICC_APPL_TYPE_UNKNOWN))
+				return i;
+		}
+	}
+
+	return NOT_AVAILABLE;
+}
+
+static uint8_t get_pin_id(struct sim_data *sd,
+				uint8_t passwd_type,
+				int8_t *index)
+{
+#define MAX_INDEX (sizeof(pin_ids)/sizeof(struct sim_passwd_to_pin_id))
+	uint8_t i, pin_id;
+	*index =3D -1;
+
+	for (i =3D 0; i <  MAX_INDEX; i++) {
+		if (pin_ids[i].passwd_type =3D=3D passwd_type)
+			*index =3D i;
+	}
+
+	switch (passwd_type) {
+	case OFONO_SIM_PASSWORD_SIM_PIN:
+	case OFONO_SIM_PASSWORD_SIM_PUK:
+		return sd->pin1_id;
+	case OFONO_SIM_PASSWORD_SIM_PIN2:
+	case OFONO_SIM_PASSWORD_SIM_PUK2:
+		return sd->pin2_id;
+	default:
+
+		if (*index =3D=3D -1)
+			pin_id =3D 0;
+		else
+			pin_id =3D pin_ids[*index].pin_id;
+
+		return pin_id;
+	}
+}
+
+static void update_locked_pin(struct ofono_sim_local *local_sim,
+				uint8_t lock_type, uint8_t pinID)
+{
+	struct sim_data *sd =3D ofono_sim_get_data((struct ofono_sim *)local_sim);
+
+	switch (lock_type) {
+	case UICC_PIN_VERIFY_NEEDED:
+
+		if (pinID <=3D sd->pin1_id) {
+			local_sim->pin_type =3D
+				OFONO_SIM_PASSWORD_SIM_PIN;
+			local_sim->locked_pins[
+				OFONO_SIM_PASSWORD_SIM_PIN] =3D TRUE;
+			sd->passwd_required =3D TRUE;
+		} else if (pinID =3D=3D sd->pin2_id) {
+			local_sim->pin_type =3D
+				OFONO_SIM_PASSWORD_SIM_PIN2;
+			local_sim->locked_pins[
+				OFONO_SIM_PASSWORD_SIM_PIN2] =3D TRUE;
+			sd->passwd_required =3D TRUE;
+		} else if (pinID =3D=3D upin_id) {
+			local_sim->pin_type =3D
+				OFONO_SIM_PASSWORD_PHNET_PIN;
+			local_sim->locked_pins[
+				OFONO_SIM_PASSWORD_PHNET_PIN] =3D TRUE;
+			sd->passwd_required =3D TRUE;
+		}
+
+		break;
+	case UICC_PIN_UNBLOCK_NEEDED:
+
+		if (pinID =3D=3D sd->pin1_id) {
+			local_sim->pin_type =3D
+				OFONO_SIM_PASSWORD_SIM_PUK;
+			local_sim->locked_pins[
+				OFONO_SIM_PASSWORD_SIM_PUK] =3D TRUE;
+			sd->passwd_required =3D TRUE;
+		} else if (pinID =3D=3D sd->pin2_id) {
+			local_sim->pin_type =3D
+				OFONO_SIM_PASSWORD_SIM_PUK2;
+			local_sim->locked_pins[
+				OFONO_SIM_PASSWORD_SIM_PUK2] =3D TRUE;
+			sd->passwd_required =3D TRUE;
+		} else if (pinID =3D=3D upin_id) {
+			local_sim->pin_type =3D
+				OFONO_SIM_PASSWORD_PHNET_PUK;
+			local_sim->locked_pins[
+				OFONO_SIM_PASSWORD_PHNET_PUK] =3D TRUE;
+			sd->passwd_required =3D TRUE;
+		}
+
+		break;
+	default:
+		break;
+	}
+}
+
+static gboolean get_fileid_path(struct ofono_sim *sim,
+				int *mf_path,
+				int *df1_path,
+				int *df2_path,
+				unsigned char *df_len,
+				int fileid)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+
+	switch (fileid) {
+	case SIM_EFPL_FILEID:
+	case SIM_EF_ICCID_FILEID:
+		*mf_path =3D MF_FILEID;
+		*df1_path =3D 0x0000;
+		*df2_path =3D 0x0000;
+		*df_len =3D 2;
+		break;
+	case SIM_EFSMSP_FILEID:
+	case SIM_EFSDN_FILEID:
+	case SIM_EFMSISDN_FILEID:
+		*mf_path =3D MF_FILEID;
+
+		if (UICC_APPL_TYPE_ICC_SIM =3D=3D sd->app_type)
+			*df1_path =3D DFTELECOM_FILEID;
+		else
+			*df1_path =3D ADF_USIM;
+
+		*df2_path =3D 0x0000;
+		*df_len =3D 4;
+		break;
+	case SIM_EFLI_FILEID:
+	case SIM_EFSPN_FILEID:
+	case SIM_EFAD_FILEID:
+	case SIM_EFPNN_FILEID:
+	case SIM_EFOPL_FILEID:
+	case SIM_EFMBDN_FILEID:
+	case SIM_EFMBI_FILEID:
+	case SIM_EFMWIS_FILEID:
+	case SIM_EFSPDI_FILEID:
+	case SIM_EFECC_FILEID:
+	case SIM_EFCBMI_FILEID:
+	case SIM_EFCBMIR_FILEID:
+	case SIM_EFCBMID_FILEID:
+	case SIM_EFIMSI_FILEID:
+	case SIM_EFPHASE_FILEID: /*Did not find in TS 31.102 v6.21.0*/
+	case SIM_EFARR_FILEID:
+	case SIM_EF_CPHS_INFORMATION_FILEID: /*Found from unofficial source*/
+		*mf_path =3D MF_FILEID;
+
+		if (UICC_APPL_TYPE_ICC_SIM =3D=3D sd->app_type)
+			*df1_path =3D DFGSM_FILEID;
+		else
+			*df1_path =3D ADF_USIM;
+
+		*df2_path =3D 0x0000;
+		*df_len =3D 4;
+		break;
+		/* No info */
+	case SIM_EF_CPHS_MBDN_FILEID:
+	case SIM_EF_CPHS_MWIS_FILEID:
+		DBG("=3D=3D=3D=3D=3D=3D=3D=3D No path info for %04X", fileid);
+		return FALSE;
+	case SIM_EFADN_SIM_FILEID: /* Only for SIM */
+	case SIM_EFEXT1_SIM_FILEID: /* Only for SIM */
+		*mf_path =3D MF_FILEID;
+		*df1_path =3D DFTELECOM_FILEID;
+		*df2_path =3D 0x0000;
+		*df_len =3D 4;
+		break;
+	default:
+		*mf_path =3D MF_FILEID;
+		*df1_path =3D DFTELECOM_FILEID;
+		*df2_path =3D DFPHONEBOOK_FILEID;
+		*df_len =3D 6;
+		break;
+	}
+
+	return TRUE;
+}
+
+static uint8_t get_sfi(const int fileid)
+{
+	uint8_t ret;
+
+	/* SFI list from 3GPP TS 31.102 Annex H */
+	switch (fileid) {
+	case SIM_EFECC_FILEID:
+		ret =3D 01;
+		break;
+	case SIM_EFLI_FILEID:
+		ret =3D 02;
+		break;
+	case SIM_EFAD_FILEID:
+		ret =3D 03;
+		break;
+	case SIM_EFIMSI_FILEID:
+		ret =3D 07;
+		break;
+	case SIM_EFCBMID_FILEID:
+		ret =3D 0x0E;
+		break;
+	case SIM_EFPNN_FILEID:
+		ret =3D 0x19;
+		break;
+	case SIM_EFOPL_FILEID:
+		ret =3D 0x1A;
+		break;
+	default:
+		ret =3D UICC_SFI_NOT_PRESENT;
+		break;
+	}
+
+	return ret;
+}
+
+int get_app_id()
+{
+	if (uicc_sim) {
+		struct sim_data *sd =3D ofono_sim_get_data(uicc_sim);
+		DBG("app_id %d", sd->app_id);
+		return sd->app_id;
+	} else
+		return -1;
+}
+
+int get_app_type()
+{
+	if (uicc_sim) {
+		struct sim_data *sd =3D ofono_sim_get_data(uicc_sim);
+		DBG("app_type %d", sd->app_type);
+		return sd->app_type;
+	} else
+		return -1;
+}
+
+int get_client_id()
+{
+	if (uicc_sim) {
+		struct sim_data *sd =3D ofono_sim_get_data(uicc_sim);
+		DBG("client_id %d", sd->client_id);
+		return sd->client_id;
+	} else
+		return -1;
+}
+
+GIsiClient *read_pn_uicc_client()
+{
+	return pn_uicc_client;
+}
+
+struct ofono_sim *get_sim()
+{
+	return uicc_sim;
+}
+
+/* Returns file info */
+#ifdef STATIC_FILE_INFO
+static gboolean fake_file_info(gpointer user)
+{
+	struct isi_cb_data *cbd =3D user;
+	ofono_sim_file_info_cb_t cb =3D cbd->cb;
+	struct file_info const *fi =3D cbd->user;
+	DBG("Returning static file info: Fileid=3D%04X, \
+		filelen=3D%d, reclen=3D%d, structure=3D%d",
+		fi->fileid, fi->length, fi->record_length, fi->structure);
+	CALLBACK_WITH_SUCCESS(cb, fi->length, fi->structure,
+				fi->record_length, fi->access, cbd->data);
+	g_free(cbd);
+	return FALSE;
+}
+#else
+static gboolean isi_file_info_resp(GIsiClient *client,
+					const void *restrict data,
+					size_t len,
+					uint16_t object,
+					void *opaque)
+{
+	const unsigned char *msg =3D data;
+	struct isi_cb_data *cbd =3D opaque;
+	ofono_sim_file_info_cb_t cb =3D cbd->cb;
+	uint16_t length =3D 0;
+	uint16_t record_length =3D 0;
+	uint8_t structure =3D -1;
+	uint8_t records =3D 0;
+	uint16_t file_id =3D 0;
+	uint8_t access[3] =3D {0, 0, 0};
+	uint8_t fcp_len =3D 0, read =3D 0, id =3D 0, item_len =3D 0;
+	uint8_t fcp =3D 0, desc =3D 0, coding =3D 0;
+	gboolean everything_ok =3D FALSE;
+	/*Access is read from static file info*/
+	struct file_info const *info =3D cbd->user;
+	GIsiSubBlockIter iter;
+	struct sim_data *sd =3D ofono_sim_get_data(uicc_sim);
+
+	if (!msg) {
+		DBG("ISI client error: %d", g_isi_client_error(client));
+		goto error;
+	}
+
+	DBG("%s, service %s, status %s, details %d",
+		uicc_message_id_name(msg[0]),
+		uicc_service_type_name(msg[1]),
+		uicc_status_name(msg[2]), msg[3]);
+
+	if (msg[0] !=3D UICC_APPL_CMD_RESP)
+		goto error;
+
+	if (msg[1] !=3D UICC_APPL_FILE_INFO)
+		goto error;
+
+	if (msg[2] !=3D UICC_STATUS_OK)
+		goto error;
+
+	if (info) {
+		access[0] =3D info->access[0];
+		access[1] =3D info->access[1];
+		access[2] =3D info->access[2];
+	}
+
+	g_isi_sb_iter_init_full(&iter, msg, len, 7, TRUE, msg[6]);
+
+	while (g_isi_sb_iter_is_valid(&iter)) {
+		DBG("Sub-block %s",
+			uicc_subblock_name(g_isi_sb_iter_get_id(&iter)));
+
+		switch (g_isi_sb_iter_get_id(&iter)) {
+		case UICC_SB_FCI:
+			DBG("UICC_SB_FCI");
+			everything_ok =3D TRUE;
+
+			switch (sd->app_type) {
+			case UICC_APPL_TYPE_UICC_USIM:
+				DBG("UICC_APPL_TYPE_UICC_USIM");
+				(void) g_isi_sb_iter_get_byte(&iter, &fcp, 8);
+
+				if (fcp =3D=3D FCP_TEMPLATE) {
+					(void) g_isi_sb_iter_get_byte(&iter,
+								      &fcp_len,
+								      9);
+
+					while (read < fcp_len) {
+						(void) g_isi_sb_iter_get_byte(
+							&iter, &id, read + 10);
+						(void) g_isi_sb_iter_get_byte(
+							&iter, &item_len,
+							read + 11);
+
+						switch (id) {
+						case FCP_FILE_SIZE:
+
+							if (item_len =3D=3D 2) {
+								g_isi_sb_iter_get_word(
+									&iter,
+									&length,
+									read + 10 + 2);
+							}
+
+							break;
+						case FCP_FILE_ID:
+
+							if (item_len =3D=3D 2) {
+								g_isi_sb_iter_get_word(
+									&iter,
+									&file_id,
+									read + 10 + 2);
+							}
+
+							break;
+						case FCP_FILE_DESC:
+
+							if (item_len >=3D 2) {
+								(void) g_isi_sb_iter_get_byte(
+									&iter,
+									&desc,
+									read + 10 + 2);
+								(void) g_isi_sb_iter_get_byte(
+									&iter,
+									&coding,
+									read + 10 + 3);
+							}
+
+							if (item_len >=3D 4) {
+								g_isi_sb_iter_get_word(
+									&iter,
+									&record_length,
+									read + 10 + 4);
+								(void) g_isi_sb_iter_get_byte(
+									&iter,
+									&records,
+									read + 10 + 6);
+							}
+
+							break;
+						case FCP_FILE_SECURITY_ARR:
+						case FCP_FILE_SECURITY_COMPACT:
+						case FCP_FILE_SECURITY_EXPANDED:
+
+						/* Not implemented, using static
+						 * access rules as these are
+						 * used only for cacheing See
+						 * ETSI TS 102 221, ch
+						 * 11.1.1.4.7 and
+						 * Annexes E,F and G
+						 */
+
+						case FCP_FILE_LIFECYCLE:
+						default:
+							DBG("FCP id %02X not supported",
+								id);
+							break;
+						}
+
+						/*Data length + id size + len size*/
+						read +=3D item_len + 2;
+					}
+				}
+
+				if ((desc & 7) =3D=3D 1)
+					structure =3D
+					  OFONO_SIM_FILE_STRUCTURE_TRANSPARENT;
+				else if ((desc & 7) =3D=3D 2)
+					structure =3D
+					  OFONO_SIM_FILE_STRUCTURE_FIXED;
+				else if ((desc & 7) =3D=3D 6)
+					structure =3D
+					  OFONO_SIM_FILE_STRUCTURE_CYCLIC;
+
+				break;
+			case UICC_APPL_TYPE_ICC_SIM:
+				DBG("UICC_APPL_TYPE_ICC_SIM");
+				g_isi_sb_iter_get_word(&iter, &length, 10);
+				g_isi_sb_iter_get_word(&iter, &file_id, 12);
+				(void)g_isi_sb_iter_get_byte(&iter,
+								&access[0], 16);
+				(void)g_isi_sb_iter_get_byte(&iter,
+								&access[0], 17);
+				(void)g_isi_sb_iter_get_byte(&iter,
+								&access[0], 18);
+				(void)g_isi_sb_iter_get_byte(&iter,
+								&item_len, 20);
+				(void)g_isi_sb_iter_get_byte(&iter,
+								&structure, 21);
+
+				if (item_len =3D=3D 2)
+					(void)g_isi_sb_iter_get_byte(&iter,
+								     (uint8_t *)&record_length, 22);
+
+				break;
+			default:
+				DBG("UICC application type %d not supported",
+					sd->app_type);
+				break;
+			}
+
+			break;
+		default:
+			DBG("Skipping SB");
+			break;
+		}
+
+		if (g_isi_sb_iter_next(&iter) =3D=3D FALSE)
+			goto error;
+	}
+
+	if (everything_ok) {
+		DBG("=3D=3D=3D=3DReturning real file info: Fileid=3D%04X, filelen=3D%d, \
+			records=3D%d, reclen=3D%d, structure=3D%d",
+			file_id, length, records,
+			record_length, structure);
+		CALLBACK_WITH_SUCCESS(cb, length, structure, record_length,
+				      access, '\n', cbd->data);
+		goto out;
+	}
+
+error:
+	DBG("Error reading file info");
+	CALLBACK_WITH_FAILURE(cb, 0, 0, 0, access, '\n', cbd->data);
+out:
+	g_free(cbd);
+	return TRUE;
+}
+
+#endif /* STATIC_FILE_INFO */
+static void isi_read_file_info(struct ofono_sim *sim, int fileid,
+				ofono_sim_file_info_cb_t cb, void *data)
+{
+#ifdef STATIC_FILE_INFO
+	int i;
+	int N =3D sizeof(static_file_info) / sizeof(static_file_info[0]);
+	struct isi_cb_data *cbd =3D NULL;
+
+	for (i =3D 0; i < N; i++) {
+		if (fileid =3D=3D static_file_info[i].fileid) {
+			cbd =3D isi_cb_data_new((void *) &static_file_info[i],
+						cb, data);
+			g_idle_add(fake_file_info, cbd);
+			return;
+		}
+	}
+
+	DBG("Not implemented (fileid =3D %04x)", fileid);
+	CALLBACK_WITH_FAILURE(cb, -1, -1, -1, NULL, data);
+#else
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(NULL, cb, data);
+	/* Prepare for static file info used for access rights */
+	int i;
+	int N =3D sizeof(static_file_info) / sizeof(static_file_info[0]);
+	int mf_path =3D 0;
+	int df1_path =3D 0;
+	int df2_path =3D 0;
+	unsigned char df_len =3D 0;
+
+	DBG("File info for ID=3D%04X app id %d", fileid, sd->app_id);
+
+	for (i =3D 0; i < N; i++) {
+		if (fileid =3D=3D static_file_info[i].fileid && cbd !=3D NULL) {
+			cbd->user =3D (void *) &static_file_info[i];
+			continue;
+		}
+	}
+	if (!get_fileid_path(sim, &mf_path, &df1_path,
+				&df2_path, &df_len, fileid))
+		goto error;
+	if (cbd && sd) {
+		const unsigned char msg[] =3D {
+			UICC_APPL_CMD_REQ,
+			UICC_APPL_FILE_INFO,
+			sd->app_id,
+			UICC_SESSION_ID_NOT_USED, /*Session ID*/
+			0, /*Filler*/
+			0, /*Filler*/
+			1, /*number of subblocks*/
+		/* Subblock 1*/
+			UICC_SB_APPL_PATH >> 8,
+			UICC_SB_APPL_PATH & 0xff,
+			0,
+			16, /*Sub block length*/
+			fileid >> 8, /* UICC elementary file ID*/
+			fileid & 0xFF,
+			get_sfi(fileid), /* Elementary file short file id*/
+			0, /*filler*/
+			df_len, /*DF Path length*/
+			0, /*Filler*/
+			mf_path >> 8,
+			mf_path & 0xff,
+			df1_path >> 8, /*DF Path*/
+			df1_path & 0xFF,
+			df2_path >> 8, /*DF Path*/
+			df2_path & 0xFF,
+		};
+		g_isi_request_make(
+			sd->client, msg, sizeof(msg), SIM_TIMEOUT,
+			isi_file_info_resp, cbd);
+		return;
+	}
+
+error:
+	DBG("Not implemented (fileid =3D %04x)", fileid);
+	CALLBACK_WITH_FAILURE(cb, 0, 0, 0, NULL, '\n', cbd->data);
+	g_free(cbd);
+	return;
+#endif /* STATIC_FILE_INFO */
+}
+
+static gboolean isi_read_file_transparent_resp(GIsiClient *client,
+						const void *restrict data,
+						size_t len,
+						uint16_t object,
+						void *opaque)
+{
+	const unsigned char *msg =3D data;
+	struct isi_cb_data *cbd =3D opaque;
+	ofono_sim_read_cb_t cb =3D cbd->cb;
+	uint32_t filelen =3D 0;
+	unsigned char filedata[256] =3D { 0xff };
+	gboolean everything_ok =3D FALSE;
+	GIsiSubBlockIter iter;
+
+	if (!msg) {
+		DBG("ISI client error: %d", g_isi_client_error(client));
+		goto error;
+	}
+
+	DBG("%s, service %s, status %s, details %d",
+		uicc_message_id_name(msg[0]),
+		uicc_service_type_name(msg[1]),
+		uicc_status_name(msg[2]), msg[3]);
+
+	if (msg[0] !=3D UICC_APPL_CMD_RESP)
+		goto error;
+
+	if (msg[1] !=3D UICC_APPL_READ_TRANSPARENT)
+		goto error;
+
+	if (msg[2] !=3D UICC_STATUS_OK)
+		goto error;
+
+	g_isi_sb_iter_init_full(&iter, msg, len, 7, TRUE, msg[6]);
+
+	while (g_isi_sb_iter_is_valid(&iter)) {
+		DBG("Sub-block %s",
+			uicc_subblock_name(g_isi_sb_iter_get_id(&iter)));
+
+		switch (g_isi_sb_iter_get_id(&iter)) {
+		case UICC_SB_FILE_DATA:
+			g_isi_sb_iter_get_dword(&iter, &filelen, 4);
+			memmove(&filedata, iter.start + 8, filelen);
+			everything_ok =3D TRUE;
+			break;
+		default:
+			break;
+		}
+
+		g_isi_sb_iter_next(&iter);
+	}
+
+	if (everything_ok) {
+		DBG("Transparent EF read: 1st byte %02x, len %d",
+			filedata[0], filelen);
+		CALLBACK_WITH_SUCCESS(cb, filedata, filelen, cbd->data);
+		goto out;
+	}
+
+error:
+	DBG("Error reading transparent EF");
+	CALLBACK_WITH_FAILURE(cb, NULL, 0, cbd->data);
+out:
+	g_free(cbd);
+	return TRUE;
+}
+
+static void isi_read_file_transparent(struct ofono_sim *sim,
+					int fileid,
+					int start,
+					int length,
+					ofono_sim_read_cb_t cb,
+					void *data)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(sim, cb, data);
+	int mf_path =3D 0;
+	int df1_path =3D 0;
+	int df2_path =3D 0;
+	unsigned char df_len =3D 0;
+
+	DBG("File ID=3D%04X, client %d, AID %d",
+		fileid, sd->client_id, sd->app_id);
+
+	if (!get_fileid_path(sim, &mf_path, &df1_path,
+			&df2_path, &df_len, fileid))
+		goto error;
+
+	if (cbd && sd) {
+		const unsigned char msg[] =3D {
+			UICC_APPL_CMD_REQ,
+			UICC_APPL_READ_TRANSPARENT,
+			sd->app_id,
+			UICC_SESSION_ID_NOT_USED, /*Session ID*/
+			0, /*Filler*/
+			0, /*Filler*/
+			3, /*number of subblocks*/
+		/* Subblock 1 */
+			UICC_SB_CLIENT >> 8,
+			UICC_SB_CLIENT & 0xff,
+			0,
+			8, /*Sub block length*/
+			0, 0, 0, /* Filler */
+			sd->client_id,
+		/* Subblock 2*/
+			UICC_SB_TRANSPARENT >> 8,
+			UICC_SB_TRANSPARENT & 0xff,
+			0, /*Sub block length*/
+			8, /*Sub block length*/
+			0, /*File offset (0=3Dbeginning)*/
+			0, /*File offset (0=3Dbeginning)*/
+			0, /*Data amount (0=3Dall)*/
+			0, /*Data amount (0=3Dall)*/
+		/* Subblock 3 */
+			UICC_SB_APPL_PATH >> 8,
+			UICC_SB_APPL_PATH & 0xff,
+			0,
+			16, /* Sub block length*/
+			fileid >> 8, /* UICC elementary file ID*/
+			fileid & 0xFF,
+			get_sfi(fileid), /* Elementary file short file id*/
+			0, /*filler*/
+			df_len, /*DF Path length*/
+			0, /*Filler*/
+			mf_path >> 8,
+			mf_path & 0xff,
+			df1_path >> 8, /*DF Path*/
+			df1_path & 0xFF,
+			df2_path >> 8, /*DF Path*/
+			df2_path & 0xFF
+		};
+		g_isi_request_make(
+			sd->client, msg, sizeof(msg), SIM_TIMEOUT,
+			isi_read_file_transparent_resp, cbd);
+		return;
+	}
+
+error:
+	DBG("Not implemented (fileid =3D %04x)", fileid);
+	CALLBACK_WITH_FAILURE(cb, NULL, 0, data);
+	g_free(cbd);
+	return;
+}
+
+static gboolean isi_read_file_linear_fixed_resp(GIsiClient *client,
+						const void *restrict data,
+						size_t len,
+						uint16_t object,
+						void *opaque)
+{
+	const unsigned char *msg =3D data;
+	struct isi_cb_data *cbd =3D opaque;
+	ofono_sim_read_cb_t cb =3D cbd->cb;
+	uint32_t filelen =3D 0;
+	unsigned char filedata[256] =3D { 0xff };
+	gboolean everything_ok =3D FALSE;
+	GIsiSubBlockIter iter;
+
+	if (!msg) {
+		DBG("ISI client error: %d", g_isi_client_error(client));
+		goto error;
+	}
+
+	DBG("%s, service %s, status %s, details %d",
+		uicc_message_id_name(msg[0]),
+		uicc_service_type_name(msg[1]),
+		uicc_status_name(msg[2]), msg[3]);
+
+	if (msg[0] !=3D UICC_APPL_CMD_RESP)
+		goto error;
+
+	if (msg[1] !=3D UICC_APPL_READ_LINEAR_FIXED)
+		goto error;
+
+	if (msg[2] !=3D UICC_STATUS_OK)
+		goto error;
+
+	everything_ok =3D FALSE;
+	g_isi_sb_iter_init_full(&iter, msg, len, 7, TRUE, msg[6]);
+
+	while (g_isi_sb_iter_is_valid(&iter)) {
+		DBG("Sub-block %s",
+			uicc_subblock_name(g_isi_sb_iter_get_id(&iter)));
+
+		switch (g_isi_sb_iter_get_id(&iter)) {
+		case UICC_SB_FILE_DATA:
+			g_isi_sb_iter_get_dword(&iter, &filelen, 4);
+			memmove(&filedata, iter.start + 8, filelen);
+			everything_ok =3D TRUE;
+			break;
+		default:
+			break;
+		}
+
+		g_isi_sb_iter_next(&iter);
+	}
+
+	if (everything_ok) {
+		DBG("Linear fixed EF read: 1st byte %02x, len %d",
+			filedata[0], filelen);
+		CALLBACK_WITH_SUCCESS(cb, filedata, filelen, cbd->data);
+		goto out;
+	}
+
+error:
+	DBG("Error reading linear fixed EF");
+	CALLBACK_WITH_FAILURE(cb, NULL, 0, cbd->data);
+out:
+	g_free(cbd);
+	return TRUE;
+}
+
+static void isi_read_file_linear_fixed(struct ofono_sim *sim,
+					int fileid,
+					int record,
+					int rec_length,
+					ofono_sim_read_cb_t cb,
+					void *data)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(sim, cb, data);
+	int mf_path =3D 0;
+	int df1_path =3D 0;
+	int df2_path =3D 0;
+	unsigned char df_len =3D 0;
+	DBG("File ID=3D%04X, record %d, client %d AID %d",
+		fileid, record, sd->client_id, sd->app_id);
+	if (!get_fileid_path(sim, &mf_path,
+			&df1_path, &df2_path, &df_len, fileid))
+		goto error;
+	if (cbd && sd) {
+
+		const unsigned char msg[] =3D {
+			UICC_APPL_CMD_REQ,
+			UICC_APPL_READ_LINEAR_FIXED,
+			sd->app_id,
+			UICC_SESSION_ID_NOT_USED, /*Session ID*/
+			0, /*Filler*/
+			0, /*Filler*/
+			3, /*number of subblocks*/
+		/* Subblock 1*/
+			UICC_SB_CLIENT >> 8,
+			UICC_SB_CLIENT & 0xff,
+			0,
+			8, /*Sub block length */
+			0, 0, 0, /* Filler */
+			sd->client_id,
+		/* Subblock 2 */
+			UICC_SB_LINEAR_FIXED >> 8,
+			UICC_SB_LINEAR_FIXED & 0xff,
+			0, /*Sub block length*/
+			8, /*Sub block length*/
+			record, /*Record*/
+			0, /*Record offset (0=3Dbeginning)*/
+			rec_length & 0xff, /*Data amount (0=3Dall)*/
+			0, /*Filler*/
+		/* Subblock 3*/
+			UICC_SB_APPL_PATH >> 8,
+			UICC_SB_APPL_PATH & 0xff,
+			0,
+			16, /*Sub block length*/
+			fileid >> 8, /* UICC elementary file ID*/
+			fileid & 0xFF,
+			get_sfi(fileid), /* Elementary file short file id*/
+			0, /*filler*/
+			df_len, /*DF Path length*/
+			0, /*Filler*/
+			mf_path >> 8,
+			mf_path & 0xff,
+			df1_path >> 8, /*DF Path*/
+			df1_path & 0xFF,
+			df2_path >> 8, /*DF Path*/
+			df2_path & 0xFF
+		};
+		g_isi_request_make(
+			sd->client, msg, sizeof(msg), SIM_TIMEOUT,
+			isi_read_file_linear_fixed_resp, cbd);
+		return;
+	}
+
+error:
+	DBG("Not implemented (fileid =3D %04x)", fileid);
+	CALLBACK_WITH_FAILURE(cb, NULL, 0, data);
+	g_free(cbd);
+}
+
+#ifdef READ_FILE_CYCLIC
+static gboolean isi_read_file_cyclic_resp(GIsiClient *client,
+						const void *restrict data,
+						size_t len,
+						uint16_t object,
+						void *opaque)
+{
+	const unsigned char *msg =3D data;
+	struct isi_cb_data *cbd =3D opaque;
+	ofono_sim_read_cb_t cb =3D cbd->cb;
+	uint32_t filelen =3D 0;
+	unsigned char filedata[256] =3D { 0xff };
+	gboolean everything_ok =3D FALSE;
+	GIsiSubBlockIter iter;
+
+	if (!msg) {
+		DBG("ISI client error: %d", g_isi_client_error(client));
+		goto error;
+	}
+
+	DBG("%s, service %s, status %s, details %d",
+		uicc_message_id_name(msg[0]),
+		uicc_service_type_name(msg[1]),
+		uicc_status_name(msg[2]), msg[3]);
+
+	if (msg[0] !=3D UICC_APPL_CMD_RESP)
+		goto error;
+
+	if (msg[1] !=3D UICC_APPL_READ_CYCLIC)
+		goto error;
+
+	if (msg[2] !=3D UICC_STATUS_OK)
+		goto error;
+
+	everything_ok =3D FALSE;
+	g_isi_sb_iter_init_full(&iter, msg, len, 7, TRUE, msg[6]);
+
+	while (g_isi_sb_iter_is_valid(&iter)) {
+		DBG("Sub-block %s",
+			uicc_subblock_name(g_isi_sb_iter_get_id(&iter)));
+
+		switch (g_isi_sb_iter_get_id(&iter)) {
+		case UICC_SB_FILE_DATA:
+			g_isi_sb_iter_get_dword(&iter, &filelen, 4);
+			memmove(&filedata, iter.start + 8, filelen);
+			everything_ok =3D TRUE;
+			break;
+		default:
+			break;
+		}
+
+		g_isi_sb_iter_next(&iter);
+	}
+
+	if (everything_ok) {
+		DBG("Cyclic EF read: 1st byte %02x, len %d",
+			filedata[0], filelen);
+		CALLBACK_WITH_SUCCESS(cb, filedata, filelen, cbd->data);
+		goto out;
+	}
+
+error:
+	DBG("Error reading cyclic EF");
+	CALLBACK_WITH_FAILURE(cb, NULL, 0, cbd->data);
+
+out:
+	g_free(cbd);
+	return TRUE;
+}
+
+static void isi_read_file_cyclic(struct ofono_sim *sim,
+					int fileid,
+					int record,
+					int rec_length,
+					ofono_sim_read_cb_t cb, void *data)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(sim, cb, data);
+	int mf_path =3D 0;
+	int df1_path =3D 0;
+	int df2_path =3D 0;
+	unsigned char df_len =3D 0;
+	DBG("File ID=3D%04X, record %d, client %d AID %d",
+		fileid, record, sd->client_id, sd->app_id);
+
+	if (!get_fileid_path(sim, &mf_path,
+			&df1_path, &df2_path, &df_len, fileid))
+		goto error;
+
+	if (cbd && sd) {
+		const unsigned char msg[] =3D {
+			UICC_APPL_CMD_REQ,
+			UICC_APPL_READ_LINEAR_FIXED,
+			sd->app_id,
+			UICC_SESSION_ID_NOT_USED, /*Session ID*/
+			0, /*Filler*/
+			0, /*Filler*/
+			3, /*number of subblocks*/
+		/* Subblock 1 */
+			UICC_SB_CLIENT >> 8,
+			UICC_SB_CLIENT & 0xff,
+			0,
+			8, /*Sub block length*/
+			0, 0, 0, /* Filler*/
+			sd->client_id,
+		/* Subblock 2 */
+			UICC_SB_CYCLIC >> 8,
+			UICC_SB_CYCLIC & 0xff,
+			0, /*Sub block length*/
+			8, /*Sub block length*/
+			record, /*Record*/
+			0, /*Record offset (0=3Dbeginning)*/
+			rec_length & 0xff, /*Data amount (0=3Dall)*/
+			0, /*Filler*/
+		/* Subblock 3 */
+			UICC_SB_APPL_PATH >> 8,
+			UICC_SB_APPL_PATH & 0xff,
+			0,
+			16, /* Sub block length */
+			fileid >> 8, /* UICC elementary file ID */
+			fileid & 0xFF,
+			/* Elementary file short file id */
+			get_sfi(fileid),
+			0, /*filler*/
+			df_len, /*DF Path length*/
+			0, /*Filler*/
+			mf_path >> 8,
+			mf_path & 0xff,
+			df1_path >> 8, /*DF Path*/
+			df1_path & 0xFF,
+			df2_path >> 8, /*DF Path*/
+			df2_path & 0xFF
+		};
+		g_isi_request_make(
+			sd->client, msg, sizeof(msg), SIM_TIMEOUT,
+			isi_read_file_cyclic_resp, cbd);
+		return;
+	}
+
+error:
+	DBG("Not implemented (fileid =3D %04x)", fileid);
+	CALLBACK_WITH_FAILURE(cb, NULL, 0, data);
+	g_free(cbd);
+}
+#endif
+
+static void uicc_read_imsi_resp(const struct ofono_error *error,
+				const unsigned char *data,
+				int len,
+				void *user)
+{
+#define SIM_MAX_IMSI_LENGTH     15
+	struct isi_cb_data *cbd =3D user;
+	ofono_sim_imsi_cb_t cb =3D cbd->cb;
+	/* For coding see TS 24.008 */
+	char imsi[SIM_MAX_IMSI_LENGTH + 1];
+	int i =3D 1; /*Skip length, the 1st byte*/
+	int j =3D 0;
+	int octets;
+
+	if (!data)
+		goto error;
+
+	octets =3D data[0];
+
+	if (octets !=3D 8 || octets > len)
+		goto error;
+
+	/* Ignore the low-order semi-octet of the first byte */
+	imsi[j] =3D ((data[i] & 0xF0) >> 4) + '0';
+
+	for (i++, j++; i - 1 < octets && j < SIM_MAX_IMSI_LENGTH; i++) {
+		char nibble;
+		imsi[j++] =3D (data[i] & 0x0F) + '0';
+		nibble =3D (data[i] & 0xF0) >> 4;
+
+		if (nibble !=3D 0x0F)
+			imsi[j++] =3D nibble + '0';
+	}
+
+	imsi[j] =3D '\0';
+	DBG("IMSI %s", imsi);
+	CALLBACK_WITH_SUCCESS(cb, imsi, cbd->data);
+	goto out;
+error:
+	CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
+out:
+	g_free(cbd);
+	return;
+}
+
+static void uicc_read_imsi_req(struct ofono_sim *sim,
+				ofono_sim_imsi_cb_t cb,
+				void *data)
+{
+	struct isi_cb_data *cbd =3D isi_cb_data_new(sim, cb, data);
+	isi_read_file_transparent(sim, SIM_EFIMSI_FILEID, 0, 9,
+					uicc_read_imsi_resp, cbd);
+}
+
+static gboolean uicc_application_activate_resp(GIsiClient *client,
+		const void *restrict data,
+		size_t len,
+		uint16_t object,
+		void *opaque)
+{
+	const unsigned char *msg =3D data;
+	struct ofono_sim *sim =3D opaque;
+	GIsiSubBlockIter iter;
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+
+	DBG("");
+
+	if (!msg) {
+		DBG("ISI client error: %d", g_isi_client_error(client));
+		goto error;
+	}
+
+	DBG("%s, service=3D%s, status=3D%s details=3D%d",
+		uicc_message_id_name(msg[0]),
+		uicc_service_type_name(msg[1]),
+		uicc_status_name(msg[2]), msg[3]);
+
+	if (msg[0] !=3D UICC_APPLICATION_RESP)
+		goto error;
+
+	if ((msg[2] =3D=3D UICC_STATUS_OK) ||
+			(msg[2] =3D=3D UICC_STATUS_APPL_ACTIVE)) {
+		if (!sd->uicc_app_started) {
+			sd->app_id =3D sd->trying_app_id;
+			sd->app_type =3D sd->trying_app_type;
+			sd->uicc_app_started =3D TRUE;
+			DBG("UICC application activated");
+			ofono_sim_inserted_notify(sim, TRUE);
+			ofono_sim_register(sim);
+			g_free(sim_application_list_p);
+		}
+	} else {
+		int i =3D sim_applications_get_next_index(
+				sim_application_list_p, sd->trying_app_id);
+
+		if (i =3D=3D NOT_AVAILABLE) {
+			g_free(sim_application_list_p);
+			goto error;
+		}
+
+		DBG("Activation Error, trying to activate APP with ID:%d", i);
+		uicc_application_activate_req(client, sim,
+						sim_application_list_p->app_type[i],
+						sim_application_list_p->app_list[i]);
+		goto error;
+	}
+
+	g_isi_sb_iter_init_full(&iter, msg, len, 7, TRUE, msg[6]);
+
+	while (g_isi_sb_iter_is_valid(&iter)) {
+		DBG("Sub-block %s",
+			uicc_subblock_name(g_isi_sb_iter_get_id(&iter)));
+
+		switch (g_isi_sb_iter_get_id(&iter)) {
+		case UICC_SB_CLIENT: {
+			guint8 client =3D 0;
+			g_isi_sb_iter_get_byte(&iter, &client, 7);
+			DBG("Client id %d", client);
+			sd->client_id =3D client;
+			break;
+		}
+		case UICC_SB_FCI:
+			DBG("UICC_SB_FCI");
+
+			if (sd->app_type =3D=3D UICC_APPL_TYPE_UICC_USIM) {
+				uint8_t fcp =3D 0, fcp_len =3D 0, read =3D 0,
+					id =3D 0, item_len =3D 0;
+				(void) g_isi_sb_iter_get_byte(&iter, &fcp, 8);
+				DBG("UICC_APPL_TYPE_UICC_USIM");
+
+				if (fcp =3D=3D FCP_TEMPLATE) {
+					(void) g_isi_sb_iter_get_byte(
+						&iter, &fcp_len, 9);
+					DBG("FCP_TEMPLATE");
+
+					while (read < fcp_len) {
+						(void) g_isi_sb_iter_get_byte(
+							&iter, &id, read + 10);
+						(void) g_isi_sb_iter_get_byte(
+							&iter, &item_len,
+							read + 11);
+
+						/* See TS 102 221,
+						*  PIN status template DO */
+						switch (id) {
+							uint8_t pin_do_len, pin_len,
+								pin_tag, pin_id,
+								pin_tag_pos;
+
+						case FCP_PIN_STATUS:
+
+							DBG("PIN status");
+							g_isi_sb_iter_get_byte(&iter,
+										&pin_do_len,
+										read + 10 + 3);
+							pin_tag_pos =3D
+								read + 10 + 4 + pin_do_len;
+							g_isi_sb_iter_get_byte(&iter,
+										&pin_tag,
+										pin_tag_pos);
+
+							while (pin_tag =3D=3D 0x83) {
+								g_isi_sb_iter_get_byte(
+									&iter,
+									&pin_len,
+									pin_tag_pos + 1);
+								g_isi_sb_iter_get_byte(
+									&iter,
+									&pin_id,
+									pin_tag_pos + 2);
+								pin_tag_pos +=3D 2 + pin_len;
+								g_isi_sb_iter_get_byte(
+									&iter, &pin_tag,
+									pin_tag_pos);
+								DBG("PIN_len %d, PIN id %02x, \
+									PIN tag %02x", pin_len,
+									pin_id, pin_tag);
+
+								if ((0x01 <=3D pin_id) &&
+										(pin_id <=3D 0x08))
+									sd->pin1_id =3D pin_id;
+								else if ((0x81 <=3D pin_id) &&
+										(pin_id <=3D 0x88))
+									sd->pin2_id =3D pin_id;
+							}
+
+							DBG("PIN1 %02x,\
+								PIN2 %02x",
+								sd->pin1_id,
+								sd->pin2_id);
+							break;
+						default:
+							DBG("Skipping tag %02x", id);
+							break;
+						}
+
+						/*Data length + id size + len size*/
+						read +=3D item_len + 2;
+					}
+				}
+			}
+
+			break;
+		case UICC_SB_CHV:
+			DBG("UICC_SB_CHV");
+
+			if (sd->app_type =3D=3D UICC_APPL_TYPE_ICC_SIM) {
+				uint8_t chv_id =3D 0, pin_id =3D 0;
+				(void) g_isi_sb_iter_get_byte(&iter,
+							      &chv_id, 4);
+				(void) g_isi_sb_iter_get_byte(&iter,
+							      &pin_id, 5);
+				DBG("UICC_APPL_TYPE_UICC_SIM");
+
+				if (chv_id =3D=3D 1)
+					sd->pin1_id =3D pin_id;
+				else if (chv_id =3D=3D 2)
+					sd->pin2_id =3D pin_id;
+			}
+
+			break;
+		default:
+			DBG("Skipping sub-block: %s (%zu bytes)",
+				uicc_subblock_name(g_isi_sb_iter_get_id(&iter)),
+				g_isi_sb_iter_get_len(&iter));
+			break;
+		}
+
+		(void)g_isi_sb_iter_next(&iter);
+	}
+
+error:
+	return TRUE;
+}
+
+static void uicc_application_activate_req(GIsiClient *client,
+						void *opaque,
+						unsigned char appl_type,
+						unsigned char aid)
+{
+	const unsigned char msg[] =3D {
+		UICC_APPLICATION_REQ,
+		UICC_APPL_HOST_ACTIVATE,
+		2, /* number of subblocks*/
+	/* Subblock 1 */
+		UICC_SB_APPLICATION >> 8,
+		UICC_SB_APPLICATION & 0xff,
+		0, /*subblock length*/
+		8, /*subblock length*/
+		0, /*filler*/
+		0, /*filler*/
+		appl_type,
+		aid,
+	/* Subblock 2 */
+		UICC_SB_APPL_INFO >> 8,
+		UICC_SB_APPL_INFO & 0xff,
+		0, /*subblock length*/
+		8, /*subblock length*/
+		0, /*filler*/
+		0, /*filler*/
+		0, /*filler*/
+		/* whether the application initialization procedure
+		*  will follow the activation or not */
+		UICC_APPL_START_UP_INIT_PROC
+	};
+
+	DBG("Appl type %d, AID %d", appl_type, aid);
+
+	g_isi_request_make(
+		client, msg, sizeof(msg), SIM_TIMEOUT,
+		uicc_application_activate_resp, opaque);
+}
+
+static gboolean uicc_application_list_resp(GIsiClient *client,
+						const void *restrict data,
+						size_t len,
+						uint16_t object,
+						void *opaque)
+{
+	struct ofono_sim *sim =3D opaque;
+	const unsigned char *msg =3D data;
+	gboolean everything_ok =3D TRUE;
+	int index =3D NOT_AVAILABLE;
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+
+	if (!msg) {
+		DBG("ISI client error: %d", g_isi_client_error(client));
+		goto error;
+	}
+
+	DBG("%s, service=3D%s, status=3D%s details=3D%d",
+		uicc_message_id_name(msg[0]),
+		uicc_service_type_name(msg[1]),
+		uicc_status_name(msg[2]), msg[3]);
+
+	if ((msg[0] !=3D UICC_APPLICATION_RESP) ||
+			(msg[1] !=3D UICC_APPL_LIST))
+		return FALSE;
+
+	if (msg[2] =3D=3D UICC_STATUS_FAIL)
+		everything_ok =3D FALSE;
+
+	sim_application_list_p =3D g_try_new0(struct sim_applications, 1);
+
+	if (everything_ok) {
+		GIsiSubBlockIter iter;
+		g_isi_sb_iter_init_full(&iter, msg, len, 7, TRUE, msg[6]);
+
+		while (g_isi_sb_iter_is_valid(&iter)) {
+			DBG("Sub-block %s",
+				uicc_subblock_name(
+					g_isi_sb_iter_get_id(&iter)));
+
+			switch (g_isi_sb_iter_get_id(&iter)) {
+			case UICC_SB_APPL_DATA_OBJECT: {
+				guint8 appl_id =3D -1;
+				guint8 appl_type =3D -1;
+				guint8 status =3D -1;
+				gboolean ret;
+				ret =3D g_isi_sb_iter_get_byte(
+					      &iter, &appl_type, 6);
+				ret =3D g_isi_sb_iter_get_byte(
+					      &iter, &appl_id, 7);
+				(void) g_isi_sb_iter_get_byte(
+					&iter, &status, 8);
+				DBG("Appl type=3D%d, Appl id=3D%d, Appl status=3D%d",
+					appl_type, appl_id, status);
+
+				sim_application_list_p->app_list[appl_id] =3D
+					appl_id;
+				sim_application_list_p->app_type[appl_id] =3D
+					appl_type;
+				break;
+			}
+			default:
+				DBG("Skipping sub-block: %s (%zu bytes)",
+					uicc_subblock_name(
+						g_isi_sb_iter_get_id(&iter)),
+					g_isi_sb_iter_get_len(&iter));
+				break;
+			}
+
+			g_isi_sb_iter_next(&iter);
+		}
+	}
+
+	if (!sd->uicc_app_started) {
+		index =3D sim_applications_get_next_index(sim_application_list_p,
+						NOT_ACTIVATED);
+
+		if (index !=3D NOT_AVAILABLE) {
+			DBG("Activating APP index:%d", index);
+			sd->trying_app_id =3D
+			  sim_application_list_p->app_list[index];
+			sd->trying_app_type =3D
+			  sim_application_list_p->app_type[index];
+			DBG("Activating APP ID: %d APP type: %d",
+				sd->trying_app_id, sd->trying_app_type);
+			uicc_application_activate_req(client, sim,
+						sim_application_list_p->app_type[index],
+						sim_application_list_p->app_list[index]);
+		} else
+			g_free(sim_application_list_p);
+	}
+
+error:
+	return TRUE;
+}
+
+static void uicc_application_list_req(GIsiClient *client,
+					void *opaque)
+{
+	const unsigned char msg[] =3D {
+		UICC_APPLICATION_REQ,
+		UICC_APPL_LIST,
+		0 /* number of subblocks*/
+	};
+	DBG("");
+
+	g_isi_request_make(
+		client, msg, sizeof(msg), SIM_TIMEOUT,
+		uicc_application_list_resp, opaque);
+}
+
+static gboolean uicc_pin_enter_resp(GIsiClient *client,
+					const void *restrict data,
+					size_t len,
+					uint16_t object,
+					void *opaque)
+{
+	const unsigned char *msg =3D data;
+	struct isi_cb_data *cbd =3D opaque;
+	ofono_sim_lock_unlock_cb_t cb =3D cbd->cb;
+	struct ofono_sim_local *local_sim =3D
+					(struct ofono_sim_local *) cbd->user;
+	struct ofono_error error;
+#ifdef STATUS_WORD_HANDLING
+	GIsiSubBlockIter iter;
+#endif
+	struct sim_data *sd =3D
+			ofono_sim_get_data((struct ofono_sim *) local_sim);
+
+	DBG("");
+
+	if (!msg) {
+		DBG("ISI client error: %d",
+			g_isi_client_error(client));
+		goto error;
+	}
+
+	DBG("%s, service %s, status %s",
+		uicc_message_id_name(msg[0]),
+		uicc_service_type_name(msg[1]),
+		uicc_status_name(msg[2]));
+
+	if (msg[2] =3D=3D UICC_STATUS_OK) {
+		sd->passwd_required =3D FALSE;
+		error.type =3D OFONO_ERROR_TYPE_NO_ERROR;
+		error.error =3D 0;
+		goto out;
+	}
+
+error:
+#ifdef STATUS_WORD_HANDLING
+	g_isi_sb_iter_init_full(&iter, msg, len, 7, TRUE, msg[6]);
+
+	while (g_isi_sb_iter_is_valid(&iter)) {
+		DBG("Sub-block %s",
+			uicc_subblock_name(g_isi_sb_iter_get_id(&iter)));
+
+		switch (g_isi_sb_iter_get_id(&iter)) {
+		case UICC_SB_STATUS_WORD: {
+			uint16_t status;
+			g_isi_sb_iter_get_word(&iter, &status, 6);
+			DBG("APDU status word =3D %04X", status);
+
+			switch (status) {
+			case 0x6983:
+			case 0x9840:
+				DBG("Authentication method blocked");
+				update_locked_pin(local_sim,
+							UICC_PIN_UNBLOCK_NEEDED,
+							sd->current_pin_id);
+				break;
+			default:
+
+				if ((status & 0xfff0) =3D=3D 0x63c0)
+					DBG("Attempts left %d", status & 0xf);
+
+				break;
+			}
+
+			break;
+		}
+		default:
+			break;
+		}
+
+		g_isi_sb_iter_next(&iter);
+	}
+
+#endif
+	error.type =3D OFONO_ERROR_TYPE_FAILURE;
+	error.error =3D 1;
+out:
+	cb(&error, cbd->data);
+	g_free(cbd);
+	return TRUE;
+}
+
+static void uicc_pin_enter(struct ofono_sim *sim, const char *passwd,
+				ofono_sim_lock_unlock_cb_t cb, void *data)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(sim, cb, data);
+	sd->current_pin_id =3D sd->pin1_id; /* No way to enter PIN2 */
+	DBG("PIN=3D%s PINID=3D%02x", passwd, sd->current_pin_id);
+
+	if (cbd && sd) {
+		unsigned char pinlen =3D strlen(passwd);
+		unsigned char msg[] =3D {
+			UICC_PIN_REQ,
+			UICC_PIN_VERIFY,
+			sd->app_id,
+			0, /* Filler */
+			0, /* Filler */
+			0, /* Filler */
+			1, /* number of subblocks */
+		/* Subblock 1 */
+			UICC_SB_PIN >> 8,
+			UICC_SB_PIN & 0xff,
+			0,
+			16, /* Max length */
+			sd->current_pin_id, /* PIN id */
+			UICC_PIN_OLD, /* PIN qualifier */
+			pinlen, /* PIN length */
+			0,
+			0,
+			0,
+			0,
+			0,
+			0,
+			0,
+			0,
+			0
+		};
+
+		if ((pinlen < 4) || (pinlen > 8))
+			goto error;
+
+		memmove(&msg[14], passwd, pinlen);
+
+		g_isi_request_make(sd->client, msg, sizeof(msg),
+					SIM_TIMEOUT, uicc_pin_enter_resp, cbd);
+		return;
+	}
+
+error:
+	CALLBACK_WITH_FAILURE(cb, data);
+	g_free(cbd);
+}
+
+#ifdef PIN_PROMPT
+enum ofono_sim_password_type passwd_type_for_query =3D
+	OFONO_SIM_PASSWORD_SIM_PIN;
+
+static gboolean uicc_pin_prompt_resp(GIsiClient *client,
+					const void *restrict data,
+					size_t len,
+					uint16_t object,
+					void *opaque)
+{
+	const unsigned char *msg =3D data;
+	struct isi_cb_data *cbd =3D opaque;
+	ofono_sim_passwd_cb_t cb =3D cbd->cb;
+	struct ofono_sim_local *local_sim =3D
+					(struct ofono_sim_local *) cbd->user;
+	struct sim_data *sd =3D
+			ofono_sim_get_data((struct ofono_sim *)local_sim);
+
+	unsigned char lock_type =3D -1;
+	GIsiSubBlockIter iter;
+	uint8_t status =3D UICC_STATUS_UNKNOWN;
+	uint8_t pin_attempts =3D -1;
+	uint8_t puk_attempts =3D -1;
+
+	if (!msg) {
+		DBG("ISI client error: %d", g_isi_client_error(client));
+		goto error;
+	}
+
+	DBG("%s, service %s, status %s",
+		uicc_message_id_name(msg[0]),
+		uicc_service_type_name(msg[1]),
+		uicc_status_name(msg[2]));
+
+	if (msg[0] !=3D UICC_PIN_RESP)
+		goto error;
+
+	if (msg[1] =3D=3D UICC_PIN_PROMPT_VERIFY) {
+		sd->pin_state_received =3D TRUE;
+		status =3D msg[2];
+	} else if (msg[1] =3D=3D UICC_PIN_INFO) {
+		if (msg[2] !=3D UICC_STATUS_OK)
+			goto error;
+
+		sd->pin_state_received =3D TRUE;
+		g_isi_sb_iter_init_full(&iter, msg, len, 7, TRUE, msg[6]);
+
+		while (g_isi_sb_iter_is_valid(&iter)) {
+			DBG("Sub-block %s",
+				uicc_subblock_name(g_isi_sb_iter_get_id(
+							&iter)));
+
+			switch (g_isi_sb_iter_get_id(&iter)) {
+			case UICC_SB_PIN_INFO:
+				g_isi_sb_iter_get_byte(&iter, &status, 4);
+				g_isi_sb_iter_get_byte(&iter,
+							&pin_attempts, 5);
+				g_isi_sb_iter_get_byte(&iter,
+							&puk_attempts, 6);
+				DBG("Status=3D%s, PIN attempts=3D%d, \
+					PUK attempts=3D%d",
+					uicc_status_name(status),
+					pin_attempts, puk_attempts);
+				break;
+			default:
+				break;
+			}
+
+			g_isi_sb_iter_next(&iter);
+		}
+	}
+
+	if ((status =3D=3D UICC_STATUS_OK) ||
+		(status =3D=3D UICC_STATUS_PIN_ENABLED)) {
+		/* PIN query on, indication should tell
+		 * if it is verified or not
+		 */
+		if (pin_attempts =3D=3D 0) {
+			DBG("PIN blocked");
+			update_locked_pin(local_sim,
+					  UICC_PIN_UNBLOCK_NEEDED,
+						sd->current_pin_id);
+		} else {
+			DBG("PIN query enabled");
+			update_locked_pin(local_sim,
+					  UICC_PIN_VERIFY_NEEDED,
+						sd->current_pin_id);
+		}
+
+		lock_type =3D local_sim->pin_type;
+	} else if (status =3D=3D UICC_STATUS_PIN_DISABLED) {
+		if (pin_attempts =3D=3D 0) {
+			DBG("PIN blocked");
+			update_locked_pin(local_sim,
+					  UICC_PIN_UNBLOCK_NEEDED,
+						sd->current_pin_id);
+			lock_type =3D local_sim->pin_type;
+		} else {
+			DBG("PIN query disabled");
+			local_sim->locked_pins[OFONO_SIM_PASSWORD_SIM_PIN] =3D
+				FALSE;
+			local_sim->locked_pins[OFONO_SIM_PASSWORD_SIM_PIN2] =3D
+				FALSE;
+			lock_type =3D OFONO_SIM_PASSWORD_NONE;
+		}
+	}
+
+	if (msg[1] =3D=3D UICC_PIN_PROMPT_VERIFY) {
+		uicc_pin_prompt(cbd->user,
+				passwd_type_for_query,
+				cb,
+				cbd->data,
+				UICC_PIN_INFO);
+	}
+
+	CALLBACK_WITH_SUCCESS(cb, lock_type, cbd->data);
+	goto out;
+error:
+	DBG("PIN prompt verify failed");
+	CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
+out:
+	g_free(cbd);
+	return TRUE;
+}
+
+static void uicc_pin_prompt(struct ofono_sim *sim,
+				enum ofono_sim_password_type passwd_type,
+				ofono_sim_passwd_cb_t cb,
+				void *data,
+				uint8_t service)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(sim, cb, data);
+	int8_t index;
+	sd->current_pin_id =3D get_pin_id(sd, passwd_type, &index);
+	DBG("PINID =3D %02x", sd->current_pin_id);
+
+	if ((cbd) && (sd) && (sd->current_pin_id)) {
+		unsigned char msg[] =3D {
+			UICC_PIN_REQ,
+			service,
+			sd->app_id,
+			0, /*Filler*/
+			0, /*Filler*/
+			0, /*Filler*/
+			1, /*number of subblocks*/
+		/* Subblock 1 */
+			UICC_SB_PIN_REF >> 8,
+			UICC_SB_PIN_REF & 0xff,
+			0, /*Sub block length.*/
+			8,
+			sd->current_pin_id, /*PIN ID*/
+			0, /*Filler*/
+			0, /*Filler*/
+			0  /*Filler*/
+		};
+		g_isi_request_make(sd->client, msg, sizeof(msg),
+				   SIM_TIMEOUT, uicc_pin_prompt_resp, cbd);
+	} else {
+		DBG("PIN info query failed");
+		CALLBACK_WITH_FAILURE(cb, -1, data);
+		g_free(cbd);
+	}
+}
+#endif
+
+static void uicc_passwd_state_query(struct ofono_sim *sim,
+					ofono_sim_passwd_cb_t cb,
+					void *data)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct ofono_sim_local *local_sim =3D (struct ofono_sim_local *)sim;
+	if (sd->pin_state_received) {
+		int lock_type =3D OFONO_SIM_PASSWORD_NONE;
+
+		if (sd->passwd_required) {
+			/* These should be in priority order, highest last */
+			if (local_sim->locked_pins[
+				    OFONO_SIM_PASSWORD_SIM_PIN] =3D=3D TRUE)
+				lock_type =3D OFONO_SIM_PASSWORD_SIM_PIN;
+
+			if (local_sim->locked_pins[
+				    OFONO_SIM_PASSWORD_SIM_PIN2] =3D=3D TRUE)
+				lock_type =3D OFONO_SIM_PASSWORD_SIM_PIN2;
+
+			if (local_sim->locked_pins[
+				    OFONO_SIM_PASSWORD_PHNET_PIN] =3D=3D TRUE)
+				lock_type =3D OFONO_SIM_PASSWORD_PHNET_PIN;
+
+			if (local_sim->locked_pins[
+				    OFONO_SIM_PASSWORD_SIM_PUK] =3D=3D TRUE)
+				lock_type =3D OFONO_SIM_PASSWORD_SIM_PUK;
+
+			if (local_sim->locked_pins[
+				    OFONO_SIM_PASSWORD_SIM_PUK2] =3D=3D TRUE)
+				lock_type =3D OFONO_SIM_PASSWORD_SIM_PUK2;
+
+			if (local_sim->locked_pins[
+				    OFONO_SIM_PASSWORD_PHNET_PUK] =3D=3D TRUE)
+				lock_type =3D OFONO_SIM_PASSWORD_PHNET_PUK;
+		}
+
+		DBG("UICC lock type=3D%d", lock_type);
+		CALLBACK_WITH_SUCCESS(cb, lock_type, data);
+	} else {
+#ifdef PIN_PROMPT
+
+		if (sd->uicc_app_started) {
+			/* No indication received but UICC app is
+			 * started, let's query the state
+			 */
+			DBG("Querying PIN info");
+			uicc_pin_prompt(sim, passwd_type_for_query,
+					cb, data, UICC_PIN_PROMPT_VERIFY);
+			return;
+		}
+
+#endif
+		DBG("No UICC_PIN_IND received");
+		CALLBACK_WITH_FAILURE(cb, -1, data);
+	}
+}
+
+static gboolean uicc_pin_enable_resp(GIsiClient *client,
+					const void *restrict data,
+					size_t len,
+					uint16_t object,
+					void *opaque)
+{
+	const unsigned char *msg =3D data;
+	struct isi_cb_data *cbd =3D opaque;
+	ofono_sim_lock_unlock_cb_t cb =3D cbd->cb;
+	struct ofono_sim_local *local_sim =3D
+					(struct ofono_sim_local *) cbd->user;
+	struct sim_data *sd =3D
+			ofono_sim_get_data((struct ofono_sim *) local_sim);
+
+	gboolean everything_ok =3D TRUE;
+#ifdef STATUS_WORD_HANDLING
+	GIsiSubBlockIter iter;
+#endif
+
+	if (!msg) {
+		DBG("ISI client error: %d", g_isi_client_error(client));
+		goto error;
+	}
+
+	DBG("%s, service %s, status %s, details=3D%d, len=3D%d",
+	    uicc_message_id_name(msg[0]),
+	    uicc_service_type_name(msg[1]),
+	    uicc_status_name(msg[2]), msg[3], (int) len);
+
+	if (msg[0] !=3D UICC_PIN_RESP)
+		goto error;
+
+	if (msg[1] !=3D UICC_PIN_DISABLE && msg[1] !=3D UICC_PIN_ENABLE)
+		goto error;
+
+	if (msg[2] !=3D UICC_STATUS_OK)
+		goto error;
+
+	if (everything_ok) {
+		DBG("PIN lock/unlock succeeded");
+		CALLBACK_WITH_SUCCESS(cb, cbd->data);
+		goto out;
+	}
+
+error:
+#ifdef STATUS_WORD_HANDLING
+	g_isi_sb_iter_init_full(&iter, msg, len, 7, TRUE, msg[6]);
+
+	while (g_isi_sb_iter_is_valid(&iter)) {
+		DBG("Sub-block %s",
+		    uicc_subblock_name(g_isi_sb_iter_get_id(&iter)));
+
+		switch (g_isi_sb_iter_get_id(&iter)) {
+		case UICC_SB_STATUS_WORD: {
+			uint16_t status;
+			g_isi_sb_iter_get_word(&iter, &status, 6);
+			DBG("APDU status word =3D %04X", status);
+
+			switch (status) {
+			case 0x6983:
+			case 0x9840:
+				DBG("Authentication method blocked");
+				update_locked_pin(local_sim,
+						  UICC_PIN_UNBLOCK_NEEDED,
+						  sd->current_pin_id);
+				break;
+			default:
+
+				if ((status & 0xfff0) =3D=3D 0x63c0)
+					DBG("Attempts left %d", status & 0xf);
+
+				break;
+			}
+		}
+		default:
+			break;
+		}
+
+		g_isi_sb_iter_next(&iter);
+	}
+
+#endif
+	DBG("PIN lock/unlock failed");
+	CALLBACK_WITH_FAILURE(cb, cbd->data);
+out:
+	g_free(cbd);
+	return TRUE;
+}
+
+static void uicc_pin_enable(struct ofono_sim *sim,
+				enum ofono_sim_password_type passwd_type,
+				int enable, const char *passwd,
+				ofono_sim_lock_unlock_cb_t cb, void *data)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(sim, cb, data);
+	int8_t index;
+	unsigned char service =3D 0;
+	sd->current_pin_id =3D get_pin_id(sd, passwd_type, &index);
+
+	DBG("Lock=3D%d, PIN code=3D%s, PIN ID =3D%d",
+	enable, passwd, sd->current_pin_id);
+	if (enable) {
+		DBG("Enabling PIN");
+		service =3D UICC_PIN_ENABLE;
+	} else {
+		DBG("Disabling PIN");
+		service =3D UICC_PIN_DISABLE;
+	}
+	if ((cbd) && (sd) && (sd->current_pin_id)) {
+
+		unsigned char pinlen =3D strlen(passwd);
+
+		unsigned char msg[] =3D {
+			UICC_PIN_REQ,
+			service,
+			sd->app_id,
+			0, /*Filler*/
+			0, /*Filler*/
+			0, /*Filler*/
+			1, /*number of subblocks*/
+		/* Subblock 1 */
+			UICC_SB_PIN >> 8,
+			UICC_SB_PIN & 0xff,
+			0,
+			16, /*Max length*/
+			sd->current_pin_id, /* PIN id */
+			UICC_PIN_OLD, /* PIN qualifier */
+			pinlen, /* PIN length */
+			0,
+			0,
+			0,
+			0,
+			0,
+			0,
+			0,
+			0,
+			0
+		};
+
+		if ((pinlen < 4) || (pinlen > 8))
+			goto error;
+		memmove(&msg[14], passwd, pinlen);
+		g_isi_request_make(
+			sd->client, msg, sizeof(msg), SIM_TIMEOUT,
+			uicc_pin_enable_resp, cbd);
+		return;
+	}
+
+error:
+	DBG("Error");
+	CALLBACK_WITH_FAILURE(cb, data);
+	g_free(cbd);
+	return;
+}
+
+#ifdef QUERY_LOCKED
+static gboolean uicc_query_locked_resp(GIsiClient *client,
+					const void *restrict data,
+					size_t len,
+					uint16_t object,
+					void *opaque)
+{
+	const unsigned char *msg =3D data;
+	struct isi_cb_data *cbd =3D opaque;
+	ofono_sim_locked_cb_t cb =3D cbd->cb;
+	GIsiSubBlockIter iter;
+	int lock_status =3D -1;
+
+	if (msg[0] < 0xf0) {
+		DBG("%s, service %s, status %s, details=3D%d, state=3D%d",
+			uicc_message_id_name(msg[0]),
+			uicc_service_type_name(msg[1]),
+			uicc_status_name(msg[2]),
+			msg[3], msg[4]);
+
+		if ((msg[0] =3D=3D UICC_PIN_RESP) &&
+		    (msg[1] =3D=3D UICC_PIN_INFO) &&
+		    (msg[2] =3D=3D UICC_STATUS_OK)) {
+			g_isi_sb_iter_init_full(&iter, msg,
+						len, 7, TRUE, msg[6]);
+
+			while (g_isi_sb_iter_is_valid(&iter)) {
+				DBG("Sub-block %s",
+				    uicc_subblock_name(
+						g_isi_sb_iter_get_id(&iter)));
+
+				switch (g_isi_sb_iter_get_id(&iter)) {
+				case UICC_SB_PIN_INFO:
+					uint8_t pin_status;
+					uint8_t pin_attempts;
+					uint8_t puk_attempts;
+					uint8_t passwd_type;
+					(void) g_isi_sb_iter_get_byte(&iter,
+									&pin_status, 4);
+					(void) g_isi_sb_iter_get_byte(&iter,
+									&pin_attempts, 5);
+					(void) g_isi_sb_iter_get_byte(&iter,
+								       &puk_attempts, 6);
+					DBG("PIN info, state =3D %d, \
+						PIN attemps =3D %d, \
+						PUK attempts =3D %d",
+						pin_status,
+						pin_attempts,
+						puk_attempts);
+					passwd_type =3D
+						((struct sim_passwd_to_pin_id *)
+						 cbd->user)->passwd_type;
+
+					if ((passwd_type =3D=3D
+							OFONO_SIM_PASSWORD_SIM_PUK) ||
+							(passwd_type =3D=3D
+							OFONO_SIM_PASSWORD_SIM_PUK2)) {
+						DBG("Checking PUK/PUK2 status");
+
+						if (pin_attempts =3D=3D 0)
+							lock_status =3D 1;
+						else
+							lock_status =3D 0;
+					} else {
+						DBG("Checking PIN/PIN2 status");
+
+						if (pin_status =3D=3D
+								UICC_STATUS_PIN_ENABLED)
+							lock_status =3D 1;
+
+						if (pin_status =3D=3D
+								UICC_STATUS_PIN_DISABLED)
+							lock_status =3D 0;
+					}
+
+					break;
+				default:
+					break;
+				}
+
+				g_isi_sb_iter_next(&iter);
+			}
+		} else if ((msg[0] =3D=3D UICC_SIMLOCK_RESP) &&
+				(msg[1] =3D=3D UICC_SIMLOCK_ACTIVE) &&
+				(msg[2] =3D=3D UICC_STATUS_OK)) {
+			if (msg[4] =3D=3D UICC_SIMLOCK_STATUS_ACTIVE)
+				lock_status =3D 1;
+
+			if (msg[4] =3D=3D UICC_SIMLOCK_STATUS_INACTIVE)
+				lock_status =3D 0;
+		} else
+			goto error;
+
+		DBG("Lock status =3D %d", lock_status);
+
+		if (cb)
+			CALLBACK_WITH_SUCCESS(cb, lock_status, cbd->data);
+
+		goto out;
+	} else {
+		DBG("COMMON_MESSAGE, submessage %02X", msg[1]);
+	}
+
+error:
+	DBG("Querying lock status failed");
+
+	if (cb)
+		CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
+
+out:
+	g_free(cbd);
+	return TRUE;
+}
+
+static void uicc_query_locked(struct ofono_sim *sim,
+				enum ofono_sim_password_type type,
+				ofono_sim_locked_cb_t cb,
+				void *data)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(sim, cb, data);
+	uint8_t index;
+
+	if (cbd && sd) {
+		sd->current_pin_id =3D get_pin_id(sd, type, &index);
+
+		if (!sd->current_pin_id) {
+			DBG("SIMlock type query");
+			unsigned char simlock_msg[] =3D {
+				UICC_SIMLOCK_REQ,
+				UICC_SIMLOCK_ACTIVE,
+				0,
+				0
+			};
+			g_isi_request_make(
+				sd->client, simlock_msg,
+				sizeof(simlock_msg), SIM_TIMEOUT,
+				uicc_query_locked_resp, cbd);
+			return;
+		} else {
+			cbd->user =3D (void *) &pin_ids[index];
+			DBG("PIN/PUK type lock query, PIN %d",
+						sd->current_pin_id);
+			unsigned char pin_puk_msg[] =3D {
+				UICC_PIN_REQ,
+				UICC_PIN_INFO,
+				sd->app_id,
+				0, /*Filler*/
+				0, /*Filler*/
+				0, /*Filler*/
+				1, /*number of subblocks*/
+			/* Subblock 1 */
+				UICC_SB_PIN_REF >> 8,
+				UICC_SB_PIN_REF & 0xff,
+				0, /*Sub block length.*/
+				8,
+				sd->current_pin_id, /*PIN ID*/
+				0, /*Filler*/
+				0, /*Filler*/
+				0  /*Filler*/
+			};
+			g_isi_request_make(
+				sd->client, pin_puk_msg,
+				sizeof(pin_puk_msg), SIM_TIMEOUT,
+				uicc_query_locked_resp, cbd);
+		}
+	} else {
+		DBG("Error");
+
+		if (cb)
+			CALLBACK_WITH_FAILURE(cb, -1, data);
+
+		g_free(cbd);
+		return;
+	}
+}
+#endif
+
+static gboolean uicc_pin_change_resp(GIsiClient *client,
+					const void *restrict data,
+					size_t len,
+					uint16_t object,
+					void *opaque)
+{
+	const unsigned char *msg =3D data;
+	struct isi_cb_data *cbd =3D opaque;
+	ofono_sim_lock_unlock_cb_t cb =3D cbd->cb;
+	struct ofono_sim_local *local_sim =3D
+					(struct ofono_sim_local *) cbd->user;
+	struct sim_data *sd =3D
+			ofono_sim_get_data((struct ofono_sim *) local_sim);
+
+	gboolean everything_ok =3D TRUE;
+#ifdef STATUS_WORD_HANDLING
+	GIsiSubBlockIter iter;
+#endif
+
+	if (!msg) {
+		DBG("ISI client error: %d", g_isi_client_error(client));
+		goto error;
+	}
+
+	DBG("%s, service %s, status %s, details=3D%d, len=3D%d",
+		uicc_message_id_name(msg[0]),
+		uicc_service_type_name(msg[1]),
+		uicc_status_name(msg[2]), (int) msg[3], (int) len);
+
+	if (msg[0] !=3D UICC_PIN_RESP)
+		goto error;
+
+	if (msg[1] !=3D UICC_PIN_CHANGE)
+		goto error;
+
+	if (msg[2] !=3D UICC_STATUS_OK)
+		goto error;
+
+	if (everything_ok) {
+		DBG("PIN change succeeded");
+		CALLBACK_WITH_SUCCESS(cb, cbd->data);
+		goto out;
+	}
+
+error:
+#ifdef STATUS_WORD_HANDLING
+	g_isi_sb_iter_init_full(&iter, msg, len, 7, TRUE, msg[6]);
+
+	while (g_isi_sb_iter_is_valid(&iter)) {
+		DBG("Sub-block %s",
+			uicc_subblock_name(g_isi_sb_iter_get_id(&iter)));
+
+		switch (g_isi_sb_iter_get_id(&iter)) {
+		case UICC_SB_STATUS_WORD: {
+			uint16_t status;
+			g_isi_sb_iter_get_word(&iter, &status, 6);
+			DBG("APDU status word =3D %04X", status);
+
+			switch (status) {
+			case 0x6983:
+			case 0x9840:
+				DBG("Authentication method blocked");
+				update_locked_pin(local_sim,
+					UICC_PIN_UNBLOCK_NEEDED,
+						sd->current_pin_id);
+				break;
+			default:
+
+				if ((status & 0xfff0) =3D=3D 0x63c0)
+					DBG("Attempts left %d", status & 0xf);
+
+				break;
+			}
+
+			break;
+		}
+		default:
+			break;
+		}
+
+		g_isi_sb_iter_next(&iter);
+	}
+
+#endif
+	DBG("PIN change failed");
+	CALLBACK_WITH_FAILURE(cb, cbd->data);
+out:
+	g_free(cbd);
+	return TRUE;
+}
+
+static void uicc_change_pin(struct ofono_sim *sim,
+				enum ofono_sim_password_type passwd_type,
+				const char *old,
+				const char *new,
+				ofono_sim_lock_unlock_cb_t cb,
+				void *data)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(sim, cb, data);
+	int8_t index;
+	sd->current_pin_id =3D get_pin_id(sd, passwd_type, &index);
+	DBG("old=3D%s, new=3D%s, PINID=3D%02x",
+		old, new, sd->current_pin_id);
+
+	if ((cbd) && (sd) && (sd->current_pin_id)) {
+		unsigned char service =3D UICC_PIN_CHANGE;
+		unsigned char oldlen =3D strlen(old);
+		unsigned char newlen =3D strlen(new);
+
+		unsigned char msg[] =3D {
+			UICC_PIN_REQ,
+			service,
+			sd->app_id,
+			0, /*Filler*/
+			0, /*Filler*/
+			0, /*Filler*/
+			2, /*number of subblocks*/
+		/* Subblock 1 */
+			UICC_SB_PIN >> 8,
+			UICC_SB_PIN & 0xff,
+			0,
+			16, /* Must be fixed */
+			sd->current_pin_id, /* PIN id */
+			UICC_PIN_OLD, /* PIN qualifier */
+			oldlen, /* PIN length */
+			0,
+			0,
+			0,
+			0,
+			0,
+			0,
+			0,
+			0,
+			0,
+		/* Subblock 2 */
+			UICC_SB_PIN >> 8,
+			UICC_SB_PIN & 0xff,
+			0,
+			/* Sub block length:
+			*  "header" size + 1 (=3Dtrailing filler) + PIN length */
+			16,
+			sd->current_pin_id, /* PIN id */
+			UICC_PIN_NEW, /* PIN qualifier */
+			newlen, /* PIN length */
+			0,
+			0,
+			0,
+			0,
+			0,
+			0,
+			0,
+			0,
+			0
+		};
+
+		if ((oldlen < 4) || (oldlen > 8))
+			goto error;
+
+		if ((newlen < 4) || (newlen > 8))
+			goto error;
+
+		memmove(&msg[14], old, oldlen);
+		memmove(&msg[30], new, newlen);
+		g_isi_request_make(
+			sd->client, msg, sizeof(msg), SIM_TIMEOUT,
+			uicc_pin_change_resp, cbd);
+		return;
+	}
+
+error:
+	DBG("Error");
+	CALLBACK_WITH_FAILURE(cb, data);
+	g_free(cbd);
+	return;
+}
+
+static gboolean uicc_pin_send_puk_resp(GIsiClient *client,
+					const void *restrict data,
+					size_t len,
+					uint16_t object,
+					void *opaque)
+{
+	const unsigned char *msg =3D data;
+	struct isi_cb_data *cbd =3D opaque;
+	ofono_sim_lock_unlock_cb_t cb =3D cbd->cb;
+	struct ofono_sim_local *local_sim =3D
+					(struct ofono_sim_local *) cbd->user;
+	gboolean everything_ok =3D TRUE;
+#ifdef STATUS_WORD_HANDLING
+	GIsiSubBlockIter iter;
+#endif
+
+	if (!msg) {
+		DBG("ISI client error: %d", g_isi_client_error(client));
+		goto error;
+	}
+
+	DBG("%s, service %s, status %s, details=3D%d, len=3D%d",
+		uicc_message_id_name(msg[0]),
+		uicc_service_type_name(msg[1]),
+		uicc_status_name(msg[2]), (int) msg[3], (int) len);
+
+	if (msg[0] !=3D UICC_PIN_RESP)
+		goto error;
+
+	if (msg[1] !=3D UICC_PIN_UNBLOCK)
+		goto error;
+
+	if (msg[2] !=3D UICC_STATUS_OK)
+		goto error;
+
+	if (everything_ok) {
+		DBG("PIN reset succeeded");
+		/* Only PIN1 can be reseted, turns PIN query on */
+		local_sim->locked_pins[OFONO_SIM_PASSWORD_SIM_PIN] =3D TRUE;
+		local_sim->locked_pins[OFONO_SIM_PASSWORD_SIM_PUK] =3D FALSE;
+		CALLBACK_WITH_SUCCESS(cb, cbd->data);
+		goto out;
+	}
+
+error:
+#ifdef STATUS_WORD_HANDLING
+	g_isi_sb_iter_init_full(&iter, msg, len, 7, TRUE, msg[6]);
+
+	while (g_isi_sb_iter_is_valid(&iter)) {
+		DBG("Sub-block %s",
+			uicc_subblock_name(g_isi_sb_iter_get_id(&iter)));
+
+		switch (g_isi_sb_iter_get_id(&iter)) {
+		case UICC_SB_STATUS_WORD: {
+			uint16_t status;
+			g_isi_sb_iter_get_word(&iter, &status, 6);
+			DBG("APDU status word =3D %04X", status);
+
+			switch (status) {
+			case 0x6983:
+			case 0x9840:
+				DBG("Authentication method blocked");
+				break;
+			default:
+
+				if ((status & 0xfff0) =3D=3D 0x63c0)
+					DBG("Attempts left %d", status & 0xf);
+
+				break;
+			}
+
+			break;
+		}
+		default:
+			break;
+		}
+
+		g_isi_sb_iter_next(&iter);
+	}
+
+#endif
+	DBG("PIN reset failed");
+	CALLBACK_WITH_FAILURE(cb, cbd->data);
+out:
+	g_free(cbd);
+	return TRUE;
+}
+
+static void uicc_pin_send_puk(struct ofono_sim *sim,
+				const char *puk,
+				const char *passwd,
+				ofono_sim_lock_unlock_cb_t cb,
+				void *data)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(sim, cb, data);
+	sd->current_pin_id =3D sd->pin1_id; /* No way to reset PIN2 */
+	DBG("PUK=3D%s, PIN=3D%s, PINID=3D%02x", puk, passwd, sd->current_pin_id);
+
+	if (cbd && sd) {
+		unsigned char service =3D UICC_PIN_UNBLOCK;
+		unsigned char pinlen =3D strlen(passwd);
+
+		unsigned char msg[] =3D {
+			UICC_PIN_REQ,
+			service,
+			sd->app_id,
+			0, /*Filler*/
+			0, /*Filler*/
+			0, /*Filler*/
+			2, /*number of subblocks*/
+		/* Subblock 1*/
+			UICC_SB_PIN >> 8,
+			UICC_SB_PIN & 0xff,
+			0,
+			16, /*Must be fixed*/
+			sd->current_pin_id, /* PIN id*/
+			UICC_PIN_NEW, /* PIN qualifier*/
+			pinlen, /* PIN length*/
+			0,
+			0,
+			0,
+			0,
+			0,
+			0,
+			0,
+			0,
+			0,
+		/* Subblock 2*/
+			UICC_SB_PUK >> 8,
+			UICC_SB_PUK & 0xff,
+			0,
+			16, /*Sub block length*/
+			sd->current_pin_id, /* PIN id*/
+			8, /* PUK length*/
+			puk[0],
+			puk[1],
+			puk[2],
+			puk[3],
+			puk[4],
+			puk[5],
+			puk[6],
+			puk[7],
+			0,
+			0
+		};
+
+		if ((pinlen < 4) || (pinlen > 8))
+			goto error;
+
+		if (strlen(puk) !=3D 8)
+			goto error;
+		memmove(&msg[14], passwd, pinlen);
+		g_isi_request_make(
+			sd->client, msg, sizeof(msg), SIM_TIMEOUT,
+			uicc_pin_send_puk_resp, cbd);
+		return;
+	}
+
+error:
+	DBG("PIN reset error");
+	CALLBACK_WITH_FAILURE(cb, data);
+	g_free(cbd);
+	return;
+}
+
+static gboolean check_write_resp(const uint8_t *msg, size_t len,
+					struct isi_cb_data **_cbd)
+{
+	struct isi_cb_data *cbd =3D *_cbd;
+	struct ofono_sim *sim =3D cbd->user;
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	ofono_sim_write_cb_t cb =3D cbd->cb;
+	DBG("");
+
+	if (!msg) {
+		DBG("ISI client error: %d", g_isi_client_error(sd->client));
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+		g_free(*_cbd);
+		*_cbd =3D NULL;
+		return TRUE;
+	}
+
+	if (len < 7 || msg[0] !=3D UICC_APPL_CMD_RESP) {
+		DBG("Invalid response");
+		return FALSE;
+	}
+
+	if (msg[2] !=3D UICC_STATUS_OK) {
+		DBG("Failed");
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+		g_free(*_cbd);
+		*_cbd =3D NULL;
+		return TRUE;
+	}
+
+	return TRUE;
+}
+
+#ifdef WRITE_FILE_TRANSPARENT
+static gboolean write_file_transparent_cb(GIsiClient *client,
+						const void *restrict data,
+						size_t len,
+						uint16_t object,
+						void *opaque)
+{
+	const uint8_t *msg =3D data;
+	struct isi_cb_data *cbd =3D opaque;
+	ofono_sim_write_cb_t cb =3D cbd->cb;
+	gboolean ret =3D check_write_resp(msg, len, &cbd);
+	DBG("");
+
+	if (ret && cbd) {
+		if (msg[1] !=3D UICC_APPL_UPDATE_TRANSPARENT) {
+			DBG("Invalid response");
+			return FALSE;
+		}
+
+		CALLBACK_WITH_SUCCESS(cb, cbd->data);
+		g_free(cbd);
+		return TRUE;
+	}
+
+	return ret;
+}
+
+static void isi_write_file_transparent(struct ofono_sim *sim, int fileid,
+					int start, int length,
+					const unsigned char *value,
+					ofono_sim_write_cb_t cb,
+					void *data)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(sim, cb, data);
+	int mf_path =3D 0, df1_path =3D 0, df2_path =3D 0;
+	unsigned char df_len =3D 0;
+	size_t  i =3D 0;
+
+	size_t sb_file_data_legth =3D (2 + 2 + 4 + length + 3) & ~3;
+	size_t fill_count =3D sb_file_data_legth - (2 + 2 + 4 + length);
+	uint8_t *fill_data =3D g_try_malloc0(fill_count);
+
+	DBG("");
+
+	if (!fill_data && fill_count > 0)
+		goto error;
+
+	for (i =3D 0; i < fill_count; i++)
+		fill_data[i] =3D 0x00;
+
+	if (!sd->app_id || !sd->client_id || !sd || !sd->client || !cbd) {
+		DBG("Parameter error");
+		goto error;
+	}
+
+	if (get_fileid_path(sim, &mf_path, &df1_path,
+			&df2_path, &df_len, fileid)) {
+		uint8_t msg[] =3D {
+			UICC_APPL_CMD_REQ,
+			UICC_APPL_UPDATE_TRANSPARENT,
+			sd->app_id,
+			UICC_SESSION_ID_NOT_USED,
+			0x00, 0x00, /* fillers */
+			0x04, /* nro of sub blocks */
+			/* 1st subblock */
+			UICC_SB_CLIENT >> 8,
+			UICC_SB_CLIENT & 0xFF,
+			0x00, 0x08, /* subblock length */
+			0x00, 0x00, 0x00, /* fillers */
+			sd->client_id,
+			/* 2nd subblock */
+			UICC_SB_TRANSPARENT >> 8,
+			UICC_SB_TRANSPARENT & 0xFF,
+			0x00, 0x08, /* sub block length */
+			start >> 8, /* file offset (0 =3D=3D beginning) */
+			start & 0xFF,
+			0x00, 0x00, /* data amount, used only for reading */
+			/* 3th subblock */
+			UICC_SB_APPL_PATH >> 8,
+			UICC_SB_APPL_PATH & 0xFF,
+			0x00, 0x10, /* subblock length */
+			fileid >> 8, /* elementary file id */
+			fileid & 0xFF,
+			get_sfi(fileid),
+			0x00, /* filler */
+			df_len, /* path length */
+			0x00, /* filler */
+			mf_path >> 8, /* DF Path MF */
+			mf_path & 0xFF,
+			df1_path >> 8, /* DF Path */
+			df1_path & 0xFF,
+			df2_path >> 8, /* DF Path */
+			df2_path & 0xFF,
+			/* 4nd subblock */
+			UICC_SB_FILE_DATA >> 8,
+			UICC_SB_FILE_DATA & 0xFF,
+			sb_file_data_legth >> 8, /* subblock length */
+			sb_file_data_legth & 0xFF,
+			length >> 24, /* data length, need to be shifted*/
+			length >> 16,
+			length >> 8,
+			length & 0xFF,
+		};
+
+		struct iovec iov[3] =3D {
+			{ msg, sizeof(msg) },
+			{ (uint8_t *)value, length },
+			{ fill_data, fill_count },
+		};
+
+		if (g_isi_request_vmake(sd->client, iov, 3, SIM_TIMEOUT,
+					write_file_transparent_cb, cbd))
+			goto out;
+	}
+
+error:
+	CALLBACK_WITH_FAILURE(cb, data);
+
+	if (cbd)
+		g_free(cbd);
+
+out:
+
+	if (fill_data)
+		g_free(fill_data);
+
+	return;
+}
+#endif
+
+static gboolean write_file_linear_cb(GIsiClient *client,
+					const void *restrict data,
+					size_t len,
+					uint16_t object,
+					void *opaque)
+{
+	const uint8_t *msg =3D data;
+	struct isi_cb_data *cbd =3D opaque;
+	ofono_sim_write_cb_t cb =3D cbd->cb;
+	gboolean ret =3D check_write_resp(msg, len, &cbd);
+	DBG("");
+
+	if (ret && cbd) {
+		if (msg[1] !=3D UICC_APPL_UPDATE_LINEAR_FIXED) {
+			DBG("Invalid response");
+			return FALSE;
+		}
+
+		CALLBACK_WITH_SUCCESS(cb, cbd->data);
+		g_free(cbd);
+		return TRUE;
+	}
+
+	return ret;
+}
+
+static void isi_write_file_linear(struct ofono_sim *sim, int fileid,
+					int record, int length,
+					const unsigned char *value,
+					ofono_sim_write_cb_t cb,
+					void *data)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(sim, cb, data);
+
+	int mf_path =3D 0;
+	int df1_path =3D 0;
+	int df2_path =3D 0;
+	unsigned char df_len =3D 0;
+	size_t i =3D 0;
+
+	size_t sb_file_data_legth =3D (2 + 2 + 4 + length + 3) & ~3;
+	size_t fill_count =3D sb_file_data_legth - (2 + 2 + 4 + length);
+	uint8_t *fill_data =3D g_try_malloc0(fill_count);
+	DBG("");
+
+	if (!fill_data && fill_count > 0)
+		goto error;
+
+	for (i =3D 0; i < fill_count; i++)
+		fill_data[i] =3D 0x00;
+
+	if (!sd->app_id || !sd->client_id || !sd || !sd->client || !cbd) {
+		DBG("Parameter error");
+		goto error;
+	}
+
+	if (get_fileid_path(sim, &mf_path, &df1_path,
+			&df2_path, &df_len, fileid)) {
+		uint8_t msg[] =3D {
+			UICC_APPL_CMD_REQ,
+			UICC_APPL_UPDATE_LINEAR_FIXED,
+			sd->app_id,
+			UICC_SESSION_ID_NOT_USED,
+			0x00, 0x00, /* fillers */
+			0x04, /* nro of sub blocks */
+			/* 1st subblock */
+			UICC_SB_CLIENT >> 8,
+			UICC_SB_CLIENT & 0xFF,
+			0x00, 0x08, /* subblock length */
+			0x00, 0x00, 0x00, /* fillers */
+			sd->client_id,
+			/* 2nd subblock */
+			UICC_SB_LINEAR_FIXED >> 8,
+			UICC_SB_LINEAR_FIXED & 0xFF,
+			0x00, 0x08, /* subblock length */
+			record, /* the record in the file*/
+			0x00, /* record offset (0 =3D=3D beginning) */
+			0x00, /* data amount, used only for reading */
+			0x00, /* filler */
+			/* 3th subblock */
+			UICC_SB_APPL_PATH >> 8,
+			UICC_SB_APPL_PATH & 0xFF,
+			0x00, 0x10, /* subblock length */
+			fileid >> 8, /* elementary file id */
+			fileid & 0xFF,
+			get_sfi(fileid),
+			0x00, /* filler */
+			df_len, /* path length */
+			0x00, /* filler */
+			mf_path >> 8, /* DF Path MF */
+			mf_path & 0xFF,
+			df1_path >> 8, /* DF Path */
+			df1_path & 0xFF,
+			df2_path >> 8, /* DF Path */
+			df2_path & 0xFF,
+			/* 4nd subblock */
+			UICC_SB_FILE_DATA >> 8,
+			UICC_SB_FILE_DATA & 0xFF,
+			sb_file_data_legth >> 8, /* subblock length */
+			sb_file_data_legth & 0xFF,
+			length >> 24, /* data length, need to be shifted*/
+			length >> 16,
+			length >> 8,
+			length & 0xFF,
+		};
+
+		struct iovec iov[3] =3D {
+			{ msg, sizeof(msg) },
+			{ (uint8_t *)value, length },
+			{ fill_data, fill_count },
+		};
+
+		if (g_isi_request_vmake(sd->client, iov, 3, SIM_TIMEOUT,
+					write_file_linear_cb, cbd))
+			goto out;
+	}
+error:
+	CALLBACK_WITH_FAILURE(cb, data);
+
+	if (cbd)
+		g_free(cbd);
+
+out:
+
+	if (fill_data)
+		g_free(fill_data);
+
+	return;
+}
+
+#ifdef WRITE_FILE_CYCLIC
+static gboolean write_file_cyclic_cb(GIsiClient *client,
+					const void *restrict data,
+					size_t len,
+					uint16_t object,
+					void *opaque)
+{
+	const uint8_t *msg =3D data;
+	struct isi_cb_data *cbd =3D opaque;
+	ofono_sim_write_cb_t cb =3D cbd->cb;
+	gboolean ret =3D check_write_resp(msg, len, &cbd);
+	DBG("");
+
+	if (ret && cbd) {
+		if (msg[1] !=3D UICC_APPL_UPDATE_CYCLIC) {
+			DBG("Invalid response");
+			return FALSE;
+		}
+
+		CALLBACK_WITH_SUCCESS(cb, cbd->data);
+		g_free(cbd);
+		return TRUE;
+	}
+
+	return ret;
+}
+
+static void isi_write_file_cyclic(struct ofono_sim *sim,
+					int fileid,
+					int length,
+					const unsigned char *value,
+					ofono_sim_write_cb_t cb,
+					void *data)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(sim, cb, data);
+
+	int mf_path =3D 0;
+	int df1_path =3D 0;
+	int df2_path =3D 0;
+	unsigned char df_len =3D 0;
+	size_t i =3D 0;
+	size_t sb_file_data_legth =3D (2 + 2 + 4 + length + 3) & ~3;
+	size_t fill_count =3D sb_file_data_legth - (2 + 2 + 4 + length);
+	uint8_t *fill_data =3D g_try_malloc0(fill_count);
+
+	if (!fill_data && fill_count > 0)
+		goto error;
+
+	for (i =3D 0; i < fill_count; i++)
+		fill_data[i] =3D 0x00;
+
+	if (!sd->app_id || !sd->client_id || !sd || !sd->client || !cbd) {
+		DBG("Parameter error");
+		goto error;
+	}
+
+	if (get_fileid_path(sim, &mf_path, &df1_path,
+			&df2_path, &df_len, fileid)) {
+		uint8_t msg[] =3D {
+			UICC_APPL_CMD_REQ,
+			UICC_APPL_UPDATE_CYCLIC,
+			sd->app_id,
+			UICC_SESSION_ID_NOT_USED,
+			0x00, 0x00, /* fillers */
+			0x04, /* nro of sub blocks */
+			/* 1st subblock */
+			UICC_SB_CLIENT >> 8,
+			UICC_SB_CLIENT & 0xFF,
+			0x00, 0x08, /* subblock length */
+			0x00, 0x00, 0x00, /* fillers */
+			sd->client_id,
+			/* 2nd subblock */
+			UICC_SB_CYCLIC >> 8,
+			UICC_SB_CYCLIC & 0xFF,
+			0x00, 0x08, /* sub block length */
+			0x01, /* record, write is allowed only to first */
+			0x00, /* record offset (0 =3D=3D beginning) */
+			0x00, 0x00, /* data amount, used only for reading */
+			0x00, /* filler */
+			/* 3th subblock */
+			UICC_SB_APPL_PATH >> 8,
+			UICC_SB_APPL_PATH & 0xFF,
+			0x00, 0x10, /* subblock length */
+			fileid >> 8, /* elementary file id */
+			fileid & 0xFF,
+			get_sfi(fileid),
+			0x00, /* filler */
+			df_len, /* path length */
+			0x00, /* filler */
+			mf_path >> 8, /* DF Path MF */
+			mf_path & 0xFF,
+			df1_path >> 8, /* DF Path */
+			df1_path & 0xFF,
+			df2_path >> 8, /* DF Path */
+			df2_path & 0xFF,
+			/* 4nd subblock */
+			UICC_SB_FILE_DATA >> 8,
+			UICC_SB_FILE_DATA & 0xFF,
+			sb_file_data_legth >> 8, /* subblock length */
+			sb_file_data_legth & 0xFF,
+			length >> 24, /* data length, need to be shifted*/
+			length >> 16,
+			length >> 8,
+			length & 0xFF,
+		};
+
+		struct iovec iov[3] =3D {
+			{ msg, sizeof(msg) },
+			{ (uint8_t *)value, length + fill_count },
+			{ fill_data, fill_count },
+		};
+
+		if (g_isi_request_vmake(sd->client, iov, 3, SIM_TIMEOUT,
+					write_file_cyclic_cb, cbd))
+			goto out;
+	}
+error:
+	CALLBACK_WITH_FAILURE(cb, data);
+
+	if (cbd)
+		g_free(cbd);
+
+out:
+
+	if (fill_data)
+		g_free(fill_data);
+
+	return;
+}
+#endif
+
+static void uicc_ind_handler(GIsiClient *client, const void *restrict data,
+				size_t len, uint16_t object, void *opaque)
+{
+	struct ofono_sim *sim =3D opaque;
+	const unsigned char *msg =3D data;
+	struct sim_data *sd =3D ofono_sim_get_data(sim);;
+
+	DBG("%s, service %s, card/PIN type=3D%d",
+		uicc_message_id_name(msg[0]),
+		uicc_service_type_name(msg[1]), msg[2]);
+
+	switch (msg[0]) {
+
+	case UICC_CARD_IND:
+		ofono_sim_inserted_notify(sim, TRUE);
+
+		if ((msg[1] =3D=3D UICC_CARD_READY) && (!sd->uicc_app_started)) {
+			DBG("UICC_CARD_IND activation");
+			uicc_application_list_req(client, sim);
+		}
+		break;
+	case UICC_PIN_IND:
+		sd->pin_state_received =3D TRUE;
+		sd->passwd_required =3D FALSE;
+
+		switch (msg[1]) {
+		case UICC_PIN_VERIFY_NEEDED:
+			update_locked_pin((struct ofono_sim_local *)sim,
+						UICC_PIN_VERIFY_NEEDED, msg[2]);
+			break;
+		case UICC_PIN_UNBLOCK_NEEDED:
+			update_locked_pin((struct ofono_sim_local *)sim,
+						UICC_PIN_UNBLOCK_NEEDED, msg[2]);
+			break;
+		case UICC_PIN_PERMANENTLY_BLOCKED:
+		case UICC_PIN_VERIFIED:
+		default:
+			break;
+		}
+
+		break;
+	case UICC_IND:
+		DBG("UICC IND RECEIVED");
+
+		if (msg[1] =3D=3D UICC_START_UP_COMPLETE)
+			sd->passwd_required =3D FALSE;
+
+		break;
+	default:
+		break;
+	}
+}
+
+static void uicc_reachable_cb(GIsiClient *client, gboolean alive,
+				uint16_t object, void *opaque)
+{
+	struct ofono_sim *sim =3D opaque;
+	struct sim_data *sd =3D ofono_sim_get_data(sim);;
+
+	if (!alive) {
+		DBG("SIM client: %s", strerror(-g_isi_client_error(client)));
+		ofono_sim_remove(sim);
+	} else {
+		DBG("%s (v%03d.%03d) reachable",
+			pn_resource_name(g_isi_client_resource(client)),
+			g_isi_version_major(client),
+			g_isi_version_minor(client));
+		g_isi_subscribe(client, UICC_IND, uicc_ind_handler, opaque);
+		g_isi_subscribe(client, UICC_CARD_IND,
+				uicc_ind_handler, opaque);
+		g_isi_subscribe(client, UICC_PIN_IND,
+				uicc_ind_handler, opaque);
+		g_isi_subscribe(client, UICC_APPLICATION_IND,
+				uicc_ind_handler, opaque);
+		if (!sd->uicc_app_started) {
+			DBG("Let's check if we have UICC applications");
+			uicc_application_list_req(client, sim);
+		}
+	}
+}
+
+static int uicc_probe(struct ofono_sim *sim, unsigned int vendor,
+			void *user)
+{
+	GIsiModem *idx =3D user;
+	struct sim_data *sd =3D g_try_new0(struct sim_data, 1);
+	int ret =3D 0;
+
+	if (!sd)
+		ret =3D -ENOMEM;
+
+	if (!ret) {
+		sd->client =3D get_pn_uicc_client(idx, PN_UICC);
+
+		if (!sd->client)
+			ret =3D -ENOMEM;
+
+		sd->uicc_app_started =3D FALSE;
+		sd->pin_state_received =3D FALSE;
+		sd->passwd_required =3D TRUE;
+		sd->current_pin_id =3D 0x01;
+		sd->pin1_id =3D 0x01;
+		sd->pin2_id =3D 0x81;
+
+		uicc_sim =3D sim;
+		ofono_sim_set_data(sim, sd);
+	} else
+		g_free(sd);
+
+	if (!ret && sd->client)
+		g_isi_verify(sd->client, uicc_reachable_cb, sim);
+
+	return ret;
+}
+
+static void isi_uicc_remove(struct ofono_sim *sim)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+
+	DBG("");
+
+	if (!sd)
+		return;
+
+	sd->uicc_app_started =3D FALSE;
+	sd->pin_state_received =3D FALSE;
+	sd->passwd_required =3D TRUE;
+
+	pn_uicc_client_destroy(sd->client);
+
+	ofono_sim_set_data(sim, NULL);
+
+	g_free(sd);
+}
+
+static struct ofono_sim_driver driver =3D {
+	.name			=3D "isimodem25",
+	.probe			=3D uicc_probe,
+	.remove			=3D isi_uicc_remove,
+	.read_file_info		=3D isi_read_file_info,
+	.read_file_transparent	=3D isi_read_file_transparent,
+	.read_file_linear	=3D isi_read_file_linear_fixed,
+#ifdef READ_FILE_CYCLIC
+	.read_file_cyclic	=3D isi_read_file_cyclic,
+#else
+	.read_file_cyclic	=3D NULL,
+#endif
+#ifdef WRITE_FILE_TRANSPARENT
+	.write_file_transparent	=3D isi_write_file_transparent,
+#else
+	.write_file_transparent	=3D NULL,
+#endif
+	.write_file_linear	=3D isi_write_file_linear,
+#ifdef WRITE_FILE_CYCLIC
+	.write_file_cyclic	=3D isi_write_file_cyclic,
+#else
+	.write_file_cyclic	=3D NULL,
+#endif
+	.read_imsi		=3D uicc_read_imsi_req,
+	.query_passwd_state	=3D uicc_passwd_state_query,
+	.send_passwd		=3D uicc_pin_enter,
+	.reset_passwd		=3D uicc_pin_send_puk,
+	.change_passwd		=3D uicc_change_pin,
+	.lock			=3D uicc_pin_enable,
+#ifdef QUERY_LOCKED
+	.query_locked		=3D uicc_query_locked
+#else
+	.query_locked		=3D NULL
+#endif
+};
+
+struct ofono_sim_driver *get_sim_driver_func()
+{
+	return &driver;
+}
+
+void isi_sim_init()
+{
+	uicc_sim =3D NULL;
+	pn_uicc_client =3D NULL;
+	uicc_users =3D 0;
+	ofono_sim_driver_register(&driver);
+}
+
+void isi_sim_exit()
+{
+	ofono_sim_driver_unregister(&driver);
+}
+
+GIsiClient *get_pn_uicc_client(GIsiModem *modem, uint8_t resource)
+{
+	if (!pn_uicc_client)
+		pn_uicc_client =3D g_isi_client_create(modem, resource);
+
+	uicc_users++;
+	return pn_uicc_client;
+}
+
+void pn_uicc_client_destroy(GIsiClient *client)
+{
+	if (uicc_users > 0)
+		uicc_users--;
+	if (!uicc_users) {
+		if (pn_uicc_client) {
+			g_isi_client_destroy(client);
+			pn_uicc_client =3D NULL;
+		}
+	}
+}
diff --git a/drivers/isimodem2.5/uicc.h b/drivers/isimodem2.5/uicc.h
new file mode 100644
index 0000000..84e4eee
--- /dev/null
+++ b/drivers/isimodem2.5/uicc.h
@@ -0,0 +1,253 @@
+/*
+ * This file is part of oFono - Open Source Telephony
+ *
+ * Copyright (C) 2009 Nokia Corporation and/or its subsidiary(-ies).
+ * Copyright (C) ST-Ericsson SA 2010.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#ifndef __ISIMODEM25_UICC_H
+#define __ISIMODEM25_UICC_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#define PN_UICC 0x8C
+
+#define UICC_APPL_ID_UNKNOWN			0x00
+#define UICC_SFI_NOT_PRESENT			0x00
+#define UICC_SESSION_ID_NOT_USED		0x00
+
+enum uicc_status {
+	UICC_STATUS_OK =3D			0x00,
+	UICC_STATUS_FAIL =3D			0x01,
+	UICC_STATUS_UNKNOWN =3D			0x02,
+	UICC_STATUS_NOT_READY =3D			0x10,
+	UICC_STATUS_START_UP_COMPLETED =3D	0x11,
+	UICC_STATUS_SHUTTING_DOWN =3D		0x12,
+	UICC_STATUS_CARD_NOT_READY =3D		0x20,
+	UICC_STATUS_CARD_READY =3D		0x21,
+	UICC_STATUS_CARD_DISCONNECTED =3D		0x22,
+	UICC_STATUS_CARD_NOT_PRESENT =3D		0x23,
+	UICC_STATUS_CARD_REJECTED =3D		0x24,
+	UICC_STATUS_APPL_ACTIVE =3D		0x30,
+	UICC_STATUS_APPL_NOT_ACTIVE =3D		0x31,
+	UICC_STATUS_PIN_ENABLED =3D		0x40,
+	UICC_STATUS_PIN_DISABLED =3D		0x41
+};
+
+enum uicc_subblock {
+	UICC_SB_SHUT_DOWN_CONFIG =3D		0x0023,
+	UICC_SB_CARD_STATUS =3D			0x0001,
+	UICC_SB_CARD_INFO =3D			0x0024,
+	UICC_SB_CARD_REJECT_CAUSE =3D		0x0025,
+	UICC_SB_CLIENT =3D			0x001F,
+	UICC_SB_APPL_DATA_OBJECT =3D		0x0002,
+	UICC_SB_APPLICATION =3D			0x0003,
+	UICC_SB_APPL_INFO =3D			0x0004,
+	UICC_SB_APPL_STATUS =3D			0x0005,
+	UICC_SB_FCP =3D				0x0007,
+	UICC_SB_FCI =3D				0x001C,
+	UICC_SB_CHV =3D				0x001B,
+	UICC_SB_PIN =3D				0x0008,
+	UICC_SB_PIN_REF =3D			0x0009,
+	UICC_SB_PUK =3D				0x000A,
+	UICC_SB_PIN_SUBST =3D			0x000B,
+	UICC_SB_PIN_INFO =3D			0x000C,
+	UICC_SB_APPL_PATH =3D			0x000D,
+	UICC_SB_SESSION =3D			0x000E,
+	UICC_SB_FILE_DATA =3D			0x000F,
+	UICC_SB_APDU =3D				0x0014,
+	UICC_SB_TRANSPARENT_READ =3D		0x0010,
+	UICC_SB_TRANSPARENT_UPDATE =3D		0x0011,
+	UICC_SB_TRANSPARENT =3D			0x0012,
+	UICC_SB_LINEAR_FIXED =3D			0x0013,
+	UICC_SB_CYCLIC =3D			0x0026,
+	UICC_SB_TERMINAL_PROFILE =3D		0x0015,
+	UICC_SB_TERMINAL_RESPONSE =3D		0x001D,
+	UICC_SB_ENVELOPE =3D			0x0021,
+	UICC_SB_POLLING_SET =3D			0x0016,
+	UICC_SB_REFRESH =3D			0x0017,
+	UICC_SB_AID =3D				0x0006,
+	UICC_SB_REFRESH_RESULT =3D		0x0018,
+	UICC_SB_APDU_ACTIONS =3D			0x0019,
+	UICC_SB_OBJECT_ID =3D			0x001A,
+	UICC_SB_STATUS_WORD =3D			0x0020,
+	UICC_SB_APDU_SAP_INFO =3D			0x0022,
+	UICC_SB_ACCESS_MODE =3D			0x0027,
+	UICC_SB_RESP_INFO =3D			0x0028,
+	UICC_SB_APDU_SAP_CONFIG =3D		0x0029
+
+};
+
+enum uicc_message_id {
+	UICC_REQ =3D				0x00,
+	UICC_RESP =3D				0x01,
+	UICC_IND =3D				0x02,
+	UICC_CARD_REQ =3D				0x03,
+	UICC_CARD_RESP =3D			0x04,
+	UICC_CARD_IND =3D				0x05,
+	UICC_APPLICATION_REQ =3D			0x06,
+	UICC_APPLICATION_RESP =3D			0x07,
+	UICC_APPLICATION_IND =3D			0x08,
+	UICC_PIN_REQ =3D				0x09,
+	UICC_PIN_RESP =3D				0x0A,
+	UICC_PIN_IND =3D				0x0B,
+	UICC_APPL_CMD_REQ =3D			0x0C,
+	UICC_APPL_CMD_RESP =3D			0x0D,
+	UICC_APPL_CMD_IND =3D			0x0E,
+	UICC_CONNECTOR_REQ =3D			0x0F,
+	UICC_CONNECTOR_RESP =3D			0x10,
+	UICC_CAT_REQ =3D				0x12,
+	UICC_CAT_RESP =3D				0x13,
+	UICC_CAT_IND =3D				0x14,
+	UICC_APDU_REQ =3D				0x15,
+	UICC_APDU_RESP =3D			0x16,
+	UICC_APDU_RESET_IND =3D			0x17,
+	UICC_REFRESH_REQ =3D			0x18,
+	UICC_REFRESH_RESP =3D			0x19,
+	UICC_REFRESH_IND =3D			0x1A,
+	UICC_SIMLOCK_REQ =3D			0x1B,
+	UICC_SIMLOCK_RESP =3D			0x1C,
+	UICC_APDU_SAP_REQ =3D			0x1E,
+	UICC_APDU_SAP_RESP =3D			0x1F,
+	UICC_APDU_SAP_IND =3D			0x20,
+	UICC_PWR_CTRL_REQ =3D			0x21,
+	UICC_PWR_CTRL_RESP =3D			0x22,
+	UICC_PWR_CTRL_IND =3D			0x23
+};
+
+enum uicc_service_type {
+	UICC_APPL_LIST =3D			0x01,
+	UICC_APPL_HOST_ACTIVATE =3D		0x03,
+	UICC_APPL_START_UP_COMPLETE =3D		0x05,
+	UICC_APPL_SHUT_DOWN_INITIATED =3D		0x06,
+	UICC_APPL_STATUS_GET =3D			0x07,
+	UICC_APPL_HOST_DEACTIVATE =3D		0x09,
+	UICC_PIN_VERIFY =3D			0x11,
+	UICC_PIN_UNBLOCK =3D			0x12,
+	UICC_PIN_DISABLE =3D			0x13,
+	UICC_PIN_ENABLE =3D			0x14,
+	UICC_PIN_CHANGE =3D			0x15,
+	UICC_PIN_SUBSTITUTE =3D			0x16,
+	UICC_PIN_INFO =3D				0x17,
+	UICC_PIN_PROMPT_VERIFY =3D		0x18,
+	UICC_APPL_READ_TRANSPARENT =3D		0x21,
+	UICC_APPL_UPDATE_TRANSPARENT =3D		0x22,
+	UICC_APPL_READ_LINEAR_FIXED =3D		0x23,
+	UICC_APPL_UPDATE_LINEAR_FIXED =3D		0x24,
+	UICC_APPL_FILE_INFO =3D			0x25,
+	UICC_APPL_APDU_SEND =3D			0x26,
+	UICC_APPL_CLEAR_CACHE =3D			0x27,
+	UICC_APPL_SESSION_START	=3D		0x28,
+	UICC_APPL_SESSION_END =3D			0x29,
+	UICC_APPL_READ_CYCLIC =3D			0x2A,
+	UICC_APPL_UPDATE_CYCLIC =3D		0x2B,
+	UICC_CONNECT =3D				0x31,
+	UICC_DISCONNECT =3D			0x32,
+	UICC_RECONNECT =3D			0x33,
+	UICC_CAT_ENABLE =3D			0x41,
+	UICC_CAT_DISABLE =3D			0x42,
+	UICC_CAT_TERMINAL_PROFILE =3D		0x43,
+	UICC_CAT_TERMINAL_RESPONSE =3D		0x44,
+	UICC_CAT_ENVELOPE =3D			0x45,
+	UICC_CAT_POLLING_SET =3D			0x46,
+	UICC_CAT_REFRESH =3D			0x47,
+	UICC_CAT_POLL =3D				0x48,
+	UICC_APDU_SEND =3D			0x51,
+	UICC_APDU_ATR_GET =3D			0x52,
+	UICC_APDU_CONTROL =3D			0x53,
+	UICC_REFRESH_STATUS =3D			0x61,
+	UICC_APPL_TERMINATED =3D			0x71,
+	UICC_APPL_RECOVERED =3D			0x72,
+	UICC_APPL_ACTIVATED =3D			0x75,
+	UICC_PIN_VERIFY_NEEDED =3D		0x81,
+	UICC_PIN_UNBLOCK_NEEDED =3D		0x82,
+	UICC_PIN_PERMANENTLY_BLOCKED =3D		0x83,
+	UICC_PIN_VERIFIED =3D			0x84,
+	UICC_CAT_FETCHED_CMD =3D			0x91,
+	UICC_CAT_NOT_SUPPORTED =3D		0x92,
+	UICC_CAT_REG_FAILED =3D			0x93,
+	UICC_CAT_REG_OK =3D			0x94,
+	UICC_REFRESH_PERMISSION =3D		0xA1,
+	UICC_REFRESH_STARTING =3D			0xA2,
+	UICC_REFRESH_CANCELLED =3D		0xA3,
+	UICC_REFRESH_NOW =3D			0xA4,
+	UICC_START_UP_COMPLETE =3D		0xB0,
+	UICC_STATUS_GET =3D			0xB1,
+	UICC_READY =3D				0xB2,
+	UICC_READY_FOR_ACTIVATION =3D		0xB3,
+	UICC_INITIALIZED =3D			0xB4,
+	UICC_SHUTTING_DOWN =3D			0xB5,
+	UICC_SHUT_DOWN_CONFIG =3D			0xB6,
+	UICC_ERROR =3D				0xB7,
+	UICC_CARD_DISCONNECTED =3D		0xC0,
+	UICC_CARD_REMOVED =3D			0xC1,
+	UICC_CARD_NOT_PRESENT =3D			0xC2,
+	UICC_CARD_READY =3D			0xC4,
+	UICC_CARD_STATUS_GET =3D			0xC5,
+	UICC_CARD_REJECTED =3D			0xC8,
+	UICC_CARD_INFO_GET =3D			0xC9,
+	UICC_SIMLOCK_ACTIVE =3D			0xD0,
+	UICC_APDU_SAP_ACTIVATE =3D		0xE1,
+	UICC_APDU_SAP_DEACTIVATE =3D		0xE2,
+	UICC_APDU_SAP_ATR_GET =3D			0xE3,
+	UICC_APDU_SAP_COLD_RESET =3D		0xE4,
+	UICC_APDU_SAP_WARM_RESET =3D		0xE5,
+	UICC_APDU_SAP_APDU_SEND =3D		0xE6,
+	UICC_APDU_SAP_RECOVERY =3D		0xE7,
+	UICC_APDU_SAP_CONFIG_GET =3D		0xE8,
+	UICC_PWR_CTRL_ENABLE =3D			0xF1,
+	UICC_PWR_CTRL_DISABLE =3D			0xF2,
+	UICC_PWR_CTRL_WAIT =3D			0xF3,
+	UICC_PWR_CTRL_PROCEED =3D			0xF4,
+	UICC_PWR_CTRL_PERMISSION =3D		0xFA
+};
+
+enum uicc_appl_type_table {
+	UICC_APPL_TYPE_UNKNOWN =3D		0x00,
+	UICC_APPL_TYPE_ICC_SIM =3D		0x01,
+	UICC_APPL_TYPE_UICC_USIM =3D		0x02
+};
+enum uicc_pin_qualifier {
+	UICC_PIN_NEW =3D				0x01,
+	UICC_PIN_OLD =3D				0x02
+};
+enum uicc_appl_start_up_type {
+	UICC_APPL_START_UP_NO_INIT_PROC =3D	0x00,
+	UICC_APPL_START_UP_INIT_PROC =3D		0x01
+};
+enum uicc_card_type {
+	UICC_CARD_TYPE_ICC =3D			0x01,
+	UICC_CARD_TYPE_UICC =3D			0x02
+};
+enum uicc_details {
+	UICC_NO_DETAILS =3D			0x00,
+	UICC_INVALID_PARAMETERS =3D		0x01,
+	UICC_FILE_NOT_FOUND =3D			0x02
+};
+enum uicc_simlock_status {
+	UICC_SIMLOCK_STATUS_ACTIVE =3D		0x01,
+	UICC_SIMLOCK_STATUS_INACTIVE =3D		0x02
+};
+
+#ifdef __cplusplus
+};
+#endif
+
+#endif /* __ISIMODEM25_UICC_H */
diff --git a/drivers/isimodem2.5/uicc_interface.h b/drivers/isimodem2.5/uic=
c_interface.h
new file mode 100644
index 0000000..4b70fb7
--- /dev/null
+++ b/drivers/isimodem2.5/uicc_interface.h
@@ -0,0 +1,40 @@
+/*
+ * This file is part of oFono - Open Source Telephony
+ *
+ * Copyright (C) ST-Ericsson SA 2010.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#ifndef __ISIMODEM25_UICC_INTERFACE_H
+#define __ISIMODEM25_UICC_INTERFACE_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+int get_app_id();
+int get_app_type();
+int get_client_id();
+GIsiClient *read_pn_uicc_client(); /* Only returns the exisisting client */
+GIsiClient *get_pn_uicc_client(GIsiModem *modem, uint8_t resource);
+void pn_uicc_client_destroy(GIsiClient *client);
+struct ofono_sim_driver *get_sim_driver_func();
+struct ofono_sim *get_sim();
+#ifdef __cplusplus
+};
+#endif
+
+#endif /* __ISIMODEM25_UICC_INTERFACE_H */
diff --git a/drivers/isimodem2.5/ussd.c b/drivers/isimodem2.5/ussd.c
new file mode 100644
index 0000000..9fd19a5
--- /dev/null
+++ b/drivers/isimodem2.5/ussd.c
@@ -0,0 +1,341 @@
+/*
+ * This file is part of oFono - Open Source Telephony
+ *
+ * Copyright (C) 2009 Nokia Corporation and/or its subsidiary(-ies).
+ * Copyright (C) ST-Ericsson SA 2010.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/uio.h>
+
+
+#include <gisi/client.h>
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/ussd.h>
+
+#include <glib.h>
+
+#include "debug.h"
+#include "isimodem.h"
+#include "isiutil.h"
+#include "smsutil.h"
+#include "ss.h"
+#include "util.h"
+
+struct ussd_data {
+	GIsiClient *client;
+};
+
+/**
+ * Convert type to status
+ * @param type
+ */
+static inline int isi_type_to_status(uint8_t type)
+{
+	switch (type) {
+	case SS_GSM_USSD_MT_REPLY:
+		return OFONO_USSD_STATUS_LOCAL_CLIENT_RESPONDED;
+	case SS_GSM_USSD_COMMAND:
+		return OFONO_USSD_STATUS_ACTION_REQUIRED;
+	case SS_GSM_USSD_NOTIFY:
+		return OFONO_USSD_STATUS_NOTIFY;
+	case SS_GSM_USSD_END:
+		return OFONO_USSD_STATUS_TERMINATED;
+	case SS_GSM_USSD_REQUEST:
+	default:
+		return OFONO_USSD_STATUS_NOT_SUPPORTED;
+	}
+}
+
+/**
+ * Parse ussd
+ * @param ussd
+ * @param restrict_data
+ * @param len
+ */
+static void ussd_parse(struct ofono_ussd *ussd, const void *restrict data,
+	    size_t len)
+{
+	const unsigned char *msg =3D data;
+	int status =3D OFONO_USSD_STATUS_NOT_SUPPORTED;
+
+	if (!msg || len < 4)
+		ofono_ussd_notify(ussd, status, 0, NULL, 0);
+
+	status =3D isi_type_to_status(msg[2]);
+
+	if (msg[3] =3D=3D 0 || (size_t)(msg[3] + 4) > len)
+		ofono_ussd_notify(ussd, status, msg[1], msg + 4, msg[3]);
+}
+
+/**
+ * Callback for ussd send response
+ * @param client
+ * @param restrict_data
+ * @param len
+ * @param object
+ * @param opaque
+ */
+static gboolean ussd_send_resp_cb(GIsiClient *client,
+					const void *restrict data, size_t len,
+					uint16_t object, void *opaque)
+{
+	const unsigned char *msg =3D data;
+	struct isi_cb_data *cbd =3D opaque;
+	ofono_ussd_cb_t cb =3D (cbd) ? cbd->cb : NULL;
+
+	if (!msg) {
+		DBG("ISI client error: %d", g_isi_client_error(client));
+		goto error;
+	}
+
+	if (!cbd || !cb)
+		goto error;
+
+	DBG("%s", ss_message_id_name(msg[0]));
+
+	if (len < 3)
+		return FALSE;
+
+	if (msg[0] =3D=3D SS_SERVICE_FAILED_RESP)
+		goto error;
+
+	if (len < 4 || msg[0] !=3D SS_GSM_USSD_SEND_RESP)
+		return FALSE;
+
+	CALLBACK_WITH_SUCCESS(cb, cbd->data);
+	ussd_parse(cbd->user, data, len);
+	goto out;
+error:
+	CALLBACK_WITH_FAILURE(cb, cbd->data);
+out:
+	g_free(cbd);
+	return TRUE;
+}
+
+/**
+ * Send a USSD ISI request
+ * @param ussd
+ * @param str
+ * @param cb
+ * @param data
+ */
+static void isi_request(struct ofono_ussd *ussd, int dcs,
+			const unsigned char *pdu, int len,
+			ofono_ussd_cb_t cb, void *data)
+{
+	struct ussd_data *ud =3D ofono_ussd_get_data(ussd);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(ussd, cb, data);
+	uint8_t filled_len =3D (4 + len + 3) & ~3;
+	const uint8_t padding_bytes[] =3D {0, 0, 0, 0, 0, 0, 0, 0};
+	const uint8_t msg[] =3D {
+		SS_GSM_USSD_SEND_REQ,
+		SS_GSM_USSD_COMMAND,
+		0x01, /* subblock count */
+		/* Sub-block 1*/
+		SS_GSM_USSD_STRING,
+		filled_len, /* subblock length */
+		dcs, /* DCS */
+		len, /* string length */
+		/* USSD string goes here */
+	};
+	const struct iovec iov[3] =3D {
+		{ (uint8_t *) msg, sizeof(msg) },
+		{ (uint8_t *)pdu, len },
+		{ (uint8_t *) padding_bytes, (filled_len - len - 4) }
+	};
+	DBG("");
+	DBG("len=3D%d", (int) len);
+
+	if (!cbd || !ud)
+		goto error;
+
+	if (g_isi_request_vmake(ud->client, (struct iovec *) iov, 3,
+		SS_TIMEOUT, ussd_send_resp_cb, data))
+		return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, data);
+	g_free(cbd);
+}
+
+/**
+  * Cancel USSD ISI request
+  * @param ussd
+  * @param cb
+  * @param data
+  */
+static void isi_cancel(struct ofono_ussd *ussd,
+			ofono_ussd_cb_t cb, void *data)
+{
+	struct ussd_data *ud =3D ofono_ussd_get_data(ussd);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(ussd, cb, data);
+	const unsigned char msg[] =3D {
+		SS_GSM_USSD_SEND_REQ,
+		SS_GSM_USSD_END,
+		0x00 /* subblock count */
+	};
+	DBG("");
+
+	if (!cbd || !ud)
+		goto error;
+
+	if (g_isi_request_make(ud->client, msg, sizeof(msg), SS_TIMEOUT,
+				ussd_send_resp_cb, cbd))
+		return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, data);
+	g_free(cbd);
+}
+
+/**
+ * USSD indication callback
+ * @param client
+ * @param restrict_data
+ * @param len
+ * @param object
+ * @param opaque
+ */
+static void ussd_ind_cb(GIsiClient *client,
+			const void *restrict data, size_t len,
+			uint16_t object, void *opaque)
+{
+	const unsigned char *msg =3D data;
+	struct ofono_ussd *ussd =3D opaque;
+	DBG("%s", ss_message_id_name(msg[0]));
+
+	if (!msg || len < 4 || msg[0] !=3D SS_GSM_USSD_RECEIVE_IND)
+		return;
+
+	ussd_parse(ussd, data, len);
+}
+
+/**
+  * Subscribe to USSD
+  * @param user
+  */
+static gboolean isi_ussd_register(gpointer user)
+{
+	struct ofono_ussd *ussd =3D user;
+	struct ussd_data *ud =3D ofono_ussd_get_data(ussd);
+	g_isi_subscribe(ud->client, SS_GSM_USSD_RECEIVE_IND, ussd_ind_cb, ussd);
+	ofono_ussd_register(ussd);
+	return FALSE;
+}
+
+/**
+  * USSD reachable callback
+  * @param client
+  * @param alive
+  * @param object
+  * @param opaque
+  */
+static void ussd_reachable_cb(GIsiClient *client,
+				gboolean alive, uint16_t object,
+				void *opaque)
+{
+	struct ofono_ussd *ussd =3D opaque;
+
+	if (!alive) {
+		DBG("Unable to bootstrap ussd driver");
+		return;
+	}
+
+	DBG("%s (v%03d.%03d) reachable",
+		pn_resource_name(g_isi_client_resource(client)),
+		g_isi_version_major(client),
+		g_isi_version_minor(client));
+	g_idle_add(isi_ussd_register, ussd);
+}
+
+/**
+ * Probe USSD server
+ * @param ussd
+ * @param vendor
+ * @param user
+ */
+static int isi_ussd_probe(struct ofono_ussd *ussd, unsigned int vendor,
+				void *user)
+{
+	GIsiModem *idx =3D user;
+	struct ussd_data *ud =3D g_try_new0(struct ussd_data, 1);
+
+	if (!ud)
+		return -ENOMEM;
+
+	ud->client =3D get_pn_ss_client(idx, PN_SS);
+
+	if (!ud->client) {
+		g_free(ud);
+		return -ENOMEM;
+	}
+
+	ofono_ussd_set_data(ussd, ud);
+	g_isi_verify(ud->client, ussd_reachable_cb, ussd);
+	return 0;
+}
+
+/**
+ * Remove USSD
+ * @param ussd
+ */
+static void isi_ussd_remove(struct ofono_ussd *ussd)
+{
+	struct ussd_data *data =3D ofono_ussd_get_data(ussd);
+
+	if (!data)
+		return;
+
+	ofono_ussd_set_data(ussd, NULL);
+	pn_ss_client_destroy(data->client);
+	g_free(data);
+}
+
+static struct ofono_ussd_driver driver =3D {
+	.name		=3D "isimodem25",
+	.probe		=3D isi_ussd_probe,
+	.remove		=3D isi_ussd_remove,
+	.request	=3D isi_request,
+	.cancel		=3D isi_cancel
+};
+
+/**
+ * Init USSD
+ */
+void isi_ussd_init()
+{
+	ofono_ussd_driver_register(&driver);
+}
+
+/**
+ * Unregister USSD
+ */
+void isi_ussd_exit()
+{
+	ofono_ussd_driver_unregister(&driver);
+}
diff --git a/drivers/isimodem2.5/voicecall.c b/drivers/isimodem2.5/voicecal=
l.c
new file mode 100644
index 0000000..ecb0d0d
--- /dev/null
+++ b/drivers/isimodem2.5/voicecall.c
@@ -0,0 +1,1555 @@
+/*
+ * This file is part of oFono - Open Source Telephony
+ *
+ * Copyright (C) 2009 Nokia Corporation and/or its subsidiary(-ies).
+ * Copyright (C) ST-Ericsson SA 2010.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+#include <assert.h>
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include <glib.h>
+
+#include <ofono/modem.h>
+#include <ofono/call-settings.h>
+#include <gisi/client.h>
+#include <src/common.h>
+#include <gisi/iter.h>
+#include <gisi/netlink.h>
+#include <ofono/log.h>
+#include <ofono/voicecall.h>
+
+#include "debug.h"
+#include "call.h"
+#include "isimodem.h"
+#include "isiutil.h"
+#include "timeout.h"
+
+struct isi_call {
+	uint8_t id, call_id, status, mode, mode_info, cause_type, cause;
+	uint8_t addr_type, presentation;
+	uint8_t reason;
+	char address[30], addr_pad[4];
+};
+
+struct isi_voicecall {
+	GIsiClient *client;
+
+	struct isi_call_req_context *queue;
+
+	struct isi_call calls[8];
+
+	void *control_req_irc;
+};
+
+/* -----------------------------------------------------------------------=
-- */
+
+static void isi_call_notify(struct ofono_voicecall *ovc,
+				struct isi_call *call);
+static void isi_call_release(struct ofono_voicecall *, struct isi_call *);
+static struct ofono_call isi_call_as_ofono_call(struct isi_call const *);
+static int isi_call_status_to_clcc(struct isi_call const *call);
+static struct isi_call *isi_call_set_idle(struct isi_call *call);
+static struct isi_call_req_context *isi_call_status_req(
+	struct ofono_voicecall *ovc,
+	uint8_t id,
+	uint8_t mode,
+	ofono_voicecall_cb_t cb,
+	void *data);
+
+static void isi_call_status_ind_cb(GIsiClient *,
+					void const *restrict,
+					size_t,
+					uint16_t,
+					void *);
+
+typedef void GIsiVerify(GIsiClient *client, gboolean alive, uint16_t objec=
t,
+			void *opaque);
+
+typedef gboolean GIsiResponse(GIsiClient *client,
+				void const *restrict data, size_t len,
+				uint16_t object, void *opaque);
+
+static GIsiVerify isi_call_verify_cb;
+static gboolean isi_call_register(gpointer);
+
+/* -----------------------------------------------------------------------=
-- */
+/* Request context for voicecall cb */
+
+struct isi_call_req_context;
+
+typedef void isi_call_req_step(struct isi_call_req_context *, int reason);
+
+struct isi_call_req_context {
+	struct isi_call_req_context *next, **prev;
+	isi_call_req_step *step;
+	struct ofono_voicecall *ovc;
+	ofono_voicecall_cb_t cb;
+	void *data;
+};
+
+/* -----------------------------------------------------------------------=
-- */
+
+static struct isi_call_req_context *isi_call_req(
+	struct ofono_voicecall *ovc,
+	void const *restrict req,
+	size_t len,
+	GIsiResponse *handler,
+	ofono_voicecall_cb_t cb,
+	void *data) {
+
+	struct isi_voicecall *ivc;
+	struct isi_call_req_context *irc;
+
+	ivc =3D ofono_voicecall_get_data(ovc);
+	DBG("");
+
+	irc =3D g_try_new0(struct isi_call_req_context, 1);
+
+	if (irc) {
+		irc->ovc =3D ovc;
+		irc->cb =3D cb;
+		irc->data =3D data;
+
+		if (g_isi_request_make(ivc->client, req, len,
+					ISI_CALL_TIMEOUT, handler, irc))
+			return irc;
+	}
+
+	g_free(irc);
+
+	if (cb)
+		CALLBACK_WITH_FAILURE(cb, data);
+
+	return NULL;
+}
+
+static void isi_ctx_queue(struct isi_call_req_context *irc,
+				isi_call_req_step *next)
+{
+	DBG("");
+
+	if (irc->prev =3D=3D NULL) {
+		struct isi_voicecall *ivc =3D ofono_voicecall_get_data(irc->ovc);
+
+		if (ivc->queue) {
+			irc->next =3D ivc->queue;
+			irc->next->prev =3D &irc->next;
+		}
+
+		irc->prev =3D &ivc->queue;
+		ivc->queue =3D irc;
+	}
+
+	irc->step =3D next;
+}
+
+static void isi_ctx_remove(struct isi_call_req_context *irc)
+{
+	DBG("");
+
+	if (irc->prev) {
+		*irc->prev =3D irc->next;
+
+		if (irc->next) {
+			irc->next->prev =3D irc->prev;
+			irc->next =3D NULL;
+		}
+
+		irc->prev =3D NULL;
+	}
+}
+
+static void isi_ctx_free(struct isi_call_req_context *irc)
+{
+	DBG("");
+
+	if (irc) {
+		isi_ctx_remove(irc);
+		g_free(irc);
+	}
+}
+
+static gboolean isi_ctx_return(struct isi_call_req_context *irc,
+				enum ofono_error_type type,
+				int error)
+{
+	DBG("");
+
+	if (!irc)
+		return TRUE;
+
+	if (irc->cb) {
+		struct ofono_error e =3D { .type =3D type, .error =3D error };
+		irc->cb(&e, irc->data);
+	}
+
+	isi_ctx_free(irc);
+	return TRUE;
+}
+
+static gboolean isi_ctx_return_failure(struct isi_call_req_context *irc)
+{
+	DBG("");
+	return isi_ctx_return(irc, OFONO_ERROR_TYPE_FAILURE, 0);
+}
+
+static gboolean isi_ctx_return_success(struct isi_call_req_context *irc)
+{
+	DBG("");
+
+	if (irc && irc->step) {
+		irc->step(irc, 0);
+		return TRUE;
+	}
+
+	return isi_ctx_return(irc, OFONO_ERROR_TYPE_NO_ERROR, 0);
+}
+
+/* -----------------------------------------------------------------------=
-- */
+/* Decoding subblocks */
+
+static void isi_call_any_address_sb_proc(struct isi_voicecall *ivc,
+						struct isi_call *call,
+						GIsiSubBlockIter const *sb)
+{
+	uint8_t addr_type, presentation, addr_len;
+	char *address;
+
+	if (!g_isi_sb_iter_get_byte(sb, &addr_type, 2) ||
+		!g_isi_sb_iter_get_byte(sb, &presentation, 3) ||
+		/* fillerbyte */
+		!g_isi_sb_iter_get_byte(sb, &addr_len, 5) ||
+		!g_isi_sb_iter_get_alpha_tag(sb, &address, 2 * addr_len, 6))
+		return;
+
+	call->addr_type =3D addr_type | 0x80;
+	call->presentation =3D presentation;
+	strncpy(call->address, address, sizeof call->address);
+	g_free(address);
+}
+
+static void isi_call_origin_address_sb_proc(struct isi_voicecall *ivc,
+						struct isi_call *call,
+						GIsiSubBlockIter const *sb)
+{
+	if (!call->address[0])
+		isi_call_any_address_sb_proc(ivc, call, sb);
+}
+
+static void isi_call_destination_address_sb_proc(struct isi_voicecall *ivc,
+						struct isi_call *call,
+						GIsiSubBlockIter const *sb)
+{
+	if (!call->address[0])
+		isi_call_any_address_sb_proc(ivc, call, sb);
+}
+
+static void isi_call_mode_sb_proc(struct isi_voicecall *ivc,
+					struct isi_call *call,
+					GIsiSubBlockIter const *sb)
+{
+	uint8_t mode, mode_info;
+
+	if (!g_isi_sb_iter_get_byte(sb, &mode, 2) ||
+			!g_isi_sb_iter_get_byte(sb, &mode_info, 3))
+		return;
+
+	call->mode =3D mode;
+	call->mode_info =3D mode_info;
+}
+
+static void isi_call_cause_sb_proc(struct isi_voicecall *ivc,
+					struct isi_call *call,
+					GIsiSubBlockIter const *sb)
+{
+	uint8_t cause_type, cause;
+
+	if (!g_isi_sb_iter_get_byte(sb, &cause_type, 2) ||
+			!g_isi_sb_iter_get_byte(sb, &cause, 3))
+		return;
+
+	call->cause_type =3D cause_type;
+	call->cause =3D cause;
+}
+
+static void isi_call_status_sb_proc(struct isi_voicecall *ivc,
+					struct isi_call *call,
+					GIsiSubBlockIter const *sb,
+					struct ofono_voicecall *ovc)
+{
+	uint8_t status;
+
+	if (!g_isi_sb_iter_get_byte(sb, &status, 2))
+		return;
+
+	if ((status !=3D CALL_MODEM_STATUS_ANSWERED) &&
+	    (status !=3D CALL_MODEM_STATUS_COMING) &&
+	    (status !=3D CALL_MODEM_STATUS_PROCEEDING) &&
+	    (status !=3D CALL_MODEM_STATUS_MT_ALERTING))
+		call->status =3D status;
+
+	if (status =3D=3D CALL_MODEM_STATUS_MT_ALERTING) {
+		isi_call_status_req(ovc,
+			call->call_id,
+			CALL_MODEM_STATUS_MODE_ADDR_AND_ORIGIN,
+			NULL, NULL);
+	}
+}
+
+static struct isi_call *isi_call_status_info_sb_proc(
+	struct isi_voicecall *ivc,
+	struct isi_call calls[8],
+	GIsiSubBlockIter const *sb) {
+	struct isi_call *call =3D NULL;
+	int i;
+	uint8_t call_id;
+	uint8_t mode;
+	uint8_t mode_info;
+	uint8_t status;
+
+	if (!g_isi_sb_iter_get_byte(sb, &call_id, 2) ||
+			!g_isi_sb_iter_get_byte(sb, &mode, 3) ||
+			!g_isi_sb_iter_get_byte(sb, &mode_info, 4) ||
+			!g_isi_sb_iter_get_byte(sb, &status, 5))
+		return NULL;
+
+	i =3D call_id & 7;
+
+	if (1 <=3D i && i <=3D 7) {
+		call =3D &calls[i];
+		call->call_id =3D call_id;
+
+		if ((status !=3D CALL_MODEM_STATUS_ANSWERED) &&
+		    (status !=3D CALL_MODEM_STATUS_COMING) &&
+		    (status !=3D CALL_MODEM_STATUS_PROCEEDING))
+			call->status =3D status;
+
+		call->mode =3D mode;
+		call->mode_info =3D mode_info;
+	}
+
+	return call;
+}
+
+static struct isi_call *isi_call_addr_and_status_info_sb_proc(
+	struct isi_voicecall *ivc,
+	struct isi_call calls[8],
+	GIsiSubBlockIter const *sb) {
+	struct isi_call *call =3D NULL;
+	int i;
+	uint8_t call_id;
+	uint8_t mode;
+	uint8_t mode_info;
+	uint8_t status;
+	uint8_t addr_type;
+	uint8_t presentation;
+	uint8_t addr_len;
+	char *address;
+
+	if (!g_isi_sb_iter_get_byte(sb, &call_id, 2) ||
+		!g_isi_sb_iter_get_byte(sb, &mode, 3) ||
+		!g_isi_sb_iter_get_byte(sb, &mode_info, 4) ||
+		!g_isi_sb_iter_get_byte(sb, &status, 5) ||
+		/*filler*/
+		/*link id*/
+		!g_isi_sb_iter_get_byte(sb, &addr_type, 8) ||
+		!g_isi_sb_iter_get_byte(sb, &presentation, 9) ||
+		/*filler*/
+		!g_isi_sb_iter_get_byte(sb, &addr_len, 11) ||
+		!g_isi_sb_iter_get_alpha_tag(sb, &address, 2 * addr_len, 12))
+		return NULL;
+
+	i =3D call_id & 7;
+
+	if (1 <=3D i && i <=3D 7) {
+		call =3D &calls[i];
+		call->call_id =3D call_id;
+
+		if ((status !=3D CALL_MODEM_STATUS_ANSWERED) &&
+			(status !=3D CALL_MODEM_STATUS_COMING) &&
+			(status !=3D CALL_MODEM_STATUS_PROCEEDING))
+			call->status =3D status;
+
+		call->mode =3D mode;
+		call->mode_info =3D mode_info;
+		call->addr_type =3D addr_type | 0x80;
+		call->presentation =3D presentation;
+		strncpy(call->address, address, sizeof call->address);
+	}
+
+	free(address);
+
+	return call;
+}
+
+/* -----------------------------------------------------------------------=
-- */
+/* PN_CALL messages */
+
+static GIsiResponse isi_call_status_resp,
+	isi_call_create_resp,
+	isi_call_answer_resp,
+	isi_call_release_resp,
+	isi_call_control_resp,
+	isi_call_dtmf_send_resp;
+
+static struct isi_call_req_context *isi_call_create_req(
+	struct ofono_voicecall *ovc,
+	uint8_t presentation,
+	uint8_t addr_type,
+	char const address[21],
+	ofono_voicecall_cb_t cb,
+	void *data) {
+
+	size_t addr_len =3D strlen(address);
+	size_t sub_len =3D (6 + 2 * addr_len + 3) & ~3;
+	size_t i, offset =3D 3 + 4 + 4 + 6;
+	uint8_t req[3 + 4 + 4 + 6 + 40] =3D {
+		CALL_MODEM_CREATE_REQ,
+		0, /* No id */
+		3, /* Subblock count: Mode, Clir, Number */
+		/* MODE SB */
+		/* (CALL__MODEM_MODE_INFO '0' indicates a local origination) */
+		/*sb id, len, mode, filler*/
+		CALL_MODEM_SB_MODE, 4, CALL_MODEM_MODE_SPEECH, 0,
+		/* ORIGIN_INFO SB */
+		/*sb id, len, presentation, filler*/
+		CALL_MODEM_SB_LINE_ID, 4, presentation, 0,
+		/* DESTINATION ADDRESS SB */
+		CALL_MODEM_SB_DESTINATION_ADDRESS,
+		sub_len,
+		addr_type & 0x7F,
+		0, 0,   /*filler*/
+		addr_len,
+		/* uint16_t addr[20] */
+	};
+	size_t rlen =3D 3 + 4 + 4 + sub_len;
+	struct isi_call_req_context *irc =3D NULL;
+	DBG("");
+
+	if (addr_len > 20) {
+		CALLBACK_WITH_FAILURE(cb, data);
+		return NULL;
+	}
+
+	for (i =3D 0; i < addr_len; i++)
+		req[offset + 2 * i + 1] =3D address[i];
+
+	irc =3D isi_call_req(ovc, req, rlen, isi_call_create_resp, cb, data);
+
+	return irc;
+}
+
+static gboolean isi_call_create_resp(GIsiClient *client,
+					void const *restrict data,
+					size_t len,
+					uint16_t object,
+					void *irc)
+{
+	struct {
+		uint8_t message_id, call_id, sub_blocks;
+	} const *m =3D data;
+	DBG("");
+
+	if (m !=3D NULL && len < (sizeof *m))
+		return FALSE;
+
+	if (m =3D=3D NULL)
+		return isi_ctx_return_failure(irc);
+
+	if (m->message_id !=3D CALL_MODEM_CREATE_RESP)
+		return FALSE;
+
+	DBG("call id: %02X", m->call_id);
+
+	if (m->call_id !=3D CALL_MODEM_ID_NONE && m->sub_blocks =3D=3D 0)
+		return isi_ctx_return_success(irc);
+
+	/* Cause ? */
+	return isi_ctx_return_failure(irc);
+}
+
+static void isi_call_status_ind_cb(GIsiClient *client,
+					void const *restrict data,
+					size_t len,
+					uint16_t object,
+					void *_ovc)
+{
+	struct ofono_voicecall *ovc =3D _ovc;
+	struct isi_voicecall *ivc =3D ofono_voicecall_get_data(ovc);
+	struct {
+		uint8_t message_id, call_id, sub_blocks;
+	} const *m =3D data;
+	struct isi_call *call;
+	uint8_t old;
+	GIsiSubBlockIter sb[1];
+	DBG("");
+
+	if (len < 3)
+		return; /* runt */
+
+	if ((m->call_id & 7) =3D=3D 0)
+		return;
+
+	call =3D &ivc->calls[m->call_id & 7];
+	old =3D call->status;
+	call->call_id =3D m->call_id;
+
+	for (g_isi_sb_iter_init(sb, data, len, (sizeof *m));
+			g_isi_sb_iter_is_valid(sb);
+			g_isi_sb_iter_next(sb)) {
+		switch (g_isi_sb_iter_get_id(sb)) {
+		case CALL_MODEM_SB_ORIGIN_ADDRESS:
+			isi_call_origin_address_sb_proc(ivc, call, sb);
+			break;
+		case CALL_MODEM_SB_STATUS:
+			isi_call_status_sb_proc(ivc, call, sb, ovc);
+			break;
+		case CALL_MODEM_SB_MODE:
+			isi_call_mode_sb_proc(ivc, call, sb);
+			break;
+		case CALL_MODEM_SB_CAUSE:
+			isi_call_cause_sb_proc(ivc, call, sb);
+			break;
+		case CALL_MODEM_SB_DESTINATION_ADDRESS:
+			isi_call_destination_address_sb_proc(ivc, call, sb);
+			break;
+		case CALL_MODEM_SB_DETAILED_CAUSE:
+		case CALL_MODEM_SB_DESTINATION_PRE_ADDRESS:
+		case CALL_MODEM_SB_DESTINATION_POST_ADDRESS:
+		case CALL_MODEM_SB_DESTINATION_SUBADDRESS:
+		case CALL_MODEM_SB_NW_CAUSE:
+			break;
+		}
+	}
+
+	DBG("    call id: %02X, mode: %02X status: %02X",
+		call->call_id, call->mode, call->status);
+
+	if (old !=3D call->status) {
+		if (call->status =3D=3D CALL_MODEM_STATUS_IDLE) {
+			isi_call_notify(ovc, call);
+			isi_call_set_idle(call);
+			return;
+		}
+	}
+
+	isi_call_notify(ovc, call);
+}
+
+static struct isi_call_req_context *isi_call_answer_req(
+				struct ofono_voicecall *ovc,
+				uint8_t call_id,
+				ofono_voicecall_cb_t cb,
+				void *data)
+{
+	uint8_t const req[] =3D {
+		CALL_MODEM_ANSWER_REQ, call_id, 0
+	};
+	size_t rlen =3D sizeof req;
+	DBG("");
+
+	return isi_call_req(ovc, req, rlen, isi_call_answer_resp, cb, data);
+}
+
+static gboolean isi_call_answer_resp(GIsiClient *client,
+					void const *restrict data,
+					size_t len,
+					uint16_t object,
+					void *irc)
+{
+	struct {
+		uint8_t message_id, call_id, sub_blocks;
+	} const *m =3D data;
+	DBG("");
+
+	if (m !=3D NULL && len < (sizeof *m))
+		return FALSE;
+
+	if (m =3D=3D NULL)
+		return isi_ctx_return_failure(irc);
+
+	if (m->message_id !=3D CALL_MODEM_ANSWER_RESP)
+		return FALSE;
+
+	if (m->call_id !=3D CALL_MODEM_ID_NONE && m->sub_blocks =3D=3D 0)
+		return isi_ctx_return_success(irc);
+
+	/* Cause ? */
+	return isi_ctx_return_failure(irc);
+}
+
+static struct isi_call_req_context *isi_call_release_req(
+	struct ofono_voicecall *ovc,
+	uint8_t call_id,
+	uint8_t cause_type,
+	uint8_t cause,
+	ofono_voicecall_cb_t cb,
+	void *data) {
+
+	uint8_t const req[] =3D {
+		CALL_MODEM_RELEASE_REQ,
+		call_id,
+		1, /*Subblock count*/
+		CALL_MODEM_SB_CAUSE,
+		4, /*Subblock length*/
+		cause_type,
+		cause,
+	};
+
+	size_t rlen =3D sizeof req;
+
+	struct isi_call_req_context *irc =3D
+		isi_call_req(ovc, req, rlen, isi_call_release_resp, cb, data);
+	DBG("");
+
+	return irc;
+}
+
+static gboolean isi_call_release_resp(GIsiClient *client,
+					void const *restrict data,
+					size_t len,
+					uint16_t object,
+					void *irc)
+{
+	const unsigned char *msg =3D data;
+	struct {
+		uint8_t message_id, call_id, sub_blocks;
+	} const *m =3D data;
+	GIsiSubBlockIter i[1];
+	uint8_t cause_type =3D 0, cause =3D 0;
+	DBG("");
+
+	if (m !=3D NULL && len < (sizeof *m))
+		return FALSE;
+
+	if (m =3D=3D NULL)
+		return isi_ctx_return_failure(irc);
+
+	if (m->message_id !=3D CALL_MODEM_RELEASE_RESP)
+		return FALSE;
+
+	for (g_isi_sb_iter_init(i, msg, len, (sizeof *m));
+			g_isi_sb_iter_is_valid(i);
+			g_isi_sb_iter_next(i)) {
+		if (g_isi_sb_iter_get_id(i) !=3D CALL_MODEM_SB_CAUSE ||
+				!g_isi_sb_iter_get_byte(i, &cause_type, 2) ||
+				!g_isi_sb_iter_get_byte(i, &cause, 3))
+			continue;
+	}
+
+	DBG("cause type: %02X, cause: %02X", cause_type, cause);
+
+	if ((cause_type =3D=3D CALL_MODEM_CAUSE_TYPE_SERVER ||
+			cause_type =3D=3D CALL_MODEM_CAUSE_TYPE_CLIENT) &&
+			(cause =3D=3D CALL_MODEM_CAUSE_RELEASE_BY_USER ||
+			cause =3D=3D CALL_MODEM_CAUSE_BUSY_USER_REQUEST))
+		return isi_ctx_return_success(irc);
+	else
+		return isi_ctx_return_failure(irc);
+}
+
+static struct isi_call_req_context *isi_call_status_req(
+	struct ofono_voicecall *ovc,
+	uint8_t id,
+	uint8_t mode,
+	ofono_voicecall_cb_t cb,
+	void *data) {
+
+	unsigned char req[] =3D {
+		CALL_MODEM_STATUS_REQ,
+		id, /*Call id*/
+		1, /*Subblock count*/
+		CALL_MODEM_SB_STATUS_MODE,
+		4, /*Subblock length*/
+		mode,
+		0, /*filler*/
+	};
+	size_t rlen =3D sizeof req;
+	DBG("");
+
+	return isi_call_req(ovc, req, rlen, isi_call_status_resp, cb, data);
+}
+
+
+static gboolean isi_call_status_resp(GIsiClient *client,
+					void const *restrict data,
+					size_t len,
+					uint16_t object,
+					void *_irc)
+{
+	struct isi_call_req_context *irc =3D _irc;
+	struct ofono_voicecall *ovc =3D irc->ovc;
+	struct isi_voicecall *ivc =3D ofono_voicecall_get_data(ovc);
+	struct {
+		uint8_t message_id, call_id, sub_blocks;
+	} const *m =3D data;
+	GIsiSubBlockIter sb[1];
+	struct isi_call *call =3D NULL;
+	DBG("");
+
+	if (m !=3D NULL && len < (sizeof *m))
+		return FALSE;
+
+	if (m =3D=3D NULL)
+		return isi_ctx_return_failure(irc);
+
+	if (m->message_id !=3D CALL_MODEM_STATUS_RESP)
+		return FALSE;
+
+	for (g_isi_sb_iter_init(sb, m, len, (sizeof *m));
+			g_isi_sb_iter_is_valid(sb);
+			g_isi_sb_iter_next(sb)) {
+		switch (g_isi_sb_iter_get_id(sb)) {
+		case CALL_MODEM_SB_STATUS_INFO:
+			call =3D isi_call_status_info_sb_proc(
+					ivc, ivc->calls, sb);
+			break;
+		case CALL_MODEM_SB_ADDR_AND_STATUS_INFO:
+			call =3D isi_call_addr_and_status_info_sb_proc(
+					ivc, ivc->calls, sb);
+
+			if (call)
+				isi_call_notify(ovc, call);
+
+			break;
+		case CALL_MODEM_SB_CAUSE:
+
+			if (call)
+				isi_call_cause_sb_proc(ivc, call, sb);
+
+			break;
+		}
+	}
+
+	return isi_ctx_return_success(irc);
+}
+
+static struct isi_call_req_context *isi_call_control_req(
+	struct ofono_voicecall *ovc,
+	uint8_t call_id,
+	uint8_t op,
+	uint8_t info,
+	ofono_voicecall_cb_t cb,
+	void *data) {
+
+	uint8_t const req[] =3D {
+		CALL_MODEM_CONTROL_REQ,
+		call_id,
+		1, /*Subblock count*/
+		CALL_MODEM_SB_OPERATION,
+		4, /*Subblock length*/
+		op,
+		info, /*filler*/
+	};
+	size_t rlen =3D sizeof req;
+	DBG("");
+
+	return isi_call_req(ovc, req, rlen, isi_call_control_resp, cb, data);
+}
+
+static gboolean isi_call_control_resp(GIsiClient *client,
+					void const *restrict data,
+					size_t len,
+					uint16_t object,
+					void *irc)
+{
+	struct isi_call_req_context *resp_irc =3D irc;
+	struct {
+		uint8_t message_id, call_id, sub_blocks;
+	} const *m =3D data;
+	GIsiSubBlockIter i[1];
+	uint8_t cause_type =3D 0, cause =3D 0;
+	DBG("");
+
+	if (m !=3D NULL && len < sizeof *m)
+		return FALSE;
+
+	if (m =3D=3D NULL)
+		return isi_ctx_return_failure(irc);
+
+	if (m->message_id !=3D CALL_MODEM_CONTROL_RESP)
+		return FALSE;
+
+	for (g_isi_sb_iter_init(i, m, len, (sizeof *m));
+			g_isi_sb_iter_is_valid(i);
+			g_isi_sb_iter_next(i)) {
+		if (g_isi_sb_iter_get_id(i) !=3D CALL_MODEM_SB_CAUSE ||
+				!g_isi_sb_iter_get_byte(i, &cause_type, 2) ||
+				!g_isi_sb_iter_get_byte(i, &cause, 3))
+			continue;
+	}
+
+	if (cause) {
+		struct isi_voicecall *ivc =3D ofono_voicecall_get_data(
+							resp_irc->ovc);
+		gboolean ret =3D isi_ctx_return_failure(irc);
+		ivc->control_req_irc =3D NULL;
+		return ret;
+	}
+
+	return TRUE;
+}
+
+static void isi_call_control_ind_cb(GIsiClient *client,
+					void const *restrict data,
+					size_t len,
+					uint16_t object,
+					void *_ovc)
+{
+	struct ofono_voicecall *ovc =3D _ovc;
+	struct isi_voicecall *ivc =3D ofono_voicecall_get_data(ovc);
+	struct {
+		uint8_t message_id, call_id, sub_blocks;
+	} const *m =3D data;
+	GIsiSubBlockIter i[1];
+	uint8_t cause_type =3D 0, cause =3D 0;
+	DBG("");
+
+	if (len < 3 || m =3D=3D NULL)
+		return;
+
+	if (m->message_id !=3D CALL_MODEM_CONTROL_IND)
+		return;
+
+	for (g_isi_sb_iter_init(i, m, len, (sizeof *m));
+			g_isi_sb_iter_is_valid(i);
+			g_isi_sb_iter_next(i)) {
+		if (g_isi_sb_iter_get_id(i) !=3D CALL_MODEM_SB_CAUSE ||
+				!g_isi_sb_iter_get_byte(i, &cause_type, 2) ||
+				!g_isi_sb_iter_get_byte(i, &cause, 3))
+			continue;
+	}
+
+	if (ivc->control_req_irc) {
+		if (!cause)
+			isi_ctx_return_success(ivc->control_req_irc);
+		else
+			isi_ctx_return_failure(ivc->control_req_irc);
+
+		ivc->control_req_irc =3D NULL;
+	}
+}
+
+static struct isi_call_req_context *isi_call_dtmf_send_req(
+	struct ofono_voicecall *ovc,
+	uint8_t call_id,
+	char const *string,
+	ofono_voicecall_cb_t cb,
+	void *data) {
+
+	size_t str_len =3D strlen(string);
+	size_t sub_len =3D 4 + ((2 * str_len + 3) & ~3);
+	size_t i, offset =3D 3 + 4 + 8 + 4;
+	size_t rlen =3D 3 + 4 + 8 + sub_len;
+	uint8_t req[3 + 4 + 8 + (255 & ~3)] =3D {
+		CALL_MODEM_DTMF_SEND_REQ,
+		call_id,
+		3, /* Subblock count */
+		CALL_MODEM_SB_DTMF_INFO,
+		4, /* Subblock length */
+		CALL_MODEM_DTMF_ENABLE_TONE_IND_SEND,
+		0, /*filler*/
+		CALL_MODEM_SB_DTMF_TIMERS,
+		8, /* Subblock length */
+		0, 200, /* duration in ms */
+		0, 100, /* gap in ms */
+		0, 0, /* filler */
+		CALL_MODEM_SB_DTMF_STRING,
+		sub_len,
+		CALL_MODEM_DTMF_PAUSE_1S, /* pause length */
+		str_len,
+		/* string */
+	};
+	DBG("");
+
+	if (sub_len >=3D 256) {
+		CALLBACK_WITH_FAILURE(cb, data);
+		return FALSE;
+	}
+
+	for (i =3D 0; i < str_len; i++)
+		req[offset + 2 * i + 1] =3D string[i];
+
+	return isi_call_req(ovc, req, rlen, isi_call_dtmf_send_resp, cb, data);
+}
+
+static gboolean isi_call_dtmf_send_resp(GIsiClient *client,
+					void const *restrict data,
+					size_t len,
+					uint16_t object,
+					void *irc)
+{
+	struct {
+		uint8_t message_id, call_id, sub_blocks;
+	} const *m =3D data;
+	GIsiSubBlockIter i[1];
+	uint8_t cause_type =3D 0, cause =3D 0;
+	DBG("");
+
+	if (m !=3D NULL && len < (sizeof *m))
+		return FALSE;
+
+	if (m =3D=3D NULL)
+		return isi_ctx_return_failure(irc);
+
+	if (m->message_id !=3D CALL_MODEM_DTMF_SEND_RESP)
+		return FALSE;
+
+	if (m->sub_blocks =3D=3D 0)
+		return isi_ctx_return_success(irc);
+
+	for (g_isi_sb_iter_init(i, m, len, (sizeof *m));
+			g_isi_sb_iter_is_valid(i);
+			g_isi_sb_iter_next(i)) {
+		if (g_isi_sb_iter_get_id(i) !=3D CALL_MODEM_SB_CAUSE ||
+				!g_isi_sb_iter_get_byte(i, &cause_type, 2) ||
+				!g_isi_sb_iter_get_byte(i, &cause, 3))
+			continue;
+	}
+
+	if (!cause)
+		return isi_ctx_return_success(irc);
+	else
+		return isi_ctx_return_failure(irc);
+}
+
+
+/* -----------------------------------------------------------------------=
-- */
+/* Notify */
+
+static void isi_call_notify(struct ofono_voicecall *ovc,
+				struct isi_call *call)
+{
+	struct isi_voicecall *ivc =3D ofono_voicecall_get_data(ovc);
+	struct isi_call_req_context *irc, **queue;
+	struct ofono_call ocall;
+	DBG("");
+
+	for (queue =3D &ivc->queue; (irc =3D *queue);) {
+		irc->step(irc, call->status);
+
+		if (*queue =3D=3D irc)
+			queue =3D &irc->next;
+	}
+
+	switch (call->status) {
+	case CALL_MODEM_STATUS_IDLE:
+		return;
+	case CALL_MODEM_STATUS_MO_RELEASE:
+	case CALL_MODEM_STATUS_MT_RELEASE:
+		isi_call_release(ovc, call);
+		return;
+	default:
+		break;
+	}
+
+	ocall =3D isi_call_as_ofono_call(call);
+	DBG("    id: %u, %s, status: %u, \"%s\", num.type: %u, clpi type: %u",
+		ocall.id,
+		ocall.direction ? "MT" : "MO",
+		ocall.status,
+		ocall.phone_number.number,
+		ocall.phone_number.type,
+		ocall.clip_validity);
+	ofono_voicecall_notify(ovc, &ocall);
+}
+
+static void isi_call_release(struct ofono_voicecall *ovc,
+				struct isi_call *call)
+{
+	struct ofono_error error =3D { OFONO_ERROR_TYPE_NO_ERROR, 0 };
+	enum ofono_disconnect_reason reason;
+	DBG("");
+
+	switch (call->status) {
+	case CALL_MODEM_STATUS_IDLE:
+		reason =3D OFONO_DISCONNECT_REASON_UNKNOWN;
+		break;
+	case CALL_MODEM_STATUS_MO_RELEASE:
+		reason =3D OFONO_DISCONNECT_REASON_LOCAL_HANGUP;
+		break;
+	case CALL_MODEM_STATUS_MT_RELEASE:
+		reason =3D OFONO_DISCONNECT_REASON_REMOTE_HANGUP;
+		break;
+	default:
+		reason =3D OFONO_DISCONNECT_REASON_ERROR;
+		break;
+	}
+
+	if (!call->reason) {
+		call->reason =3D reason;
+		DBG("disconnected id: %02X, reason: %u", call->id, reason);
+		ofono_voicecall_disconnected(ovc, call->id, reason, &error);
+	}
+
+	if (!reason)
+		isi_call_set_idle(call);
+}
+
+static struct ofono_call isi_call_as_ofono_call(struct isi_call const *cal=
l)
+{
+	struct ofono_call ocall =3D { call->id };
+	struct ofono_phone_number *number =3D &ocall.phone_number;
+
+	ocall.type =3D 0; /* Voice call */
+	ocall.direction =3D call->mode_info & CALL_MODEM_MODE_ORIGINATOR;
+	ocall.status =3D isi_call_status_to_clcc(call);
+	memmove(number->number, call->address, sizeof number->number);
+	number->type =3D 0x80 | call->addr_type;
+	ocall.clip_validity =3D call->presentation & 3;
+
+	if (ocall.clip_validity =3D=3D 0 && strlen(number->number) =3D=3D 0)
+		ocall.clip_validity =3D 2;
+
+	return ocall;
+}
+
+/** Get +CLCC status */
+static int isi_call_status_to_clcc(struct isi_call const *call)
+{
+	switch (call->status) {
+	case CALL_MODEM_STATUS_CREATE:
+		return CALL_STATUS_DIALING;
+	case CALL_MODEM_STATUS_COMING:
+	case CALL_MODEM_STATUS_MT_ALERTING:
+		return CALL_STATUS_INCOMING;
+	case CALL_MODEM_STATUS_PROCEEDING:
+		if ((call->mode_info & CALL_MODEM_MODE_ORIGINATOR))
+			return CALL_STATUS_INCOMING;
+		else
+			return CALL_STATUS_DIALING;
+
+	case CALL_MODEM_STATUS_MO_ALERTING:
+		return CALL_STATUS_ALERTING;
+	case CALL_MODEM_STATUS_WAITING:
+		return CALL_STATUS_WAITING;
+	case CALL_MODEM_STATUS_ANSWERED:
+	case CALL_MODEM_STATUS_ACTIVE:
+	case CALL_MODEM_STATUS_MO_RELEASE:
+	case CALL_MODEM_STATUS_MT_RELEASE:
+	case CALL_MODEM_STATUS_HOLD_INITIATED:
+	case CALL_MODEM_STATUS_RECONNECT_PENDING:
+		return CALL_STATUS_ACTIVE;
+	case CALL_MODEM_STATUS_HOLD:
+	case CALL_MODEM_STATUS_RETRIEVE_INITIATED:
+		return CALL_STATUS_HELD;
+	case CALL_MODEM_STATUS_IDLE:
+		return CALL_STATUS_DISCONNECTED;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static struct isi_call *isi_call_set_idle(struct isi_call *call)
+{
+	uint8_t id;
+
+	if (call) {
+		id =3D call->id;
+		memset(call, 0, sizeof *call);
+		call->id =3D id;
+	}
+
+	return call;
+}
+
+/* ---------------------------------------------------------------------- =
*/
+
+static void isi_dial(struct ofono_voicecall *ovc,
+			const struct ofono_phone_number *restrict number,
+			enum ofono_clir_option clir,
+			enum ofono_cug_option cug,
+			ofono_voicecall_cb_t cb,
+			void *data)
+{
+	unsigned char presentation =3D CALL_MODEM_PRESENT_DEFAULT;
+	DBG("");
+
+	if (clir =3D=3D OFONO_CLIR_OPTION_DEFAULT)
+		clir =3D get_clir_status();
+
+	switch (clir) {
+	case OFONO_CLIR_OPTION_DEFAULT:
+		presentation =3D CALL_MODEM_PRESENT_DEFAULT;
+		break;
+	case OFONO_CLIR_OPTION_INVOCATION:
+		presentation =3D CALL_MODEM_PRESENT_RESTRICTED;
+		break;
+	case OFONO_CLIR_OPTION_SUPPRESSION:
+		presentation =3D CALL_MODEM_PRESENT_ALLOWED;
+		break;
+	default:
+		break;
+	}
+
+	if (cug =3D=3D OFONO_CUG_OPTION_INVOCATION) {
+		/* Not implemented */
+		CALLBACK_WITH_FAILURE(cb, data);
+		return;
+	}
+
+	isi_call_create_req(ovc, presentation,
+				number->type,
+				number->number,
+				cb, data);
+}
+
+static void isi_answer(struct ofono_voicecall *ovc,
+			ofono_voicecall_cb_t cb, void *data)
+{
+	struct isi_voicecall *ivc =3D ofono_voicecall_get_data(ovc);
+	uint8_t call_id;
+	DBG("");
+
+	for (call_id =3D 1; call_id <=3D 7; call_id++) {
+		if (ivc->calls[call_id].status =3D=3D
+			CALL_MODEM_STATUS_MT_ALERTING ||
+			ivc->calls[call_id].status =3D=3D CALL_MODEM_STATUS_WAITING)
+			break;
+	}
+
+	isi_call_answer_req(ovc, call_id, cb, data);
+}
+
+
+static void isi_hangup(struct ofono_voicecall *ovc,
+			ofono_voicecall_cb_t cb, void *data)
+{
+	struct isi_voicecall *ivc =3D ofono_voicecall_get_data(ovc);
+
+	uint8_t call_id;
+	DBG("");
+
+	for (call_id =3D 1; call_id <=3D 7; call_id++) {
+		if (ivc->calls[call_id].status =3D=3D
+				CALL_MODEM_STATUS_CREATE ||
+		    ivc->calls[call_id].status =3D=3D
+				CALL_MODEM_STATUS_MO_ALERTING ||
+		    ivc->calls[call_id].status =3D=3D
+				CALL_MODEM_STATUS_PROCEEDING ||
+		    ivc->calls[call_id].status =3D=3D CALL_MODEM_STATUS_ACTIVE)
+			break;
+	}
+
+	DBG("");
+	isi_call_release_req(ovc, call_id, CALL_MODEM_CAUSE_TYPE_CLIENT,
+				CALL_MODEM_CAUSE_RELEASE_BY_USER,
+				cb, data);
+}
+
+static void isi_hangup_all(struct ofono_voicecall *ovc,
+				ofono_voicecall_cb_t cb, void *data)
+{
+	DBG("");
+	isi_call_release_req(ovc, CALL_MODEM_ID_ALL,
+				CALL_MODEM_CAUSE_TYPE_CLIENT,
+				CALL_MODEM_CAUSE_RELEASE_BY_USER,
+				cb, data);
+}
+
+static void isi_release_all_held(struct ofono_voicecall *ovc,
+				 ofono_voicecall_cb_t cb, void *data)
+{
+	DBG("");
+	isi_call_release_req(ovc, CALL_MODEM_ID_HOLD,
+				CALL_MODEM_CAUSE_TYPE_CLIENT,
+				CALL_MODEM_CAUSE_RELEASE_BY_USER,
+				cb, data);
+}
+
+static void isi_set_udub(struct ofono_voicecall *ovc,
+				ofono_voicecall_cb_t cb, void *data)
+{
+	struct isi_voicecall *ivc =3D ofono_voicecall_get_data(ovc);
+	int id;
+	DBG("");
+
+	for (id =3D 1; id <=3D 7; id++) {
+		if (ivc->calls[id].status =3D=3D CALL_MODEM_STATUS_WAITING)
+			break;
+
+		if (ivc->calls[id].status =3D=3D CALL_MODEM_STATUS_MT_ALERTING)
+			break;
+
+		if (ivc->calls[id].status =3D=3D CALL_MODEM_STATUS_COMING)
+			break;
+	}
+
+	if (id <=3D 7)
+		isi_call_release_req(ovc, id,
+					CALL_MODEM_CAUSE_TYPE_CLIENT,
+					CALL_MODEM_CAUSE_BUSY_USER_REQUEST,
+					cb, data);
+	else
+		CALLBACK_WITH_FAILURE(cb, data);
+}
+
+static void isi_retrieve(struct ofono_voicecall *ovc,
+				ofono_voicecall_cb_t cb, void *data)
+{
+	struct isi_voicecall *ivc =3D ofono_voicecall_get_data(ovc);
+	DBG("");
+
+	ivc->control_req_irc =3D isi_call_control_req(ovc, CALL_MODEM_ID_HOLD,
+				CALL_MODEM_OP_RETRIEVE, 0, cb, data);
+}
+
+static isi_call_req_step isi_wait_and_answer, isi_wait_and_retrieve;
+
+static void isi_release_all_active(struct ofono_voicecall *ovc,
+					ofono_voicecall_cb_t cb, void *data)
+{
+	struct isi_voicecall *ivc =3D ofono_voicecall_get_data(ovc);
+	int id, waiting =3D 0, active =3D 0, hold =3D 0;
+	DBG("");
+
+	for (id =3D 1; id <=3D 7; id++) {
+		if (ivc->calls[id].status =3D=3D CALL_MODEM_STATUS_WAITING)
+			waiting++;
+
+		if (ivc->calls[id].status =3D=3D CALL_MODEM_STATUS_HOLD)
+			hold++;
+
+		if (ivc->calls[id].status =3D=3D CALL_MODEM_STATUS_ACTIVE)
+			active++;
+	}
+
+	if (active) {
+		struct isi_call_req_context *irc;
+		irc =3D isi_call_release_req(ovc, CALL_MODEM_ID_ACTIVE,
+					   CALL_MODEM_CAUSE_TYPE_CLIENT,
+					   CALL_MODEM_CAUSE_RELEASE_BY_USER,
+					   cb, data);
+
+		if (irc =3D=3D NULL)
+			;
+		else if (waiting)
+			isi_ctx_queue(irc, isi_wait_and_answer);
+		else if (hold)
+			isi_ctx_queue(irc, isi_wait_and_retrieve);
+	} else
+		CALLBACK_WITH_FAILURE(cb, data);
+}
+
+static void isi_wait_and_answer(struct isi_call_req_context *irc,
+				int event)
+{
+	DBG("");
+	DBG("irc: %p, event: %u", (void *) irc, event);
+
+	switch (event) {
+	case CALL_MODEM_STATUS_IDLE:
+		isi_answer(irc->ovc, irc->cb, irc->data);
+		isi_ctx_free(irc);
+		break;
+	default:
+		break;
+	}
+}
+
+static void isi_wait_and_retrieve(struct isi_call_req_context *irc,
+					int event)
+{
+	DBG("");
+	DBG("irc: %p, event: %u", (void *) irc, event);
+
+	switch (event) {
+	case CALL_MODEM_STATUS_IDLE:
+		isi_retrieve(irc->ovc, irc->cb, irc->data);
+		isi_ctx_free(irc);
+		break;
+	default:
+		break;
+	}
+}
+
+static void isi_hold_all_active(struct ofono_voicecall *ovc,
+				ofono_voicecall_cb_t cb, void *data)
+{
+	struct isi_voicecall *ivc =3D ofono_voicecall_get_data(ovc);
+	int id, op =3D 0, waiting =3D 0, active =3D 0, hold =3D 0;
+	DBG("");
+
+	for (id =3D 1; id <=3D 7; id++) {
+		if (ivc->calls[id].status =3D=3D CALL_MODEM_STATUS_WAITING)
+			waiting++;
+
+		if (ivc->calls[id].status =3D=3D CALL_MODEM_STATUS_HOLD)
+			hold++;
+
+		if (ivc->calls[id].status =3D=3D CALL_MODEM_STATUS_ACTIVE)
+			active++;
+	}
+
+	if (waiting) {
+		isi_call_answer_req(ovc, CALL_MODEM_ID_WAITING, cb, data);
+	} else if (hold) {
+		if (active)
+			id =3D CALL_MODEM_ID_ACTIVE, op =3D CALL_MODEM_OP_SWAP;
+		else
+			id =3D CALL_MODEM_ID_HOLD, op =3D CALL_MODEM_OP_RETRIEVE;
+
+		ivc->control_req_irc =3D isi_call_control_req(ovc, id, op, 0,
+					cb, data);
+	} else if (active) {
+		id =3D CALL_MODEM_ID_ACTIVE, op =3D CALL_MODEM_OP_HOLD;
+		ivc->control_req_irc =3D isi_call_control_req(ovc, id, op, 0,
+					cb, data);
+	} else {
+		CALLBACK_WITH_FAILURE(cb, data);
+	}
+}
+
+static void isi_release_specific(struct ofono_voicecall *ovc, int id,
+				 ofono_voicecall_cb_t cb, void *data)
+{
+	struct isi_voicecall *ivc =3D ofono_voicecall_get_data(ovc);
+	DBG("");
+
+	if (1 <=3D id && id <=3D 7) {
+		struct isi_call const *status =3D &ivc->calls[id];
+		uint8_t cause =3D CALL_MODEM_CAUSE_RELEASE_BY_USER;
+
+		switch (status->status) {
+		case CALL_MODEM_STATUS_MT_ALERTING:
+		case CALL_MODEM_STATUS_WAITING:
+			cause =3D CALL_MODEM_CAUSE_BUSY_USER_REQUEST;
+			break;
+		case CALL_MODEM_STATUS_PROCEEDING:
+
+			if ((status->mode_info & CALL_MODEM_MODE_ORIGINATOR))
+				cause =3D CALL_MODEM_CAUSE_BUSY_USER_REQUEST;
+
+			break;
+		default:
+			break;
+		}
+
+		isi_call_release_req(ovc, id,
+					CALL_MODEM_CAUSE_TYPE_CLIENT, cause,
+					cb, data);
+	} else
+		CALLBACK_WITH_FAILURE(cb, data);
+}
+
+static void isi_private_chat(struct ofono_voicecall *ovc, int id,
+				ofono_voicecall_cb_t cb, void *data)
+{
+	struct isi_voicecall *ivc =3D ofono_voicecall_get_data(ovc);
+	DBG("");
+
+	if (1 <=3D id && id <=3D 7)
+		ivc->control_req_irc =3D isi_call_control_req(ovc,
+					id, CALL_MODEM_OP_CONFERENCE_SPLIT, 0,
+					cb, data);
+	else
+		CALLBACK_WITH_FAILURE(cb, data);
+}
+
+static void isi_create_multiparty(struct ofono_voicecall *ovc,
+					ofono_voicecall_cb_t cb, void *data)
+{
+	struct isi_voicecall *ivc =3D ofono_voicecall_get_data(ovc);
+	DBG("");
+
+	ivc->control_req_irc =3D isi_call_control_req(ovc,
+				CALL_MODEM_ID_ACTIVE,
+				CALL_MODEM_OP_CONFERENCE_BUILD,
+				0, cb, data);
+}
+
+static void isi_transfer(struct ofono_voicecall *ovc,
+				ofono_voicecall_cb_t cb, void *data)
+{
+	struct isi_voicecall *ivc =3D ofono_voicecall_get_data(ovc);
+	uint8_t id;
+	DBG("");
+
+	for (id =3D 1; id <=3D 7; id++) {
+		if (ivc->calls[id].status =3D=3D CALL_MODEM_STATUS_MO_ALERTING)
+			break;
+	}
+
+	if (id > 7)
+		id =3D CALL_MODEM_ID_HOLD;
+
+	ivc->control_req_irc =3D isi_call_control_req(ovc,
+				id, CALL_MODEM_OP_TRANSFER, 0,
+				cb, data);
+}
+
+static void isi_swap_without_accept(struct ofono_voicecall *ovc,
+					ofono_voicecall_cb_t cb, void *data)
+{
+	struct isi_voicecall *ivc =3D ofono_voicecall_get_data(ovc);
+	int id, op =3D 0, active =3D 0, hold =3D 0;
+	DBG("");
+
+	for (id =3D 1; id <=3D 7; id++) {
+		if (ivc->calls[id].status =3D=3D CALL_MODEM_STATUS_HOLD)
+			hold++;
+
+		if (ivc->calls[id].status =3D=3D CALL_MODEM_STATUS_ACTIVE)
+			active++;
+	}
+
+	if (hold && active) {
+		id =3D CALL_MODEM_ID_ACTIVE, op =3D CALL_MODEM_OP_SWAP;
+	} else if (active) {
+		id =3D CALL_MODEM_ID_ACTIVE, op =3D CALL_MODEM_OP_HOLD;
+	} else if (hold) {
+		id =3D CALL_MODEM_ID_HOLD, op =3D CALL_MODEM_OP_RETRIEVE;
+	} else {
+		CALLBACK_WITH_FAILURE(cb, data);
+		return;
+	}
+
+	ivc->control_req_irc =3D isi_call_control_req(ovc, id, op, 0, cb, data);
+}
+
+static void isi_send_tones(struct ofono_voicecall *ovc, const char *tones,
+				 ofono_voicecall_cb_t cb, void *data)
+{
+	DBG("");
+	isi_call_dtmf_send_req(ovc, CALL_MODEM_ID_ALL, tones, cb, data);
+}
+
+static int isi_voicecall_probe(struct ofono_voicecall *ovc,
+				unsigned int vendor,
+				void *user)
+{
+	GIsiModem *idx =3D user;
+	struct isi_voicecall *ivc =3D g_try_new0(struct isi_voicecall, 1);
+	int id;
+	DBG("");
+
+	if (!ivc)
+		return -ENOMEM;
+
+	for (id =3D 0; id <=3D 7; id++)
+		ivc->calls[id].id =3D id;
+
+	ivc->client =3D g_isi_client_create(idx, PN_MODEM_CALL);
+
+	if (!ivc->client) {
+		g_free(ivc);
+		return -ENOMEM;
+	}
+
+	ofono_voicecall_set_data(ovc, ivc);
+
+	if (!g_isi_verify(ivc->client, isi_call_verify_cb, ovc))
+		DBG("unable to verify reachability");
+
+	return 0;
+}
+
+static void isi_call_verify_cb(GIsiClient *client,
+				gboolean alive, uint16_t object,
+				void *ovc)
+{
+	DBG("");
+
+	if (!alive) {
+		DBG("unable to bootstrap voice call driver");
+		return;
+	}
+
+	DBG("    %s (v%03d.%03d) reachable",
+		pn_resource_name(g_isi_client_resource(client)),
+		g_isi_version_major(client),
+		g_isi_version_minor(client));
+	g_idle_add(isi_call_register, ovc);
+}
+
+static gboolean isi_call_register(gpointer _ovc)
+{
+	struct ofono_voicecall *ovc =3D _ovc;
+	struct isi_voicecall *ivc =3D ofono_voicecall_get_data(ovc);
+	DBG("");
+
+	g_isi_subscribe(ivc->client,
+			CALL_MODEM_STATUS_IND, isi_call_status_ind_cb,
+			ovc);
+	g_isi_subscribe(ivc->client,
+			CALL_MODEM_CONTROL_IND, isi_call_control_ind_cb,
+			ovc);
+
+	if (!isi_call_status_req(ovc,
+				CALL_MODEM_ID_ALL,
+				CALL_MODEM_STATUS_MODE_ADDR_AND_ORIGIN,
+				NULL, NULL))
+		DBG("    failed to request call status");
+
+	ofono_voicecall_register(ovc);
+	return FALSE;
+}
+
+static void isi_voicecall_remove(struct ofono_voicecall *call)
+{
+	struct isi_voicecall *data =3D ofono_voicecall_get_data(call);
+	DBG("");
+
+	if (data) {
+		g_isi_client_destroy(data->client);
+		g_free(data);
+	}
+}
+
+static struct ofono_voicecall_driver driver =3D {
+	.name				=3D "isimodem25",
+	.probe				=3D isi_voicecall_probe,
+	.remove				=3D isi_voicecall_remove,
+	.dial				=3D isi_dial,
+	.answer				=3D isi_answer,
+	.hangup_active			=3D isi_hangup,
+	.hangup_all			=3D isi_hangup_all,
+	.hold_all_active		=3D isi_hold_all_active,
+	.release_all_held		=3D isi_release_all_held,
+	.set_udub			=3D isi_set_udub,
+	.release_all_active		=3D isi_release_all_active,
+	.release_specific		=3D isi_release_specific,
+	.private_chat			=3D isi_private_chat,
+	.create_multiparty		=3D isi_create_multiparty,
+	.transfer			=3D isi_transfer,
+	.swap_without_accept		=3D isi_swap_without_accept,
+	.send_tones			=3D isi_send_tones,
+};
+
+void isi_voicecall_init()
+{
+	DBG("");
+	ofono_voicecall_driver_register(&driver);
+}
+
+void isi_voicecall_exit()
+{
+	DBG("");
+	ofono_voicecall_driver_unregister(&driver);
+}
-- =

1.7.3.2


--===============7968256373358350399==--

