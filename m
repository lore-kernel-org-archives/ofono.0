Content-Type: multipart/mixed; boundary="===============2005861599526530377=="
MIME-Version: 1.0
From: Syam Sidhardhan <syamsidhardh@gmail.com>
Subject: [PATCH] isimodem: Remove extra bogus semicolon
Date: Fri, 30 Dec 2011 03:00:25 +0530
Message-ID: <1325194225-6500-1-git-send-email-syamsidhardh@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2005861599526530377==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/isimodem/voicecall.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/isimodem/voicecall.c b/drivers/isimodem/voicecall.c
index f7ee95b..2f38f68 100644
--- a/drivers/isimodem/voicecall.c
+++ b/drivers/isimodem/voicecall.c
@@ -1793,7 +1793,7 @@ static void isi_swap_without_accept(struct ofono_voic=
ecall *ovc,
 static void isi_send_tones(struct ofono_voicecall *ovc, const char *tones,
 				ofono_voicecall_cb_t cb, void *data)
 {
-	isi_call_dtmf_send_req(ovc, CALL_ID_ALL, tones, cb, data);;
+	isi_call_dtmf_send_req(ovc, CALL_ID_ALL, tones, cb, data);
 }
 =

 static void subscribe_indications(GIsiClient *cl, void *data)
-- =

1.7.4.1


--===============2005861599526530377==--

