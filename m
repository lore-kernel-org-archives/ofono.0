Content-Type: multipart/mixed; boundary="===============6121854896248467635=="
MIME-Version: 1.0
From: Petr Vorel <petr.vorel@gmail.com>
Subject: [PATCH 2/2] don't redefine GNU_SOURCE
Date: Fri, 06 Nov 2015 18:34:17 +0100
Message-ID: <1446831257-26136-2-git-send-email-petr.vorel@gmail.com>
In-Reply-To: <1446831257-26136-1-git-send-email-petr.vorel@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6121854896248467635==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
 drivers/atmodem/call-barring.c          | 2 ++
 drivers/atmodem/call-forwarding.c       | 2 ++
 drivers/atmodem/call-meter.c            | 2 ++
 drivers/atmodem/call-settings.c         | 2 ++
 drivers/atmodem/call-volume.c           | 2 ++
 drivers/atmodem/cbs.c                   | 2 ++
 drivers/atmodem/gnss.c                  | 2 ++
 drivers/atmodem/gprs-context.c          | 2 ++
 drivers/atmodem/gprs.c                  | 2 ++
 drivers/atmodem/network-registration.c  | 2 ++
 drivers/atmodem/phonebook.c             | 2 ++
 drivers/atmodem/sim-auth.c              | 2 ++
 drivers/atmodem/sim.c                   | 2 ++
 drivers/atmodem/sms.c                   | 2 ++
 drivers/atmodem/stk.c                   | 2 ++
 drivers/atmodem/ussd.c                  | 2 ++
 drivers/atmodem/voicecall.c             | 2 ++
 drivers/calypsomodem/stk.c              | 2 ++
 drivers/calypsomodem/voicecall.c        | 2 ++
 drivers/cdmamodem/connman.c             | 2 ++
 drivers/cdmamodem/voicecall.c           | 2 ++
 drivers/hfpmodem/call-volume.c          | 2 ++
 drivers/hfpmodem/handsfree.c            | 2 ++
 drivers/hfpmodem/network-registration.c | 2 ++
 drivers/hfpmodem/siri.c                 | 2 ++
 drivers/hfpmodem/slc.c                  | 2 ++
 drivers/hfpmodem/voicecall.c            | 2 ++
 drivers/hsomodem/gprs-context.c         | 2 ++
 drivers/hsomodem/radio-settings.c       | 2 ++
 drivers/huaweimodem/audio-settings.c    | 2 ++
 drivers/huaweimodem/cdma-netreg.c       | 2 ++
 drivers/huaweimodem/gprs-context.c      | 2 ++
 drivers/huaweimodem/radio-settings.c    | 2 ++
 drivers/huaweimodem/voicecall.c         | 2 ++
 drivers/iceramodem/gprs-context.c       | 2 ++
 drivers/iceramodem/radio-settings.c     | 2 ++
 drivers/ifxmodem/audio-settings.c       | 2 ++
 drivers/ifxmodem/ctm.c                  | 2 ++
 drivers/ifxmodem/gprs-context.c         | 2 ++
 drivers/ifxmodem/radio-settings.c       | 2 ++
 drivers/ifxmodem/stk.c                  | 2 ++
 drivers/ifxmodem/voicecall.c            | 2 ++
 drivers/isimodem/audio-settings.c       | 2 ++
 drivers/isimodem/call-barring.c         | 2 ++
 drivers/isimodem/call-forwarding.c      | 2 ++
 drivers/isimodem/call-meter.c           | 2 ++
 drivers/isimodem/call-settings.c        | 2 ++
 drivers/isimodem/cbs.c                  | 2 ++
 drivers/isimodem/debug.c                | 2 ++
 drivers/isimodem/devinfo.c              | 2 ++
 drivers/isimodem/gprs-context.c         | 2 ++
 drivers/isimodem/gprs.c                 | 2 ++
 drivers/isimodem/network-registration.c | 2 ++
 drivers/isimodem/radio-settings.c       | 2 ++
 drivers/isimodem/sim.c                  | 2 ++
 drivers/isimodem/sms.c                  | 2 ++
 drivers/isimodem/uicc-util.c            | 2 ++
 drivers/isimodem/uicc.c                 | 2 ++
 drivers/isimodem/ussd.c                 | 2 ++
 drivers/isimodem/voicecall.c            | 2 ++
 drivers/mbmmodem/gprs-context.c         | 2 ++
 drivers/mbmmodem/location-reporting.c   | 2 ++
 drivers/mbmmodem/stk.c                  | 2 ++
 drivers/nwmodem/radio-settings.c        | 2 ++
 drivers/qmimodem/location-reporting.c   | 2 ++
 drivers/qmimodem/qmi.c                  | 2 ++
 drivers/rilmodem/call-forwarding.c      | 2 ++
 drivers/rilmodem/call-settings.c        | 2 ++
 drivers/rilmodem/call-volume.c          | 2 ++
 drivers/rilmodem/devinfo.c              | 2 ++
 drivers/rilmodem/gprs-context.c         | 2 ++
 drivers/rilmodem/gprs.c                 | 2 ++
 drivers/rilmodem/network-registration.c | 2 ++
 drivers/rilmodem/phonebook.c            | 2 ++
 drivers/rilmodem/radio-settings.c       | 2 ++
 drivers/rilmodem/sim.c                  | 2 ++
 drivers/rilmodem/sms.c                  | 2 ++
 drivers/rilmodem/ussd.c                 | 2 ++
 drivers/rilmodem/voicecall.c            | 2 ++
 drivers/stemodem/gprs-context.c         | 2 ++
 drivers/stemodem/radio-settings.c       | 2 ++
 drivers/stemodem/voicecall.c            | 2 ++
 drivers/swmodem/gprs-context.c          | 2 ++
 drivers/telitmodem/location-reporting.c | 2 ++
 drivers/ztemodem/radio-settings.c       | 2 ++
 gisi/client.c                           | 2 ++
 gisi/modem.c                            | 2 ++
 gril/parcel.c                           | 2 ++
 src/call-volume.c                       | 2 ++
 src/cdma-smsutil.c                      | 2 ++
 src/common.c                            | 2 ++
 src/gnss.c                              | 2 ++
 src/gnssagent.c                         | 2 ++
 src/handsfree.c                         | 2 ++
 src/idmap.c                             | 2 ++
 src/log.c                               | 2 ++
 src/phonebook.c                         | 2 ++
 src/sim-auth.c                          | 2 ++
 src/sim.c                               | 2 ++
 src/simfs.c                             | 2 ++
 src/siri.c                              | 2 ++
 src/smsagent.c                          | 2 ++
 src/smsutil.c                           | 2 ++
 src/stk.c                               | 2 ++
 src/stkagent.c                          | 2 ++
 src/storage.c                           | 2 ++
 src/ussd.c                              | 2 ++
 tools/tty-redirector.c                  | 2 ++
 108 files changed, 216 insertions(+)

