Content-Type: multipart/mixed; boundary="===============5125259575541415691=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH] emulator: fix request tests
Date: Thu, 16 Jun 2011 15:27:48 +0200
Message-ID: <1308230868-17256-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5125259575541415691==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/emulator.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index c120ad3..8821afd 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -433,7 +433,7 @@ static void brsf_cb(GAtServer *server, GAtServerRequest=
Type type,
 		if (g_at_result_iter_next_number(&iter, &val) =3D=3D FALSE)
 			goto fail;
 =

-		if ((val < 0) && (val > 127))
+		if ((val < 0) || (val > 127))
 			goto fail;
 =

 		em->r_features =3D val;
@@ -715,7 +715,7 @@ static void cmee_cb(GAtServer *server, GAtServerRequest=
Type type,
 		if (g_at_result_iter_next_number(&iter, &val) =3D=3D FALSE)
 			goto fail;
 =

-		if (val < 0 && val > 1)
+		if (val !=3D 0 && val !=3D 1)
 			goto fail;
 =

 		em->cmee_mode =3D val;
-- =

1.7.1


--===============5125259575541415691==--

