Content-Type: multipart/mixed; boundary="===============2982761460738694266=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH 09/10] ublox: add SMS support
Date: Thu, 18 Jul 2019 12:23:13 +0200
Message-ID: <20190718102314.28094-9-jonas@norrbonn.se>
In-Reply-To: <20190718102314.28094-1-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2982761460738694266==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ublox.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/plugins/ublox.c b/plugins/ublox.c
index 6e867666..b65bc52a 100644
--- a/plugins/ublox.c
+++ b/plugins/ublox.c
@@ -40,6 +40,7 @@
 #include <ofono/gprs-context.h>
 #include <ofono/netmon.h>
 #include <ofono/lte.h>
+#include <ofono/sms.h>
 #include <ofono/voicecall.h>
 #include <ofono/call-forwarding.h>
 #include <ofono/call-settings.h>
@@ -388,6 +389,8 @@ static void ublox_post_sim(struct ofono_modem *modem)
 	ofono_lte_create(modem,
 		ublox_model_to_id(data->model), "ubloxmodem", data->aux);
 =

+	ofono_sms_create(modem, 0, "atmodem", data->aux);
+
 	ofono_ussd_create(modem, 0, "atmodem", data->aux);
 	ofono_call_forwarding_create(modem, 0, "atmodem", data->aux);
 	ofono_call_settings_create(modem, 0, "atmodem", data->aux);
-- =

2.20.1


--===============2982761460738694266==--

