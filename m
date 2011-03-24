Content-Type: multipart/mixed; boundary="===============7838505785150027025=="
MIME-Version: 1.0
From: Jarko Poutiainen <jarko.poutiainen@tieto.com>
Subject: [PATCH 10/12] ste: add support for gnss
Date: Thu, 24 Mar 2011 15:46:34 +0200
Message-ID: <1300974396-15801-11-git-send-email-jarko.poutiainen@tieto.com>
In-Reply-To: <1300974396-15801-1-git-send-email-jarko.poutiainen@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7838505785150027025==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ste.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/plugins/ste.c b/plugins/ste.c
index 36b3148..f7fe2b4 100644
--- a/plugins/ste.c
+++ b/plugins/ste.c
@@ -57,6 +57,7 @@
 #include <ofono/gprs-context.h>
 #include <ofono/radio-settings.h>
 #include <ofono/stk.h>
+#include <ofono/gnss.h>
 =

 #include <drivers/atmodem/atutil.h>
 #include <drivers/atmodem/vendor.h>
@@ -64,17 +65,18 @@
 #include <drivers/stemodem/caif_socket.h>
 #include <drivers/stemodem/if_caif.h>
 =

-#define NUM_CHAT	5
+#define NUM_CHAT	6
 #define AT_DEFAULT	0
 #define AT_NET		1
 #define AT_VOICE	2
 #define AT_GPRS	3
 #define AT_SIM		4
+#define AT_GNSS	5
 =

 #define MAX_PDP_CONTEXTS	4
 =

 static char *chat_prefixes[NUM_CHAT] =3D { "Default: ", "Net: ", "Voice: ",
-					"GPRS: ", "SIM: " };
+					 "GPRS: ", "SIM: ", "GNSS:" };
 =

 struct ste_data {
 	GAtChat *chat[NUM_CHAT];
@@ -471,6 +473,8 @@ static void ste_post_online(struct ofono_modem *modem)
 	ofono_call_barring_create(modem, 0, "atmodem", data->chat[AT_DEFAULT]);
 	ofono_call_volume_create(modem, 0, "atmodem", data->chat[AT_DEFAULT]);
 	ofono_cbs_create(modem, 0, "atmodem", data->chat[AT_DEFAULT]);
+	ofono_gnss_create(modem, OFONO_VENDOR_STE, "atmodem",
+				data->chat[AT_GNSS]);
 =

 	gprs =3D ofono_gprs_create(modem, OFONO_VENDOR_MBM,
 					"atmodem", data->chat[AT_GPRS]);
-- =

1.7.0.4


--===============7838505785150027025==--

