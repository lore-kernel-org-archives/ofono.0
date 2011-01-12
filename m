Content-Type: multipart/mixed; boundary="===============7869490275331605656=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [PATCH] isimodem: fix return from call control requests
Date: Wed, 12 Jan 2011 17:16:28 +0200
Message-ID: <1294845388-13084-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7869490275331605656==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 drivers/isimodem/voicecall.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/isimodem/voicecall.c b/drivers/isimodem/voicecall.c
index c19e64d..6f866a5 100644
--- a/drivers/isimodem/voicecall.c
+++ b/drivers/isimodem/voicecall.c
@@ -795,7 +795,7 @@ static void isi_call_control_resp(const GIsiMessage *ms=
g, void *data)
 	}
 =

 	if (cause =3D=3D CALL_CAUSE_NO_CAUSE) {
-		isi_ctx_return_failure(irc);
+		isi_ctx_return_success(irc);
 		return;
 	}
 =

-- =

1.7.1


--===============7869490275331605656==--

