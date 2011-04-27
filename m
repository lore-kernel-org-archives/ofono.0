Content-Type: multipart/mixed; boundary="===============9068984751012816788=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [PATCH] isimodem: use a specific call id when answering
Date: Wed, 27 Apr 2011 15:45:09 +0300
Message-ID: <1303908309-28914-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9068984751012816788==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 drivers/isimodem/voicecall.c |   22 +++++++++++++++++++++-
 1 files changed, 21 insertions(+), 1 deletions(-)

diff --git a/drivers/isimodem/voicecall.c b/drivers/isimodem/voicecall.c
index 333f9b8..4d4e16b 100644
--- a/drivers/isimodem/voicecall.c
+++ b/drivers/isimodem/voicecall.c
@@ -1480,7 +1480,27 @@ static void isi_dial(struct ofono_voicecall *ovc,
 static void isi_answer(struct ofono_voicecall *ovc, ofono_voicecall_cb_t c=
b,
 			void *data)
 {
-	isi_call_answer_req(ovc, CALL_ID_ALL, cb, data);
+	struct isi_voicecall *ivc =3D ofono_voicecall_get_data(ovc);
+	int id;
+
+	for (id =3D 1; id <=3D 7; id++) {
+		switch (ivc->calls[id].status) {
+		case CALL_STATUS_COMING:
+		case CALL_STATUS_MT_ALERTING:
+		case CALL_STATUS_WAITING:
+			goto answer;
+		case CALL_STATUS_PROCEEDING:
+			if (ivc->calls[id].mode_info & CALL_MODE_ORIGINATOR)
+				goto answer;
+			break;
+		}
+	}
+
+	CALLBACK_WITH_FAILURE(cb, data);
+	return;
+
+answer:
+	isi_call_answer_req(ovc, id, cb, data);
 }
 =

 static void isi_hangup_current(struct ofono_voicecall *ovc,
-- =

1.7.1


--===============9068984751012816788==--

