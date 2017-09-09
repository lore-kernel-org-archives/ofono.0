Content-Type: multipart/mixed; boundary="===============7993387130172697914=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH 1/1] udev: add serial_info struct to modem
Date: Sat, 09 Sep 2017 11:05:19 +0200
Message-ID: <20170909090519.20523-1-jonas@southpole.se>
In-Reply-To: <20170909085655.19564-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7993387130172697914==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
Hi Clayton,

Sorry, I messed up the earlier patch.  It should be like this, I think.

/Jonas

 plugins/udevng.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 5767259..a4b99aa 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -1355,7 +1355,7 @@ static void add_serial_device(struct udev_device *dev)
 	info->subsystem =3D g_strdup(subsystem);
 	info->dev =3D udev_device_ref(dev);
 =

-	modem->devices =3D g_slist_append(modem->devices, info);
+	modem->serial =3D info;
 }
 =

 static void add_device(const char *syspath, const char *devname,
-- =

2.9.3


--===============7993387130172697914==--

