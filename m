Content-Type: multipart/mixed; boundary="===============3895018856627032819=="
MIME-Version: 1.0
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH] bluetooth: ignore error if driver returns -EALREADY
Date: Mon, 25 Jun 2012 11:54:35 +0300
Message-ID: <1340614475-32177-1-git-send-email-luiz.dentz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3895018856627032819==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 plugins/bluetooth.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
index dbf79eb..cb5fe24 100644
--- a/plugins/bluetooth.c
+++ b/plugins/bluetooth.c
@@ -275,7 +275,7 @@ static void bluetooth_probe(GSList *uuids, const char *=
path,
 			continue;
 =

 		err =3D driver->probe(path, device, adapter, alias);
-		if (err =3D=3D 0)
+		if (err =3D=3D 0 || err =3D=3D -EALREADY)
 			continue;
 =

 		ofono_error("%s probe: %s (%d)", driver->name, strerror(-err),
-- =

1.7.10.2


--===============3895018856627032819==--

