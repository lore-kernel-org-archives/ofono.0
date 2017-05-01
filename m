Content-Type: multipart/mixed; boundary="===============6978224236631933958=="
MIME-Version: 1.0
From: Alexander Couzens <lynxis@fe80.eu>
Subject: [PATCH 1/7] udevng/gobi: improve debug output
Date: Mon, 01 May 2017 22:52:50 +0200
Message-ID: <20170501205256.4205-1-lynxis@fe80.eu>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6978224236631933958==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add info->sysattr and info->subsystem to the log message.
---
 plugins/udevng.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 5e74a7cc..47bc8910 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -204,8 +204,9 @@ static gboolean setup_gobi(struct modem_info *modem)
 	for (list =3D modem->devices; list; list =3D list->next) {
 		struct device_info *info =3D list->data;
 =

-		DBG("%s %s %s %s", info->devnode, info->interface,
-						info->number, info->label);
+		DBG("%s %s %s %s %s %s", info->devnode, info->interface,
+						info->number, info->label,
+						info->sysattr, info->subsystem);
 =

 		if (g_strcmp0(info->interface, "255/255/255") =3D=3D 0) {
 			if (info->number =3D=3D NULL)
-- =

2.12.2


--===============6978224236631933958==--