diff --git a/drivers/atmodem/call-barring.c b/drivers/atmodem/call-barring.c
index 1239d05..243d3fc 100644
--- a/drivers/atmodem/call-barring.c
+++ b/drivers/atmodem/call-barring.c
@@ -23,7 +23,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/atmodem/call-forwarding.c b/drivers/atmodem/call-forwa=
rding.c
index e2020d3..b40e920 100644
--- a/drivers/atmodem/call-forwarding.c
+++ b/drivers/atmodem/call-forwarding.c
@@ -23,7 +23,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/atmodem/call-meter.c b/drivers/atmodem/call-meter.c
index 430d546..7c2535f 100644
--- a/drivers/atmodem/call-meter.c
+++ b/drivers/atmodem/call-meter.c
@@ -23,7 +23,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/atmodem/call-settings.c b/drivers/atmodem/call-setting=
s.c
index f017ab5..b185585 100644
--- a/drivers/atmodem/call-settings.c
+++ b/drivers/atmodem/call-settings.c
@@ -23,7 +23,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/atmodem/call-volume.c b/drivers/atmodem/call-volume.c
index e2535b1..7905e7e 100644
--- a/drivers/atmodem/call-volume.c
+++ b/drivers/atmodem/call-volume.c
@@ -23,7 +23,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <string.h>
 #include <stdio.h>
 =

diff --git a/drivers/atmodem/cbs.c b/drivers/atmodem/cbs.c
index 3c491be..196935e 100644
--- a/drivers/atmodem/cbs.c
+++ b/drivers/atmodem/cbs.c
@@ -23,7 +23,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <string.h>
 #include <stdio.h>
 =

