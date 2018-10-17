Content-Type: multipart/mixed; boundary="===============3535978341727894124=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH 1/1] Remove superfluous definitions of _GNU_SOURCE
Date: Wed, 17 Oct 2018 12:23:04 +0200
Message-ID: <20181017102304.5857-1-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3535978341727894124==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There are a large number of files in the tree that define _GNU_SOURCE
despite not actually using features hidden behind this flag.  This patch
removes all these definitions in one fell swoop...
---

I realize that it's not quite kosher in ofono to send pathes that touch
more than directory.  Breaking this up into separate patches doesn't
really make sense though, given its nature.  If the list insists,
though, I can break this up into a series of ~50 patches...

/Jonas

 drivers/atmodem/call-barring.c            | 1 -
 drivers/atmodem/call-forwarding.c         | 1 -
 drivers/atmodem/call-meter.c              | 1 -
 drivers/atmodem/call-settings.c           | 1 -
 drivers/atmodem/call-volume.c             | 1 -
 drivers/atmodem/cbs.c                     | 1 -
 drivers/atmodem/gnss.c                    | 1 -
 drivers/atmodem/gprs-context.c            | 1 -
 drivers/atmodem/gprs.c                    | 1 -
 drivers/atmodem/lte.c                     | 1 -
 drivers/atmodem/network-registration.c    | 1 -
 drivers/atmodem/phonebook.c               | 1 -
 drivers/atmodem/sim.c                     | 1 -
 drivers/atmodem/sms.c                     | 1 -
 drivers/atmodem/stk.c                     | 1 -
 drivers/atmodem/ussd.c                    | 1 -
 drivers/atmodem/voicecall.c               | 1 -
 drivers/calypsomodem/stk.c                | 1 -
 drivers/calypsomodem/voicecall.c          | 1 -
 drivers/cdmamodem/connman.c               | 1 -
 drivers/cdmamodem/voicecall.c             | 1 -
 drivers/gemaltomodem/location-reporting.c | 1 -
 drivers/hfpmodem/call-volume.c            | 1 -
 drivers/hfpmodem/handsfree.c              | 1 -
 drivers/hfpmodem/network-registration.c   | 1 -
 drivers/hfpmodem/siri.c                   | 1 -
 drivers/hfpmodem/slc.c                    | 1 -
 drivers/hfpmodem/voicecall.c              | 1 -
 drivers/hsomodem/gprs-context.c           | 1 -
 drivers/hsomodem/radio-settings.c         | 1 -
 drivers/huaweimodem/audio-settings.c      | 1 -
 drivers/huaweimodem/cdma-netreg.c         | 1 -
 drivers/huaweimodem/gprs-context.c        | 1 -
 drivers/huaweimodem/radio-settings.c      | 1 -
 drivers/huaweimodem/voicecall.c           | 1 -
 drivers/iceramodem/gprs-context.c         | 1 -
 drivers/iceramodem/radio-settings.c       | 1 -
 drivers/ifxmodem/audio-settings.c         | 1 -
 drivers/ifxmodem/ctm.c                    | 1 -
 drivers/ifxmodem/gprs-context.c           | 1 -
 drivers/ifxmodem/radio-settings.c         | 1 -
 drivers/ifxmodem/stk.c                    | 1 -
 drivers/ifxmodem/voicecall.c              | 1 -
 drivers/isimodem/audio-settings.c         | 1 -
 drivers/isimodem/call-barring.c           | 1 -
 drivers/isimodem/call-forwarding.c        | 1 -
 drivers/isimodem/call-meter.c             | 1 -
 drivers/isimodem/call-settings.c          | 1 -
 drivers/isimodem/cbs.c                    | 1 -
 drivers/isimodem/debug.c                  | 1 -
 drivers/isimodem/devinfo.c                | 1 -
 drivers/isimodem/gprs-context.c           | 1 -
 drivers/isimodem/gprs.c                   | 1 -
 drivers/isimodem/network-registration.c   | 1 -
 drivers/isimodem/radio-settings.c         | 1 -
 drivers/isimodem/sim.c                    | 1 -
 drivers/isimodem/sms.c                    | 1 -
 drivers/isimodem/uicc-util.c              | 1 -
 drivers/isimodem/uicc.c                   | 1 -
 drivers/isimodem/ussd.c                   | 1 -
 drivers/isimodem/voicecall.c              | 1 -
 drivers/mbimmodem/gprs-context.c          | 1 -
 drivers/mbimmodem/gprs.c                  | 1 -
 drivers/mbimmodem/mbim.c                  | 1 -
 drivers/mbimmodem/network-registration.c  | 1 -
 drivers/mbimmodem/sms.c                   | 1 -
 drivers/mbmmodem/gprs-context.c           | 1 -
 drivers/mbmmodem/location-reporting.c     | 1 -
 drivers/mbmmodem/stk.c                    | 1 -
 drivers/nwmodem/radio-settings.c          | 1 -
 drivers/qmimodem/lte.c                    | 1 -
 drivers/qmimodem/netmon.c                 | 1 -
 drivers/qmimodem/ussd.c                   | 1 -
 drivers/rilmodem/call-forwarding.c        | 1 -
 drivers/rilmodem/call-settings.c          | 1 -
 drivers/rilmodem/call-volume.c            | 1 -
 drivers/rilmodem/cbs.c                    | 1 -
 drivers/rilmodem/devinfo.c                | 1 -
 drivers/rilmodem/gprs-context.c           | 1 -
 drivers/rilmodem/gprs.c                   | 1 -
 drivers/rilmodem/lte.c                    | 1 -
 drivers/rilmodem/netmon.c                 | 1 -
 drivers/rilmodem/network-registration.c   | 1 -
 drivers/rilmodem/phonebook.c              | 1 -
 drivers/rilmodem/radio-settings.c         | 1 -
 drivers/rilmodem/sim.c                    | 1 -
 drivers/rilmodem/sms.c                    | 1 -
 drivers/rilmodem/stk.c                    | 1 -
 drivers/rilmodem/ussd.c                   | 1 -
 drivers/rilmodem/voicecall.c              | 1 -
 drivers/stemodem/gprs-context.c           | 1 -
 drivers/stemodem/radio-settings.c         | 1 -
 drivers/stemodem/voicecall.c              | 1 -
 drivers/swmodem/gprs-context.c            | 1 -
 drivers/telitmodem/gprs-context-ncm.c     | 1 -
 drivers/telitmodem/location-reporting.c   | 1 -
 drivers/ubloxmodem/gprs-context.c         | 1 -
 drivers/ubloxmodem/lte.c                  | 1 -
 drivers/ubloxmodem/netmon.c               | 1 -
 drivers/xmm7modem/ims.c                   | 1 -
 drivers/xmm7modem/netmon.c                | 1 -
 drivers/xmm7modem/radio-settings.c        | 1 -
 drivers/ztemodem/radio-settings.c         | 1 -
 gisi/client.c                             | 1 -
 gisi/modem.c                              | 1 -
 gril/parcel.c                             | 1 -
 plugins/gobi.c                            | 1 -
 plugins/mbim.c                            | 1 -
 src/call-volume.c                         | 1 -
 src/cdma-smsutil.c                        | 1 -
 src/gnss.c                                | 1 -
 src/gnssagent.c                           | 1 -
 src/handsfree.c                           | 1 -
 src/idmap.c                               | 1 -
 src/netmonagent.c                         | 1 -
 src/phonebook.c                           | 1 -
 src/sim-auth.c                            | 1 -
 src/sim.c                                 | 1 -
 src/simfs.c                               | 1 -
 src/siri.c                                | 1 -
 src/smsagent.c                            | 1 -
 src/stk.c                                 | 1 -
 src/stkagent.c                            | 1 -
 src/storage.c                             | 1 -
 src/ussd.c                                | 1 -
 tools/tty-redirector.c                    | 1 -
 unit/rilmodem-test-engine.c               | 1 -
 unit/rilmodem-test-server.c               | 1 -
 unit/test-rilmodem-cb.c                   | 1 -
 unit/test-rilmodem-cs.c                   | 1 -
 unit/test-rilmodem-gprs.c                 | 1 -
 unit/test-rilmodem-sms.c                  | 1 -
 132 files changed, 132 deletions(-)

