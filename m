Content-Type: multipart/mixed; boundary="===============9128707659486764581=="
MIME-Version: 1.0
From: Caiwen Zhang <caiwen.zhang@windriver.com>
Subject: [PATCH] skip modem port checking when create NDIS gprs context
Date: Fri, 03 Jun 2011 17:14:07 +0800
Message-ID: <1307092447-23510-1-git-send-email-caiwen.zhang@windriver.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9128707659486764581==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When create NDIS gprs context, It doesn't depend on modem port,
don't need to check modem port.

---
 plugins/huawei.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/plugins/huawei.c b/plugins/huawei.c
index 639ae0d..6a71305 100644
--- a/plugins/huawei.c
+++ b/plugins/huawei.c
@@ -716,16 +716,15 @@ static void huawei_post_online(struct ofono_modem *mo=
dem)
 	ofono_ussd_create(modem, OFONO_VENDOR_QUALCOMM_MSM,
 						"atmodem", data->pcui);
 =

-	if ((data->sim_state =3D=3D HUAWEI_SIM_STATE_VALID ||
-			data->sim_state =3D=3D HUAWEI_SIM_STATE_INVALID_CS) &&
-			data->modem !=3D NULL) {
+	if (data->sim_state =3D=3D HUAWEI_SIM_STATE_VALID ||
+			data->sim_state =3D=3D HUAWEI_SIM_STATE_INVALID_CS) {
 		data->gprs =3D ofono_gprs_create(modem, OFONO_VENDOR_HUAWEI,
 						"atmodem", data->pcui);
 =

 		if (data->ndis =3D=3D TRUE)
 			data->gc =3D ofono_gprs_context_create(modem, 0,
 						"huaweimodem", data->pcui);
-		else
+		else if (data->modem !=3D NULL)
 			data->gc =3D ofono_gprs_context_create(modem, 0,
 						"atmodem", data->modem);
 =

-- =

1.7.5


--===============9128707659486764581==--