diff --git a/drivers/atmodem/gnss.c b/drivers/atmodem/gnss.c
index 5d868dd..bc7eacf 100644
--- a/drivers/atmodem/gnss.c
+++ b/drivers/atmodem/gnss.c
@@ -24,7 +24,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/atmodem/gprs-context.c b/drivers/atmodem/gprs-context.c
index f6e6c2e..c7486ff 100644
--- a/drivers/atmodem/gprs-context.c
+++ b/drivers/atmodem/gprs-context.c
@@ -23,7 +23,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/atmodem/gprs.c b/drivers/atmodem/gprs.c
index 5551316..9aef095 100644
--- a/drivers/atmodem/gprs.c
+++ b/drivers/atmodem/gprs.c
@@ -24,7 +24,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/atmodem/network-registration.c b/drivers/atmodem/netwo=
rk-registration.c
index 7cfd6b2..94dc045 100644
--- a/drivers/atmodem/network-registration.c
+++ b/drivers/atmodem/network-registration.c
@@ -24,7 +24,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/atmodem/phonebook.c b/drivers/atmodem/phonebook.c
index a43b8cc..0a6995a 100644
--- a/drivers/atmodem/phonebook.c
+++ b/drivers/atmodem/phonebook.c
@@ -23,7 +23,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/atmodem/sim-auth.c b/drivers/atmodem/sim-auth.c
index 271ceed..5b8c31c 100644
--- a/drivers/atmodem/sim-auth.c
+++ b/drivers/atmodem/sim-auth.c
@@ -23,7 +23,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <string.h>
 =

 #include <glib.h>
diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index d6a0dcf..62e47e4 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -23,7 +23,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/atmodem/sms.c b/drivers/atmodem/sms.c
index f93dd23..7ef4c9d 100644
--- a/drivers/atmodem/sms.c
+++ b/drivers/atmodem/sms.c
@@ -23,7 +23,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/atmodem/stk.c b/drivers/atmodem/stk.c
index b4fb2f2..794a639 100644
--- a/drivers/atmodem/stk.c
+++ b/drivers/atmodem/stk.c
@@ -23,7 +23,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/atmodem/ussd.c b/drivers/atmodem/ussd.c
index 2e45317..ab2fa15 100644
--- a/drivers/atmodem/ussd.c
+++ b/drivers/atmodem/ussd.c
@@ -23,7 +23,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/atmodem/voicecall.c b/drivers/atmodem/voicecall.c
index 7d823a2..4fc8140 100644
--- a/drivers/atmodem/voicecall.c
+++ b/drivers/atmodem/voicecall.c
@@ -23,7 +23,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/calypsomodem/stk.c b/drivers/calypsomodem/stk.c
index 9ac9d7c..5bc7f91 100644
--- a/drivers/calypsomodem/stk.c
+++ b/drivers/calypsomodem/stk.c
@@ -23,7 +23,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/calypsomodem/voicecall.c b/drivers/calypsomodem/voicec=
all.c
index 3c047b7..bd7cd8c 100644
--- a/drivers/calypsomodem/voicecall.c
+++ b/drivers/calypsomodem/voicecall.c
@@ -23,7 +23,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/cdmamodem/connman.c b/drivers/cdmamodem/connman.c
index 8c3265a..d41dc19 100644
--- a/drivers/cdmamodem/connman.c
+++ b/drivers/cdmamodem/connman.c
@@ -23,7 +23,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/cdmamodem/voicecall.c b/drivers/cdmamodem/voicecall.c
index 98cf554..f4f22bb 100644
--- a/drivers/cdmamodem/voicecall.c
+++ b/drivers/cdmamodem/voicecall.c
@@ -23,7 +23,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/hfpmodem/call-volume.c b/drivers/hfpmodem/call-volume.c
index 0d7431e..263e97b 100644
--- a/drivers/hfpmodem/call-volume.c
+++ b/drivers/hfpmodem/call-volume.c
@@ -23,7 +23,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/hfpmodem/handsfree.c b/drivers/hfpmodem/handsfree.c
index 6e8c4d3..31280d2 100644
--- a/drivers/hfpmodem/handsfree.c
+++ b/drivers/hfpmodem/handsfree.c
@@ -24,7 +24,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/hfpmodem/network-registration.c b/drivers/hfpmodem/net=
work-registration.c
index 22ce664..d96da3d 100644
--- a/drivers/hfpmodem/network-registration.c
+++ b/drivers/hfpmodem/network-registration.c
@@ -24,7 +24,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/hfpmodem/siri.c b/drivers/hfpmodem/siri.c
index 6106ef8..dcbc6ab 100644
--- a/drivers/hfpmodem/siri.c
+++ b/drivers/hfpmodem/siri.c
@@ -23,7 +23,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/hfpmodem/slc.c b/drivers/hfpmodem/slc.c
index 8e62519..b4f4fbe 100644
--- a/drivers/hfpmodem/slc.c
+++ b/drivers/hfpmodem/slc.c
@@ -23,7 +23,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <stdio.h>
 #include <string.h>
 #include <errno.h>
