Content-Type: multipart/mixed; boundary="===============8795033120979464582=="
MIME-Version: 1.0
From: Sergey Matyukevich <geomatsi@gmail.com>
Subject: [PATCH 2/2] plugins: gemalto: enable LTE for ELS81x
Date: Sat, 27 Jun 2020 14:08:38 +0300
Message-ID: <20200627110838.808865-3-geomatsi@gmail.com>
In-Reply-To: <20200627110838.808865-1-geomatsi@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8795033120979464582==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Enable LTE atom for Cinterion ELS81x modems.

---
 plugins/gemalto.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/plugins/gemalto.c b/plugins/gemalto.c
index 297aaea3..13950742 100644
--- a/plugins/gemalto.c
+++ b/plugins/gemalto.c
@@ -58,6 +58,8 @@
 #define GEMALTO_MODEL_PHS8P	"0053"
 /* ALS3, PLS8-E, and PLS8-X family */
 #define GEMALTO_MODEL_ALS3_PLS8x	"0061"
+/* ELS81 modem */
+#define GEMALTO_MODEL_ELS81x   "005b"
 =

 static const char *none_prefix[] =3D { NULL };
 static const char *sctm_prefix[] =3D { "^SCTM:", NULL };
@@ -601,7 +603,8 @@ static void gemalto_post_sim(struct ofono_modem *modem)
 =

 	ofono_ussd_create(modem, 0, "atmodem", data->app);
 =

-	if (!g_strcmp0(model, GEMALTO_MODEL_ALS3_PLS8x))
+	if (!g_strcmp0(model, GEMALTO_MODEL_ALS3_PLS8x) ||
+	    !g_strcmp0(model, GEMALTO_MODEL_ELS81x))
 		ofono_lte_create(modem, OFONO_VENDOR_GEMALTO,
 						"atmodem", data->app);
 }
-- =

2.27.0

--===============8795033120979464582==--

