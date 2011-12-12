Content-Type: multipart/mixed; boundary="===============6282976374796521490=="
MIME-Version: 1.0
From: marko.saukko@gmail.com
Subject: [PATCH 3/3] Disabling CBS from N950 driver,
 as it supposedly doesn't work properly.
Date: Mon, 12 Dec 2011 13:39:44 +0200
Message-ID: <1323689984-24866-4-git-send-email-marko.saukko@gmail.com>
In-Reply-To: <1323689984-24866-1-git-send-email-marko.saukko@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6282976374796521490==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Marko Saukko <marko.saukko@cybercom.com>

---
 plugins/n950.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/plugins/n950.c b/plugins/n950.c
index 6c9a9da..8e82cc7 100644
--- a/plugins/n950.c
+++ b/plugins/n950.c
@@ -28,6 +28,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <glib.h>
+#include <unistd.h>
 =

 #include <gisi/modem.h>
 #include <gisi/netlink.h>
@@ -507,7 +508,7 @@ static void n950_post_online(struct ofono_modem *modem)
 =

 	ofono_netreg_create(modem, 0, "isimodem", isi->modem);
 	ofono_sms_create(modem, 0, "isimodem", isi->modem);
-	ofono_cbs_create(modem, 0, "isimodem", isi->modem);
+	/*ofono_cbs_create(modem, 0, "isimodem", isi->modem);*/
 	ofono_ussd_create(modem, 0, "isimodem", isi->modem);
 	ofono_call_settings_create(modem, 0, "isimodem", isi->modem);
 	ofono_call_barring_create(modem, 0, "isimodem", isi->modem);
-- =

1.7.6.4


--===============6282976374796521490==--