diff --git a/drivers/hfpmodem/voicecall.c b/drivers/hfpmodem/voicecall.c
index d0e9353..874e9e4 100644
--- a/drivers/hfpmodem/voicecall.c
+++ b/drivers/hfpmodem/voicecall.c
@@ -23,7 +23,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/hsomodem/gprs-context.c b/drivers/hsomodem/gprs-contex=
t.c
index ce8d21c..8470a98 100644
--- a/drivers/hsomodem/gprs-context.c
+++ b/drivers/hsomodem/gprs-context.c
@@ -23,7 +23,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/hsomodem/radio-settings.c b/drivers/hsomodem/radio-set=
tings.c
index e3d87f3..9331995 100644
--- a/drivers/hsomodem/radio-settings.c
+++ b/drivers/hsomodem/radio-settings.c
@@ -23,7 +23,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/huaweimodem/audio-settings.c b/drivers/huaweimodem/aud=
io-settings.c
index 1d4e903..f0d1297 100644
--- a/drivers/huaweimodem/audio-settings.c
+++ b/drivers/huaweimodem/audio-settings.c
@@ -23,7 +23,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/huaweimodem/cdma-netreg.c b/drivers/huaweimodem/cdma-n=
etreg.c
index 2ae66e1..368ffd7 100644
--- a/drivers/huaweimodem/cdma-netreg.c
+++ b/drivers/huaweimodem/cdma-netreg.c
@@ -23,7 +23,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <glib.h>
 #include <errno.h>
 =

