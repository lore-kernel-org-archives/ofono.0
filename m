Content-Type: multipart/mixed; boundary="===============5454159386534348025=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [RFC hwdb v1 01/28] zte: remove unused qcdm property
Date: Thu, 30 Mar 2017 22:52:42 +0200
Message-ID: <20170330205309.25850-2-jonas@southpole.se>
In-Reply-To: <20170330205309.25850-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5454159386534348025==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/udevng.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index d198763..d9153b3 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -765,7 +765,7 @@ static gboolean setup_simcom(struct modem_info *modem)
 =

 static gboolean setup_zte(struct modem_info *modem)
 {
-	const char *aux =3D NULL, *mdm =3D NULL, *qcdm =3D NULL;
+	const char *aux =3D NULL, *mdm =3D NULL;
 	const char *modem_intf;
 	GSList *list;
 =

@@ -793,9 +793,7 @@ static gboolean setup_zte(struct modem_info *modem)
 			if (aux !=3D NULL)
 				break;
 		} else if (g_strcmp0(info->interface, "255/255/255") =3D=3D 0) {
-			if (g_strcmp0(info->number, "00") =3D=3D 0)
-				qcdm =3D info->devnode;
-			else if (g_strcmp0(info->number, "01") =3D=3D 0)
+			if (g_strcmp0(info->number, "01") =3D=3D 0)
 				aux =3D info->devnode;
 			else if (g_strcmp0(info->number, modem_intf) =3D=3D 0)
 				mdm =3D info->devnode;
-- =

2.9.3


--===============5454159386534348025==--

