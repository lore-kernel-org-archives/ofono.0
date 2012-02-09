Content-Type: multipart/mixed; boundary="===============1544875099952954182=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH] emulator: Fix start of RING event
Date: Thu, 09 Feb 2012 15:12:43 +0100
Message-ID: <1328796763-9777-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1544875099952954182==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

RING event should only be sent when callsetup indicator is set to
Incoming and there is no active call.

If call indicator is set to inactive while callsetup is
already set to Incoming (waiting call has generated +CCWA),
no RING event should be sent.

Ref.: PTS test TC_AG_TWC_BV_02_I
---
 src/emulator.c |   18 +++---------------
 1 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index 262e782..0fa6eac 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -1219,23 +1219,12 @@ void ofono_emulator_set_indicator(struct ofono_emul=
ator *em,
 	}
 =

 	/*
-	 * Ring timer should be started when:
-	 * - callsetup indicator is set to Incoming and there is no active call
-	 *   (not a waiting call)
-	 * - or call indicator is set to inactive while callsetup is already
-	 *   set to Incoming.
+	 * Ring timer should be started when callsetup indicator is set to
+	 * Incoming and there is no active call (not a waiting call).
 	 * In those cases, a first RING should be sent just after the +CIEV
 	 * Ring timer should be stopped for all other values of callsetup
 	 */
-	if (waiting)
-		return;
-
-	/* Call state went from active/held + waiting -> incoming */
-	if (call && value =3D=3D OFONO_EMULATOR_CALL_INACTIVE &&
-			cs_ind->value =3D=3D OFONO_EMULATOR_CALLSETUP_INCOMING)
-		goto start_ring;
-
-	if (!callsetup)
+	if (!callsetup || waiting)
 		return;
 =

 	if (value !=3D OFONO_EMULATOR_CALLSETUP_INCOMING) {
@@ -1247,7 +1236,6 @@ void ofono_emulator_set_indicator(struct ofono_emulat=
or *em,
 		return;
 	}
 =

-start_ring:
 	notify_ring(em);
 	em->callsetup_source =3D g_timeout_add_seconds(RING_TIMEOUT,
 							notify_ring, em);
-- =

1.7.1


--===============1544875099952954182==--

