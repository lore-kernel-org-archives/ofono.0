Content-Type: multipart/mixed; boundary="===============6338884606348105529=="
MIME-Version: 1.0
From: Dragos Tatulea <dragos@endocode.com>
Subject: [PATCH 07/19] atmodem: ublox: EPS now supported by newer ublox
Date: Wed, 09 Mar 2016 16:44:48 +0100
Message-ID: <1457538300-7183-8-git-send-email-dragos@endocode.com>
In-Reply-To: <1457538300-7183-1-git-send-email-dragos@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6338884606348105529==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Based on UBX-13002752 R33
---
 drivers/atmodem/gprs.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/atmodem/gprs.c b/drivers/atmodem/gprs.c
index 5551316..0165253 100644
--- a/drivers/atmodem/gprs.c
+++ b/drivers/atmodem/gprs.c
@@ -303,10 +303,6 @@ static void ublox_ureg_notify(GAtResult *result, gpoin=
ter user_data)
 	case 5:
 		bearer =3D 4;
 		break;
-	case 7:
-		/* XXX: reserved - assume none. */
-		bearer =3D 0;
-		break;
 	case 8:
 		bearer =3D 1;
 		break;
-- =

2.5.0


--===============6338884606348105529==--

