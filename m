Content-Type: multipart/mixed; boundary="===============3071241155869433505=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH] plugins: add ctm create to ifx plugin
Date: Fri, 14 Jan 2011 15:10:01 +0200
Message-ID: <1295010601-11721-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3071241155869433505==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ifx.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/plugins/ifx.c b/plugins/ifx.c
index c0a69c2..61c60c1 100644
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
@@ -692,6 +693,7 @@ static void ifx_pre_sim(struct ofono_modem *modem)
 	ofono_voicecall_create(modem, 0, "ifxmodem", data->dlcs[VOICE_DLC]);
 	ofono_audio_settings_create(modem, 0,
 					"ifxmodem", data->dlcs[VOICE_DLC]);
+	ofono_ctm_create(modem, 0, "ifxmodem", data->dlcs[AUX_DLC]);
 }
 =

 static void ifx_post_sim(struct ofono_modem *modem)
-- =

1.7.0.4


--===============3071241155869433505==--

