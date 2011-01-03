Content-Type: multipart/mixed; boundary="===============1817164606843963485=="
MIME-Version: 1.0
From: Marit Henriksen <maritsofie.henriksen8@gmail.com>
Subject: [PATCHv2] stemodem: Fix for MT call not working when caller id is
 hidden.
Date: Mon, 03 Jan 2011 13:59:42 +0100
Message-ID: <1294059582-1801-1-git-send-email-maritsofie.henriksen8@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1817164606843963485==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Marit Henriksen <marit.henriksen@stericsson.com>

In *ECAV, the number will not be included if caller id is hidden.
Set it to an empty string in that case, and set number type to
128, unknown number type.
---
 drivers/stemodem/voicecall.c |   16 +++++++++++-----
 1 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/stemodem/voicecall.c b/drivers/stemodem/voicecall.c
index bf68f52..4964fb7 100644
--- a/drivers/stemodem/voicecall.c
+++ b/drivers/stemodem/voicecall.c
@@ -1,4 +1,4 @@
-/*
+e/*
  *
  *  oFono - Open Source Telephony
  *
@@ -442,10 +442,16 @@ static void ecav_notify(GAtResult *result, gpointer u=
ser_data)
 	if (status =3D=3D CALL_STATUS_DIALING ||
 			status =3D=3D CALL_STATUS_WAITING ||
 			status =3D=3D CALL_STATUS_INCOMING) {
-		if (!g_at_result_iter_next_string(&iter, &num))
-			return;
-
-		if (!g_at_result_iter_next_number(&iter, &num_type))
+		/*
+		* If caller uses hidden id, the number and
+		* number type might not be present. Don't
+		* look for type if number is not present.
+		*/
+		if (!g_at_result_iter_next_string(&iter, &num)) {
+			num=3D"";
+			num_type =3D 128;
+		}
+		else if (!g_at_result_iter_next_number(&iter, &num_type))
 			return;
 	}
 =

-- =

1.7.1


--===============1817164606843963485==--

