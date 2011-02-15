Content-Type: multipart/mixed; boundary="===============7225388417191833666=="
MIME-Version: 1.0
From: Andreas Westin <andreas.westin@stericsson.com>
Subject: [PATCH 15/18] isimodem: wgmodem2.5 added to ssn
Date: Tue, 15 Feb 2011 13:31:09 +0100
Message-ID: <cc88ddffda993490b994c9a975c2f6b70710b4d6.1297772944.git.andreas.westin@stericsson.com>
In-Reply-To: <cover.1297772944.git.andreas.westin@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7225388417191833666==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Jessica Nilsson <jessica.j.nilsson@stericsson.com>

---
 drivers/isimodem/call-forwarding.c |    1 -
 drivers/isimodem/ssn.c             |  382 ++++++++++++++++++++++++++++++++=
+++-
 2 files changed, 377 insertions(+), 6 deletions(-)

diff --git a/drivers/isimodem/call-forwarding.c b/drivers/isimodem/call-for=
warding.c
index 74645c3..1c9a072 100644
--- a/drivers/isimodem/call-forwarding.c
+++ b/drivers/isimodem/call-forwarding.c
@@ -469,7 +469,6 @@ static int isi_call_forwarding_probe(struct ofono_call_=
forwarding *cf,
 		return -ENOMEM;
 =

 	fd->client =3D g_isi_client_create(modem, PN_SS);
-
 	if (fd->client =3D=3D NULL) {
 		g_free(fd);
 		return -ENOMEM;
diff --git a/drivers/isimodem/ssn.c b/drivers/isimodem/ssn.c
index 068e5e8..9f6ceff 100644
--- a/drivers/isimodem/ssn.c
+++ b/drivers/isimodem/ssn.c
@@ -3,6 +3,7 @@
  *  oFono - Open Source Telephony
  *
  *  Copyright (C) 2009-2010 Nokia Corporation and/or its subsidiary(-ies).
+ *  Copyright (C) ST-Ericsson SA 2011.
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2 as
@@ -32,20 +33,381 @@
 #include <glib.h>
 =

 #include <gisi/client.h>
+#include <gisi/iter.h>
 =

 #include <ofono/log.h>
 #include <ofono/modem.h>
 #include <ofono/ssn.h>
 =

+#include "call.h"
 #include "isimodem.h"
 #include "ss.h"
 =

+#define NOT_3GGP_NOTIFICATION -1
+#define PN_SS			0x06
+
+/* TS 27.007 Supplementary service notifications +CSSN */
+enum ss_cssi {
+	SS_MO_UNCONDITIONAL_FORWARDING =3D	0,
+	SS_MO_CONDITIONAL_FORWARDING =3D		1,
+	SS_MO_CALL_FORWARDED =3D			2,
+	SS_MO_CALL_WAITING =3D			3,
+	SS_MO_CUG_CALL =3D			4,
+	SS_MO_OUTGOING_BARRING =3D		5,
+	SS_MO_INCOMING_BARRING =3D		6,
+	SS_MO_CLIR_SUPPRESSION_REJECTED =3D	7,
+	SS_MO_CALL_DEFLECTED =3D			8,
+};
+
+enum ss_cssu {
+	SS_MT_CALL_FORWARDED =3D			0,
+	SS_MT_CUG_CALL =3D			1,
+	SS_MT_VOICECALL_ON_HOLD =3D		2,
+	SS_MT_VOICECALL_RETRIEVED =3D		3,
+	SS_MT_MULTIPARTY_VOICECALL =3D		4,
+	SS_MT_VOICECALL_HOLD_RELEASED =3D		5,
+	SS_MT_FORWARD_CHECK_SS_MESSAGE =3D	6,
+	SS_MT_VOICECALL_IN_TRANSFER =3D		7,
+	SS_MT_VOICECALL_TRANSFERRED =3D		8,
+	SS_MT_CALL_DEFLECTED =3D			9,
+};
+
 struct ssn_data {
 	GIsiClient *client;
 };
 =

+struct isi_ssn_prop {
+	char number[OFONO_MAX_PHONE_NUMBER_LENGTH + 1];
+	int type;
+	uint16_t cug_index;
+};
+
+struct isi_ssn {
+	GIsiClient *client;
+	struct isi_call_req_context *queue;
+};
+
+static void isi_cm_sb_rem_address_sb_proc(struct isi_ssn_prop *ssn_prop,
+		GIsiSubBlockIter const *sb)
+{
+	uint8_t addr_type, addr_len;
+	char *address;
+	DBG("CALL_SB_REMOTE_ADDRESS");
+
+	if (!g_isi_sb_iter_get_byte(sb, &addr_type, 2) ||
+			/* address type */
+			/* presentation indicator */
+			/* fillerbyte */
+			!g_isi_sb_iter_get_byte(sb, &addr_len, 5) ||
+			!g_isi_sb_iter_get_alpha_tag(sb, &address, 2 *
+					addr_len, 6))
+		return;
+
+	strncpy(ssn_prop->number, address, addr_len);
+
+	g_free(address);
+}
+
+static void isi_ssn_notify_ofono(void *_ssn, int cssi, int cssu,
+		struct isi_ssn_prop *ssn_prop)
+{
+	struct ofono_phone_number *phone_nr =3D
+			(struct ofono_phone_number *) ssn_prop;
+
+	if (cssi !=3D NOT_3GGP_NOTIFICATION)
+		ofono_ssn_cssi_notify(_ssn, cssi, ssn_prop->cug_index);
+
+	if (cssu !=3D NOT_3GGP_NOTIFICATION)
+		ofono_ssn_cssu_notify(_ssn, cssi, ssn_prop->cug_index,
+				phone_nr);
+}
+
+static void isi_ssn_call_modem_sb_notify(GIsiSubBlockIter const *sb)
+{
+	uint8_t sb_property;
+	g_isi_sb_iter_get_byte(sb, &sb_property, 2);
+
+	if (sb_property =3D=3D CALL_NOTIFY_USER_SUSPENDED)
+		DBG("CALL_NOTIFY_USER_SUSPENDED");
+
+	if (sb_property =3D=3D CALL_NOTIFY_USER_RESUMED)
+		DBG("CALL_NOTIFY_USER_RESUMED");
+
+	if (sb_property =3D=3D CALL_NOTIFY_BEARER_CHANGE)
+		DBG("CALL_NOTIFY_BEARER_CHANGE");
+}
+
+static void isi_ssn_call_modem_sb_ss_code(GIsiSubBlockIter const *sb,
+		int *cssi_p, int *cssu_p)
+{
+	uint16_t sb_property;
+	g_isi_sb_iter_get_word(sb, &sb_property, 2);
+
+	switch (sb_property) {
+	case(CALL_SSC_ALL_FWDS):
+		DBG("Call forwarding is active");
+	break;
+	case(CALL_SSC_ALL_COND_FWD): {
+		*(cssi_p) =3D SS_MO_CONDITIONAL_FORWARDING;
+		DBG("Some of conditional call forwardings active");
+	}
+	break;
+	case(CALL_SSC_CFU): {
+		*(cssi_p) =3D SS_MO_UNCONDITIONAL_FORWARDING;
+		DBG("Unconditional call forwarding is active");
+	}
+	break;
+	case(CALL_SSC_CFB):
+		DBG("Unknown notification #1");
+	break;
+	case(CALL_SSC_CFNRY):
+		DBG("Unknown notification #2");
+	break;
+	case(CALL_SSC_CFGNC):
+		DBG("Unknown notification #3");
+	break;
+	case(CALL_SSC_OUTGOING_BARR_SERV): {
+		*(cssi_p) =3D SS_MO_OUTGOING_BARRING;
+		DBG("Outgoing calls are barred");
+	}
+	break;
+	case(CALL_SSC_INCOMING_BARR_SERV): {
+		*(cssi_p) =3D SS_MO_INCOMING_BARRING;
+		DBG("Incoming calls are barred");
+	}
+	break;
+	case(CALL_SSC_CALL_WAITING):
+		DBG("Incoming calls are barred");
+	break;
+	case(CALL_SSC_CLIR):
+		DBG("CLIR connected unknown indication.");
+	break;
+	case(CALL_SSC_ETC):
+		DBG("Unknown notification #4");
+	break;
+	case(CALL_SSC_MPTY): {
+		*(cssu_p) =3D SS_MT_MULTIPARTY_VOICECALL;
+		DBG("Multiparty call entered.");
+	}
+	break;
+	case(CALL_SSC_CALL_HOLD): {
+		*(cssu_p) =3D SS_MT_VOICECALL_HOLD_RELEASED;
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
+	if (sb_property & CALL_SS_STATUS_ACTIVE)
+		DBG("CALL_SS_STATUS_ACTIVE");
+
+	if (sb_property & CALL_SS_STATUS_REGISTERED)
+		DBG("CALL_SS_STATUS_REGISTERED");
+
+	if (sb_property & CALL_SS_STATUS_PROVISIONED)
+		DBG("CALL_SS_STATUS_PROVISIONED");
+
+	if (sb_property & CALL_SS_STATUS_QUIESCENT)
+		DBG("CALL_SS_STATUS_QUIESCENT");
+}
+
+static void isi_ssn_call_modem_sb_ss_notify(GIsiSubBlockIter const *sb,
+		int *cssi_p, int *cssu_p)
+{
+	uint8_t sb_property;
+	g_isi_sb_iter_get_byte(sb, &sb_property, 2);
+
+	if (sb_property & CALL_SSN_INCOMING_IS_FWD) {
+		*(cssu_p) =3D SS_MT_CALL_FORWARDED;
+		DBG("This is a forwarded call #1.");
+	}
+
+	if (sb_property & CALL_SSN_INCOMING_FWD)
+		DBG("This is a forwarded call #2.");
+
+	if (sb_property & CALL_SSN_OUTGOING_FWD) {
+		*(cssi_p) =3D SS_MO_CALL_FORWARDED;
+		DBG("Call has been forwarded.");
+	}
+}
+
+static void isi_ssn_call_modem_sb_ss_notify_ind(GIsiSubBlockIter const *sb,
+		int *cssi_p)
+{
+	uint8_t sb_property;
+	g_isi_sb_iter_get_byte(sb, &sb_property, 2);
+
+	if (sb_property & CALL_SSI_CALL_IS_WAITING) {
+		*(cssi_p) =3D SS_MO_CALL_WAITING;
+		DBG("Call is waiting.");
+	}
+
+	if (sb_property & CALL_SSI_MPTY)
+		DBG("Multiparty call.");
+
+	if (sb_property & CALL_SSI_CLIR_SUPPR_REJ) {
+		*(cssi_p) =3D SS_MO_CLIR_SUPPRESSION_REJECTED;
+		DBG("CLIR suppression rejected.");
+	}
+}
+
+static void isi_ssn_call_modem_sb_ss_hold(GIsiSubBlockIter const *sb,
+		int *cssu_p)
+{
+	uint8_t sb_property;
+	g_isi_sb_iter_get_byte(sb, &sb_property, 2);
+
+	if (sb_property & CALL_HOLD_IND_RETRIEVED) {
+		*(cssu_p) =3D SS_MT_VOICECALL_RETRIEVED;
+		DBG("Call has been retrieved.");
+	}
+
+	if (sb_property & CALL_HOLD_IND_ON_HOLD) {
+		*(cssu_p) =3D SS_MT_VOICECALL_ON_HOLD;
+		DBG("Call has been put on hold.");
+	}
+}
+
+static void isi_ssn_call_modem_sb_ss_ect_ind(GIsiSubBlockIter const *sb,
+		int *cssu_p)
+{
+	uint8_t sb_property;
+	g_isi_sb_iter_get_byte(sb, &sb_property, 2);
+
+	if (sb_property & CALL_ECT_CALL_STATE_ALERT) {
+		*(cssu_p) =3D SS_MT_VOICECALL_IN_TRANSFER;
+		DBG("Call is being connected with the remote party");
+		DBG("in alerting state.");
+	}
+
+	if (sb_property & CALL_ECT_CALL_STATE_ACTIVE) {
+		*(cssu_p) =3D SS_MT_VOICECALL_TRANSFERRED;
+		DBG("Call has been connected with the other remote");
+		DBG("party in explicit call transfer operation.");
+	}
+}
+
+static int isi_ssn_call_modem_sb_cug_info(GIsiSubBlockIter const *sb,
+		struct isi_ssn_prop *ssn_prop)
+{
+	uint8_t sb_property;
+	g_isi_sb_iter_get_byte(sb, &sb_property, 2);
+	DBG("CALL_SB_CUG_INFO: This is a CUG Call.");
+	DBG("Preferential CUG: 0x%x,", sb_property);
+	g_isi_sb_iter_get_byte(sb, &sb_property, 3);
+	DBG("Cug Output Access: 0x%x,", sb_property);
+	g_isi_sb_iter_get_word(sb, &ssn_prop->cug_index, 4);
+	DBG("Cug Call Index: 0x%x,", ssn_prop->cug_index);
+	return SS_MO_CUG_CALL;
+}
+
+
+static void isi_callmodem_notif_ind_cb(const GIsiMessage *msg, void *data)
+{
+	struct ofono_ssn *ssn =3D data;
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
+	if (g_isi_msg_data_len(msg) < 3)
+		goto out;
+
+	if (issn->client =3D=3D NULL)
+		goto out;
+
+	for (g_isi_sb_iter_init(sb, data, (sizeof *m));
+			g_isi_sb_iter_is_valid(sb);
+			g_isi_sb_iter_next(sb)) {
+		switch (g_isi_sb_iter_get_id(sb)) {
+		case CALL_SB_NOTIFY:
+			isi_ssn_call_modem_sb_notify(sb);
+			break;
+		case CALL_SB_SS_CODE:
+			isi_ssn_call_modem_sb_ss_code(sb, &cssi, &cssu);
+			break;
+		case CALL_SB_SS_STATUS:
+			isi_ssn_call_modem_sb_ss_status(sb);
+			break;
+		case CALL_SB_SS_NOTIFY:
+			isi_ssn_call_modem_sb_ss_notify(sb, &cssi, &cssu);
+			break;
+		case CALL_SB_SS_NOTIFY_INDICATOR:
+			isi_ssn_call_modem_sb_ss_notify_ind(sb, &cssi);
+			break;
+		case CALL_SB_SS_HOLD_INDICATOR:
+			isi_ssn_call_modem_sb_ss_hold(sb, &cssu);
+			break;
+		case CALL_SB_SS_ECT_INDICATOR:
+			isi_ssn_call_modem_sb_ss_ect_ind(sb, &cssu);
+			break;
+		case CALL_SB_REMOTE_ADDRESS:
+			isi_cm_sb_rem_address_sb_proc(ssn_prop, sb);
+			break;
+		case CALL_SB_REMOTE_SUBADDRESS:
+			break;
+		case CALL_SB_CUG_INFO:
+			cssu =3D isi_ssn_call_modem_sb_cug_info(sb, ssn_prop);
+			break;
+		case CALL_SB_ORIGIN_INFO:
+			break;
+		case CALL_SB_ALERTING_PATTERN:
+			break;
+		case CALL_SB_ALERTING_INFO:
+			break;
+		}
+	}
+
+	isi_ssn_notify_ofono(ssn, cssi, cssu, ssn_prop);
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
+	g_isi_client_ind_subscribe(sd->client, CALL_GSM_NOTIFICATION_IND,
+			isi_callmodem_notif_ind_cb, ssn);
+
+	ofono_ssn_register(user);
+
+	return FALSE;
+}
+
+static void ssn_reachable_cb(const GIsiMessage *msg, void *data)
+{
+	struct ofono_ssn *ssn =3D data;
+	struct ssn_data *sd =3D ofono_ssn_get_data(ssn);
+
+	if (g_isi_msg_error(msg) < 0)
+		return;
+
+	if (sd =3D=3D NULL)
+		return;
+
+	DBG("PN_SSN (v%03d.%03d) reachable.", g_isi_msg_version_major(msg),
+			g_isi_msg_version_minor(msg));
+
+	g_idle_add(isi_ssn_register, ssn);
+}
+
 static int isi_ssn_probe(struct ofono_ssn *ssn, unsigned int vendor,
-				void *user)
+		void *user)
 {
 	GIsiModem *modem =3D user;
 	struct ssn_data *sd;
@@ -54,7 +416,17 @@ static int isi_ssn_probe(struct ofono_ssn *ssn, unsigne=
d int vendor,
 	if (sd =3D=3D NULL)
 		return -ENOMEM;
 =

-	sd->client =3D g_isi_client_create(modem, PN_SS);
+	if (g_isi_modem_version_major(modem) =3D=3D 2 &&
+			g_isi_modem_version_minor(modem) >=3D 0) {
+
+		sd->client =3D g_isi_client_create(modem, PN_MODEM_CALL);
+
+		if (sd->client)
+			g_isi_client_verify(sd->client, ssn_reachable_cb, ssn,
+						NULL);
+	} else
+		sd->client =3D g_isi_client_create(modem, PN_SS);
+
 	if (sd->client =3D=3D NULL) {
 		g_free(sd);
 		return -ENOMEM;
@@ -79,9 +451,9 @@ static void isi_ssn_remove(struct ofono_ssn *ssn)
 }
 =

 static struct ofono_ssn_driver driver =3D {
-	.name			=3D "isimodem",
-	.probe			=3D isi_ssn_probe,
-	.remove			=3D isi_ssn_remove
+		.name			=3D "isimodem",
+		.probe			=3D isi_ssn_probe,
+		.remove			=3D isi_ssn_remove
 };
 =

 void isi_ssn_init(void)
-- =

1.7.3.5


--===============7225388417191833666==--

