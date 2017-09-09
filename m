Content-Type: multipart/mixed; boundary="===============0246978308144177735=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH 1/1] udev: add serial_info struct to modem
Date: Sat, 09 Sep 2017 10:56:55 +0200
Message-ID: <20170909085655.19564-1-jonas@southpole.se>
In-Reply-To: <20170909030933.GA3@computer.craftyguy.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0246978308144177735==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
Hi Clayton,

Give this patch a try and see if things look better.

/Jonas


 plugins/udevng.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 5767259..317b6a9 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -1355,6 +1355,8 @@ static void add_serial_device(struct udev_device *dev)
 	info->subsystem =3D g_strdup(subsystem);
 	info->dev =3D udev_device_ref(dev);
 =

+	modem->serial =3D info;
+
 	modem->devices =3D g_slist_append(modem->devices, info);
 }
 =

-- =

2.9.3


--===============0246978308144177735==--

