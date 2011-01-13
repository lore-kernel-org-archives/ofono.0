Content-Type: multipart/mixed; boundary="===============8040884944491673638=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH v3 2/2] plugins: add ctm create to ifx plugin
Date: Thu, 13 Jan 2011 16:31:22 +0200
Message-ID: <1294929082-19792-3-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1294929082-19792-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8040884944491673638==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ifx.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/plugins/ifx.c b/plugins/ifx.c
index c0a69c2..08b0001 100644
--- a/plugins/ifx.c
+++ b/plugins/ifx.c
@@ -57,6 +57,7 @@
 #include <ofono/radio-settings.h>
 #include <ofono/audio-settings.h>
 #include <ofono/stk.h>
+#include <ofono/ctm.h>
 #include <ofono/log.h>
 =

 #include <drivers/atmodem/atutil.h>
@@ -700,6 +701,7 @@ static void ifx_post_sim(struct ofono_modem *modem)
 =

 	DBG("%p", modem);
 =

+	ofono_ctm_create(modem, 0, "ifxmodem", data->dlcs[AUX_DLC]);
 	ofono_stk_create(modem, 0, "ifxmodem", data->dlcs[AUX_DLC]);
 	ofono_phonebook_create(modem, OFONO_VENDOR_IFX,
 					"atmodem", data->dlcs[AUX_DLC]);
-- =

1.7.0.4


--===============8040884944491673638==--

