Content-Type: multipart/mixed; boundary="===============2045130605317594268=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [PATCH] isimodem/voicecall: fix hangup_active
Date: Wed, 06 Oct 2010 12:23:01 +0300
Message-ID: <1286356981-29522-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2045130605317594268==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 drivers/isimodem/voicecall.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/isimodem/voicecall.c b/drivers/isimodem/voicecall.c
index 4b720be..ace2346 100644
--- a/drivers/isimodem/voicecall.c
+++ b/drivers/isimodem/voicecall.c
@@ -988,11 +988,11 @@ static void isi_answer(struct ofono_voicecall *ovc,
 	isi_call_answer_req(ovc, CALL_ID_ALL, cb, data);
 }
 =

-static void isi_hangup(struct ofono_voicecall *ovc,
+static void isi_hangup_active(struct ofono_voicecall *ovc,
 			ofono_voicecall_cb_t cb, void *data)
 {
 	/* AT+CHUP */
-	isi_call_release_req(ovc, CALL_ID_ALL, CALL_CAUSE_TYPE_CLIENT,
+	isi_call_release_req(ovc, CALL_ID_ACTIVE, CALL_CAUSE_TYPE_CLIENT,
 				CALL_CAUSE_RELEASE_BY_USER, cb, data);
 }
 =

@@ -1318,7 +1318,7 @@ static struct ofono_voicecall_driver driver =3D {
 	.remove			=3D isi_voicecall_remove,
 	.dial			=3D isi_dial,
 	.answer			=3D isi_answer,
-	.hangup_active		=3D isi_hangup,
+	.hangup_active		=3D isi_hangup_active,
 	.hold_all_active	=3D isi_hold_all_active,
 	.release_all_held	=3D isi_release_all_held,
 	.set_udub		=3D isi_set_udub,
-- =

1.7.0.4


--===============2045130605317594268==--

