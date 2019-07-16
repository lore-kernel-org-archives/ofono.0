Content-Type: multipart/mixed; boundary="===============1489671885880930856=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCH 3/7] quectel: enable call volume settings
Date: Tue, 16 Jul 2019 21:10:49 +0200
Message-ID: <20190716191053.71990-3-martin@geanix.com>
In-Reply-To: <20190716191053.71990-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1489671885880930856==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/quectel.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/plugins/quectel.c b/plugins/quectel.c
index f2b765b6..61b82744 100644
--- a/plugins/quectel.c
+++ b/plugins/quectel.c
@@ -45,6 +45,7 @@
 #include <ofono/sms.h>
 #include <ofono/phonebook.h>
 #include <ofono/voicecall.h>
+#include <ofono/call-volume.h>
 #include <ofono/gprs.h>
 #include <ofono/gprs-context.h>
 #include <ofono/log.h>
@@ -398,6 +399,7 @@ static void call_ready_notify(GAtResult *result, void *=
user_data)
 =

 	ofono_phonebook_create(modem, 0, "atmodem", data->aux);
 	ofono_voicecall_create(modem, 0, "atmodem", data->aux);
+	ofono_call_volume_create(modem, 0, "atmodem", data->aux);
 }
 =

 static int open_ttys(struct ofono_modem *modem)
-- =

2.22.0


--===============1489671885880930856==--

