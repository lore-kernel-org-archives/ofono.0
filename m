Content-Type: multipart/mixed; boundary="===============3173302184718289878=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [RFC ssn PATCH 3/4] isimodem/ssn: add common notifications
Date: Fri, 08 Oct 2010 18:36:39 +0300
Message-ID: <1286552200-18282-4-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1286552200-18282-3-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3173302184718289878==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

Add notifications on hold, retrieve, multiparty, call waiting, barrings,
and various notifications on call forwarding.

Note that driver uses the CUG index parameter to pass call IDs to core.
---
 drivers/isimodem/call.h |   12 +++
 drivers/isimodem/ssn.c  |  224 +++++++++++++++++++++++++++++++++++++++++++=
++--
 2 files changed, 227 insertions(+), 9 deletions(-)

diff --git a/drivers/isimodem/call.h b/drivers/isimodem/call.h
index 2901971..9a8ba39 100644
--- a/drivers/isimodem/call.h
+++ b/drivers/isimodem/call.h
@@ -402,6 +402,18 @@ enum {
 	CALL_DTMF_DISABLE_TONE_IND_SEND =3D 0x02
 };
 =

+enum {
+	CALL_GSM_SSI_CALL_IS_WAITING =3D		0x01,
+	CALL_GSM_SSI_MPTY =3D			0x02,
+	CALL_GSM_SSI_CLIR_SUPPR_REJ =3D		0x04,
+};
+
+enum {
+	CALL_GSM_SSN_INCOMING_IS_FWD =3D		0x01,
+	CALL_GSM_SSN_INCOMING_FWD =3D		0x02,
+	CALL_GSM_SSN_OUTGOING_FWD =3D		0x04,
+};
+
 #ifdef __cplusplus
 };
 #endif
