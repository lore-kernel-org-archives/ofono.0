Content-Type: multipart/mixed; boundary="===============1617509739120467582=="
MIME-Version: 1.0
From: Jarko Poutiainen <jarko.poutiainen@tieto.com>
Subject: [PATCH] isimodem: voicecall answer fix for Nemo on N9
Date: Mon, 10 Sep 2012 15:16:07 +0300
Message-ID: <1347279367-21026-1-git-send-email-jarko.poutiainen@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1617509739120467582==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Voicecall answering in Mer/Nemomobile run on Nokia N9 will fail unless call=
 id is passed to modem. This patch fixes that issue.

---
 drivers/isimodem/voicecall.c |   15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/isimodem/voicecall.c b/drivers/isimodem/voicecall.c
index 2f38f68..b549687 100644
--- a/drivers/isimodem/voicecall.c
+++ b/drivers/isimodem/voicecall.c
@@ -1504,7 +1504,20 @@ static void isi_dial(struct ofono_voicecall *ovc,
 static void isi_answer(struct ofono_voicecall *ovc, ofono_voicecall_cb_t c=
b,
 			void *data)
 {
-	isi_call_answer_req(ovc, CALL_ID_ALL, cb, data);
+	struct isi_voicecall *ivc =3D ofono_voicecall_get_data(ovc);
+	int id;
+
+	for (id =3D 1; id <=3D 7; id++) {
+
+		if (ivc->calls[id].status =3D=3D CALL_STATUS_MT_ALERTING)
+			goto answer_by_id;
+
+	}
+
+	id =3D CALL_ID_ALL;
+
+answer_by_id:
+	isi_call_answer_req(ovc, id, cb, data);
 }
 =

 static void isi_hangup_current(struct ofono_voicecall *ovc,
-- =

1.7.9.5


--===============1617509739120467582==--

