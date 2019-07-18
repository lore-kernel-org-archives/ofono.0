Content-Type: multipart/mixed; boundary="===============7138092150272740174=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH 08/10] ublox: add voicecall support
Date: Thu, 18 Jul 2019 12:23:12 +0200
Message-ID: <20190718102314.28094-8-jonas@norrbonn.se>
In-Reply-To: <20190718102314.28094-1-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7138092150272740174==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ublox.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/plugins/ublox.c b/plugins/ublox.c
index 1da7101e..6e867666 100644
--- a/plugins/ublox.c
+++ b/plugins/ublox.c
@@ -41,6 +41,12 @@
 #include <ofono/netmon.h>
 #include <ofono/lte.h>
 #include <ofono/voicecall.h>
+#include <ofono/call-forwarding.h>
+#include <ofono/call-settings.h>
+#include <ofono/call-meter.h>
+#include <ofono/call-barring.h>
+#include <ofono/message-waiting.h>
+#include <ofono/ussd.h>
 =

 #include <drivers/atmodem/vendor.h>
 #include <drivers/ubloxmodem/ubloxmodem.h>
@@ -356,6 +362,7 @@ static void ublox_post_sim(struct ofono_modem *modem)
 	struct ofono_gprs *gprs;
 	struct ofono_gprs_context *gc;
 	GAtChat *chat =3D data->modem ? data->modem : data->aux;
+	struct ofono_message_waiting *mw;
 	const char *driver;
 	const char *iface;
 	int variant;
@@ -380,6 +387,16 @@ static void ublox_post_sim(struct ofono_modem *modem)
 =

 	ofono_lte_create(modem,
 		ublox_model_to_id(data->model), "ubloxmodem", data->aux);
+
+	ofono_ussd_create(modem, 0, "atmodem", data->aux);
+	ofono_call_forwarding_create(modem, 0, "atmodem", data->aux);
+	ofono_call_settings_create(modem, 0, "atmodem", data->aux);
+	ofono_call_meter_create(modem, 0, "atmodem", data->aux);
+	ofono_call_barring_create(modem, 0, "atmodem", data->aux);
+
+	mw =3D ofono_message_waiting_create(modem);
+	if (mw)
+		ofono_message_waiting_register(mw);
 }
 =

 static void ublox_post_online(struct ofono_modem *modem)
-- =

2.20.1


--===============7138092150272740174==--