diff --git a/drivers/atmodem/call-barring.c b/drivers/atmodem/call-barring.c
index 1239d053..ab34638a 100644
--- a/drivers/atmodem/call-barring.c
+++ b/drivers/atmodem/call-barring.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/atmodem/call-forwarding.c b/drivers/atmodem/call-forwa=
rding.c
index e2020d36..764deb92 100644
--- a/drivers/atmodem/call-forwarding.c
+++ b/drivers/atmodem/call-forwarding.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/atmodem/call-meter.c b/drivers/atmodem/call-meter.c
index 430d5461..ef43ea28 100644
--- a/drivers/atmodem/call-meter.c
+++ b/drivers/atmodem/call-meter.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/atmodem/call-settings.c b/drivers/atmodem/call-setting=
s.c
index f017ab5c..994f528e 100644
--- a/drivers/atmodem/call-settings.c
+++ b/drivers/atmodem/call-settings.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/atmodem/call-volume.c b/drivers/atmodem/call-volume.c
index e2535b15..af3af319 100644
--- a/drivers/atmodem/call-volume.c
+++ b/drivers/atmodem/call-volume.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <string.h>
 #include <stdio.h>
 =

diff --git a/drivers/atmodem/cbs.c b/drivers/atmodem/cbs.c
index 1824b47d..2423ec1f 100644
--- a/drivers/atmodem/cbs.c
+++ b/drivers/atmodem/cbs.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <string.h>
 #include <stdio.h>
 =

diff --git a/drivers/atmodem/gnss.c b/drivers/atmodem/gnss.c
index 5d868dd3..447911bd 100644
--- a/drivers/atmodem/gnss.c
+++ b/drivers/atmodem/gnss.c
@@ -24,7 +24,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/atmodem/gprs-context.c b/drivers/atmodem/gprs-context.c
index 2212af69..c8841cf9 100644
--- a/drivers/atmodem/gprs-context.c
+++ b/drivers/atmodem/gprs-context.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/atmodem/gprs.c b/drivers/atmodem/gprs.c
index df37d05f..11e51906 100644
--- a/drivers/atmodem/gprs.c
+++ b/drivers/atmodem/gprs.c
@@ -24,7 +24,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/atmodem/lte.c b/drivers/atmodem/lte.c
index efa4e5fe..5a249a4a 100644
--- a/drivers/atmodem/lte.c
+++ b/drivers/atmodem/lte.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <stdlib.h>
 #include <stdio.h>
 #include <string.h>
