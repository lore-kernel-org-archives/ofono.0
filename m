Content-Type: multipart/mixed; boundary="===============6287140687695968371=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [RFC hwdb v1 11/28] udevng (hso): remove impossible condition
Date: Thu, 30 Mar 2017 22:52:52 +0200
Message-ID: <20170330205309.25850-12-jonas@southpole.se>
In-Reply-To: <20170330205309.25850-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6287140687695968371==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The hso driver setup function tests for the devnode beginning with "hso"
in order to detect the network interface.  Since the devnode will always
begin with "/dev", this condition will never be fulfilled.

Given that the 'net' variable never gets set, we could just remove it.
However, leaving it there for now might be reminder to someone to figure
out how to set it in case it's actually needed.  That said, this test
has been in the code since 2011 and, presumably, nobody's noticied so
this modem might not be something that anybody actually uses anymore.
---
 plugins/udevng.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 5b858f2..f66a8b1 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -174,9 +174,6 @@ static gboolean setup_hso(struct modem_info *modem)
 			app =3D info->devnode;
 		else if (g_strcmp0(info->sysattr, "Modem") =3D=3D 0)
 			mdm =3D info->devnode;
-		else if (info->sysattr =3D=3D NULL &&
-				g_str_has_prefix(info->devnode, "hso") =3D=3D TRUE)
-			net =3D info->devnode;
 	}
 =

 	if (ctl =3D=3D NULL || app =3D=3D NULL)
-- =

2.9.3


--===============6287140687695968371==--

