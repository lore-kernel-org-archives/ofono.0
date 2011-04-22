Content-Type: multipart/mixed; boundary="===============8238437995921107550=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH] voicecall: fix waiting calls for HFP emulator
Date: Fri, 22 Apr 2011 17:44:02 +0200
Message-ID: <1303487042-8612-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8238437995921107550==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fix precedence between waiting and dialing so HFP emulator is notified
of dialing/alerting even in case of a waiting call pending.
---
 src/voicecall.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index 7aa0b7e..dcc358e 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -770,12 +770,14 @@ static void notify_emulator_call_status(struct ofono_=
voicecall *vc)
 						emulator_call_status_cb,
 						GINT_TO_POINTER(status));
 =

-	if (incoming || waiting)
+	if (incoming)
 		status =3D OFONO_EMULATOR_CALLSETUP_INCOMING;
 	else if (dialing)
 		status =3D OFONO_EMULATOR_CALLSETUP_OUTGOING;
 	else if (alerting)
 		status =3D OFONO_EMULATOR_CALLSETUP_ALERTING;
+	else if (waiting)
+		status =3D OFONO_EMULATOR_CALLSETUP_INCOMING;
 	else
 		status =3D OFONO_EMULATOR_CALLSETUP_INACTIVE;
 =

-- =

1.7.1


--===============8238437995921107550==--

