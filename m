Content-Type: multipart/mixed; boundary="===============4295267681106446803=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjur.brandeland@stericsson.com>
Subject: [PATCHv2 1/7] stemodem: Add support for STK by including MBM
 implementation.
Date: Mon, 16 Aug 2010 15:54:02 +0200
Message-ID: <1281966848-14553-2-git-send-email-sjur.brandeland@stericsson.com>
In-Reply-To: <1281966848-14553-1-git-send-email-sjur.brandeland@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4295267681106446803==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
Changes:
 o Use MBM stk driver implementation (avoid copying code).
   Note: stemodm.h has to declare the mbm_stk_init/exit functions because
   	 importing mbmdriver causes compile errors due to duplicated
	 declarations.


 drivers/stemodem/stemodem.c |    2 ++
 drivers/stemodem/stemodem.h |    2 ++
 plugins/ste.c               |    2 ++
 3 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/stemodem/stemodem.c b/drivers/stemodem/stemodem.c
index c18a8b5..0ba7878 100644
--- a/drivers/stemodem/stemodem.c
+++ b/drivers/stemodem/stemodem.c
@@ -38,6 +38,7 @@ static int stemodem_init(void)
 {
 	ste_voicecall_init();
 	ste_gprs_context_init();
+	mbm_stk_init();
 =

 	return 0;
 }
@@ -46,6 +47,7 @@ static void stemodem_exit(void)
 {
 	ste_voicecall_exit();
 	ste_gprs_context_exit();
+	mbm_stk_exit();
 }
 =

 OFONO_PLUGIN_DEFINE(stemodem, "STE modem driver", VERSION,
diff --git a/drivers/stemodem/stemodem.h b/drivers/stemodem/stemodem.h
index 267e001..e10abd3 100644
--- a/drivers/stemodem/stemodem.h
+++ b/drivers/stemodem/stemodem.h
@@ -28,3 +28,5 @@ extern void ste_gprs_context_exit();
 extern void ste_voicecall_init();
 extern void ste_voicecall_exit();
 =

+extern void mbm_stk_init();
+extern void mbm_stk_exit();
diff --git a/plugins/ste.c b/plugins/ste.c
index f3ae0b2..9cb49d3 100644
--- a/plugins/ste.c
+++ b/plugins/ste.c
@@ -54,6 +54,7 @@
 #include <ofono/voicecall.h>
 #include <ofono/gprs.h>
 #include <ofono/gprs-context.h>
+#include <ofono/stk.h>
 #include <drivers/atmodem/vendor.h>
 =

 #include <drivers/stemodem/caif_socket.h>
@@ -241,6 +242,7 @@ static void ste_post_sim(struct ofono_modem *modem)
 =

 	gprs =3D ofono_gprs_create(modem,
 			OFONO_VENDOR_STE, "atmodem", data->chat);
+	ofono_stk_create(modem, 0, "mbmmodem", data->chat);
 	gc =3D ofono_gprs_context_create(modem, 0, "stemodem", data->chat);
 =

 	if (gprs && gc)
-- =

1.7.0.4


--===============4295267681106446803==--

