Content-Type: multipart/mixed; boundary="===============2343781563428097611=="
MIME-Version: 1.0
From: Sergey Matyukevich <geomatsi@gmail.com>
Subject: [PATCH] gemalto: radio-settings: cleanup
Date: Fri, 23 Jul 2021 20:00:01 +0300
Message-ID: <20210723170001.12102-1-geomatsi@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2343781563428097611==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Enum ofono_radio_access_mode has been replaced by unsigned int.
This change allows to move handling of all the modes into
'switch' in the function gemalto_set_rat_mode.
---
 drivers/gemaltomodem/radio-settings.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/gemaltomodem/radio-settings.c b/drivers/gemaltomodem/r=
adio-settings.c
index 738a6908..50764f83 100644
--- a/drivers/gemaltomodem/radio-settings.c
+++ b/drivers/gemaltomodem/radio-settings.c
@@ -171,21 +171,18 @@ static void gemalto_set_rat_mode(struct ofono_radio_s=
ettings *rs,
 	case OFONO_RADIO_ACCESS_MODE_LTE:
 		val =3D 3;
 		break;
-	}
-
-	if (m =3D=3D (OFONO_RADIO_ACCESS_MODE_UMTS|OFONO_RADIO_ACCESS_MODE_GSM)) {
+	case OFONO_RADIO_ACCESS_MODE_UMTS|OFONO_RADIO_ACCESS_MODE_GSM:
 		val =3D 1;
 		p1 =3D 2;
-	}
-
-	if (m =3D=3D (OFONO_RADIO_ACCESS_MODE_LTE|OFONO_RADIO_ACCESS_MODE_UMTS)) {
+		break;
+	case OFONO_RADIO_ACCESS_MODE_LTE|OFONO_RADIO_ACCESS_MODE_UMTS:
 		val =3D 4;
 		p1 =3D 3;
-	}
-
-	if (m =3D=3D (OFONO_RADIO_ACCESS_MODE_LTE|OFONO_RADIO_ACCESS_MODE_GSM)) {
+		break;
+	case OFONO_RADIO_ACCESS_MODE_LTE|OFONO_RADIO_ACCESS_MODE_GSM:
 		val =3D 5;
 		p1 =3D 3;
+		break;
 	}
 =

 	if (val =3D=3D 6)
-- =

2.32.0

--===============2343781563428097611==--

