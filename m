Content-Type: multipart/mixed; boundary="===============3352517701579289813=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 3/3] huawei: Remove call meter support for EM770
Date: Tue, 29 Jun 2010 15:07:10 +0800
Message-ID: <1277795230-18323-4-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1277795230-18323-3-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3352517701579289813==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

EM770W returns "COMMAND NOT SUPPORT" when we send "AT+CCWE=3D1" to
initialize call meter atom. So disable it.
---
 plugins/huawei.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/plugins/huawei.c b/plugins/huawei.c
index 0dc6ae4..98ce65b 100644
--- a/plugins/huawei.c
+++ b/plugins/huawei.c
@@ -46,7 +46,6 @@
 #include <ofono/voicecall.h>
 #include <ofono/call-forwarding.h>
 #include <ofono/call-settings.h>
-#include <ofono/call-meter.h>
 #include <ofono/call-barring.h>
 #include <ofono/ssn.h>
 #include <ofono/phonebook.h>
@@ -332,7 +331,6 @@ static void huawei_post_sim(struct ofono_modem *modem)
 	if (g_str_equal(model, HUAWEI_MODEL_EM770W)) {
 		ofono_call_forwarding_create(modem, 0, "atmodem", data->pcui);
 		ofono_call_settings_create(modem, 0, "atmodem", data->pcui);
-		ofono_call_meter_create(modem, 0, "atmodem", data->pcui);
 		ofono_call_barring_create(modem, 0, "atmodem", data->pcui);
 		ofono_ssn_create(modem, 0, "atmodem", data->pcui);
 		ofono_phonebook_create(modem, 0, "atmodem", data->pcui);
-- =

1.6.3.3


--===============3352517701579289813==--

