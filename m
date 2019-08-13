Content-Type: multipart/mixed; boundary="===============0783716102203355891=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCH 2/2] quectel: convert power event reasons to lower case
Date: Tue, 13 Aug 2019 20:08:53 +0200
Message-ID: <20190813180853.2049-2-martin@geanix.com>
In-Reply-To: <20190813180853.2049-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0783716102203355891==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/quectel.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/plugins/quectel.c b/plugins/quectel.c
index eef66ced..ccfc6c5f 100644
--- a/plugins/quectel.c
+++ b/plugins/quectel.c
@@ -365,27 +365,27 @@ static void voltage_handle(struct ofono_modem *modem,
 	case LOW_POWER_DOWN:
 		close =3D true;
 		name =3D "PowerDown";
-		reason =3D "VoltageLow";
+		reason =3D "voltagelow";
 		break;
 	case LOW_WARNING:
 		close =3D false;
 		name =3D "PowerWarning";
-		reason =3D "VoltageLow";
+		reason =3D "voltagelow";
 		break;
 	case NORMAL_POWER_DOWN:
 		close =3D true;
 		name =3D "PowerDown";
-		reason =3D "Normal";
+		reason =3D "normal";
 		break;
 	case HIGH_WARNING:
 		close =3D false;
 		name =3D "PowerWarning";
-		reason =3D "VoltageHigh";
+		reason =3D "voltagehigh";
 		break;
 	case HIGH_POWER_DOWN:
 		close =3D true;
 		name =3D "PowerDown";
-		reason =3D "VoltageHigh";
+		reason =3D "voltagehigh";
 		break;
 	default:
 		return;
-- =

2.22.0


--===============0783716102203355891==--

