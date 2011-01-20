Content-Type: multipart/mixed; boundary="===============6023213927420897875=="
MIME-Version: 1.0
From: Kai Vehmanen <kai.vehmanen@nokia.com>
Subject: [PATCH] isimodem: fix sending DTMF
Date: Thu, 20 Jan 2011 16:13:01 +0200
Message-ID: <1295532781-22585-1-git-send-email-kai.vehmanen@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6023213927420897875==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

isi_call_dtmf_send_resp() handles the success case incorrectly, and
thus all send_tones attempts fail with bogus error codes.
---
 drivers/isimodem/voicecall.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/isimodem/voicecall.c b/drivers/isimodem/voicecall.c
index e5842aa..acbaa63 100644
--- a/drivers/isimodem/voicecall.c
+++ b/drivers/isimodem/voicecall.c
@@ -865,7 +865,7 @@ static void isi_call_dtmf_send_resp(const GIsiMessage *=
msg, void *data)
 	struct isi_call_req_ctx *irc =3D data;
 	GIsiSubBlockIter iter;
 	uint8_t cause_type;
-	uint8_t cause;
+	uint8_t cause =3D CALL_CAUSE_NO_CAUSE;
 =

 	if (!check_response_status(msg, CALL_DTMF_SEND_RESP))
 		goto error;
-- =

1.7.0.4


--===============6023213927420897875==--

