Content-Type: multipart/mixed; boundary="===============3701549336787669706=="
MIME-Version: 1.0
From: Alex J Lennon <ajlennon@dynamicdevices.co.uk>
Subject: [PATCH 3/4] cinterion: Register as OFONO_VENDOR_CINTERION
Date: Tue, 12 May 2015 18:23:01 +0100
Message-ID: <1431451382-7788-3-git-send-email-ajlennon@dynamicdevices.co.uk>
In-Reply-To: <1431451382-7788-1-git-send-email-ajlennon@dynamicdevices.co.uk>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3701549336787669706==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This enables us to take advantage of vendor specific quirks
(e.g. signal strength handling specifics for tc65)
---
 plugins/cinterion.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/plugins/cinterion.c b/plugins/cinterion.c
index 7f14fa0..6d85189 100644
--- a/plugins/cinterion.c
+++ b/plugins/cinterion.c
@@ -52,6 +52,8 @@
 #include <ofono/gprs.h>
 #include <ofono/gprs-context.h>
 =

+#include <drivers/atmodem/vendor.h>
+
 static int cinterion_probe(struct ofono_modem *modem)
 {
 	return 0;
@@ -207,7 +209,7 @@ static void cinterion_post_online(struct ofono_modem *m=
odem)
 	ofono_ussd_create(modem, 0, "atmodem", chat);
 	ofono_call_forwarding_create(modem, 0, "atmodem", chat);
 	ofono_call_settings_create(modem, 0, "atmodem", chat);
-	ofono_netreg_create(modem, 0, "atmodem", chat);
+	ofono_netreg_create(modem, OFONO_VENDOR_CINTERION, "atmodem", chat);
 	ofono_call_meter_create(modem, 0, "atmodem", chat);
 	ofono_call_barring_create(modem, 0, "atmodem", chat);
 =

-- =

1.9.1


--===============3701549336787669706==--

