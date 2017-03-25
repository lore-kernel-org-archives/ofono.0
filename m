Content-Type: multipart/mixed; boundary="===============1326706963669618379=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH udev 05/15] udev: remove unused modem property
Date: Sat, 25 Mar 2017 17:57:55 +0100
Message-ID: <20170325165805.28166-6-jonas@southpole.se>
In-Reply-To: <20170325165805.28166-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1326706963669618379==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The property 'Registered' is not used anywhere.
---
 plugins/udev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/plugins/udev.c b/plugins/udev.c
index 7c090aa..dc07fc6 100644
--- a/plugins/udev.c
+++ b/plugins/udev.c
@@ -270,7 +270,6 @@ static void add_modem(struct udev_device *udev_device)
 			return;
 =

 		ofono_modem_set_string(modem, "Path", devpath);
-		ofono_modem_set_integer(modem, "Registered", 0);
 =

 		modem_list =3D g_slist_prepend(modem_list, modem);
 	}
-- =

2.9.3


--===============1326706963669618379==--

