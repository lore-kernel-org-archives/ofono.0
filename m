Content-Type: multipart/mixed; boundary="===============3073008674378177233=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH 3/5] speedup: Create GSM/UMTS atoms only if support has been
 detected
Date: Mon, 09 Jan 2012 14:10:58 +0100
Message-ID: <1326114660-10111-4-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1326114660-10111-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3073008674378177233==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/speedup.c |   50 +++++++++++++++++++++++++++++---------------------
 1 files changed, 29 insertions(+), 21 deletions(-)

diff --git a/plugins/speedup.c b/plugins/speedup.c
index f03f8f3..02b6f61 100644
--- a/plugins/speedup.c
+++ b/plugins/speedup.c
@@ -265,49 +265,57 @@ static int speedup_disable(struct ofono_modem *modem)
 static void speedup_pre_sim(struct ofono_modem *modem)
 {
 	struct speedup_data *data =3D ofono_modem_get_data(modem);
-	struct ofono_sim *sim;
 =

 	DBG("%p", modem);
 =

-	ofono_devinfo_create(modem, 0, "atmodem", data->aux);
-	sim =3D ofono_sim_create(modem, OFONO_VENDOR_SPEEDUP,
-						"atmodem", data->aux);
+	if (data->have_gsm =3D=3D TRUE) {
+		struct ofono_sim *sim;
+		ofono_devinfo_create(modem, 0, "atmodem", data->aux);
+		sim =3D ofono_sim_create(modem, OFONO_VENDOR_SPEEDUP,
+							"atmodem", data->aux);
 =

-	if (sim && data->have_sim =3D=3D TRUE)
-		ofono_sim_inserted_notify(sim, TRUE);
+		if (sim && data->have_sim =3D=3D TRUE)
+			ofono_sim_inserted_notify(sim, TRUE);
+	}
 }
 =

 static void speedup_post_sim(struct ofono_modem *modem)
 {
 	struct speedup_data *data =3D ofono_modem_get_data(modem);
-	struct ofono_gprs *gprs;
-	struct ofono_gprs_context *gc;
 =

 	DBG("%p", modem);
 =

-	ofono_phonebook_create(modem, 0, "atmodem", data->aux);
+	if (data->have_gsm =3D=3D TRUE) {
+		struct ofono_gprs *gprs;
+		struct ofono_gprs_context *gc;
+		ofono_phonebook_create(modem, 0, "atmodem", data->aux);
 =

-	ofono_sms_create(modem, OFONO_VENDOR_QUALCOMM_MSM,
-						"atmodem", data->aux);
+		ofono_sms_create(modem, OFONO_VENDOR_QUALCOMM_MSM,
+							"atmodem", data->aux);
 =

-	gprs =3D ofono_gprs_create(modem, OFONO_VENDOR_SPEEDUP,
-						"atmodem", data->aux);
-	gc =3D ofono_gprs_context_create(modem, 0, "atmodem", data->modem);
+		gprs =3D ofono_gprs_create(modem, OFONO_VENDOR_SPEEDUP,
+							"atmodem", data->aux);
+		gc =3D ofono_gprs_context_create(modem, 0, "atmodem",
+							data->modem);
 =

-	if (gprs && gc)
-		ofono_gprs_add_context(gprs, gc);
+		if (gprs && gc)
+			ofono_gprs_add_context(gprs, gc);
+	}
 }
 =

 static void speedup_post_online(struct ofono_modem *modem)
 {
 	struct speedup_data *data =3D ofono_modem_get_data(modem);
 =

-	ofono_netreg_create(modem, OFONO_VENDOR_SPEEDUP, "atmodem", data->aux);
+	if (data->have_gsm =3D=3D TRUE) {
+		ofono_netreg_create(modem, OFONO_VENDOR_SPEEDUP, "atmodem",
+							data->aux);
 =

-	ofono_cbs_create(modem, OFONO_VENDOR_QUALCOMM_MSM,
-						"atmodem", data->aux);
-	ofono_ussd_create(modem, OFONO_VENDOR_QUALCOMM_MSM,
-						"atmodem", data->aux);
+		ofono_cbs_create(modem, OFONO_VENDOR_QUALCOMM_MSM,
+							"atmodem", data->aux);
+		ofono_ussd_create(modem, OFONO_VENDOR_QUALCOMM_MSM,
+							"atmodem", data->aux);
+	}
 }
 =

 static struct ofono_modem_driver speedup_driver =3D {
-- =

1.7.1


--===============3073008674378177233==--

