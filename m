Content-Type: multipart/mixed; boundary="===============1388622806344319873=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH] atmodem: fix DBG message
Date: Tue, 30 Nov 2010 20:14:39 -0200
Message-ID: <1291155279-14733-1-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1388622806344319873==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/voicecall.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/atmodem/voicecall.c b/drivers/atmodem/voicecall.c
index 10b8f4b..f6714cb 100644
--- a/drivers/atmodem/voicecall.c
+++ b/drivers/atmodem/voicecall.c
@@ -679,7 +679,7 @@ static void cring_notify(GAtResult *result, gpointer us=
er_data)
 	 */
 	vd->clcc_source =3D g_timeout_add(CLIP_INTERVAL, poll_clcc, vc);
 =

-	DBG("cring_notify");
+	DBG("");
 }
 =

 static void clip_notify(GAtResult *result, gpointer user_data)
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

@@ -784,7 +784,7 @@ static void ccwa_notify(GAtResult *result, gpointer use=
r_data)
 	/* If we have CLI validity field, override our guessed value */
 	g_at_result_iter_next_number(&iter, &validity);
 =

-	DBG("ccwa_notify: %s %d %d %d", num, num_type, cls, validity);
+	DBG("%s %d %d %d", num, num_type, cls, validity);
 =

 	call =3D create_call(vc, class_to_call_type(cls), 1, 5,
 				num, num_type, validity);
-- =

1.7.3.2


--===============1388622806344319873==--

