Content-Type: multipart/mixed; boundary="===============3239751121777357205=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH 3/4] gobi: add LTE atom
Date: Thu, 01 Mar 2018 11:48:03 +0100
Message-ID: <20180301104804.24058-4-jonas@southpole.se>
In-Reply-To: <20180301104804.24058-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3239751121777357205==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This atom needs to be created in post_sim so that the APN can be
written to the default profile before the modem attempts to use the
setting to connect to the network.
---
 plugins/gobi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/plugins/gobi.c b/plugins/gobi.c
index 17900010..e7cf1598 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -43,6 +43,7 @@
 #include <ofono/ussd.h>
 #include <ofono/gprs.h>
 #include <ofono/gprs-context.h>
+#include <ofono/lte.h>
 #include <ofono/radio-settings.h>
 #include <ofono/location-reporting.h>
 #include <ofono/log.h>
@@ -483,6 +484,8 @@ static void gobi_post_sim(struct ofono_modem *modem)
 =

 	DBG("%p", modem);
 =

+	ofono_lte_create(modem, "qmimodem", data->device);
+
 	if (data->features & GOBI_CAT)
 		ofono_stk_create(modem, 0, "qmimodem", data->device);
 	else if (data->features & GOBI_CAT_OLD)
-- =

2.14.1


--===============3239751121777357205==--

