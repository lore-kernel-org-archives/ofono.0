Content-Type: multipart/mixed; boundary="===============5188719741914010522=="
MIME-Version: 1.0
From: r.r.zaripov@gmail.com
Subject: [PATCH] sim900: Add ussd and voice call support
Date: Sun, 11 Mar 2012 10:08:38 +0400
Message-ID: <1331446118-13750-1-git-send-email-r.r.zaripov@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5188719741914010522==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Renat Zaripov <r.r.zaripov@gmail.com>

---
 plugins/sim900.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/plugins/sim900.c b/plugins/sim900.c
index 1589a33..496faa6 100644
--- a/plugins/sim900.c
+++ b/plugins/sim900.c
@@ -43,6 +43,7 @@
 #include <ofono/phonebook.h>
 #include <ofono/history.h>
 #include <ofono/log.h>
+#include <ofono/voicecall.h>
 =

 #include <drivers/atmodem/vendor.h>
 =

@@ -235,6 +236,8 @@ static void sim900_post_online(struct ofono_modem *mode=
m)
 	DBG("%p", modem);
 =

 	ofono_netreg_create(modem, OFONO_VENDOR_SIMCOM, "atmodem", data->modem);
+	ofono_ussd_create(modem, 0, "atmodem", data->modem);
+	ofono_voicecall_create(modem, 0, "atmodem", data->modem);
 }
 =

 static struct ofono_modem_driver sim900_driver =3D {
-- =

1.7.7.3


--===============5188719741914010522==--

