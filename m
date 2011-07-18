Content-Type: multipart/mixed; boundary="===============0581555254488878740=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH] voicecall: fix callheld indicator for PTS
Date: Mon, 18 Jul 2011 16:33:35 +0200
Message-ID: <1310999615-4077-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0581555254488878740==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fix PTS test TP/TWC/BV-03-I [Call Waiting- Hold Active/Retrieve
Waiting Call or Held].

PTS test fails after receiving intermediate update of callheld indicator
with value 0 (no held call) before it receives update to value 1
(active and held calls). This is due to the non-atomic update of calls
status after call swap (moving first call to active state before moving
second one to hold state).

HFP 1.5 spec specifies that an update of callheld indicator to 1 should
be sent after AT+CHLD=3D2 command.
As oFono emulator sends +CIEV only if the indicator value changes, we
need to use an intermediate state for callheld indicator (2, all calls on
hold).

So, in case of multiple active calls, or an active call with an active
mutiparty call, force update of callheld indicator to 2.
---
 src/voicecall.c |   18 ++++++++++++++----
 1 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index 3646951..4b8373e 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -733,7 +733,8 @@ static void emulator_callheld_status_cb(struct ofono_at=
om *atom, void *data)
 static void notify_emulator_call_status(struct ofono_voicecall *vc)
 {
 	struct ofono_modem *modem =3D __ofono_atom_get_modem(vc->atom);
-	gboolean call =3D FALSE;
+	unsigned int non_mpty =3D 0;
+	gboolean multiparty =3D FALSE;
 	gboolean held =3D FALSE;
 	gboolean incoming =3D FALSE;
 	gboolean dialing =3D FALSE;
@@ -750,7 +751,12 @@ static void notify_emulator_call_status(struct ofono_v=
oicecall *vc)
 =

 		switch (v->call->status) {
 		case CALL_STATUS_ACTIVE:
-			call =3D TRUE;
+			if (g_slist_find_custom(vc->multiparty_list,
+						GINT_TO_POINTER(v->call->id),
+						call_compare_by_id))
+				multiparty =3D TRUE;
+			else
+				non_mpty++;
 			break;
 =

 		case CALL_STATUS_HELD:
@@ -775,7 +781,8 @@ static void notify_emulator_call_status(struct ofono_vo=
icecall *vc)
 		}
 	}
 =

-	data.status =3D call || held ? OFONO_EMULATOR_CALL_ACTIVE :
+	data.status =3D non_mpty || multiparty || held ?
+					OFONO_EMULATOR_CALL_ACTIVE :
 					OFONO_EMULATOR_CALL_INACTIVE;
 =

 	__ofono_modem_foreach_registered_atom(modem,
@@ -799,8 +806,11 @@ static void notify_emulator_call_status(struct ofono_v=
oicecall *vc)
 						&data);
 =

 	if (held)
-		data.status =3D call ? OFONO_EMULATOR_CALLHELD_MULTIPLE :
+		data.status =3D (non_mpty || multiparty) ?
+					OFONO_EMULATOR_CALLHELD_MULTIPLE :
 					OFONO_EMULATOR_CALLHELD_ON_HOLD;
+	else if (non_mpty > 1 || (non_mpty && multiparty))
+		data.status =3D OFONO_EMULATOR_CALLHELD_ON_HOLD;
 	else
 		data.status =3D OFONO_EMULATOR_CALLHELD_NONE;
 =

-- =

1.7.1


--===============0581555254488878740==--

