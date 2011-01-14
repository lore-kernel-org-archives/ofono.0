Content-Type: multipart/mixed; boundary="===============6237449926442379997=="
MIME-Version: 1.0
From: Marit Henriksen <maritsofie.henriksen8@gmail.com>
Subject: [PATCH] stemodem: Return immediately if not voice call.
Date: Fri, 14 Jan 2011 12:19:54 +0100
Message-ID: <1295003994-11353-1-git-send-email-maritsofie.henriksen8@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6237449926442379997==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Marit Henriksen <marit.henriksen@stericsson.com>

---
 drivers/stemodem/voicecall.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/stemodem/voicecall.c b/drivers/stemodem/voicecall.c
index 8f3533d..e840e4f 100644
--- a/drivers/stemodem/voicecall.c
+++ b/drivers/stemodem/voicecall.c
@@ -433,6 +433,9 @@ static void ecav_notify(GAtResult *result, gpointer use=
r_data)
 	if (!g_at_result_iter_next_number(&iter, &call_type))
 		return;
 =

+	if (call_type !=3D BEARER_CLASS_VOICE)
+		return;
+
 	/* Skip process id and exit cause */
 	g_at_result_iter_skip_next(&iter);
 	g_at_result_iter_skip_next(&iter);
@@ -454,9 +457,6 @@ static void ecav_notify(GAtResult *result, gpointer use=
r_data)
 			return;
 	}
 =

-	if (call_type !=3D BEARER_CLASS_VOICE)
-		return;
-
 	/*
 	 * Handle the call according to the status.
 	 * If it doesn't exists we make a new one
-- =

1.7.1


--===============6237449926442379997==--

