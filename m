Content-Type: multipart/mixed; boundary="===============3114029323389803625=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [RFC online/offline atoms PATCH 4/4] isigen: create sms and gprs in
 post_sim
Date: Tue, 05 Oct 2010 14:35:12 +0300
Message-ID: <1286278512-3529-5-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1286278512-3529-4-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3114029323389803625==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 plugins/isigen.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/plugins/isigen.c b/plugins/isigen.c
index db61fdb..d550a34 100644
--- a/plugins/isigen.c
+++ b/plugins/isigen.c
@@ -395,22 +395,29 @@ static void isigen_pre_sim(struct ofono_modem *modem)
 static void isigen_post_sim(struct ofono_modem *modem)
 {
 	struct isi_data *isi =3D ofono_modem_get_data(modem);
+	struct ofono_gprs *gprs;
+	struct ofono_gprs_context *gc;
 =

 	DBG("(%p) with %s", modem, isi->ifname);
 =

 	ofono_phonebook_create(isi->modem, 0, "isimodem", isi->idx);
+	ofono_sms_create(isi->modem, 0, "isimodem", isi->idx);
+	gprs =3D ofono_gprs_create(isi->modem, 0, "isimodem", isi->idx);
+	gc =3D ofono_gprs_context_create(isi->modem, 0, "isimodem", isi->idx);
+
+	if (gprs && gc)
+		ofono_gprs_add_context(gprs, gc);
+	else
+		DBG("Failed to add context");
 }
 =

 static void isigen_post_online(struct ofono_modem *modem)
 {
 	struct isi_data *isi =3D ofono_modem_get_data(modem);
-	struct ofono_gprs *gprs;
-	struct ofono_gprs_context *gc;
 =

 	DBG("(%p) with %s", modem, isi->ifname);
 =

 	ofono_netreg_create(isi->modem, 0, "isimodem", isi->idx);
-	ofono_sms_create(isi->modem, 0, "isimodem", isi->idx);
 	ofono_cbs_create(isi->modem, 0, "isimodem", isi->idx);
 	ofono_ssn_create(isi->modem, 0, "isimodem", isi->idx);
 	ofono_ussd_create(isi->modem, 0, "isimodem", isi->idx);
@@ -419,13 +426,6 @@ static void isigen_post_online(struct ofono_modem *mod=
em)
 	ofono_call_barring_create(isi->modem, 0, "isimodem", isi->idx);
 	ofono_call_meter_create(isi->modem, 0, "isimodem", isi->idx);
 	ofono_radio_settings_create(isi->modem, 0, "isimodem", isi->idx);
-	gprs =3D ofono_gprs_create(isi->modem, 0, "isimodem", isi->idx);
-	gc =3D ofono_gprs_context_create(isi->modem, 0, "isimodem", isi->idx);
-
-	if (gprs && gc)
-		ofono_gprs_add_context(gprs, gc);
-	else
-		DBG("Failed to add context");
 }
 =

 static struct ofono_modem_driver driver =3D {
-- =

1.7.0.4


--===============3114029323389803625==--