diff --git a/drivers/huaweimodem/gprs-context.c b/drivers/huaweimodem/gprs-=
context.c
index 3acd90c..9cb40e5 100644
--- a/drivers/huaweimodem/gprs-context.c
+++ b/drivers/huaweimodem/gprs-context.c
@@ -23,7 +23,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/huaweimodem/radio-settings.c b/drivers/huaweimodem/rad=
io-settings.c
index c34653a..b8c67c1 100644
--- a/drivers/huaweimodem/radio-settings.c
+++ b/drivers/huaweimodem/radio-settings.c
@@ -23,7 +23,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/huaweimodem/voicecall.c b/drivers/huaweimodem/voicecal=
l.c
index f55568d..f9e8eda 100644
--- a/drivers/huaweimodem/voicecall.c
+++ b/drivers/huaweimodem/voicecall.c
@@ -23,7 +23,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/iceramodem/gprs-context.c b/drivers/iceramodem/gprs-co=
ntext.c
index 5f3ff30..11f92cd 100644
--- a/drivers/iceramodem/gprs-context.c
+++ b/drivers/iceramodem/gprs-context.c
@@ -23,7 +23,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/iceramodem/radio-settings.c b/drivers/iceramodem/radio=
-settings.c
index d76e545..eb03fc7 100644
--- a/drivers/iceramodem/radio-settings.c
+++ b/drivers/iceramodem/radio-settings.c
@@ -23,7 +23,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/ifxmodem/audio-settings.c b/drivers/ifxmodem/audio-set=
tings.c
index ce31a06..e4657a0 100644
--- a/drivers/ifxmodem/audio-settings.c
+++ b/drivers/ifxmodem/audio-settings.c
@@ -23,7 +23,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/ifxmodem/ctm.c b/drivers/ifxmodem/ctm.c
index 827bf3b..f2fa59e 100644
--- a/drivers/ifxmodem/ctm.c
+++ b/drivers/ifxmodem/ctm.c
@@ -23,7 +23,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/ifxmodem/gprs-context.c b/drivers/ifxmodem/gprs-contex=
t.c
index 4cca265..3c46a13 100644
--- a/drivers/ifxmodem/gprs-context.c
+++ b/drivers/ifxmodem/gprs-context.c
@@ -23,7 +23,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/ifxmodem/radio-settings.c b/drivers/ifxmodem/radio-set=
tings.c
index e4a09f2..9cfb8fa 100644
--- a/drivers/ifxmodem/radio-settings.c
+++ b/drivers/ifxmodem/radio-settings.c
@@ -23,7 +23,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/ifxmodem/stk.c b/drivers/ifxmodem/stk.c
index 22aac62..4b3bb69 100644
--- a/drivers/ifxmodem/stk.c
+++ b/drivers/ifxmodem/stk.c
@@ -23,7 +23,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/ifxmodem/voicecall.c b/drivers/ifxmodem/voicecall.c
index 7c27642..d511e66 100644
--- a/drivers/ifxmodem/voicecall.c
+++ b/drivers/ifxmodem/voicecall.c
@@ -23,7 +23,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/isimodem/audio-settings.c b/drivers/isimodem/audio-set=
tings.c
index 3dc2796..98a87c6 100644
--- a/drivers/isimodem/audio-settings.c
+++ b/drivers/isimodem/audio-settings.c
@@ -23,7 +23,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/isimodem/call-barring.c b/drivers/isimodem/call-barrin=
g.c
index 833c5ce..c715bad 100644
--- a/drivers/isimodem/call-barring.c
+++ b/drivers/isimodem/call-barring.c
@@ -23,7 +23,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/drivers/isimodem/call-forwarding.c b/drivers/isimodem/call-for=
warding.c
index 6366c3f..e377120 100644
--- a/drivers/isimodem/call-forwarding.c
+++ b/drivers/isimodem/call-forwarding.c
@@ -23,7 +23,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/drivers/isimodem/call-meter.c b/drivers/isimodem/call-meter.c
index 3a558f6..60d798b 100644
--- a/drivers/isimodem/call-meter.c
+++ b/drivers/isimodem/call-meter.c
@@ -23,7 +23,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/drivers/isimodem/call-settings.c b/drivers/isimodem/call-setti=
ngs.c
index b4533bb..c6f5c17 100644
--- a/drivers/isimodem/call-settings.c
+++ b/drivers/isimodem/call-settings.c
@@ -23,7 +23,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/drivers/isimodem/cbs.c b/drivers/isimodem/cbs.c
index d102cdd..b3574f2 100644
--- a/drivers/isimodem/cbs.c
+++ b/drivers/isimodem/cbs.c
@@ -23,7 +23,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/drivers/isimodem/debug.c b/drivers/isimodem/debug.c
index a312c74..7c491b8 100644
--- a/drivers/isimodem/debug.c
+++ b/drivers/isimodem/debug.c
@@ -23,7 +23,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <stdio.h>
 #include <stdlib.h>
 #include <stdint.h>