diff --git a/drivers/atmodem/network-registration.c b/drivers/atmodem/netwo=
rk-registration.c
index 5440bde2..e8e4278d 100644
--- a/drivers/atmodem/network-registration.c
+++ b/drivers/atmodem/network-registration.c
@@ -24,7 +24,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/atmodem/phonebook.c b/drivers/atmodem/phonebook.c
index a43b8cc8..183eed15 100644
--- a/drivers/atmodem/phonebook.c
+++ b/drivers/atmodem/phonebook.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index 2ce72c83..8f47f4ac 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/atmodem/sms.c b/drivers/atmodem/sms.c
index 2c4920dc..c9c2378f 100644
--- a/drivers/atmodem/sms.c
+++ b/drivers/atmodem/sms.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/atmodem/stk.c b/drivers/atmodem/stk.c
index b4fb2f24..08fb8b12 100644
--- a/drivers/atmodem/stk.c
+++ b/drivers/atmodem/stk.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/atmodem/ussd.c b/drivers/atmodem/ussd.c
index 2e45317d..cc17d0a9 100644
--- a/drivers/atmodem/ussd.c
+++ b/drivers/atmodem/ussd.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/atmodem/voicecall.c b/drivers/atmodem/voicecall.c
index aa56f1ee..03b69971 100644
--- a/drivers/atmodem/voicecall.c
+++ b/drivers/atmodem/voicecall.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/calypsomodem/stk.c b/drivers/calypsomodem/stk.c
index 9ac9d7c4..1eeb3a2d 100644
--- a/drivers/calypsomodem/stk.c
+++ b/drivers/calypsomodem/stk.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/calypsomodem/voicecall.c b/drivers/calypsomodem/voicec=
all.c
index 3c047b78..62f973fe 100644
--- a/drivers/calypsomodem/voicecall.c
+++ b/drivers/calypsomodem/voicecall.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/cdmamodem/connman.c b/drivers/cdmamodem/connman.c
index 7f0f54b6..ddb586a2 100644
--- a/drivers/cdmamodem/connman.c
+++ b/drivers/cdmamodem/connman.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/cdmamodem/voicecall.c b/drivers/cdmamodem/voicecall.c
index 98cf5543..0f1359d1 100644
--- a/drivers/cdmamodem/voicecall.c
+++ b/drivers/cdmamodem/voicecall.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/gemaltomodem/location-reporting.c b/drivers/gemaltomod=
em/location-reporting.c
index bcfe00e5..66296cb4 100644
--- a/drivers/gemaltomodem/location-reporting.c
+++ b/drivers/gemaltomodem/location-reporting.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/hfpmodem/call-volume.c b/drivers/hfpmodem/call-volume.c
index 0d7431e2..1077ffcd 100644
--- a/drivers/hfpmodem/call-volume.c
+++ b/drivers/hfpmodem/call-volume.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/hfpmodem/handsfree.c b/drivers/hfpmodem/handsfree.c
index 6e8c4d30..1be18ca5 100644
--- a/drivers/hfpmodem/handsfree.c
+++ b/drivers/hfpmodem/handsfree.c
@@ -24,7 +24,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/hfpmodem/network-registration.c b/drivers/hfpmodem/net=
work-registration.c
index 22ce664a..f8be64a9 100644
--- a/drivers/hfpmodem/network-registration.c
+++ b/drivers/hfpmodem/network-registration.c
@@ -24,7 +24,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/hfpmodem/siri.c b/drivers/hfpmodem/siri.c
index 6106ef86..08ffefa7 100644
--- a/drivers/hfpmodem/siri.c
+++ b/drivers/hfpmodem/siri.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/hfpmodem/slc.c b/drivers/hfpmodem/slc.c
index 8e625191..0db0fb32 100644
--- a/drivers/hfpmodem/slc.c
+++ b/drivers/hfpmodem/slc.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <stdio.h>
 #include <string.h>
 #include <errno.h>
diff --git a/drivers/hfpmodem/voicecall.c b/drivers/hfpmodem/voicecall.c
index 6ffe9d52..c93b10c3 100644
--- a/drivers/hfpmodem/voicecall.c
+++ b/drivers/hfpmodem/voicecall.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/hsomodem/gprs-context.c b/drivers/hsomodem/gprs-contex=
t.c
index ce8d21c2..062975ad 100644
--- a/drivers/hsomodem/gprs-context.c
+++ b/drivers/hsomodem/gprs-context.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/hsomodem/radio-settings.c b/drivers/hsomodem/radio-set=
tings.c
index e3d87f32..8c0b88bc 100644
--- a/drivers/hsomodem/radio-settings.c
+++ b/drivers/hsomodem/radio-settings.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/huaweimodem/audio-settings.c b/drivers/huaweimodem/aud=
io-settings.c
index 1d4e903a..eb9813a9 100644
--- a/drivers/huaweimodem/audio-settings.c
+++ b/drivers/huaweimodem/audio-settings.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/huaweimodem/cdma-netreg.c b/drivers/huaweimodem/cdma-n=
etreg.c
index 2ae66e17..2ed344df 100644
--- a/drivers/huaweimodem/cdma-netreg.c
+++ b/drivers/huaweimodem/cdma-netreg.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <glib.h>
 #include <errno.h>
 =

