Content-Type: multipart/mixed; boundary="===============9168125857916768443=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH v2] hfpmodem: fix callheld indicator
Date: Mon, 25 Jul 2011 16:42:19 +0200
Message-ID: <1311604939-10751-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9168125857916768443==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Callheld move from 1 (active and held calls) to 2 (all calls on hold) may
result of:
- active call has been dropped by remote,
- an intermediate state during a call swap which will be followed by a
  move back to 1.
So, wait a little before checking calls state.
---
 drivers/hfpmodem/voicecall.c |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/drivers/hfpmodem/voicecall.c b/drivers/hfpmodem/voicecall.c
index 126c1e3..3c49870 100644
--- a/drivers/hfpmodem/voicecall.c
+++ b/drivers/hfpmodem/voicecall.c
@@ -42,6 +42,7 @@
 #include "slc.h"
 =

 #define POLL_CLCC_INTERVAL 2000
+#define POLL_CLCC_DELAY 50
 #define CLIP_TIMEOUT 500
 =

 static const char *none_prefix[] =3D { NULL };
@@ -1024,6 +1025,11 @@ static void ciev_callheld_notify(struct ofono_voicec=
all *vc,
 		break;
 =

 	case 1:
+		if (vd->clcc_source) {
+			g_source_remove(vd->clcc_source);
+			vd->clcc_source =3D 0;
+		}
+
 		/* We have to poll here, we have no idea whether the call was
 		 * accepted by CHLD=3D1 or swapped by CHLD=3D2 or one call was
 		 * chosed for private chat by CHLD=3D2x
@@ -1043,7 +1049,15 @@ static void ciev_callheld_notify(struct ofono_voicec=
all *vc,
 				ofono_voicecall_notify(vc, call);
 			}
 		} else if (callheld =3D=3D 1) {
-			release_with_status(vc, CALL_STATUS_ACTIVE);
+			if (vd->clcc_source)
+				g_source_remove(vd->clcc_source);
+
+			/* We have to schedule a poll here, we have no idea
+			 * whether active call was dropped by remote or if this
+			 * is an intermediate state during call swap
+			 */
+			vd->clcc_source =3D g_timeout_add(POLL_CLCC_DELAY,
+							poll_clcc, vc);
 		}
 	}
 =

-- =

1.7.1


--===============9168125857916768443==--

