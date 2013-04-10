Content-Type: multipart/mixed; boundary="===============8257461417484098356=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: [PATCH 3/6] emulator: Change feature check to attend HFP 1.6
Date: Wed, 10 Apr 2013 16:24:44 -0300
Message-ID: <1365621887-16940-4-git-send-email-paulo.borges@openbossa.org>
In-Reply-To: <1365621887-16940-1-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8257461417484098356==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In HFP 1.6 there is a new feature: Codec Negociation.
---
 src/emulator.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/emulator.c b/src/emulator.c
index 4a748f0..f34d4d3 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -459,7 +459,7 @@ static void brsf_cb(GAtServer *server, GAtServerRequest=
Type type,
 		if (g_at_result_iter_next_number(&iter, &val) =3D=3D FALSE)
 			goto fail;
 =

-		if (val < 0 || val > 127)
+		if (val < 0 || val > 255)
 			goto fail;
 =

 		em->r_features =3D val;
-- =

1.7.9.5


--===============8257461417484098356==--

