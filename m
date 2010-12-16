Content-Type: multipart/mixed; boundary="===============7477117117801584891=="
MIME-Version: 1.0
From: Marit Henriksen <maritsofie.henriksen8@gmail.com>
Subject: [PATCH] stemodem: Fix for MT call not working when caller id is
 hidden.
Date: Thu, 16 Dec 2010 14:56:31 +0100
Message-ID: <1292507791-23495-1-git-send-email-maritsofie.henriksen8@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7477117117801584891==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Marit Henriksen <marit.henriksen@stericsson.com>

In *ECAV, the number will not be included if caller id is hidden.
Set it to an empty string in that case.
---
 drivers/stemodem/voicecall.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/stemodem/voicecall.c b/drivers/stemodem/voicecall.c
index b9d91d2..d900666 100644
--- a/drivers/stemodem/voicecall.c
+++ b/drivers/stemodem/voicecall.c
@@ -442,10 +442,14 @@ static void ecav_notify(GAtResult *result, gpointer u=
ser_data)
 	if (status =3D=3D CALL_STATUS_DIALING ||
 			status =3D=3D CALL_STATUS_WAITING ||
 			status =3D=3D CALL_STATUS_INCOMING) {
+		/*
+		* If caller uses hidden id, the number and
+		* number type might not be present. Don't
+		* look for type if number is not present.
+		*/
 		if (!g_at_result_iter_next_string(&iter, &num))
-			return;
-
-		if (!g_at_result_iter_next_number(&iter, &num_type))
+			num =3D "";
+		else if (!g_at_result_iter_next_number(&iter, &num_type))
 			return;
 	}
 =

-- =

1.7.1


--===============7477117117801584891==--

