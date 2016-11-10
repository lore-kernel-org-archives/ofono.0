Content-Type: multipart/mixed; boundary="===============8573279698198370770=="
MIME-Version: 1.0
From: Dragos Tatulea <dragos@endocode.com>
Subject: [PATCH 9/9] plugins: ublox: enable lte driver for tobyl2
Date: Thu, 10 Nov 2016 17:55:56 +0100
Message-ID: <1478796956-22500-10-git-send-email-dragos@endocode.com>
In-Reply-To: <1478796956-22500-1-git-send-email-dragos@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8573279698198370770==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ublox.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/plugins/ublox.c b/plugins/ublox.c
index 092ba64..6d77df8 100644
--- a/plugins/ublox.c
+++ b/plugins/ublox.c
@@ -38,6 +38,7 @@
 #include <ofono/sim.h>
 #include <ofono/gprs.h>
 #include <ofono/gprs-context.h>
+#include <ofono/lte.h>
 =

 #include <drivers/atmodem/atutil.h>
 #include <drivers/atmodem/vendor.h>
@@ -313,6 +314,8 @@ static void ublox_post_sim(struct ofono_modem *modem)
 =

 		--ncontexts;
 	}
+
+	ofono_lte_create(modem, "ubloxmodem", data->aux);
 }
 =

 static void ublox_post_online(struct ofono_modem *modem)
-- =

2.7.4


--===============8573279698198370770==--

