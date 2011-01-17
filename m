Content-Type: multipart/mixed; boundary="===============3052657341828971948=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [PATCH] Fix crash in isimodem call forwarding.
Date: Mon, 17 Jan 2011 19:05:16 +0200
Message-ID: <1295283916-17511-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3052657341828971948==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 drivers/isimodem/call-forwarding.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/isimodem/call-forwarding.c b/drivers/isimodem/call-for=
warding.c
index 2fafb26..89a03dc 100644
--- a/drivers/isimodem/call-forwarding.c
+++ b/drivers/isimodem/call-forwarding.c
@@ -143,6 +143,14 @@ static gboolean decode_gsm_forwarding_info(GIsiSubBloc=
kIter *parent,
 							info->numlen * 2,
 							2 + len))
 				return FALSE;
+
+			if (number)
+				*number =3D tag;
+			else
+				g_free(tag);
+		} else {
+			if (number)
+				*number =3D g_strdup("");
 		}
 =

 		if (status)
@@ -154,11 +162,6 @@ static gboolean decode_gsm_forwarding_info(GIsiSubBloc=
kIter *parent,
 		if (noreply)
 			*noreply =3D info->noreply;
 =

-		if (number)
-			*number =3D tag;
-		else
-			g_free(tag);
-
 		return TRUE;
 	}
 	return FALSE;
-- =

1.7.1


--===============3052657341828971948==--

