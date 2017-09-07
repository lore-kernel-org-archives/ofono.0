Content-Type: multipart/mixed; boundary="===============3984849618324388993=="
MIME-Version: 1.0
From: Alexander Couzens <lynxis@fe80.eu>
Subject: [PATCH] udevng/Sierra: use first cdc-wdm interface
Date: Thu, 07 Sep 2017 21:33:28 +0200
Message-ID: <20170907193328.23062-1-lynxis@fe80.eu>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3984849618324388993==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Using the voice firmware on a mc7304 the modem
stopped accepting qmi messages on the second
cdc-wdm interface.
---
 plugins/udevng.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index aa28bcb8911e..1e716a60334b 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -267,12 +267,28 @@ static gboolean setup_sierra(struct modem_info *modem)
 				app =3D info->devnode;
 			else if (g_strcmp0(info->number, "07") =3D=3D 0)
 				net =3D info->devnode;
-			else if (g_strcmp0(info->number, "0a") =3D=3D 0) {
-				if (g_strcmp0(info->subsystem, "net") =3D=3D 0)
+			else if (g_strcmp0(info->subsystem, "net") =3D=3D 0) {
+				/*
+				 * When using the voice firmware on a mc7304
+				 * the second cdc-wdm interface doesn't handle
+				 * qmi messages properly.
+				 * Some modems still have a working second
+				 * cdc-wdm interface, some are not. But always
+				 * the first interface works.
+				 */
+				if (g_strcmp0(info->number, "08") =3D=3D 0) {
 					net =3D info->devnode;
-				else if (g_strcmp0(info->subsystem,
-								"usbmisc") =3D=3D 0)
+				} else if (g_strcmp0(info->number, "0a") =3D=3D 0) {
+					if (net =3D=3D NULL)
+						net =3D info->devnode;
+				}
+			} else if (g_strcmp0(info->subsystem, "usbmisc") =3D=3D 0) {
+				if (g_strcmp0(info->number, "08") =3D=3D 0) {
 					qmi =3D info->devnode;
+				} else if (g_strcmp0(info->number, "0a") =3D=3D 0) {
+					if (qmi =3D=3D NULL)
+						qmi =3D info->devnode;
+				}
 			}
 		}
 	}
-- =

2.14.1


--===============3984849618324388993==--

