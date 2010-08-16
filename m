Content-Type: multipart/mixed; boundary="===============2572661612759096687=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjur.brandeland@stericsson.com>
Subject: [PATCHv2 5/7] plugins/ste: Add Radio-Settings
Date: Mon, 16 Aug 2010 15:54:06 +0200
Message-ID: <1281966848-14553-6-git-send-email-sjur.brandeland@stericsson.com>
In-Reply-To: <1281966848-14553-1-git-send-email-sjur.brandeland@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2572661612759096687==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ste.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/plugins/ste.c b/plugins/ste.c
index e1ca06c..1e3ed9d 100644
--- a/plugins/ste.c
+++ b/plugins/ste.c
@@ -55,6 +55,7 @@
 #include <ofono/gprs.h>
 #include <ofono/gprs-context.h>
 #include <ofono/stk.h>
+#include <ofono/radio-settings.h>
 #include <drivers/atmodem/vendor.h>
 =

 #include <drivers/stemodem/caif_socket.h>
@@ -292,6 +293,7 @@ static void ste_post_sim(struct ofono_modem *modem)
 	gprs =3D ofono_gprs_create(modem,
 			OFONO_VENDOR_STE, "atmodem", data->chat);
 	ofono_stk_create(modem, 0, "mbmmodem", data->chat);
+	ofono_radio_settings_create(modem, 0, "stemodem", data->chat);
 	gc =3D ofono_gprs_context_create(modem, 0, "stemodem", data->chat);
 =

 	if (gprs && gc)
-- =

1.6.3.3


--===============2572661612759096687==--

