Content-Type: multipart/mixed; boundary="===============6814212069402295643=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: [PATCH] bluez5: Move ref / unref handsfree audio
Date: Wed, 27 Feb 2013 18:49:13 -0300
Message-ID: <1362001753-6607-1-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6814212069402295643==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This commit moves the ref / unref to hfp_hf_bluez5 to make
bluez5 more generic and reusable.
---
 plugins/bluez5.c        |   15 +--------------
 plugins/hfp_hf_bluez5.c |    5 +++++
 2 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/plugins/bluez5.c b/plugins/bluez5.c
index 788f3a2..9233a2b 100644
--- a/plugins/bluez5.c
+++ b/plugins/bluez5.c
@@ -35,7 +35,6 @@
 #include <ofono/dbus.h>
 #include <ofono/plugin.h>
 #include <ofono/log.h>
-#include <ofono/handsfree-audio.h>
 =

 #include <gdbus/gdbus.h>
 #include "bluez5.h"
@@ -257,17 +256,5 @@ void bt_disconnect_profile(DBusConnection *conn,
 							cb, user_data);
 }
 =

-static int bluez5_init(void)
-{
-	ofono_handsfree_audio_ref();
-
-	return 0;
-}
-
-static void bluez5_exit(void)
-{
-	ofono_handsfree_audio_unref();
-}
-
 OFONO_PLUGIN_DEFINE(bluez5, "BlueZ 5 Utils Plugin", VERSION,
-			OFONO_PLUGIN_PRIORITY_DEFAULT, bluez5_init, bluez5_exit)
+			OFONO_PLUGIN_PRIORITY_DEFAULT, NULL, NULL)
diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index 7057d71..ad52027 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -47,6 +47,7 @@
 #include <ofono/voicecall.h>
 #include <ofono/call-volume.h>
 #include <ofono/handsfree.h>
+#include <ofono/handsfree-audio.h>
 =

 #include <drivers/hfpmodem/slc.h>
 =

@@ -683,6 +684,8 @@ static int hfp_init(void)
 	g_dbus_client_set_proxy_handlers(bluez, proxy_added, NULL,
 						property_changed, NULL);
 =

+	ofono_handsfree_audio_ref();
+
 	return 0;
 }
 =

@@ -698,6 +701,8 @@ static void hfp_exit(void)
 =

 	if (sco_watch > 0)
 		g_source_remove(sco_watch);
+
+	ofono_handsfree_audio_unref();
 }
 =

 OFONO_PLUGIN_DEFINE(hfp_bluez5, "External Hands-Free Profile Plugin", VERS=
ION,
-- =

1.7.9.5


--===============6814212069402295643==--

