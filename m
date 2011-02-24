Content-Type: multipart/mixed; boundary="===============6376649085216508511=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH 2/2] emulator: add support of void parameters in CMER
Date: Thu, 24 Feb 2011 16:46:34 +0100
Message-ID: <1298562394-11475-3-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1298562394-11475-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6376649085216508511==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/emulator.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index 4896ae1..c4bc505 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -312,23 +312,23 @@ static void cmer_cb(GAtServer *server, GAtServerReque=
stType type,
 	case G_AT_SERVER_REQUEST_TYPE_SET:
 	{
 		GAtResultIter iter;
-		int mode;
+		int mode =3D em->events_mode;
 		int ind =3D em->events_ind;
-		int val;
+		int val =3D 0;
 =

 		g_at_result_iter_init(&iter, result);
 		g_at_result_iter_next(&iter, "");
 =

 		/* mode */
-		if (g_at_result_iter_next_number(&iter, &mode) =3D=3D FALSE)
+		if (!g_at_result_iter_next_number_or_void(&iter, &mode))
 			goto fail;
 =

 		if ((mode !=3D 0) && (mode !=3D 3))
 			goto fail;
 =

 		/* keyp */
-		if (g_at_result_iter_next_number(&iter, &val) =3D=3D FALSE) {
-			if (g_at_result_iter_skip_next(&iter) =3D=3D FALSE)
+		if (!g_at_result_iter_next_number_or_void(&iter, &val)) {
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
+		if (!g_at_result_iter_next_number_or_void(&iter, &val)) {
+			if (!g_at_result_iter_skip_next(&iter))
 				goto done;
 			goto fail;
 		}
@@ -347,8 +347,8 @@ static void cmer_cb(GAtServer *server, GAtServerRequest=
Type type,
 			goto fail;
 =

 		/* ind */
-		if (g_at_result_iter_next_number(&iter, &ind) =3D=3D FALSE) {
-			if (g_at_result_iter_skip_next(&iter) =3D=3D FALSE)
+		if (!g_at_result_iter_next_number_or_void(&iter, &ind)) {
+			if (!g_at_result_iter_skip_next(&iter))
 				goto done;
 			goto fail;
 		}
@@ -357,8 +357,8 @@ static void cmer_cb(GAtServer *server, GAtServerRequest=
Type type,
 			goto fail;
 =

 		/* bfr */
-		if (g_at_result_iter_next_number(&iter, &val) =3D=3D FALSE) {
-			if (g_at_result_iter_skip_next(&iter) =3D=3D FALSE)
+		if (!g_at_result_iter_next_number_or_void(&iter, &val)) {
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


--===============6376649085216508511==--

