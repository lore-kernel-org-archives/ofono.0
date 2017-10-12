Content-Type: multipart/mixed; boundary="===============0249551472892228686=="
MIME-Version: 1.0
From: James Prestwood <james.prestwood@linux.intel.com>
Subject: [PATCHv5 4/4] phonesim: Added sim-auth to phonesim plugin
Date: Thu, 12 Oct 2017 09:28:11 -0700
Message-ID: <1507825691-21128-4-git-send-email-james.prestwood@linux.intel.com>
In-Reply-To: <1507825691-21128-1-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0249551472892228686==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/phonesim.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/plugins/phonesim.c b/plugins/phonesim.c
index 16bccd5..3af2c46 100644
--- a/plugins/phonesim.c
+++ b/plugins/phonesim.c
@@ -61,6 +61,7 @@
 #include <ofono/gnss.h>
 #include <ofono/handsfree.h>
 #include <ofono/siri.h>
+#include <ofono/sim-auth.h>
 =

 #include <drivers/atmodem/vendor.h>
 #include <drivers/atmodem/atutil.h>
@@ -860,6 +861,7 @@ static void phonesim_post_sim(struct ofono_modem *modem)
 		ofono_sms_create(modem, 0, "atmodem", data->chat);
 =

 	ofono_radio_settings_create(modem, 0, "phonesim", data->chat);
+	ofono_sim_auth_create(modem, 0, "atmodem", data->chat);
 }
 =

 static void phonesim_post_online(struct ofono_modem *modem)
-- =

2.7.4


--===============0249551472892228686==--

