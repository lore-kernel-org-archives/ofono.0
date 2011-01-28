Content-Type: multipart/mixed; boundary="===============0430173185936900364=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [ss-notify FYI 3/6] isimodem/ssn: add common notifications
Date: Fri, 28 Jan 2011 19:38:16 +0200
Message-ID: <1296236300-19189-4-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1296236300-19189-3-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0430173185936900364==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

Add notifications on hold, retrieve, multiparty, call waiting, barrings,
and call forwarding.
---
 drivers/isimodem/call.h |   12 ++++
 drivers/isimodem/ssn.c  |  168 +++++++++++++++++++++++++++++++++++++++++++=
+++-
 2 files changed, 179 insertions(+), 1 deletions(-)

diff --git a/drivers/isimodem/call.h b/drivers/isimodem/call.h
index 05f05a5..c95fa69 100644
--- a/drivers/isimodem/call.h
+++ b/drivers/isimodem/call.h
@@ -402,6 +402,18 @@ enum {
 	CALL_DTMF_DISABLE_TONE_IND_SEND =3D	0x02,
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
index 068e5e8..ad93962 100644
--- a/drivers/isimodem/ssn.c
+++ b/drivers/isimodem/ssn.c
@@ -30,20 +30,181 @@
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
 #include "ss.h"
 =

 struct ssn_data {
 	GIsiClient *client;
 };
 =

+static void isi_ssn_ss_code(struct ofono_ssn *ssn, int call_id,
+				uint16_t ss_code, uint8_t ss_notification)
+{
+	int cssi =3D -1;
+	int cssu =3D -1;
+	struct ofono_phone_number number =3D { };
+
+	DBG("ss_code=3D%u, ss_notification=3D0x%02x", ss_code, ss_notification);
+
+	/* ss-code is MMI code from 22.030 */
+	switch (ss_code) {
+	case SS_GSM_FORW_UNCONDITIONAL:
+	case SS_GSM_FORW_NO_REPLY:
+	case SS_GSM_FORW_NO_REACH:
+	case SS_GSM_FORW_BUSY:
+	case SS_GSM_ALL_COND_FORWARDINGS:
+		/* ss-notification is defined in 24.080:
+		 *
+		 * SS-Notification ::=3D OCTET STRING (SIZE (1))
+		 * -- Bit 8 7 6 5 4 00000 (Unused)
+		 * -- Bit 3 (CALL_GSM_SSN_OUTGOING_FWD)
+		 * -- Call is forwarded indication to A-subscriber
+		 * -- (calling subscriber)
+		 * -- 0 =3D No information content
+		 * -- 1 =3D Outgoing call has been forwarded to C
+		 *
+		 * -- Bit 2 (CALL_GSM_SSN_INCOMING_FWD)
+		 * -- Call is forwarded indication to B-subscriber
+		 * -- (forwarding subscriber)
+		 * -- 0 =3D No information content
+		 * -- 1 =3D Incoming call has been forwarded to C
+		 *
+		 * -- Bit 1 (CALL_GSM_SSN_INCOMING_IS_FWD)
+		 * -- Call is forwarded indication to C-subscriber
+		 * -- (forwarded-to subscriber)
+		 * -- 0 =3D No information content
+		 * -- 1 =3D Incoming call is a forwarded call
+		 */
+		if (ss_notification & CALL_GSM_SSN_OUTGOING_FWD)
+			cssi =3D OFONO_SS_MO_CALL_FORWARDED;
+		else if (ss_notification & CALL_GSM_SSN_INCOMING_IS_FWD)
+			cssu =3D OFONO_SS_MT_CALL_FORWARDED;
+		else if (ss_notification & CALL_GSM_SSN_INCOMING_FWD) {
+			if (ss_code =3D=3D SS_GSM_FORW_UNCONDITIONAL)
+				cssi =3D OFONO_SS_MO_CONDITIONAL_FORWARDING;
+			else
+				cssi =3D OFONO_SS_MO_UNCONDITIONAL_FORWARDING;
+		}
+		break;
+
+	case SS_GSM_BARR_ALL_OUT:
+	case SS_GSM_OUTGOING_BARR_SERV:
+	case SS_GSM_BARR_OUT_INTER:
+	case SS_GSM_BARR_OUT_INTER_EXC_HOME:
+		cssi =3D OFONO_SS_MO_OUTGOING_BARRING;
+		break;
+
+	case SS_GSM_INCOMING_BARR_SERV:
+	case SS_GSM_BARR_ALL_IN:
+	case SS_GSM_BARR_ALL_IN_ROAM:
+		cssi =3D OFONO_SS_MO_INCOMING_BARRING;
+		break;
+
+	default:
+		return;
+	}
+
+
+	if (cssi !=3D -1)
+		ofono_ssn_cssi_notify(ssn, cssi, call_id);
+
+	if (cssu !=3D -1)
+		ofono_ssn_cssu_notify(ssn, cssu, call_id, &number);
+}
+
+static void isi_ssn_notify_indicator(struct ofono_ssn *ssn, int call_id,
+					GIsiSubBlockIter const *sb)
+{
+	uint8_t bits;
+	struct ofono_phone_number number =3D { };
+
+	DBG("");
+
+	if (!g_isi_sb_iter_get_byte(sb, &bits, 2))
+		return;
+
+	if (bits & CALL_GSM_SSI_CALL_IS_WAITING)
+		ofono_ssn_cssi_notify(ssn, OFONO_SS_MO_CALL_WAITING, call_id);
+
+	if (bits & CALL_GSM_SSI_MPTY)
+		/* call is connected to multiparty by remote end */
+		ofono_ssn_cssu_notify(ssn, OFONO_SS_MT_MULTIPARTY_VOICECALL,
+					call_id, &number);
+
+	if (bits & CALL_GSM_SSI_CLIR_SUPPR_REJ)
+		ofono_ssn_cssi_notify(ssn,
+			OFONO_SS_MO_CLIR_SUPPRESSION_REJECTED, call_id);
+}
+
+static void isi_ssn_hold_indicator(struct ofono_ssn *ssn, int call_id,
+					GIsiSubBlockIter const *sb)
+{
+	int code;
+	uint8_t hold;
+	struct ofono_phone_number number =3D { };
+
+	DBG("");
+
+	if (!g_isi_sb_iter_get_byte(sb, &hold, 2))
+		return;
+
+	if (hold)
+		code =3D OFONO_SS_MT_VOICECALL_ON_HOLD;
+	else
+		code =3D OFONO_SS_MT_VOICECALL_RETRIEVED;
+
+	ofono_ssn_cssu_notify(ssn, code, call_id, &number);
+}
+
+static void isi_ssn_ind(const GIsiMessage *msg, void *data)
+{
+	struct ofono_ssn *ssn =3D user;
+	int call_id;
+	uint16_t ss_code =3D 0;
+	uint8_t ss_notification =3D 0;
+	GIsiSubBlockIter sb[1];
+
+	if (!g_isi_msg_data_get_byte(msg, 0, &call_id) || call_id =3D=3D 0)
+		return;
+
+	DBG("call_id %u, len =3D %zu", call_id, len);
+
+	for (g_isi_sb_iter_init(sb, msg, 2);
+			g_isi_sb_iter_is_valid(sb);
+			g_isi_sb_iter_next(sb)) {
+		switch (g_isi_sb_iter_get_id(sb)) {
+		case CALL_GSM_SS_CODE:
+			g_isi_sb_iter_get_word(sb, &ss_code, 2);
+			break;
+
+		case CALL_GSM_SS_NOTIFY:
+			g_isi_sb_iter_get_byte(sb, &ss_notification, 2);
+			break;
+
+		case CALL_GSM_SS_NOTIFY_INDICATOR:
+			isi_ssn_notify_indicator(ssn, call_id, sb);
+			break;
+
+		case CALL_GSM_SS_HOLD_INDICATOR:
+			isi_ssn_hold_indicator(ssn, call_id, sb);
+			break;
+		}
+	}
+
+	if (ss_code !=3D 0)
+		isi_ssn_ss_code(ssn, call_id, ss_code, ss_notification);
+}
+
 static int isi_ssn_probe(struct ofono_ssn *ssn, unsigned int vendor,
 				void *user)
 {
@@ -54,7 +215,7 @@ static int isi_ssn_probe(struct ofono_ssn *ssn, unsigned=
 int vendor,
 	if (sd =3D=3D NULL)
 		return -ENOMEM;
 =

-	sd->client =3D g_isi_client_create(modem, PN_SS);
+	sd->client =3D g_isi_client_create(modem, PN_CALL);
 	if (sd->client =3D=3D NULL) {
 		g_free(sd);
 		return -ENOMEM;
@@ -62,6 +223,11 @@ static int isi_ssn_probe(struct ofono_ssn *ssn, unsigne=
d int vendor,
 =

 	ofono_ssn_set_data(ssn, sd);
 =

+	ofono_ssn_register(ssn);
+
+	g_isi_subscribe(data->client, CALL_GSM_NOTIFICATION_IND,
+			isi_ssn_ind, ssn);
+
 	return 0;
 }
 =

-- =

1.7.1


--===============0430173185936900364==--

