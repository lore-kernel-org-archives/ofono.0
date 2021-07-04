Content-Type: multipart/mixed; boundary="===============4428254224113373386=="
MIME-Version: 1.0
From: Sergey Matyukevich <geomatsi@gmail.com>
Subject: [PATCH 3/3] plugins: gemalto: move ussd atom to post_online
Date: Sun, 04 Jul 2021 18:53:48 +0300
Message-ID: <20210704155348.432964-4-geomatsi@gmail.com>
In-Reply-To: <20210704155348.432964-1-geomatsi@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4428254224113373386==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Gemalto modem does not allow to enable Supplementary Service
during post_sim stage. So move ussd atom to post_online stage.

---
 plugins/gemalto.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/plugins/gemalto.c b/plugins/gemalto.c
index a2e8a39c..d1962ab8 100644
--- a/plugins/gemalto.c
+++ b/plugins/gemalto.c
@@ -614,8 +614,6 @@ static void gemalto_post_sim(struct ofono_modem *modem)
 	if (gprs && gc)
 		ofono_gprs_add_context(gprs, gc);
 =

-	ofono_ussd_create(modem, 0, "atmodem", data->app);
-
 	if (!g_strcmp0(model, GEMALTO_MODEL_ALS3_PLS8x) ||
 	    !g_strcmp0(model, GEMALTO_MODEL_ELS81x))
 		ofono_lte_create(modem, OFONO_VENDOR_GEMALTO,
@@ -639,6 +637,8 @@ static void gemalto_post_online(struct ofono_modem *mod=
em)
 	ofono_call_meter_create(modem, 0, "atmodem", data->app);
 	ofono_call_barring_create(modem, 0, "atmodem", data->app);
 =

+	ofono_ussd_create(modem, 0, "atmodem", data->app);
+
 	if (!g_strcmp0(model, GEMALTO_MODEL_ELS81x))
 		ofono_netmon_create(modem, OFONO_VENDOR_GEMALTO,
 					"gemaltomodem", data->app);
--===============4428254224113373386==--