diff --git a/drivers/huaweimodem/gprs-context.c b/drivers/huaweimodem/gprs-=
context.c
index dda5e32d..721563de 100644
--- a/drivers/huaweimodem/gprs-context.c
+++ b/drivers/huaweimodem/gprs-context.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/huaweimodem/radio-settings.c b/drivers/huaweimodem/rad=
io-settings.c
index 65bae527..06109cd3 100644
--- a/drivers/huaweimodem/radio-settings.c
+++ b/drivers/huaweimodem/radio-settings.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/huaweimodem/voicecall.c b/drivers/huaweimodem/voicecal=
l.c
index f55568d3..e2ff63f7 100644
--- a/drivers/huaweimodem/voicecall.c
+++ b/drivers/huaweimodem/voicecall.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/iceramodem/gprs-context.c b/drivers/iceramodem/gprs-co=
ntext.c
index 5f3ff304..5e305f72 100644
--- a/drivers/iceramodem/gprs-context.c
+++ b/drivers/iceramodem/gprs-context.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/iceramodem/radio-settings.c b/drivers/iceramodem/radio=
-settings.c
index d76e5458..cc9d5fa0 100644
--- a/drivers/iceramodem/radio-settings.c
+++ b/drivers/iceramodem/radio-settings.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/ifxmodem/audio-settings.c b/drivers/ifxmodem/audio-set=
tings.c
index ce31a067..45aeef46 100644
--- a/drivers/ifxmodem/audio-settings.c
+++ b/drivers/ifxmodem/audio-settings.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/ifxmodem/ctm.c b/drivers/ifxmodem/ctm.c
index 827bf3b1..ec4b7a79 100644
--- a/drivers/ifxmodem/ctm.c
+++ b/drivers/ifxmodem/ctm.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/ifxmodem/gprs-context.c b/drivers/ifxmodem/gprs-contex=
t.c
index 289b4341..855e935e 100644
--- a/drivers/ifxmodem/gprs-context.c
+++ b/drivers/ifxmodem/gprs-context.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/ifxmodem/radio-settings.c b/drivers/ifxmodem/radio-set=
tings.c
index e4a09f2a..d5fa3f63 100644
--- a/drivers/ifxmodem/radio-settings.c
+++ b/drivers/ifxmodem/radio-settings.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/ifxmodem/stk.c b/drivers/ifxmodem/stk.c
index 22aac622..ea00bf92 100644
--- a/drivers/ifxmodem/stk.c
+++ b/drivers/ifxmodem/stk.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/ifxmodem/voicecall.c b/drivers/ifxmodem/voicecall.c
index 45b5ca42..51e3cc46 100644
--- a/drivers/ifxmodem/voicecall.c
+++ b/drivers/ifxmodem/voicecall.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/isimodem/audio-settings.c b/drivers/isimodem/audio-set=
tings.c
index 3dc27966..b517925c 100644
--- a/drivers/isimodem/audio-settings.c
+++ b/drivers/isimodem/audio-settings.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/isimodem/call-barring.c b/drivers/isimodem/call-barrin=
g.c
index 833c5ce4..ab8b5fc9 100644
--- a/drivers/isimodem/call-barring.c
+++ b/drivers/isimodem/call-barring.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/drivers/isimodem/call-forwarding.c b/drivers/isimodem/call-for=
warding.c
index 6366c3f2..366aa11e 100644
--- a/drivers/isimodem/call-forwarding.c
+++ b/drivers/isimodem/call-forwarding.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/drivers/isimodem/call-meter.c b/drivers/isimodem/call-meter.c
index 3a558f6b..8196b737 100644
--- a/drivers/isimodem/call-meter.c
+++ b/drivers/isimodem/call-meter.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/drivers/isimodem/call-settings.c b/drivers/isimodem/call-setti=
ngs.c
index b4533bbb..231e3186 100644
--- a/drivers/isimodem/call-settings.c
+++ b/drivers/isimodem/call-settings.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/drivers/isimodem/cbs.c b/drivers/isimodem/cbs.c
index d102cddd..6b4ab169 100644
--- a/drivers/isimodem/cbs.c
+++ b/drivers/isimodem/cbs.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/drivers/isimodem/debug.c b/drivers/isimodem/debug.c
index a312c745..18055791 100644
--- a/drivers/isimodem/debug.c
+++ b/drivers/isimodem/debug.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
 #include <stdint.h>
