Content-Type: multipart/mixed; boundary="===============5479231336210076298=="
MIME-Version: 1.0
From: Bassem Boubaker <bassem.boubaker@actia.fr>
Subject: [PATCH] Gemalto.c : Make supported modem family name more significant
Date: Mon, 19 Mar 2018 17:57:31 +0100
Message-ID: <1521478651-24386-1-git-send-email-bassem.boubaker@actia.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5479231336210076298==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

	Some gemalto modem family share almost the same base except some very spec=
ific
	AT command and some hardware changes like ALSx and PXSx family
---
 plugins/gemalto.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/plugins/gemalto.c b/plugins/gemalto.c
index 5573606..26be621 100644
--- a/plugins/gemalto.c
+++ b/plugins/gemalto.c
@@ -55,7 +55,8 @@
 =

 /* Supported gemalto's modem */
 #define GEMALTO_MODEL_PHS8P 	"0053"
-#define GEMALTO_MODEL_ALS3 	"0061"
+/* ALS3, PLS8-E, and PLS8-X family */
+#define GEMALTO_MODEL_ALS3_PLS8x 	"0061"
 =

 static const char *none_prefix[] =3D { NULL };
 static const char *sctm_prefix[] =3D { "^SCTM:", NULL };
@@ -524,7 +525,7 @@ static void gemalto_post_sim(struct ofono_modem *modem)
 	if (gprs && gc)
 		ofono_gprs_add_context(gprs, gc);
 =

-	if (!g_strcmp0(model, GEMALTO_MODEL_ALS3))
+	if (!g_strcmp0(model, GEMALTO_MODEL_ALS3_PLS8x))
 		ofono_lte_create(modem, OFONO_VENDOR_CINTERION,
 						"atmodem", data->app);
 }
-- =

2.7.4


--===============5479231336210076298==--

