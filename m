Content-Type: multipart/mixed; boundary="===============2230253016819706834=="
MIME-Version: 1.0
From: Vijay Nayani <vijay.nayani@elektrobit.com>
Subject: [RFC PATCH 19/20] phonesim: atoms creation based on UE mode
Date: Mon, 11 Apr 2011 13:20:17 +0300
Message-ID: <1302517218-2147-20-git-send-email-vijay.nayani@elektrobit.com>
In-Reply-To: <1302517218-2147-1-git-send-email-vijay.nayani@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2230253016819706834==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/phonesim.c |   42 +++++++++++++++++++++++++++++++-----------
 1 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/plugins/phonesim.c b/plugins/phonesim.c
index 0727baf..8e3e928 100644
--- a/plugins/phonesim.c
+++ b/plugins/phonesim.c
@@ -64,6 +64,8 @@
 #include <drivers/atmodem/sim-poll.h>
 #include <drivers/atmodem/atutil.h>
 =

+#include  "common.h"
+
 static const char *none_prefix[] =3D { NULL };
 static const char *ptty_prefix[] =3D { "+PTTY:", NULL };
 static const char *cemode_prefix[] =3D { "+CEMODE:", NULL };
@@ -667,11 +669,16 @@ static void phonesim_pre_sim(struct ofono_modem *mode=
m)
 	ofono_devinfo_create(modem, 0, "atmodem", data->chat);
 	sim =3D ofono_sim_create(modem, 0, "atmodem", data->chat);
 =

+	if (data->pref_ue_mode =3D=3D PREFERRED_UE_MODE_PS_VOICE_CENTRIC ||
+			data->pref_ue_mode =3D=3D PREFERRED_UE_MODE_PS_DATA_CENTRIC)
+		goto out;
+
 	if (data->calypso)
 		ofono_voicecall_create(modem, 0, "calypsomodem", data->chat);
 	else
 		ofono_voicecall_create(modem, 0, "atmodem", data->chat);
 =

+out:
 	if (sim)
 		ofono_sim_inserted_notify(sim, TRUE);
 }
@@ -682,13 +689,18 @@ static void phonesim_post_sim(struct ofono_modem *mod=
em)
 =

 	DBG("%p", modem);
 =

-	ofono_ctm_create(modem, 0, "phonesim", data->chat);
 	ofono_phonebook_create(modem, 0, "atmodem", data->chat);
 =

 	if (!data->calypso)
 		ofono_stk_create(modem, OFONO_VENDOR_PHONESIM,
 					"atmodem", data->chat);
 =

+	/* Other atom creations need to be addressed in the future */
+	if (data->pref_ue_mode =3D=3D PREFERRED_UE_MODE_PS_VOICE_CENTRIC ||
+			data->pref_ue_mode =3D=3D PREFERRED_UE_MODE_PS_DATA_CENTRIC)
+		return;
+
+	ofono_ctm_create(modem, 0, "phonesim", data->chat);
 	ofono_call_forwarding_create(modem, 0, "atmodem", data->chat);
 =

 	if (!data->calypso)
@@ -704,9 +716,6 @@ static void phonesim_post_online(struct ofono_modem *mo=
dem)
 =

 	DBG("%p", modem);
 =

-	ofono_ussd_create(modem, 0, "atmodem", data->chat);
-	ofono_call_settings_create(modem, 0, "atmodem", data->chat);
-
 	if (data->calypso)
 		ofono_netreg_create(modem, OFONO_VENDOR_CALYPSO,
 							"atmodem", data->chat);
@@ -714,13 +723,6 @@ static void phonesim_post_online(struct ofono_modem *m=
odem)
 		ofono_netreg_create(modem, OFONO_VENDOR_PHONESIM,
 							"atmodem", data->chat);
 =

-	ofono_call_meter_create(modem, 0, "atmodem", data->chat);
-	ofono_call_barring_create(modem, 0, "atmodem", data->chat);
-	ofono_call_volume_create(modem, 0, "atmodem", data->chat);
-
-	if (!data->calypso)
-		ofono_cbs_create(modem, 0, "atmodem", data->chat);
-
 	ps =3D ofono_packet_service_create(modem, 0, "atmodem", data->chat);
 =

 	pc1 =3D ofono_packet_context_create(modem, 0, "phonesim", data->chat);
@@ -731,6 +733,24 @@ static void phonesim_post_online(struct ofono_modem *m=
odem)
 	if (ps && pc2)
 		ofono_packet_service_add_context(ps, pc2);
 =

+	/*
+	 * Incase of +CEMODE: 0 or +CEMODE: 3, only LTE atoms are created which
+	 * include sim, phonebook, stk, netreg, packet-service and packet-context.
+	 */
+	if (data->pref_ue_mode =3D=3D PREFERRED_UE_MODE_PS_VOICE_CENTRIC ||
+			data->pref_ue_mode =3D=3D PREFERRED_UE_MODE_PS_DATA_CENTRIC)
+		return;
+
+	ofono_ussd_create(modem, 0, "atmodem", data->chat);
+	ofono_call_settings_create(modem, 0, "atmodem", data->chat);
+
+	ofono_call_meter_create(modem, 0, "atmodem", data->chat);
+	ofono_call_barring_create(modem, 0, "atmodem", data->chat);
+	ofono_call_volume_create(modem, 0, "atmodem", data->chat);
+
+	if (!data->calypso)
+		ofono_cbs_create(modem, 0, "atmodem", data->chat);
+
 	mw =3D ofono_message_waiting_create(modem);
 	if (mw)
 		ofono_message_waiting_register(mw);
-- =

1.7.0.4


--===============2230253016819706834==--

