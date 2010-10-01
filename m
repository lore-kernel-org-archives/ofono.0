Content-Type: multipart/mixed; boundary="===============6282636234309069184=="
MIME-Version: 1.0
From: Kai Vehmanen <kai.vehmanen@nokia.com>
Subject: [PATCH 2/2] n900: Enable audio settings atom
Date: Fri, 01 Oct 2010 16:04:16 +0300
Message-ID: <1285938256-6423-3-git-send-email-kai.vehmanen@nokia.com>
In-Reply-To: <1285938256-6423-1-git-send-email-kai.vehmanen@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6282636234309069184==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/n900.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/plugins/n900.c b/plugins/n900.c
index 9be7b09..a9e6b59 100644
--- a/plugins/n900.c
+++ b/plugins/n900.c
@@ -53,6 +53,7 @@
 #include <ofono/radio-settings.h>
 #include <ofono/gprs.h>
 #include <ofono/gprs-context.h>
+#include <ofono/audio-settings.h>
 =

 #include "drivers/isimodem/isimodem.h"
 #include "drivers/isimodem/isiutil.h"
@@ -480,6 +481,7 @@ static void n900_pre_sim(struct ofono_modem *modem)
 	ofono_sim_create(isi->modem, 0, "isimodem", isi->idx);
 	ofono_devinfo_create(isi->modem, 0, "isimodem", isi->idx);
 	ofono_voicecall_create(isi->modem, 0, "isimodem", isi->idx);
+	ofono_audio_settings_create(isi->modem, 0, "isimodem", isi->idx);
 }
 =

 static void n900_post_sim(struct ofono_modem *modem)
-- =

1.7.0.4


--===============6282636234309069184==--

