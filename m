Content-Type: multipart/mixed; boundary="===============2668704224206064244=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH] emulator: Fix for PTS test TC_AG_TWC_BV_02_I
Date: Tue, 28 Feb 2012 14:33:57 +0100
Message-ID: <1330436037-18377-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2668704224206064244==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

RING event should only be sent when callsetup indicator is set to
Incoming and there is no active call.

If call indicator is set to inactive while callsetup is
already set to Incoming (waiting call has generated +CCWA),
RING event should be sent after all calls' state have been updated.

As state of calls are updated one by one, generating multiple calls
to ofono_emulator_set_indicator(), do not call notify_ring() just
after call indicator went from active/held to inactive (only start
ring timer).
In ring_timer(), in case of a call in waiting state, just exit and
wait for next timeout.
---
 src/emulator.c |   21 +++++++++++----------
 1 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index 262e782..fed699c 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -414,6 +414,13 @@ static gboolean notify_ring(void *user_data)
 	if (em->type =3D=3D OFONO_EMULATOR_TYPE_HFP && em->slc =3D=3D FALSE)
 		return TRUE;
 =

+	/*
+	 * In case of waiting call becoming an incoming call, call status
+	 * change may not have been done yet, wait for change has been completed
+	 */
+	if (find_call_with_status(em, CALL_STATUS_WAITING))
+		return TRUE;
+
 	g_at_server_send_unsolicited(em->server, "RING");
 =

 	if (!em->clip)
@@ -421,13 +428,6 @@ static gboolean notify_ring(void *user_data)
 =

 	c =3D find_call_with_status(em, CALL_STATUS_INCOMING);
 =

-	/*
-	 * In case of waiting call becoming an incoming call, call status
-	 * change may not have been done yet, so try to find waiting call too
-	 */
-	if (c =3D=3D NULL)
-		c =3D find_call_with_status(em, CALL_STATUS_WAITING);
-
 	if (c =3D=3D NULL)
 		return TRUE;
 =

@@ -1221,10 +1221,10 @@ void ofono_emulator_set_indicator(struct ofono_emul=
ator *em,
 	/*
 	 * Ring timer should be started when:
 	 * - callsetup indicator is set to Incoming and there is no active call
-	 *   (not a waiting call)
+	 *   (not a waiting call), in this case, a first RING should be sent
+	 *   just after the +CIEV
 	 * - or call indicator is set to inactive while callsetup is already
 	 *   set to Incoming.
-	 * In those cases, a first RING should be sent just after the +CIEV
 	 * Ring timer should be stopped for all other values of callsetup
 	 */
 	if (waiting)
@@ -1247,8 +1247,9 @@ void ofono_emulator_set_indicator(struct ofono_emulat=
or *em,
 		return;
 	}
 =

-start_ring:
 	notify_ring(em);
+
+start_ring:
 	em->callsetup_source =3D g_timeout_add_seconds(RING_TIMEOUT,
 							notify_ring, em);
 }
-- =

1.7.1


--===============2668704224206064244==--

