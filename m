Content-Type: multipart/mixed; boundary="===============2783841691945824754=="
MIME-Version: 1.0
From: Arun Ravindran <arunlee@gmail.com>
Subject: [PATCH] isimodem: Improper handling of missed call
Date: Mon, 23 May 2011 18:20:11 +0300
Message-ID: <1306164011-29368-1-git-send-email-arunlee@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2783841691945824754==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/isimodem/voicecall.c |   32 ++++++++++++++++++++++++++++----
 1 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/isimodem/voicecall.c b/drivers/isimodem/voicecall.c
index 333f9b8..c599e39 100644
--- a/drivers/isimodem/voicecall.c
+++ b/drivers/isimodem/voicecall.c
@@ -50,6 +50,7 @@ struct isi_call {
 	uint8_t id;
 	uint8_t call_id;
 	uint8_t status;
+	uint8_t prev_status;
 	uint8_t mode;
 	uint8_t mode_info;
 	uint8_t cause_type;
@@ -314,7 +315,7 @@ static void isi_call_status_sb_proc(struct isi_voicecal=
l *ivc,
 =

 	if (!g_isi_sb_iter_get_byte(sb, &status, 2))
 		return;
-
+	call->prev_status =3D call->status;
 	call->status =3D status;
 }
 =

@@ -401,10 +402,16 @@ static int isi_call_status_to_clcc(const struct isi_c=
all *call)
 		return 5;
 =

 	case CALL_STATUS_MO_RELEASE:
-	case CALL_STATUS_MT_RELEASE:
-	case CALL_STATUS_TERMINATED:
 		return 6;
 =

+	case CALL_STATUS_MT_RELEASE:
+		if ((call->prev_status =3D=3D CALL_STATUS_MT_ALERTING) ||
+				(call->prev_status =3D=3D CALL_STATUS_COMING) ||
+				(call->prev_status =3D=3D CALL_STATUS_WAITING))
+			return 4;
+		else
+			return 6;
+
 	case CALL_STATUS_ACTIVE:
 	case CALL_STATUS_HOLD_INITIATED:
 		return 0;
@@ -548,9 +555,26 @@ static void isi_call_notify(struct ofono_voicecall *ov=
c, struct isi_call *call)
 =

 	case CALL_STATUS_MO_RELEASE:
 	case CALL_STATUS_MT_RELEASE:
-	case CALL_STATUS_TERMINATED:
+		/*
+		* Core requires the call status to be either incoming
+		* or waiting to identify the disconnected call as missed.
+		* The MT RELEASE is not mapped to any state in +CLCC, but
+		* we need the disconnect reason.
+		*/
 		isi_call_set_disconnect_reason(call);
 		break;
+	case CALL_STATUS_TERMINATED:
+		DBG("State( CALL_STATUS_TERMINATED ) need not be reported to Core");
+		/* =

+		* The call terminated is not reported to core as
+		* these intermediate states are not processed in =

+		* the core. We report the call status when it becomes =

+		* idle and TERMINATED is not mapped to +CLCC. The disconnect =

+		* reason is set, so that the call termination cause =

+		* in case of error is available to the core.
+		*/
+		isi_call_set_disconnect_reason(call);
+		return;
 	case CALL_STATUS_ANSWERED:
 		DBG("State need not be reported to Core");
 		return;
-- =

1.7.1


--===============2783841691945824754==--

