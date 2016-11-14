Content-Type: multipart/mixed; boundary="===============2021175591802430572=="
MIME-Version: 1.0
From: Dragos Tatulea <dragos@endocode.com>
Subject: [PATCH] driver: ublox: fix memory leak in release
Date: Mon, 14 Nov 2016 16:24:34 +0100
Message-ID: <1479137074-7587-1-git-send-email-dragos@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2021175591802430572==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/ubloxmodem/gprs-context.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ubloxmodem/gprs-context.c b/drivers/ubloxmodem/gprs-co=
ntext.c
index 7ef05b7..3069e88 100644
--- a/drivers/ubloxmodem/gprs-context.c
+++ b/drivers/ubloxmodem/gprs-context.c
@@ -442,6 +442,7 @@ static void ublox_gprs_context_remove(struct ofono_gprs=
_context *gc)
 	g_at_chat_unref(gcd->chat);
 =

 	memset(gcd, 0, sizeof(*gcd));
+	g_free(gcd);
 }
 =

 static struct ofono_gprs_context_driver driver =3D {
-- =

2.7.4


--===============2021175591802430572==--

