Content-Type: multipart/mixed; boundary="===============8784266237641241541=="
MIME-Version: 1.0
From: Christopher Vogl <christopher.vogl@hale.at>
Subject: [PATCH] telit: move gprs atom into post sim phase
Date: Thu, 16 Aug 2012 10:40:08 +0200
Message-ID: <1345106408-20215-1-git-send-email-christopher.vogl@hale.at>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8784266237641241541==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/telit.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/plugins/telit.c b/plugins/telit.c
index 6ae7249..519f2ac 100644
--- a/plugins/telit.c
+++ b/plugins/telit.c
@@ -559,6 +559,8 @@ static void telit_pre_sim(struct ofono_modem *modem)
 static void telit_post_sim(struct ofono_modem *modem)
 {
 	struct telit_data *data =3D ofono_modem_get_data(modem);
+	struct ofono_gprs *gprs;
+	struct ofono_gprs_context *gc;
 =

 	if (data->sap_modem)
 		modem =3D data->sap_modem;
@@ -566,6 +568,12 @@ static void telit_post_sim(struct ofono_modem *modem)
 	DBG("%p", modem);
 =

 	ofono_sms_create(modem, 0, "atmodem", data->chat);
+
+	gprs =3D ofono_gprs_create(modem, OFONO_VENDOR_TELIT, "atmodem", data->ch=
at);
+	gc =3D ofono_gprs_context_create(modem, 0, "atmodem", data->chat);
+
+	if (gprs && gc)
+		ofono_gprs_add_context(gprs, gc);
 }
 =

 static void set_online_cb(gboolean ok, GAtResult *result, gpointer user_da=
ta)
@@ -595,8 +603,6 @@ static void telit_post_online(struct ofono_modem *modem)
 {
 	struct telit_data *data =3D ofono_modem_get_data(modem);
 	struct ofono_message_waiting *mw;
-	struct ofono_gprs *gprs;
-	struct ofono_gprs_context *gc;
 =

 	if(data->sap_modem)
 		modem =3D data->sap_modem;
@@ -610,12 +616,6 @@ static void telit_post_online(struct ofono_modem *mode=
m)
 	ofono_call_meter_create(modem, 0, "atmodem", data->chat);
 	ofono_call_barring_create(modem, 0, "atmodem", data->chat);
 =

-	gprs =3D ofono_gprs_create(modem, 0, "atmodem", data->chat);
-	gc =3D ofono_gprs_context_create(modem, 0, "atmodem", data->chat);
-
-	if (gprs && gc)
-		ofono_gprs_add_context(gprs, gc);
-
 	mw =3D ofono_message_waiting_create(modem);
 	if (mw)
 		ofono_message_waiting_register(mw);
-- =

1.7.7.6


--
Scanned by MailScanner.


--===============8784266237641241541==--

