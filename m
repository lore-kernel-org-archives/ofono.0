Content-Type: multipart/mixed; boundary="===============7100405952191028519=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH] hfpmodem: fix callheld indicator
Date: Fri, 22 Jul 2011 18:27:38 +0200
Message-ID: <1311352058-9158-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7100405952191028519==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Removing release of active calls when receive callheld move from 1
(active and held calls) to 2 (all calls on hold). Intermediate state
callheld=3D2 during a swap calls command is allowed by PTS.
---
 drivers/hfpmodem/voicecall.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/hfpmodem/voicecall.c b/drivers/hfpmodem/voicecall.c
index 126c1e3..5824643 100644
--- a/drivers/hfpmodem/voicecall.c
+++ b/drivers/hfpmodem/voicecall.c
@@ -1042,8 +1042,6 @@ static void ciev_callheld_notify(struct ofono_voiceca=
ll *vc,
 				call->status =3D CALL_STATUS_HELD;
 				ofono_voicecall_notify(vc, call);
 			}
-		} else if (callheld =3D=3D 1) {
-			release_with_status(vc, CALL_STATUS_ACTIVE);
 		}
 	}
 =

-- =

1.7.1


--===============7100405952191028519==--

