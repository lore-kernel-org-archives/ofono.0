Content-Type: multipart/mixed; boundary="===============4575499086697976963=="
MIME-Version: 1.0
From: John Ernberg <john.ernberg@actia.se>
Subject: [PATCH] radio-settings: Fix typo in radio_band_umts_from_string
Date: Mon, 17 Jul 2017 09:20:36 +0000
Message-ID: <1500283227-5074-1-git-send-email-john.ernberg@actia.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4575499086697976963==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: John Ernberg <john.ernberg@actia.se>

---
 src/radio-settings.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/radio-settings.c b/src/radio-settings.c
index b988e3e..c551b04 100644
--- a/src/radio-settings.c
+++ b/src/radio-settings.c
@@ -167,7 +167,7 @@ static gboolean radio_band_umts_from_string(const char =
*str,
 					enum ofono_radio_band_umts *band)
 {
 	if (g_str_equal(str, "any")) {
-		*band =3D OFONO_RADIO_BAND_GSM_ANY;
+		*band =3D OFONO_RADIO_BAND_UMTS_ANY;
 		return TRUE;
 	} else if (g_str_equal(str, "850")) {
 		*band =3D OFONO_RADIO_BAND_UMTS_850;
-- =

2.7.4

--===============4575499086697976963==--

