Content-Type: multipart/mixed; boundary="===============6259605207849236264=="
MIME-Version: 1.0
From: Antara Borwankar <antara.borwankar@intel.com>
Subject: [PATCH 6/6] coex: enabled coex atom with xmm7modem driver
Date: Mon, 01 Oct 2018 16:05:53 +0530
Message-ID: <1538390153-6540-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6259605207849236264==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Antara <antara.borwankar@intel.com>

enabling coex atom in xmm7modem plugin which will use xmm7modem
driver
---
 Makefile.am                   | 12 +++++++-----
 drivers/xmm7modem/xmm7modem.c |  2 ++
 drivers/xmm7modem/xmm7modem.h |  3 +++
 include/dbus.h                |  2 ++
 plugins/xmm7xxx.c             |  2 ++
 src/ofono.conf                |  1 +
 src/ofono.h                   |  2 ++
 7 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 6dee4ce..6dfa7cf 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -23,7 +23,7 @@ pkginclude_HEADERS =3D include/log.h include/plugin.h inc=
lude/history.h \
 			include/cdma-provision.h include/handsfree.h \
 			include/handsfree-audio.h include/siri.h \
 			include/netmon.h include/lte.h include/ims.h \
-			include/storage.h
+			include/storage.h include/coex.h
 =

 nodist_pkginclude_HEADERS =3D include/version.h
 =

@@ -404,7 +404,8 @@ builtin_sources +=3D drivers/atmodem/atutil.h \
 			drivers/xmm7modem/xmm7modem.h \
 			drivers/xmm7modem/xmm7modem.c \
 			drivers/xmm7modem/radio-settings.c \
-			drivers/xmm7modem/ims.c
+			drivers/xmm7modem/ims.c \
+			drivers/xmm7modem/coex.c
 =

 if PHONESIM
 builtin_modules +=3D phonesim
@@ -667,7 +668,8 @@ src_ofonod_SOURCES =3D $(builtin_sources) $(gatchat_sou=
rces) src/ofono.ver \
 			src/handsfree-audio.c src/bluetooth.h \
 			src/hfp.h src/siri.c \
 			src/netmon.c src/lte.c src/ims.c \
-			src/netmonagent.c src/netmonagent.h
+			src/netmonagent.c src/netmonagent.h \
+			src/coex.c src/coexagent.c src/coexagent.h
 =

 src_ofonod_LDADD =3D gdbus/libgdbus-internal.la $(builtin_libadd) \
 			@GLIB_LIBS@ @DBUS_LIBS@ -ldl
@@ -717,7 +719,8 @@ doc_files =3D doc/overview.txt doc/ofono-paper.txt doc/=
release-faq.txt \
 			doc/allowed-apns-api.txt \
 			doc/lte-api.txt \
 			doc/cinterion-hardware-monitor-api.txt \
-			doc/ims-api.txt
+			doc/ims-api.txt \
+			doc/coex-api.txt
 =

 =

 test_scripts =3D test/backtrace \
@@ -827,7 +830,6 @@ test_scripts =3D test/backtrace \
 		test/ims-unregister \
 		test/list-applications
 =

-
 if TEST
 testdir =3D $(pkglibdir)/test
 test_SCRIPTS =3D $(test_scripts)
diff --git a/drivers/xmm7modem/xmm7modem.c b/drivers/xmm7modem/xmm7modem.c
index 5c08343..7ef4e16 100644
--- a/drivers/xmm7modem/xmm7modem.c
+++ b/drivers/xmm7modem/xmm7modem.c
@@ -37,6 +37,7 @@ static int xmm7modem_init(void)
 {
 	xmm_radio_settings_init();
 	xmm_ims_init();
+	xmm_coex_init();
 =

 	return 0;
 }
