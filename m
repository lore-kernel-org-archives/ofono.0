Content-Type: multipart/mixed; boundary="===============0719744344091128584=="
MIME-Version: 1.0
From: Forest Bond <forest@alittletooquiet.net>
Subject: [PATCH 5/8] sierra: Create GPRS context in post_sim function
Date: Fri, 28 Dec 2012 14:35:46 -0500
Message-ID: <20121228193546.GK18339@alittletooquiet.net>
In-Reply-To: <20121228193141.GF18339@alittletooquiet.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0719744344091128584==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Forest Bond <forest.bond@rapidrollout.com>

This matches the huawei plugin.
---
 plugins/sierra.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/plugins/sierra.c b/plugins/sierra.c
index 3143f09..4e125d7 100644
--- a/plugins/sierra.c
+++ b/plugins/sierra.c
@@ -228,27 +228,27 @@ static void sierra_pre_sim(struct ofono_modem *modem)
 static void sierra_post_sim(struct ofono_modem *modem)
 {
 	struct sierra_data *data =3D ofono_modem_get_data(modem);
+	struct ofono_gprs *gprs;
+	struct ofono_gprs_context *gc;
 =

 	DBG("%p", modem);
 =

 	ofono_phonebook_create(modem, 0, "atmodem", data->modem);
+
+	gprs =3D ofono_gprs_create(modem, 0, "atmodem", data->modem);
+	gc =3D ofono_gprs_context_create(modem, 0, "swmodem", data->modem);
+
+	if (gprs && gc)
+		ofono_gprs_add_context(gprs, gc);
 }
 =

 static void sierra_post_online(struct ofono_modem *modem)
 {
 	struct sierra_data *data =3D ofono_modem_get_data(modem);
-	struct ofono_gprs *gprs;
-	struct ofono_gprs_context *gc;
 =

 	DBG("%p", modem);
 =

 	ofono_netreg_create(modem, 0, "atmodem", data->modem);
-
-	gprs =3D ofono_gprs_create(modem, 0, "atmodem", data->modem);
-	gc =3D ofono_gprs_context_create(modem, 0, "swmodem", data->modem);
-
-	if (gprs && gc)
-		ofono_gprs_add_context(gprs, gc);
 }
 =

 static struct ofono_modem_driver sierra_driver =3D {
-- =

1.7.0.4

--===============0719744344091128584==--

