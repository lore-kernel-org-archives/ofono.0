Content-Type: multipart/mixed; boundary="===============3989685376925953319=="
MIME-Version: 1.0
From: ext-arun.1.ravindran@Nokia.com
Subject: [PATCH] isimodem:Remove reporting active state wrongly
Date: Tue, 05 Apr 2011 12:32:53 +0300
Message-ID: <1301995973-15858-1-git-send-email-ext-arun.1.ravindran@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3989685376925953319==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Arun Ravindran <ext-arun.1.ravindran@nokia.com>

---
 drivers/isimodem/voicecall.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/isimodem/voicecall.c b/drivers/isimodem/voicecall.c
index 5cbba1f..05f7c09 100644
--- a/drivers/isimodem/voicecall.c
+++ b/drivers/isimodem/voicecall.c
@@ -405,7 +405,6 @@ static int isi_call_status_to_clcc(const struct isi_cal=
l *call)
 	case CALL_STATUS_TERMINATED:
 		return 6;
 =

-	case CALL_STATUS_ANSWERED:
 	case CALL_STATUS_ACTIVE:
 	case CALL_STATUS_HOLD_INITIATED:
 		return 0;
@@ -551,6 +550,10 @@ static void isi_call_notify(struct ofono_voicecall *ov=
c, struct isi_call *call)
 	case CALL_STATUS_MT_RELEASE:
 	case CALL_STATUS_TERMINATED:
 		isi_call_set_disconnect_reason(call);
+		break;
+	case CALL_STATUS_ANSWERED:
+		DBG("State need not be reported to Core");
+		return;
 	}
 =

 	ocall =3D isi_call_as_ofono_call(call);
-- =

1.7.0.4


--===============3989685376925953319==--

