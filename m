Content-Type: multipart/mixed; boundary="===============1444030430510428957=="
MIME-Version: 1.0
From: Alexander Couzens <lynxis@fe80.eu>
Subject: [PATCH 2/3] qmi/discovery: include control service into service list
Date: Thu, 07 Sep 2017 21:23:05 +0200
Message-ID: <20170907192306.18117-2-lynxis@fe80.eu>
In-Reply-To: <20170907192306.18117-1-lynxis@fe80.eu>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1444030430510428957==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There is no need to exclude it. It helps debugging because
the service is now logged.
---
 drivers/qmimodem/qmi.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 1af86aaccb08..7ea22992f8f0 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -1136,15 +1136,12 @@ static void discover_callback(uint16_t message, uin=
t16_t length,
 		if (type =3D=3D QMI_SERVICE_CONTROL) {
 			device->control_major =3D major;
 			device->control_minor =3D minor;
-			continue;
 		}
 =

-		list[count].type =3D type;
-		list[count].major =3D major;
-		list[count].minor =3D minor;
-		list[count].name =3D name;
-
-		count++;
+		list[i].type =3D type;
+		list[i].major =3D major;
+		list[i].minor =3D minor;
+		list[i].name =3D name;
 =

 		if (name)
 			__debug_device(device, "found service [%s %d.%d]",
@@ -1154,6 +1151,8 @@ static void discover_callback(uint16_t message, uint1=
6_t length,
 							type, major, minor);
 	}
 =

+	count =3D service_list->count;
+
 	ptr =3D tlv_get(buffer, length, 0x10, &len);
 	if (!ptr)
 		goto done;
-- =

2.14.1


--===============1444030430510428957==--

