Content-Type: multipart/mixed; boundary="===============2527899934568912627=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH 4/7] gobi: create NetworkMonitor atom
Date: Fri, 08 Sep 2017 04:40:37 +0200
Message-ID: <20170908024040.31418-4-jonas@southpole.se>
In-Reply-To: <20170908024040.31418-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2527899934568912627==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/gobi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/plugins/gobi.c b/plugins/gobi.c
index a498599..bc2b068 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -34,6 +34,7 @@
 #include <ofono/modem.h>
 #include <ofono/devinfo.h>
 #include <ofono/netreg.h>
+#include <ofono/netmon.h>
 #include <ofono/phonebook.h>
 #include <ofono/voicecall.h>
 #include <ofono/sim.h>
@@ -493,8 +494,10 @@ static void gobi_post_online(struct ofono_modem *modem)
 =

 	DBG("%p", modem);
 =

-	if (data->features & GOBI_NAS)
+	if (data->features & GOBI_NAS) {
 		ofono_netreg_create(modem, 0, "qmimodem", data->device);
+		ofono_netmon_create(modem, 0, "qmimodem", data->device);
+	}
 =

 	if (data->features & GOBI_VOICE)
 		ofono_ussd_create(modem, 0, "qmimodem", data->device);
-- =

2.9.3


--===============2527899934568912627==--

