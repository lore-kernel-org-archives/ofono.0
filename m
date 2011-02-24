Content-Type: multipart/mixed; boundary="===============7110009843560116080=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH 2/2] emulator: add support of void parameters in CMER
Date: Thu, 24 Feb 2011 18:16:06 +0100
Message-ID: <1298567766-17745-3-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1298567766-17745-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7110009843560116080==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/emulator.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index 9cd3252..20a575f 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -312,7 +312,7 @@ static void cmer_cb(GAtServer *server, GAtServerRequest=
Type type,
 	case G_AT_SERVER_REQUEST_TYPE_SET:
 	{
 		GAtResultIter iter;
-		int mode;
+		int mode =3D em->events_mode;
 		int ind =3D em->events_ind;
 		int val;
 =

@@ -320,15 +320,15 @@ static void cmer_cb(GAtServer *server, GAtServerReque=
stType type,
 		g_at_result_iter_next(&iter, "");
 =

 		/* mode */
-		if (g_at_result_iter_next_number(&iter, &mode) =3D=3D FALSE)
+		if (!g_at_result_iter_next_number_default(&iter, mode, &mode))
 			goto fail;
 =

 		if (mode !=3D 0 && mode !=3D 3)
 			goto fail;
 =

 		/* keyp */
-		if (g_at_result_iter_next_number(&iter, &val) =3D=3D FALSE) {
-			if (g_at_result_iter_skip_next(&iter) =3D=3D FALSE)
+		if (!g_at_result_iter_next_number_default(&iter, 0, &val)) {
+			if (!g_at_result_iter_skip_next(&iter))
 				goto done;
 			goto fail;
 		}
@@ -337,8 +337,8 @@ static void cmer_cb(GAtServer *server, GAtServerRequest=
Type type,
 			goto fail;
 =

 		/* disp */
-		if (g_at_result_iter_next_number(&iter, &val) =3D=3D FALSE) {
-			if (g_at_result_iter_skip_next(&iter) =3D=3D FALSE)
+		if (!g_at_result_iter_next_number_default(&iter, 0, &val)) {
+			if (!g_at_result_iter_skip_next(&iter))
 				goto done;
 			goto fail;
 		}
@@ -347,18 +347,18 @@ static void cmer_cb(GAtServer *server, GAtServerReque=
stType type,
 			goto fail;
 =

 		/* ind */
-		if (g_at_result_iter_next_number(&iter, &ind) =3D=3D FALSE) {
-			if (g_at_result_iter_skip_next(&iter) =3D=3D FALSE)
+		if (!g_at_result_iter_next_number_default(&iter, ind, &ind)) {
+			if (!g_at_result_iter_skip_next(&iter))
 				goto done;
 			goto fail;
 		}
 =

-		if ((ind !=3D 0) && (ind !=3D 1))
+		if (ind !=3D 0 && ind !=3D 1)
 			goto fail;
 =

 		/* bfr */
-		if (g_at_result_iter_next_number(&iter, &val) =3D=3D FALSE) {
-			if (g_at_result_iter_skip_next(&iter) =3D=3D FALSE)
+		if (!g_at_result_iter_next_number_default(&iter, 0, &val)) {
+			if (!g_at_result_iter_skip_next(&iter))
 				goto done;
 			goto fail;
 		}
@@ -367,7 +367,7 @@ static void cmer_cb(GAtServer *server, GAtServerRequest=
Type type,
 			goto fail;
 =

 		/* check that bfr is last parameter */
-		if (g_at_result_iter_skip_next(&iter) =3D=3D TRUE)
+		if (g_at_result_iter_skip_next(&iter))
 			goto fail;
 =

 done:
-- =

1.7.1


--===============7110009843560116080==--