diff --git a/drivers/isimodem/ssn.c b/drivers/isimodem/ssn.c
index def3b0c..1e1f659 100644
--- a/drivers/isimodem/ssn.c
+++ b/drivers/isimodem/ssn.c
@@ -1,7 +1,7 @@
 /*
  * This file is part of oFono - Open Source Telephony
  *
- * Copyright (C) 2009 Nokia Corporation and/or its subsidiary(-ies).
+ * Copyright (C) 2009-2010 Nokia Corporation and/or its subsidiary(-ies).
  *
  * Contact: Aki Niemi <aki.niemi@nokia.com>
  *
@@ -32,42 +32,248 @@
 #include <errno.h>
 =

 #include <glib.h>
+#include <arpa/inet.h>
 =

 #include <gisi/client.h>
+#include <gisi/iter.h>
 =

 #include <ofono/log.h>
 #include <ofono/modem.h>
 #include <ofono/ssn.h>
 =

 #include "isimodem.h"
+#include "call.h"
+#include "ss.h"
 =

-#define PN_SS			0x06
-
-struct ssn_data {
+struct isi_ssn {
 	GIsiClient *client;
 };
 =

+static void isi_ssn_ss_code(struct ofono_ssn *ssn, uint16_t ss_code)
+{
+	int cssi;
+
+	DBG("ss_code=3D%u", ss_code);
+
+	/* ss-code is MMI code from 22.030 */
+
+	switch (ss_code) {
+	case SS_GSM_FORW_UNCONDITIONAL:
+	case SS_GSM_ALL_FORWARDINGS:
+		/* 3GPP TS 22.082 clause 1.1.1 */
+		cssi =3D OFONO_SS_MO_UNCONDITIONAL_FORWARDING;
+		break;
+
+	case SS_GSM_FORW_NO_REPLY:
+	case SS_GSM_FORW_NO_REACH:
+	case SS_GSM_FORW_BUSY:
+	case SS_GSM_ALL_COND_FORWARDINGS:
+		/* 3GPP TS 22.082 clauses 2.1.1, 3.1.1, 4.1.1 */
+		cssi =3D OFONO_SS_MO_CONDITIONAL_FORWARDING;
+		break;
+
+	case SS_GSM_BARR_ALL_OUT:
+	case SS_GSM_OUTGOING_BARR_SERV:
+	case SS_GSM_BARR_OUT_INTER:
+	case SS_GSM_BARR_OUT_INTER_EXC_HOME:
+		/* 3GPP TS 22.088 clause 1.1 */
+		cssi =3D OFONO_SS_MO_OUTGOING_BARRING;
+		break;
+
+	case SS_GSM_INCOMING_BARR_SERV:
+	case SS_GSM_BARR_ALL_IN:
+	case SS_GSM_BARR_ALL_IN_ROAM:
+		/* 3GPP TS 22.088 clause 2.1 */
+		/* Called subscriber has barred incoming calls */
+		cssi =3D OFONO_SS_MO_INCOMING_BARRING;
+		break;
+
+	default:
+		return;
+	}
+
+	ofono_ssn_cssi_notify(ssn, cssi, 0);
+}
+
+static void isi_ssn_ss_notification(struct ofono_ssn *ssn, int id,
+					uint8_t ss_notification)
+{
+	int code;
+
+	struct ofono_phone_number number =3D { };
+
+	/* See SS-Notification in TS 22.080 clause 4.4.2 */
+
+	if (ss_notification & (1 << 2)) {
+		/* "Call is forwarded" indication to A-subscriber */
+		/* 3GPP TS 22.082 clauses 1.1.3, 2.1.3, 3.1.3, 4.1.3 */
+		code =3D OFONO_SS_MO_CALL_FORWARDED;
+		ofono_ssn_cssi_notify(ssn, code, id);
+	} else if (ss_notification & (1 << 1)) {
+		/* "Call is forwarded" indication to B subscriber */
+		/* 3GPP TS 24.082 clauses 2.1.1, 3.1.1 */
+		code =3D OFONO_SS_MT_OTHER_CALL_FORWARDED;
+		ofono_ssn_cssu_notify(ssn, code, 0, number);
+		/* A subscriber address is not relayed to mobile */
+	} else if (ss_notification & (1 << 0)) {
+		/* "Call is forwarded" indication to C subscriber */
+		/* 3GPP TS 22.082 clauses 1.1.2, 2.1.2, 3.1.2, 4.1.2 */
+		code =3D OFONO_SS_MT_CALL_FORWARDED;
+		ofono_ssn_cssu_notify(ssn, code, id, number);
+		/* The redirecting address is not part of notifySS */
+		/* However, it is available in CALL_COMING_IND */
+	}
+}
+
+static void isi_ssn_notify_indicator(struct ofono_ssn *ssn, int id,
+					uint8_t ss_indicators,
+					struct ofono_phone_number *number)
+{
+	DBG("");
+
+	if (ss_indicators & CALL_GSM_SSI_CALL_IS_WAITING) {
+		ofono_ssn_cssi_notify(ssn,
+			OFONO_SS_MO_CALL_WAITING, id);
+	}
+
+	if (ss_indicators & CALL_GSM_SSI_MPTY) {
+		/* call is connected to multiparty by remote end */
+		ofono_ssn_cssu_notify(ssn,
+			OFONO_SS_MT_MULTIPARTY_VOICECALL, id, number);
+	}
+
+	if (ss_indicators & CALL_GSM_SSI_CLIR_SUPPR_REJ) {
+		ofono_ssn_cssi_notify(ssn,
+			OFONO_SS_MO_CLIR_SUPPRESSION_REJECTED, id);
+	}
+}
+
+static void isi_ssn_hold_indicator(struct ofono_ssn *ssn, int id, uint8_t =
hold)
+{
+	int code;
+
+	struct ofono_phone_number number =3D { };
+
+	DBG("CallOnHoldIndication=3D%u", hold);
+
+	if (hold)
+		code =3D OFONO_SS_MT_VOICECALL_ON_HOLD;
+	else
+		code =3D OFONO_SS_MT_VOICECALL_RETRIEVED;
+
+	ofono_ssn_cssu_notify(ssn, code, id, &number);
+}
+
+static void isi_ssn_ind(GIsiClient *client,
+			void const *restrict data, size_t len,
+			uint16_t object, void *user)
+{
+	struct ofono_ssn *ssn =3D user;
+	struct {
+		uint8_t message_id, call_id, sub_blocks;
+	} const *m =3D data;
+	int id;
+	uint16_t ss_code =3D 0;
+	uint8_t ss_notification =3D 0;
+	uint8_t ss_indicators;
+	uint8_t ss_hold;
+	struct {
+		int ss_notification;
+		int ss_status;
+		int ss_indicators;
+		int ss_hold;
+	} got =3D { };
+	GIsiSubBlockIter sb[1];
+
+	if (len < 3)
+		return;		/* runt */
+
+	id =3D m->call_id & 7;
+	if (id =3D=3D 0)
+		return;
+
+	DBG("id %u, len =3D %zu", id, len);
+
+	for (g_isi_sb_iter_init(sb, data, len, (sizeof *m));
+			g_isi_sb_iter_is_valid(sb);
+				g_isi_sb_iter_next(sb)) {
+		switch (g_isi_sb_iter_get_id(sb)) {
+		case CALL_GSM_SS_CODE:
+			g_isi_sb_iter_get_word(sb, &ss_code, 2);
+			break;
+
+		case CALL_GSM_SS_STATUS:
+			got.ss_status =3D 1;
+			break;
+
+		case CALL_GSM_SS_NOTIFY:
+			if (g_isi_sb_iter_get_byte(sb, &ss_notification, 2))
+				got.ss_notification =3D 1;
+			break;
+
+		case CALL_GSM_SS_NOTIFY_INDICATOR:
+			if (g_isi_sb_iter_get_byte(sb, &ss_indicators, 2))
+				got.ss_indicators =3D 1;
+			break;
+
+		case CALL_GSM_SS_HOLD_INDICATOR:
+			if (g_isi_sb_iter_get_byte(sb, &ss_hold, 2))
+				got.ss_hold =3D 1;
+			break;
+
+		case CALL_GSM_SS_ECT_INDICATOR:
+			/* TODO */
+			break;
+
+		case CALL_GSM_CUG_INFO:
+			/* TODO */
+			break;
+		}
+	}
+
+	if (got.ss_notification)
+		isi_ssn_ss_notification(ssn, id, ss_notification);
+	else if (got.ss_status)
+		isi_ssn_ss_code(ssn, ss_code);
+
+	if (got.ss_indicators)
+		isi_ssn_notify_indicator(ssn, id, ss_indicators);
+
+	if (got.ss_hold)
+		isi_ssn_hold_indicator(ssn, id, ss_hold);
+}
+
 static int isi_ssn_probe(struct ofono_ssn *ssn, unsigned int vendor,
 				void *user)
 {
-	GIsiModem *idx =3D user;
-	struct ssn_data *data =3D g_try_new0(struct ssn_data, 1);
+	GIsiModem *modem =3D user;
+	struct isi_ssn *data;
 =

+	DBG("");
+
+	data =3D g_try_new0(struct isi_ssn, 1);
 	if (!data)
 		return -ENOMEM;
 =

-	data->client =3D g_isi_client_create(idx, PN_SS);
-	if (!data->client)
+	data->client =3D g_isi_client_create(modem, PN_CALL);
+	if (!data->client) {
+		g_free(data);
 		return -ENOMEM;
+	}
 =

 	ofono_ssn_set_data(ssn, data);
 =

+	ofono_ssn_register(ssn);
+
+	g_isi_subscribe(data->client, CALL_GSM_NOTIFICATION_IND,
+			isi_ssn_ind, ssn);
+
 	return 0;
 }
 =

 static void isi_ssn_remove(struct ofono_ssn *ssn)
 {
-	struct ssn_data *data =3D ofono_ssn_get_data(ssn);
+	struct isi_ssn *data =3D ofono_ssn_get_data(ssn);
 =

 	if (data) {
 		g_isi_client_destroy(data->client);
-- =

1.7.0.4


--===============3173302184718289878==--

