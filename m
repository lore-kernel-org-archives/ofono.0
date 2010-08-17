Content-Type: multipart/mixed; boundary="===============3110917874164226123=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjur.brandeland@stericsson.com>
Subject: [PATCH v5 5/8] plugins/ste: Add Radio-Settings
Date: Tue, 17 Aug 2010 14:22:31 +0200
Message-ID: <1282047754-15562-6-git-send-email-sjur.brandeland@stericsson.com>
In-Reply-To: <1282047754-15562-1-git-send-email-sjur.brandeland@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3110917874164226123==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/stemodem/radio-settings.c |    5 +++++
 plugins/ste.c                     |    2 ++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/plugins/ste.c b/plugins/ste.c
index bcf2704..16ddbe1 100644
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


--===============3110917874164226123==--

