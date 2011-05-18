Content-Type: multipart/mixed; boundary="===============7969263076524563058=="
MIME-Version: 1.0
From: Arun Ravindran <arunlee@gmail.com>
Subject: [PATCH] isimodem: Improper handling of missed call
Date: Wed, 18 May 2011 13:47:32 +0300
Message-ID: <1305715652-4357-1-git-send-email-arunlee@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7969263076524563058==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/isimodem/voicecall.c |   20 ++++++++++++++++----
 1 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/isimodem/voicecall.c b/drivers/isimodem/voicecall.c
index 333f9b8..6979105 100644
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
+	=

 	case CALL_STATUS_ACTIVE:
 	case CALL_STATUS_HOLD_INITIATED:
 		return 0;
@@ -548,9 +555,14 @@ static void isi_call_notify(struct ofono_voicecall *ov=
c, struct isi_call *call)
 =

 	case CALL_STATUS_MO_RELEASE:
 	case CALL_STATUS_MT_RELEASE:
+		isi_call_set_disconect_reason(call):
+		break;
+
 	case CALL_STATUS_TERMINATED:
 		isi_call_set_disconnect_reason(call);
-		break;
+		DBG("State( CALL_STATUS_TERMINATED ) need not be reported to Core");
+		return;
+
 	case CALL_STATUS_ANSWERED:
 		DBG("State need not be reported to Core");
 		return;
-- =

1.7.1


--===============7969263076524563058==--

