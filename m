Content-Type: multipart/mixed; boundary="===============8466970041475944553=="
MIME-Version: 1.0
From: Samrat Guha Niyogi <samrat.guha.niyogi@intel.com>
Subject: [PATCH] sofia3gr: Enable vendor type in SMS driver
Date: Tue, 22 Mar 2016 16:18:52 +0530
Message-ID: <1458643732-18296-1-git-send-email-samrat.guha.niyogi@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8466970041475944553==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Anirudh Gargi <anirudh.gargi@intel.com>

---
 plugins/ril_sofia3gr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/plugins/ril_sofia3gr.c b/plugins/ril_sofia3gr.c
index 0d4a204..ac60f7f 100644
--- a/plugins/ril_sofia3gr.c
+++ b/plugins/ril_sofia3gr.c
@@ -152,7 +152,7 @@ static void ril_post_sim(struct ofono_modem *modem)
 	struct ofono_gprs *gprs;
 	struct ofono_gprs_context *gc;
 =

-	ofono_sms_create(modem, 0, "rilmodem", rd->ril);
+	ofono_sms_create(modem, OFONO_RIL_VENDOR_IMC_SOFIA3GR, "rilmodem", rd->ri=
l);
 =

 	gprs =3D ofono_gprs_create(modem, 0, "rilmodem", rd->ril);
 	gc =3D ofono_gprs_context_create(modem, 0, "rilmodem", rd->ril);
-- =

1.9.1


--===============8466970041475944553==--