diff --git a/drivers/isimodem/devinfo.c b/drivers/isimodem/devinfo.c
index 3a59b358..65dd98cd 100644
--- a/drivers/isimodem/devinfo.c
+++ b/drivers/isimodem/devinfo.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/drivers/isimodem/gprs-context.c b/drivers/isimodem/gprs-contex=
t.c
index 4d2e7a12..c89ccbcd 100644
--- a/drivers/isimodem/gprs-context.c
+++ b/drivers/isimodem/gprs-context.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/isimodem/gprs.c b/drivers/isimodem/gprs.c
index 2d64bf1f..da33472b 100644
--- a/drivers/isimodem/gprs.c
+++ b/drivers/isimodem/gprs.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/drivers/isimodem/network-registration.c b/drivers/isimodem/net=
work-registration.c
index 922eb9e0..b1e5f25e 100644
--- a/drivers/isimodem/network-registration.c
+++ b/drivers/isimodem/network-registration.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/drivers/isimodem/radio-settings.c b/drivers/isimodem/radio-set=
tings.c
index 2c4989c6..051cf1b0 100644
--- a/drivers/isimodem/radio-settings.c
+++ b/drivers/isimodem/radio-settings.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/drivers/isimodem/sim.c b/drivers/isimodem/sim.c
index 9e86d870..1dbffb97 100644
--- a/drivers/isimodem/sim.c
+++ b/drivers/isimodem/sim.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/drivers/isimodem/sms.c b/drivers/isimodem/sms.c
index 4caccc8f..85523232 100644
--- a/drivers/isimodem/sms.c
+++ b/drivers/isimodem/sms.c
@@ -24,7 +24,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/drivers/isimodem/uicc-util.c b/drivers/isimodem/uicc-util.c
index f04ca5aa..d7e6b52b 100644
--- a/drivers/isimodem/uicc-util.c
+++ b/drivers/isimodem/uicc-util.c
@@ -24,7 +24,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/drivers/isimodem/uicc.c b/drivers/isimodem/uicc.c
index 621ec7da..e7457447 100644
--- a/drivers/isimodem/uicc.c
+++ b/drivers/isimodem/uicc.c
@@ -24,7 +24,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/drivers/isimodem/ussd.c b/drivers/isimodem/ussd.c
index 71f246d0..1a93b92a 100644
--- a/drivers/isimodem/ussd.c
+++ b/drivers/isimodem/ussd.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/drivers/isimodem/voicecall.c b/drivers/isimodem/voicecall.c
index d6d4ea37..2110eb26 100644
--- a/drivers/isimodem/voicecall.c
+++ b/drivers/isimodem/voicecall.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/drivers/mbimmodem/gprs-context.c b/drivers/mbimmodem/gprs-cont=
ext.c
index a2c14d4e..ac5c1ed8 100644
--- a/drivers/mbimmodem/gprs-context.c
+++ b/drivers/mbimmodem/gprs-context.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <stdint.h>
 #include <stdbool.h>
 #include <errno.h>
diff --git a/drivers/mbimmodem/gprs.c b/drivers/mbimmodem/gprs.c
index 409668a4..d8aa5829 100644
--- a/drivers/mbimmodem/gprs.c
+++ b/drivers/mbimmodem/gprs.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <stdint.h>
 #include <stdbool.h>
 #include <inttypes.h>
diff --git a/drivers/mbimmodem/mbim.c b/drivers/mbimmodem/mbim.c
index 9fcf44b2..db21c87b 100644
--- a/drivers/mbimmodem/mbim.c
+++ b/drivers/mbimmodem/mbim.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <unistd.h>
 #include <limits.h>
 #include <errno.h>
diff --git a/drivers/mbimmodem/network-registration.c b/drivers/mbimmodem/n=
etwork-registration.c
index 6b82c6ff..fb400e73 100644
--- a/drivers/mbimmodem/network-registration.c
+++ b/drivers/mbimmodem/network-registration.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <stdbool.h>
 #include <stdint.h>
 #include <stdlib.h>
diff --git a/drivers/mbimmodem/sms.c b/drivers/mbimmodem/sms.c
index 0c3d75c5..e1d73e17 100644
--- a/drivers/mbimmodem/sms.c
+++ b/drivers/mbimmodem/sms.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <string.h>
 #include <errno.h>
 #include <stdint.h>
diff --git a/drivers/mbmmodem/gprs-context.c b/drivers/mbmmodem/gprs-contex=
t.c
index e961afa1..6f2ffa34 100644
--- a/drivers/mbmmodem/gprs-context.c
+++ b/drivers/mbmmodem/gprs-context.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/mbmmodem/location-reporting.c b/drivers/mbmmodem/locat=
ion-reporting.c
index 7c50ac2d..7270253f 100644
--- a/drivers/mbmmodem/location-reporting.c
+++ b/drivers/mbmmodem/location-reporting.c
@@ -24,7 +24,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/mbmmodem/stk.c b/drivers/mbmmodem/stk.c
index e33c91b4..89b246cd 100644
--- a/drivers/mbmmodem/stk.c
+++ b/drivers/mbmmodem/stk.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/nwmodem/radio-settings.c b/drivers/nwmodem/radio-setti=
ngs.c
index e43504ab..be06d952 100644
--- a/drivers/nwmodem/radio-settings.c
+++ b/drivers/nwmodem/radio-settings.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/qmimodem/lte.c b/drivers/qmimodem/lte.c
index 841e7751..c67f0887 100644
--- a/drivers/qmimodem/lte.c
+++ b/drivers/qmimodem/lte.c
@@ -24,7 +24,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <stdlib.h>
 #include <stdio.h>
 #include <string.h>
diff --git a/drivers/qmimodem/netmon.c b/drivers/qmimodem/netmon.c
index 6ef5d09c..58edb676 100644
--- a/drivers/qmimodem/netmon.c
+++ b/drivers/qmimodem/netmon.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
 #include <stdint.h>
