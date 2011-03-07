Content-Type: multipart/mixed; boundary="===============7746213796589613429=="
MIME-Version: 1.0
From: Antti Paila <antti.paila@nokia.com>
Subject: [PATCH 4/5] isimodem: cell info creation to post_online
Date: Mon, 07 Mar 2011 12:24:33 +0200
Message-ID: <1299493474-12982-5-git-send-email-antti.paila@nokia.com>
In-Reply-To: <1299493474-12982-1-git-send-email-antti.paila@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7746213796589613429==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/isiusb.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/plugins/isiusb.c b/plugins/isiusb.c
index 2d17b43..1356f8f 100644
--- a/plugins/isiusb.c
+++ b/plugins/isiusb.c
@@ -55,6 +55,7 @@
 #include <ofono/gprs.h>
 #include <ofono/gprs-context.h>
 #include <ofono/message-waiting.h>
+#include <ofono/cell-info.h>
 =

 #include "drivers/isimodem/isimodem.h"
 #include "drivers/isimodem/isiutil.h"
@@ -441,6 +442,8 @@ static void isiusb_post_online(struct ofono_modem *mode=
m)
 	mw =3D ofono_message_waiting_create(modem);
 	if (mw)
 		ofono_message_waiting_register(mw);
+
+	ofono_cell_info_create(modem, 0, "isimodem", isi->modem);
 }
 =

 static int isiusb_enable(struct ofono_modem *modem)
-- =

1.7.1


--===============7746213796589613429==--

