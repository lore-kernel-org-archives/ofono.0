Content-Type: multipart/mixed; boundary="===============8496370252497509479=="
MIME-Version: 1.0
From: Marit Henriksen <maritsofie.henriksen8@gmail.com>
Subject: [PATCHv4] stemodem: Fix for MT call not working when caller id is
 hidden.
Date: Tue, 04 Jan 2011 09:42:04 +0100
Message-ID: <1294130524-3515-1-git-send-email-maritsofie.henriksen8@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8496370252497509479==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Marit Henriksen <marit.henriksen@stericsson.com>

In *ECAV, the number will not be included if caller id is hidden.
Set it to an empty string in that case, and set number type to
128, unknown number type.
---
 drivers/stemodem/voicecall.c |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/stemodem/voicecall.c b/drivers/stemodem/voicecall.c
index bf68f52..99383cf 100644
--- a/drivers/stemodem/voicecall.c
+++ b/drivers/stemodem/voicecall.c
@@ -442,10 +442,15 @@ static void ecav_notify(GAtResult *result, gpointer u=
ser_data)
 	if (status =3D=3D CALL_STATUS_DIALING ||
 			status =3D=3D CALL_STATUS_WAITING ||
 			status =3D=3D CALL_STATUS_INCOMING) {
-		if (!g_at_result_iter_next_string(&iter, &num))
-			return;
-
-		if (!g_at_result_iter_next_number(&iter, &num_type))
+		/*
+		 * If caller uses hidden id, the number and
+		 * number type might not be present. Don't
+		 * look for type if number is not present.
+		 */
+		if (!g_at_result_iter_next_string(&iter, &num)) {
+			num =3D "";
+			num_type =3D 128;
+		} else if (!g_at_result_iter_next_number(&iter, &num_type))
 			return;
 	}
 =

-- =

1.7.1


--===============8496370252497509479==--

