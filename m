Content-Type: multipart/mixed; boundary="===============4871901683198908555=="
MIME-Version: 1.0
From: Tonny Tzeng <tonny.tzeng@gmail.com>
Subject: [PATCH] Specify vendor ID for Huawei modem while creating GPRS context
Date: Fri, 03 Dec 2010 23:22:52 +0800
Message-ID: <1291389772.2043.27.camel@Twins.TonnyLab.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4871901683198908555==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/huawei.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/plugins/huawei.c b/plugins/huawei.c
index 25dfaca..32cf70d 100644
--- a/plugins/huawei.c
+++ b/plugins/huawei.c
@@ -454,7 +454,7 @@ static void huawei_disconnect(gpointer user_data)
 			data->sim_state =3D=3D HUAWEI_SIM_STATE_INVALID_CS) {
 		ofono_info("Reopened GPRS context channel");
 =

-		data->gc =3D ofono_gprs_context_create(modem, 0, "atmodem",
+		data->gc =3D ofono_gprs_context_create(modem, OFONO_VENDOR_HUAWEI,
"atmodem",
 								data->modem);
 =

 		if (data->gprs && data->gc)
@@ -631,12 +631,12 @@ static void huawei_post_online(struct ofono_modem
*modem)
 =

 	if (data->sim_state =3D=3D HUAWEI_SIM_STATE_VALID ||
 			data->sim_state =3D=3D HUAWEI_SIM_STATE_INVALID_CS) {
-		data->gprs =3D ofono_gprs_create(modem, 0, "atmodem", data->pcui);
+		data->gprs =3D ofono_gprs_create(modem, OFONO_VENDOR_HUAWEI, "atmodem",
data->pcui);
 		if (data->ndis =3D=3D TRUE)
-			data->gc =3D ofono_gprs_context_create(modem, 0,
+			data->gc =3D ofono_gprs_context_create(modem, OFONO_VENDOR_HUAWEI,
 						"huaweimodem", data->pcui);
 		else
-			data->gc =3D ofono_gprs_context_create(modem, 0,
+			data->gc =3D ofono_gprs_context_create(modem, OFONO_VENDOR_HUAWEI,
 						"atmodem", data->modem);
 =

 		if (data->gprs && data->gc)
-- =

1.7.2.2



--===============4871901683198908555==--