diff --git a/drivers/isimodem/devinfo.c b/drivers/isimodem/devinfo.c
index 3a59b35..d813e81 100644
--- a/drivers/isimodem/devinfo.c
+++ b/drivers/isimodem/devinfo.c
@@ -23,7 +23,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/drivers/isimodem/gprs-context.c b/drivers/isimodem/gprs-contex=
t.c
index ce53d02..847ace6 100644
--- a/drivers/isimodem/gprs-context.c
+++ b/drivers/isimodem/gprs-context.c
@@ -23,7 +23,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/isimodem/gprs.c b/drivers/isimodem/gprs.c
index 2d64bf1..bcc9d8b 100644
--- a/drivers/isimodem/gprs.c
+++ b/drivers/isimodem/gprs.c
@@ -23,7 +23,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/drivers/isimodem/network-registration.c b/drivers/isimodem/net=
work-registration.c
index 922eb9e..9cadfd7 100644
--- a/drivers/isimodem/network-registration.c
+++ b/drivers/isimodem/network-registration.c
@@ -23,7 +23,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/drivers/isimodem/radio-settings.c b/drivers/isimodem/radio-set=
tings.c
index 2c4989c..199da11 100644
--- a/drivers/isimodem/radio-settings.c
+++ b/drivers/isimodem/radio-settings.c
@@ -23,7 +23,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/drivers/isimodem/sim.c b/drivers/isimodem/sim.c
index 74c6b0d..43642d5 100644
--- a/drivers/isimodem/sim.c
+++ b/drivers/isimodem/sim.c
@@ -23,7 +23,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/drivers/isimodem/sms.c b/drivers/isimodem/sms.c
index 4caccc8..940726e 100644
--- a/drivers/isimodem/sms.c
+++ b/drivers/isimodem/sms.c
@@ -24,7 +24,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/drivers/isimodem/uicc-util.c b/drivers/isimodem/uicc-util.c
index f04ca5a..8ac36c9 100644
--- a/drivers/isimodem/uicc-util.c
+++ b/drivers/isimodem/uicc-util.c
@@ -24,7 +24,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/drivers/isimodem/uicc.c b/drivers/isimodem/uicc.c
index 0a5121d..214b550 100644
--- a/drivers/isimodem/uicc.c
+++ b/drivers/isimodem/uicc.c
@@ -24,7 +24,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/drivers/isimodem/ussd.c b/drivers/isimodem/ussd.c
index 71f246d..28cc2f6 100644
--- a/drivers/isimodem/ussd.c
+++ b/drivers/isimodem/ussd.c
@@ -23,7 +23,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/drivers/isimodem/voicecall.c b/drivers/isimodem/voicecall.c
index 460e34e..eb52fc5 100644
--- a/drivers/isimodem/voicecall.c
+++ b/drivers/isimodem/voicecall.c
@@ -23,7 +23,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/drivers/mbmmodem/gprs-context.c b/drivers/mbmmodem/gprs-contex=
t.c
index e961afa..428f7c8 100644
--- a/drivers/mbmmodem/gprs-context.c
+++ b/drivers/mbmmodem/gprs-context.c
@@ -23,7 +23,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/mbmmodem/location-reporting.c b/drivers/mbmmodem/locat=
ion-reporting.c
index 7c50ac2..32dc24f 100644
--- a/drivers/mbmmodem/location-reporting.c
+++ b/drivers/mbmmodem/location-reporting.c
@@ -24,7 +24,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/mbmmodem/stk.c b/drivers/mbmmodem/stk.c
index e33c91b..0252f97 100644
--- a/drivers/mbmmodem/stk.c
+++ b/drivers/mbmmodem/stk.c
@@ -23,7 +23,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/nwmodem/radio-settings.c b/drivers/nwmodem/radio-setti=
ngs.c
index e43504a..c60445e 100644
--- a/drivers/nwmodem/radio-settings.c
+++ b/drivers/nwmodem/radio-settings.c
@@ -23,7 +23,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/qmimodem/location-reporting.c b/drivers/qmimodem/locat=
ion-reporting.c
index e4ce233..fe22dfd 100644
--- a/drivers/qmimodem/location-reporting.c
+++ b/drivers/qmimodem/location-reporting.c
@@ -23,7 +23,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <fcntl.h>
 #include <unistd.h>
 =

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 3389bb1..a7d4d34 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -23,7 +23,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <stdio.h>
 #include <ctype.h>
 #include <fcntl.h>
diff --git a/drivers/rilmodem/call-forwarding.c b/drivers/rilmodem/call-for=
warding.c
index 1fcedb3..fcab63a 100644
--- a/drivers/rilmodem/call-forwarding.c
+++ b/drivers/rilmodem/call-forwarding.c
@@ -25,7 +25,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/drivers/rilmodem/call-settings.c b/drivers/rilmodem/call-setti=
ngs.c
index 3d10bc0..3ee63fd 100644
--- a/drivers/rilmodem/call-settings.c
+++ b/drivers/rilmodem/call-settings.c
@@ -26,7 +26,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/drivers/rilmodem/call-volume.c b/drivers/rilmodem/call-volume.c
index 2bf0c5f..6585834 100644
--- a/drivers/rilmodem/call-volume.c
+++ b/drivers/rilmodem/call-volume.c
@@ -24,7 +24,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <string.h>
 #include <stdio.h>
 #include <errno.h>
