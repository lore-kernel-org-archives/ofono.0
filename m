Content-Type: multipart/mixed; boundary="===============6155938118228909008=="
MIME-Version: 1.0
From: ANTARA BORWANKAR <antara.borwankar@intel.com>
Subject: [PATCH 2/2] ril_intel: changes for lte modem
Date: Mon, 12 Dec 2016 11:10:31 +0530
Message-ID: <1481521231-19578-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6155938118228909008==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

plugin modified to bring up lte atom and
set MODEM_PROP_LTE_CAPABLE to TRUE
---
 plugins/ril_intel.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/plugins/ril_intel.c b/plugins/ril_intel.c
index 69e848b..06bcaa9 100644
--- a/plugins/ril_intel.c
+++ b/plugins/ril_intel.c
@@ -130,10 +130,15 @@ static void ril_radio_state_changed(struct ril_msg *m=
essage,
 static int ril_probe(struct ofono_modem *modem)
 {
 	struct ril_data *rd;
+	ofono_bool_t lte_cap;
 =

 	DBG("");
 =

 	rd =3D g_new0(struct ril_data, 1);
+
+	lte_cap =3D getenv("OFONO_RIL_RAT_LTE") ? TRUE : FALSE;
+	ofono_modem_set_boolean(modem, MODEM_PROP_LTE_CAPABLE, lte_cap);
+
 	ofono_modem_set_data(modem, rd);
 =

 	return 0;
@@ -437,7 +442,10 @@ static void ril_post_sim(struct ofono_modem *modem)
 	struct ofono_gprs *gprs;
 	struct ofono_gprs_context *gc;
 =

-	ofono_sms_create(modem, OFONO_RIL_VENDOR_IMC_SOFIA3GR,
+	if (ofono_modem_get_boolean(modem, MODEM_PROP_LTE_CAPABLE))
+		ofono_sms_create(modem, 0, "rilmodem", rd->ril);
+	else
+		ofono_sms_create(modem, OFONO_RIL_VENDOR_IMC_SOFIA3GR,
 					"rilmodem", rd->ril);
 =

 	gprs =3D ofono_gprs_create(modem, 0, "rilmodem", rd->ril);
@@ -448,6 +456,9 @@ static void ril_post_sim(struct ofono_modem *modem)
 					OFONO_GPRS_CONTEXT_TYPE_INTERNET);
 		ofono_gprs_add_context(gprs, gc);
 	}
+
+	if (ofono_modem_get_boolean(modem, MODEM_PROP_LTE_CAPABLE))
+		ofono_lte_create(modem, "rilmodem", rd->ril);
 }
 =

 static void ril_post_online(struct ofono_modem *modem)
@@ -455,8 +466,13 @@ static void ril_post_online(struct ofono_modem *modem)
 	struct ril_data *rd =3D ofono_modem_get_data(modem);
 =

 	ofono_netreg_create(modem, 0, "rilmodem", rd->ril);
-	ofono_radio_settings_create(modem, OFONO_RIL_VENDOR_IMC_SOFIA3GR,
-					"rilmodem", rd->ril);
+
+	if (ofono_modem_get_boolean(modem, MODEM_PROP_LTE_CAPABLE))
+		ofono_radio_settings_create(modem, 0, "rilmodem", rd->ril);
+	else
+		ofono_radio_settings_create(modem, OFONO_RIL_VENDOR_IMC_SOFIA3GR,
+						"rilmodem", rd->ril);
+
 	ofono_ussd_create(modem, 0, "rilmodem", rd->ril);
 	ofono_netmon_create(modem, 0, "rilmodem", rd->ril);
 }
-- =

1.9.1


--===============6155938118228909008==--

