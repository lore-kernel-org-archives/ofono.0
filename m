Content-Type: multipart/mixed; boundary="===============8404612970755656478=="
MIME-Version: 1.0
From: Jukka Saunamaki <jukka.saunamaki@nokia.com>
Subject: [PATCH] isiusb: add message-waiting
Date: Thu, 03 Mar 2011 10:47:24 +0200
Message-ID: <1299142044-10021-1-git-send-email-jukka.saunamaki@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8404612970755656478==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/isiusb.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/plugins/isiusb.c b/plugins/isiusb.c
index c036604..cf31756 100644
--- a/plugins/isiusb.c
+++ b/plugins/isiusb.c
@@ -54,6 +54,7 @@
 #include <ofono/radio-settings.h>
 #include <ofono/gprs.h>
 #include <ofono/gprs-context.h>
+#include <ofono/message-waiting.h>
 =

 #include "drivers/isimodem/isimodem.h"
 #include "drivers/isimodem/isiutil.h"
@@ -421,6 +422,7 @@ static void isiusb_post_sim(struct ofono_modem *modem)
 static void isiusb_post_online(struct ofono_modem *modem)
 {
 	struct isi_data *isi =3D ofono_modem_get_data(modem);
+	struct ofono_message_waiting *mw;
 =

 	DBG("(%p) with %s", modem, isi->ifname);
 =

@@ -434,6 +436,9 @@ static void isiusb_post_online(struct ofono_modem *mode=
m)
 	ofono_call_barring_create(modem, 0, "isimodem", isi->modem);
 	ofono_call_meter_create(modem, 0, "isimodem", isi->modem);
 	ofono_gprs_create(modem, 0, "isimodem", isi->modem);
+	mw =3D ofono_message_waiting_create(modem);
+	if (mw)
+		ofono_message_waiting_register(mw);
 }
 =

 static int isiusb_enable(struct ofono_modem *modem)
-- =

1.7.1


--===============8404612970755656478==--

