Content-Type: multipart/mixed; boundary="===============3392582837959143533=="
MIME-Version: 1.0
From: caiwen.zhang@intel.com
Subject: [PATCH] plugins/ril: Move GPRS atom creating to 'post_online' state
Date: Thu, 21 Apr 2016 16:15:34 +0800
Message-ID: <1461226534-1788-1-git-send-email-caiwen.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3392582837959143533==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Caiwen Zhang <caiwen.zhang@intel.com>

At gprs atom 'probe' state, max cid query may fail due to rild
status isn't RADIO_STATUS_ON. It causes gprs atom is removed, gprs
feature is inavailable. Move gprs atom creating to 'post_online'
state to make sure rild status is RADIO_STATUS_ON when query max
cid.
---
 plugins/ril.c | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/plugins/ril.c b/plugins/ril.c
index ea50d76..b66664a 100644
--- a/plugins/ril.c
+++ b/plugins/ril.c
@@ -215,8 +215,6 @@ void ril_pre_sim(struct ofono_modem *modem)
 void ril_post_sim(struct ofono_modem *modem)
 {
 	struct ril_data *rd =3D ofono_modem_get_data(modem);
-	struct ofono_gprs *gprs;
-	struct ofono_gprs_context *gc;
 	struct ofono_message_waiting *mw;
 =

 	/* TODO: this function should setup:
@@ -226,23 +224,6 @@ void ril_post_sim(struct ofono_modem *modem)
 	 */
 	ofono_sms_create(modem, rd->vendor, RILMODEM, rd->ril);
 =

-	gprs =3D ofono_gprs_create(modem, rd->vendor, RILMODEM, rd->ril);
-	gc =3D ofono_gprs_context_create(modem, rd->vendor, RILMODEM, rd->ril);
-
-	if (gc) {
-		ofono_gprs_context_set_type(gc,
-					OFONO_GPRS_CONTEXT_TYPE_INTERNET);
-		ofono_gprs_add_context(gprs, gc);
-	}
-
-	gc =3D ofono_gprs_context_create(modem, rd->vendor, RILMODEM, rd->ril);
-
-	if (gc) {
-		ofono_gprs_context_set_type(gc,
-					OFONO_GPRS_CONTEXT_TYPE_MMS);
-		ofono_gprs_add_context(gprs, gc);
-	}
-
 	mw =3D ofono_message_waiting_create(modem);
 	if (mw)
 		ofono_message_waiting_register(mw);
@@ -255,11 +236,28 @@ void ril_post_sim(struct ofono_modem *modem)
 void ril_post_online(struct ofono_modem *modem)
 {
 	struct ril_data *rd =3D ofono_modem_get_data(modem);
+	struct ofono_gprs *gprs;
+	struct ofono_gprs_context *gc;
 =

 	ofono_netreg_create(modem, rd->vendor, RILMODEM, rd->ril);
 	ofono_ussd_create(modem, rd->vendor, RILMODEM, rd->ril);
 	ofono_call_settings_create(modem, rd->vendor, RILMODEM, rd->ril);
 	ofono_call_barring_create(modem, rd->vendor, RILMODEM, rd->ril);
+	gprs =3D ofono_gprs_create(modem, rd->vendor, RILMODEM, rd->ril);
+	gc =3D ofono_gprs_context_create(modem, rd->vendor, RILMODEM, rd->ril);
+
+	if (gc) {
+		ofono_gprs_context_set_type(gc,
+					OFONO_GPRS_CONTEXT_TYPE_INTERNET);
+		ofono_gprs_add_context(gprs, gc);
+	}
+
+	gc =3D ofono_gprs_context_create(modem, rd->vendor, RILMODEM, rd->ril);
+
+	if (gc) {
+		ofono_gprs_context_set_type(gc, OFONO_GPRS_CONTEXT_TYPE_MMS);
+		ofono_gprs_add_context(gprs, gc);
+	}
 }
 =

 static void ril_set_online_cb(struct ril_msg *message, gpointer user_data)
-- =

1.9.1


--===============3392582837959143533==--

