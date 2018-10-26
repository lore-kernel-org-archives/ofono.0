Content-Type: multipart/mixed; boundary="===============5976539984211183639=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH 1/5] plugins/gemalto: vendor Gemalto on LTE atom
Date: Fri, 26 Oct 2018 07:11:02 +0200
Message-ID: <20181026051106.16828-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5976539984211183639==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/gemalto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/plugins/gemalto.c b/plugins/gemalto.c
index 5d3c77a9..43d66eb5 100644
--- a/plugins/gemalto.c
+++ b/plugins/gemalto.c
@@ -610,7 +610,7 @@ static void gemalto_post_sim(struct ofono_modem *modem)
 	ofono_call_barring_create(modem, 0, "atmodem", data->app);
 =

 	if (!g_strcmp0(model, GEMALTO_MODEL_ALS3_PLS8x))
-		ofono_lte_create(modem, OFONO_VENDOR_CINTERION,
+		ofono_lte_create(modem, OFONO_VENDOR_GEMALTO,
 						"atmodem", data->app);
 }
 =

-- =

2.17.1


--===============5976539984211183639==--