@@ -45,6 +46,7 @@ static void xmm7modem_exit(void)
 {
 	xmm_radio_settings_exit();
 	xmm_ims_exit();
+	xmm_coex_exit();
 }
 =

 OFONO_PLUGIN_DEFINE(xmm7modem, "Intel xmm7xxx series modem driver",
diff --git a/drivers/xmm7modem/xmm7modem.h b/drivers/xmm7modem/xmm7modem.h
index 5f8f172..cc232fc 100644
--- a/drivers/xmm7modem/xmm7modem.h
+++ b/drivers/xmm7modem/xmm7modem.h
@@ -28,3 +28,6 @@ extern void xmm_radio_settings_exit(void);
 =

 extern void xmm_ims_init(void);
 extern void xmm_ims_exit(void);
+
+extern void xmm_coex_init(void);
+extern void xmm_coex_exit(void);
diff --git a/include/dbus.h b/include/dbus.h
index 9cc47f7..a14d991 100644
--- a/include/dbus.h
+++ b/include/dbus.h
@@ -67,6 +67,8 @@ extern "C" {
 #define OFONO_NETMON_AGENT_INTERFACE OFONO_SERVICE ".NetworkMonitorAgent"
 #define OFONO_LTE_INTERFACE OFONO_SERVICE ".LongTermEvolution"
 #define OFONO_IMS_INTERFACE OFONO_SERVICE ".IpMultimediaSystem"
+#define OFONO_COEX_INTERFACE OFONO_SERVICE ".LTECoex"
+#define OFONO_COEX_AGENT_INTERFACE OFONO_SERVICE ".LTECoexAgent"
 =

 /* CDMA Interfaces */
 #define OFONO_CDMA_VOICECALL_MANAGER_INTERFACE "org.ofono.cdma.VoiceCallMa=
nager"
diff --git a/plugins/xmm7xxx.c b/plugins/xmm7xxx.c
index 9db87ad..5b11d42 100644
--- a/plugins/xmm7xxx.c
+++ b/plugins/xmm7xxx.c
@@ -50,6 +50,7 @@
 #include <ofono/lte.h>
 #include <ofono/ims.h>
 #include <ofono/sim-auth.h>
+#include <ofono/coex.h>
 =

 #include <drivers/atmodem/atutil.h>
 #include <drivers/atmodem/vendor.h>
@@ -326,6 +327,7 @@ static void xmm7xxx_post_sim(struct ofono_modem *modem)
 	ofono_lte_create(modem, 0, "atmodem", data->chat);
 	ofono_radio_settings_create(modem, 0, "xmm7modem", data->chat);
 	ofono_sim_auth_create(modem);
+	ofono_coex_create(modem, 0, "xmm7modem", data->chat);
 }
 =

 static void xmm7xxx_post_online(struct ofono_modem *modem)
diff --git a/src/ofono.conf b/src/ofono.conf
index 61e0bde..5a3afaa 100644
--- a/src/ofono.conf
+++ b/src/ofono.conf
@@ -16,6 +16,7 @@
     <allow send_interface=3D"org.ofono.PositioningRequestAgent"/>
     <allow send_interface=3D"org.ofono.HandsfreeAudioAgent"/>
     <allow send_interface=3D"org.ofono.NetworkMonitorAgent"/>
+    <allow send_interface=3D"org.ofono.LTECoexAgent"/>
   </policy>
 =

   <policy at_console=3D"true">
diff --git a/src/ofono.h b/src/ofono.h
index ac3726d..dd3b443 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -153,6 +153,7 @@ enum ofono_atom_type {
 	OFONO_ATOM_TYPE_NETMON,
 	OFONO_ATOM_TYPE_LTE,
 	OFONO_ATOM_TYPE_IMS,
+	OFONO_ATOM_TYPE_COEX,
 };
 =

 enum ofono_atom_watch_condition {
@@ -568,3 +569,4 @@ ofono_bool_t __ofono_private_network_request(ofono_priv=
ate_network_cb_t cb,
 #include <ofono/netmon.h>
 #include <ofono/lte.h>
 #include <ofono/ims.h>
+#include <ofono/coex.h>
-- =

1.9.1


--===============6259605207849236264==--

