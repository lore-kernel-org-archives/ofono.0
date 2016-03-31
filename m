Content-Type: multipart/mixed; boundary="===============9144552119808447318=="
MIME-Version: 1.0
From: Nishanth V <nishanth.v@intel.com>
Subject: [PATCH 5/6] sofia3gr: Add netmon support
Date: Thu, 31 Mar 2016 09:54:23 +0530
Message-ID: <1459398263-5934-1-git-send-email-nishanth.v@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9144552119808447318==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ril_sofia3gr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/plugins/ril_sofia3gr.c b/plugins/ril_sofia3gr.c
index 2cba72f..bdbc39d 100644
--- a/plugins/ril_sofia3gr.c
+++ b/plugins/ril_sofia3gr.c
@@ -46,6 +46,7 @@
 #include <ofono/gprs-context.h>
 #include <ofono/radio-settings.h>
 #include <ofono/ussd.h>
+#include <ofono/netmon.h>
 =

 #include <gril/gril.h>
 =

@@ -172,6 +173,7 @@ static void ril_post_online(struct ofono_modem *modem)
 	ofono_netreg_create(modem, 0, "rilmodem", rd->ril);
 	ofono_radio_settings_create(modem, 0, "rilmodem", rd->ril);
 	ofono_ussd_create(modem, 0, "rilmodem", rd->ril);
+	ofono_netmon_create(modem, 0, "rilmodem", rd->ril);
 }
 =

 static void ril_set_online_cb(struct ril_msg *message, gpointer user_data)
-- =

1.9.1


--===============9144552119808447318==--

