Content-Type: multipart/mixed; boundary="===============3958886064874019787=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH 1/4] voicecall: Improve transitions check
Date: Fri, 09 Mar 2012 16:26:52 +0100
Message-ID: <1331306815-13424-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3958886064874019787==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Indicators should not be updated if:
- multiple separate calls are active at same time
- a conf call and a call are active at same time
- multiple separate calls are held at same time
- a conf call and a call are held at same time
- a conf call has call in active and held state
---
 src/voicecall.c |   29 +++++++++++++++++------------
 1 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index c128227..dc4fdf5 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -779,6 +779,8 @@ static void notify_emulator_call_status(struct ofono_vo=
icecall *vc)
 	unsigned int non_mpty =3D 0;
 	gboolean multiparty =3D FALSE;
 	gboolean held =3D FALSE;
+	unsigned int non_mpty_held =3D 0;
+	gboolean multiparty_held =3D FALSE;
 	gboolean incoming =3D FALSE;
 	gboolean dialing =3D FALSE;
 	gboolean alerting =3D FALSE;
@@ -805,6 +807,12 @@ static void notify_emulator_call_status(struct ofono_v=
oicecall *vc)
 =

 		case CALL_STATUS_HELD:
 			held =3D TRUE;
+			if (g_slist_find_custom(vc->multiparty_list,
+						GINT_TO_POINTER(v->call->id),
+						call_compare_by_id))
+				multiparty_held =3D TRUE;
+			else
+				non_mpty_held++;
 			break;
 =

 		case CALL_STATUS_DIALING:
@@ -838,6 +846,15 @@ static void notify_emulator_call_status(struct ofono_v=
oicecall *vc)
 	if (waiting && (held =3D=3D FALSE && call =3D=3D FALSE))
 		return;
 =

+	if (non_mpty > 1 || (non_mpty && multiparty))
+		return;
+
+	if (non_mpty_held > 1 || (non_mpty_held && multiparty_held))
+		return;
+
+	if (multiparty && multiparty_held)
+		return;
+
 	data.status =3D call || held ? OFONO_EMULATOR_CALL_ACTIVE :
 					OFONO_EMULATOR_CALL_INACTIVE;
 =

@@ -864,18 +881,6 @@ static void notify_emulator_call_status(struct ofono_v=
oicecall *vc)
 	if (held)
 		data.status =3D call ? OFONO_EMULATOR_CALLHELD_MULTIPLE :
 					OFONO_EMULATOR_CALLHELD_ON_HOLD;
-	else if (non_mpty > 1 || (non_mpty && multiparty))
-		/*
-		 * After call swap, it is possible that all calls move
-		 * temporarily to active state (depending on call state update
-		 * order), generating an update of callheld indicator to 0.
-		 * This will fail PTS test TP/TWC/BV-03-I.
-		 *
-		 * So, in case of multiple active calls, or an active call with
-		 * an active mutiparty call, force update of callheld indicator
-		 * to 2 (intermediate state allowed).
-		 */
-		data.status =3D OFONO_EMULATOR_CALLHELD_ON_HOLD;
 	else
 		data.status =3D OFONO_EMULATOR_CALLHELD_NONE;
 =

-- =

1.7.1


--===============3958886064874019787==--

