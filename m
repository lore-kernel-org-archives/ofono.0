Content-Type: multipart/mixed; boundary="===============0377654648773552143=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: [PATCH v4 1/7] plugins/ste: Include STK support from MBM driver.
Date: Mon, 16 Aug 2010 23:12:06 +0200
Message-ID: <1281993134-3926-1-git-send-email-sjurbren@gmail.com>
In-Reply-To: <1281966848-14553-1-git-send-email-sjur.brandeland@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0377654648773552143==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Sjur Br=C3=A6ndeland <sjur.brandeland@stericsson.com>

---
Marcel Holtmann wrote:
>>> ... The build system builds the plugins
>>> properly and you can cross reference modem drivers from your modem
>>> plugin without any problems.
>>
>>Simply refering to MBM driver from ste.c
>>
>one minor nitpick here. Can you please not squeeze this in between GPRS
>and GPRS Context atoms. Put it at the same location the MBM plugin does.

Fixed.

---
 plugins/ste.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/plugins/ste.c b/plugins/ste.c
index f3ae0b2..5b34704 100644
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
@@ -228,6 +229,7 @@ static void ste_post_sim(struct ofono_modem *modem)
 =

 	DBG("%p", modem);
 =

+	ofono_stk_create(modem, 0, "mbmmodem", data->chat);
 	ofono_ussd_create(modem, 0, "atmodem", data->chat);
 	ofono_call_forwarding_create(modem, 0, "atmodem", data->chat);
 	ofono_call_settings_create(modem, 0, "atmodem", data->chat);
-- =

1.6.3.3


--===============0377654648773552143==--

