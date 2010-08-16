Content-Type: multipart/mixed; boundary="===============6092011319190878755=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: [PATCH v4 5/7] plugins/ste: Add Radio-Settings
Date: Mon, 16 Aug 2010 23:12:10 +0200
Message-ID: <1281993134-3926-5-git-send-email-sjurbren@gmail.com>
In-Reply-To: <1281993134-3926-4-git-send-email-sjurbren@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6092011319190878755==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Sjur Br=C3=A6ndeland <sjur.brandeland@stericsson.com>

---
 plugins/ste.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/plugins/ste.c b/plugins/ste.c
index f1535e3..eeaa324 100644
--- a/plugins/ste.c
+++ b/plugins/ste.c
@@ -54,6 +54,7 @@
 #include <ofono/voicecall.h>
 #include <ofono/gprs.h>
 #include <ofono/gprs-context.h>
+#include <ofono/radio-settings.h>
 #include <ofono/stk.h>
 #include <drivers/atmodem/vendor.h>
 =

@@ -279,6 +280,7 @@ static void ste_post_sim(struct ofono_modem *modem)
 	DBG("%p", modem);
 =

 	ofono_stk_create(modem, 0, "mbmmodem", data->chat);
+	ofono_radio_settings_create(modem, 0, "stemodem", data->chat);
 	ofono_ussd_create(modem, 0, "atmodem", data->chat);
 	ofono_call_forwarding_create(modem, 0, "atmodem", data->chat);
 	ofono_call_settings_create(modem, 0, "atmodem", data->chat);
-- =

1.6.3.3


--===============6092011319190878755==--

