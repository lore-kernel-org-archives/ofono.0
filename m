Content-Type: multipart/mixed; boundary="===============1920757774049192957=="
MIME-Version: 1.0
From: Alexander Couzens <lynxis@fe80.eu>
Subject: [PATCH 1/3] qmi/discovery: remove useless code
Date: Thu, 07 Sep 2017 21:23:04 +0200
Message-ID: <20170907192306.18117-1-lynxis@fe80.eu>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1920757774049192957==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/qmimodem/qmi.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index c538cb978393..1af86aaccb08 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -1162,11 +1162,6 @@ static void discover_callback(uint16_t message, uint=
16_t length,
 =

 	service_list =3D ptr + *((uint8_t *) ptr) + 1;
 =

-	for (i =3D 0; i < service_list->count; i++) {
-		if (service_list->services[i].type =3D=3D QMI_SERVICE_CONTROL)
-			continue;
-	}
-
 done:
 	device->version_list =3D list;
 	device->version_count =3D count;
-- =

2.14.1


--===============1920757774049192957==--

