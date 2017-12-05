Content-Type: multipart/mixed; boundary="===============7104116424086425188=="
MIME-Version: 1.0
From: Alexander Couzens <lynxis@fe80.eu>
Subject: [PATCH][v2 2/4] qmi: include the CTL in the debug output
Date: Tue, 05 Dec 2017 18:52:35 +0100
Message-ID: <20171205175237.17399-2-lynxis@fe80.eu>
In-Reply-To: <20171205175237.17399-1-lynxis@fe80.eu>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7104116424086425188==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The CTL version is important for certain calls. This is
a useful information for debugging.
---
 drivers/qmimodem/qmi.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 5b29b761686a..0269f7729be0 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -1134,6 +1134,13 @@ static void discover_callback(uint16_t message, uint=
16_t length,
 		uint8_t type =3D service_list->services[i].type;
 		const char *name =3D __service_type_to_string(type);
 =

+		if (name)
+			__debug_device(device, "found service [%s %d.%d]",
+				       name, major, minor);
+		else
+			__debug_device(device, "found service [%d %d.%d]",
+				       type, major, minor);
+
 		if (type =3D=3D QMI_SERVICE_CONTROL) {
 			device->control_major =3D major;
 			device->control_minor =3D minor;
@@ -1146,13 +1153,6 @@ static void discover_callback(uint16_t message, uint=
16_t length,
 		list[count].name =3D name;
 =

 		count++;
-
-		if (name)
-			__debug_device(device, "found service [%s %d.%d]",
-							name, major, minor);
-		else
-			__debug_device(device, "found service [%d %d.%d]",
-							type, major, minor);
 	}
 =

 	ptr =3D tlv_get(buffer, length, 0x10, &len);
-- =

2.15.1


--===============7104116424086425188==--

