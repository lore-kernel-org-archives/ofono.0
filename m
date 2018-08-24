Content-Type: multipart/mixed; boundary="===============4061966744554331099=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCH] udevng: fix removal of serial devices
Date: Fri, 24 Aug 2018 13:33:30 +0200
Message-ID: <20180824113330.9735-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4061966744554331099==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Since the merge of udev.c into udevng.c all cleanup function must handle
both usb devices and serial devices. Add this distinction to
check_remove(), so that is doesn't try to iterate the .serial member as
if it were a .devices list.
---
 plugins/udevng.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 4b565070..71a70f0b 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -1380,11 +1380,19 @@ static gboolean check_remove(gpointer key, gpointer=
 value, gpointer user_data)
 	const char *devpath =3D user_data;
 	GSList *list;
 =

-	for (list =3D modem->devices; list; list =3D list->next) {
-		struct device_info *info =3D list->data;
+	switch (modem->type) {
+	case MODEM_TYPE_USB:
+		for (list =3D modem->devices; list; list =3D list->next) {
+			struct device_info *info =3D list->data;
 =

-		if (g_strcmp0(info->devpath, devpath) =3D=3D 0)
+			if (g_strcmp0(info->devpath, devpath) =3D=3D 0)
+				return TRUE;
+		}
+		break;
+	case MODEM_TYPE_SERIAL:
+		if (g_strcmp0(modem->serial->devpath, devpath) =3D=3D 0)
 			return TRUE;
+		break;
 	}
 =

 	return FALSE;
-- =

2.18.0


--===============4061966744554331099==--

