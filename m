Content-Type: multipart/mixed; boundary="===============0489421931124753091=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: [PATCH v3 5/7] plugins/ste: Add Radio-Settings
Date: Mon, 16 Aug 2010 22:35:47 +0200
Message-ID: <1281990950-21705-5-git-send-email-sjurbren@gmail.com>
In-Reply-To: <1281990950-21705-4-git-send-email-sjurbren@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0489421931124753091==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Sjur Br=C3=A6ndeland <sjur.brandeland@stericsson.com>

---
 plugins/ste.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/plugins/ste.c b/plugins/ste.c
index 5fecd5e..5a71945 100644
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
@@ -293,6 +294,7 @@ static void ste_post_sim(struct ofono_modem *modem)
 	gprs =3D ofono_gprs_create(modem,
 			OFONO_VENDOR_STE, "atmodem", data->chat);
 	ofono_stk_create(modem, 0, "mbmmodem", data->chat);
+	ofono_radio_settings_create(modem, 0, "stemodem", data->chat);
 	gc =3D ofono_gprs_context_create(modem, 0, "stemodem", data->chat);
 =

 	if (gprs && gc)
-- =

1.6.3.3


--===============0489421931124753091==--