diff --git a/drivers/rilmodem/devinfo.c b/drivers/rilmodem/devinfo.c
index bb1e642..a742f31 100644
--- a/drivers/rilmodem/devinfo.c
+++ b/drivers/rilmodem/devinfo.c
@@ -24,7 +24,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/drivers/rilmodem/gprs-context.c b/drivers/rilmodem/gprs-contex=
t.c
index 2021533..0a8e59a 100644
--- a/drivers/rilmodem/gprs-context.c
+++ b/drivers/rilmodem/gprs-context.c
@@ -24,7 +24,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/rilmodem/gprs.c b/drivers/rilmodem/gprs.c
index 75dcfcc..f0b97fb 100644
--- a/drivers/rilmodem/gprs.c
+++ b/drivers/rilmodem/gprs.c
@@ -26,7 +26,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/rilmodem/network-registration.c b/drivers/rilmodem/net=
work-registration.c
index 6808a29..cc762df 100644
--- a/drivers/rilmodem/network-registration.c
+++ b/drivers/rilmodem/network-registration.c
@@ -26,7 +26,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/rilmodem/phonebook.c b/drivers/rilmodem/phonebook.c
index c3f1c0b..528aebf 100644
--- a/drivers/rilmodem/phonebook.c
+++ b/drivers/rilmodem/phonebook.c
@@ -27,7 +27,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/drivers/rilmodem/radio-settings.c b/drivers/rilmodem/radio-set=
tings.c
index 90b49c6..713e007 100644
--- a/drivers/rilmodem/radio-settings.c
+++ b/drivers/rilmodem/radio-settings.c
@@ -25,7 +25,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/drivers/rilmodem/sim.c b/drivers/rilmodem/sim.c
index f71bd0a..fcec19e 100644
--- a/drivers/rilmodem/sim.c
+++ b/drivers/rilmodem/sim.c
@@ -25,7 +25,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/rilmodem/sms.c b/drivers/rilmodem/sms.c
index 3eedadd..271f8fd 100644
--- a/drivers/rilmodem/sms.c
+++ b/drivers/rilmodem/sms.c
@@ -25,7 +25,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <ctype.h>
 #include <string.h>
 #include <stdlib.h>
diff --git a/drivers/rilmodem/ussd.c b/drivers/rilmodem/ussd.c
index 9e9b0ff..f6b70d0 100644
--- a/drivers/rilmodem/ussd.c
+++ b/drivers/rilmodem/ussd.c
@@ -24,7 +24,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/drivers/rilmodem/voicecall.c b/drivers/rilmodem/voicecall.c
index 3fa4b37..b56d66c 100644
--- a/drivers/rilmodem/voicecall.c
+++ b/drivers/rilmodem/voicecall.c
@@ -25,7 +25,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/stemodem/gprs-context.c b/drivers/stemodem/gprs-contex=
t.c
index 18b2bfa..ded857d 100644
--- a/drivers/stemodem/gprs-context.c
+++ b/drivers/stemodem/gprs-context.c
@@ -24,7 +24,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/stemodem/radio-settings.c b/drivers/stemodem/radio-set=
tings.c
index 15d09b7..96afb6f 100644
--- a/drivers/stemodem/radio-settings.c
+++ b/drivers/stemodem/radio-settings.c
@@ -24,7 +24,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/stemodem/voicecall.c b/drivers/stemodem/voicecall.c
index 1cbf51a..311f073 100644
--- a/drivers/stemodem/voicecall.c
+++ b/drivers/stemodem/voicecall.c
@@ -24,7 +24,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/swmodem/gprs-context.c b/drivers/swmodem/gprs-context.c
index 1506ed1..b4be614 100644
--- a/drivers/swmodem/gprs-context.c
+++ b/drivers/swmodem/gprs-context.c
@@ -23,7 +23,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/telitmodem/location-reporting.c b/drivers/telitmodem/l=
ocation-reporting.c
index d16c58f..28c7cd8 100644
--- a/drivers/telitmodem/location-reporting.c
+++ b/drivers/telitmodem/location-reporting.c
@@ -23,7 +23,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/ztemodem/radio-settings.c b/drivers/ztemodem/radio-set=
tings.c
index d303af0..9557fe6 100644
--- a/drivers/ztemodem/radio-settings.c
+++ b/drivers/ztemodem/radio-settings.c
@@ -23,7 +23,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/gisi/client.c b/gisi/client.c
index 7512441..d958af7 100644
--- a/gisi/client.c
+++ b/gisi/client.c
@@ -23,7 +23,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <stdint.h>
 #include <string.h>
 #include <stdlib.h>
diff --git a/gisi/modem.c b/gisi/modem.c
index aee24af..36e58da 100644
--- a/gisi/modem.c
+++ b/gisi/modem.c
@@ -23,7 +23,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <stdint.h>
 #include <string.h>
 #include <sys/types.h>
diff --git a/gril/parcel.c b/gril/parcel.c
index 1cd8c8e..69a5184 100644
--- a/gril/parcel.c
+++ b/gril/parcel.c
@@ -24,7 +24,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/src/call-volume.c b/src/call-volume.c
index ddb8b77..9ae82ef 100644
--- a/src/call-volume.c
+++ b/src/call-volume.c
@@ -23,7 +23,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/src/cdma-smsutil.c b/src/cdma-smsutil.c
index e36f2e3..807f2f8 100644
--- a/src/cdma-smsutil.c
+++ b/src/cdma-smsutil.c
@@ -23,7 +23,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <string.h>
 #include <dirent.h>
 #include <sys/types.h>
