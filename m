Content-Type: multipart/mixed; boundary="===============3192418497485806052=="
MIME-Version: 1.0
From: Sergey Matyukevich <geomatsi@gmail.com>
Subject: [PATCH v2 2/3] plugins: udevng: detect gemalto network interfaces
Date: Tue, 18 Aug 2020 23:43:46 +0300
Message-ID: <20200818204347.29516-3-geomatsi@gmail.com>
In-Reply-To: <20200818204347.29516-1-geomatsi@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3192418497485806052==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Some gemalto modems, including ELS81x, may provide more than one
USB ethernet interface. Detect and save both network interfaces
rather than only the last one.

Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>
---
 plugins/udevng.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 7e6a3ab7..839fabdb 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -1162,7 +1162,7 @@ static gboolean setup_ublox(struct modem_info *modem)
 static gboolean setup_gemalto(struct modem_info* modem)
 {
 	const char *app =3D NULL, *gps =3D NULL, *mdm =3D NULL,
-		*net =3D NULL, *qmi =3D NULL;
+		*net =3D NULL, *qmi =3D NULL, *net2 =3D NULL;
 =

 	GSList *list;
 =

@@ -1197,9 +1197,14 @@ static gboolean setup_gemalto(struct modem_info* mod=
em)
 			else if (g_strcmp0(info->number, "04") =3D=3D 0)
 				gps =3D info->devnode;
 		}
+
 		if (g_strcmp0(info->interface, "2/6/0") =3D=3D 0) {
-			if (g_strcmp0(info->subsystem, "net") =3D=3D 0)
-				net =3D info->devnode;
+			if (g_strcmp0(info->subsystem, "net") =3D=3D 0) {
+				if (g_strcmp0(info->number, "0a") =3D=3D 0)
+					net =3D info->devnode;
+				if (g_strcmp0(info->number, "0c") =3D=3D 0)
+					net2 =3D info->devnode;
+			}
 		}
 	}
 =

@@ -1216,6 +1221,9 @@ static gboolean setup_gemalto(struct modem_info* mode=
m)
 	ofono_modem_set_string(modem->modem, "Model", modem->model);
 	ofono_modem_set_string(modem->modem, "NetworkInterface", net);
 =

+	if (net2)
+		ofono_modem_set_string(modem->modem, "NetworkInterface2", net2);
+
 	return TRUE;
 }
 =

-- =

2.28.0

--===============3192418497485806052==--

