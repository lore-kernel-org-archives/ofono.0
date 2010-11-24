Content-Type: multipart/mixed; boundary="===============8041426618599040939=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH] isi: Fix issue in call forwarding erase response
Date: Wed, 24 Nov 2010 02:10:54 -0800
Message-ID: <1290593454-22149-2-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1290593454-22149-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8041426618599040939==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/isimodem/call-forwarding.c |   20 ++++++++++++++------
 1 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/isimodem/call-forwarding.c b/drivers/isimodem/call-for=
warding.c
index 1448451..c364bdf 100644
--- a/drivers/isimodem/call-forwarding.c
+++ b/drivers/isimodem/call-forwarding.c
@@ -98,12 +98,20 @@ static gboolean decode_gsm_forwarding_info(const void *=
restrict data,
 			uint8_t _ton;
 			char *_number =3D NULL;
 =

-			if (!g_isi_sb_iter_get_byte(&iter, &_status, 3)
-				|| !g_isi_sb_iter_get_byte(&iter, &_ton, 4)
-				|| !g_isi_sb_iter_get_byte(&iter, &_norply, 5)
-				|| !g_isi_sb_iter_get_byte(&iter, &_numlen, 7)
-				|| !g_isi_sb_iter_get_alpha_tag(&iter, &_number,
-					_numlen * 2, 10))
+			if (status && !g_isi_sb_iter_get_byte(&iter, &_status, 3))
+				return FALSE;
+
+			if (ton && !g_isi_sb_iter_get_byte(&iter, &_ton, 4))
+				return FALSE;
+
+			if (norply && !g_isi_sb_iter_get_byte(&iter, &_norply, 5))
+				return FALSE;
+
+			if (number && !g_isi_sb_iter_get_byte(&iter, &_numlen, 7))
+				return FALSE;
+
+			if (number && !g_isi_sb_iter_get_alpha_tag(&iter,
+						&_number, _numlen * 2, 10))
 				return FALSE;
 =

 			if (status)
-- =

1.7.0.4


--===============8041426618599040939==--

