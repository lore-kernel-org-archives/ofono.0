Content-Type: multipart/mixed; boundary="===============3875348396724386888=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH qmi lte v4 6/6] gobi: add LTE atom
Date: Tue, 18 Apr 2017 09:50:52 +0200
Message-ID: <20170418075052.23980-6-jonas@southpole.se>
In-Reply-To: <20170418075052.23980-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3875348396724386888==
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
index df35f94..a339740 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -42,6 +42,7 @@
 #include <ofono/ussd.h>
 #include <ofono/gprs.h>
 #include <ofono/gprs-context.h>
+#include <ofono/lte.h>
 #include <ofono/radio-settings.h>
 #include <ofono/location-reporting.h>
 #include <ofono/log.h>
@@ -469,6 +470,8 @@ static void gobi_post_sim(struct ofono_modem *modem)
 =

 	DBG("%p", modem);
 =

+	ofono_lte_create(modem, "qmimodem", data->device);
+
 	if (data->features & GOBI_CAT)
 		ofono_stk_create(modem, 0, "qmimodem", data->device);
 	else if (data->features & GOBI_CAT_OLD)
-- =

2.9.3


--===============3875348396724386888==--

