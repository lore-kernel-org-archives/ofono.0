Content-Type: multipart/mixed; boundary="===============3154585013079155299=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: [PATCH 4/7] emulator: Change feature check to attend HFP 1.6
Date: Fri, 12 Apr 2013 17:41:02 -0300
Message-ID: <1365799265-19946-5-git-send-email-paulo.borges@openbossa.org>
In-Reply-To: <1365799265-19946-1-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3154585013079155299==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

HFP 1.6 adds a new feature called Codec Negotitation. For the HF Role,
this feature is stored in the eighty bit of the supported features
bitmap.

This way, we need to change the range of valid HF feature bitmaps to
2^8-1.
---
 src/emulator.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/emulator.c b/src/emulator.c
index 890ea20..80341a4 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -487,7 +487,7 @@ static void brsf_cb(GAtServer *server, GAtServerRequest=
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


--===============3154585013079155299==--

