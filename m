Content-Type: multipart/mixed; boundary="===============5316226624708862693=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH] voicecall: fix DBG message
Date: Tue, 30 Nov 2010 17:40:24 -0200
Message-ID: <1291146024-11457-1-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5316226624708862693==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/voicecall.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/atmodem/voicecall.c b/drivers/atmodem/voicecall.c
index 10b8f4b..3c31d72 100644
--- a/drivers/atmodem/voicecall.c
+++ b/drivers/atmodem/voicecall.c
@@ -723,7 +723,7 @@ static void clip_notify(GAtResult *result, gpointer use=
r_data)
 	/* If we have CLI validity field, override our guessed value */
 	g_at_result_iter_next_number(&iter, &validity);
 =

-	DBG("clip_notify: %s %d %d", num, type, validity);
+	DBG("%s %d %d", num, type, validity);
 =

 	call =3D l->data;
 =

-- =

1.7.3.2


--===============5316226624708862693==--

