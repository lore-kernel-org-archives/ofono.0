Content-Type: multipart/mixed; boundary="===============6442327225217554751=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH qmi 3/5] gobi: query presence of WDA service
Date: Sat, 25 Mar 2017 17:57:53 +0100
Message-ID: <20170325165755.28114-4-jonas@southpole.se>
In-Reply-To: <20170325165755.28114-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6442327225217554751==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/gobi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/plugins/gobi.c b/plugins/gobi.c
index 06f906d..df35f94 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -48,6 +48,7 @@
 =

 #include <drivers/qmimodem/qmi.h>
 #include <drivers/qmimodem/dms.h>
+#include <drivers/qmimodem/wda.h>
 #include <drivers/qmimodem/util.h>
 =

 #define GOBI_DMS	(1 << 0)
@@ -60,6 +61,7 @@
 #define GOBI_CAT	(1 << 7)
 #define GOBI_CAT_OLD	(1 << 8)
 #define GOBI_VOICE	(1 << 9)
+#define GOBI_WDA	(1 << 10)
 =

 struct gobi_data {
 	struct qmi_device *device;
@@ -275,6 +277,9 @@ static void discover_cb(uint8_t count, const struct qmi=
_version *list,
 		case QMI_SERVICE_WDS:
 			data->features |=3D GOBI_WDS;
 			break;
+		case QMI_SERVICE_WDA:
+			data->features |=3D GOBI_WDA;
+			break;
 		case QMI_SERVICE_PDS:
 			data->features |=3D GOBI_PDS;
 			break;
-- =

2.9.3


--===============6442327225217554751==--

