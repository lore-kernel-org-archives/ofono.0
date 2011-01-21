Content-Type: multipart/mixed; boundary="===============2854832879900539505=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH] isimodem: fix issue with user busy release
Date: Fri, 21 Jan 2011 10:24:30 +0200
Message-ID: <1295598270-13244-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2854832879900539505==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

when the user rejects the incoming call, hangup_active
will get called on the driver side whereas when the user
rejects the waiting call, set_udub will get called on the
driver side.
---
 drivers/isimodem/voicecall.c |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/isimodem/voicecall.c b/drivers/isimodem/voicecall.c
index e5842aa..9aa9454 100644
--- a/drivers/isimodem/voicecall.c
+++ b/drivers/isimodem/voicecall.c
@@ -973,6 +973,7 @@ static void isi_hangup_current(struct ofono_voicecall *=
ovc,
 	 */
 	struct isi_voicecall *ivc =3D ofono_voicecall_get_data(ovc);
 	int id =3D 0;
+	uint8_t cause =3D CALL_CAUSE_RELEASE_BY_USER;
 =

 	for (id =3D 1; id <=3D 7; id++) {
 		if (ivc->calls[id].call_id & CALL_ID_WAITING)
@@ -983,19 +984,23 @@ static void isi_hangup_current(struct ofono_voicecall=
 *ovc,
 		switch (ivc->calls[id].status) {
 		case CALL_STATUS_CREATE:
 		case CALL_STATUS_COMING:
-		case CALL_STATUS_PROCEEDING:
 		case CALL_STATUS_MO_ALERTING:
-		case CALL_STATUS_MT_ALERTING:
 		case CALL_STATUS_ANSWERED:
 			goto release_by_id;
+		case CALL_STATUS_MT_ALERTING:
+			cause =3D CALL_CAUSE_BUSY_USER_REQUEST;
+			goto release_by_id;
+		case CALL_STATUS_PROCEEDING:
+			if (ivc->calls[id].mode_info & CALL_MODE_ORIGINATOR)
+				cause =3D CALL_CAUSE_BUSY_USER_REQUEST;
+			goto release_by_id;
 		}
 	}
 =

 	id =3D CALL_ID_ACTIVE;
 =

 release_by_id:
-	isi_call_release_req(ovc, id, CALL_CAUSE_TYPE_CLIENT,
-				CALL_CAUSE_RELEASE_BY_USER, cb, data);
+	isi_call_release_req(ovc, id, CALL_CAUSE_TYPE_CLIENT, cause, cb, data);
 }
 =

 static void isi_release_all_held(struct ofono_voicecall *ovc,
-- =

1.7.0.4


--===============2854832879900539505==--

