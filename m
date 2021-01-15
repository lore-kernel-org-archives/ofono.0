Content-Type: multipart/mixed; boundary="===============4213899416883798663=="
MIME-Version: 1.0
From: Sergey Matyukevich <geomatsi@gmail.com>
Subject: [PATCH v2 2/3] plugin: gemalto: enable netmon
Date: Fri, 15 Jan 2021 19:25:46 +0300
Message-ID: <20210115162547.17156-3-geomatsi@gmail.com>
In-Reply-To: <20210115162547.17156-1-geomatsi@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4213899416883798663==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Enable netmon functionality for Gemalto ELS81x modems.
---
 plugins/gemalto.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/plugins/gemalto.c b/plugins/gemalto.c
index 28ee3aff..135e2d26 100644
--- a/plugins/gemalto.c
+++ b/plugins/gemalto.c
@@ -48,6 +48,7 @@
 #include <ofono/gprs.h>
 #include <ofono/gprs-context.h>
 #include <ofono/location-reporting.h>
+#include <ofono/netmon.h>
 =

 #include <drivers/atmodem/atutil.h>
 #include <drivers/atmodem/vendor.h>
@@ -622,6 +623,7 @@ static void gemalto_post_sim(struct ofono_modem *modem)
 static void gemalto_post_online(struct ofono_modem *modem)
 {
 	struct gemalto_data *data =3D ofono_modem_get_data(modem);
+	const char *model =3D ofono_modem_get_string(modem, "Model");
 =

 	DBG("%p", modem);
 =

@@ -634,6 +636,10 @@ static void gemalto_post_online(struct ofono_modem *mo=
dem)
 	ofono_call_settings_create(modem, 0, "atmodem", data->app);
 	ofono_call_meter_create(modem, 0, "atmodem", data->app);
 	ofono_call_barring_create(modem, 0, "atmodem", data->app);
+
+	if (!g_strcmp0(model, GEMALTO_MODEL_ELS81x))
+		ofono_netmon_create(modem, OFONO_VENDOR_GEMALTO,
+					"gemaltomodem", data->app);
 }
 =

 static struct ofono_modem_driver gemalto_driver =3D {
--===============4213899416883798663==--

