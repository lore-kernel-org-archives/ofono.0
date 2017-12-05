Content-Type: multipart/mixed; boundary="===============5308847651154796845=="
MIME-Version: 1.0
From: Alexander Couzens <lynxis@fe80.eu>
Subject: [PATCH][v2 1/4] qmi/discovery: remove useless code
Date: Tue, 05 Dec 2017 18:52:34 +0100
Message-ID: <20171205175237.17399-1-lynxis@fe80.eu>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5308847651154796845==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/qmimodem/qmi.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index a0632ca54025..5b29b761686a 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -1161,13 +1161,6 @@ static void discover_callback(uint16_t message, uint=
16_t length,
 =

 	device->version_str =3D strndup(ptr + 1, *((uint8_t *) ptr));
 =

-	service_list =3D ptr + *((uint8_t *) ptr) + 1;
-
-	for (i =3D 0; i < service_list->count; i++) {
-		if (service_list->services[i].type =3D=3D QMI_SERVICE_CONTROL)
-			continue;
-	}
-
 done:
 	device->version_list =3D list;
 	device->version_count =3D count;
-- =

2.15.1


--===============5308847651154796845==--

