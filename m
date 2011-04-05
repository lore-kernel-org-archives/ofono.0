Content-Type: multipart/mixed; boundary="===============8993171225123937158=="
MIME-Version: 1.0
From: ext-arun.1.ravindran@nokia.com
Subject: [PATCH] isimodem:hangupall failed for hold initiated call
Date: Tue, 05 Apr 2011 15:02:59 +0300
Message-ID: <1302004979-17634-1-git-send-email-ext-arun.1.ravindran@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8993171225123937158==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Arun Ravindran <ext-arun.1.ravindran@nokia.com>

---
 drivers/isimodem/voicecall.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/isimodem/voicecall.c b/drivers/isimodem/voicecall.c
index 05f7c09..2cbd046 100644
--- a/drivers/isimodem/voicecall.c
+++ b/drivers/isimodem/voicecall.c
@@ -1496,6 +1496,7 @@ static void isi_hangup_current(struct ofono_voicecall=
 *ovc,
 		case CALL_STATUS_COMING:
 		case CALL_STATUS_MO_ALERTING:
 		case CALL_STATUS_ANSWERED:
+		case CALL_STATUS_HOLD_INITIATED:
 			goto release_by_id;
 		case CALL_STATUS_MT_ALERTING:
 			cause =3D CALL_CAUSE_BUSY_USER_REQUEST;
-- =

1.7.0.4


--===============8993171225123937158==--