diff --git a/src/common.c b/src/common.c
index 17d1d58..7d5b78e 100644
--- a/src/common.c
+++ b/src/common.c
@@ -23,7 +23,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <string.h>
 #include <errno.h>
 =

diff --git a/src/gnss.c b/src/gnss.c
index 97d1152..ece9594 100644
--- a/src/gnss.c
+++ b/src/gnss.c
@@ -24,7 +24,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <string.h>
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/src/gnssagent.c b/src/gnssagent.c
index 56d00f9..049dc46 100644
--- a/src/gnssagent.c
+++ b/src/gnssagent.c
@@ -24,7 +24,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <stdint.h>
 #include <string.h>
 #include <errno.h>
diff --git a/src/handsfree.c b/src/handsfree.c
index 31b9d7d..1974b63 100644
--- a/src/handsfree.c
+++ b/src/handsfree.c
@@ -24,7 +24,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/src/idmap.c b/src/idmap.c
index c097eb4..ccc9cb5 100644
--- a/src/idmap.c
+++ b/src/idmap.c
@@ -24,7 +24,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <string.h>
 =

 #include <glib.h>
diff --git a/src/log.c b/src/log.c
index 0d55d6e..22b4596 100644
--- a/src/log.c
+++ b/src/log.c
@@ -23,7 +23,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <stdio.h>
 #include <unistd.h>
 #include <stdarg.h>
diff --git a/src/phonebook.c b/src/phonebook.c
index 531b5a6..d50ee9a 100644
--- a/src/phonebook.c
+++ b/src/phonebook.c
@@ -23,7 +23,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <string.h>
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/src/sim-auth.c b/src/sim-auth.c
index 5d2f075..c7e97f5 100644
--- a/src/sim-auth.c
+++ b/src/sim-auth.c
@@ -23,7 +23,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 =

 #include <glib.h>
 #include <errno.h>
diff --git a/src/sim.c b/src/sim.c
index 7614b33..c77c0a3 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -23,7 +23,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <string.h>
 #include <stdio.h>
 #include <stdint.h>
diff --git a/src/simfs.c b/src/simfs.c
index 03c8c9e..ab32969 100644
--- a/src/simfs.c
+++ b/src/simfs.c
@@ -23,7 +23,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <string.h>
 #include <stdio.h>
 =

diff --git a/src/siri.c b/src/siri.c
index 649518f..9ab73cf 100644
--- a/src/siri.c
+++ b/src/siri.c
@@ -23,7 +23,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/src/smsagent.c b/src/smsagent.c
index 68ca54e..b999055 100644
--- a/src/smsagent.c
+++ b/src/smsagent.c
@@ -23,7 +23,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <stdint.h>
 #include <string.h>
 #include <errno.h>
diff --git a/src/smsutil.c b/src/smsutil.c
index 19e2016..eaf99cc 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -23,7 +23,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/src/stk.c b/src/stk.c
index 01c95b5..ddedb89 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -23,7 +23,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <string.h>
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/src/stkagent.c b/src/stkagent.c
index 4bd39b8..210b03c 100644
--- a/src/stkagent.c
+++ b/src/stkagent.c
@@ -23,7 +23,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <stdint.h>
 #include <string.h>
 #include <errno.h>
diff --git a/src/storage.c b/src/storage.c
index bde0bea..64694d1 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -23,7 +23,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <string.h>
 #include <stdarg.h>
 #include <sys/types.h>
diff --git a/src/ussd.c b/src/ussd.c
index bc8e0f6..cf944b0 100644
--- a/src/ussd.c
+++ b/src/ussd.c
@@ -23,7 +23,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <string.h>
 #include <stdio.h>
 #include <errno.h>
diff --git a/tools/tty-redirector.c b/tools/tty-redirector.c
index b015a25..59e0dc4 100644
--- a/tools/tty-redirector.c
+++ b/tools/tty-redirector.c
@@ -23,7 +23,9 @@
 #include <config.h>
 #endif
 =

+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <stdio.h>
 #include <fcntl.h>
 #include <unistd.h>
-- =

2.6.2


--===============6121854896248467635==--