diff --git a/drivers/qmimodem/ussd.c b/drivers/qmimodem/ussd.c
index 174e354d..bb9fc522 100644
--- a/drivers/qmimodem/ussd.c
+++ b/drivers/qmimodem/ussd.c
@@ -24,7 +24,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <string.h>
 =

 #include <glib.h>
diff --git a/drivers/rilmodem/call-forwarding.c b/drivers/rilmodem/call-for=
warding.c
index 4aff4d33..b186a720 100644
--- a/drivers/rilmodem/call-forwarding.c
+++ b/drivers/rilmodem/call-forwarding.c
@@ -25,7 +25,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/drivers/rilmodem/call-settings.c b/drivers/rilmodem/call-setti=
ngs.c
index 3d10bc04..6aaa3984 100644
--- a/drivers/rilmodem/call-settings.c
+++ b/drivers/rilmodem/call-settings.c
@@ -26,7 +26,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/drivers/rilmodem/call-volume.c b/drivers/rilmodem/call-volume.c
index 2bf0c5f2..e9cb9cfe 100644
--- a/drivers/rilmodem/call-volume.c
+++ b/drivers/rilmodem/call-volume.c
@@ -24,7 +24,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <string.h>
 #include <stdio.h>
 #include <errno.h>
diff --git a/drivers/rilmodem/cbs.c b/drivers/rilmodem/cbs.c
index 6050f772..14d6bba3 100644
--- a/drivers/rilmodem/cbs.c
+++ b/drivers/rilmodem/cbs.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <string.h>
 #include <stdio.h>
 #include <ctype.h>
diff --git a/drivers/rilmodem/devinfo.c b/drivers/rilmodem/devinfo.c
index 24197628..84c7847d 100644
--- a/drivers/rilmodem/devinfo.c
+++ b/drivers/rilmodem/devinfo.c
@@ -24,7 +24,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/drivers/rilmodem/gprs-context.c b/drivers/rilmodem/gprs-contex=
t.c
index ef62cba9..ebc51a06 100644
--- a/drivers/rilmodem/gprs-context.c
+++ b/drivers/rilmodem/gprs-context.c
@@ -24,7 +24,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/rilmodem/gprs.c b/drivers/rilmodem/gprs.c
index 0ec9d5fc..668b3b47 100644
--- a/drivers/rilmodem/gprs.c
+++ b/drivers/rilmodem/gprs.c
@@ -26,7 +26,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/rilmodem/lte.c b/drivers/rilmodem/lte.c
index 1302a562..fb84d3d5 100644
--- a/drivers/rilmodem/lte.c
+++ b/drivers/rilmodem/lte.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/rilmodem/netmon.c b/drivers/rilmodem/netmon.c
index 709997c5..9c633f0f 100644
--- a/drivers/rilmodem/netmon.c
+++ b/drivers/rilmodem/netmon.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
 #include <stdint.h>
diff --git a/drivers/rilmodem/network-registration.c b/drivers/rilmodem/net=
work-registration.c
index 809b3bc8..bfca92a5 100644
--- a/drivers/rilmodem/network-registration.c
+++ b/drivers/rilmodem/network-registration.c
@@ -26,7 +26,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/rilmodem/phonebook.c b/drivers/rilmodem/phonebook.c
index c3f1c0b7..d82bb648 100644
--- a/drivers/rilmodem/phonebook.c
+++ b/drivers/rilmodem/phonebook.c
@@ -27,7 +27,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/drivers/rilmodem/radio-settings.c b/drivers/rilmodem/radio-set=
tings.c
index 36befcaf..cd7bb502 100644
--- a/drivers/rilmodem/radio-settings.c
+++ b/drivers/rilmodem/radio-settings.c
@@ -25,7 +25,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/drivers/rilmodem/sim.c b/drivers/rilmodem/sim.c
index ede319e7..fd686f58 100644
--- a/drivers/rilmodem/sim.c
+++ b/drivers/rilmodem/sim.c
@@ -25,7 +25,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/rilmodem/sms.c b/drivers/rilmodem/sms.c
index 4500bf61..8c16fab1 100644
--- a/drivers/rilmodem/sms.c
+++ b/drivers/rilmodem/sms.c
@@ -25,7 +25,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <ctype.h>
 #include <string.h>
 #include <stdlib.h>
diff --git a/drivers/rilmodem/stk.c b/drivers/rilmodem/stk.c
index bd9a6c88..013401e3 100644
--- a/drivers/rilmodem/stk.c
+++ b/drivers/rilmodem/stk.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <string.h>
 #include <stdio.h>
 =

