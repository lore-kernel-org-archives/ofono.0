Content-Type: multipart/mixed; boundary="===============1942581441190111463=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH] mbm: add radio-settings support
Date: Mon, 31 Jan 2011 00:30:51 -0800
Message-ID: <1296462651-14991-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1942581441190111463==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/mbm.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/plugins/mbm.c b/plugins/mbm.c
index 600b358..2ab80b4 100644
--- a/plugins/mbm.c
+++ b/plugins/mbm.c
@@ -44,6 +44,7 @@
 #include <ofono/ussd.h>
 #include <ofono/gprs.h>
 #include <ofono/gprs-context.h>
+#include <ofono/radio-settings.h>
 #include <ofono/log.h>
 =

 #include <drivers/atmodem/atutil.h>
@@ -500,6 +501,7 @@ static void mbm_post_sim(struct ofono_modem *modem)
 	DBG("%p", modem);
 =

 	ofono_stk_create(modem, 0, "mbmmodem", data->modem_port);
+	ofono_radio_settings_create(modem, 0, "stemodem", data->modem_port);
 =

 	ofono_sms_create(modem, 0, "atmodem", data->modem_port);
 }
-- =

1.7.0.4


--===============1942581441190111463==--

