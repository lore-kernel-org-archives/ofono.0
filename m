Content-Type: multipart/mixed; boundary="===============4475021102667085321=="
MIME-Version: 1.0
From: James Prestwood <james.prestwood@linux.intel.com>
Subject: [PATCHv5 3/4] xmm7xxx: add sim-auth driver to xmm7xxx plugin
Date: Thu, 12 Oct 2017 09:28:10 -0700
Message-ID: <1507825691-21128-3-git-send-email-james.prestwood@linux.intel.com>
In-Reply-To: <1507825691-21128-1-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4475021102667085321==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/xmm7xxx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/plugins/xmm7xxx.c b/plugins/xmm7xxx.c
index 5cb843b..497bdef 100644
--- a/plugins/xmm7xxx.c
+++ b/plugins/xmm7xxx.c
@@ -49,6 +49,7 @@
 #include <ofono/stk.h>
 #include <ofono/lte.h>
 #include <ofono/ims.h>
+#include <ofono/sim-auth.h>
 =

 #include <drivers/atmodem/atutil.h>
 #include <drivers/atmodem/vendor.h>
@@ -322,6 +323,7 @@ static void xmm7xxx_post_sim(struct ofono_modem *modem)
 =

 	ofono_lte_create(modem, "atmodem", data->chat);
 	ofono_radio_settings_create(modem, 0, "xmm7modem", data->chat);
+	ofono_sim_auth_create(modem, 0, "atmodem", data->chat);
 }
 =

 static void xmm7xxx_post_online(struct ofono_modem *modem)
-- =

2.7.4


--===============4475021102667085321==--