diff --git a/drivers/rilmodem/ussd.c b/drivers/rilmodem/ussd.c
index 9e9b0ffb..099fe546 100644
--- a/drivers/rilmodem/ussd.c
+++ b/drivers/rilmodem/ussd.c
@@ -24,7 +24,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/drivers/rilmodem/voicecall.c b/drivers/rilmodem/voicecall.c
index b7180b90..010f7d4e 100644
--- a/drivers/rilmodem/voicecall.c
+++ b/drivers/rilmodem/voicecall.c
@@ -25,7 +25,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/stemodem/gprs-context.c b/drivers/stemodem/gprs-contex=
t.c
index 18b2bfa4..ee82919b 100644
--- a/drivers/stemodem/gprs-context.c
+++ b/drivers/stemodem/gprs-context.c
@@ -24,7 +24,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/stemodem/radio-settings.c b/drivers/stemodem/radio-set=
tings.c
index 15d09b70..5b007129 100644
--- a/drivers/stemodem/radio-settings.c
+++ b/drivers/stemodem/radio-settings.c
@@ -24,7 +24,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/stemodem/voicecall.c b/drivers/stemodem/voicecall.c
index 356ab7c6..4f684391 100644
--- a/drivers/stemodem/voicecall.c
+++ b/drivers/stemodem/voicecall.c
@@ -24,7 +24,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/swmodem/gprs-context.c b/drivers/swmodem/gprs-context.c
index 1506ed14..622b07b1 100644
--- a/drivers/swmodem/gprs-context.c
+++ b/drivers/swmodem/gprs-context.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/telitmodem/gprs-context-ncm.c b/drivers/telitmodem/gpr=
s-context-ncm.c
index 9c9b9500..ca63f760 100644
--- a/drivers/telitmodem/gprs-context-ncm.c
+++ b/drivers/telitmodem/gprs-context-ncm.c
@@ -19,7 +19,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/telitmodem/location-reporting.c b/drivers/telitmodem/l=
ocation-reporting.c
index d16c58f0..944af69c 100644
--- a/drivers/telitmodem/location-reporting.c
+++ b/drivers/telitmodem/location-reporting.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/ubloxmodem/gprs-context.c b/drivers/ubloxmodem/gprs-co=
ntext.c
index 7eb18f09..485148a4 100644
--- a/drivers/ubloxmodem/gprs-context.c
+++ b/drivers/ubloxmodem/gprs-context.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/ubloxmodem/lte.c b/drivers/ubloxmodem/lte.c
index e9cb82b0..a0e9582f 100644
--- a/drivers/ubloxmodem/lte.c
+++ b/drivers/ubloxmodem/lte.c
@@ -22,7 +22,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <stdlib.h>
 #include <stdio.h>
 #include <string.h>
diff --git a/drivers/ubloxmodem/netmon.c b/drivers/ubloxmodem/netmon.c
index 0749078f..edf3058c 100644
--- a/drivers/ubloxmodem/netmon.c
+++ b/drivers/ubloxmodem/netmon.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
 #include <stdint.h>
diff --git a/drivers/xmm7modem/ims.c b/drivers/xmm7modem/ims.c
index a86948f3..ee6495f6 100644
--- a/drivers/xmm7modem/ims.c
+++ b/drivers/xmm7modem/ims.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <stdlib.h>
 #include <stdio.h>
 #include <string.h>
diff --git a/drivers/xmm7modem/netmon.c b/drivers/xmm7modem/netmon.c
index 472e908c..3b84d534 100644
--- a/drivers/xmm7modem/netmon.c
+++ b/drivers/xmm7modem/netmon.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
 #include <stdint.h>
diff --git a/drivers/xmm7modem/radio-settings.c b/drivers/xmm7modem/radio-s=
ettings.c
index f22c388a..e068bb4c 100644
--- a/drivers/xmm7modem/radio-settings.c
+++ b/drivers/xmm7modem/radio-settings.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/drivers/ztemodem/radio-settings.c b/drivers/ztemodem/radio-set=
tings.c
index d303af0b..c01acbe5 100644
--- a/drivers/ztemodem/radio-settings.c
+++ b/drivers/ztemodem/radio-settings.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/gisi/client.c b/gisi/client.c
index 7512441f..32e2b1d5 100644
--- a/gisi/client.c
+++ b/gisi/client.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <stdint.h>
 #include <string.h>
 #include <stdlib.h>
diff --git a/gisi/modem.c b/gisi/modem.c
index aee24af6..ef0c0491 100644
--- a/gisi/modem.c
+++ b/gisi/modem.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <stdint.h>
 #include <string.h>
 #include <sys/types.h>
diff --git a/gril/parcel.c b/gril/parcel.c
index 1cfc68a5..eef1be36 100644
--- a/gril/parcel.c
+++ b/gril/parcel.c
@@ -24,7 +24,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/plugins/gobi.c b/plugins/gobi.c
index 85218913..9b5d7cff 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <unistd.h>
diff --git a/plugins/mbim.c b/plugins/mbim.c
index 87bb0233..3e131634 100644
--- a/plugins/mbim.c
+++ b/plugins/mbim.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <sys/types.h>
diff --git a/src/call-volume.c b/src/call-volume.c
index ddb8b773..8e8b6f1c 100644
--- a/src/call-volume.c
+++ b/src/call-volume.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/src/cdma-smsutil.c b/src/cdma-smsutil.c
index 35b77e0b..638e4b68 100644
--- a/src/cdma-smsutil.c
+++ b/src/cdma-smsutil.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <string.h>
 #include <dirent.h>
 #include <sys/types.h>
diff --git a/src/gnss.c b/src/gnss.c
index ba2a97b7..acb2336a 100644
--- a/src/gnss.c
+++ b/src/gnss.c
@@ -24,7 +24,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <string.h>
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/src/gnssagent.c b/src/gnssagent.c
index 56d00f9e..f370dec8 100644
--- a/src/gnssagent.c
+++ b/src/gnssagent.c
@@ -24,7 +24,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <stdint.h>
 #include <string.h>
 #include <errno.h>
diff --git a/src/handsfree.c b/src/handsfree.c
index 3b518fd9..921e0bd7 100644
--- a/src/handsfree.c
+++ b/src/handsfree.c
@@ -24,7 +24,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/src/idmap.c b/src/idmap.c
index da32d960..68047208 100644
--- a/src/idmap.c
+++ b/src/idmap.c
@@ -24,7 +24,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <string.h>
 =

 #include <glib.h>
diff --git a/src/netmonagent.c b/src/netmonagent.c
index dfe1d464..7262e072 100644
--- a/src/netmonagent.c
+++ b/src/netmonagent.c
@@ -2,7 +2,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <stdint.h>
 #include <string.h>
 #include <errno.h>
diff --git a/src/phonebook.c b/src/phonebook.c
index f8936c5f..9dfa8bec 100644
--- a/src/phonebook.c
+++ b/src/phonebook.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <string.h>
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/src/sim-auth.c b/src/sim-auth.c
index 8cbd01e1..0434350d 100644
--- a/src/sim-auth.c
+++ b/src/sim-auth.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 =

 #include <glib.h>
 #include <errno.h>
diff --git a/src/sim.c b/src/sim.c
index 6ef5881a..129ff5dd 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <string.h>
 #include <stdio.h>
 #include <stdint.h>
diff --git a/src/simfs.c b/src/simfs.c
index 439e62d0..0100d415 100644
--- a/src/simfs.c
+++ b/src/simfs.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <string.h>
 #include <stdio.h>
 =

diff --git a/src/siri.c b/src/siri.c
index 649518f5..88888dcf 100644
--- a/src/siri.c
+++ b/src/siri.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/src/smsagent.c b/src/smsagent.c
index 68ca54e7..08b5b34c 100644
--- a/src/smsagent.c
+++ b/src/smsagent.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <stdint.h>
 #include <string.h>
 #include <errno.h>
diff --git a/src/stk.c b/src/stk.c
index 9cdf2b1e..a9c73fc5 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <string.h>
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/src/stkagent.c b/src/stkagent.c
index 4bd39b86..bbc894e6 100644
--- a/src/stkagent.c
+++ b/src/stkagent.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <stdint.h>
 #include <string.h>
 #include <errno.h>
diff --git a/src/storage.c b/src/storage.c
index 9b7bfbc7..6dce04ea 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -25,7 +25,6 @@
 =

 #include <ofono/storage.h>
 =

-#define _GNU_SOURCE
 #include <string.h>
 #include <stdarg.h>
 #include <sys/types.h>
diff --git a/src/ussd.c b/src/ussd.c
index 23b33235..df1136f5 100644
--- a/src/ussd.c
+++ b/src/ussd.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <string.h>
 #include <stdio.h>
 #include <errno.h>
diff --git a/tools/tty-redirector.c b/tools/tty-redirector.c
index b015a259..6c28a45d 100644
--- a/tools/tty-redirector.c
+++ b/tools/tty-redirector.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <stdio.h>
 #include <fcntl.h>
 #include <unistd.h>
diff --git a/unit/rilmodem-test-engine.c b/unit/rilmodem-test-engine.c
index 7cbc1ad4..a428f020 100644
--- a/unit/rilmodem-test-engine.c
+++ b/unit/rilmodem-test-engine.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <stdio.h>
 #include <netinet/in.h>
 #include <sys/socket.h>
diff --git a/unit/rilmodem-test-server.c b/unit/rilmodem-test-server.c
index 5a3b03a0..5a20d43d 100644
--- a/unit/rilmodem-test-server.c
+++ b/unit/rilmodem-test-server.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <netinet/in.h>
 #include <sys/socket.h>
 #include <sys/un.h>
diff --git a/unit/test-rilmodem-cb.c b/unit/test-rilmodem-cb.c
index 43c6fa17..e8607535 100644
--- a/unit/test-rilmodem-cb.c
+++ b/unit/test-rilmodem-cb.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <assert.h>
 #include <errno.h>
 #include <glib.h>
diff --git a/unit/test-rilmodem-cs.c b/unit/test-rilmodem-cs.c
index ae7abec1..94fee1a6 100644
--- a/unit/test-rilmodem-cs.c
+++ b/unit/test-rilmodem-cs.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <assert.h>
 #include <errno.h>
 #include <glib.h>
diff --git a/unit/test-rilmodem-gprs.c b/unit/test-rilmodem-gprs.c
index 057c51e0..9d86608b 100644
--- a/unit/test-rilmodem-gprs.c
+++ b/unit/test-rilmodem-gprs.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <assert.h>
 #include <errno.h>
 #include <glib.h>
diff --git a/unit/test-rilmodem-sms.c b/unit/test-rilmodem-sms.c
index 70c7386c..15e704ef 100644
--- a/unit/test-rilmodem-sms.c
+++ b/unit/test-rilmodem-sms.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <assert.h>
 #include <errno.h>
 #include <glib.h>
-- =

2.17.1


--===============3535978341727894124==--

